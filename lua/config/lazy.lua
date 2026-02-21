-- 此处安装lazy.nvim插件,用于更加简洁明了的neovim包管理(尽量连接VPN)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- 此处是lazy.nvim的配置
require("lazy").setup({
    spec = {
        { import = "plugins" }, -- 导入你的插件
    },
    defaults = {
        lazy = false, -- 默认不采用懒加载
        version = false, -- 选用稳定版（false 表示最新）
        -- version = "*", -- 如果需要特定版本可以启用
    },
    -- install = { colorscheme = { "tokyonight", "habamax" } }, -- 安装时的默认主题
    checker = {
        enabled = true, -- 自动检查插件更新
        notify = false, -- 不显示更新通知
    },

    -- 性能优化配置
    performance = {
        cache = {
            enabled = true, -- 启用缓存加速启动
        },
        reset_packpath = true, -- 重置 packpath 减少目录扫描
        rtp = {
            reset = true, -- 重置 runtimepath
            paths = {}, -- 额外的 rtp 路径（默认空）

            -- 禁用不需要的内置插件
            disabled_plugins = { -- 这是标准的配置字段名
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                -- "matchit",      -- 如需保留可以注释掉
                -- "matchparen",   -- 括号匹配，建议保留
                -- "netrw",        -- 文件浏览，如使用 nvim-tree 可禁用
                -- "netrwPlugin",
                "rrhelper",
                "spellfile_plugin",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zip",
                "zipPlugin",
            },
        },
    },
})
