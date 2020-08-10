extends Spatial

onready var finish_timer : Timer = $FinishTimer

func _on_HoleArea_body_entered(body):
    print(body.name)
    finish_timer.start()

func _on_HoleArea_body_exited(body):
    finish_timer.stop()

func _on_FinishTimer_timeout():
    print('Hole made!')
