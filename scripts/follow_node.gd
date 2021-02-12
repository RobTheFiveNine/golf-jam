extends Spatial

class_name FollowNode

export (NodePath) var target_path

onready var target_node = get_node(target_path)
onready var start_offset = self.transform.origin - target_node.transform.origin

func _process(delta):
    self.transform.origin = target_node.transform.origin + start_offset
