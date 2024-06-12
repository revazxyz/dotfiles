local lsp_zero = require "lsp-zero"

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

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
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  })
}

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
    { name = "cmdline" }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

local lspconfig = require "lspconfig"
local mason = require "mason"
mason.setup {}

local cmp_nvim = require "cmp_nvim_lsp"
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
      lspconfig[server_name].setup {
        capabilities = cmp_nvim.default_capabilities()
      }
    end,
  }
}
