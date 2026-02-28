---@diagnostic disable: undefined-global

swayimg.imagelist.enable_adjacent(true)

swayimg.viewer.set_window_background(0xff24273a)
swayimg.viewer.set_image_background(0xff24273a)
swayimg.viewer.enable_loop(false)

swayimg.slideshow.set_window_background(0xff24273a)
swayimg.slideshow.set_image_background(0xff24273a)

swayimg.gallery.set_thumb_size(300)
swayimg.gallery.set_window_color(0xff24273a)
swayimg.gallery.set_border_color(0xffb7bdf8)
swayimg.gallery.set_unselected_color(0xff24273a)

swayimg.text.hide()

swayimg.viewer.on_key("q", function() swayimg.exit() end)
swayimg.gallery.on_key("q", function() swayimg.exit() end)

swayimg.viewer.on_key("Right", function() swayimg.viewer.switch_image("next") end)
swayimg.viewer.on_key("Left", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("Up", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("Down", function() swayimg.viewer.switch_image("next") end)

swayimg.viewer.on_key("l", function() swayimg.viewer.switch_image("next") end)
swayimg.viewer.on_key("h", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("k", function() swayimg.viewer.switch_image("prev") end)
swayimg.viewer.on_key("j", function() swayimg.viewer.switch_image("next") end)

swayimg.gallery.on_key("l", function() swayimg.gallery.switch_image("right") end)
swayimg.gallery.on_key("h", function() swayimg.gallery.switch_image("left") end)
swayimg.gallery.on_key("k", function() swayimg.gallery.switch_image("up") end)
swayimg.gallery.on_key("j", function() swayimg.gallery.switch_image("down") end)
