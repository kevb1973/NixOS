-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat({ "nix" }, false)
set_autoformat({ "fish" }, true)
set_autoformat({ "lua" }, true)
set_autoformat({ "yaml" }, true)
