 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#d4f1f7',
    base01 = '#c3ebf3',
    base02 = '#bbe8f2',
    base03 = '#688e96',
    base04 = '#555c5e',
    base05 = '#181a1b',
    base06 = '#181a1b',
    base07 = '#181a1b',
    base08 = '#fd4663',
    base09 = '#2c1a85',
    base0A = '#1a3d85',
    base0B = '#187487',
    base0C = '#2a1980',
    base0D = '#177082',
    base0E = '#193b80',
    base0F = '#1f4dad',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- telescope.nvim
  hi('TelescopeNormal',         { fg = '#181a1b',          bg = '#d4f1f7' })
  hi('TelescopeBorder',         { fg = '#688e96',             bg = '#d4f1f7' })
  hi('TelescopePromptNormal',   { fg = '#181a1b',          bg = '#d4f1f7' })
  hi('TelescopePromptBorder',   { fg = '#688e96',             bg = '#d4f1f7' })
  hi('TelescopePromptPrefix',   { fg = '#187487',             bg = '#d4f1f7' })
  hi('TelescopePromptCounter',  { fg = '#555c5e',  bg = '#d4f1f7' })
  hi('TelescopePromptTitle',    { fg = '#d4f1f7',             bg = '#187487' })
  hi('TelescopePreviewTitle',   { fg = '#d4f1f7',             bg = '#1a3d85' })
  hi('TelescopeResultsTitle',   { fg = '#d4f1f7',             bg = '#2c1a85' })
  hi('TelescopeSelection',      { fg = '#181a1b',          bg = '#bbe8f2' })
  hi('TelescopeSelectionCaret', { fg = '#187487',             bg = '#bbe8f2' })
  hi('TelescopeMatching',       { fg = '#187487',             bold = true })

  -- mini.pick
  hi('MiniPickNormal',         { fg = '#181a1b',          bg = '#d4f1f7' })
  hi('MiniPickBorder',         { fg = '#688e96',             bg = '#d4f1f7' })
  hi('MiniPickPrompt',   { fg = '#181a1b',          bg = '#d4f1f7' })
  hi('MiniPickPromptPrefix',   { fg = '#187487',             bg = '#d4f1f7' })
  hi('MiniPickBorderText',    { fg = '#d4f1f7',             bg = '#187487' })
  hi('MiniPickMatchCurrent',      { fg = '#181a1b',          bg = '#bbe8f2' })
  hi('MiniPickPromptCaret', { fg = '#187487',             bg = '#bbe8f2' })
  hi('MiniPickMatchRanges',       { fg = '#187487',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
