return {
  'sanfusu/neovim-undotree',
  keys = {
    {
      '<Leader>u',
      '<cmd>UndotreeToggle<CR>',
      mode = 'n',
      noremap = true,
      desc = 'toggle undo tree',
    },
  },
}
