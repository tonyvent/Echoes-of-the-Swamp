
extends CharacterBody2D
class_name Frog

@export var move_speed: float = 140.0
@export var jump_force: float = 300.0
@export var gravity: float = 1000.0
@export var coyote_time: float = 0.1
@export var max_hp: int = 3

var hp: int
var _coyote: float = 0.0
var facing: int = 1

@onready var sprite_root: Node2D = $SpriteRoot
@onready var tongue_ray: RayCast2D = $TongueRay

func _ready() -> void:
    hp = max_hp
    if tongue_ray:
        tongue_ray.enabled = false

func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity.y += gravity * delta
        _coyote = maxf(_coyote - delta, -1.0)
    else:
        _coyote = coyote_time

    var dir := 0.0
    if Input.is_action_pressed("ui_left"):
        dir -= 1.0
    if Input.is_action_pressed("ui_right"):
        dir += 1.0
    velocity.x = dir * move_speed

    if dir != 0.0:
        facing = 1 if dir > 0.0 else -1
        if is_instance_valid(sprite_root):
            sprite_root.scale.x = float(facing)

    if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump")) and _coyote > 0.0:
        velocity.y = -jump_force
        _coyote = -1.0

    if Input.is_action_just_pressed("attack_stick"):
        _do_stick()
    if Input.is_action_just_pressed("attack_tongue"):
        _do_tongue()

    move_and_slide()

func _do_stick() -> void:
    if has_node("AnimationPlayer"):
        $AnimationPlayer.play("stick")

func _do_tongue() -> void:
    if not tongue_ray:
        return
    tongue_ray.target_position = Vector2(120.0 * float(facing), 0.0)
    tongue_ray.enabled = true
    tongue_ray.force_raycast_update()
    if tongue_ray.is_colliding():
        var hit := tongue_ray.get_collider()
        if hit and hit.has_method("on_tongue_hit"):
            hit.call("on_tongue_hit")
    tongue_ray.enabled = false

func take_damage(amount: int) -> void:
    hp -= amount
    if hp <= 0:
        _die()

func _die() -> void:
    get_tree().change_scene_to_file("res://scenes/Ending.tscn")
