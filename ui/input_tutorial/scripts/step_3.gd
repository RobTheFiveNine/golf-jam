extends TutorialStep

var criteria_met : bool = false
var aimed : bool = false
var slow_aimed : bool = false

func _input(event):
    if active_step and not criteria_met:
        if Input.is_action_just_pressed("steady_aim"):
            slow_aimed = true
            
        if Input.is_action_just_pressed("move_left"):
            aimed = true
            
        if Input.is_action_just_pressed("move_right"):
            aimed = true
            
        if slow_aimed and aimed:
            criteria_met = true
            emit_signal("criteria_met", step_number)
