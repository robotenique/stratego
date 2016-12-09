extends Node
var mTab = []
# i = row
# j = column
# mTab[i][j] = [originalTexture, buttonInstance, playerNumber]
var gIsOn = false
var pronto = false
var pronto2 = false

# 0 - No action , 1 - Common move, 2 - Combat
var toggle = 2
var stable_ID = []
# TODO: combatLog is a list with the information about the combat.
#       The information needs to be accessed only if toggle == 2
var combatLog = [0, 0, 0, 0, 0, 0, 0, 0, 0]
# combatLog[peça ataque(0), peça defesa(1), linha da peça de defesa(2), coluna da peça de defesa(3), resultado do combate(4), bomba(5), general(6),linha da peça de ataque(7), coluna da peça de ataque(8)]
#resultado do combate: 0 se o atacante morre, 1 se o defensor morre, 2 se ambos morrem
#general assume valores 0, 1, 2 e 3.  0 = combate normal. 1 = general atacante morre pra spy. 2 = spy atacante mata general.
#bomba assume valores 0, 1 e 2. 0 = não tem bomba no combate. 1 = atacante morre pra bomba. 2 = sapper mata bomba.
