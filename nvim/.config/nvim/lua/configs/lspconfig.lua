require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "pyright",
  "ts_ls",
  "rust_analyzer",
  "tailwindcss",
  "clangd",
  "lua_ls",
  "eslint",
  "nextjs",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
