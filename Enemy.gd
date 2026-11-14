extends CharacterBody2D

@export var speed: float = 150.0
@export var max_health: int = 3
@export var damage_to_castle: int = 1

var current_health: int

# We will find the castle automatically when the game starts
var castle: Node2D

func _ready():
	current_health = max_health
	# Look for the castle in the scene. 
	# Make sure your Castle node is named exactly "Castle" in the Scene tree!
	castle = get_tree().get_first_node_in_group("castle")

func _physics_process(delta):
	if castle == null:
		return
		
	# 1. Move toward the castle
	var direction = (castle.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	
	# 2. Check if we hit the castle
	# We use a simple distance check for now
	if global_position.distance_to(castle.global_position) < 20:
		print("Enemy hit the castle!")
		# In a real game, we would damage the castle here
		queue_free() # Destroy the enemy

func take_damage(amount: int):
	current_health -= amount
	if current_health <= 0:
		print("Enemy died!")
		queue_free() # Remove enemy from scene
