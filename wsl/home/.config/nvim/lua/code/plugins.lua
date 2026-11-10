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
    -- Lua helper library
    { "nvim-lua/plenary.nvim", lazy = true },

    -- Syntax-aware parsing: needed for flash.nvim's treesitter jumps.
    -- VSCode does its own highlighting, so treesitter highlight stays off here.
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
      lazy = false,
      build = ":TSUpdate",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "lua", "vim", "vimdoc", "bash", "markdown", "markdown_inline", "query" },
          auto_install = true,
          highlight = { enable = false },
        })
      end,
    },

    -- Better textobjects; "f"/"if"/"af" select the enclosing function
    -- definition (via treesitter) instead of mini.ai's default "function call".
    {
      "echasnovski/mini.ai",
      version = "*",
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
      opts = function()
        local ai = require("mini.ai")
        return {
          custom_textobjects = {
            f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          },
        }
      end,
    },

    -- Arguments
    {
      "vim-scripts/argtextobj.vim",
      lazy = false,
    },

    -- Surround (uses s, sa, sd, sr)
    {
      "echasnovski/mini.surround",
      version = "*",
      opts = {
        mappings = {
          add = "<leader>sa",
          delete = "<leader>sd",
          replace = "<leader>sr",
          find = "<leader>sf",
          find_left = "<leader>sF",
          highlight = "<leader>sH",
          update_n_lines = "<leader>sn",
        },
      },
    },

    -- Flash (ONLY on leader, no conflicts)
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      },
    },

    -- Comments (gc)
    {
      "numToStr/Comment.nvim",
      event = "VeryLazy",
      opts = {},
    },
  },
  {
    checker = { enabled = false },
  })
