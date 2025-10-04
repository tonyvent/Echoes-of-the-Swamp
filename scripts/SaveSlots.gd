
extends Control

@onready var slot1: Button = %Slot1
@onready var slot2: Button = %Slot2
@onready var slot3: Button = %Slot3
@onready var back: Button = %Back
@onready var info: Label = %Info

func _ready() -> void:
    _refresh()
    if slot1: slot1.pressed.connect(func(): _choose(1))
    if slot2: slot2.pressed.connect(func(): _choose(2))
    if slot3: slot3.pressed.connect(func(): _choose(3))
    if back: back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))

func _refresh() -> void:
    if slot1: slot1.text = "Slot 1 — Best %d" % SaveSystem.load_progress(1)
    if slot2: slot2.text = "Slot 2 — Best %d" % SaveSystem.load_progress(2)
    if slot3: slot3.text = "Slot 3 — Best %d" % SaveSystem.load_progress(3)
    if info: info.text = "Current slot: %d" % GameState.current_slot

func _choose(i: int) -> void:
    GameState.current_slot = i
    _refresh()
