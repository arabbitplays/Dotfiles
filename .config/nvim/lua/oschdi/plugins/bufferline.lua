vim.opt.termguicolors = true
local bufferline = require('bufferline')
require("bufferline").setup{
  options = {
    mode = "buffers",
    --style_preset =  bufferline.style_preset.slope,
    separator_style = "slope",
    indicator = {
      style = 'underline'
    },
    diagnostics = "nvim-lsp",
    offset = {
      filetype = "neo-tree",
      text = "File Explorer",
      text_align = "center",
      separator = true
    },
    color_icons = true,
    show_duplicate_prefix = true
  }
}
