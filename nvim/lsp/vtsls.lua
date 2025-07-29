return {
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", ".git" },
  settings = {
    vtsls = {
      enableMoveToFileCodeAction = true,
    },
    typescript = {
      preferences = {
        preferGoToSourceDefinition = true,
      },
    },
  },
}
