extends Node

# member variables here, example:
# var a=2
# var b="textvar"
var current_scene = null
func _ready():
	pass
	
func _input_event(ev):   
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	print(current_scene)
	#var obj = get_tree().get("/root/regras.scn")
	#print(obj) 
	#get_tree().set_current_scene(obj)



