/// @desc Apply upgrade and save info
disappearing = false
disappearTime = 2 //seconds
drawAlpha = 1
initalized = false

initalize = function(itemID){
	var itemStruct = itemID.pick()
	name = itemStruct.name
	sprite = itemStruct.sprite
	description = itemStruct.description
	
	initalized = true
}
