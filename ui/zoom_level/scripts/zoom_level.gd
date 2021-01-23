extends Control

signal level_changed(zoom_level)

onready var level_2 : TextureRect = $Level2
onready var level_3 : TextureRect = $Level3
onready var tween : Tween = $Tween

var zoom_level : int = 1
var icons : Array

func _process(delta):
    if Input.is_action_just_pressed("cycle_zoom"):
        if zoom_level == 3:
            zoom_level = 1
        else:
            zoom_level += 1
            
        if zoom_level > 1:
            highlight_icon()
        else:
            fade_out_icons()
            
        emit_signal("level_changed", zoom_level)

func highlight_icon():
    var node : TextureRect = level_2

    if zoom_level == 3:
        node = level_3

    tween.interpolate_property(
        node,
        "modulate",
        null,
        Color("ffffffff"),
        0.2,
        Tween.TRANS_SINE,
        Tween.EASE_IN
    )
    
    tween.interpolate_property(
        node,
        "rect_rotation",
        null,
        12,
        0.1,
        Tween.TRANS_SINE,
        Tween.EASE_IN
    )
    
    tween.interpolate_property(
        node,
        "rect_rotation",
        null,
        -12,
        0.1,
        Tween.TRANS_SINE,
        Tween.EASE_IN,
        0.1
    )
    
    tween.interpolate_property(
        node,
        "rect_rotation",
        null,
        0,
        0.1,
        Tween.TRANS_SINE,
        Tween.EASE_IN,
        0.2
    )
    
    tween.start()

func fade_out_icons():
    tween.interpolate_property(
        level_2,
        "modulate",
        null,
        Color("80ffffff"),
        0.2,
        Tween.TRANS_SINE,
        Tween.EASE_IN
    )

    tween.interpolate_property(
        level_3,
        "modulate",
        null,
        Color("80ffffff"),
        0.2,
        Tween.TRANS_SINE,
        Tween.EASE_IN
    )

    tween.start()
