-- 基础设置
local o = vim.opt
local g = vim.g

o.number = true                  -- 显示行号
o.relativenumber = true         -- 相对行号
o.clipboard = "unnamedplus"     -- 使用系统剪贴板
o.autoindent = true             -- 自动缩进
o.cursorline = true             -- 高亮当前行
o.expandtab = true              -- 使用空格代替 tab
o.shiftwidth = 2                -- 缩进宽度
o.tabstop = 2                   -- tab 字符宽度
o.ruler = true                  -- 显示光标位置
o.mouse = "a"                   -- 启用鼠标支持
o.title = true                  -- 显示窗口标题
o.ttimeoutlen = 0               -- 按键超时时间
o.wildmenu = true               -- 命令行补全增强
o.showcmd = true                -- 显示正在输入的命令
o.showmatch = true              -- 匹配括号高亮
o.inccommand = "split"          -- 实时预览 substitute 命令
o.splitright = true             -- 新窗口右侧打开
o.splitbelow = true             -- 新窗口下方打开
o.termguicolors = true          -- 启用 24-bit 颜色支持
o.fileencoding = "utf-8"        -- 文件编码

-- colorscheme 设置
local colorscheme = "kanagawa"

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
  vim.notify("colorscheme '" .. colorscheme .. "' not found!", vim.log.levels.WARN)
end
