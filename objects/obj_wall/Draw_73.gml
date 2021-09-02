/// @desc Show Collision Boxes
if(global.showCollisionBox){
	draw_set_alpha(0.5)
	draw_set_color($FF3B71E5)
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	draw_set_alpha(1)
	draw_set_color(c_white)
}