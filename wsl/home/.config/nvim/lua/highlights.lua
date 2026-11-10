-- ~/.config/nvim/lua/highlights.lua

-- Create a custom highlight group for yanked text
-- We are changing the color to a distinct orange
vim.api.nvim_set_hl(0, 'YankHighlight', {
  bg = '#FFA500', -- A bright orange background
  fg = '#000000', -- A dark foreground color for contrast
  bold = true,    -- Make the text bold
})

-- Create an autocommand group for highlights to avoid duplicate commands
local augroup = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

-- Create an autocommand that listens for the 'TextYankPost' event
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  callback = function()
    -- Use the custom highlight group and a longer timeout
    vim.highlight.on_yank({
      higroup = 'YankHighlight',
      timeout = 300, -- Lasts for 400 milliseconds
    })
  end,
})
