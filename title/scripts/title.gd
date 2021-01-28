extends Spatial

onready var animation : AnimationPlayer = $AnimationPlayer

func _ready():
    get_tree().paused = false
    Global.total_stars = 0
    $TransitionOverlay.color = Color(0, 0, 0, 256)
    animation.play_backwards("FadeOut")

func _on_StartButton_pressed():
    animation.play("FadeOut")
    yield(animation, "animation_finished")
    get_tree().change_scene("res://levels/level_1/level_1.tscn")
