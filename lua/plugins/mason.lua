return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "vimls",
            "bashls",
            "taplo",
            "yamlls",
            "jsonls",
            "cmake",
            "marksman",
        },
    },
    dependencies = {
        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            },
        },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            opts = {
                ensure_installed = {},
            },
        },
        {
            "neovim/nvim-lspconfig",
            event = { "BufReadPre", "BufNewFile" },
        },
    },
}
