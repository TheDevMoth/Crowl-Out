/// @desc 


var swingRot = sin(current_time/1000)*swingRotation
var swingDist = sin(current_time/800)*swingDistance
gpu_set_blendmode(bm_add)
draw_circle_color(x,y+swingDist,TILE_W,$FF09BDEF,c_black,false)
gpu_set_blendmode(bm_normal)
draw_sprite_ext(sprite_index,0,x,y+swingDist,1,1,swingRot,c_white,1)
