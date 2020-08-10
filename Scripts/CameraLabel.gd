extends Label


func _process(delta):
    self.text = "Camera Rotation: " + str(get_parent().get_parent().get_node("Player/Camera_Container/Rotation_Helper/Camera").rotation_degrees)
