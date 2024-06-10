local lsp_zero = require "lsp-zero"

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

local lspconfig = require "lspconfig"
local mason = require "mason"
mason.setup {}

local mason_lspconfig = require "mason-lspconfig"
mason_lspconfig.setup {
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "jedi_language_server",
    "tsserver",
    "eslint",
    "jsonls",
    "clangd",
    "cmake",
    "bashls"
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup {}
    end,
  }
}

local cmp = require "cmp"

cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
  }),
}
