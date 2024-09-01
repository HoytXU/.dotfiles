require'nvim-treesitter.configs'.setup {
  ensure_installed = {"c", "cpp"}, --  C++ syntax highlight 
  highlight = {
    enable = true,                
    additional_vim_regex_highlighting = false,
  },
}

return
{
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
    config = function()
			require("config.nvim-cmp")
		end,
  },
	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},

}
