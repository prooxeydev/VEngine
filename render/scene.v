module render

import components
import gx


struct Scene {
	id int
mut:
	components []&components.Component
	title string
	background_color_r int
	background_color_g int
	background_color_b int
	background_color_a int
}

pub fn create_scene(title string, id int) &Scene {
	return &Scene{
		id: id
		components: []&components.Component{}
		title: title
	}
}

pub fn (scene mut Scene) add_component(component &components.Component) {
	scene.components << component
}