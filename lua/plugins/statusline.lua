-- statusline
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'catppuccin',
      globalstatus = true,
    },
    extensions = {
      'nvim-tree',
    },
    sections = {
      lualine_c = {
        -- show relative filepath in filename
        { 'filename', path = 1, }
      },
    },
    winbar = { lualine_c = { 'filename' } },
    inactive_winbar = { lualine_c = { 'filename' } },
  },
}
