
extends CharacterBody2D
class_name Boss

@export var hp: int = 30
@export var speed: float = 50.0
var _dir: int = 1

func _physics_process(_d: float) -> void:
    velocity.x = float(_dir) * speed
    move_and_slide()
    if is_on_wall():
        _dir *= -1

func take_damage(n: int) -> void:
    hp -= n
    if hp <= 0:
        if get_parent() and get_parent().has_method("on_boss_defeated"):
            get_parent().call("on_boss_defeated")
        queue_free()

func on_tongue_hit() -> void:
    take_damage(5)
