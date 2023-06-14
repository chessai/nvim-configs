return {
  'mg979/vim-visual-multi',

  lazy = false,

  init = function()
    vim.g.VM_leader = '\\'
  end,

  keys = {
    {
      '<C-j>',
      '<Plug>(VM-Add-Cursor-Down)',
      mode = 'n',
      desc = 'add vm cursor down',
    },
    {
      '<C-k>',
      '<Plug>(VM-Add-Cursor-Up)',
      mode = 'n',
      desc = 'add vm cursor up',
    },
  }
}
