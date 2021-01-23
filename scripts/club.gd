extends Spatial

export (NodePath) var ball_path
export (float) var aim_speed = 2.4
export (float) var max_power = 10

signal reset
signal ball_hit

onready var animation_player = $AnimationPlayer
onready var static_body = $StaticBody
onready var mesh = $Mesh
onready var aim_cast = $Mesh/RayCast
onready var aim_line = $ImmediateGeometry
onready var tween : Tween = $HitTween

var ball : RigidBody
var ball_in_hole : bool = false
var input_mode : int
var swinging : bool = false
var power_modifier : float = 0

func reset_position():
    var offset = Vector3(0.15, 2.3, -0.1)
    
    transform.origin = ball.global_transform.origin
    mesh.transform.origin = offset
    aim_cast.global_transform.origin = ball.global_transform.origin
    visible = true
    
    animation_player.play("Reset")
    emit_signal("reset")
    draw_aim_assist()

func draw_aim_assist():
    var collision_point = aim_cast.get_collision_point()

    aim_line.clear()
    aim_line.begin(Mesh.PRIMITIVE_LINE_STRIP)
    aim_line.add_vertex(to_local(ball.global_transform.origin))
    aim_line.add_vertex(to_local(collision_point))
    aim_line.end()

func _ready():
    ball = get_node(ball_path).get_node("RigidBody")
    visible = false
        
func _process(delta):
    var modifier = 1
    var aim_altered = false
    
    if swinging:
        return
    
    if input_mode == Player.INPUT_MODE_AIM:
        if Input.is_action_pressed("steady_aim"):
            modifier = 0.15
            
        if Input.is_action_pressed("move_left"):
            rotate_y((aim_speed * delta) * modifier)
            aim_altered = true
            
        if Input.is_action_pressed("move_right"):
            rotate_y(((aim_speed * delta) * -1) * modifier)
            aim_altered = true

    draw_aim_assist()

func hit_ball():
    aim_line.clear()
    ball.sleeping = false

    var impulse = global_transform.basis.x * (max_power * power_modifier) * -1
    ball.apply_central_impulse(impulse)
    emit_signal("ball_hit")

func _on_ball_stopped():
    if not ball_in_hole:
        swinging = false
        reset_position()
    
func _on_ball_entered_hole():
    ball_in_hole = true
    
func _on_ball_exited_hole():
    ball_in_hole = false
    
func _on_input_mode_changed(mode):
    input_mode = mode

func _on_HitTween_tween_completed(object, key):
    if mesh.rotation_degrees.z == 0:
        animation_player.play("Hit")

func swing(power_value):
    swinging = true
    power_modifier = power_value / 100
    
    var lift_to = mesh.rotation_degrees
    lift_to.z = 45 * power_modifier
    
    tween.interpolate_property(
        mesh,
        "rotation_degrees",
        mesh.rotation_degrees,
        lift_to,
        0.5,
        Tween.TRANS_SINE,
        Tween.EASE_IN
    )
    
    tween.interpolate_property(
        mesh,
        "rotation_degrees",
        lift_to,
        mesh.rotation_degrees,
        0.3,
        Tween.TRANS_SINE,
        Tween.EASE_IN,
        0.6
    )

    tween.start()
    
    
    
