extends "res://Scripts/MazeGenerator.gd"


onready var time = $DirtyTime


func _on_Maze_maze_generation_completed():
	time.start()


func _on_DirtyTime_timeout():
	print("hi")
