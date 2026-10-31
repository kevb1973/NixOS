-- You'll probably like this — suppress maximize events from all apps
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
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
	move = { "1950", "200" },
})

hl.window_rule({
	match = { class = "^(neovide)$" },
	workspace = "special:scratch",
})

hl.window_rule({
	match = { class = "^(kitty-session)$" },
	workspace = "special:scratch",
})

-- Workspace rules

hl.workspace_rule({
	workspace = "r[1-2]",
	layout = "scrolling",
})

hl.workspace_rule({
	workspace = "special:todonotes",
	layout = "scrolling",
})

hl.workspace_rule({
	workspace = "special:scratch",
	layout = "scrolling",
})

-- Layer rules

hl.layer_rule({
	match = { namespace = "noctalia-bar-main" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "notifications" },
	blur = true,
	ignore_alpha = 0,
})

-- on_created_empty replacement
local workspace_programs = {
	["special:calc"] = { "qalculate-gtk", { float = true, size = { "500", "200" }, move = { "2050", "100" } } },
	["special:spotify"] = { "spotify", {} },
	["special:kpat"] = { "kpat", {} },
}
hl.on("workspace.created", function(ws)
	if not ws.is_empty then
		return
	end

	local program = workspace_programs[ws.name]
	if program == nil then
		return
	end

	local cmd, rules = table.unpack(program)
	-- shallow-copy the rules table so we can add the workspace to it
	local rules2 = {}
	for k, v in pairs(rules) do
		rules2[k] = v
	end
	rules2.workspace = ws.name .. " silent"
	-- run it!
	hl.exec_cmd(cmd, rules2)
end)
