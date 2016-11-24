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
# var combatLog = [str , ...]
