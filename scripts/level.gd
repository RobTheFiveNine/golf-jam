extends Node

export (int) var level_number = 0
export (int) var one_star_shots = 0
export (int) var two_star_shots = 0
export (int) var three_star_shots = 0

onready var camera_mode_label = $CanvasLayer/CameraModeLabel
onready var club = $Club
onready var animation_player = $AnimationPlayer

func _ready():
    $StarRequirements.set_requirements(
        one_star_shots,
        two_star_shots,
        three_star_shots
    )

func _on_Player_input_mode_changed(mode):
    club._on_input_mode_changed(mode)

    if mode == Player.INPUT_MODE_AIM:
        camera_mode_label.text = "Camera: Aim"
    else:
        camera_mode_label.text = "Camera: Free View"

func _on_level_finished():
    print("finished level ", level_number)
    animation_player.play("Complete")

func _on_ball_entered_hole():
    club._on_ball_entered_hole()
    
func _on_ball_exited_hole():
    club._on_ball_exited_hole()
