extends Control

onready var tween : Tween = $Tween
onready var s1_container : Control = $VBoxContainer/OneStarContainer
onready var s2_container : Control = $VBoxContainer/TwoStarContainer
onready var s3_container : Control = $VBoxContainer/ThreeStarContainer
onready var s1_label : Label = $MarginContainer/VBoxContainer2/OneStarLabel
onready var s2_label : Label = $MarginContainer/VBoxContainer2/TwoStarLabel
onready var s3_label : Label = $MarginContainer/VBoxContainer2/ThreeStarLabel

var requirements : Array
var shots_taken : int
var failed : Array

func _ready():
    failed = [false, false, false]

func set_star_value(star_count, requirement):
    var node : Label = s1_label
    
    if star_count == 2:
        node = s2_label
    elif star_count == 3:
        node = s3_label

    if requirement > 1:
        node.text = "%s shots" % requirement
    else:
        node.text = "%s shot" % requirement

func set_requirements(s1, s2, s3):
    requirements = [s1, s2, s3]

    set_star_value(1, s1)
    set_star_value(2, s2)
    set_star_value(3, s3)
    
func fade_requirement(index):
    var label = s1_label
    var container = s1_container
    
    if index == 2:
        label = s2_label
        container = s2_container
    elif index == 3:
        label = s3_label
        container = s3_container

    tween.interpolate_property(
        label,
        "modulate",
        null,
        Color("80ffffff"),
        0.2,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN
    )
    
    tween.interpolate_property(
        container,
        "modulate",
        null,
        Color("80ffffff"),
        0.2,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN
    )

    tween.start()
    
func _on_club_reset():
    if shots_taken >= requirements[0] and not failed[0]:
        failed[0] = true
        fade_requirement(1)
    
    if shots_taken >= requirements[1] and not failed[1]:
        failed[1] = true
        fade_requirement(2)
        
    if shots_taken >= requirements[2] and not failed[2]:
        failed[2] = true
        fade_requirement(3)    

func _on_shot_taken(shots):
    shots_taken = shots

