extends "res://resources/overlap/Hitbox.gd"

export(int) var SPEED: int = 100

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += SPEED * direction * delta

func destroy():
	queue_free()

func _on_PlayerDagger_area_entered(area):
	destroy()

func _on_PlayerDagger_body_entered(body):
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
