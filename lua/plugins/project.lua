return {
  {
    'ahmedkhalf/project.nvim',
    name = 'project_nvim',
    opts = {
      manual_mode = true,
      silent_chdir = false,
    },
    keys = {
      { '<Leader>cp', '<cmd>ProjectRoot<CR>', mode = { 'n' }, noremap = true, desc = 'cd to project root' },
    },
  },

  {
    'JellyApple102/flote.nvim',
    config = true,
    keys = {
      { '<Leader>n', '<cmd>Flote<CR>', mode = { 'n' }, noremap = true, desc = 'open project note' }
    },
  },
}
