extends Node

class_name Level

export (int) var level_number = 0
export (int) var one_star_shots = 0
export (int) var two_star_shots = 0
export (int) var three_star_shots = 0
export (PackedScene) var next_scene

onready var camera_mode_label = $CanvasLayer/CameraModeLabel
onready var club = $Club
onready var animation_player = $AnimationPlayer

var shots_taken : int = 0

func _ready():
    $TransitionOverlay.modulate = Color("ffffffff")
    $StarRequirements.set_requirements(
        one_star_shots,
        two_star_shots,
        three_star_shots
    )
    
    $OutOfBounds.visible = false
    animation_player.play("FadeIn")

func _on_Player_input_mode_changed(mode):
    club._on_input_mode_changed(mode)
    
func get_star_rating():
    var stars = 0
    
    if shots_taken <= one_star_shots:
        stars = 1
    
    if shots_taken <= two_star_shots:
        stars = 2
        
    if shots_taken <= three_star_shots:
        stars = 3
        
    return stars

func _on_level_finished():
    get_tree().paused = true
    $LevelCompleteOverlay.show_overlay(get_star_rating())

func _on_ball_entered_hole():
    club._on_ball_entered_hole()
    
func _on_ball_exited_hole():
    club._on_ball_exited_hole()

func _on_Club_ball_hit():
    shots_taken += 1
