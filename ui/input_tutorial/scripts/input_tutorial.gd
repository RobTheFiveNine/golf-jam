extends Node

export (int) var step_count = 0

onready var fade_in : Tween = $FadeIn
onready var fade_out : Tween = $FadeOut

var next_step : int = 1

func _ready():
    for i in range(step_count):
        var node : Control = find_node("Step_%s" % (i + 1))
        node.modulate = Color("00ffffff")
        node.visible = true
    
    load_step(1)
    
func find_step(step_number) -> TutorialStep:
    return find_node("Step_%s" % step_number) as TutorialStep
    
func load_step(step_number):
    var node = find_step(step_number)
    var initial_value = Color("00ffffff")
    var final_value = Color("ffffffff")
    fade_in.interpolate_property(node, "modulate", initial_value, final_value, 0.25, Tween.TRANS_LINEAR, 0, 0.175)
    fade_in.start()

func complete_step(step_number):
    var node = find_step(step_number)
    var initial_value = Color("ffffffff")
    var final_value = Color("00ffffff")
    fade_out.interpolate_property(node, "modulate", initial_value, final_value, 0.25, Tween.TRANS_LINEAR, 0)
    fade_out.start()

func _on_criteria_met(step_number):
    if step_number <= step_count:
        complete_step(step_number)

func _on_FadeIn_tween_completed(object, key):
    var step = find_step(next_step)
    step.begin()

func _on_FadeOut_tween_completed(object, key):
    var previous_step = find_step(next_step)
    previous_step.complete()

    if next_step < step_count:
        next_step += 1
        load_step(next_step)
