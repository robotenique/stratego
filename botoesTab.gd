
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


func isVizinho(data, destL, destPec, isScout):
	# d = destiny
	# o = origin
	var dl = int(destL[5])
	var dc = int(destPec[1])
	var ol = int(data[2][5])
	var oc = int(data[4][1])
	var flag = false

	if not isScout:
		if dl == ol - 1 and dc == oc:
			return true
		elif dl == ol and dc == ol + 1:
			return true
		elif dl == ol + 1 and dc == oc:
			return true
		elif dl == ol and dc == ol - 1:
			return true
		else:
			return false
	# Checking Scout movement
	else:
		if dl > ol and dc == oc:
			for i in range(ol + 1,dl):
				if global.mTab[i][oc][0] != load("res://tile.png"):
					flag = true
					break
		elif ol > dl and dc == oc:
			for i in range(ol - 1, dl, -1):
				if global.mTab[i][oc][0] != load("res://tile.png"):
					flag = true
					break
		elif ol == dl and dc > oc:
			for j in range(oc + 1, ol):
				if global.mTab[ol][j][0] != load("res://tile.png"):
					flag = true
					break
		elif ol == dl and dc < oc:
			for j in range(oc - 1, dc, -1):
				if global.mTab[ol][j][0] != load("res://tile.png"):
					flag = true
					break
		else: return false
	return not(flag)



# @TODO: CORRIGIR SWAPPEC, POIS ESTA TROCANDO ERRADO!!!
# as vezes nao esta trocando, verificar
func swapPec(ol, oc, dl, dc):
	var textO = global.mTab[ol][oc][0]
	var playerO = global.mTab[ol][oc][2]
	var textD = global.mTab[dl][dc][0]
	var playerD = global.mTab[dl][dc][2]
	global.mTab[dl][dc][0] = textO
	global.mTab[ol][oc][0] = textD
	global.mTab[dl][dc][2] = playerO
	global.mTab[ol][oc][2] = playerD
	global.mTab[ol][oc][1].set_normal_texture(textD)
	global.mTab[dl][dc][1].set_normal_texture(textO)

#@TODO: IMPLEMENTAR can_drop_data p/ game_loop()
#limitações:
#if peca pertence à player:
#	if not (bomba, flag)
#		if mov->tabuleiro:
#			if posDestino pertence ao quadrado de vizinhança:
#				if posDestino == inimigo:
#					return combate(pecaAtual,pecaDestino)
#				elif posDestino == vazio:
#					return move(peca, posDestino)
#			elif é scout && movScoutÉválido(peca):
#				if posDestino == inimigo:
#					return combate(pecaAtual,pecaDestino)
#				elif posDestino == vazio:
#					return move(peca, posDestino)
#return false


func can_drop_gState(pos, data, destL, destPec):
	# Origin and destination mTab instance
	var mTab_o = 0
	var mTab_d = 0
	if data[3] == 1:
		# If the button is from the board, and the destination is to a line
		if not(data[2][0]=="p") and destL[0]=="l":
			# Gets the data from mTab of the given button:
				# data[2][5] = Line number of origin button
				# data[4][1] = Button number in the line
			mTab_o = global.mTab[int(data[2][5])][int(data[4][1])]
			# Gets the data from mTab of the destiny button:
				# destL[5] = Line number of destiny button
				# destPec[1] = Button number in the line
			mTab_d = global.mTab[int(destL[5])][int(destPec[1])]
			# If the player = 1 and the destination
			if(mTab_o[2] == 1 and mTab_d[2] != 1):
				if not((mTab_o[0] == load("res://pB.png"))+(mTab_o[0] == load("res://pF.png"))):
					if isVizinho(data, destL, destPec,(mTab_o[0] == load("res://p2.png"))):
						if mTab_d[2] == 2:
							pass
						else:
							swapPec(int(data[2][5]), int(data[4][1]), int(destL[5]), int(destPec[1]));
					else:
						pass
	else:
		pass

# Só é chamada para montar o tabuleiro
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
