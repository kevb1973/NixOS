-- You'll probably like this — suppress maximize events from all apps
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	match = { title = "^(floatingTerminal)$" },
	float = true,
	center = true,
	size = { "monitor_w * 0.6", "monitor_h * 0.6" },
})

-- imv floating image viewer
hl.window_rule({
	match = { title = "^(imv_floating)$" },
	float = true,
	center = true,
})

hl.window_rule({
	match = { class = "^(superproductivity)$" },
	workspace = "special:todonotes",
})

hl.window_rule({
	match = { class = "^(silverbullet)$" },
	workspace = "special:todonotes",
})

hl.window_rule({
	match = { class = "^(qalculate-gtk)$" },
	float = true,
	size = { "500", "200" },
	move = { "2050", "100" },
})

hl.window_rule({
	match = { class = "^(org.kde.kpat)$" },
	float = true,
	size = { "1150", "1250" },
	workspace = "special:kpat",
	-- move = { "2050", "100" },
})

hl.window_rule({
	match = { class = "^(spotify)$" },
	float = true,
	size = { "2400", "1392" },
	workspace = "special:spotify",
	-- move = { "2050", "100" },
})

hl.window_rule({
	match = { title = "^(Picture-in-Picture)$" },
	float = true,
	pin = true,
	no_initial_focus = true,
	size = { "600", "340" },
	move = { "1950", "1050" },
})

hl.window_rule({
	match = { class = "^(neovide)$" },
	workspace = "2",
})

hl.window_rule({
	match = { class = "^(kitty-session)$" },
	workspace = "2",
})
-- Workspace rules

hl.workspace_rule({
	workspace = "special:calc",
	on_created_empty = "qalculate-gtk",
})

hl.workspace_rule({
	workspace = "special:spotify",
	on_created_empty = "spotify",
})

hl.workspace_rule({
	workspace = "special:kpat",
	on_created_empty = "kpat",
})

hl.workspace_rule({
	workspace = "r[1-2]",
	layout = "scrolling",
})

hl.workspace_rule({
	workspace = "special:todonotes",
	layout = "scrolling",
})

-- Layer rules

hl.layer_rule({
	match = { namespace = "launcher" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "notifications" },
	blur = true,
	ignore_alpha = 0,
})
