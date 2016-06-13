
extends Control

# member variables here, example:
# var a=2
# var b="textvar"
var pLabel = 0
var pConf = 0
var pPop = 0


func _ready():
	pass

func _on_VoltarBtn_pressed():
	get_tree().change_scene("res://title1.scn")


func _on_MudarPlayerBtn_pressed():
	pLabel = get_node("PlayerLabel")
	pConf = get_node("MudarPlayerBtn")
	pPop = get_node("MudarPlayerBtn/confirmacao")
	#var player = int(pLabel.get_text()[7])
	#if verificaTab(player):		
	pPop.popup_centered()
	
	
	


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
			