module components

import gg
import gx
import freetype
import time

type Component = SimpleComponent

pub struct SimpleComponent {
mut:
	id int
	loc &Location
	components []&Component
	width f32
	height f32
	perc bool
	color gx.Color
}

pub fn simple_component(x, y, width, height f32, perc bool, color gx.Color, components []&Component) &SimpleComponent {
	return &SimpleComponent{
		id: 0
		loc: &Location{x: x, y: y}
		width: width
		height: height
		perc: perc
		color: color
		components: components
	}
}

fn (component mut SimpleComponent) set_loc(x, y int) {
	component.loc.x = x
	component.loc.y = y
}

fn (component mut SimpleComponent) add_loc(x, y int) {
	component.loc.x += x
	component.loc.y += y
}

pub fn (component mut SimpleComponent) add_size(width, height f32) {
	component.refactor_size(component.width + width, component.height + height)
}

pub fn (component mut SimpleComponent) refactor_size(new_width, new_height f32) {
	component.refactor_size_by_ms(new_width, new_height, 500)
}

pub fn (component mut SimpleComponent) refactor_size_by_ms(new_width, new_height f32, time int) {
	d_w := (new_width - component.width) / (time / 14)
	d_h := (new_height - component.height) / (time / 14)
	go component.animate_size_change(d_w, d_h, time / 14, 0)
}

fn (component mut SimpleComponent) animate_size_change(d_w, d_h f32, t, i int) {
	component.width += d_w
	component.height += d_h
	time.sleep_ms(14)
	if t != i {
		component.animate_size_change(d_w, d_h, t, i + 1)
	}
}

pub fn (component mut SimpleComponent) add_component(comp &Component) {
	component.components << comp
}

pub fn (component mut SimpleComponent) remove_component(comp Component) {
	mut data := []&Component{len: component.components.len-1, cap: component.components.len-1}
	for c in component.components {
		if c.get_id() != comp.get_id() {
			data << c
		}
	}
	component.components = data
}

pub fn (component mut SimpleComponent) get_component(id int) &Component {
	return component.components[id]
}

pub fn (component mut SimpleComponent) get_id() int {
	return component.id
}

pub fn (component mut SimpleComponent) draw(gg &gg.GG, ft &freetype.FreeType, w, h f32) {
	mut x := component.loc.x
	mut y := component.loc.y
	mut width := component.width
	mut height := component.height

	if component.perc {

		x = (x / 100) * w
		y = (y / 100) * h
		width = (width / 100) * w
		height = (height / 100) * h
	}

	gg.draw_rect(x, y, width, height, component.color)
	
	for comp in component.components {
		comp.draw(gg, ft, width, height)
	}
}