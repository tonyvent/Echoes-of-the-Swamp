
extends Node2D

@onready var frog: Node2D = $Frog
@onready var gen: Node = $LevelGenerator
@onready var cam: Camera2D = $Camera2D

func _ready() -> void:
    if gen and gen.has_method("configure"):
        gen.call("configure", GameState.run_seed, GameState.depth)
    if frog:
        frog.position = Vector2(0, -40)

func _process(_d: float) -> void:
    if cam and frog:
        cam.position = frog.position
