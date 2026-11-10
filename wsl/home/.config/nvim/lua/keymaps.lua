-- set up key mappings
local map = vim.keymap.set

-- remap 'jk' to escape in insert mode
map('i', 'jk', '<Esc>', { desc = 'Escape from insert mode' })

-- quick save
map('n', '<C-s>', '<Cmd>w<CR>', { desc = 'Save buffer' })

-- quick quit
map('n', '<leader>q', '<Cmd>q<CR>', { desc = 'Quit buffer' })

-- quick movement
map('n', 'J', '5j', { desc = 'Move down 5 lines' })
map('n', 'K', '5k', { desc = 'Move up 5 lines' })

-- move selected block updown
map("x", "J", ":m '>+1<CR>gv=gv", {desc = 'move selected up' })
map("x", "K", ":m '<-2<CR>gv=gv", { desc = 'move selected down' })

-- removes highlighting after escaping vim search
map("n", "<Esc>", "<Esc>:noh<CR>", opts)

map({ "n", "v" }, "L", "$", opts)
map({ "n", "v" }, "H", "^", opts)
map("n", "gH", "H", opts)
map("n", "gL", "L", opts)

-- split window
map('n', '<leader>sv', '<Cmd>vsplit<CR>', { desc = 'Vertical split' })
map('n', '<leader>sh', '<Cmd>split<CR>', { desc = 'Horizontal split' })

-- move between splits
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to below split' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to above split' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- telescope mappings
map('n', '<leader>ff', '<Cmd>Telescope find_files<CR>', { desc = 'Find files' })
map('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>', { desc = 'Live grep' })
map('n', '<leader>fb', '<Cmd>Telescope buffers<CR>', { desc = 'Find buffers' })
map('n', '<leader>fh', '<Cmd>Telescope help_tags<CR>', { desc = 'Find help' })
map('n', '<leader>fr', '<Cmd>Telescope oldfiles<CR>', { desc = 'Recent files' })

-- undo history viewer
map('n', '<leader>u', '<Cmd>UndotreeToggle<CR>', { desc = 'Toggle undo tree' })
map('n', '<leader>t', '<Cmd>split | terminal<CR>', { desc = 'Open terminal (split)' })

-- navigate buffers
map("n", "<A-l>", "<cmd>BufferNext<CR>", opts)
map("n", "<A-h>", "<cmd>BufferPrevious<CR>", opts)

-- close buffer
map("n", "<leader>q", "<cmd>BufferClose<CR>", opts)

-- move buffer position
map("n", "<S-A-l>", "<cmd>BufferMoveNext<CR>", opts)
map("n", "<S-A-h>", "<cmd>BufferMovePrevious<CR>", opts)

-- go to buffer by number
map("n", "<leader>1", "<cmd>BufferGoto 1<CR>", opts)
map("n", "<leader>2", "<cmd>BufferGoto 2<CR>", opts)
map("n", "<leader>3", "<cmd>BufferGoto 3<CR>", opts)
map("n", "<leader>4", "<cmd>BufferGoto 4<CR>", opts)

-- pin buffer (very useful)
map("n", "<leader>p", "<cmd>BufferPin<CR>", opts)

-- close all but current
map("n", "<leader>bo", "<cmd>BufferCloseAllButCurrent<CR>", opts)

-- magic: jump mode 🔥
map("n", "<leader>b", "<cmd>BufferPick<CR>", opts)

-- toggle file explorer sidebar (nvim-tree, VS Code Explorer-style)
map("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- open floating oil.nvim (edit current directory as a buffer)
map("n", "-", "<Cmd>Oil --float<CR>", { desc = "Open parent directory (float)" })

-- dotnet project actions (easy-dotnet.nvim)
map("n", "<leader>dr", "<Cmd>Dotnet run<CR>", { desc = "Dotnet run" })
map("n", "<leader>db", "<Cmd>Dotnet build<CR>", { desc = "Dotnet build" })
map("n", "<leader>dt", "<Cmd>Dotnet testrunner<CR>", { desc = "Dotnet test runner" })
map("n", "<leader>ds", "<Cmd>Dotnet solution select<CR>", { desc = "Dotnet select solution" })
