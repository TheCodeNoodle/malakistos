extends CharacterBody2D

@export var speed:float = 75.0

var cardinal_direction : Vector2 = Vector2.LEFT	
var direction : Vector2 = Vector2.ZERO
var state : String = "idle"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func get_input():
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	var changed = setState()
	print("Changed:", changed, " State:", state)
	
	if changed or setDirection():
		setDirection()	
		updateAnim()
		
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
func setDirection() -> bool :
	if direction == Vector2.ZERO:
		return false

	var new_direction := cardinal_direction

	if abs(direction.x) > abs(direction.y):
		new_direction = Vector2.RIGHT if direction.x > 0 else Vector2.LEFT
	elif abs(direction.x) == abs(direction.y):
		new_direction = Vector2.RIGHT if direction.x > 0 else Vector2.LEFT
	else:
		new_direction = Vector2.DOWN if direction.y > 0 else Vector2.UP

	if new_direction == cardinal_direction:
		return false

	cardinal_direction = new_direction
	return true
	
	
func setState() -> bool:
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true
	
	
func updateAnim() -> void :
	animated_sprite_2d.play(state + "_" + animDirection())	
	pass

func animDirection() -> String :
	if cardinal_direction == Vector2.DOWN :
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else:
		return "left"
		
		
