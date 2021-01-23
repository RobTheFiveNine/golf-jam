extends Control

signal power_set(power_value)

onready var progress_bar : ProgressBar = $ProgressBar
onready var animation : AnimationPlayer = $AnimationPlayer
onready var tween : Tween = $ModulateTween

var is_active : bool = false
var is_set : bool = false

func _ready():
    modulate = Color("00ffffff")

func _process(delta):
    if is_set:
        return

    if Input.is_action_just_pressed("action"):
        if is_active:
            is_active = false
            is_set = true
            animation.stop()
            fade_out()
            emit_signal("power_set", progress_bar.value)
        else:
            fade_in()
            is_active = true
            animation.play("Fill")
            
func fade_in():
    tween.interpolate_property(self, "modulate", null, Color("ffffffff"), 0.1, Tween.TRANS_LINEAR)
    tween.start()
            
func fade_out():
    tween.interpolate_property(self, "modulate", null, Color("00ffffff"), 1.1, Tween.TRANS_LINEAR)
    tween.start()

func reset():
    is_set = false
    is_active = false
    progress_bar.value = 0
