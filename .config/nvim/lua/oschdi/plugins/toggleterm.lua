require("toggleterm").setup{
  open_mapping = [[<c-t>]],
}

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "curved",
  },
})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end
