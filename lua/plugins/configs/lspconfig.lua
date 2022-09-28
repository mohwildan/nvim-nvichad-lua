local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  if vim.g.vim_version > 7 then
    -- nightly
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  else
    -- stable
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

lspconfig.sumneko_lua.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.tsserver.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetype = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
}

lspconfig.pyright.setup {
  cmd = { "pyright-langserver", "--stdio" },
  filetype = { "python" },
}

lspconfig.html.setup {
  capabilities = M.capabilities,
  cmd = { "vscode-html-language-server", "--stdio" },
  filetype = { "html" },
  init_options = {
     configurationSection = { "html", "css", "javascript" },
  embeddedLanguages = {
    css = true,
    javascript = true
  },
  provideFormatter = true
  }
}

lspconfig.cssls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "vscode-css-language-server", "--stdio" },
  filetype = { "css", "scss", "less" }
}

lspconfig.clangd.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "clangd" },
  filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
}

lspconfig.astro.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "astro-ls", "--stdio" },
  filetype = { "astro" }
}

lspconfig.tailwindcss.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetype = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" }
}

lspconfig.prismals.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "prisma-language-server", "--stdio" },
  filetype = { "prisma" }
}

lspconfig.eslint.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetype = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte" }
}


lspconfig.graphql.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  cmd = { "graphql-lsp", "server", "-m", "stream" },
  filetype = { "graphql", "typescriptreact", "javascriptreact" }
}
return M
