return{
  {
    'preservim/nerdtree',
    config = function()
      -- Optional: You can add custom configuration here
      vim.api.nvim_set_keymap('n', '<leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
    end
  },
}


