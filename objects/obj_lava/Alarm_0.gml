/// @description create little lava particles
with (instance_create_layer(x + random(sprite_width) - 6, y - 4 - sprite_height / 2, "Lava", obj_particle)) {
	image_blend = c_yellow;
}

alarm[0] = random_range(10, 20);