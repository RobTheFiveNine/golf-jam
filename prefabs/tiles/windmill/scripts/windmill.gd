extends Spatial

onready var blades_animation : AnimationPlayer = $BladesAnimation

func _ready():
    blades_animation.play("Rotate")
