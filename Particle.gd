extends Node2D

var mass = 0.1
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

func applyForce(Force):
	acceleration += Force / mass

func _process(delta):
	velocity += acceleration * delta
	position += velocity * delta
	acceleration = Vector2.ZERO
