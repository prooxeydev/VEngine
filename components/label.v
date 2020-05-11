module components


import gg
import gx
import freetype
import time

pub struct Label {
mut:
	id int
	text string
	loc &Location
	components []&Component
	perc bool
	align int
	size int
	color gx.Color
}

pub fn label(x, y int, text string, perc bool, size int, color gx.Color, align int, components []&Component) &Label {
	return &Label{
		id: 1
		loc: &Location{ x: x, y: y }
		text: text
		color: color
		align: align
		size: size
		perc: perc
		components: components
	}
}

fn (label Label) add_size(width, height f32) {}
fn (label Label) refactor_size(new_width, new_height f32) {}
fn (label Label) refactor_size_by_ms(new_width, new_height f32, time int) {}

fn (label mut Label) set_loc(x, y int) {
	label.loc.x = x
	label.loc.y = y
}

pub fn (label mut Label) add_loc(x, y int) {
	label.loc.x += x
	label.loc.y += y
}

fn (label mut Label) add_component(component &Component) {
	label.components << component
}

fn (label mut Label) remove_component(component &Component) {
	mut data := []&Component{len: label.components.len-1, cap: label.components.len-1}
	for c in label.components {
		if ptr_str(c) != ptr_str(component) {
			data << c
		}
	}
	label.components = data
}

fn (label mut Label) get_component(id int) &Component {
	return label.components[id]
}

fn (label mut Label) get_id() int {
	return label.id
}

fn (label mut Label) perc() bool {
	return label.perc
}

fn (label mut Label) draw(gg &gg.GG, ft &freetype.FreeType, w, h f32) {
	mut x := label.loc.x
	//println(label.text)
	mut y := label.loc.y

	b := label.perc()

	if b {
		x = (x / 100) * w
		y = (y / 100) * h
	}

	println(x)
	println(y)

	ft.draw_text(1, 3, 'test', gx.TextCfg{
		align: label.align
		size: label.size
		color: label.color
	})

	for c in label.components {
		c.draw(gg, ft, w, h)
	}
}