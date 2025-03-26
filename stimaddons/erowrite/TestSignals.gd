extends OptionButton


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TestSignals_item_selected(index: int) -> void:
	$Value1.text = ""
	$Value2.text = ""
	
	match index:
		0:
			pass
		1:
			$Value1.editable = true
			$Value1.placeholder_text = "completion_ratio"
			$Value2.editable = true
			$Value2.placeholder_text = "word_count"
		2:
			$Value1.editable = false
			$Value1.placeholder_text = "n/a"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		3:
			$Value1.editable = true
			$Value1.placeholder_text = "text"
			$Value2.editable = true
			$Value2.placeholder_text = "file_path"
		4:
			$Value1.editable = true
			$Value1.placeholder_text = "text"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		5:
			$Value1.editable = true
			$Value1.placeholder_text = "panel_state"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		6:
			$Value1.editable = true
			$Value1.placeholder_text = "visibility"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		7:
			$Value1.editable = true
			$Value1.placeholder_text = "fullscreen_state"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		8:
			$Value1.editable = true
			$Value1.placeholder_text = "width"
			$Value2.editable = true
			$Value2.placeholder_text = "height"
		9:
			$Value1.editable = true
			$Value1.placeholder_text = "new_goal"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		10:
			$Value1.editable = true
			$Value1.placeholder_text = "theme_info"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		11:
			$Value1.editable = true
			$Value1.placeholder_text = "state"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		12:
			$Value1.editable = true
			$Value1.placeholder_text = "new_bg_location"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		13:
			$Value1.editable = true
			$Value1.placeholder_text = "new_font"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		14:
			$Value1.editable = true
			$Value1.placeholder_text = "new_size"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		15:
			$Value1.editable = true
			$Value1.placeholder_text = "new_sound_location"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		16:
			$Value1.editable = true
			$Value1.placeholder_text = "new_volume"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		17:
			$Value1.editable = true
			$Value1.placeholder_text = "new_sound_location"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		18:
			$Value1.editable = true
			$Value1.placeholder_text = "new_volume"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		19:
			$Value1.editable = false
			$Value1.placeholder_text = "n/a"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		20:
			$Value1.editable = false
			$Value1.placeholder_text = "n/a"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"
		21:
			$Value1.editable = false
			$Value1.placeholder_text = "n/a"
			$Value2.editable = false
			$Value2.placeholder_text = "n/a"


func _on_ActivateSignal_pressed() -> void:
	var signal_name = $".".text
	var arg1 = $Value1.text
	var arg2 = $Value2.text
	
	if arg1 and !arg2:
		Events.emit_signal(signal_name, arg1)
	elif arg1 and arg2:
		Events.emit_signal(signal_name, arg1, arg2)
	elif !arg1 and !arg2:
		Events.emit_signal(signal_name)		
		
		
