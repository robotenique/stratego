
extends TextureButton

# member variables here, example:
# var a=2
# var b="textvar"

func get_drag_data(pos):
	var cpb = TextureButton.new()
	cpb.set_normal_texture(get_normal_texture())
	set_drag_preview(cpb)
	# Return color as drag data	
	var nome = get_name()
	var btn = get_parent().get_child(int(nome[1]))	
	var texture = get_normal_texture()
	var data = [btn,texture]
	#	data.set_normal_texture(load("res://paladin1.jpg"))
	return data



func can_drop_data(pos, data):
	return typeof(data)==18


func drop_data(pos, data):
	if(can_drop_data(pos,data[1])):
		self.set_normal_texture(data[1])		
		var nome = get_name()
		var btn = get_parent().get_child(int(nome[1]))	
		var txtDestino = btn.get_normal_texture()
		print(txtDestino)
		data[0].set_normal_texture(txtDestino)
