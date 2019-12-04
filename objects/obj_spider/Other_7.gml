/// @description Jump

if (state == spider.idle) {
	if (instance_exists(obj_player)) {
		xspeed = sign(obj_player.x - x) * max_speed;
		yspeed = -abs(xspeed * 2);
	}
	
	move(obj_solo);
	state = spider.jump;
}