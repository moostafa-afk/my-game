extends CharacterBody2D


# Called when the node enters the scene tree for the first time.

@export var speed = 600
@onready var animation_tree : AnimationTree = $AnimationTree2
var direction = Vector2.ZERO

func _ready():
	animation_tree.active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(_delta):
	
	
	var hide = true # hides other sprite
	
	direction = Input.is_action_pressed("right") # moves right
	
	update_animation_parameters()
	if direction:
		velocity.x = speed 
		$animations/walk_player/walk.flip_h = false
		$animations/idle_player/idle.visible = false
		$animations/walk_player/walk.visible = true
		$animations/idle_player/idle.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -speed #moves left
		$animations/walk_player/walk.flip_h = true 
		$animations/idle_player/idle.flip_h = true
		$animations/idle_player/idle.visible = false
		$animations/walk_player/walk.visible = true
	else:
		velocity.x = 0
		
		$animations/idle_player/idle.visible = true
		$animations/walk_player/walk.visible = false
		
	

	
	print(velocity)
	
	
	move_and_slide()
func update_animation_parameters():
	if  (velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/walk"] = false
		
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/walk"] = true
	
		
	if (velocity != Vector2.ZERO): # keeps animation in the same direction
		animation_tree.set("parameters/walk/blend_position", velocity)
		
		
	elif (velocity == Vector2.ZERO): # keeps animation in the same direction
		animation_tree.set("parameters/idle/blend_position", velocity)
		
	
