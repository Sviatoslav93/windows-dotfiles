local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- normal mode (single line)
keymap("n", "J", "v:count == 0 ? '5j' : 'j'", { expr = true, noremap = true, silent = true })
keymap("n", "K", "v:count == 0 ? '5k' : 'k'", { expr = true, noremap = true, silent = true })

-- keep cursor centered
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- <C-f> is vim's built-in full-page-down scroll; override it to VS Code's find widget instead
keymap({ "n", "v" }, "<C-f>", "<cmd>lua require('vscode').action('actions.find')<CR>")

-- splits
keymap("n", "<leader>sv", "<cmd>lua require('vscode').action('workbench.action.splitEditorRight')<CR>")
keymap("n", "<leader>sh", "<cmd>lua require('vscode').action('workbench.action.splitEditorDown')<CR>")

-- close split
keymap("n", "<leader>sq", "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>")

-- navigation between splits
keymap("n", "<C-h>", "<cmd>lua require('vscode').action('workbench.action.focusLeftGroup')<CR>")
keymap("n", "<C-l>", "<cmd>lua require('vscode').action('workbench.action.focusRightGroup')<CR>")
keymap("n", "<C-k>", "<cmd>lua require('vscode').action('workbench.action.focusAboveGroup')<CR>")
keymap("n", "<C-j>", "<cmd>lua require('vscode').action('workbench.action.focusBelowGroup')<CR>")

-- resize splits
keymap("n", "<leader>=", "<cmd>lua require('vscode').action('workbench.action.evenEditorWidths')<CR>")

-- move editor between groups
keymap("n", "<leader>mh", "<cmd>lua require('vscode').action('workbench.action.moveEditorToLeftGroup')<CR>")
keymap("n", "<leader>ml", "<cmd>lua require('vscode').action('workbench.action.moveEditorToRightGroup')<CR>")
keymap("n", "<leader>mk", "<cmd>lua require('vscode').action('workbench.action.moveEditorToAboveGroup')<CR>")
keymap("n", "<leader>mj", "<cmd>lua require('vscode').action('workbench.action.moveEditorToBelowGroup')<CR>")

-- tab manipulation
keymap({ "n" }, "<leader>q", "<cmd>lua require('vscode').action('workbench.action.closeActiveEditor')<CR>")
keymap({ "n" }, "<leader><leader>w", "<cmd>lua require('vscode').action('workbench.action.saveall')<cr>")

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

--
keymap({ "n", "v" }, "L", "$", opts)
keymap({ "n", "v" }, "H", "^", opts)
keymap("n", "gH", "H", opts)
keymap("n", "gL", "L", opts)

-- general keymaps
keymap({ "n", "v" }, "<leader>t", "<cmd>lua require('vscode').action('workbench.action.terminal.toggleTerminal')<CR>")
keymap({ "n", "v" }, "<leader><leader>b", "<cmd>lua require('vscode').action('editor.debug.action.toggleBreakpoint')<CR>")
keymap("n", "<leader><leader>h", "<cmd>lua require('vscode').action('editor.debug.action.showDebugHover')<CR>")
keymap({ "n", "v" }, "<leader>d", "<cmd>lua require('vscode').action('editor.action.showHover')<CR>")
keymap({ "n", "v" }, "<leader>a", "<cmd>lua require('vscode').action('editor.action.quickFix')<CR>")
keymap({ "n", "v" }, "<leader>sp", "<cmd>lua require('vscode').action('workbench.actions.view.problems')<CR>")
keymap({ "n", "v" }, "<leader>cn", "<cmd>lua require('vscode').action('notifications.clearAll')<CR>")
keymap({ "n", "v" }, "<leader>ff", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")
keymap({ "n", "v" }, "<leader>cp", "<cmd>lua require('vscode').action('workbench.action.showCommands')<CR>")
keymap({ "n", "v" }, "<leader>rr", "<cmd>lua require('vscode').action('code-runner.run')<CR>")
keymap({ "n", "v" }, "<leader>fd", "<cmd>lua require('vscode').action('editor.action.formatDocument')<CR>")

-- code navigation
keymap("n", "<leader>gi", "<cmd>lua require('vscode').action('editor.action.goToImplementation')<CR>", opts)
keymap("n", "<leader>pi", "<cmd>lua require('vscode').action('editor.action.peekImplementation')<CR>", opts)
keymap("n", "<leader>pd", "<cmd>lua require('vscode').action('editor.action.peekDefinition')<CR>", opts)
keymap("n", "<leader>pr", "<cmd>lua require('vscode').action('editor.action.referenceSearch.trigger')<CR>", opts)
keymap("n", "<leader>fr", "<cmd>lua require('vscode').action('editor.action.referenceSearch.trigger')<CR>", opts)

-- CamelCase/snake_case-aware word motion (VS Code's built-in cursorWordPart*, not plain w/b)
keymap("n", "<leader>w", "<cmd>lua require('vscode').action('cursorWordPartRight')<CR>", opts)
keymap("n", "<leader>b", "<cmd>lua require('vscode').action('cursorWordPartLeft')<CR>", opts)
keymap("v", "<leader>w", "<cmd>lua require('vscode').action('cursorWordPartRightSelect')<CR>", opts)
keymap("v", "<leader>b", "<cmd>lua require('vscode').action('cursorWordPartLeftSelect')<CR>", opts)

-- rename symbol
keymap("n", "<leader>rn", "<cmd>lua require('vscode').action('editor.action.rename')<CR>", opts)

-- diagnostics navigation (mirrors standalone nvim's lsp.lua ]d/[d)
keymap("n", "]d", "<cmd>lua require('vscode').action('editor.action.marker.next')<CR>", opts)
keymap("n", "[d", "<cmd>lua require('vscode').action('editor.action.marker.prevInFiles')<CR>", opts)

-- go to symbol / outline
keymap("n", "<leader>so", "<cmd>lua require('vscode').action('editor.action.quickOutline')<CR>", opts)

-- toggle file explorer sidebar
keymap("n", "<leader>e", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>", opts)

-- harpoon keymaps
keymap({ "n", "v" }, "<leader>ha", "<cmd>lua require('vscode').action('vscode-harpoon.addEditor')<CR>")
keymap({ "n", "v" }, "<leader>ho", "<cmd>lua require('vscode').action('vscode-harpoon.editorQuickPick')<CR>")
keymap({ "n", "v" }, "<leader>he", "<cmd>lua require('vscode').action('vscode-harpoon.editEditors')<CR>")
keymap({ "n", "v" }, "<leader>h1", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor1')<CR>")
keymap({ "n", "v" }, "<leader>h2", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor2')<CR>")
keymap({ "n", "v" }, "<leader>h3", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor3')<CR>")
keymap({ "n", "v" }, "<leader>h4", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor4')<CR>")
keymap({ "n", "v" }, "<leader>h5", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor5')<CR>")
keymap({ "n", "v" }, "<leader>h6", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor6')<CR>")
keymap({ "n", "v" }, "<leader>h7", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor7')<CR>")
keymap({ "n", "v" }, "<leader>h8", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor8')<CR>")
keymap({ "n", "v" }, "<leader>h9", "<cmd>lua require('vscode').action('vscode-harpoon.gotoEditor9')<CR>")

-- project manager keymaps
keymap({ "n", "v" }, "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
keymap({ "n", "v" }, "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
keymap({ "n", "v" }, "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")
