
extends Control

@onready var again: Button = %Again
@onready var to_menu: Button = %Menu
@onready var depth_label: Label = %Depth

func _ready() -> void:
    if depth_label:
        depth_label.text = "Depth Reached: %d" % GameState.depth
    SaveSystem.maybe_update_progress(GameState.current_slot, GameState.depth)
    if again: again.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/Tutorial.tscn"))
    if to_menu: to_menu.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))
