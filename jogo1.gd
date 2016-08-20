
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
var b = "1"


func _ready():
	tt = "OI"
	Globals.set(b,"1")
	
func _on_VoltarBtn_pressed():
	get_tree().change_scene("res://title1.scn")


func _on_MudarPlayerBtn_pressed():	
	#TODO: CONFIGURAR POPUPDIALOG!
	#var sd = get_node("MudarPlayerBtn/PopupMenu")
	#sd.add_icon_item(load("res://p1.png"),"ATTAAAAAA")
	#sd.popup_centered()
	
	pLabel = get_node("PlayerLabel")
	pConf = get_node("MudarPlayerBtn")
	pPop = get_node("MudarPlayerBtn/confirmacao")
	pPopError = get_node("MudarPlayerBtn/erroDialog")
	var player = int(pLabel.get_text()[7])
	
	
	
	
	
	if verificaTab(player):
	#CRIANDO TABULEIRO	
		if(player==1 and b=="1"):
			b = "WOL"
			for i in range(10):
				mTab.append([])
				for j in range(10):	#		
					mTab[i].append([load("res://tile.png"),get_node(str("tabuleiro/linha",i,"/p",j)),0])
			for i in range(10):
				for j in range(10):
					print(mTab[i][j][1])
					print("oi")
			
		pPop.popup_centered()		
	else:
		pPopError.popup_centered()
		
		
		
	
func fechaTab(player):
	var tNeutra = load("res://pneutral.jpg")
	var tab = 0	
	if player==1:
		tab = [get_node("tabuleiro/linha6"),get_node("tabuleiro/linha7"),get_node("tabuleiro/linha8"),get_node("tabuleiro/linha9")]
	else:
		tab = [get_node("tabuleiro/linha0"),get_node("tabuleiro/linha1"),get_node("tabuleiro/linha2"),get_node("tabuleiro/linha3")]
	for linha in tab:
		for p in range(10):
			linha.get_child(p).set_normal_texture(tNeutra)
	
	

	
func _on_confirmacao_confirmed():	
	pLabel.set_text("Player 2")
	pLabel.set("custom_colors/font_color", Color(1,0,0))
	pConf.set_text("Começar jogo!")
	pPop.set_text("Iniciar jogo agora?!")


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
	for i in range(10):
		for j in range(10):
			print(mTab[i][j][1])

					
	var t = [];
	for i in range(1,41):
		t.append(get_node(str("pecas",i,"/peca1")).get_normal_texture())
		get_node(str("pecas",i,"/peca1")).set_normal_texture(load("res://tile.png"))
	var k = 0	
	for i in range(9,5,-1):
		for j in range(10):
			mTab[i][j][1].set_normal_texture(t[k])
			k += 1
			
	
		
