local vars = require("modules.vars")
local terminal = vars.terminal

hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SHIFT + Return", hl.dsp.exec_cmd("strata"))
hl.bind("SUPER + KP_Multiply", hl.dsp.workspace.toggle_special("calc"))
hl.bind("SUPER + code:87", hl.dsp.workspace.toggle_special("spotify"))
hl.bind("SUPER + code:88", hl.dsp.workspace.toggle_special("kpat"))
hl.bind(
	"SUPER + ALT + Return",
	hl.dsp.exec_cmd(terminal .. " --app-id=kitty-session --session ~/.config/kitty/default.kitty-session")
)
hl.bind("SUPER + grave", hl.dsp.workspace.toggle_special("scratch"))
hl.bind("SUPER + SHIFT + grave", hl.dsp.window.move({ workspace = "special:scratch" }))
hl.bind("SUPER + SPACE", hl.dsp.workspace.toggle_special("todonotes"))

hl.bind("SUPER + SHIFT + X", hl.dsp.window.close())
-- hl.bind("SUPER + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + X", hl.dsp.layout("togglesplit")) -- dwindle

-- Move focus with mainMod + h/j/k/l
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "down" }))

-- Swap windows with mainMod + SHIFT + h/j/k/l
-- TODO(investigate): This is a conflict with moveactive binds below
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.swap({ direction = "left" }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.swap({ direction = "down" }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.swap({ direction = "up" }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "right" }))

-- Move floating windows with mainMod + SHIFT + h/j/k/l
-- hl.bind("SUPER + SHIFT + h", hl.dsp.window.move({ x = -15, y = 0, relative = true }), { repeating = true })
-- hl.bind("SUPER + SHIFT + j", hl.dsp.window.move({ x = 0, y = 15, relative = true }), { repeating = true })
-- hl.bind("SUPER + SHIFT + k", hl.dsp.window.move({ x = 0, y = -15, relative = true }), { repeating = true })
-- hl.bind("SUPER + SHIFT + l", hl.dsp.window.move({ x = 15, y = 0, relative = true }), { repeating = true })

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Tab between last and current workspace
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "previous" }))

-- Resize active window
-- hl.bind("SUPER + code:20", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { repeating = true })
-- hl.bind("SUPER + code:21", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { repeating = true })
-- hl.bind("SUPER + SHIFT + code:20", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { repeating = true })
-- hl.bind("SUPER + SHIFT + code:21", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { repeating = true })
hl.bind("SUPER + Minus", hl.dsp.layout("colresize -conf"))
hl.bind("SUPER + Equal", hl.dsp.layout("colresize +conf"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Maximize / Fullscreen
hl.bind("SUPER + BackSpace", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
