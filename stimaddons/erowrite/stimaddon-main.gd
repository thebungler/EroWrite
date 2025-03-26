extends Node

const ButtplugDevice = preload("res://stimaddons/erowrite/lib/ButtplugDevice.gd")
onready var client = self.get_node("ButtUI/Client")
onready var audioPlayer = self.get_node("AudioStreamPlayer")
onready var vibeTimer = self.get_node("VibeTimer")
#var babySound = preload("res://stimaddons/erowrite/mpb.mp3")
#var meowSound = preload("res://stimaddons/erowrite/mpm.mp3")
var completionActive = 0
var milestoneActive = 0
var activelyTyping = 0
var currentVibrationStrength = 0
var timerRunning = 0
var sineTime : float

#please note this also gives negative numbers, as sine waves are wont to do
func get_sine(freq):
	return sin(sineTime*freq) * 1

#ez function for vibrating. power is float from 0 to 1, sine is true or false for if we apply sine effect.
func vibrate(power):
	if self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/Wave/CheckBox").pressed == true:
		power = power * abs(get_sine(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/SineFreq/HSlider").value))
	client.get_children()[0].do_vibrate(power,-1)
	currentVibrationStrength=power

func vibeWait(msec, reset):
	#async function used for timed vibrations. waits until msec passes before any vibration changes may take place.
	#then resets vibration to a minimal level if reset is true.
	timerRunning = 1
	vibeTimer.set_wait_time(msec/1000) # Set Timer's delay
	vibeTimer.start() # Start the Timer counting down
	yield(vibeTimer, "timeout") # Wait for the timer to wind down
	if reset == true:
		vibrate(0.1)
	timerRunning = 0
	return
# this loops regularly. we handle all vibrations from here. other functions just set options to be used here
func _process(delta):
	#keep our sine wave going
	sineTime += delta
	#don't bother doing anything for vibration if there are no devices
	if client.get_child_count() == 0:
		$WindowDialog/VBoxContainer/TypingStatus.text = ("No devices detected")
		return
	#don't bother doing anything for vibration if we are doing a timed vibration
	if timerRunning == 1:
		return
	#first check for word goal completion
	if completionActive == 1:
		$WindowDialog/VBoxContainer/TypingStatus.text = ("Doing completion vibration")
		vibrate(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/Completion/Strength/HSlider").value)
		vibeWait(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/Completion/Length/HSlider").value,true)
		completionActive = 0
		return
	#then if we've hit any milestones
	if milestoneActive == 1:
		$WindowDialog/VBoxContainer/TypingStatus.text = ("Doing milestone vibration")
		vibrate(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/Milestone/Strength/HSlider").value)
		vibeWait(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/Milestone/Length/HSlider").value,true)
		milestoneActive = 0
		return
	#then handle regular vibration, both increase and decay
	if activelyTyping == 1:
		vibrate(clamp((currentVibrationStrength*(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/ChangeStrength/HSlider").value/10)),0.1,self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/MaxVibe/HSlider").value))
		$WindowDialog/VBoxContainer/TypingStatus.text = ("Increasing/maintaining typing vibration to "+str(currentVibrationStrength))
		vibeWait(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/UpSpeed/HSlider").value,false)
		return
	else:
		currentVibrationStrength = currentVibrationStrength/(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/ChangeStrength/HSlider").value/10)
		if currentVibrationStrength < 0.03:
			currentVibrationStrength = 0
		vibrate(clamp(currentVibrationStrength, 0, self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/MaxVibe/HSlider").value))
		$WindowDialog/VBoxContainer/TypingStatus.text = ("Decreasing typing vibration to "+str(currentVibrationStrength))
		vibeWait(self.get_node("ButtUI/HBoxContainer/View/PanelContainer/Settings/VBoxContainer/General/DownSpeed/HSlider").value,false)
		return
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($AddonConfig.addon_name + " main scene added as child")
	#lazy way of syncing visibility lol
	$ButtUI.visible = $WindowDialog.visible

# App icon pressed
func _on_AddonBarIcon_pressed() -> void:
	$WindowDialog.visible = !$WindowDialog.visible
	$ButtUI.visible = !$ButtUI.visible

# Typing states
func _on_typing_started():
	#$WindowDialog/VBoxContainer/TypingStatus.text = ("Typing started...")
	activelyTyping = 1
	
func _on_typing_ended():
	#$WindowDialog/VBoxContainer/TypingStatus.text = ("Typing ended...")
	activelyTyping = 0
	
# General events
func _on_progress_milestone_reached(completion_ratio, word_count):
	$WindowDialog/VBoxContainer/ProgressStatus.text = "Completion ratio: " + completion_ratio as String + " | Word count: " + word_count as String	
	if float(completion_ratio) < 0.99:
		milestoneActive = 1
	else:
		completionActive = 1


func _on_typing_idle():
	$WindowDialog/VBoxContainer/TypingStatus.text = ("Typing idle...")	

