extends Spatial

onready var animation : AnimationPlayer = $AnimationPlayer

func _on_StartButton_pressed():
    animation.play("FadeOut")
    yield(animation, "animation_finished")
    get_tree().change_scene("res://levels/level_1/level_1.tscn")
