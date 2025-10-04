
extends Node
class_name SaveSystem

const SAVE_PREFIX := "user://echoes_slot_"
const SAVE_EXT := ".save"

func _file_path(slot: int) -> String:
    return "%s%d%s" % [SAVE_PREFIX, slot, SAVE_EXT]

func save_progress(slot: int, max_depth: int) -> void:
    var data: Dictionary = { "max_depth": max_depth }
    var f := FileAccess.open(_file_path(slot), FileAccess.WRITE)
    if f:
        f.store_string(JSON.stringify(data))
        f.close()

func load_progress(slot: int) -> int:
    var path := _file_path(slot)
    if not FileAccess.file_exists(path):
        return 0
    var f := FileAccess.open(path, FileAccess.READ)
    if not f:
        return 0
    var txt: String = f.get_as_text()
    f.close()
    var parsed = JSON.parse_string(txt)
    if typeof(parsed) == TYPE_DICTIONARY and parsed.has("max_depth"):
        return int(parsed.max_depth)
    return 0

func maybe_update_progress(slot: int, depth: int) -> void:
    var best: int = load_progress(slot)
    if depth > best:
        save_progress(slot, depth)
