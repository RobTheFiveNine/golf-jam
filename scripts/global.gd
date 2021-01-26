extends Node

var level_count = 1
var root : Node

func _ready():
    root = get_tree().get_root()
    
func get_current_level() -> Level:
    return root.get_children()[root.get_child_count() - 1] as Level

func load_next_level():
    var current_level = get_current_level()
    if current_level.next_scene:
        get_tree().change_scene_to(current_level.next_scene)
        get_tree().paused = false
    else:
        print("Load end game stats")
        pass
