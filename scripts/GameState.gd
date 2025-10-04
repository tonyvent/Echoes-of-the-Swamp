
extends Node
class_name GameState

var current_slot: int = 1
var max_depth_by_slot: Dictionary = {}
var depth: int = 0
var run_seed: int = 0
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
    rng.randomize()

func new_run() -> void:
    depth = 0
    var now_i: int = int(Time.get_unix_time_from_system())
    if run_seed == 0:
        run_seed = now_i % 2147483647
    rng.seed = run_seed

func advance_depth() -> void:
    depth += 1

func set_seed(seed_value: int) -> void:
    run_seed = seed_value
    rng.seed = seed_value
