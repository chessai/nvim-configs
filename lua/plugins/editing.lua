return {
  -- repeat more things with .
  'kana/vim-repeat',

  -- inserting/changing/deleting delimiters
  { 'kylechui/nvim-surround', config = true },

  -- exchanging two regions
  'tommcdo/vim-exchange',

  -- easy commenting
  {
    'numToStr/Comment.nvim',
    config = true,
  },

  -- switch between single-line and multiline constructs
  {
    'Wansmer/treesj',
    keys = {
      { 'g<Space>', '<cmd>TSJToggle<CR>', mode = { 'n' }, noremap = true, desc = 'toggle node split' },
    },
    opts = {
      use_default_keymaps = false,
    },
  },
}
