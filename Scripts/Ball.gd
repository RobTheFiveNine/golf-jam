extends Spatial

signal ball_stopped

onready var raycast : RayCast = $RayCast
onready var rigidbody : RigidBody = $RigidBody

func _physics_process(delta):
    var velocity_length = rigidbody.linear_velocity.length()

    if raycast.is_colliding() and velocity_length < 0.03 and velocity_length > 0:
        rigidbody.sleeping = true
        emit_signal("ball_stopped")
