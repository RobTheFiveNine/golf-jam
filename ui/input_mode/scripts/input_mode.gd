extends Control

onready var tween : Tween = $Tween
onready var aim : TextureRect = $AimIcon
onready var free_view : TextureRect = $FreeViewIcon

func _ready():
    free_view.rect_scale = Vector2(1, 1)
    aim.rect_scale = Vector2(0, 0)

func _on_Player_input_mode_changed(mode):
    var new = aim
    var old = free_view

    if mode == Player.INPUT_MODE_FREE_VIEW:
        new = free_view
        old = aim
        
    tween.stop_all()
        
    tween.interpolate_property(
        old,
        "rect_scale",
        null,
        Vector2(1.2, 1.2),
        0.1,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN
    )
    
    tween.interpolate_property(
        old,
        "rect_scale",
        null,
        Vector2.ZERO,
        0.2,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN,
        0.1
    )
    
    tween.interpolate_property(
        new,
        "rect_scale",
        null,
        Vector2(1, 1),
        0.2,
        Tween.TRANS_LINEAR,
        Tween.EASE_IN,
        0.3
    )
    
    tween.start()
