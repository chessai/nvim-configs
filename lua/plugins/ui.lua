return {
  -- nicer vim.ui.input (e.g. renaming) and vim.ui.select (e.g. code actions)
  {
    'stevearc/dressing.nvim',
    opts = {
      select = {
        enabled = false, -- use telescope-ui-select instead
      },
    },
  },

  -- sets vim.ui.select to telescope
  'nvim-telescope/telescope-ui-select.nvim',

  -- nicer vim.notify
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      vim.notify = notify
      notify.setup({
        timeout = 3000,
        stages = 'fade',
      })
    end,
  }
}
