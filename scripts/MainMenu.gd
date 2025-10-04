
extends Control

@onready var start_btn: Button = %Start
@onready var tutorial_btn: Button = %Tutorial
@onready var settings_btn: Button = %Settings
@onready var exit_btn: Button = %Exit
@onready var slot_btn: Button = %Slots
@onready var best_label: Label = %BestDepth

func _ready() -> void:
    if start_btn: start_btn.pressed.connect(_start_game)
    if tutorial_btn: tutorial_btn.pressed.connect(_tutorial)
    if settings_btn: settings_btn.pressed.connect(_settings)
    if slot_btn: slot_btn.pressed.connect(_slots)
    if exit_btn: exit_btn.pressed.connect(get_tree().quit)
    _refresh_best()

func _refresh_best() -> void:
    var best: int = SaveSystem.load_progress(GameState.current_slot)
    if best_label:
        best_label.text = "Slot %d — Best Depth: %d" % [GameState.current_slot, best]

func _start_game() -> void:
    GameState.new_run()
    get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")

func _tutorial() -> void:
    get_tree().change_scene_to_file("res://scenes/Tutorial.tscn")

func _settings() -> void:
    get_tree().change_scene_to_file("res://scenes/Settings.tscn")

func _slots() -> void:
    get_tree().change_scene_to_file("res://scenes/SaveSlots.tscn")
