extends "res://resources/entity/EntityBase.gd"

export(PackedScene) var DAGGER: PackedScene = preload("res://resources/projectiles/PlayerDagger.tscn")

onready var attackTimer = $AttackTimer


func _physics_process(delta):
	var input_dir = get_input_direction()
	if input_dir != Vector2.ZERO:
		# PLAYER IS MOVING
		velocity = SPEED * input_dir
		animPlayer.play("run")
		if input_dir.x != 0 and sign(sprite.scale.x) != sign(input_dir.x):
			sprite.scale.x *= -1
	else:
		# PLAYER IS IDLE
		velocity = Vector2.ZERO
		animPlayer.play("idle")
	
	if Input.is_action_just_pressed("action_attack") and attackTimer.is_stopped():
		var dagger_direction = self.global_position.direction_to(get_global_mouse_position())
		throw_dagger(dagger_direction)
	
	move()

func throw_dagger(dagger_direction: Vector2):
	if DAGGER:
		var dagger = DAGGER.instance()
		get_tree().current_scene.add_child(dagger)
		dagger.global_position = self.global_position
		
		var dagger_rotation = dagger_direction.angle()
		dagger.rotation = dagger_rotation
		
		attackTimer.start()

func get_input_direction() -> Vector2:
	var input_dir: Vector2 = Vector2.ZERO
	
	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_dir = input_dir.normalized()
	
	return input_dir

