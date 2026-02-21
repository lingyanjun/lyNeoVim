return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
    },
    vim.lsp.enable("lua_ls"),
    vim.lsp.enable("clangd"),
    vim.diagnostic.config({
        virtual_text = {
            prefix = "●",
            source = true,
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "▲",
                [vim.diagnostic.severity.INFO] = "●",
                [vim.diagnostic.severity.HINT] = "⚑",
            },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = "rounded",
            source = true,
            header = "",
            prefix = "",
        },
    }),
}
