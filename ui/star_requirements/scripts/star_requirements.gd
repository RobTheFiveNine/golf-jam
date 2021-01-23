extends Control

func set_requirements(s1, s2, s3):
    if s1 > 1:
        $MarginContainer/VBoxContainer2/Label.text = "%s shots" % s1
    else:
        $MarginContainer/VBoxContainer2/Label.text = "%s shot" % s1

    $MarginContainer/VBoxContainer2/Label2.text = "%s shots" % s2
    $MarginContainer/VBoxContainer2/Label3.text = "%s shots" % s3
