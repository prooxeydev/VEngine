module input

struct Mouse {
mut:
	x f64
	y f64
}

pub fn create_mouse(x, y int) &Mouse {
	return &Mouse{
		x: x
		y: y
	}
}

pub fn (mouse mut Mouse) update_mouse(x, y f64) {
	mouse.x = x
	mouse.y = y
}