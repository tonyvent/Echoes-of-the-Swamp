
extends Control

@onready var back: Button = %Back

func _ready() -> void:
    if back:
        back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))
