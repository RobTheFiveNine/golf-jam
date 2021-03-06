extends Spatial

class_name HoleTile

signal level_finished
signal ball_entered_hole
signal ball_exited_hole

onready var hole_area : Area = $HoleArea

var finish_timer : Timer

func _ready():
    finish_timer = Timer.new()
    finish_timer.wait_time = 2
    finish_timer.one_shot = true
    finish_timer.connect("timeout", self, "_on_FinishTimer_timeout")
    add_child(finish_timer)
    
    hole_area.connect("body_entered", self, "_on_HoleArea_body_entered")
    hole_area.connect("body_exited", self, "_on_HoleArea_body_exited")

func _on_HoleArea_body_entered(body):
    emit_signal("ball_entered_hole")
    finish_timer.start()

func _on_HoleArea_body_exited(body):
    emit_signal("ball_exited_hole")
    finish_timer.stop()

func _on_FinishTimer_timeout():
    emit_signal("level_finished")

func _on_HoleDropArea_body_entered(body):
    body.collision_mask = 8

func _on_HoleDropArea_body_exited(body):
    body.collision_mask = 73
