return {
  -- kanagawa 主题
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
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.catppuccin_flavour = "mocha" -- 可选: "latte", "frappe", "macchiato", "mocha"
      require("catppuccin").setup({
        flavour = vim.g.catppuccin_flavour,
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- 可选: "storm", "moon", "night", "day"
        transparent = false,
        terminal_colors = true,
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon", -- 可选: "main", "moon", "dawn"
        dark_variant = "moon",
      })
      vim.cmd.colorscheme("rose-pine")
    end,
  },

  -- Gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark" -- 可选: "light", "dark"
      require("gruvbox").setup({
        contrast = "hard", -- 可选: "soft", "medium", "hard"
        transparent_mode = false,
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
