
extends CharacterBody2D
class_name EnemyBug

@export var speed: float = 60.0
@export var touch_damage: int = 1
var _dir: int = 1

func _physics_process(_d: float) -> void:
    velocity.x = float(_dir) * speed
    move_and_slide()
    if is_on_wall():
        _dir *= -1

func on_tongue_hit() -> void:
    queue_free()
