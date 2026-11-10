-- kanagawa.nvim applies the theme in lua/plugins.lua (priority 1000).
-- Fallback if the plugin is missing or :colorscheme kanagawa-dragon fails.
local fallback = "habamax"
if vim.g.colors_name ~= "kanagawa-dragon" then
  local ok = pcall(vim.cmd.colorscheme, "kanagawa-dragon")
  if not ok then
    ok = pcall(vim.cmd.colorscheme, fallback)
    if not ok then
      vim.notify("Colorscheme 'kanagawa-dragon' and fallback '" .. fallback .. "' failed.", vim.log.levels.WARN)
      pcall(vim.cmd.colorscheme, "default")
    end
  end
end

-- main editor uses terminal background; floats stay on kanagawa's own
-- (opaque) NormalFloat/FloatBorder groups instead of a hardcoded override.
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
