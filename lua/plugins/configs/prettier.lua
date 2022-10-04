local prettier = pcall(require, "prettier")

prettier.setup {
  bin = 'prettierd',
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less",
    "prisma",
    "python",
    "graphql"
  },
}
