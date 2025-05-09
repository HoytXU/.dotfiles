return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = "dragon",
        background = {
          dark = "dragon",
          light = "lotus"
        },
      })

      vim.cmd("colorscheme kanagawa")
    end,
  }
}
