-- nvim-ufo 折叠插件配置
return {
    {
        "kevinhwang91/promise-async",
        lazy = true, -- 改为懒加载，由 nvim-ufo 自动加载
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" }, -- 使用 dependencies 替代 requires
        event = { "BufReadPost", "BufNewFile" }, -- 打开文件时加载
        config = function()
            -- 基础折叠设置
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            -- 根据文件类型选择折叠提供者
            local ftMap = {
                vim = "indent",
                c = { "lsp", "treesitter" },
                lua = { "lsp", "indent" },
            }

            local ufo = require("ufo")

            -- 自定义折叠文本显示
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ("  %d "):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0

                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, "MoreMsg" })
                return newVirtText
            end

            -- Ufo 主配置
            ufo.setup({
                open_fold_hl_timeout = 150,

                close_fold_kinds_for_ft = {
                    default = { "imports", "comment" },
                    json = { "array" },
                    c = { "comment", "region" },
                    lua = { "comment" },
                },

                close_fold_current_line_for_ft = {
                    default = true,
                    c = false,
                },

                preview = {
                    win_config = {
                        border = { "", "─", "", "", "", "─", "", "" },
                        winhighlight = "Normal:Folded",
                        winblend = 0,
                    },
                    mappings = {
                        scrollU = "<C-u>",
                        scrollD = "<C-d>",
                        jumpTop = "[",
                        jumpBot = "]",
                    },
                },

                provider_selector = function(bufnr, filetype, buftype)
                    return ftMap[filetype] or { "lsp", "indent" }
                end,

                fold_virt_text_handler = handler,
            })

            -- 基础折叠键映射（添加 desc 以便 which-key 显示）
            vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "打开所有折叠" })
            vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "关闭所有折叠" })
            vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "打开除指定类型外的折叠" })
            vim.keymap.set("n", "zm", function()
                ufo.closeFoldsWith(0)
            end, { desc = "关闭所有折叠" })

            -- 预览折叠内容
            vim.keymap.set("n", "K", function()
                local winid = ufo.peekFoldedLinesUnderCursor()
                if not winid then
                    if pcall(require, "coc") then
                        vim.fn.CocActionAsync("definitionHover")
                    else
                        vim.lsp.buf.hover()
                    end
                end
            end, { desc = "预览折叠/LSP悬停" })

            -- 递归打开/关闭折叠（添加别名映射）
            vim.keymap.set("n", "zO", function()
                ufo.openAllFolds()
            end, { desc = "打开所有折叠" })

            vim.keymap.set("n", "zC", function()
                ufo.closeAllFolds()
            end, { desc = "关闭所有折叠" })

            -- LSP 折叠能力配置
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
        end,
    },
}
