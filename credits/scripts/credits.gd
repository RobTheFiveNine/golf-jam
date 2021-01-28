extends Spatial

onready var stars_label : Label = $CenterContainer/VBoxContainer/StarsLabel
onready var animation : AnimationPlayer = $AnimationPlayer

func _ready():
    $TransitionOverlay.color = Color(0, 0, 0, 256)
    get_tree().paused = false
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    stars_label.text = "%s/%s stars collected" % [
        Global.total_stars,
        Global.level_count * 3
    ]
    
    animation.play_backwards("FadeOut")

func _on_MainMenuButton_pressed():
    animation.play("FadeOut")
    yield(animation, "animation_finished")
    get_tree().change_scene("res://title/title.tscn")
