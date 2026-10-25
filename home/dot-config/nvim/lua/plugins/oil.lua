return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>o", "<CMD>Oil<CR>", desc = "Open Oil" },
  },
  opts = {
    default_file_explorer = false,
    skip_confirm_for_simple_edits = true,
    view_options = {
      sort = { { "name", "asc" } },
    },
  },
}
