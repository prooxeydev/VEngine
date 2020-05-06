module render

import glfw
import gg
import gx
import gl
import freetype
import time

struct RenderManager {
	gg &gg.GG
	window &glfw.Window
	ft &freetype.FreeType
mut:
	width int
	height int
	scenes []&Scene
	scene int
	l int
	open bool
	title string
}

pub fn create_render_manager(width, height int, game_ptr, key_down voidptr, on_click voidptr, resize voidptr) &RenderManager {
	glfw.init_glfw()
	window := glfw.create_window(glfw.WinCfg{
		width: width
		height: height
		borderless: false
		title: ''
		ptr: game_ptr
		always_on_top: false
	})
	window.make_context_current()
	gg.init_gg()
	gg := gg.new_context(gg.Cfg{
		width: width
		height: height
		font_size: 20
		use_ortho: true
		window_user_ptr: 0
	})
	window.onkeydown(key_down)
	window.on_click(on_click)
	window.on_resize(resize)

	return &RenderManager{
		gg: gg
		window: window
		ft: 0
		scenes: []&Scene{}
		scene: -1
		l: -1
		width: width
		height: height
		open: false
		title: ''
	}
}

pub fn (manager mut RenderManager) open(ms int) {
	if manager.scene < 0 || manager.open {
		return
	}
	manager.open = true
	for {
		if manager.window.should_close() {
			manager.window.destroy()
			return
		}
		scene := manager.scenes[manager.scene]
		if manager.title != scene.title {
			manager.title = scene.title
			manager.window.set_title(manager.title)
		}
		gl.clear()
		gl.clear_color(scene.background_color_r, scene.background_color_g, scene.background_color_b, scene.background_color_a)
		manager.render()
		manager.window.swap_buffers()
		glfw.wait_events()
		time.sleep_ms(ms)
	}
}

pub fn (manager mut RenderManager) make_scene(title string) &Scene {
	manager.l += 1
	scene := create_scene(title, manager.l)
	manager.add_scene(scene)
	return scene
}

pub fn (manager mut RenderManager) add_scene(scene &Scene) {
	manager.scenes << scene
}

pub fn (manager mut RenderManager) remove_scene(scene &Scene) {
	manager.scenes = manager.scenes.filter(it.id != scene.id)
}

pub fn (manager mut RenderManager) change_scene(id int) {
	manager.scene = id
}

fn (manager mut RenderManager) render() {
	scene := manager.scenes[manager.scene]
	for component in scene.components {
		component.draw(manager.gg, manager.ft, manager.width, manager.height)
	}
}

fn (manager mut RenderManager) resize_v(width, height int) {
	manager.width = width
	manager.height = height
}