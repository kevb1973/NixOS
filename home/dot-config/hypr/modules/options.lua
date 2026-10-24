hl.config({
	general = {
		col = {
			active_border = "rgb(ebdbb2)",
			inactive_border = "rgb(272727)",
		},

		gaps_in = 4,
		gaps_out = 7,

		border_size = 2,
	},

	decoration = {
		rounding = 0,

		blur = {
			enabled = true,
			size = 10,
			passes = 3,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		force_default_wallpaper = 0,
		key_press_enables_dpms = true,
		mouse_move_enables_dpms = true,
	},

	scrolling = {
		column_width = 1.0,
	},

	xwayland = {
		-- expose physical resolution to X11 apps (games under muvm/FEX)
		force_zero_scaling = true,
	},
})
