extends KinematicBody2D

onready var animation_tree = get_node("AnimatedSprite/AnimationTree")
onready var animation_mode = animation_tree.get("parameters/playback")


var motion = Vector2()

const SPEED = 20
const MAX_SPEED = 170
const FRICTION = 0.35
const MAX_STAMINA = 100


var velocity_multiplier = 1
var stamina = 100

#func _ready():
func _unhandled_input(event):
	pass

func _physics_process(delta):
	update_movement()
	move_and_slide(motion * velocity_multiplier)
	
	
#func _input(event):
	
func update_movement():
#	look_at(get_global_mouse_position())
#   Directional movement
	var current_frame = $AnimatedSprite.frame
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
		motion.x = lerp(motion.x, 0, FRICTION)
#		$AnimatedSprite.animation = "run_s"
#		$AnimatedSprite.playing = true
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_left"):
		motion.y = clamp(motion.y + SPEED/2, 0, MAX_SPEED/2)
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
#		$AnimatedSprite.animation = "run_se"
#		$AnimatedSprite.playing = true
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_right"):
		motion.y = clamp(motion.y + SPEED/2, 0, MAX_SPEED/2)
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
#		$AnimatedSprite.animation = "run_sw"
#		$AnimatedSprite.playing = true
		
	if Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
		motion.x = lerp(motion.x, 0, FRICTION)
#		$AnimatedSprite.animation = "run_n"
#		$AnimatedSprite.playing = true
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_left"):
		motion.y = clamp(motion.y - SPEED/2, -MAX_SPEED/2, 0)
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
#		$AnimatedSprite.animation = "run_ne"
#		$AnimatedSprite.playing = true
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_right"):
		motion.y = clamp(motion.y - SPEED/2, -MAX_SPEED/2, 0)
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
#		$AnimatedSprite.animation = "run_nw"
#		$AnimatedSprite.playing = true

	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
		motion.y = lerp(motion.y, 0, FRICTION)
#		$AnimatedSprite.animation = "run_e"
#		$AnimatedSprite.playing = true

	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
		motion.y = lerp(motion.y, 0, FRICTION)
#		$AnimatedSprite.animation = "run_w"
#		$AnimatedSprite.playing = true
	animation_tree.set("parameters/run/blend_position", motion.normalized())
	animation_tree.set("parameters/idle/blend_position", motion.normalized())
	animation_mode.travel("run")
	
	if not Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.y = lerp(motion.y, 0, FRICTION)
		motion.x = lerp(motion.x, 0, FRICTION)
		animation_mode.travel("idle")
#		$AnimatedSprite.animation = "idle"
#		$AnimatedSprite.playing = true
	$AnimatedSprite.frame = current_frame
	
#  Sprinting
	if Input.is_action_pressed("sprint") and stamina != 0:
		velocity_multiplier = 2
		if $SprintTimer.is_stopped():
			$SprintTimer.start()
			stamina -= 10
			get_tree().call_group("gui", "reduceStamina", 10)
	else:
		velocity_multiplier = 1
		if $SprintTimer.is_stopped():
			$SprintTimer.start()
			stamina += 10
			get_tree().call_group("gui", "regenStamina", 10)



