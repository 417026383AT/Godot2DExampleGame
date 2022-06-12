extends KinematicBody2D

const MOVING_SPEED = 25
const MAX_SPEED = 50
const JUMP_HEIGHT = -300
const UP = Vector2(0,-1)
const GRAVITY = 15


onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h= true
		animationPlayer.play("Walk")
		motion.x = min(motion.x+MOVING_SPEED,MAX_SPEED)
		
	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h= false
		animationPlayer.play("Walk")
		motion.x = max(motion.x-MOVING_SPEED,-MAX_SPEED) 
		
	else:
		animationPlayer.play("Idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x,0,0.5)
			
	else:
		if friction==true:
			motion.x = lerp(motion.x,0,0.01)
			
	motion = move_and_slide(motion,UP)
	
