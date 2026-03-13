shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	if ((UV.x <= 0.1) || (UV.x >= 0.9) || (UV.y <= 0.1) || (UV.y >= 0.9)) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
