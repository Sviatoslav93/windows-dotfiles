vim.g.mapleader = ' '

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ui
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true

-- identation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- behaviour
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.mouse = 'a'
vim.opt.splitbelow = true
vim.opt.splitright = true

-- performance
vim.opt.updatetime = 200
vim.opt.timeoutlen = 400
vim.opt.lazyredraw = true


--files
vim.opt.undofile = true
vim.opt.isfname:append("@-@")
vim.opt.path:append("**")

-- clipboard
vim.opt.clipboard = 'unnamedplus'

-- tabs
vim.opt.showtabline = 2

-- Yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
