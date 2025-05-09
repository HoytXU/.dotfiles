-- ╭─────────────────────────────────────────────────────────╮
-- │ Bootstrap lazy.nvim 插件管理器                         │
-- ╰─────────────────────────────────────────────────────────╯
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv and vim.fn.has("nvim-0.10") == 0 then
  vim.notify("lazy.nvim requires Neovim 0.10+ for optimal performance", vim.log.levels.WARN)
end

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    lazyrepo, lazypath
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "❌ Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- ╭─────────────────────────────────────────────────────────╮
-- │ 设置 leader 键，必须在加载 lazy.nvim 之前                │
-- ╰─────────────────────────────────────────────────────────╯
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ╭─────────────────────────────────────────────────────────╮
-- │ 启动 lazy.nvim 配置                                     │
-- ╰─────────────────────────────────────────────────────────╯
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- ⬅️ 你的插件目录在 lua/plugins 下
  },
  install = {
    colorscheme = { "monokai_pro", "habamax", "kanagawa"}, -- 安装阶段尝试这些配色
  },
  checker = {
    enabled = true,         -- 自动检查插件更新
    notify = false,         -- 不弹出更新通知（可选）
  },
  change_detection = {
    enabled = true,
    notify = false,         -- 不显示 config 文件变化提示
  },
})
