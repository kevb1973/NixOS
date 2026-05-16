return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable the default nil_ls
        nil_ls = { enabled = false },

        -- Enable and configure nixd
        nixd = {
          cmd = { "nixd" },
          settings = {
            nixd = {
              -- Example common settings (customize as needed)
              nixpkgs = {
                expr = "import <nixpkgs> { }", -- or use a flake
              },
              formatting = {
                command = { "nixfmt" }, -- or alejandra
              },
              -- options = { ... } for NixOS/home-manager completions
            },
          },
        },
      },
    },
  },
}
