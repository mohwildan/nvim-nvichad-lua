local present, null_ls = pcall(require, "null-ls")

if not present then
   return
end

local b = null_ls.builtins

local sources = {

   b.formatting.prettierd,

   b.formatting.stylua,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

return {
   debug = true,
   sources = sources,
}
