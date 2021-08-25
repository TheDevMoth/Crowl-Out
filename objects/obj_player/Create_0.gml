/// @desc Set up variables and states

// Variables that control feel
moveAcc = 0.3
walkSpd = 1
runSpd = 3
pushSpd = 0.1
wallsCanPush = 1 //number of walls crow can push together
pushKnockbackMult = -4
pullBufferDistance = 6 //Minimum number of pixels between the player and the object behind them when pulling. to disallow players from half pulling
swingDistance = 2

// Variables used for logic
maxSpd = walkSpd
hspd = 0
vspd = 0
state = noone
pushDirection = noone
pullDirection = noone
pushCommand = noone
pullCommand = noone
wallsPushed = ds_list_create() //Objects being currently pushed by the player
heldPickableSpr = noone

/// ---- Functions ---- ///
push = function(){
	//Check for walls
	if(!instance_place(x+hsign_from_direction(pushDirection), y+vsign_from_direction(pushDirection), obj_wall)){
		ds_list_clear(wallsPushed)
		//Check for movable walls, if none are found it is an immovable wall
		var numWallsBeingPushed = instance_place_list(x+hsign_from_direction(pushDirection), y+vsign_from_direction(pushDirection), obj_movableWall, wallsPushed, false)
		if(numWallsBeingPushed <= wallsCanPush ){
			var pushable = true //pushable until proven otherwise
			for(var i = 0; i<numWallsBeingPushed; i+=1){
				pushable = (pushable && wallsPushed[|i].push(floor(wallsCanPush/numWallsBeingPushed), pushSpd*hsign_from_direction(pushDirection), pushSpd*vsign_from_direction(pushDirection)))
			}
			if(pushable){
				// TODO play sound
				x += pushSpd*hsign_from_direction(pushDirection)
				y += pushSpd*vsign_from_direction(pushDirection)
			}
		}
	}
}

pull = function(){
	//is space behind player empty
	if(place_free(x+hsign_from_direction(pullDirection)*pullBufferDistance, y+vsign_from_direction(pullDirection)*pullBufferDistance)){
		//if walls are pullable pull them
		var numWallsBeingPulled = ds_list_size(wallsPushed)
		if(numWallsBeingPulled <= wallsCanPush){
			for(var i = 0; i<numWallsBeingPulled; i+=1){
				var iwallPullable = wallsPushed[|i].push(floor(wallsCanPush/numWallsBeingPulled), pushSpd*hsign_from_direction(pullDirection), pushSpd*vsign_from_direction(pullDirection))
				//if the wall is blocked by something stop pulling it
				if (!iwallPullable){
					ds_list_delete(wallsPushed, i)
					//When an entry is deleted the next will take it's place. 
					//if this is not the last entry decrease i to do the same position again, and n to not go out of range
					if((i+1)<numWallsBeingPulled){
						i -= 1
						numWallsBeingPulled -= 1
					}
				}
			}
			//If all walls are blocked don't move
			if(ds_list_size(wallsPushed) != 0){
				// TODO play sound
				x += pushSpd*hsign_from_direction(pullDirection)
				y += pushSpd*vsign_from_direction(pullDirection)
			}
		}
	}
}

letGo = function(){
	x -= hsign_from_direction(pushDirection)
	y -= vsign_from_direction(pushDirection)
	vspd = pushKnockbackMult*pushSpd*vsign_from_direction(pushDirection)
	hspd = pushKnockbackMult*pushSpd*hsign_from_direction(pushDirection)
	pushDirection = noone
	pullDirection = noone
	pushCommand = noone
	pullCommand = noone
}
	
collect = function(itemID){
	//check Item type
	//if Upgrade create upgrade showoff object
	if(object_is_ancestor(itemID.object_index, obj_pickableUpgrade)){
		var showoffID = instance_create_layer(0,0,"Controllers",obj_showoff_upgrade)
		showoffID.initalize(itemID)
	//if collectable create collectable showoff object
	} else if(object_is_ancestor(itemID.object_index, obj_pickableCollectable)){
		var showoffID = instance_create_layer(0,0,"Controllers",obj_showoff_collectable)
		showoffID.initalize(itemID)
	} else {
		show_error("Pickable item not upgrade nor collectable", true)
	}
	
}

collect_end = function(){
	heldPickableSpr = noone
	state = free_state
}

/// ---- State code ---- ///
/// Free State ///
free_state = function(){
	//Input for movement
	if(cmdRUN())
		maxSpd = runSpd	
	else 
		maxSpd = walkSpd
	if(cmdRIGHT())	hspd += moveAcc
	if(cmdLEFT())	hspd -= moveAcc
	if(cmdUP())		vspd -= moveAcc
	if(cmdDOWN())	vspd += moveAcc

	//Slowing down
	vspd -= vspd/maxSpd*moveAcc
	hspd -= hspd/maxSpd*moveAcc
	//Snap speed to zero (since the above equation can go on to infinitiy)
	if(abs(vspd) < moveAcc/4) vspd = 0
	if(abs(hspd) < moveAcc/4) hspd = 0
	
	//Collision detection
	if(hspd != 0 && !place_free(x+roundout(hspd), y)){
		pushDirection = find_direction(hspd, "h")
		pushCommand = command_from_direction(pushDirection)
		hspd = 0
		vspd = 0
		state = push_state
	}
	if(vspd != 0 && !place_free(x, y+roundout(vspd))){
		pushDirection = find_direction(vspd, "v")
		pushCommand = command_from_direction(pushDirection)
		hspd = 0
		vspd = 0
		state = push_state
	}
	
	//Movement
	x += hspd
	y += vspd
}

/// Push State ///
push_state = function(){
	//Player starts holding the object
	if(cmdHOLD()){
		state = hold_state
		pullDirection = find_opposite_direction(pushDirection)
		pullCommand = command_from_direction(pullDirection)
	
	//Player still pushing
	} else if(pushCommand()) {
		push()
	//player let go of the object
	} else {
		state = free_state
		letGo()
	}
}

/// Hold State ///
hold_state = function(){
	if(cmdHOLD()){
		if (cmdPICKUP()){
			for(var i = 0; i<ds_list_size(wallsPushed); i++){
				if(object_is_ancestor(wallsPushed[|i].object_index, obj_pickable)){
					letGo()
					state = collect_state
					collect(wallsPushed[|i].object_index)
					heldPickableSpr = wallsPushed[|i].sprite_index
					ds_list_clear(wallsPushed)
					break
				}
			}
		} else if(pushCommand() && !pullCommand()){
			push()
		} else if (pullCommand()){
			pull()
		}
		
	//Player let go
	} else {
		state = free_state
		letGo()
	}
}

/// Collect State ///
collect_state = function(){
	//No input just showing off the item
}

state = free_state