// 
//Controls
function cmdLEFT()	{	return (keyboard_check(vk_left) || keyboard_check(ord("A")))	}
function cmdRIGHT()	{	return (keyboard_check(vk_right) || keyboard_check(ord("D")))	}
function cmdUP()	{	return (keyboard_check(vk_up) || keyboard_check(ord("W")))		}
function cmdDOWN()	{	return (keyboard_check(vk_down) || keyboard_check(ord("S")))	}
function cmdRUN()	{	return (keyboard_check(vk_shift))	}
function cmdHOLD()	{	return (keyboard_check(vk_shift))	}
function cmdPICKUP(){	return (keyboard_check_pressed(vk_space))	}
function cmdSKIP()	{	return keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_escape) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_right) || mouse_check_button_pressed(mb_left)	}