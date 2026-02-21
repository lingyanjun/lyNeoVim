return {
    -- 辅助记忆NeoVim键位映射(按空格触发)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    -- Neovim 中实现语法高亮和语言特定功能等高级功能
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = "TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })
            require("nvim-treesitter").install({
                "c",
                "cpp",
                "lua",
                "vim",
                "bash",
                "toml",
                "yaml",
                "json",
                "cmake",
                "markdown",
                "markdown_inline",
                "vimdoc",
                "javascript",
                "typescript",
            })
        end,
    },
    -- 快速,模糊查找插件
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- optional but recommended
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "查找文件" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "查找内容" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "缓冲区列表" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "帮助标签" },
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-h>"] = "which_key",
                        },
                    },
                },
                pickers = {},
                extensions = {},
            })
            require("nvim-web-devicons").get_icon(filename, extension, options)
        end,
    },
    -- 增强neovim的diff file模式
    {
        "barrettruth/diffs.nvim",
        init = function()
            vim.g.diffs = {
                fugitive = true,
                neogit = true,
            }
        end,
        event = "VeryLazy",
    },
    -- 错误诊断
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    -- 自动补全括号等等
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    --代码块缩进显示插件
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }

            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup({ scope = { highlight = highlight } })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    -- 高亮TODO和FIX等注释
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        opts = {},
    },
    {
        "CRAG666/code_runner.nvim",
        event = "VeryLazy",
        config = function()
            require("code_runner").setup({
                mode = "float",
                focus = true,
                startinsert = true,
                filetype = {
                    lua = "lua",
                    bash = "bash",
                    sh = "sh",
                    zsh = "zsh",
                    c = "cd $dir && clang $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
                    cpp = "cd $dir && clang++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
                },
                float = {
                    border = "rounded",
                    width = 0.9,
                    height = 0.7,
                    x = 0.5,
                    y = 0.5,
                },
            })
        end,
    },
    -- 通知
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("notify").setup({
                render = "compact",
                stages = "slide",
                top_down = false,
                background_colour = "#F5F5F5",
            })
            vim.notify = require("notify")
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            find = "written",
                        },
                        opts = { skip = true },
                    },
                },
            })
        end,
    },
    -- 本地截图
    { "michaelrommel/nvim-silicon", cmd = "Silicon", config = true },
    -- 在线截图
    {
        "ellisonleao/carbon-now.nvim",
        cmd = "CarbonNow",
        keys = {
            { "<leader>pp", ":'<,'>CarbonNow<CR>", mode = "v", desc = "Carbon代码截图", silent = true },
        },
        config = function()
            require("carbon-now").setup({
                -- 可选配置
                options = {
                    theme = "dracula", -- 主题：one-dark, dracula, etc.
                    background = "rgba(0,0,0,0)", -- 背景
                    window_theme = "sharp", -- 窗口风格
                    font_family = "JetBrains Mono",
                    line_numbers = true,
                    padding_vertical = 50,
                    padding_horizontal = 50,
                    drop_shadow = true,
                    shadow_blur = 68,
                    shadow_offset = { x = 20, y = 20 },
                    width = 680,
                },
                -- 浏览器设置
                open_cmd = vim.env.BROWSER or "termux-open-url", -- Termux用这个
            })
        end,
    },
    -- 代码地图
    ---@module "neominimap.config.meta"
    {
        "Isrothy/neominimap.nvim",
        version = "v3.x.x",
        cmd = "Neominimap",
        keys = {
            { "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
            { "<leader>no", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
            { "<leader>nc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
            { "<leader>nr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },
            { "<leader>nwt", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for current window" },
            { "<leader>nwr", "<cmd>Neominimap WinRefresh<cr>", desc = "Refresh minimap for current window" },
            { "<leader>nwo", "<cmd>Neominimap WinEnable<cr>", desc = "Enable minimap for current window" },
            { "<leader>nwc", "<cmd>Neominimap WinDisable<cr>", desc = "Disable minimap for current window" },
            { "<leader>ntt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for current tab" },
            { "<leader>ntr", "<cmd>Neominimap TabRefresh<cr>", desc = "Refresh minimap for current tab" },
            { "<leader>nto", "<cmd>Neominimap TabEnable<cr>", desc = "Enable minimap for current tab" },
            { "<leader>ntc", "<cmd>Neominimap TabDisable<cr>", desc = "Disable minimap for current tab" },
            { "<leader>nbt", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
            { "<leader>nbr", "<cmd>Neominimap BufRefresh<cr>", desc = "Refresh minimap for current buffer" },
            { "<leader>nbo", "<cmd>Neominimap BufEnable<cr>", desc = "Enable minimap for current buffer" },
            { "<leader>nbc", "<cmd>Neominimap BufDisable<cr>", desc = "Disable minimap for current buffer" },
            { "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Focus on minimap" },
            { "<leader>nu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
            { "<leader>ns", "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
        },
        init = function()
            vim.opt.wrap = false
            vim.opt.sidescrolloff = 36
            vim.g.neominimap = {
                auto_enable = false,
            }
        end,
    },
    -- 专注模式 :ZenMode
    { "folke/zen-mode.nvim", cmd = "ZenMode", config = true },
    -- 快速跳转和搜索
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                search = {
                    enabled = true,
                },
                char = {
                    enabled = false,
                },
            },
        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "sustech-data/wildfire.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("wildfire").setup()
        end,
    },
    {
        "2kabhishek/nerdy.nvim",
        dependencies = {
            "folke/snacks.nvim",
        },
        cmd = "Nerdy",
        opts = {
            max_recents = 30,
            add_default_keybindings = true,
            use_new_command = true,
        },
    },
    {
        "sontungexpt/bim.nvim",
        event = "InsertEnter",
        config = function()
            require("bim").setup()
        end,
    },
    {
        "mcauley-penney/visual-whitespace.nvim",
        config = true,
        event = "ModeChanged *:[vV\22]",
        opts = {},
    },
    {
        "vidocqh/auto-indent.nvim",
        event = "InsertEnter",
        opts = {},
    },
    {
        "soulis-1256/eagle.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "dnlhc/glance.nvim",
        cmd = "Glance",
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        config = function()
            require("tiny-inline-diagnostic").setup({
                show_diagnostic_text = true,
            })
        end,
    },
    {
        "mawkler/modicator.nvim",
        event = "VeryLazy",
        dependencies = "rose-pine/neovim",
        init = function()
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {
            show_warnings = true,
        },
    },
    {
        "tris203/precognition.nvim",
        opts = {},
    },

    {
        "smjonas/inc-rename.nvim",
        event = "VeryLazy",
        opts = {},
    },
    -- 项目管理
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup({
                detection_methods = { "lsp", "pattern" },
                patterns = {
                    ".git",
                    "_darcs",
                    ".hg",
                    ".bzr",
                    ".svn",
                    "Makefile",
                    "package.json",
                    "Cargo.toml",
                    "pyproject.toml",
                },
                ignore_lsp = {},
                exclude_dirs = {},
                show_hidden = false,
                silent_chdir = true,
                scope_chdir = "global",
            })
            pcall(require("telescope").load_extension, "projects")
        end,
    },

    {
        "stevearc/aerial.nvim", -- symbols-outline 的替代品
        cmd = "AerialToggle",
        event = "VeryLazy",
        keys = {
            { "<leader>so", "<cmd>AerialToggle<CR>", desc = "切换符号大纲" },
        },
        config = true,
    },

    -- Markdown 预览和编辑增强
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },

    -- 高级搜索和替换
    {
        "nvim-pack/nvim-spectre",
        build = false,
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        keys = {
            {
                "<leader>sr",
                function()
                    require("spectre").open()
                end,
                desc = "替换 (Spectre)",
            },
        },
    },

    -- 更好的快速修复窗口
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        config = function()
            require("bqf").setup({
                auto_enable = true,
                auto_resize_height = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = { "┃", "━", "┏", "┓", "┗", "┛", "┣", "┫", "━", "┃" },
                    should_preview_cb = function(bufnr, qwinid)
                        local ret = true
                        local bufname = vim.api.nvim_buf_get_name(bufnr)
                        local fsize = vim.fn.getfsize(bufname)
                        if fsize > 100 * 1024 then
                            ret = false
                        end
                        return ret
                    end,
                },
                func_map = {
                    drop = "o",
                    openc = "O",
                    split = "<C-s>",
                    tabdrop = "<C-t>",
                    tabc = "",
                    ptogglemode = "z,",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    },

    { "echasnovski/mini.animate", version = "*", event = "VeryLazy" },

    -- 函数签名帮助
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require("lsp_signature").setup(opts)
        end,
    },

    -- 增强的语法高亮和代码折叠
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
                on_attach = nil,
            })
        end,
    },

    -- 时间管理
    {
        "epwalsh/pomo.nvim",
        version = "*",
        cmd = { "TimerStart", "TimerRepeat" },
        dependencies = {
            "rcarriga/nvim-notify",
        },
        opts = {
            sessions = {
                pomodoro = {
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                    { name = "Work", duration = "25m" },
                    { name = "Long Break", duration = "15m" },
                },
                contest = {
                    { name = "Contest", duration = "2h" },
                    { name = "Review", duration = "30m" },
                },
            },
        },
    },
    -- 更好的导航
    {
        "andymass/vim-matchup",
        event = "VeryLazy",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    -- 文本对象增强
    {
        "echasnovski/mini.ai",
        version = "*",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        event = "VeryLazy",
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        opts = {},
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                },
                formatters = {
                    stylua = {
                        args = {
                            "--indent-width",
                            "4",
                            "--indent-type",
                            "Spaces",
                            "--search-parent-directories",
                            "--stdin-filepath",
                            "$FILENAME",
                            "-",
                        },
                    },
                    ["clang-format"] = {
                        args = {
                            "--style={BasedOnStyle: Google, IndentWidth: 4, UseTab: Never}",
                            "--assume-filename",
                            "$FILENAME",
                        },
                    },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "切换文件树" },
        },
        config = function()
            local function on_attach(bufnr)
                local api = require("nvim-tree.api")
                local base_opts = { noremap = true, silent = true, nowait = true, buffer = bufnr }

                local function create_and_open()
                    api.fs.create()
                    api.node.open.edit()
                end

                vim.keymap.set("n", "<CR>", api.node.open.edit, vim.tbl_extend("force", base_opts, { desc = "打开" }))
                vim.keymap.set("n", "o", api.node.open.edit, vim.tbl_extend("force", base_opts, { desc = "打开" }))
                vim.keymap.set(
                    "n",
                    "s",
                    api.node.open.vertical,
                    vim.tbl_extend("force", base_opts, { desc = "垂直分割窗口打开" })
                )
                vim.keymap.set(
                    "n",
                    "<BS>",
                    api.node.navigate.parent_close,
                    vim.tbl_extend("force", base_opts, { desc = "关闭目录" })
                )
                vim.keymap.set(
                    "n",
                    "-",
                    api.tree.change_root_to_parent,
                    vim.tbl_extend("force", base_opts, { desc = "返回上级目录" })
                )
                vim.keymap.set(
                    "n",
                    "<C-]>",
                    api.tree.change_root_to_node,
                    vim.tbl_extend("force", base_opts, { desc = "设为根目录" })
                )
                vim.keymap.set(
                    "n",
                    "a",
                    create_and_open,
                    vim.tbl_extend("force", base_opts, { desc = "新建并打开" })
                )
                vim.keymap.set("n", "d", api.fs.remove, vim.tbl_extend("force", base_opts, { desc = "删除" }))
                vim.keymap.set("n", "r", api.fs.rename, vim.tbl_extend("force", base_opts, { desc = "重命名" }))
                vim.keymap.set("n", "c", api.fs.copy.node, vim.tbl_extend("force", base_opts, { desc = "复制" }))
                vim.keymap.set("n", "x", api.fs.cut, vim.tbl_extend("force", base_opts, { desc = "剪切" }))
                vim.keymap.set("n", "p", api.fs.paste, vim.tbl_extend("force", base_opts, { desc = "粘贴" }))
                vim.keymap.set(
                    "n",
                    "y",
                    api.fs.copy.filename,
                    vim.tbl_extend("force", base_opts, { desc = "复制文件名" })
                )
                vim.keymap.set(
                    "n",
                    "H",
                    api.tree.toggle_hidden_filter,
                    vim.tbl_extend("force", base_opts, { desc = "切换显示隐藏文件" })
                )
                vim.keymap.set(
                    "n",
                    "q",
                    api.tree.close,
                    vim.tbl_extend("force", base_opts, { desc = "关闭文件树" })
                )
                vim.keymap.set("n", "R", api.tree.reload, vim.tbl_extend("force", base_opts, { desc = "刷新" }))
                vim.keymap.set("n", "g?", api.tree.toggle_help, vim.tbl_extend("force", base_opts, { desc = "帮助" }))
            end

            require("nvim-tree").setup({
                sync_root_with_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
                filters = {
                    dotfiles = false,
                },
                view = {
                    side = "left",
                    width = 30,
                },
                on_attach = on_attach,
            })
        end,
    },
    -- 在neovim中用默认浏览器打开URL
    {
        "sontungexpt/url-open",
        event = "VeryLazy",
        cmd = "URLOpenUnderCursor",
        config = function()
            local status_ok, url_open = pcall(require, "url-open")
            if not status_ok then
                return
            end
            url_open.setup({})
        end,
    },
    -- 测试运行器
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "alfaix/neotest-gtest", -- C++ Google Test
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    ["neotest-gtest"] = {},
                },
            })

            -- 测试快捷键
            vim.keymap.set("n", "<leader>tt", function()
                require("neotest").run.run()
            end, { desc = "运行最近的测试" })
            vim.keymap.set("n", "<leader>tf", function()
                require("neotest").run.run(vim.fn.expand("%"))
            end, { desc = "运行文件中的所有测试" })
            vim.keymap.set("n", "<leader>ts", function()
                require("neotest").summary.toggle()
            end, { desc = "切换测试摘要" })
            vim.keymap.set("n", "<leader>to", function()
                require("neotest").output.open({ enter = true })
            end, { desc = "打开测试输出" })
        end,
    },

    -- 测试运行器
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "alfaix/neotest-gtest", -- C++ Google Test
        },
        -- 延迟加载，按需加载
        event = "VeryLazy",
        keys = {
            {
                "<leader>tt",
                function()
                    require("neotest").run.run()
                end,
                desc = "运行最近的测试",
            },
            {
                "<leader>tf",
                function()
                    require("neotest").run.run(vim.fn.expand("%"))
                end,
                desc = "运行文件中的所有测试",
            },
            {
                "<leader>ts",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "切换测试摘要",
            },
            {
                "<leader>to",
                function()
                    require("neotest").output.open({ enter = true })
                end,
                desc = "打开测试输出",
            },
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    ["neotest-gtest"] = {},
                },
            })
        end,
    },

    -- 代码覆盖率显示
    {
        "andythigpen/nvim-coverage",
        dependencies = "nvim-lua/plenary.nvim",
        -- 延迟加载，仅当需要时加载
        cmd = { "Coverage", "CoverageLoad", "CoverageSummary", "CoverageToggle" },
        keys = {
            {
                "<leader>cc",
                function()
                    require("coverage").load(true)
                end,
                desc = "加载覆盖率",
            },
            {
                "<leader>cs",
                function()
                    require("coverage").summary()
                end,
                desc = "覆盖率摘要",
            },
            {
                "<leader>ct",
                function()
                    require("coverage").toggle()
                end,
                desc = "切换覆盖率显示",
            },
        },
        config = function()
            require("coverage").setup({
                commands = true,
                highlights = {
                    covered = { fg = "#C3E88D" },
                    uncovered = { fg = "#F07178" },
                },
                signs = {
                    covered = { hl = "CoverageCovered", text = "▎" },
                    uncovered = { hl = "CoverageUncovered", text = "▎" },
                },
                summary = {
                    min_coverage = 80.0,
                },
                lang = {
                    c = {
                        coverage_command = "llvm-cov export --instr-profile=default.profdata ./your_binary --format=text",
                    },
                    cpp = {
                        coverage_command = "llvm-cov export --instr-profile=default.profdata ./your_binary --format=text",
                    },
                },
            })
        end,
    },
    {
        "michaelb/sniprun",
        ft = { "c", "cpp" },
        build = "sh install.sh 1",
        keys = {
            { "<leader>r", "<cmd>SnipRun<CR>", desc = "运行当前行代码", mode = "n" },
            { "<leader>R", ":'<,'>SnipRun<CR>", desc = "运行选中代码", mode = "v" },
        },
        opts = {
            -- 显示方式：可以选择多个
            display = {
                "VirtualTextOk", -- 成功时在代码旁显示
                "VirtualTextErr", -- 错误时在代码旁显示
                "TempFloatingWindow", -- 临时浮动窗口显示完整输出
            },

            -- 无输出时的显示设置
            show_no_output = {
                "Classic",
                "TempFloatingWindow",
            },

            -- 工作目录
            cwd = ".",

            -- 自定义颜色
            snipruncolors = {
                SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000" },
                SniprunFloatingWinOk = { fg = "#66eeff" },
                SniprunVirtualTextErr = { bg = "#881515", fg = "#000000" },
                SniprunFloatingWinErr = { fg = "#881515", bold = true },
            },

            -- 实时模式
            live_mode_toggle = "off",

            -- 兼容性设置
            ansi_escape = true, -- 移除 ANSI 颜色代码
            inline_messages = false, -- 是否单行显示

            -- 边框样式
            borders = "single", -- none, single, double, shadow

            -- C/C++ 解释器选项
            interpreter_options = {
                c = {
                    compiler = "clang",
                    args = "-Wall",
                },
                cpp = {
                    compiler = "clang++",
                    standard = "-std=c++17",
                    args = "-Wall",
                },
            },
        },
    },
}
