require('neo-tree').setup({
    close_if_last_window = true,
    filesystem = {
        filtered_items = {
            visible = true,       -- show hidden files
            hide_dotfiles = false, -- do not hide dotfiles
            hide_gitignored = true, -- optional: still hide gitignored files
        },
    },
    window = {
        mappings = {
            o = function(state)
                local node = state.tree.get_node()
                local path = node.path
                vim.fn.jobstart({ "xdg-open". path }, { detach = true })
            end,
        },
    },
})

vim.keymap.set('n', '<leader>n', ':Neotree toggle<CR>', { silent = true })

