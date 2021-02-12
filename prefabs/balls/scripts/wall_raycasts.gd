extends FollowNode

onready var hit_sound : AudioStreamPlayer = $HitSound
onready var initial_db = hit_sound.volume_db

export (float) var velocity_volume_modifier = 15

func play_sound():
    var body = target_node as RigidBody
    var modifier = velocity_volume_modifier * (1 - (body.linear_velocity.length() / 60))
    hit_sound.volume_db = initial_db - modifier
    hit_sound.play()

func _on_LeftCast_hit_wall():
    play_sound()

func _on_RightCast_hit_wall():
    play_sound()

func _on_DownCast_hit_wall():
    play_sound()

func _on_UpCast_hit_wall():
    play_sound()
