return {
  {
    "preservim/nerdtree",
    cmd = { "NERDTreeToggle", "NERDTreeFind", "NERDTree" },
    keys = {
      { "<leader>n", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
    },
    init = function()
      -- 可选：例如设置 NERDTree 自动打开行为等
    end,
    config = function()
      -- 可选：如需要更多行为控制
    end,
  },
}