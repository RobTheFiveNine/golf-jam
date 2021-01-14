extends Node

onready var camera_mode_label = $CanvasLayer/CameraModeLabel

func _on_Player_input_mode_changed(mode):
    if mode == Player.INPUT_MODE_AIM:
        camera_mode_label.text = "Camera: Aim"
    else:
        camera_mode_label.text = "Camera: Free View"

func _on_level_finished():
    $AnimationPlayer.play("Complete")

func _on_ball_entered_hole():
    $Club._on_ball_entered_hole()
    
func _on_ball_exited_hole():
    $Club._on_ball_exited_hole()
