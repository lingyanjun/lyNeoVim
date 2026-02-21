-- 保存时自动格式化
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

-- 设置 CursorHold 事件延迟为 100ms
vim.opt.updatetime = 100

-- 离开插入模式自动保存
vim.api.nvim_create_autocmd("InsertLeave", {
    group = augroup,
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "" and vim.bo.modifiable and vim.bo.modified then
            vim.cmd("silent write")
        end
    end,
    desc = "在离开插入模式时自动保存已修改的文件",
})
