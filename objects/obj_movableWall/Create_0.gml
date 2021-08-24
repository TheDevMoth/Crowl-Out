/// @desc Set up
//Pick a random sprite
//sprite_index = sprite
solid = true
wallsBeingPushed = ds_list_create()


push = function(wallsCanPush, hdist, vdist){
	//check if player can push this many walls
	if(wallsCanPush == 0){
		return false
	}
	
	//Check for walls
	if(!place_free(x+sign(hdist), y+sign(vdist))){
		//Check for movable walls
		ds_list_clear(wallsBeingPushed)
		var numWallsInTheWay = instance_place_list(x+sign(hdist), y+sign(vdist), obj_movableWall, wallsBeingPushed, false)
		if(numWallsInTheWay != 0 && numWallsInTheWay <= wallsCanPush){
			var pushable = true //pushable until proven otherwise
			for(var i = 0; i<numWallsInTheWay; i+=1){
				pushable = (pushable && wallsBeingPushed[|i].push(floor((wallsCanPush-1)/numWallsInTheWay), hdist, vdist))
			}
			if(pushable){
				//Success
				x += hdist
				y += vdist
				alarm[0] = 6
				return true
			} //Case further walls can not move
		} //Case too many walls infront of it or 0 meaning immovable wall
	} else {
		//Case nothing in the way
		x += hdist
		y += vdist
		alarm[0] = 6
		return true
	}
	
	return false
	
}