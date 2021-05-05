extends KinematicBody2D

signal hp_max_changed(new_hp_max)
signal hp_changed(new_hp)
signal died


export(int) var hp_max: int = 100 setget set_hp_max
export(int) var hp: int = hp_max setget set_hp, get_hp
export(int) var defense: int = 0

export(bool) var receives_knockback: bool = true
export(float) var knockback_modifier: float = 0.1

export(int) var SPEED: int = 75
var velocity: Vector2 = Vector2.ZERO

onready var sprite = $Sprite
onready var collShape = $CollisionShape2D
onready var animPlayer = $AnimationPlayer
onready var hurtbox = $Hurtbox


func get_hp():
	return hp

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_max)
		emit_signal("hp_changed", hp)
		if hp == 0:
			emit_signal("died")

func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)
		emit_signal("hp_max_changed", hp_max)
		self.hp = hp

func _physics_process(delta):
	move()

func move():
	velocity = move_and_slide(velocity)

func die():
	queue_free()

func receive_damage(base_damage: int):
	var actual_damage = base_damage
	actual_damage -= defense
	
	self.hp -= actual_damage
	return actual_damage

func receive_knockback(damage_source_pos: Vector2, received_damage: int):
	if receives_knockback:
		var knockback_direction = damage_source_pos.direction_to(self.global_position)
		var knockback_strength = received_damage * knockback_modifier
		var knockback = knockback_direction * knockback_strength
		
		global_position += knockback


func _on_Hurtbox_area_entered(hitbox):
	var actual_damage = receive_damage(hitbox.damage)
	
	if hitbox.is_in_group("Projectile"):
		hitbox.destroy()
	
	receive_knockback(hitbox.global_position, actual_damage)


func _on_EntityBase_died():
	die()
