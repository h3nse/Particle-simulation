extends Node2D

var mass = 1
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var distancePrefix = 0

func assign_properties(_position : Vector2, _velocity : Vector2, _mass, _distancePrefix):
	position = _position
	velocity = _velocity
	mass = _mass
	distancePrefix = _distancePrefix

func apply_force(Force): 
	if !mass: 
		acceleration += Force / distancePrefix
	else:
		acceleration += (Force / mass) / distancePrefix

func _process(delta):
	velocity += acceleration * delta
	position += velocity * delta
	acceleration = Vector2.ZERO
