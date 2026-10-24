hl.config({
	input = {
		kb_layout = "us",

		numlock_by_default = true,
		repeat_rate = 25,
		repeat_delay = 600,

		follow_mouse = 1,

		-- sensitivity = -0.13, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
			scroll_factor = 1.0,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.bind("F10", hl.dsp.exec_cmd("wlrctl pointer move 2560 1440"))
