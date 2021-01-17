extends Node

onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready():
    animation_player.play("Start")

func _on_criteria_met(step_number):
    if step_number < 4:
        animation_player.play("CompleteStep%s" % step_number)
