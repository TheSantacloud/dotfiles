return {
  cmd = { "xcrun", "sourcekit-lsp" },
  filetypes = { "swift", "objective-c", "objective-cpp" },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = { dynamicRegistration = true },
    },
  },
}
