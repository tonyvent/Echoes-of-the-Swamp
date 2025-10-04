
extends Node2D
class_name LevelGenerator

@export var tilemap_path: NodePath = NodePath("TileMap")
@export var enemy_scene: PackedScene
@export var platform_scene: PackedScene
@export var boss_scene: PackedScene
@export var chunk_width: int = 80
@export var ground_y_tiles: int = 4
@export var tile_source_id: int = 0
@export var tile_atlas: Vector2i = Vector2i(0, 0)

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
var _tm: TileMap
var current_depth: int = 0
var boss_alive: bool = false

func configure(seed: int, depth: int) -> void:
    _rng.seed = seed
    current_depth = depth

func _ready() -> void:
    _tm = get_node_or_null(tilemap_path)
    _build_chunk()

func _build_chunk() -> void:
    if _tm:
        _tm.clear()
        for x in range(-chunk_width/2, chunk_width/2):
            _tm.set_cell(0, Vector2i(int(x), ground_y_tiles), tile_source_id, tile_atlas)
    if platform_scene:
        for i in range(3 + min(6, current_depth)):
            var p: Node2D = platform_scene.instantiate()
            p.position = Vector2(_rng.randi_range(-chunk_width*8, chunk_width*8), _rng.randi_range(-64, 32))
            add_child(p)
    if enemy_scene:
        for i in range(4 + min(6, current_depth)):
            var e: Node2D = enemy_scene.instantiate()
            e.position = Vector2(_rng.randi_range(-chunk_width*8, chunk_width*8), ground_y_tiles*16 - 16)
            add_child(e)
    if current_depth % 5 == 0 and boss_scene:
        var b: Node2D = boss_scene.instantiate()
        b.position = Vector2(0, ground_y_tiles*16 - 16)
        add_child(b)
        boss_alive = true

func on_boss_defeated() -> void:
    boss_alive = false
    GameState.advance_depth()
    get_tree().reload_current_scene()
