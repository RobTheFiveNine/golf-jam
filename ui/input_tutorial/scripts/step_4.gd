extends TutorialStep

var criteria_met : bool = false

func _input(event):
    if active_step and not criteria_met:
        if Input.is_action_pressed("action"):
            criteria_met = true
            emit_signal("criteria_met", step_number)
