
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func _on_goto_scene_pressed():
        get_node("/root/title1").goto_scene("res://regras.scn")


