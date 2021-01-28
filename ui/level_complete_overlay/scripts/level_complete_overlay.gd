extends Control

onready var star_one : TextureRect = $CenterContainer/VBoxContainer/HBoxContainer/StarOne/Texture
onready var star_two : TextureRect = $CenterContainer/VBoxContainer/HBoxContainer/StarTwo/Texture
onready var star_three : TextureRect = $CenterContainer/VBoxContainer/HBoxContainer/StarThree/Texture
onready var input_label : Label = $CenterContainer/VBoxContainer/MarginContainer/InputLabel
onready var animation : AnimationPlayer = $AnimationPlayer
onready var in_audio : AudioStreamPlayer = $InAudio
onready var out_audio : AudioStreamPlayer = $OutAudio

var stars_earned : int
var input_enabled : bool = false

func _ready():
    modulate = Color("00ffffff")
    input_label.modulate = Color("00ffffff")
    star_one.rect_min_size = Vector2.ZERO
    star_two.rect_min_size = Vector2.ZERO
    star_three.rect_min_size = Vector2.ZERO

func animate_stars():
    if stars_earned == 0:
        animation.play("NoStars")
    elif stars_earned == 1:
        animation.play("OneStar")
    elif stars_earned == 2:
        animation.play("TwoStar")
    elif stars_earned == 3:
        animation.play("ThreeStar")
    
func show_overlay(stars):
    stars_earned = stars
    animation.play("FadeIn")
    in_audio.play()

func _on_animation_finished(anim_name):
    if anim_name == "FadeIn":
        animate_stars()
    elif anim_name != "FadeInInput":
        animation.play("FadeInInput")
    elif anim_name == "FadeInInput":
        input_enabled = true

func _input(event):
    if not input_enabled:
        return

    if event is InputEventKey:
        input_enabled = false
        out_audio.play()
        animation.play("CompleteLevel")

func load_next_level():
    Global.load_next_level()
