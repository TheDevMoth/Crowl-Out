/// @desc Show Collision Box
if(global.showCollisionBox){
	draw_set_alpha(0.5)
	draw_set_color($FF3CB878)
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false)
	draw_set_alpha(1)
	draw_set_color(c_white)
}