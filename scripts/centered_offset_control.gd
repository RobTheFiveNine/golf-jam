extends Control

class_name CenteredOffsetControl

func _ready():
    connect("minimum_size_changed", self, "_on_min_size_change")
    
func _on_min_size_change():
    rect_pivot_offset = rect_size / 2
