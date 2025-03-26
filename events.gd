extends Node

# General events
# warning-ignore-all:unused_signal
# warning-ignore-all:return_value_discarded
signal progress_milestone_reached(completion_ratio, word_count)
signal write_body_cleared
signal text_exported(text, file_path)
signal text_copied(text)
signal panel_state_changed(panel_state)
signal progress_bar_visibility_changed(visibility)
signal fullscreen_state_changed(fullscreen_state)
signal viewport_window_changed(width, height)

# Options changes
signal word_count_goal_changed(new_goal)
signal theme_changed(theme_info)
signal background_state_changed(state)
signal background_changed(new_bg_location)
signal font_changed(new_font)
signal font_size_changed(new_size)
signal typing_sound_changed(new_sound_location)
signal typing_volume_changed(new_volume)
signal soundscape_sound_changed(new_sound_location)
signal soundscape_volume_changed(new_volume)

# Typing states
signal typing_started
signal typing_ended
signal typing_idle

var debug_mode := false

func _ready() -> void:
	connect("progress_milestone_reached", self, "_on_progress_milestone_reached")
	connect("write_body_cleared", self, "_on_write_body_cleared")
	connect("text_exported", self, "_on_text_exported")
	connect("text_copied", self, "_on_text_copied")
	connect("panel_state_changed", self, "_on_panel_state_changed")
	connect("progress_bar_visibility_changed", self, "_on_progress_bar_visibility_changed")
	connect("fullscreen_state_changed", self, "_on_fullscreen_state_changed")
	
	connect("word_count_goal_changed", self, "_on_word_count_goal_changed")
	connect("theme_changed", self, "_on_theme_changed")
	connect("background_state_changed", self, "_on_background_state_changed")
	connect("background_changed", self, "_on_background_changed")
	connect("font_changed", self, "_on_font_changed")
	connect("font_size_changed", self, "_on_font_size_changed")
	connect("typing_sound_changed", self, "_on_typing_sound_changed")
	connect("typing_volume_changed", self, "_on_typing_volume_changed")
	connect("soundscape_sound_changed", self, "_on_soundscape_sound_changed")
	connect("soundscape_volume_changed", self, "_on_soundscape_volume_changed")
	
	connect("typing_started", self, "_on_typing_started")
	connect("typing_ended", self, "_on_typing_ended")
	connect("typing_idle", self, "_on_typing_idle")
	

# Addon signal debugging

# General events
func _on_progress_milestone_reached(completion_ratio, word_count):
	if debug_mode:
		print("Completion ratio: " + completion_ratio as String + " | Word count: " + word_count as String)		

func _on_write_body_cleared():
	if debug_mode:
		print("Write body cleared")
		
func _on_text_exported(text, file_path):
	if debug_mode:
		print("Text exported \"" + text.left(24) + "...\" to " + file_path)

func _on_text_copied(text):
	if debug_mode:
		print("Text copied \"" + text.left(24) + "...\"")

func _on_panel_state_changed(panel_state):
	if debug_mode:
		print("Panel state changed: " + panel_state)
	
func _on_progress_bar_visibility_changed(visibility):
	if debug_mode:
		print("Progress bar visibility changed: " + visibility)
		
func _on_fullscreen_state_changed(fullscreen_state):
	if debug_mode:
		print("Fullscreen state changed: " + fullscreen_state)

# Options changes
func _on_word_count_goal_changed(new_goal):
	if debug_mode:
		print("New word count goal: " + new_goal as String)
		
func _on_theme_changed(theme_info):
	if debug_mode:
		print("Theme changed: " + theme_info as String)

func _on_background_state_changed(background_state):
	if debug_mode:
		print("Background state: " + background_state)

func _on_background_changed(new_bg_location):
	if debug_mode:
		print("Background changed: " + new_bg_location)

func _on_font_changed(new_font_location):
	if debug_mode:
		print("Font changed: " + new_font_location)
		
func _on_font_size_changed(new_size):
	if debug_mode:
		print("Font size changed: " + new_size as String)
		
func _on_typing_sound_changed(new_sound):
	if debug_mode:
		print("Typing sound changed: " + new_sound as String)

func _on_typing_volume_changed(new_volume):
	if debug_mode:
		print("Typing volume changed: " + new_volume as String)
		
func _on_soundscape_sound_changed(new_sound):
	if debug_mode:
		print("Soundscape sound changed: " + new_sound as String)

func _on_soundscape_volume_changed(new_volume):
	if debug_mode:
		print("Soundscape volume changed: " + new_volume as String)
		
# Typing states
func _on_typing_started():
	if debug_mode:
		print("Typing started...")

func _on_typing_ended():
	if debug_mode:
		print("Typing ended...")

func _on_typing_idle():
#	if debug_mode:
#		print("Typing idle...")	
	pass

