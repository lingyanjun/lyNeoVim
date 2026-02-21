return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        { "nvim-neotest/nvim-nio" },
        "theHamsta/nvim-dap-virtual-text",
    },
    -- 使用 lazy 加载，只有在需要调试时才加载
    cmd = {
        "DapContinue",
        "DapToggleBreakpoint",
        "DapStepOver",
        "DapStepInto",
        "DapStepOut",
        "DapReplOpen",
        "DapRunLast",
    },
    -- 按键触发加载
    keys = {
        {
            "<leader>ds",
            mode = "n",
            function()
                require("dap").continue()
            end,
            desc = "开始/继续调试",
        },
        {
            "<leader>do",
            mode = "n",
            function()
                require("dap").step_over()
            end,
            desc = "单步跳过",
        },
        {
            "<leader>di",
            mode = "n",
            function()
                require("dap").step_into()
            end,
            desc = "单步进入",
        },
        {
            "<leader>dq",
            mode = "n",
            function()
                require("dap").step_out()
            end,
            desc = "单步退出",
        },
        {
            "<leader>b",
            mode = "n",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "切换断点",
        },
        {
            "<leader>B",
            mode = "n",
            function()
                require("dap").set_breakpoint(vim.fn.input("断点条件: "))
            end,
            desc = "条件断点",
        },
        {
            "<leader>dr",
            mode = "n",
            function()
                require("dap").repl.open()
            end,
            desc = "打开调试 REPL",
        },
        {
            "<leader>dl",
            mode = "n",
            function()
                require("dap").run_last()
            end,
            desc = "运行上次调试",
        },
        -- 手动打开/关闭 DAP UI
        {
            "<leader>du",
            mode = "n",
            function()
                local ok, dapui = pcall(require, "dapui")
                if ok then
                    dapui.toggle()
                else
                    vim.notify("请先启动调试会话", vim.log.levels.WARN)
                end
            end,
            desc = "切换调试 UI",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- 延迟初始化 UI 组件，优化启动速度
        vim.schedule(function()
            dapui.setup()
            require("nvim-dap-virtual-text").setup()
        end)

        -- ============ C/C++ 调试配置 (使用 cpptools) ============
        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = "OpenDebugAD7", -- 如果是termux这里务必按照我的github的步骤，因为termux本身没有glibc库
            options = {
                detached = true, -- 安卓系统务必保持 true
            },
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtEntry = true,
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
            {
                name = "Attach to gdbserver :1234",
                type = "cppdbg",
                request = "launch",
                MIMode = "gdb",
                miDebuggerServerAddress = "localhost:1234",
                miDebuggerPath = "/data/data/com.termux/files/usr/bin/gdb",
                cwd = "${workspaceFolder}",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
        }
        dap.configurations.c = dap.configurations.cpp
        
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            local ok, dapui = pcall(require, "dapui")
            if ok then
                dapui.close()
                dap.repl.close() -- 同时关闭 repl 窗口
            end
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            local ok, dapui = pcall(require, "dapui")
            if ok then
                dapui.close()
                dap.repl.close() -- 同时关闭 repl 窗口
            end
        end

        -- 在调试会话中显示当前行指示器
        vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
        vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
        vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

        -- 断点符号
        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.fn.sign_define(
            "DapBreakpointCondition",
            { text = "🟡", texthl = "DapBreakpoint", linehl = "", numhl = "" }
        )
        vim.fn.sign_define("DapBreakpointRejected", { text = "⚪", texthl = "DapBreakpoint", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DapLogPoint", linehl = "", numhl = "" })
        vim.fn.sign_define(
            "DapStopped",
            { text = "➡️", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
        )
    end,
}

