module main

import render
import time
import components
import gx
import glfw

struct App{
mut:
	manager &render.RenderManager
	key_down bool
	animate bool
}

fn main() {
	app := &App{
		manager: 0
		key_down: false
		animate: false
	}
	manager := render.create_render_manager(1280, 720, app, on_key_down, on_click, on_resize)
	app.manager = manager
	scene := manager.make_scene('test')
	component := components.simple_component(0, 0, 70, 70, true, gx.white, []&components.Component{})
	scene.add_component(component)
	manager.change_scene(0)
	go app.run(component)
	manager.open(14)
}

fn (app mut App) run(component &components.SimpleComponent) {
	for {
		if app.key_down {
			if !app.animate {
				app.animate = true
				component.refactor_size(90, 90)
			}
		}
	}
}

fn on_key_down(wnd voidptr, key, code, action, mods int) {

}

fn on_click(wnd voidptr, button, action, mods int) {

}

fn on_resize(wnd voidptr, width, height int) {
//	app := &App(wnd)
//	app.manager.width = width
//	app.manager.height = height
}