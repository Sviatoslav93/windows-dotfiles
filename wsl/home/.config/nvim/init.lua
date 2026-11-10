vim.opt.ignorecase = true
vim.opt.smartcase = true

if vim.g.vscode then
    -- VSCode extensions
    require('code.options')
    require('code.keymaps')
    require('code.plugins')
else
    -- ordinary Neovim
    require('options')
    require('keymaps')
    require('plugins')
    require('lsp')
    require('colorscheme')
end
