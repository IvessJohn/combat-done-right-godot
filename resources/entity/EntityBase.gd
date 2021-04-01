extends KinematicBody2D

export(int) var hp_max: int = 100
export(int) var hp: int = hp_max
export(int) var defense: int = 0

export(int) var SPEED: int = 75
var velocity: Vector2 = Vector2.ZERO

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer


func _physics_process(delta):
	move()

func move():
	velocity = move_and_slide(velocity)

func die():
	queue_free()
