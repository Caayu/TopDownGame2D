extends CharacterBody2D


const SPEED = 60.0

# Sempre lide com movimento aqui:
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	velocity.x = Input.get_axis("move_left", "move_right")
	velocity.y = Input.get_axis("move_up", "move_down")

	velocity = velocity.normalized() * SPEED
	
	move_and_slide()
