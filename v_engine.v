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
	manager := render.create_render_manager(1280, 720, app, on_key_down, on_click, on_resize, update_mouse)
	app.manager = manager
	scene := manager.make_scene('test')
	component := components.simple_component(0, 0, 70, 70, false, gx.white, []&components.Component{})
	scene.add_component(component)
	s1 := manager.make_scene('test1')
	component1 := components.simple_component(0, 0, 30, 70, false, gx.green, []&components.Component{})
	s1.add_component(component1)
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

fn (app mut App) key_change(key, code, action, mods int) {
	println('Key: $key, Code: $code, Action: $action, Mods: $mods')
	component := app.manager.scenes[app.manager.scene].components[0]
	if action == 1 || action == 2 {
		if key == 262 {
			//Left
			component.add_loc(1, 0)
		}
		if key == 263 {
			//Right
			component.add_loc(-1, 0)
		}
		if key == 264 {
			//Top
			component.add_loc(0, 1)
		}
		if key == 265 {
			//Bottom
			component.add_loc(0, -1)
		}
	}
	if key == 93 {
		//Increase
		if action == 1 {
			component.refactor_size(140, 140)
		}
	}
	if key == 47 {
		//Decrease
		if action == 1 {
			component.refactor_size(70, 70)
		}
	}
	if key == 258 {
		if action == 1 {
			if app.manager.scene == 0 {
				app.manager.change_scene(1)
			} else {
				app.manager.change_scene(0)
			}
		}
	}
}

fn on_key_down(wnd voidptr, key, code, action, mods int) {
	mut app := &App(glfw.get_window_user_pointer(wnd))
	app.manager.keyboard_callback(key, code, action, mods)
	//app.key_change(key, code, action, mods)
}

fn on_click(wnd voidptr, button, action, mods int) {
	mut app := &App(glfw.get_window_user_pointer(wnd))
	app.manager.mouse_click_callback(button, action, mods)
}

fn on_resize(wnd voidptr, width, height int) {
//	app := &App(wnd)
//	app.manager.width = width
//	app.manager.height = height
}

fn update_mouse(wnd voidptr, x, y f64) {
	mut app := &App(glfw.get_window_user_pointer(wnd))
	app.manager.mouse_move_callback(x, y)
	app.manager.mouse.update_mouse(x, y)
}