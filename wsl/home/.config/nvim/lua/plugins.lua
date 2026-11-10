local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Kanagawa theme (load before other UI plugins).
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({ theme = "dragon", background = { dark = "dragon" } })
      vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },
  -- Lua helper library used by many plugins.
  { "nvim-lua/plenary.nvim",       lazy = true },
  -- Filetype icons for UI plugins.
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- Syntax-aware parsing: real highlighting, indent, and flash.nvim's treesitter jumps.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline", "query", "c_sharp", "xml" },
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  },

  -- Statusline at the bottom of each window.
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
      },
    },
  },
  -- Popup hints for available keybindings.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Fuzzy finder for files, text, buffers, and help.
  {
    "nvim-telescope/telescope.nvim",
    version = false,
    cmd = "Telescope",
    -- Loaded on VeryLazy too so the ui-select override below is active before any
    -- vim.ui.select call (e.g. code actions), not just after :Telescope has run once.
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim", -- floating popup for vim.ui.select (code actions, etc.)
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  -- VS Code-style lightbulb: shows a sign when code actions are available at the cursor.
  {
    "kosayoda/nvim-lightbulb",
    event = "VeryLazy",
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = true, text = "💡" },
    },
  },
  -- Seamless navigation between tmux panes and Neovim splits.
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- Visual undo history tree toggle.
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  },
  -- Add/change/delete surrounding characters quickly.
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  -- Fast jump/search motions across the current buffer.
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter search" },
    },
  },
  -- Auto-close brackets, quotes, and pairs while typing.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- Toggle line/block comments with easy keymaps.
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- Edit the filesystem like a normal buffer; replaces netrw as the file explorer.
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
  -- Persistent left sidebar file tree (VS Code Explorer-style), distinct from oil's buffer-editing style.
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      disable_netrw = false,
      hijack_netrw = false, -- oil.nvim already owns netrw
      view = { width = 30, side = "left" },
      renderer = { group_empty = true },
      update_focused_file = { enable = true },
    },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      require("barbar").setup({
        animation = false, -- faster
        auto_hide = false,
        tabpages = true,
        clickable = true,
        icons = {
          buffer_index = true,
          buffer_number = false,
          button = "",
          diagnostics = {
            [vim.diagnostic.severity.ERROR] = { enabled = true },
            [vim.diagnostic.severity.WARN]  = { enabled = true },
          },
          gitsigns = {
            added = { enabled = true },
            changed = { enabled = true },
            deleted = { enabled = true },
          },
        },
      })
    end,
  },
  -- Completion engine; feeds capabilities to LSP servers (see lua/lsp.lua).
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
      -- "super-tab": Tab selects+accepts, like VS Code/Rider intellisense.
      keymap = { preset = "super-tab" },
      completion = { documentation = { auto_show = true } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
  -- .NET/C# IDE layer: Roslyn LSP, build/run/watch, test runner, NuGet, DAP registration.
  {
    "GustavEikaas/easy-dotnet.nvim",
    ft = { "cs", "fsproj", "csproj", "sln", "slnx", "fs" },
    cmd = "Dotnet",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("easy-dotnet").setup({
        lsp = {
          config = {
            capabilities = require("lsp").capabilities(),
          },
        },
        debugger = { enabled = true },
        test_runner = { viewmode = "float" },
        picker = "telescope",
      })
    end,
  },
  -- Debug Adapter Protocol client; easy-dotnet.nvim auto-registers the netcoredbg configs onto this.
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", function() require("dap").continue() end,   desc = "DAP: Continue" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "DAP: Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "DAP: Step into" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "DAP: Step out" },
    },
  },
  -- Visual UI (breakpoints, scopes, stack, REPL) for nvim-dap.
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}, {
  checker = { enabled = false },
})
