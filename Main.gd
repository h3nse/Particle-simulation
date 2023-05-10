extends Node2D

onready var particleShell = load("res://Particle.tscn")
onready var massSlider = $MassSlider
onready var massLabel = $MassLabel

var particles = []
var wind = Vector2(-10,0)
var mouseStartPos = Vector2.ZERO

const g = Vector2(0,9.8)

enum {
	NORMAL,
	DRAWING
}
var state = NORMAL

func _process(delta):
	match state:
		NORMAL:
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				mouseStartPos = get_local_mouse_position()
				state = DRAWING
		DRAWING:
			if Input.is_action_just_released("click"):
				create_particle(mouseStartPos, calculate_velocity(mouseStartPos, get_local_mouse_position()), massSlider.value)
				state = NORMAL
			update()

	for p in particles:
		p.apply_force(p.mass * g)
		p.apply_force(wind)
	
	massLabel.text = str(massSlider.value) + " * 10g"

func calculate_velocity(startPoint : Vector2, endPoint : Vector2):
	var velocity = startPoint.direction_to(endPoint) * startPoint.distance_to(endPoint)
	return velocity

func create_particle(_position : Vector2, _velocity : Vector2, mass : int):
	var particle = particleShell.instance()
	self.add_child(particle)
	particles.append(particle)
	particle.assign_properties(_position, _velocity, mass)

func _draw():
	if state == DRAWING:
		draw_line(mouseStartPos, get_local_mouse_position(), Color(255,0,0), 1)
	else:
		pass
