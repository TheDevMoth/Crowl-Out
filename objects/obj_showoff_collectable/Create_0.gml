/// @desc Apply upgrade and save info
transitionTime = 0.25 //time for the notification to slide in (out is double it)
disappearTime = 2 //seconds
initalized = false
frame = -1
maxFrame = floor(transitionTime*fps) //for in transition

initalize = function(itemID){
	var itemStruct = itemID.pick()
	name = itemStruct.name
	sprite = itemStruct.sprite
	
	frame = 0
	initalized = true
}
