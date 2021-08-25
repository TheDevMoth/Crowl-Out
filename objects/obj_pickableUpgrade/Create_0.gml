/// @desc

// Inherit the parent event
event_inherited();

pick = function(){
	//Upgrade
	
	//Update inventory
	
	//set self for deletion
	instance_destroy()
	
	//return a struct containing the Item name, sprite index, and Item description
	return {
		name : itemName,
		sprite : sprite_index,
		description : itemDescription
	}
}