local servers = {}

servers.lua_ls = {
    settings = {
        Lua = {
            formatters = {
                ignoreComments = true,
            },
            signatureHelp = { enabled = true },
            diagnostics = {
                globals = { 'nixCats' },
                disable = { 'missing-fields' },
            },
        },
        telemetry = { enabled = false },
    },
    filetypes = { 'lua' },
}
 
-- This is this flake's version of what kickstarter has set up for mason handlers.
-- This is a convenience function that calls lspconfig on the LSPs we downloaded via nix
-- This will not download your LSP --- Nix does that.

--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--  All of them are listed in https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
--  You may do the same thing with cmd
 
servers.clangd = {
  cmd = {
    "clangd",
    "--query-driver=**",
    "--background-index",
    "--clang-tidy",
  },
}

local function on_attach(_, bufnr)
-- we create a function that lets us more easily define mappings specific
-- for LSP related items. It sets the mode, buffer and description for us each time.

    local nmap = function(keys, func, desc)
        if desc then
        desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    vim.keymap.set("n", "<leader>ci", function()
      vim.lsp.buf.code_action({
        filter = function(action)
          return action.kind == "quickfix"
              or action.kind == "refactor"
        end,
      })
    end, { desc = "LSP: Implement declaration" })

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('<leader>k', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nixCats-lsp-attach', { clear = true }),
    callback = function(event)
        on_attach(vim.lsp.get_client_by_id(event.data.client_id), event.buf)
    end
})



-- tell LSPs that there is the cmp capability
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
vim.lsp.config('*', { capabilities = capabilities })

-- call lsp config with all the serverss
for server_name, cfg in pairs(servers) do
    vim.lsp.config(server_name, cfg)
    vim.lsp.enable(server_name)
end
