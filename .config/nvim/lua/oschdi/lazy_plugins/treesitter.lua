return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c", "cpp", "c_sharp", "lua", "vim", "vimdoc", "javascript", "html", "python", "typescript", "nix"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}