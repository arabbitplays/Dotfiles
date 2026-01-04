require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm",                  -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  transparent = true,               -- Enable this to disable setting the background color
  terminal_colors = true,           -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = false },
    keywords = { italic = false },
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark",             -- style for sidebars, see below
    floats = "dark",               -- style for floating windows
  },
})

require("gruvbox").setup({
    terminal_colors = true,
    transparent_mode = true,
    inverse = true
})

local theme_file = vim.fn.expand("~/.config/nvim/current-theme")

local theme_map = {
  tokyo = "tokyonight-storm",
  forest = "gruvbox",
}

local function apply_theme()
  local f = io.open(theme_file, "r")
  if not f then
    return
  end

  local theme = f:read("*l")
  f:close()

  local colorscheme = theme_map[theme]
  if colorscheme then
    vim.cmd.colorscheme(colorscheme)
  end
end

-- Apply on startup
apply_theme()


local uv = vim.loop
local theme_watcher = nil

local function watch_theme_file()
  theme_watcher = uv.new_fs_event()
  theme_watcher:start(theme_file, {}, vim.schedule_wrap(function()
    apply_theme()
  end))
end

watch_theme_file()

