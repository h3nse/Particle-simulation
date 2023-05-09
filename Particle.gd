extends Node2D

var mass = 1
var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO

func apply_force(Force):
	acceleration += Force / mass

func _process(delta):
	velocity += acceleration * delta
	position += velocity * delta * 100
	acceleration = Vector2.ZERO
