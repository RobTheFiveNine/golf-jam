extends Spatial

onready var animation_tree = $AnimationTree

func _ready():
    animation_tree.active = true
    var state_machine = animation_tree.get("parameters/playback")
    state_machine.start("hill")
