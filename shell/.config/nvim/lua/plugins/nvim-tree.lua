return {
{
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 图标支持（强烈推荐）
  },
  config = function()
    -- 禁用老掉牙的 netrw, 已经在setting中实现
    -- vim.g.loaded_netrw = 1
    -- vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = true,
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "name",
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false, -- 是否显示 . 文件
      },
      update_focused_file = {
        enable = true,         -- 自动跳转到当前文件
        update_root = false,   -- 是否自动改变 root（关掉更稳）
      },
      git = {
        enable = true,
        ignore = false,        -- 显示 .gitignore 忽略的文件
      },
      actions = {
        open_file = {
          quit_on_open = true, -- 打开文件后关闭 tree
        },
      },
    })
     
    -- 快捷键打开/关闭文件树, 在keybinds.lua中已经设置
    -- vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end,
}
}
