extends Node2D

var mass = 1
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

func assign_properties(_position : Vector2, _velocity : Vector2, _mass):
	position = _position
	velocity = _velocity
	mass = _mass

func apply_force(Force): 
	if !mass: 
		acceleration = Vector2.ZERO
	else:
		acceleration += Force / mass * 10

func _process(delta):
	velocity += acceleration * delta * 10
	position += velocity * delta
	acceleration = Vector2.ZERO
