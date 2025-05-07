return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim", -- 不需要 mason.nvim 本体，因为在 mason.lua 配置了
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- 👇 只负责配置 LSP 安装器
      local servers = { "lua_ls", "rust_analyzer", "pylsp" }
      mason_lspconfig.setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      -- 🚀 按键绑定
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true, noremap = true }
        local map = vim.keymap.set
        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "K", vim.lsp.buf.hover, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        map("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        map("n", "<space>D", vim.lsp.buf.type_definition, opts)
        map("n", "<space>rn", vim.lsp.buf.rename, opts)
        map("n", "<space>ca", vim.lsp.buf.code_action, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
        map("n", "<space>e", vim.diagnostic.open_float, opts)
        map("n", "[d", vim.diagnostic.goto_prev, opts)
        map("n", "]d", vim.diagnostic.goto_next, opts)
        map("n", "<space>q", vim.diagnostic.setloclist, opts)
      end

      -- 🧠 LSP配置器
      for _, server in ipairs(servers) do
        local opts = {
          on_attach = on_attach,
        }

        if server == "lua_ls" then
          opts.settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          }
        end

        lspconfig[server].setup(opts)
      end
    end,
  },
}


