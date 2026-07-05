return {
  "nvim-mini/mini.files",
  opts = function(_, opts)
    -- Override navigation to use arrow keys
    opts.mappings = opts.mappings or {}
    opts.mappings.go_in = "<Right>"
    opts.mappings.go_out = "<Left>"
    opts.mappings.go_in_plus = "<S-Right>" -- enter + close on file (optional)
    opts.mappings.go_out_plus = "<S-Left>" -- go out + trim (optional)
    opts.windows.width_preview = 70

    return opts
  end,

  config = function(_, opts)
    require("mini.files").setup(opts)

    -- Extra split keymaps (gs = horizontal, gv = vertical)
    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        -- Open split and make it the new target
        local new_target = vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
          vim.cmd(direction .. " split")
          return vim.api.nvim_get_current_win()
        end)
        MiniFiles.set_target_window(new_target)
      end

      vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        local buf_id = args.data.buf_id

        map_split(buf_id, "gs", "belowright horizontal")
        map_split(buf_id, "gv", "belowright vertical")
      end,
    })
  end,
}
