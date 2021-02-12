extends Spatial

signal ball_stopped

export (NodePath) var out_of_bounds_path

onready var raycast : RayCast = $RayCast
onready var rigidbody : RigidBody = $RigidBody
onready var out_of_bounds : Node = get_node(out_of_bounds_path)
onready var bounce_sound : AudioStreamPlayer = $AudioStreamPlayer

var last_position : Vector3
var on_floor : bool
var on_floor_last_frame : bool = true
var current_floor : PhysicsBody

func _physics_process(delta):
    var velocity_length = rigidbody.linear_velocity.length()
    on_floor = raycast.is_colliding()
    
    if not on_floor_last_frame and on_floor:
        bounce_sound.play()
        
    on_floor_last_frame = on_floor
    current_floor = raycast.get_collider()

    if on_floor and velocity_length < 0.03 and velocity_length > 0:
        rigidbody.sleeping = true
        last_position = rigidbody.transform.origin

        emit_signal("ball_stopped")

    if rigidbody.global_transform.origin.y < out_of_bounds.global_transform.origin.y:
        rigidbody.transform.origin = Vector3(last_position.x, last_position.y + 2, last_position.z)
