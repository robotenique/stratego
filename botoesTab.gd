
extends TextureButton

# member variables here, example:
# var a=2
# var b="textvar"

#func getPlayer()


func get_drag_data(pos):
	#Player hardCoded
	#var player = getPlayer()
	var player = 1
	var cpb = TextureButton.new()
	cpb.set_normal_texture(get_normal_texture())
	set_drag_preview(cpb)
	# Return color as drag data	
	var nome = get_name()
	var btn = get_parent().get_child(int(nome[1]))	
	var texture = get_normal_texture()
	var data = [btn,texture,get_parent().get_name(),player]
	#	data.set_normal_texture(load("res://paladin1.jpg"))
	return data





func can_drop_data(pos, data,linhaDestino):
	var isButton = typeof(data[0])==18	
	if data[3]==1:	
		#PEÇA ---> TABULEIRO
		if data[2][0]=="p":
			if linhaDestino[0] != "p":
				if int(linhaDestino[5])>5:
					return isButton
			return false		
		#TABULEIRO --> X
		elif int(data[2][5])>5:
			#Tabuleiro ---> Peça
			if linhaDestino[0] == "p":
				return isButton
			#Tabuleiro --> Tabuleiro
			elif int(linhaDestino[5])>5:
				return isButton
	else:
		return int(data[2][5])<4 and isButton
	


func drop_data(pos, data):
	if(can_drop_data(pos,data,get_parent().get_name())):
		var nome = get_name()		
		var btn = get_parent().get_child(int(nome[1]))	
		var txtDestino = btn.get_normal_texture()
		self.set_normal_texture(data[1])
		print(txtDestino)
		data[0].set_normal_texture(txtDestino)
