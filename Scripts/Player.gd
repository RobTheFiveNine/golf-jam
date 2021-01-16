extends Spatial

class_name Player

signal input_mode_changed(mode)

const INPUT_MODE_FREE_VIEW = 0
const INPUT_MODE_AIM = 1

export (float) var move_speed = 5
export (float) var mouse_sensitivity = 0.05
export (float) var camera_angle = 0
export (float) var acceleration = 8
export (float) var deceleration = 16

var velocity = Vector3()
var default_fov = 0
var zoom_level = 1
var input_mode = INPUT_MODE_FREE_VIEW

onready var camera_container = $Camera_Container
onready var rotation_helper = $Camera_Container/Rotation_Helper
onready var camera = $Camera_Container/Rotation_Helper/Camera

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    default_fov = camera.fov
    
func handle_movement(delta):
    var aim = camera.get_global_transform().basis
    var direction = Vector3()
    
    if Input.is_action_pressed("move_forward"):
        direction -= aim.z
    if Input.is_action_pressed("move_backward"):
        direction += aim.z
    if Input.is_action_pressed("move_left"):
        direction -= aim.x
    if Input.is_action_pressed("move_right"):
        direction += aim.x

    direction = direction.normalized()
    
    var target = direction * move_speed * delta
    
    if direction == Vector3.ZERO:
        velocity = velocity.linear_interpolate(target, deceleration * delta)
    else:
        velocity = velocity.linear_interpolate(target, acceleration * delta)
        
    # Prevent player moving up and down through the plane they start on
    velocity.y = 0
    transform.origin += velocity

func _process(delta):
    if Input.is_action_just_pressed("ui_end"):
        get_tree().quit()
        
    if Input.is_action_just_pressed("cycle_zoom"):
        cycle_zoom_level()

    if Input.is_action_just_pressed("ui_cancel"):
        if input_mode == INPUT_MODE_FREE_VIEW:
            input_mode = INPUT_MODE_AIM
        else:
            input_mode = INPUT_MODE_FREE_VIEW
            
        emit_signal("input_mode_changed", input_mode)

    if input_mode == INPUT_MODE_FREE_VIEW:
        return handle_movement(delta)
    
func cycle_zoom_level():
    if zoom_level == 3:
        zoom_level = 1
    else:
        zoom_level += 1

    camera.fov = default_fov / zoom_level

func _input(event):
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

    if event is InputEventMouseMotion and input_mode == INPUT_MODE_FREE_VIEW:
        rotation_helper.rotate_x(deg2rad(event.relative.y * mouse_sensitivity * -1))
        camera_container.rotate_y(deg2rad(event.relative.x * mouse_sensitivity * -1))

        var camera_rot = rotation_helper.rotation_degrees
        camera_rot.x = clamp(camera_rot.x, -70, 70)
        rotation_helper.rotation_degrees = camera_rot
