require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "ruff_lsp",
    "rust_analyzer",
    -- "black"
  },
  automatic_installation = true,
})

require("mason-null-ls").setup({
    ensure_installed = {
        "black",
        "mypy",
        "isort",
        "debugpy",
        -- "ruff",
        "rustfmt",
        -- Opt to list sources here, when available in mason.
    },
    automatic_installation = true,
    handlers = {},
})
require("null-ls").setup({
    sources = {
        -- Anything not supported by mason.
    }
})
