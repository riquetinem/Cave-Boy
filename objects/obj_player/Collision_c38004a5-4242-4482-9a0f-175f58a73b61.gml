/// @description Colliding with an enemy

//Check if we'ew above them 
var above_enemy = y < other.y + yspeed;
var falling = yspeed > 0;

if (above_enemy && (falling || state == player.ledge_grab)) {
	//Keep player above the enemy
	if (!place_meeting(x, yprevious, obj_solo)) {
		y = yprevious;
	}
	
	//Get as close to the enemy as possible
	while (!place_meeting(x, y, other)) {
		y++;	
	}
	
	with (other) {
		instance_destroy()	;
	}
	
	//Bounce off the enemy
	yspeed = -(16 / 3);
	audio_play_sound(a_step, 6, false);
} else {
	
}