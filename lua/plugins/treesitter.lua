return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'mfussenegger/nvim-treehopper',
  },
  build = function()
    vim.api.nvim_command('TSUpdate')
  end,
  opts = function()
    local treesitter_configs = require('nvim-treesitter.configs')

    treesitter_configs.setup {
      -- List of parsers to ignore installing
      ignore_install = {},
      highlight = {
        -- false will disable the whole extension
        enable = true,
        -- list of language that will be disabled
        disable = {},
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<Tab>",
          node_decremental = "<S-CR>",
        },
      },
      -- nvim-ts-context-commentstring
      context_commentstring = {
        enable = true,
      },
    }

    -- nvim-ts-hint-textobject
    vim.keymap.set('o', 'm', ":<C-U>lua require('tsht').nodes()<CR>", { silent = true })
    vim.keymap.set('x', 'm', ":lua require('tsht').nodes()<CR>", { noremap = true, silent = true })
  end,
}
