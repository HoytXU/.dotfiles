return {
  "williamboman/mason.nvim",
  cmd = "Mason", -- 懒加载：只有在你 :Mason 的时候才加载
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
