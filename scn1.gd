
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
#var root = get_tree().get_root()
#var current_scene = get_tree().get_current_scene()
    
func _ready():	
	pass
	




func _on_RegrasBtn_pressed():
	get_tree().change_scene("res://regras.scn")


func _on_QuitBtn_pressed():
	 get_tree().quit()


func _on_PlayBtn_pressed():
	get_tree().change_scene("res://jogo1.scn")
