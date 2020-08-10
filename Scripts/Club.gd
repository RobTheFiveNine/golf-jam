extends Spatial

export (NodePath) var ball_path

onready var animation_player = $AnimationPlayer
onready var static_body = $StaticBody
onready var mesh = $Mesh
onready var aim_cast = $Mesh/RayCast
onready var aim_line = $ImmediateGeometry

var ball : RigidBody

func reset_position():
    # TODO: Change positioning to change the position of the mesh itself,
    #       and place the top level node at the center of the ball
    #       so the parent can be rotated to make the mesh rotate
    #       around the ball. quick maths.
    
    self.transform.origin = ball.global_transform.origin
    var offset = Vector3(0.15, 1.93, -0.1)
    mesh.transform.origin = offset
    visible = true
    animation_player.play("Reset")

func _ready():
    ball = get_node(ball_path).get_node("RigidBody")
    visible = false

func _input(event):
    if Input.is_action_just_pressed("action"):
        animation_player.play("Slow_Swing")
        
func _process(delta):
    #print(aim_cast.get_collision_point())
    #var a = aim_cast.global_transform.origin - aim_cast.get_collision_point()
    #print(a)
    aim_line.clear()
    aim_line.begin(Mesh.PRIMITIVE_LINE_STRIP)
    aim_line.add_vertex(to_local(ball.global_transform.origin))
    aim_line.add_vertex(to_local(aim_cast.get_collision_point()))
    
    #aim_line.add_vertex(to_local($Spatial.global_transform.origin))
    #aim_line.add_vertex(to_local($Spatial2.global_transform.origin))
    aim_line.end()
    

func hit_ball():
    ball.sleeping = false
    ball.apply_central_impulse(Vector3(0, 0, 5))

func _on_ball_stopped():
    print('ball stopped')
    # static_body
    reset_position()
