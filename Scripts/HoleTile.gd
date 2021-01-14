extends Spatial

signal level_finished
signal ball_entered_hole
signal ball_exited_hole

onready var finish_timer : Timer = $FinishTimer

func _on_HoleArea_body_entered(body):
    emit_signal("ball_entered_hole")
    finish_timer.start()

func _on_HoleArea_body_exited(body):
    emit_signal("ball_exited_hole")
    finish_timer.stop()

func _on_FinishTimer_timeout():
    print('Hole made!')
    emit_signal("level_finished")
