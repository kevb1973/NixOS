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
              nixpkgs = {
                expr = "import <nixpkgs> { }",
              },
              formatting = {
                command = { "nixfmt" },
              },
            },
          },
        },

        -- Configure taplo TOML formatting (align table entries)
        taplo = {
          settings = {
            evenBetterToml = {
              formatter = {
                alignEntries = true,
              },
            },
          },
        },
      },
    },
  },
}
