/// @desc swinging animation

var swingRot = sin(current_time/1000)*swingRotation
var swingDist = sin(current_time/800)*swingDistance
draw_sprite_ext(sprite_index,0,x,y+swingDist,1,1,swingRot,c_white,1)