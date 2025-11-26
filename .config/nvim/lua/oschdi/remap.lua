local which_key = require("which-key")
local builtin = require('telescope.builtin')

which_key.add({
  { "<leader>f", group = "Find" },
  { "<leader>ff", builtin.find_files, desc = "Find files" },
  { "<leader>fg", builtin.git_files, desc = "Find git files" },
  { "<leader>fl", builtin.live_grep, desc = "Live grep" },
  { "<leader>fb", builtin.buffers, desc = "Find buffers" },
})

-- saving in all modes
vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>', { silent = true })
vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>', { silent = true })

-- searching in file
vim.keymap.set({'n', 'i'}, '<C-f>', '/\\', { silent = true })

-- word wise movement
vim.keymap.set({'n', 'v'}, 'w', 'b', { silent = true })

-- buffer movement
vim.keymap.set('n', 'J', ':bp<CR>', { silent = true })
vim.keymap.set('n', 'K', ':bn<CR>', { silent = true })

-- buffer deletions
which_key.add({
  {"<leader>d", group = "Close buffers"},
  {"<leader>dd", ":bd<CR>", { desc = "Close current buffer"}}, 
  {"<leader>da", ":%bd<CR>", { desc = "Close [a]ll buffers"}},
  {"<leader>de", ":bd|edit<CR>", { desc = "Close all [e]xcept current buffer"}}
})

-- lsp
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show LSP error under cursor" })

-- git
vim.keymap.set('n', '<leader>g', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = "Toggle lazygit" })
