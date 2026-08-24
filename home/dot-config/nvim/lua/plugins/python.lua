return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- mason = false tells LazyVim NOT to auto-install via Mason.
        -- nvim-lspconfig will still configure the server, using
        -- the `pyright-langserver` binary found on $PATH (from nixpkgs).
        pyright = {
          mason = false,
          settings = {
            python = {
              pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
            },
          },
        },
        -- Same for Ruff — use the nixpkgs binary, not Mason's.
        ruff = {
          mason = false,
        },
      },
    },
  },
}
