extends Node2D

onready var particleShell = load("res://Particle.tscn")
onready var massSlider = $UI/MassSlider
onready var massLabel = $UI/MassLabel
onready var windSlider = $UI/WindSlider
onready var windLabel = $UI/WindLabel

var particles = []
var mouseStartPos = Vector2.ZERO
var usingSlider = false

const g = Vector2(0,9.8)
const massPrefix = 0.1 #1 for kilogram | 0.1 for decigram and so on
const particleDistancePrefix = 0.01 #1 for meter | 0.1 for decimeter and so on

enum {
	NORMAL,
	DRAWING
}
var state = NORMAL

func _process(delta):
	match state:
		NORMAL:
			if Input.is_mouse_button_pressed(BUTTON_LEFT) and !usingSlider:
				mouseStartPos = get_local_mouse_position()
				state = DRAWING
		DRAWING:
			if Input.is_action_just_released("click"):
				create_particle(mouseStartPos, calculate_velocity(mouseStartPos, get_local_mouse_position()), massSlider.value)
				state = NORMAL
			update()

	for p in particles:
		p.apply_force(p.mass * g)
		p.apply_force(Vector2.RIGHT * windSlider.value)
	
	massLabel.text = str(massSlider.value * massPrefix) + " Kg"
	windLabel.text = str(abs(windSlider.value)) + " N"

func calculate_velocity(startPoint : Vector2, endPoint : Vector2):
	var velocity = startPoint.direction_to(endPoint) * startPoint.distance_to(endPoint)
	return velocity

func create_particle(_position : Vector2, _velocity : Vector2, mass : int):
	var particle = particleShell.instance()
	self.add_child(particle)
	particles.append(particle)
	particle.assign_properties(_position, _velocity, mass, particleDistancePrefix)

func _draw():
	if state == DRAWING:
		draw_line(mouseStartPos, get_local_mouse_position(), Color(255,0,0), 1)
	else:
		pass

func _on_WindSlider_drag_started():
	usingSlider = true

func _on_WindSlider_drag_ended(value_changed):
	usingSlider = false

func _on_MassSlider_drag_started():
	usingSlider = true

func _on_MassSlider_drag_ended(value_changed):
	usingSlider = false
