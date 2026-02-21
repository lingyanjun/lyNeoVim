My Neovim 配置

🚀 一个现代、功能丰富的 Neovim 配置，专注于提升开发体验

📋 概述

这是我的个人 Neovim 配置，使用 Lua 编写，由 lazy.nvim 管理。旨在提供一个流畅、高效的开发环境，重点关注 C/C++ 开发、现代 IDE 功能和美观的界面。

✨ 功能特性

🎨 外观与体验

· Everforest 主题 - 护眼配色
· Lualine - 美观的状态栏，显示诊断和 LSP 信息
· Cokeline - 带图标的标签栏，支持拖拽
· Alpha - 自定义启动页，显示启动统计
· Neoscroll - 平滑滚动动画
· Smear-cursor - 流畅光标动画
· Indent-blankline - 彩虹缩进线
· Nvim-ufo - 高级代码折叠
· Dropbar - 面包屑导航

🔧 开发工具

语言支持

· LSP - 完整的语言服务器协议支持
· Mason - LSP/DAP/linter 安装管理器
· Treesitter - 高级语法高亮和代码分析
· nvim-cmp - 智能自动补全，支持代码片段
· LSP Signature - 函数签名帮助

C/C++ 开发

· nvim-dap - 调试支持（使用 cpptools）
· neotest - 测试运行器（支持 Google Test）
· Sniprun - 内联代码运行
· 代码覆盖率 - 可视化覆盖率显示

代码质量

· Conform - 保存时自动格式化
· Trouble - 诊断/快速修复列表管理
· Todo Comments - 高亮和导航 TODO
· nvim-lightbulb - 显示代码操作提示

🔍 导航与搜索

· Telescope - 模糊查找器
· Flash - 闪电快速跳转
· Project.nvim - 项目管理
· Aerial - 符号大纲
· Wildfire - 快速选择文本对象
· vim-illuminate - 高亮相同单词

⚡ 效率工具

· Which-key - 快捷键提示
· Noice - 增强的消息/命令行界面
· nvim-notify - 美观的通知
· Neominimap - 代码迷你地图
· Zen-mode - 无干扰编码模式
· Pomo - 番茄钟定时器
· Spectre - 高级搜索替换
· Inc-rename - 实时 LSP 重命名

📝 特殊功能

· Claude Code - AI 助手集成
· Markdown Preview - 实时 Markdown 渲染
· Carbon-now - 代码截图
· Nerdy - 图标选择器
· nvim-highlight-colors - 颜色代码预览
· url-open - 打开光标下的 URL

🎯 快捷键

主键位：<Space>

📁 文件导航

快捷键 功能
<Space>e 切换文件树
<Space>E 在文件树中定位当前文件
<Space>ff 查找文件
<Space>fg 全文搜索
<Space>fb 浏览缓冲区
<Space>fh 帮助标签
<Space>so 切换符号大纲

📊 缓冲区管理

快捷键 功能
<Tab> 下一个缓冲区
<S-Tab> 上一个缓冲区
<Space>[ 上一个缓冲区
<Space>] 下一个缓冲区
<Space>w 关闭缓冲区
<Space>1-9 跳转到缓冲区 1-9
<F1>-<F9> 聚焦缓冲区 1-9
<C-1> 将缓冲区左移
<C-2> 将缓冲区右移

🔍 LSP 与诊断

快捷键 功能
gd 跳转到定义
gD 跳转到声明
gi 跳转到实现
gr 查看引用
gt 跳转到类型定义
K 显示悬停文档
<Space>rn 重命名符号
<Space>ca 代码操作
<Space>fm 格式化代码
<Space>d 显示诊断信息
<Space>dp 上一个诊断
<Space>dn 下一个诊断

🐛 调试

快捷键 功能
<Space>ds 开始/继续调试
<Space>do 单步跳过
<Space>di 单步进入
<Space>dq 单步退出
<Space>b 切换断点
<Space>B 设置条件断点
<Space>dr 打开调试 REPL
<Space>dl 运行上次调试
<Space>du 切换调试 UI

🏃 运行代码

快捷键 模式 功能
<Space>rr n 运行当前代码
<Space>rf n 运行当前文件
<Space>rc n 关闭运行窗口
<Space>r n 运行当前行
<Space>R v 运行选中代码

🔬 测试与覆盖率

快捷键 功能
<Space>tt 运行最近的测试
<Space>tf 运行文件中的所有测试
<Space>ts 切换测试摘要
<Space>to 打开测试输出
<Space>cc 加载覆盖率
<Space>cs 覆盖率摘要
<Space>ct 切换覆盖率显示

📌 TODO 管理

快捷键 功能
<Space>td 查看所有 TODO
<Space>tD 查看待办事项
]t 下一个 TODO
[t 上一个 TODO
<Space>th 切换 TODO 高亮

🛠️ 工具

快捷键 功能
<Space>t 打开终端
<Space>? 显示本地按键映射
<C-,> 唤出 Claude Code AI
<Space>xx 切换诊断列表
<Space>sr 全局搜索替换
<Space>pp v

📏 代码折叠

快捷键 功能
zR/zO 打开所有折叠
zM/zC 关闭所有折叠
zr 打开除指定类型外的折叠
zm 关闭所有折叠
K 预览折叠内容

🎯 快速跳转

快捷键 模式 功能
s n/x/o Flash 跳转
S n/x/o Treesitter 节点跳转
R o/x Treesitter 搜索

📝 基础操作

快捷键 模式 功能
<A-Up/Down> n/i/v 上下移动行
<C-c> v 复制到剪贴板
<C-x> v 剪切到剪贴板
<C-/> n/v 快速注释
</> v 缩进

🚀 快速开始

前置要求

· Neovim >= 0.9.0
· Git
· 支持真彩色的终端
· Nerd Font（推荐）
. 还有很多如clang等等，总之自己看着报错问AI吧，懒得写文档了😂😂

安装

```bash
# 备份现有配置
mv ~/.config/nvim ~/.config/nvim.bak

# 克隆配置
git clone https://github.com/lingyanjun/lyNeoVim.git ~/.config/nvim

# 启动 Neovim
nvim
```

首次启动会自动安装所有插件，请耐心等待。

📦 插件列表

<details>
<summary>点击展开完整插件列表</summary>

核心

· lazy.nvim - 插件管理器
· nvim-lspconfig - LSP 配置
· mason.nvim - LSP 安装器
· nvim-cmp - 补全框架
· nvim-treesitter - 语法高亮

UI

· everforest - 主题
· lualine.nvim - 状态栏
· nvim-tree.lua - 文件树
· alpha-nvim - 启动页
· indent-blankline.nvim - 缩进线

工具

· telescope.nvim - 模糊查找
· nvim-dap - 调试器
· neotest - 测试运行
· conform.nvim - 格式化
· which-key.nvim - 快捷键提示

... 更多插件请查看配置

</details>

⚙️ 自定义配置

配置文件结构：

```
~/.config/nvim/
├── init.lua              # 入口文件
├── lazy-lock.json        # 插件版本锁
└── lua/
    ├── config/           # 核心配置
    │   ├── options.lua   # 编辑器选项
    │   ├── keymaps.lua   # 快捷键
    │   ├── autocmds.lua  # 自动命令
    │   └── lazy.lua      # 插件管理器配置
    └── plugins/          # 插件配置
        ├── lsp.lua       # LSP 相关
        ├── nvim-cmp.lua  # 补全配置
        ├── nvim-dap.lua  # 调试配置
        ├── themes.lua    # 主题和 UI
        └── tool.lua      # 工具插件
```

📝 许可证

MIT

---

Happy Coding! 🎉