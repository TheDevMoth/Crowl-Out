// 
function find_direction(speed,hORv){
	if(hORv == "h"){
		if(speed == 0){
			return noone
		} else if (speed>0){
			return RIGHT
		} else {
			return LEFT
		}	
	} else if (hORv == "v"){
		if(speed == 0){
			return noone
		} else if (speed>0){
			return DOWN
		} else {
			return UP
		}
	} else {
		show_debug_message("DUDE H OR V")
		return noone
	}
}

function sign_from_direction(direction){
	switch(direction){
		case(UP):
			return -1
		break
		case(RIGHT):
			return 1
		break
		case(DOWN):
			return 1
		break
		case(LEFT):
			return -1
		break
		case(noone):
			return 0
		break
	}
}

//Return the sign of vspd if the object is moving in this direction
function vsign_from_direction(direction){
	switch(direction){
		case(UP):
			return -1
		break
		case(RIGHT):
			return 0
		break
		case(DOWN):
			return 1
		break
		case(LEFT):
			return 0
		break
		default:
			show_error("In vsign_from_direction() \nError: Direction undefined.",true)
		break
	}
}
//Return the sign of hspd if the object is moving in this direction
function hsign_from_direction(direction){
	switch(direction){
		case(UP):
			return 0
		break
		case(RIGHT):
			return 1
		break
		case(DOWN):
			return 0
		break
		case(LEFT):
			return -1
		break
		default:
			show_error("In hsign_from_direction() \nError: Direction undefined.",true)
		break
	}
}

//Given the direction returns the command for that direction
function command_from_direction(direction){
	switch(direction){
		case(UP):
			return function(){return cmdUP()}
		break
		case(RIGHT):
			return function(){return cmdRIGHT()}
		break
		case(DOWN):
			return function(){return cmdDOWN()}
		break
		case(LEFT):
			return function(){return cmdLEFT()}
		break
		default:
			show_error("In find_command_from_direction() \nError: Direction undefined", true)
	}
}