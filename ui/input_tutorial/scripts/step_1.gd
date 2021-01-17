extends TutorialStep

var pressed_left : bool = false
var pressed_right : bool = false
var pressed_up : bool = false
var pressed_down : bool = false
var criteria_met : bool = false

func _input(event):
    if active_step and not criteria_met:
        if Input.is_action_pressed("move_backward"):
            pressed_down = true
            
        if Input.is_action_pressed("move_forward"):
            pressed_up = true
            
        if Input.is_action_pressed("move_left"):
            pressed_left = true
            
        if Input.is_action_pressed("move_right"):
            pressed_right = true
            
        if pressed_down and pressed_up and pressed_left and pressed_right:
            criteria_met = true
            emit_signal("criteria_met", step_number)
