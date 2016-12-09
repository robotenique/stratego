
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
var pLabel = 0
var pConf = 0
var pPop = 0
var pPopError = 0
var pConf2 = 0

var criado = false
var pronto = false


func _ready():
	pass


func _on_VoltarBtn_pressed():
	get_tree().quit()


func _on_MudarPlayerBtn_pressed():
	pLabel = get_node("PlayerLabel")
	pConf = get_node("MudarPlayerBtn")
	pPop = get_node("MudarPlayerBtn/confirmacao")
	pPopError = get_node("MudarPlayerBtn/erroDialog")
	var player = int(pLabel.get_text()[7])
	print("GTOGGLE = ",global.toggle)
	if verificaTab(player) and not global.gIsOn:
		pPop.popup_centered()
	elif global.gIsOn and global.toggle:
		pPop.popup_centered()
	else:
		pPopError.popup_centered()


func abreTab(player):
	for i in range(10):
		for j in range(10):
			if(global.mTab[i][j][2] == player):
				global.mTab[i][j][1].set_normal_texture(global.mTab[i][j][0])


func fechaTab():
	var tNeutra1 = load("res://pneutral.jpg")
	var tNeutra2 = load("res://qneutral.jpg")
	for i in range(10):
		for j in range(10):
			if(global.mTab[i][j][2]==1):
				global.mTab[i][j][1].set_normal_texture(tNeutra1)
			elif(global.mTab[i][j][2]==2):
				global.mTab[i][j][1].set_normal_texture(tNeutra2)


func _on_confirmacao_confirmed():
	var popup2 = get_node("MudarPlayerBtn/conf2")
	var pLabel = get_node("PlayerLabel")
	var player = int(pLabel.get_text()[7])
	if (not pronto):
		if (not criado):
			for i in range(10):
				global.mTab.append([])
				for j in range(10):
					global.mTab[i].append([load("res://tile.png"), get_node(str("tabuleiro/linha",i,"/p",j)), 0])
			criado = true
		if(player==1):
			for i in range(6,10):
				for j in range(10):
					global.mTab[i][j][0] = global.mTab[i][j][1].get_normal_texture()
					global.mTab[i][j][2] = 1;
		if(player==2):
			for i in range(0,4):
				for j in range(10):
					global.mTab[i][j][0] = global.mTab[i][j][1].get_normal_texture()
					global.mTab[i][j][2] = 2;
					popup2.set_text("Passe para o player 1! \nO jogo vai começar!")
			pronto = true
	fechaTab()
	popup2.popup_centered()


func verificaTab(player):
	var blank = load("res://tile.png")
	var linhas = 0
	if player==1:
		linhas = [get_node("tabuleiro/linha6"),get_node("tabuleiro/linha7"),get_node("tabuleiro/linha8"),get_node("tabuleiro/linha9")]
	else:
		linhas = [get_node("tabuleiro/linha0"),get_node("tabuleiro/linha1"),get_node("tabuleiro/linha2"),get_node("tabuleiro/linha3")]
	for l in linhas:
		for t in range(10):
			if (l.get_child(t)).get_normal_texture()==blank:
				return false
	return true

func _on_erroDialog_confirmed():
	pass # replace with function body


func _on_PopupMenu_item_pressed( ID ):
	print("ATA")

func _on_rND_pressed():
	var pLabel = get_node("PlayerLabel")
	var player = int(pLabel.get_text()[7])
	if player == 1:
		for i in range(10):
			global.mTab.append([])
			for j in range(10):
				global.mTab[i].append([load("res://tile.png"),get_node(str("tabuleiro/linha",i,"/p",j)),0])
		var t = [];
		for i in range(1,41):
			t.append(get_node(str("pecas",i,"/peca1")).get_normal_texture())
			get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://tile.png"))
		var k = 0
		for i in range(9,5,-1):
			for j in range(10):
				global.mTab[i][j][1].set_normal_texture(t[k])
				k += 1
	else:
		for i in range(10):
			global.mTab.append([])
			for j in range(10):
				global.mTab[i].append([load("res://tile.png"),get_node(str("tabuleiro/linha",i,"/p",j)),0])
		var t = [];
		for i in range(1,41):
			t.append(get_node(str("pecas",i,"/peca1")).get_normal_texture())
			get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://tile.png"))
		var k = 0
		for i in range(0,4):
			for j in range(10):
				global.mTab[i][j][1].set_normal_texture(t[k])
				k += 1

func hideSelGrid():
	# Mannually setting each tile for player 2
	get_node(str("pecas1/peca1")).set_hidden(true)
	get_node(str("pecas2/peca1")).set_hidden(true)
	get_node(str("pecas3/peca1")).set_hidden(true)
	get_node(str("pecas4/peca1")).set_hidden(true)

	for i in range(5,7):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)
	for i in range(7,10):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)
	for i in range(10,14):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)
	for i in range(14,18):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)
	for i in range(18,22):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)
	for i in range(22,27):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)
	for i in range(27,35):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)
	for i in range(35,41):
		get_node(str("pecas",i,"/peca1")).set_hidden(true)

func createStableID():
	global.stable_ID = [
											[[load("res://qF.png") , load("res://pF.png")],
											 [load("res://qB.png") , load("res://pB.png")],
											 [load("res://q1.png") , load("res://p1.png")],
											 [load("res://q2.png") , load("res://p2.png")],
											 [load("res://q3.png") , load("res://p3.png")],
											 [load("res://q4.png") , load("res://p4.png")],
											 [load("res://q5.png") , load("res://p5.png")],
											 [load("res://q6.png") , load("res://p6.png")],
											 [load("res://q7.png") , load("res://p7.png")],
											 [load("res://q8.png") , load("res://p8.png")],
											 [load("res://q9.png") , load("res://p9.png")]],
											[-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9]]


func set_tab_p2():
	# Mannually setting each tile for player 2
	get_node(str("pecas1/peca1")).set_normal_texture(load("res://qF.png"))
	get_node(str("pecas2/peca1")).set_normal_texture(load("res://q1.png"))
	get_node(str("pecas3/peca1")).set_normal_texture(load("res://q9.png"))
	get_node(str("pecas4/peca1")).set_normal_texture(load("res://stalindo.jpg"))

	for i in range(5,7):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://q8.png"))
	for i in range(7,10):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://q7.png"))
	for i in range(10,14):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://q6.png"))
	for i in range(14,18):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://q5.png"))
	for i in range(18,22):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://q4.png"))
	for i in range(22,27):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://q3.png"))
	for i in range(27,35):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://q2.png"))
	for i in range(35,41):
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://qB.png"))

func _on_conf2_confirmed():
	var player = int(pLabel.get_text()[7])
	if not global.pronto :
		pConf.set_text("Começar jogo!")
		pPop.set_text("Iniciar jogo agora?!")
	if player == 1 and not global.pronto:
		set_tab_p2()
		pLabel.set_text("Player 2")
		pLabel.set("custom_colors/font_color", Color(1,0,0))
		player = 2
		global.pronto = true
	elif player == 2 and not global.pronto2:
		global.gIsOn = true
		global.pronto2 = true
		pConf = get_node("MudarPlayerBtn")
		pPop.set_text("Estás pronto?!")
		pConf.set_text("Passar para o próximo!")
		pConf2 = get_node("MudarPlayerBtn/conf2")
		pConf2.set_text("Passe para o outro player!")
		pPopError = get_node("MudarPlayerBtn/erroDialog")
		pPopError.set_text("Faça um movimento!")
		pLabel.set_text("Player 1")
		pLabel.set("custom_colors/font_color", Color(0,0,1))
		player = 1
		hideSelGrid()
		get_node(str("TitleLabel")).set_hidden(true)
		get_node(str("eixo_x")).set_hidden(false)
		get_node(str("eixo_y")).set_hidden(false)
		get_node(str("germanyFlag")).set_hidden(false)
		get_node(str("ussrFlag")).set_hidden(false)
		createStableID()
		game_loop(player)
	elif player == 1:
		player = 2
		pLabel.set_text("Player 2")
		pLabel.set("custom_colors/font_color", Color(1,0,0))
		if global.toggle == 2:
			combatResults_afterAttack()
		game_loop(player)
	elif player == 2:
		player = 1
		pLabel.set_text("Player 1")
		pLabel.set("custom_colors/font_color", Color(0,0,1))
		if global.toggle == 2:
			combatResults_afterAttack()
		game_loop(player)

func combatResults_afterAttack():
	var pPopCombat = get_tree().get_root().get_node("Control/combatDialog")
	var combatString = 0
	if global.combatLog[5]: #uma bomba esta envolvida
		if global.combatLog[5] == 1: #atacante morre pra bomba
			if global.combatLog[1] == 10: #atacante é general e morre para bomba
				combatString = str("Brilhante! Nossas minas terrestres localizadas em (x:", (10 - global.combatLog[2]) ,", y:", (1 + global.combatLog[3]) ,")\ndestruiram o general inimigo previamente localizado em (", global.combatLog[2],", ",global.combatLog[3],").") 
			else: #atacante não é general e morre para a bomba
				combatString = str("Excelente! Minas terrestres localizadas em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),")\ndestruiram uma peça ", global.combatLog[0] ," inimiga previamente localizada\nem (x:", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").") 
		else: #atacante é sapper e mata a bomba
			combatString = str("Oh não! Nossas minas terrestres localizadas em(x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),")\nforam desarmadas por um engenheiro inimigo previamente localizado\nem (x", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").")
	elif global.combatLog[6]: #um general está envolvido e não é bomba
		if global.combatLog[6] == 1: #general atacante morre pra spy
			combatString = str("Nosso espião localizado em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),") preparou\numa armadilha e capturou o general inimigo previamente localizado\nem (x", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").") 
		else: #spy mata general
			combatString = str("Desastre! Nosso general antes localizado em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),") foi\nassassinado por um espião inimigo previamente\nlocalizado em (x", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").")
	elif global.combatLog[4] == 0: #peça atacante morre para defensor que não é bomba
		if global.combatLog[1] == 10: #peça atacante morre para general
			combatString = str("Ahá! Nosso general localizado em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),") destruiu\numa peça ", global.combatLog[0] ," inimiga previamente localizada\nem (x", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").")
		else: #peça atacante morre para tropa mais forte
			combatString = str("Ahá! Sua peça ", global.combatLog[1], " localizada em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),")\ndestruiu uma peça ", global.combatLog[0] ," inimiga previamente localizada\nem (x:", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").")
	elif global.combatLog[4] == 1: #peça atacante ganha de uma peça
		if global.combatLog[0] == 10: #peça atacante é general
			combatString = str("Derrota desastrosa! Sua peça ", global.combatLog[1], " localizada em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),")\nfoi destruída pelo general inimigo previamente localizado\nem (x", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").")
		else: #peça atacante é normal
			combatString = str("Uma derrota! Sua peça ", global.combatLog[1], " localizada em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),")\nfoi destruída por uma peça ", global.combatLog[0] ," inimiga previamente\nlocalizada em (x", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),").")
	else:
		if global.combatLog[0] == 10 and global.combatLog[1] == 10:
			combatString = str("Oh não! Um ataque desesperado do general inimigo\ndestruiu o nosso líder! Ao menos o líder deles\ntambém está derrotado!")
		else:
			combatString = str("Uma batalha custosa! Sua peça ", global.combatLog[1], " localizada em (x:", (1 + global.combatLog[8]),", y:", (10 - global.combatLog[7]),")\ndestruiu uma peça ", global.combatLog[0] ," inimiga previamente localizada\nem (x", (1 + global.combatLog[3]),", y:",(10 - global.combatLog[2]),"), mas também está fora de combate.")
	pPopCombat.set_text(combatString)
	pPopCombat.popup_centered()

func game_loop(player):
	global.toggle = 0
	abreTab(player)


func _on_endDialog_confirmed():
	get_tree().quit()
