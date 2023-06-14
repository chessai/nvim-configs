return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',

    lazy = false,
    priority = 1000,

    config = function()
      require('catppuccin').setup {
        integrations = {
          nvimtree = {
            show_root = true,
          },
          which_key = true,
        },
      }

      vim.api.nvim_command('colorscheme catppuccin-mocha')
    end,
  }
}
