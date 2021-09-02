/// @desc
if(state != hold_state){
	if(cmdRIGHT()){
		image_xscale=-1
	} else if(cmdLEFT()) {
		image_xscale=1
	}
}

//Choose sprite according to state
//if(pushDirection==UP && state == push_state){
//	sprite_index = spr_crow_push //TODO add Up animation
//} else if(pushDirection==DOWN && state == push_state){
//	sprite_index = spr_crow_push //TODO add Down animation
//} else 
if(state == push_state){
	sprite_index = spr_crow_push
} else if(state == hold_state){
	if(pushCommand() && !pullCommand()){
		sprite_index = spr_crow_push
	} else if(pullCommand() && !pushCommand()){
		sprite_index = spr_crow_pull
	} else {
		sprite_index = spr_crow_hold
	}
} else if(state = collect_state){
	sprite_index = spr_ph_crow_show
	//Draw the item
	if(drawHalo){
		gpu_set_blendmode(bm_add)
		draw_circle_color(x,y-sprite_height*2,TILE_W,$FF09BDEF,c_black,false)
		gpu_set_blendmode(bm_normal)
	}
	draw_sprite_ext(heldPickableSpr,0,x,y-sprite_height*2,1,1,0,c_white,1)
	
} else if(hspd != 0 || vspd != 0){
	sprite_index = spr_crow_walk
} else { 
	sprite_index = spr_crow_idle
}

draw_self()

