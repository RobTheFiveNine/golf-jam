extends Spatial

export (float) var margin = 0.04

func _ready():
    translation.y -= margin
