/// @desc Set up
//Pick a random sprite
if(sprite = noone){
	sprite = choose(spr_obstacle1,spr_obstacle2,spr_obstacle3,spr_obstacle4,spr_obstacle5)
}
sprite_index = sprite

function push(wallsPushed, vdist, hdist){
	//check if player can push this many walls
	if(wallsPushed == 0){
		
		return false
	}
	
	//Check for walls
	if(!place_free(x+roundout(hdist), y+roundout(vdist))){
		var pushedWall = instance_place(x+roundout(hdist), y+roundout(vdist), obj_movableWall)
		//Movable wall
		if(pushedWall != noone){
			var pushable = pushedWall.push(wallsPushed-1, vdist, hdist)
			if (!pushable){
				return false
			}
		//Immovable wall
		} else {
			return false
		}
	}
	x+=hdist
	y+=vdist
	//alarm[0] = 10
	return true
}