extends Spatial

export (NodePath) var ball_path
export (float) var aim_speed = 2.4
export (float) var max_power = 10

onready var animation_player = $AnimationPlayer
onready var static_body = $StaticBody
onready var mesh = $Mesh
onready var aim_cast = $Mesh/RayCast
onready var aim_line = $ImmediateGeometry
onready var tween : Tween = $HitTween
onready var power_meter : ProgressBar = $ProgressBar

var ball : RigidBody
var input_disabled : bool = false
var ball_in_hole : bool = false
var input_mode : int
var swinging : bool = false

func reset_position():
    var offset = Vector3(0.15, 2.3, -0.1)
    power_meter.visible = false
    
    transform.origin = ball.global_transform.origin
    mesh.transform.origin = offset
    aim_cast.global_transform.origin = ball.global_transform.origin
    visible = true
    
    animation_player.play("Reset")
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

func _input(event):
    if input_disabled:
        return

    if Input.is_action_just_pressed("action"):
        if not swinging:
            swinging = true
            animation_player.play("Swing")
        else:
            input_disabled = true
            swinging = false
            animation_player.stop()
            var target = mesh.rotation_degrees
            target.z = 0
            tween.interpolate_property(
                mesh,
                "rotation_degrees",
                mesh.rotation_degrees,
                target,
                0.5,
                Tween.TRANS_SINE,
                Tween.EASE_IN
            )
            tween.start()
        
func _process(delta):
    var modifier = 1
    var aim_altered = false
    
    if input_disabled or swinging:
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

    var impulse = global_transform.basis.x * (max_power * (power_meter.value / 100)) * -1
    ball.apply_central_impulse(impulse)

func _on_ball_stopped():
    if not ball_in_hole:
        input_disabled = false
        reset_position()
    
func _on_ball_entered_hole():
    ball_in_hole = true
    
func _on_ball_exited_hole():
    ball_in_hole = false
    
func _on_input_mode_changed(mode):
    input_mode = mode

func _on_HitTween_tween_completed(object, key):
    animation_player.play("Hit")
