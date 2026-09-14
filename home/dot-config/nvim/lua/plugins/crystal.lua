-- lua/plugins/crystal.lua
return {
  "LolsonX/crystal.nvim",
  dependencies = {
    "mfussenegger/nvim-lint",
    "stevearc/conform.nvim",
    "nvim-treesitter/nvim-treesitter",
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    require("crystal-nvim").setup()
  end,
}
