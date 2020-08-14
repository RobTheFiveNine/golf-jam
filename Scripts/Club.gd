extends Spatial

export (NodePath) var ball_path
export (float) var aim_speed = 2.4

onready var animation_player = $AnimationPlayer
onready var static_body = $StaticBody
onready var mesh = $Mesh
onready var aim_cast = $Mesh/RayCast
onready var aim_line = $ImmediateGeometry

var ball : RigidBody
var input_disabled : bool = false

func reset_position():
    var offset = Vector3(0.15, 2.3, -0.1)
    
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
        input_disabled = true
        animation_player.play("Slow_Swing")
        
func _process(delta):
    var modifier = 1
    var aim_altered = false
    
    if input_disabled:
        return
    
    if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
        if Input.is_action_pressed("steady_aim"):
            modifier = 0.3
            
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

    var impulse = global_transform.basis.x * 5 * -1
    ball.apply_central_impulse(impulse)

func _on_ball_stopped():
    input_disabled = false
    reset_position()
