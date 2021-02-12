extends RayCast

signal hit_wall
var colliding_last_frame : bool = false

func _physics_process(delta):
    if is_colliding():
        if not colliding_last_frame:
            emit_signal("hit_wall")
            
    colliding_last_frame = is_colliding()
