extends Button

onready var click : AudioStreamPlayer = $Click
onready var hover : AudioStreamPlayer = $Hover

func _ready():
    connect("pressed", self, "_on_pressed")
    connect("mouse_entered", self, "_on_mouse_entered")

func _on_pressed():
    if not disabled:
        click.play()

func _on_mouse_entered():
    if not disabled:
        hover.play()
