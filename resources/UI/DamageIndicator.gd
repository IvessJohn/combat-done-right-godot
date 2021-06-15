extends Node2D

export(int) var SPEED: int = 30
export(int) var FRICTION: int = 15
var SHIFT_DIRECTION: Vector2 = Vector2.ZERO

onready var label = $Label

func _ready():
	SHIFT_DIRECTION = Vector2(rand_range(-1, 1), rand_range(-1, 1))

func _process(delta):
	global_position += SPEED * SHIFT_DIRECTION * delta
	SPEED = max(SPEED - FRICTION * delta, 0)
