extends Node2D

onready var particleShell = load("res://Particle.tscn")
var particles = []

const g = Vector2(0,9.8)
	
func _process(delta):
	if Input.is_action_just_pressed("click"):
		create_particle()

	for p in particles:
		p.apply_force(p.mass * g)

func create_particle():
	var particle = particleShell.instance()
	self.add_child(particle)
	particles.append(particle)
	particle.position = get_global_mouse_position()
