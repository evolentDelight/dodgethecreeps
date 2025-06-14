extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	var mob_type = mob_types.pick_random()
	$AnimatedSprite2D.animation = mob_type
	$AnimatedSprite2D.play()
	if mob_type == "fly":
		$CollisionShape_Fly.disabled = false
	else:
		$CollisionShape_Fly.disabled = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
