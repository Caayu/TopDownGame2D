extends CharacterBody2D


const SPEED = 60.0
var dir_name = "side_"

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _on_animation_looped():
	if "attack" in animated_sprite.animation:
		animated_sprite.play(dir_name + "idle")
		
func _on_frame_changed():
	if "attack" in animated_sprite.animation and animated_sprite.frame == 1:
		print("Aplicar dano aqui!")

func _ready():
	animated_sprite.play("front_idle")
	
	animated_sprite.connect("animation_looped", Callable(self, "_on_animation_looped"))
	animated_sprite.connect("frame_changed", Callable(self, "_on_frame_changed"))

func can_move():
	return not "attack" in animated_sprite.animation

# Sempre lide com movimento aqui:
func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if can_move():
		velocity.x = Input.get_axis("move_left", "move_right")
		velocity.y = Input.get_axis("move_up", "move_down")

		velocity = velocity.normalized() * SPEED
		
	move_and_slide()

func _process(delta):
	var anim_name = "idle"
	
	if Input.is_action_just_pressed("attack"):
		print("attack")
		animated_sprite.play(dir_name + "attack")

	if can_move():
		if velocity.length() > 0:
			anim_name = "walk"
			
			if velocity.x != 0:
				dir_name = "side_"
			elif velocity.y > 0:
				dir_name = "front_"
			elif velocity.y < 0:
				dir_name = "back_"

			animated_sprite.flip_h = dir_name == "side_" and velocity.x < 0

		animated_sprite.play(dir_name + anim_name)
	
	
	
	
	
	
	
	
