// 
//Controls
function cmdLEFT()	{	return (keyboard_check(vk_left) || keyboard_check(ord("A")))	}
function cmdRIGHT()	{	return (keyboard_check(vk_right) || keyboard_check(ord("D")))	}
function cmdUP()	{	return (keyboard_check(vk_up) || keyboard_check(ord("W")))		}
function cmdDOWN()	{	return (keyboard_check(vk_down) || keyboard_check(ord("S")))	}
function cmdRUN()	{	return (keyboard_check(vk_shift))	}
function cmdHOLD()	{	return (keyboard_check(vk_shift))	}
function cmdPICKUP(){	return (keyboard_check(vk_space))	}
