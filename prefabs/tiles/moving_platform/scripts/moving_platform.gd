extends Spatial

onready var barriers_anim : AnimationPlayer = $AnimationPlayer

func open_barriers():
    barriers_anim.play("open")
    
func close_barriers():
    barriers_anim.play_backwards("open")
