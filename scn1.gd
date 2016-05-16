
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
#var root = get_tree().get_root()
#var current_scene = get_tree().get_current_scene()
    
func _ready():	
	set_process_input(true)
	set_fixed_process(true)
	

func _input(event):
	if(event.is_action("ui_accept")):		
		get_tree().change_scene("res://regras.scn")

