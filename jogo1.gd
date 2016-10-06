
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
var pLabel = 0
var pConf = 0
var pPop = 0
var pPopError = 0

var tt = "KAKAKAKAKAKJ"
var criado = false
var pronto = false


func _ready():
	pass

	
func _on_VoltarBtn_pressed():
	get_tree().change_scene("res://title1.scn")


func _on_MudarPlayerBtn_pressed():	
	#TODO: CONFIGURAR POPUPDIALOG!
	#var sd = get_node("MudarPlayerBtn/PopupMenu")
	#sd.add_icon_item(load("res://p1.png"),"ATTAAAAAA")
	#sd.popup_centered()
	print("MUDOU")
	pLabel = get_node("PlayerLabel")
	pConf = get_node("MudarPlayerBtn")
	pPop = get_node("MudarPlayerBtn/confirmacao")
	pPopError = get_node("MudarPlayerBtn/erroDialog")
	var player = int(pLabel.get_text()[7])
	if verificaTab(player):
		pPop.popup_centered()
	else:
		pPopError.popup_centered()
		
	


func abreTab(player):	
	for i in range(10):
		for j in range(10):
			if(global.mTab[i][j][2]==player):
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
	#CRIANDO TABULEIRO	
	#O B DEVERIA SER UMA VARIAVEL STATIC P/ EXECUTAR A CRIAÇÃO DO TABULEIRO APENAS UMA VEZ!
	if (not pronto):
		if (not criado):
			for i in range(10):
				global.mTab.append([])
				for j in range(10):
					global.mTab[i][j].append([load("res://tile.png"), get_node(str("tabuleiro/linha",i,"/p",j)), 0])
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
	
func set_tab_p2():
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
	pConf.set_text("Começar jogo!")	
	pPop.set_text("Iniciar jogo agora?!")
	var pronto = false
	var pronto2 = false
	if player == 1 and not pronto:
		set_tab_p2()
		pLabel.set_text("Player 2")
		pLabel.set("custom_colors/font_color", Color(1,0,0))
		player = 2
		pronto = true
	elif player == 2 and not pronto2:
		global.gIsOn = true
		pronto2 = true
		pLabel.set_text("Player 1")
		pLabel.set("custom_colors/font_color", Color(0,0,1))
		player = 1
		game_loop(player)



func game_loop(player):	
	abreTab(player)



#           @TODO: IMPLEMENTAR can_drop_data p/ game_loop()
#           limitações:
#           if peca pertence à player:
#           	if not (bomba, flag)
#           		if mov->tabuleiro:
#           			if posDestino pertence ao quadrado de vizinhança:
#           				if posDestino == inimigo:
#           					return combate(pecaAtual,pecaDestino)
#           				elif posDestino == vazio:
#           					return move(peca, posDestino)					
#           			elif é scout && movScoutÉválido(peca):
#           				if posDestino == inimigo:
#           					return combate(pecaAtual,pecaDestino)
#           				elif posDestino == vazio:
#           					return move(peca, posDestino)	
#           
#           return false
