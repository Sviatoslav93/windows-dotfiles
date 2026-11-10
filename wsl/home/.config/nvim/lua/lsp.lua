local M = {}

-- Deferred: blink.cmp lazy-loads on InsertEnter, so calling this eagerly here
-- would force it to load at startup instead. Call M.capabilities() at the
-- point a server is actually configured (see below, and easy-dotnet.nvim).
function M.capabilities()
  return require("blink.cmp").get_lsp_capabilities()
end

-- Native LSP registration (Neovim 0.11+ vim.lsp.config/enable) for the
-- languages this repo itself is written in. Each guard skips silently if the
-- server binary isn't installed yet (install manually, same as EasyDotnet).
if vim.fn.executable("lua-language-server") == 1 then
  vim.lsp.config("lua_ls", {
    capabilities = M.capabilities(),
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  })
  vim.lsp.enable("lua_ls")
end

if vim.fn.executable("bash-language-server") == 1 then
  vim.lsp.config("bashls", { capabilities = M.capabilities() })
  vim.lsp.enable("bashls")
end

vim.diagnostic.config({
  virtual_text = { spacing = 4 },
  signs = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded", source = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

    local ok_telescope = pcall(require, "telescope")
    if ok_telescope then
      vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Go to references" }))
    else
      vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
    end
  end,
})

return M
