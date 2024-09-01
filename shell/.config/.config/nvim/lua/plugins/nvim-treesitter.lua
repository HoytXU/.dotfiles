return{
  --second plugin
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Automatically install or update parsers
    opts = {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "cpp", "lua", "python", "javascript", "html", "css" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- Enable highlighting using Tree-sitter
      highlight = {
        enable = true,

        -- Disable it in large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },

      -- Enable additional modules (optional)
      indent = { enable = true },  -- Better indentation
      rainbow = { enable = true },  -- Rainbow parentheses
      autotag = { enable = true },  -- Auto-close and auto-rename HTML tags
    },
  },
}

