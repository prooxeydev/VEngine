module input

struct Keyboard {
pub mut:
	l_ctr bool
	r_ctr bool
	alt bool
	alt_gr bool
	l_shift bool
	r_shift bool
	caps bool
}

pub fn create_keyboard() &Keyboard {
	return &Keyboard{}
}