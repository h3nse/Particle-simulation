extends Node2D

onready var particle = load("res://Particle.tscn").instance()
var gravity = Vector2.ZERO

const g = 9.8

func _ready():
	gravity.y = particle.mass * g
	
func _process(delta):
	if Input.is_action_just_pressed("click"):
		self.add_child(particle)
		particle.position = get_global_mouse_position()
	particle.applyForce(Vector2(gravity))
