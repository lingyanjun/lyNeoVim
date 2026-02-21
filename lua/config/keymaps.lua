local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local kmap = vim.api.nvim_set_keymap

-- 标签页快捷操作
kmap(
    "n",
    "<c-2>",
    "<Plug>(cokeline-switch-prev)",
    vim.tbl_extend("force", opts, {
        desc = "将标签页向右移动",
    })
)
kmap(
    "n",
    "<c-1>",
    "<Plug>(cokeline-switch-next)",
    vim.tbl_extend("force", opts, {
        desc = "将标签页向左移动",
    })
)
kmap("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
kmap("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
for i = 1, 9 do
    kmap("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
    kmap("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
end

-- 缩进
map("v", "<", "<gv", vim.tbl_extend("force", opts, { desc = "向左缩进" }))
map("v", ">", ">gv", vim.tbl_extend("force", opts, { desc = "向右缩进" }))

-- 终端开启
map("n", "<leader>t", ":terminal<CR>", {
    noremap = true,
    silent = true,
    desc = "打开/关闭终端",
})

-- 添加 option+上下移动当前行
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("n", "<A-Down>", ":m .+1<CR>==", opts)
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- 添加 V模式下 Ctrl+C 复制 Ctrl+X 剪切
map("v", "<C-c>", '"+y', opts)
map("v", "<C-x>", '"+d', opts)

-- 添加 cmd+/ 快速注释
map("n", "<C-/>", "gcc", opts)
map("v", "<C-/>", "gc", opts)

-- buffer move
map("n", "<leader>[", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<leader>]", "<Cmd>BufferNext<CR>", opts)
map("n", "<leader>w", "<Cmd>BufferClose<CR>", opts)
map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)

-- nvim-tree 快捷键
map("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" }) -- 打开/关闭文件树
map("n", "<leader>E", "<Cmd>NvimTreeFindFile<CR>", { desc = "Reveal current file in tree" }) -- 在文件树中定位当前文件
map("n", "<leader>f", "<Cmd>NvimTreeFindFile<CR>", { desc = "Focus tree at current file" }) -- 聚焦文件树并定位到当前文件
map("n", "<leader>r", "<Cmd>NvimTreeRefresh<CR>", { desc = "Refresh nvim-tree" }) -- 刷新文件树
map("n", "<leader>ec", "<Cmd>NvimTreeClose<CR>", { desc = "Close nvim-tree" }) -- 关闭文件树

-- Telescope 快捷键（文件搜索）
map("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, { desc = "Telescope find files" })
map("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()
end, { desc = "Telescope live grep" })
map("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
end, { desc = "Telescope buffers" })
map("n", "<leader>fh", function()
    require("telescope.builtin").help_tags()
end, { desc = "Telescope help tags" })

-- LSP 快捷键（代码智能提示）
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic in float window" }) -- 显示光标处诊断信息（错误/警告）
map("n", "<leader>ee", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" }) -- 将所有诊断添加到位置列表
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" }) -- 跳转到定义
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" }) -- 跳转到声明
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" }) -- 跳转到实现
map("n", "gr", vim.lsp.buf.references, { desc = "Show references" }) -- 查看引用
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" }) -- 跳转到类型定义
map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" }) -- 悬停显示文档
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" }) -- 重命名
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" }) -- 代码操作
map({ "n", "v" }, "<leader>fm", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    })
end, { desc = "Format file or range" }) -- 格式化文件或选中区域
map("n", "<leader>s", vim.lsp.buf.document_symbol, { desc = "Show document symbols" }) -- 文档符号
map("n", "<leader>S", vim.lsp.buf.workspace_symbol, { desc = "Show workspace symbols" }) -- 工作区符号
map("i", "<C-h>", vim.lsp.buf.signature_help, { desc = "Show signature help" }) -- 插入模式下显示签名帮助
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Quickfix list" }) -- 快速修复列表
map("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" }) -- 上一个诊断
map("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Next diagnostic" }) -- 下一个诊断

-- 智能左右方向键：跨行跳转
local function smart_left()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    if col == 0 and row > 1 then
        local prev_line_length = vim.fn.col({ row - 1, "$" }) - 1
        local mode = vim.fn.mode()
        local target_col = (mode == "i") and prev_line_length or math.max(0, prev_line_length - 1)

        vim.api.nvim_win_set_cursor(0, { row - 1, target_col })
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true)
    end
end

local function smart_right()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line_length = vim.fn.col({ row, "$" }) - 1 -- 获取行的实际长度
    local total_lines = vim.api.nvim_buf_line_count(0)
    local mode = vim.fn.mode()

    local at_line_end = false
    if mode == "i" then
        -- 插入模式：可以在真正的行末（换行符位置）
        at_line_end = (col >= line_length)
    else
        -- normal/visual模式：行末是最后一个字符的位置
        at_line_end = (col >= line_length - 1 and line_length > 0)
    end

    if at_line_end and row < total_lines then
        -- 当前在行末且不是最后一行，跳到下一行开头
        vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
    else
        -- 正常右移
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "n", true)
    end
end

-- 智能左右方向键映射（适用于所有模式）
map(
    { "n", "i", "v" },
    "<Left>",
    smart_left,
    vim.tbl_extend("force", opts, { desc = "智能左移：行首时跳到上一行末尾" })
)
map(
    { "n", "i", "v" },
    "<Right>",
    smart_right,
    vim.tbl_extend("force", opts, { desc = "智能右移：行末时跳到下一行开头" })
)

-- 代码运行快捷键
map("n", "<leader>rr", ":RunCode<CR>", { desc = "运行当前代码" })
map("n", "<leader>rf", ":RunFile<CR>", { desc = "运行当前文件" })
map("n", "<leader>rc", ":RunClose<CR>", { desc = "关闭运行窗口" })
-- 快速选择运行模式
map("n", "<leader>rm", function()
    local modes = { "float", "split", "tab" }
    vim.ui.select(modes, { prompt = "选择运行模式:" }, function(mode)
        if mode then
            require("code_runner").change_mode(mode)
            print("运行模式已切换为: " .. mode)
        end
    end)
end, { desc = "切换运行模式" })

-- TODO快捷键
map("n", "<leader>td", "<cmd>TodoTelescope<CR>", { desc = "查看所有 TODO" })
map("n", "<leader>tD", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", { desc = "查看待办事项" })
-- 快速跳转
map("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "下一个 TODO" })
map("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "上一个 TODO" })
-- 高亮开关
map("n", "<leader>th", function()
    require("todo-comments").toggle()
end, { desc = "切换 TODO 高亮" })

