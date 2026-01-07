-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Move to window using the <ctrl> arrow keys
map("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window
map("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Switch tabs with <ctrl> left/right
map("n", "<S-Left>", "[b", { desc = "Previous Buffer", remap = true })
map("n", "<S-Right>", "]b", { desc = "Next Buffer", remap = true })

-- Move selection with mini.move
map({ "n", "v" }, "<A-Up>", "<A-k>", { desc = "Move Selection Up", remap = true })
map({ "n", "v" }, "<A-Down>", "<A-j>", { desc = "Move Selection Down", remap = true })
map({ "n", "v" }, "<A-Left>", "<A-h>", { desc = "Move Selection Left", remap = true })
map({ "n", "v" }, "<A-Right>", "<A-l>", { desc = "Move Selection Right", remap = true })

-- Diff with buffer
map(
  "n",
  "<leader>df",
  "<cmd>vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis<cr>",
  { desc = "Diff buffer with file", remap = true }
)

-- Alternate quit shortcut (easy save/quit with C-s, C-q)
map("n", "<C-q>", "<cmd>qa<cr>", { desc = "Quit All", remap = true })
