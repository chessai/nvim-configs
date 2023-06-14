return {
  -- better commit message editing
  'rhysd/committia.vim',

  -- see commit message of last commit under cursor (<Leader>gm)
  'rhysd/git-messenger.vim',

  -- Generate gitignores
  {
    'wintermute-cell/gitignore.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
  },

  -- sign column
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- navigation
        map('n', ']h', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { desc = 'next hunk', expr = true })
        map('n', '[h', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { desc = 'previous hunk', expr = true })
        -- line operations
        map('n', '<Leader>gl', function() gs.blame_line { full = true } end, { desc = 'blame line' })
        -- hunk operations
        map({ 'n', 'x' }, '<Leader>ghs', ':Gitsigns stage_hunk<CR>', { desc = 'stage hunk' })
        map({ 'n', 'x' }, '<Leader>ghr', ':Gitsigns reset_hunk<CR>', { desc = 'reset hunk' })
        map('n', '<Leader>ghu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<Leader>ghp', gs.preview_hunk, { desc = 'preview hunk' })
        -- buffer operations
        map('n', '<Leader>gbdi', gs.diffthis, { desc = 'diff against index' })
        map('n', '<Leader>gbdp', function() gs.diffthis('~') end, { desc = 'diff against parent' })
        map('n', '<Leader>gbdd', function() gs.diffthis(vim.fn.input('ref: '):match('^%s*(.-)%s*$')) end,
          { desc = 'custom diff' })
        map('n', '<Leader>gbs', gs.stage_buffer, { desc = 'stage buffer' })
        map('n', '<Leader>gbr', gs.reset_buffer, { desc = 'reset buffer' })
        -- UI stuff
        map('n', '<Leader>gtb', gs.toggle_current_line_blame, { desc = 'toggle line blame overlay' })
        map('n', '<Leader>gtd', gs.toggle_deleted, { desc = 'toggle deleted lines' })
      end
    },
  },
}
