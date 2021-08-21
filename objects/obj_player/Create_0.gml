/// @desc Set up
// Variables that control feel
moveAcc = 0.3
walkSpd = 1
runSpd = 3
pushSpd = 0.1
wallsCanPush = 2 //number of walls crow can push together
pushKnockbackMult = -6

// Variables used for logic
maxSpd = walkSpd
hspd = 0
vspd = 0
state = noone
pushDirection = noone
wallsPushed = ds_list_create() //Objects being currently pushed by the player

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
	if(!place_free(x+roundout(hspd), y)){
		//x = trunc(x) //FIX assumes maxSpd = 1
		pushDirection = find_direction(hspd, "h")
		pushCommand = command_from_direction(pushDirection)
		hspd = 0
		vspd = 0
		state = push_state
	}
	if(!place_free(x, y+roundout(vspd))){
		//y = trunc(y) //FIX assumes maxSpd = 1
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
		//TODO Figure out what comes here
	
	//Player still pushing
	} else if(pushCommand()) {
		//Check for immovable walls if not found check for movable walls
		if(!instance_place(x+hsign_from_direction(pushDirection), y+vsign_from_direction(pushDirection), obj_wall)){
			ds_list_clear(wallsPushed)
			var numWallsBeingPushed = instance_place_list(x+hsign_from_direction(pushDirection), y+vsign_from_direction(pushDirection), obj_movableWall, wallsPushed, false)
			if(numWallsBeingPushed <= wallsCanPush ){
				var pushable = true //pushable until proven otherwise
				for(var i = 0; i<numWallsBeingPushed; i+=1){
					pushable = (pushable && wallsPushed[|i].push(floor(wallsCanPush/numWallsBeingPushed), pushSpd*vsign_from_direction(pushDirection), pushSpd*hsign_from_direction(pushDirection)))
				}
				if(pushable){
					// TODO play sound
					x += pushSpd*hsign_from_direction(pushDirection)
					y += pushSpd*vsign_from_direction(pushDirection)
				}
			}
		}
	//player let go of the object
	} else {
		state = free_state
		vspd = pushKnockbackMult*pushSpd*vsign_from_direction(pushDirection)
		hspd = pushKnockbackMult*pushSpd*hsign_from_direction(pushDirection)
		pushDirection = noone
	}
}

/// Hold State ///
hold_state = function(){
	
}

state = free_state