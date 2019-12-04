/// @description Execute the state

switch (state) {
	#region Bat idle
	case bat.idle :
		iamge_index = spr_bat_idle;
		if (instance_exists(obj_player)) {
			var dis = point_distance(x, y, obj_player.x, obj_player.y);
			
			if (dis < sight) {
				state = bat.chase;
			}
		}
	break;
	#endregion
	
	#region Bat chase 
	case bat.chase:
		if (instance_exists(obj_player)) {
			var dir = point_direction(x, y, obj_player.x, obj_player.y);
			
			xspeed = lengthdir_x(max_speed, dir);
			yspeed = lengthdir_y(max_speed, dir);
			sprite_index = spr_bat_fly;
			
			if (xspeed != 0) {
				image_xscale = sign(xspeed);	
			}
			
			move(obj_solo);
		}
	break;
	#endregion
}