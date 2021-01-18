extends TutorialStep

var press_count : int = 0
var pressed_left : bool = false
var pressed_right : bool = false
var pressed_up : bool = false
var pressed_down : bool = false
var criteria_met : bool = false

func _input(event):
    if active_step and not criteria_met:
        if Input.is_action_just_pressed("move_backward") and not pressed_down:
            pressed_down = true
            press_count += 1
            
        if Input.is_action_just_pressed("move_forward") and not pressed_up:
            pressed_up = true
            press_count += 1
            
        if Input.is_action_just_pressed("move_left") and not pressed_left:
            pressed_left = true
            press_count += 1
            
        if Input.is_action_just_pressed("move_right") and not pressed_right:
            pressed_right = true
            press_count += 1
            
        if press_count > 1:
            criteria_met = true
            emit_signal("criteria_met", step_number)
