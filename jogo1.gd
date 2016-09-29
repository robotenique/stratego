
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
var pLabel = 0
var pConf = 0
var pPop = 0
var pPopError = 0
var mTab = []
var tt = "KAKAKAKAKAKJ"
var criado = false
var pronto = false


func _ready():
	tt = "OI"

	
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
	
#func fechaTab(player):
#	if(player==1):
#		var tNeutra = load("res://pneutral.jpg")
#		tab = [get_node("tabuleiro/linha6"),get_node("tabuleiro/linha7"),get_node("tabuleiro/linha8"),get_node("tabuleiro/linha9")]
#	elif(player==2):
#		var tNeutra = load("res://pneutral.jpg")
#		tab = [get_node("tabuleiro/linha0"),get_node("tabuleiro/linha1"),get_node("tabuleiro/linha2"),get_node("tabuleiro/linha3")]
#	var tab = 0		
#	for linha in tab:
#		for p in range(10):
#			linha.get_child(p).set_normal_texture(tNeutra)

func abreTab(player):
	if(player==1):
		for i in range(10):
			for j in range(10):
				if(mTab[i][j][2]==1):
					mTab[i][j][1].set_normal_texture(mTab[i][j][0])
	#TODO PLAYER 2
			

func fechaTab():
	var tNeutra1 = load("res://pneutral.jpg")
	var tNeutra2 = load("res://stalindo.jpg")
	for i in range(10):
		for j in range(10):
			if(mTab[i][j][2]==1):
				mTab[i][j][1].set_normal_texture(tNeutra1)
			elif(mTab[i][j][2]==2):
				mTab[i][j][1].set_normal_texture(tNeutra2)
			
	
	

	
func _on_confirmacao_confirmed():
	var popup2 = get_node("MudarPlayerBtn/conf2")
	var pLabel = get_node("PlayerLabel")
	var player = int(pLabel.get_text()[7])	
	#CRIANDO TABULEIRO	
	#O B DEVERIA SER UMA VARIAVEL STATIC P/ EXECUTAR A CRIAÇÃO DO TABULEIRO APENAS UMA VEZ!
	if (not pronto):
		if (not criado):
			for i in range(10):
				mTab.append([])
				for j in range(10):
					mTab[i][j].append([load("res://tile.png"),get_node(str("tabuleiro/linha",i,"/p",j)),0])
			criado = true
		if(player==1):
			for i in range(6,10):
				for j in range(10):
					mTab[i][j][0] = mTab[i][j][1].get_normal_texture()
					mTab[i][j][2] = 1;
		if(player==2):
			for i in range(0,4):
				for j in range(10):
					mTab[i][j][0] = mTab[i][j][1].get_normal_texture()
					mTab[i][j][2] = 2;
			pronto = true
	fechaTab()
	popup2.popup_centered()


func verificaTab(player):
	var blank = load("res://tile.png")
	if player==1:	
		var linhas = [get_node("tabuleiro/linha6"),get_node("tabuleiro/linha7"),get_node("tabuleiro/linha8"),get_node("tabuleiro/linha9")]
		for l in linhas:
			for t in range(10):
				if (l.get_child(t)).get_normal_texture()==blank:
					return false
		return true
	#TODO: VERIFICAR TABULEIRO PLAYER 2
			

func _on_erroDialog_confirmed():
	pass # replace with function body


func _on_PopupMenu_item_pressed( ID ):	
	print("ATA")

func get_mTab():
	return mTab

func _on_rND_pressed():
	for i in range(10):
		mTab.append([])
		for j in range(10):	#		
			mTab[i].append([load("res://tile.png"),get_node(str("tabuleiro/linha",i,"/p",j)),0])

					
	var t = [];
	for i in range(1,41):
		t.append(get_node(str("pecas",i,"/peca1")).get_normal_texture())
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://tile.png"))
	var k = 0	
	for i in range(9,5,-1):
		for j in range(10):
			mTab[i][j][1].set_normal_texture(t[k])
			k += 1
			
	
		


func _on_conf2_confirmed():
	pLabel.set_text("Player 2")
	pLabel.set("custom_colors/font_color", Color(1,0,0))
	pConf.set_text("Começar jogo!")
	pPop.set_text("Iniciar jogo agora?!")
	#TODO: ADICIONAR PEÇAS DO PLAYER 2
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
	


