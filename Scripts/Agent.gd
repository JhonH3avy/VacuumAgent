extends Sprite

export var position_offset : int = 16
export var position_tile_size : int = 32

onready var top_ray = $TopRayCast
onready var right_ray = $RightRayCast
onready var bottom_ray = $BottomRayCast
onready var left_ray = $LeftRayCast

enum DIRECTION {
	top = 0,
	right = 1,
	bottom = 2,
	left = 3
}

var current_direction
var current_tile_position

func _ready():
	current_direction = DIRECTION.right

func _on_start_position_generated(start_position):
	current_tile_position = start_position
	position_agent(current_tile_position)
	$AgentTimer.start()


func position_agent(tile_position):
	var temp_position = tile_position * position_tile_size
	temp_position.x += position_offset
	temp_position.y += position_offset
	position = temp_position


func _on_AgentTimer_timeout():
	move()


func move():
	var direction_to_move = get_direction_to_move(current_direction)
	var movement = get_movement_from_direction(direction_to_move)
	current_tile_position += movement
	position_agent(current_tile_position)
	current_direction = direction_to_move


func get_direction_to_move(direction):
	if direction == DIRECTION.top:
		if not right_ray.is_colliding():
			return DIRECTION.right
		elif not top_ray.is_colliding():
			return DIRECTION.top
		elif not left_ray.is_colliding():
			return DIRECTION.left
		else:
			return DIRECTION.bottom
	elif direction == DIRECTION.right:
		if not bottom_ray.is_colliding():
			return DIRECTION.bottom
		elif not right_ray.is_colliding():
			return DIRECTION.right
		elif not top_ray.is_colliding():
			return DIRECTION.top
		else:
			return DIRECTION.left
	elif direction == DIRECTION.bottom:
		if not left_ray.is_colliding():
			return DIRECTION.left
		elif not bottom_ray.is_colliding():
			return DIRECTION.bottom
		elif not right_ray.is_colliding():
			return DIRECTION.right
		else:
			return DIRECTION.top
	elif direction == DIRECTION.left:
		if not top_ray.is_colliding():
			return DIRECTION.top
		elif not left_ray.is_colliding():
			return DIRECTION.left
		elif not bottom_ray.is_colliding():
			return DIRECTION.bottom
		else:
			return DIRECTION.right


func get_movement_from_direction(direction)->Vector2:
	if direction == DIRECTION.top:
		return Vector2(0,-1)
	elif direction == DIRECTION.right:
		return Vector2(1,0)
	elif direction == DIRECTION.bottom:
		return Vector2(0,1)
	elif direction == DIRECTION.left:
		return Vector2(-1,0)
	else:
		return Vector2(0,0)
