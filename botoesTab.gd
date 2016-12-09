
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
	print("ISVIZINHO = dl: ",dl,", dc = ",dc,", ol = ",ol,", oc = ",oc)
	if not isScout:
		print("IS NOT SCOUT")
		if dl == ol - 1 and dc == oc:
			return true
		elif dl == ol and dc == oc + 1:
			return true
		elif dl == ol + 1 and dc == oc:
			return true
		elif dl == ol and dc == oc - 1:
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
			for j in range(oc + 1, dc):
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

# Retorna o ID da peça, ID = [-1, 0, 1, ..., 9]
# -1 = flag
# 0 = bomb
func getID(texture):
	var count = 0
	if texture == load("res://hitlao.jpg") or texture == load("res://stalindo.jpg"):
		return 10
	for x in global.stable_ID[0]:
		if texture == x[0] or texture == x[1]:
			return  global.stable_ID[1][count]
		count += 1;

func destroy(a, b):
	var tile = load("res://tile.png")
	global.mTab[a][b][0] = tile
	global.mTab[a][b][2] = 0

# Returns true if flag was not captured, false otherwise
func combate(mTab_o, mTab_d, data, ol, oc, dl, dc):
	# po = Peça origem
	# pd = peca destino
	var po = getID(mTab_o[0])
	var pd = getID(mTab_d[0])
	var tile = load("res://tile.png")
	print("po = ",po," pd = ",pd)
	if pd == 0:
		if po == 3:
			setCombatLog(po, pd, ol, oc, dl, dc, 1, 2, 0)
			destroy(dl, dc)
			swapPec(ol, oc, dl, dc)
		else:
			setCombatLog(po, pd, ol, oc, dl, dc, 0, 1, 0)
			destroy(ol, oc)
			global.mTab[ol][oc][1].set_normal_texture(tile)
	elif pd == -1:
		return false;
	elif po > pd:
		if po == 10 and pd == 1:
			setCombatLog(po, pd, ol, oc, dl, dc, 0, 0, 1)
			destroy(ol, oc)
			global.mTab[ol][oc][1].set_normal_texture(tile)
		else:
			setCombatLog(po, pd, ol, oc, dl, dc, 1, 0, 0)
			destroy(dl, dc)
			swapPec(ol, oc, dl, dc)
	elif po < pd:
		if po == 1 and pd == 10:
			setCombatLog(po, pd, ol, oc, dl, dc, 1, 0, 2)
			destroy(dl, dc)
			swapPec(ol, oc, dl, dc)
		else:
			setCombatLog(po, pd, ol, oc, dl, dc, 0, 0, 0)
			destroy(ol, oc)
			global.mTab[ol][oc][1].set_normal_texture(tile)
			combatResults_attack()
	else:
		setCombatLog(po, pd, ol, oc, dl, dc, 2, 0, 0)
		destroy(dl, dc)
		destroy(ol, oc)
		swapPec(ol, oc, dl, dc)
	combatResults_attack()
	return true

#		if pecaDestino == bomba:
#			if pecaOrigem == 3:
#				pecaDestino(mTab) = blank && setCombatLog("pecaDestino morreu")
#				swapPec(pecaOrigem, pecaDestino)
#			else:
#				pecaOrigem == blank && setCombatLog("pecaOrigem morreu")
#		elif pecaDestino == flag:
#			return false
#   elif pecaOrigem > pecaDestino:
#			if pecaOrigem == 9 && pecaDestino == 1:
#				pecaOrigem == blank && setCombatLog("pecaOrigem morreu")
#			else:
#				pecaDestino(mTab) = blank && setCombatLog("pecaDestino morreu")
#				swapPec(pecaOrigem, pecaDestino)
#		elif pecaOrigem < pecaDestino:
#			if pecaOrigem == 1 && pecaDestino == 9:
#				pecaDestino(mTab) = blank && setCombatLog("pecaDestino morreu")
#				swapPec(pecaOrigem, pecaDestino)
#			else:
#				pecaOrigem(mTab) = blank && setCombatLog("pecaOrigem morreu")
#		else (pecas iguais):
#			pecaOrigem(mTab) = blank && setCombatLog("ambas morreram")
#			pecaDestino(mTab) = blank
#			swapPec(pecaOrigem, pecaDestino)
#	return true


func combatResults_attack():
	var pPopCombat = get_tree().get_root().get_node("Control/combatDialog")
	var combatString = 0
	if global.combatLog[5]: #uma bomba esta envolvida
		if global.combatLog[5] == 1: #atacante morre pra bomba
			if global.combatLog[1] == 10: #atacante é general e morre para bomba
				combatString = str("Aaaah, minas terrestres! Nosso general está morto!")
			else: #atacante não é general e morre para a bomba
				combatString = str("Aaah! A sua peça ", global.combatLog[0], " explodiu em uma mina do adverário!")
		else: #atacante é sapper e mata a bomba
			combatString = str("Ahá! Nosso engenheiro (3) desarmou uma mina inimiga!") 
	elif global.combatLog[6]: #um general está envolvido e não é bomba
		if global.combatLog[6] == 1: #general atacante morre pra spy
			combatString = str("Nosso general foi assassinado por um espião inimigo!\nO que faremos sem sua liderança?") 
		else: #spy mata general
			combatString = str("A operação foi um sucesso! Nosso espião neutralizou o\ngeneral inimigo!")
	elif global.combatLog[4] == 0: #peça morre para defensor que não é bomba
		if global.combatLog[1] == 10: #peça morre para general
			combatString = str("Oh não! A sua peça ", global.combatLog[0], " foi derrotada pelo poderoso general\ninimigo.")
		else:
			combatString = str("Oh não! A sua peça ", global.combatLog[0], " perdeu o combate contra uma\npeça adversária ", global.combatLog[1], ".")
	elif global.combatLog[4] == 1:
		if global.combatLog[0] == 10:
			combatString = str("Nosso general derrotou uma peça ", global.combatLog[1], " inimiga.")
		else:
			combatString = str("A batalha foi vencida! A sua peça ", global.combatLog[0], " derrotou em\ncombate uma peça ", global.combatLog[1], " adversária.")
	else:
		if global.combatLog[0] == 10 and global.combatLog[1] == 10:
			combatString = str("Oh não! Ambos os generais estão mortos!")
		else:
			combatString = str("Uma batalha custosa! A sua peça ", global.combatLog[0], " derrotou em combate\numa peça adversária ", global.combatLog[1], ", mas também está fora de\ncombate.")
	pPopCombat.set_text(combatString)
	pPopCombat.popup_centered()

# status = 0 se peça de origem morre, 1 se peça de destino morre e 2 se ambas morrem
func setCombatLog(po, pd, ol, oc, dl, dc, status, bomb, general):
	global.combatLog[0] = po
	global.combatLog[1] = pd
	global.combatLog[2] = dl
	global.combatLog[3] = dc
	global.combatLog[4] = status
	global.combatLog[5] = bomb
	global.combatLog[6] = general
	global.combatLog[7] = ol
	global.combatLog[8] = oc

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
	var pPopFim = get_tree().get_root().get_node("Control/endDialog")
	if global.toggle == 0:
		if data[3] == 1:
			print("PASS 1");
			# If the button is from the board, and the destination is to a line
			if not(data[2][0]=="p") and destL[0]=="l":
				print("PASS 2 - IF BUTTON IS FROM BOARD, AND GO TO A LINE");
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
					print("PASS 3 - IF PLAYER == 1 AND THE DESTINATION ISN'T PLAYER 1");
					if not((mTab_o[0] == load("res://pB.png"))+(mTab_o[0] == load("res://pF.png"))):
						print("PASS 4 - NOT BOMB OR FLAG");
						if isVizinho(data, destL, destPec,(mTab_o[0] == load("res://p2.png"))):
							print("PASS 5 - IF THE DESTINATION IS NEIGHBOR WITH CURRENT");
							if mTab_d[2] == 2:
								print("PASS 6 - COMBAT");
								if(combate(mTab_o, mTab_d, data, int(data[2][5]), int(data[4][1]), int(destL[5]), int(destPec[1]))):
									global.toggle = 2
								else: # the game is over
									abreTab(1)
									abreTab(2)
									pPopFim.popup_centered()
							else:
								swapPec(int(data[2][5]), int(data[4][1]), int(destL[5]), int(destPec[1]));
								global.toggle = 1
		elif data[3] == 2:
			print("PASS 1");
			# If the button is from the board, and the destination is to a line
			if not(data[2][0]=="p") and destL[0]=="l":
				print("PASS 2 - IF BUTTON IS FROM BOARD, AND GO TO A LINE");
				# Gets the data from mTab of the given button:
					# data[2][5] = Line number of origin button
					# data[4][1] = Button number in the line
				mTab_o = global.mTab[int(data[2][5])][int(data[4][1])]
				# Gets the data from mTab of the destiny button:
					# destL[5] = Line number of destiny button
					# destPec[1] = Button number in the line
				mTab_d = global.mTab[int(destL[5])][int(destPec[1])]
				# If the player = 1 and the destination
				if(mTab_o[2] == 2 and mTab_d[2] != 2):
					print("PASS 3 - IF PLAYER == 2 AND THE DESTINATION ISN'T PLAYER 2");
					if not((mTab_o[0] == load("res://qB.png"))+(mTab_o[0] == load("res://qF.png"))):
						print("PASS 4 - NOT BOMB OR FLAG");
						if isVizinho(data, destL, destPec,(mTab_o[0] == load("res://q2.png"))):
							print("PASS 5 - IF THE DESTINATION IS NEIGHBOR WITH CURRENT");
							if mTab_d[2] == 1:
								print("PASS 6 - COMBAT");
								if(combate(mTab_o, mTab_d, data, int(data[2][5]), int(data[4][1]), int(destL[5]), int(destPec[1]))):
									global.toggle = 2
								else: # the game is over
									pPopFim.popup_centered()
							else:
								swapPec(int(data[2][5]), int(data[4][1]), int(destL[5]), int(destPec[1]));
								global.toggle = 1

			pass

# Só é chamada para montar o tabuleiro
func can_drop_data(pos, data, destL):
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

func abreTab(player):
	for i in range(10):
		for j in range(10):
			if(global.mTab[i][j][2] == player):
				global.mTab[i][j][1].set_normal_texture(global.mTab[i][j][0])