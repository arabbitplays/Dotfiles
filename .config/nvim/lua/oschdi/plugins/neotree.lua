require('neo-tree').setup({
	close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,       -- show hidden files
      hide_dotfiles = false, -- do not hide dotfiles
      hide_gitignored = true, -- optional: still hide gitignored files
    },
  },
})

vim.keymap.set('n', '<leader>n', ':Neotree toggle<CR>', { silent = true })

