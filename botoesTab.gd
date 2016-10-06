
extends TextureButton

# member variables here, example:
# var a=2
# var b="textvar"

#func getPlayer()


func get_drag_data(pos):
	var pLabel = get_tree().get_root().get_node("Control/PlayerLabel")
	var player = int(pLabel.get_text()[7])	
	
	var cpb = TextureButton.new()
	cpb.set_normal_texture(get_normal_texture())
	set_drag_preview(cpb)
	# Return color as drag data	
	var nome = get_name()
	var btn = get_parent().get_child(int(nome[1]))	
	var texture = get_normal_texture()
	var data = [btn, texture, get_parent().get_name(), player, get_name()]
	return data



func can_drop_gState(pos, data, destL, destPec):
	# Origin and destination mTab instance
	var mTab_o = 0
	var mTab_d = 0
	if data[3] == 1:		
		if not(data[2][0]=="p"):			
			# Gets the data from mTab of the given button
			mTab_o = global.mTab[int(data[2][5])][int(data[4][1])]
			mTab_d = global.mTab[int(destL[5])][int(destPec[1])]
			if(mTab_o[2] == 1 and mTab_d[2] != 1):
				if(not((mTab_o[0] == load("res://pB.png"))+(mTab_o[0] == load("res://pF.png")))):
					pass
	else:
		pass

func can_drop_data(pos, data,destL):
	var isButton = typeof(data[0])==18	
	#Verificando para player1
	if data[3]==1:	
		#PEÇA ---> TABULEIRO
		if data[2][0]=="p":
			if destL[0] != "p":
				if int(destL[5])>5:
					return isButton
			return false		
		#TABULEIRO --> X
		elif int(data[2][5])>5:
			#Tabuleiro ---> Peça
			if destL[0] == "p":
				return isButton
			#Tabuleiro --> Tabuleiro
			elif int(destL[5])>5:
				return isButton
	else:
		#PEÇA ---> TABULEIRO
		if data[2][0]=="p":
			if destL[0] != "p":
				if int(destL[5]) < 4:
					return isButton
			return false
		#TABULEIRO --> X
		elif int(data[2][5]) < 4:
			#Tabuleiro ---> Peça
			if destL[0] == "p":
					return isButton
			#Tabuleiro --> Tabuleiro
			elif int(destL[5]) < 4:
				return isButton

func drop_data(pos, data):
	if(!(global.gIsOn)):
		if(can_drop_data(pos,data,get_parent().get_name())):
			var nome = get_name()		
			var btn = get_parent().get_child(int(nome[1]))	
			var txtDestino = btn.get_normal_texture()
			self.set_normal_texture(data[1])
			data[0].set_normal_texture(txtDestino)
	else:
		if(can_drop_gState(pos, data, get_parent().get_name(), get_name())):
			var nome = get_name()		
			var btn = get_parent().get_child(int(nome[1]))	
			var txtDestino = btn.get_normal_texture()
			self.set_normal_texture(data[1])
			data[0].set_normal_texture(txtDestino)


