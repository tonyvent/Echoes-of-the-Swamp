
extends Node2D

@onready var label: Label = $CanvasLayer/Label

func _ready() -> void:
    if label:
        label.text = "WASD/Arrows: Move  |  Space/Enter: Jump\nLeft Click: Stick  |  Right Click: Tongue\nPress Enter to start the run"
    GameState.new_run()

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("start_game"):
        get_tree().change_scene_to_file("res://scenes/Game.tscn")
