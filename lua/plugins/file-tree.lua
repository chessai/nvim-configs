-- file browser
return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    respect_buf_cwd = true,
    view = {
      hide_root_folder = false,
      side = 'left',
      preserve_window_proportions = false,
      number = true,
      relativenumber = true,
      signcolumn = 'yes',
    },
    actions = {
      change_dir = {
        enable = true,
        global = true,
      },
    },
  },
  keys = {
    {
      '<Leader>d',
      '<cmd>NvimTreeFindFileToggle<CR>',
      mode = 'n',
      noremap = true,
      desc = 'toggle file tree',
    },
  },
}
