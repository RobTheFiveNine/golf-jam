extends Control

class_name TutorialStep

export (bool) var active_step = false
export (int) var step_number = 0

signal criteria_met

func begin():
    active_step = true

func complete():
    active_step = false
