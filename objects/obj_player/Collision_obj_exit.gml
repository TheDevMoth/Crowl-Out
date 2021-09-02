/// @desc Go to Room
x += (TILE_W/4)*other.moveOnx
y += (TILE_H/4)*other.moveOny

global.playerPreviousHspd = hspd
global.playerPreviousVspd = vspd
hspd = 0
vspd = 0

room_goto(other.roomToGo)
