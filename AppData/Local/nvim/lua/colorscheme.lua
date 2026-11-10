-- github-nvim-theme applies the theme in lua/plugins.lua (priority 1000).
-- Fallback if the plugin is missing or :colorscheme github_dark_default fails.
local theme = "github_dark_default"
local fallback = "habamax"
if vim.g.colors_name ~= theme then
  local ok = pcall(vim.cmd.colorscheme, theme)
  if not ok then
    ok = pcall(vim.cmd.colorscheme, fallback)
    if not ok then
      vim.notify("Colorscheme '" .. theme .. "' and fallback '" .. fallback .. "' failed.", vim.log.levels.WARN)
      pcall(vim.cmd.colorscheme, "default")
    end
  end
end

-- main editor uses the terminal background (also GitHub Dark #0d1117);
-- floats keep the theme's own opaque NormalFloat/FloatBorder groups.
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
