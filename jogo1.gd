
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
var pLabel = 0
var pConf = 0
var pPop = 0
var pPopError = 0


func _ready():	
	pass

func _on_VoltarBtn_pressed():
	get_tree().change_scene("res://title1.scn")


func _on_MudarPlayerBtn_pressed():	
	#TODO: CONFIGURAR POPUPDIALOG!
	var sd = get_node("MudarPlayerBtn/PopupMenu")
	sd.add_icon_item(load("res://p1.png"),"ATTAAAAAA")
	sd.popup_centered()
	
	
	
	
	
	
	
	
	
	
	
	
	pLabel = get_node("PlayerLabel")
	pConf = get_node("MudarPlayerBtn")
	pPop = get_node("MudarPlayerBtn/confirmacao")
	pPopError = get_node("MudarPlayerBtn/erroDialog")
	var player = int(pLabel.get_text()[7])
	if verificaTab(player):		
		pPop.popup_centered()		
	else:
		pPopError.popup_centered()
		fechaTab(player)
		
		
	
func fechaTab(player):
	var tNeutra = load("res://pneutral.jpg")
	var tab = 0
	print(player)
	if player==1:
		tab = [get_node("tabuleiro/linha6"),get_node("tabuleiro/linha7"),get_node("tabuleiro/linha8"),get_node("tabuleiro/linha9")]
	else:
		tab = [get_node("tabuleiro/linha0"),get_node("tabuleiro/linha1"),get_node("tabuleiro/linha2"),get_node("tabuleiro/linha3")]
	var matrixT = []	
	for l in tab:
		for peca in range(10):
			var btn = l.get_child(peca)
			matrixT.append([btn.get_normal_texture(),btn])
			btn.set_normal_texture(tNeutra)
			
	

	
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
