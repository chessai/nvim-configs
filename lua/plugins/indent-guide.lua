-- show indent levels

return {
  'lukas-reineke/indent-blankline.nvim',
  opts = {
    enabled = 0,
    char = '│',
    defaultGroup = 'IndentLine',
  },
  keys = {
    {
      '<Leader>t<Tab>',
      ':IndentBlanklineToggle<CR>',
      mode = 'n',
      noremap = true,
      desc = 'toggle indent guides',
    },
  },
}
