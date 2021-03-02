extends Spatial

onready var animation : AnimationPlayer = $AnimationPlayer
onready var exit_button : Button = $CenterContainer2/VBoxContainer/ExitButton

func _ready():
    get_tree().paused = false
    Global.total_stars = 0
    $TransitionOverlay.color = Color(0, 0, 0, 256)
    animation.play_backwards("FadeOut")
    
    if OS.get_name() == "HTML5":
        exit_button.get_parent().remove_child(exit_button)
        exit_button.free()

func _on_StartButton_pressed():
    animation.play("FadeOut")
    yield(animation, "animation_finished")
    get_tree().change_scene("res://levels/level_01/level_1.tscn")

func _on_ExitButton_pressed():
    get_tree().quit()
