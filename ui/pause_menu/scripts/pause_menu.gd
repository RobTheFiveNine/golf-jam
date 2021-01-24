extends Control

onready var animation : AnimationPlayer = $AnimationPlayer

var is_open : bool = false

func _ready():
    modulate = Color("00ffffff")
    visible = true
    
func _process(delta):
    if Input.is_action_just_pressed("ui_cancel"):
        if is_open:
            close_menu()
        else:
            open_menu()

func open_menu():
    is_open = true
    get_tree().paused = true
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
    animation.play("FadeIn")
    
func close_menu():
    is_open = false
    get_tree().paused = false
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    animation.play("FadeOut")

func _on_ResumeButton_pressed():
    if is_open:
        close_menu()

func _on_ExitButton_pressed():
    if is_open:
        get_tree().quit()
