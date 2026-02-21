return {
    -- NeoVim官方热门的护眼主题
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.everforest_enable_italic = true
            vim.cmd.colorscheme("everforest")
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {},
        config = function()
            require("nvim-web-devicons").setup({
                -- your personal icons can go here (to override)
                -- you can specify color or cterm_color instead of specifying both of them
                -- DevIcon will be appended to `name`
                override = {
                    zsh = {
                        icon = "",
                        color = "#428850",
                        cterm_color = "65",
                        name = "Zsh",
                    },
                },
                -- globally enable different highlight colors per icon (default to true)
                -- if set to false all icons will have the default icon's color
                color_icons = true,
                -- globally enable default icons (default to false)
                -- will get overriden by `get_icons` option
                default = true,
                -- globally enable "strict" selection of icons - icon will be looked up in
                -- different tables, first by filename, and if not found by extension; this
                -- prevents cases when file doesn't have any extension but still gets some icon
                -- because its name happened to match some extension (default to false)
                strict = true,
                -- set the light or dark variant manually, instead of relying on `background`
                -- (default to nil)
                variant = "light|dark",
                -- override blend value for all highlight groups :h highlight-blend.
                -- setting this value to `0` will make all icons opaque. in practice this means
                -- that icons width will not be affected by pumblend option (see issue #608)
                -- (default to nil)
                blend = 0,
                -- same as `override` but specifically for overrides by filename
                -- takes effect when `strict` is true
                override_by_filename = {
                    [".gitignore"] = {
                        icon = "",
                        color = "#f1502f",
                        name = "Gitignore",
                    },
                },
                -- same as `override` but specifically for overrides by extension
                -- takes effect when `strict` is true
                override_by_extension = {
                    ["log"] = {
                        icon = "",
                        color = "#81e043",
                        name = "Log",
                    },
                },
                -- same as `override` but specifically for operating system
                -- takes effect when `strict` is true
                override_by_operating_system = {
                    ["apple"] = {
                        icon = "",
                        color = "#A2AAAD",
                        cterm_color = "248",
                        name = "Apple",
                    },
                },
            })
        end,
    },
    {
        "goolord/alpha-nvim", -- 搬运于github项目https://github.com/clear668866x6/nvim/tree/main
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            -- 设置高亮组
            local function setup_highlight_groups()
                vim.api.nvim_set_hl(0, "AlphaHeader1", { fg = "#ff6b6b", bold = true })
                vim.api.nvim_set_hl(0, "AlphaHeader2", { fg = "#4ecdc4", bold = true })
                vim.api.nvim_set_hl(0, "AlphaHeader3", { fg = "#45b7d1", bold = true })
                vim.api.nvim_set_hl(0, "AlphaHeader4", { fg = "#96ceb4", bold = true })
                vim.api.nvim_set_hl(0, "AlphaHeader5", { fg = "#feca57", bold = true })
                vim.api.nvim_set_hl(0, "AlphaHeader6", { fg = "#ff9ff3", bold = true })
                vim.api.nvim_set_hl(0, "AlphaBorder", { fg = "#6c5ce7", bold = true })
                vim.api.nvim_set_hl(0, "AlphaQuote", { fg = "#a8a8a8", italic = true })
                vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#74b9ff", bold = true })
            end

            -- 设置高亮组
            setup_highlight_groups()

            -- 创建大型 NEOVIM 标题，填满更多屏幕空间
            dashboard.section.header.val = {
                "",
                "",
                "                   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                "                   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                "                   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                "                   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                "                   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                "                   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
                "",
                "",
                "                           🚀 Ready to code with style! 🚀",
                "",
                "",
                "    ████████████████████████████████████████████████████████████████████████████",
                "",
                "",
            }

            -- 设置标题高亮
            dashboard.section.header.opts.hl = "AlphaHeader1"

            -- 增强的按钮配置
            dashboard.section.buttons.val = {
                dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", "󰈔  New file", ":enew <CR>"),
                dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", "󰊄  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("p", "󰏖  Projects", ":Telescope projects <CR>"),
                dashboard.button("l", "󰒲  Lazy", ":Lazy <CR>"),
                dashboard.button("m", "󱌣  Mason", ":Mason <CR>"),
                dashboard.button("<leader>c", "󰣇  Config", ":NvimTreeToggle ~/.config/nvim<CR>"),
                dashboard.button("q", "󰈆  Quit", ":qa <CR>"),
            }

            -- 设置按钮样式
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.buttons.opts.hl_shortcut = "AlphaHeader2"

            -- 配置布局
            dashboard.config.layout = {
                dashboard.section.header,
                { type = "padding", val = 2 },
                dashboard.section.buttons,
                { type = "padding", val = 2 },
                dashboard.section.footer,
            }

            -- 处理 Lazy 窗口冲突
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    once = true,
                    pattern = "AlphaReady",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            -- 设置 Alpha
            alpha.setup(dashboard.config)

            -- 动态更新 footer
            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

                    dashboard.section.footer.val = {
                        "",
                        "    ═══════════════════════════════════════════════════════════════════════════",
                        "",
                        "       " .. os.date("󰃰 %Y年%b%d日") .. "     " .. os.date("🕐 %H:%M:%S"),
                        "       ⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
                        "       🎯 "
                            .. vim.version().major
                            .. "."
                            .. vim.version().minor
                            .. "."
                            .. vim.version().patch
                            .. " • 💻 "
                            .. vim.loop.os_uname().sysname,
                        "",
                        "    ═══════════════════════════════════════════════════════════════════════════",
                        "",
                    }

                    dashboard.section.footer.opts.hl = "AlphaQuote"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })

            -- 启动时显示欢迎消息
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    vim.defer_fn(function()
                        if vim.bo.filetype == "alpha" then
                            vim.notify("🎉 Welcome back to Neovim!", vim.log.levels.INFO, {
                                title = "Dashboard",
                                timeout = 2000,
                            })
                        end
                    end, 500)
                end,
            })
        end,
    },
    -- 一个超快的显示hex颜色的插件
    {
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-highlight-colors").setup({
                render = "background",
                enable_named_colors = true,
                enable_tailwind = true,
            })
        end,
    },

    -- 光标位于一个词语时，页面上其他同一个词语加下划线
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
    },
    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        opts = {
            smear_between_buffers = true,
            smear_between_neighbor_lines = true,
            scroll_buffer_space = true,
            legacy_computing_symbols_support = true,
            smear_insert_mode = true,
        },
    },
    {
        "echasnovski/mini.icons",
        lazy = true,
        version = false,
        event = "VeryLazy",
    },
    {
        "kosayoda/nvim-lightbulb",
        event = "VeryLazy",
        config = function()
            require("nvim-lightbulb").setup({
                priority = 10,
                hide_in_unfocused_buffer = true,
                link_highlights = true,
                validate_config = "auto",
                action_kinds = nil,
                sign = {
                    enabled = true,
                    text = "💡",
                    hl = "LightBulbSign",
                },
                virtual_text = {
                    enabled = false,
                    text = "💡",
                    pos = "eol",
                    hl = "LightBulbVirtualText",
                    hl_mode = "combine",
                },
                float = {
                    enabled = false,
                    text = "💡",
                    hl = "LightBulbFloatWin",
                    win_opts = {},
                },
                status_text = {
                    enabled = false,
                    text = "💡",
                    text_unavailable = "",
                },
                autocmd = {
                    enabled = true,
                    updatetime = 200,
                    events = { "CursorHold", "CursorHoldI" },
                    pattern = { "*" },
                },
                ignore = {
                    clients = {},
                    ft = {},
                    actions_without_kind = false,
                },
            })
        end,
    },
    -- 面包屑
    {
        "Bekaboo/dropbar.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        keys = {
            { "<Leader>;", desc = "Pick symbols in winbar" },
            { "[;", desc = "Go to start of current context" },
            { "];", desc = "Select next context" },
        },
        config = function()
            local dropbar_api = require("dropbar.api")
            vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
            vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
            vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
        end,
    },
    -- 动画
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        opts = {
            animate = {
                enabled = true,
                style = "slide",
                duration = 150,
            },
        },
    },
    -- 平滑滚动插件
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            require("neoscroll").setup({
                easing_function = "quadratic",
                animation_time = 300,
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            theme = "auto",
        },
        config = function()
            local colors = {
                blue = "#80a0ff",
                cyan = "#79dac8",
                black = "#080808",
                white = "#c6c6c6",
                red = "#ff5189",
                violet = "#d183e8",
                grey = "#303030",
                error = "#ff5189",
                warn = "#f0c674",
                info = "#0db9d7",
                hint = "#10b981",
            }

            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = "",
                    section_separators = { left = "", right = "" },
                },
                sections = {
                    lualine_a = {
                        { "mode", separator = { left = "" }, right_padding = 2 },
                    },
                    lualine_b = {
                        { "branch", icon = "" },
                        { "filename", icon = "" },
                    },
                    lualine_c = {
                        "%=",
                    },
                    lualine_x = {
                        {
                            function()
                                local ok, pomo = pcall(require, "pomo")
                                if not ok then
                                    return ""
                                end

                                local timer = pomo.get_first_to_finish()
                                if timer == nil then
                                    return ""
                                end

                                return "󰄉 " .. tostring(timer)
                            end,
                            "encoding",
                            "fileformat",
                            "filetype",
                            "diagnostics",
                            sources = { "nvim_diagnostic", "nvim_lsp" },
                            sections = { "error", "warn", "info", "hint" },
                            diagnostics_color = {
                                error = { fg = colors.error },
                                warn = { fg = colors.warn },
                                info = { fg = colors.info },
                                hint = { fg = colors.hint },
                            },
                            symbols = {
                                error = " ",
                                warn = " ",
                                info = " ",
                                hint = "💡",
                            },
                            colored = true,
                            update_in_insert = true,
                            always_visible = false,
                        },
                        {
                            function()
                                local msg = "No Active Lsp"
                                local clients = vim.lsp.get_clients({ bufnr = 0 })
                                if next(clients) == nil then
                                    return msg
                                end
                                local client_names = {}
                                for _, client in ipairs(clients) do
                                    table.insert(client_names, client.name)
                                end
                                return table.concat(client_names, ", ")
                            end,
                            icon = " ",
                            color = { fg = colors.white, gui = "bold" },
                        },
                    },
                    lualine_y = {
                        { "filetype", icon = "" },
                        { "progress", icon = "" },
                    },
                    lualine_z = {
                        { "location", icon = "", separator = { right = "" }, left_padding = 2 },
                    },
                },
                inactive_sections = {
                    lualine_a = { "filename" },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "location" },
                },
                tabline = {},
                extensions = {},
            })

            vim.api.nvim_create_augroup("LualineDiagnostics", { clear = true })
            vim.api.nvim_create_autocmd({ "DiagnosticChanged", "LspAttach", "LspDetach" }, {
                group = "LualineDiagnostics",
                callback = function()
                    require("lualine").refresh()
                end,
            })
        end,
    },
    {
        "willothy/nvim-cokeline",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "stevearc/resession.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local cokeline = require("cokeline")
            local get_hl_attr = require("cokeline.hlgroups").get_hl_attr

            local function get_color(group, attr, fallback)
                local color = get_hl_attr(group, attr)
                if color then
                    return color
                end
                if fallback then
                    return get_hl_attr(fallback, attr)
                end
                return nil
            end

            local editor_bg = function()
                return get_color("Normal", "bg") or "NONE"
            end
            local sidebar_bg = function()
                return get_color("NvimTreeNormal", "bg", "Normal") or "NONE"
            end

            local focused_fg = function()
                return get_color("Normal", "fg") or "NONE"
            end
            local focused_bg = function()
                return get_color("Visual", "bg") or "NONE"
            end
            local unfocused_fg = function()
                return get_color("Comment", "fg") or "NONE"
            end
            local unfocused_bg = function()
                return get_color("TabLineFill", "bg", "Normal") or "NONE"
            end

            local pick_fg = "#ffffff"
            local pick_bg = "#e32636"

            cokeline.setup({
                sidebar = {
                    filetype = { "NvimTree", "neo-tree" },
                    components = {
                        {
                            text = "",
                            fg = unfocused_fg,
                            bg = sidebar_bg,
                        },
                        {
                            text = function(buf)
                                return " " .. buf.filetype .. " "
                            end,
                            fg = unfocused_fg,
                            bg = sidebar_bg,
                            bold = true,
                        },
                    },
                },

                components = {
                    {
                        text = "",
                        fg = function(buffer)
                            return buffer.is_focused and focused_bg() or unfocused_bg()
                        end,
                        bg = editor_bg,
                    },

                    {
                        text = function(buffer)
                            return " " .. buffer.devicon.icon .. " "
                        end,
                        fg = function(buffer)
                            return buffer.devicon.color
                        end,
                        bg = function(buffer)
                            return buffer.is_focused and focused_bg() or unfocused_bg()
                        end,
                    },

                    {
                        text = function(buffer)
                            return buffer.unique_prefix .. buffer.filename
                        end,
                        fg = focused_fg,
                        bg = function(buffer)
                            return buffer.is_focused and focused_bg() or unfocused_bg()
                        end,
                        bold = function(buffer)
                            return buffer.is_focused
                        end,
                        on_drag = cokeline.move_buffer,
                    },

                    {
                        text = function(buffer)
                            if buffer.is_modified then
                                return " ●"
                            end
                            return ""
                        end,
                        fg = focused_fg,
                        bg = function(buffer)
                            return buffer.is_focused and focused_bg() or unfocused_bg()
                        end,
                    },

                    {
                        text = " ",
                        bg = function(buffer)
                            return buffer.is_focused and focused_bg() or unfocused_bg()
                        end,
                    },

                    {
                        text = "",
                        on_click = function(_, _, _, _, buffer)
                            buffer:delete()
                        end,
                        fg = focused_fg,
                        bg = function(buffer)
                            return buffer.is_focused and focused_bg() or unfocused_bg()
                        end,
                        pick = {
                            fg = pick_fg,
                            bg = pick_bg,
                            bold = true,
                        },
                    },

                    {
                        text = "",
                        fg = function(buffer)
                            return buffer.is_focused and focused_bg() or unfocused_bg()
                        end,
                        bg = editor_bg,
                    },

                    {
                        text = " ",
                        bg = editor_bg,
                    },
                },
            })
        end,
    },
    { "SmiteshP/nvim-navic", config = true, event = "VeryLazy" },
}
