extends Node

export(String) var addon_name = "EroWrite"
export(String) var addon_author = "thebungler"
export(String) var addon_version = "0.1"
export(String) var in_addon_bar = true


# Called when the node enters the scene tree for the first time.
# warning-ignore-all:unused_signal
# warning-ignore-all:return_value_discarded
func _ready() -> void:
	Events.connect("progress_milestone_reached", get_parent(), "_on_progress_milestone_reached")
	"""
	Events.connect("write_body_cleared", get_parent(), "_on_write_body_cleared")
	Events.connect("text_exported", get_parent(), "_on_text_exported")
	Events.connect("text_copied", get_parent(), "_on_text_copied")
	Events.connect("panel_state_changed", get_parent(), "_on_panel_state_changed")
	Events.connect("progress_bar_visibility_changed", get_parent(), "_on_progress_bar_visibility_changed")
	Events.connect("fullscreen_state_changed", get_parent(), "_on_fullscreen_state_changed")
	Events.connect("viewport_window_changed", get_parent(), "_on_viewport_window_changed")
	Events.connect("word_count_goal_changed", get_parent(), "_on_word_count_goal_changed")
	Events.connect("theme_changed", get_parent(), "_on_theme_changed")
	Events.connect("background_state_changed", get_parent(), "_on_background_state_changed")
	Events.connect("background_changed", get_parent(), "_on_background_changed")
	Events.connect("font_changed", get_parent(), "_on_font_changed")
	Events.connect("font_size_changed", get_parent(), "_on_font_size_changed")
	Events.connect("typing_sound_changed", get_parent(), "_on_typing_sound_changed")
	Events.connect("typing_volume_changed", get_parent(), "_on_typing_volume_changed")
	Events.connect("soundscape_sound_changed", get_parent(), "_on_soundscape_sound_changed")
	Events.connect("soundscape_volume_changed", get_parent(), "_on_soundscape_volume_changed")
	"""
	Events.connect("typing_started", get_parent(), "_on_typing_started")
	Events.connect("typing_ended", get_parent(), "_on_typing_ended")
	Events.connect("typing_idle", get_parent(), "_on_typing_idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
