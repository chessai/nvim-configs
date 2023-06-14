-- vim.keymap.set, but defaults to { noremap = true }
local function map(mode, k, v, opts)
  opts = opts or {}
  if opts.noremap == nil then
    opts.noremap = true
  end
  vim.keymap.set(mode, k, v, opts)
end

-- Leader configuration {{{
do
  vim.g.mapleader = ' '
  map({ 'n', 'x', 'o' }, '<Space>', '<nop>', { noremap = false })
  map({ 'n', 'x', 'o' }, '<S-Space>', '<Space>', { noremap = false })
end
-- }}}

-- Essential {{{
do
  -- Work by visual line without a count, but normal when used with one
  map({ 'n', 'x', 'o' }, 'j', "(v:count == 0 ? 'gj' : 'j')", {
    silent = true,
    expr = true,
  })
  map({ 'n', 'x', 'o' }, 'k', "(v:count == 0 ? 'gk' : 'k')", {
    silent = true,
    expr = true,
  })
  -- Makes temporary macros faster
  map('n', 'Q', '@q', {
    desc = 'run @q',
  })
  -- Repeat macros/commands across visual selections
  map('x', 'Q', ':normal @q<CR>', {
    desc = 'linewise @q',
    silent = true,
  })
  map('x', '.', ':normal .<CR>', {
    desc = 'linewise .',
    silent = true,
  })
  -- Redraw page and clear highlights
  map({ 'n', 'v', 'o' }, '<C-l>', '<cmd>nohlsearch<CR><C-l>', {
    desc = 'redraw',
    silent = true,
  })
  -- Search word underneath cursor/selection but don't jump
  map('n', '*', '<cmd>let wv=winsaveview()<CR>*<cmd>call winrestview(wv)<CR>', {
    desc = 'search word forwards',
    silent = true,
  })
  map('n', '#', '<cmd>let wv=winsaveview()<CR>#<cmd>call winrestview(wv)<CR>', {
    desc = 'search word backwards',
    silent = true,
  })
  -- saving
  map('n', '<Leader>s', '<cmd>write<CR>', {
    desc = 'save buffer',
  })
  map('n', '<Leader>S', '<cmd>wall<CR>', {
    desc = 'save all',
  })
  -- changing directories
  map('n', '<Leader>cc', '<cmd>cd %:h<CR>', {
    desc = 'cd to current buffer',
  })
  map('n', '<Leader>cl', '<cmd>lcd %:h<CR>', {
    desc = 'lcd to current buffer',
  })
  map('n', '<Leader>cg', function()
    local result = vim.fn.system({ 'git', 'rev-parse', '--show-toplevel' })
    if vim.api.nvim_get_vvar('shell_error') ~= 0 then
      vim.notify('failed to get git root: ' .. result, vim.log.levels.ERROR)
      return
    end
    vim.cmd('cd ' .. result:gsub('\n$', ''))
  end, {
    desc = 'cd to git root',
  })
end
-- }}}

-- Buffers {{{
do
  map('n', '<Leader>bd', '<cmd>bdelete<CR>', {
    desc = 'delete buffer',
  })
  map('n', '<Leader>bX', '<cmd>bdelete!<CR>', {
    desc = 'kill buffer',
  })
  map('n', '<Leader>br', '<cmd>setlocal readonly!<CR>', {
    desc = 'toggle readonly',
  })
  -- Make unlisted scratch buffer
  vim.cmd([[command! Scratch new | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile]])
  map('n', '<Leader>bs', '<cmd>Scratch<CR>', {
    desc = 'open scratch buffer',
  })
end
-- }}}

-- Editing {{{
do
  -- Split current line by provided regex (\zs or \ze to preserve separators)
  map('n', 'gs', ':s//\\r/g<Left><Left><Left><Left><Left>', {
    desc = 'regex split line',
  })

  -- Start a visual substitute
  map('x', 'gs', ':s/\\%V', {
    desc = 'visual substitute',
  })

  -- Delete trailing whitespace and retab
  map('n', '<Leader><Tab>', function()
    local wv = vim.fn.winsaveview()
    vim.cmd([[
      keeppatterns %s/\s\+\ze\r\=$//e
      nohlsearch
      retab
    ]])
    vim.fn.winrestview(wv)
  end, {
    desc = 'clean whitespace',
    silent = true,
  })
end
-- }}}

-- Registers {{{
do
  -- Copy contents of register to another (provides ' as an alias for ")
  map('n', '<Leader>r', function()
    local r1 = (vim.fn.nr2char(vim.fn.getchar())):gsub("'", '"')
    local r2 = (vim.fn.nr2char(vim.fn.getchar())):gsub("'", '"')
    vim.api.nvim_command('let @' .. r2 .. '=@' .. r1)
    vim.notify('Copied @' .. r1 .. ' to @' .. r2, vim.log.levels.INFO)
  end, {
    desc = 'register copy',
    silent = true,
  })
end
-- }}}

-- Matching navigation commands (like in unimpaired) {{{
do
  for lowerkey, cmd_desc in pairs({ b = { 'b', 'buffer' }, t = { 't', 'tab' }, q = { 'c', 'quickfix item' },
    l = { 'l', 'loclist item' } }) do
    local upperkey = lowerkey:upper()
    local cmd = cmd_desc[1]
    local desc = cmd_desc[2]
    map('n', "]" .. lowerkey, "<cmd>" .. cmd .. "next<CR>", {
      desc = 'next ' .. desc,
    })
    map('n', "[" .. lowerkey, "<cmd>" .. cmd .. "previous<CR>", {
      desc = 'previous ' .. desc,
    })
    map('n', "]" .. upperkey, "<cmd>" .. cmd .. "last<CR>", {
      desc = 'last ' .. desc,
    })
    map('n', "[" .. upperkey, "<cmd>" .. cmd .. "first<CR>", {
      desc = 'first ' .. desc,
    })
  end
end
-- }}}

-- Toggles {{{
do
  map('n', '<Leader>tw', '<cmd>setlocal wrap!<CR>', {
    desc = 'toggle line wrapping',
  })
  map('n', '<Leader>tna', '<cmd>setlocal number norelativenumber<CR>', {
    desc = 'absolute line numbers',
  })
  map('n', '<Leader>tnr', '<cmd>setlocal number relativenumber<CR>', {
    desc = 'relative line numbers',
  })
  map('n', '<Leader>tnd', '<cmd>setlocal nonumber norelativenumber<CR>', {
    desc = 'disable line numbers',
  })
  map('n', '<Leader>tb', function() vim.opt.laststatus = vim.opt.laststatus:get() == 0 and 2 or 0 end, {
    desc = 'toggle statusline',
  })
  map('n', '<Leader>t!', function() vim.opt.signcolumn = vim.opt.signcolumn:get() == 'no' and 'yes' or 'no' end, {
    desc = 'toggle sign column',
  })
  map('n', '<Leader>tz', '<cmd>setlocal spell!<CR>', {
    desc = 'toggle spelling',
  })
  map('n', '<Leader>tf', function() vim.opt.foldcolumn = vim.opt.foldcolumn:get() == 0 and 1 or 0 end, {
    desc = 'toggle fold column',
  })
  map('n', '<Leader>tl', '<cmd>setlocal list!<CR>', {
    desc = 'toggle listchars',
  })

  -- indentation
  local function trim_str(s)
    return s:match('^%s*(.-)%s*$')
  end

  local function set_indent_to(indent_level, opts)
    local use_tabs = false
    if opts then
      use_tabs = opts.tabs or false
    end
    if use_tabs then
      vim.bo.expandtab = false
      vim.bo.tabstop = indent_level
      vim.bo.softtabstop = 0
      vim.bo.shiftwidth = indent_level
    else
      vim.bo.expandtab = true
      vim.bo.tabstop = indent_level
      vim.bo.softtabstop = indent_level
      vim.bo.shiftwidth = indent_level
    end
    vim.api.nvim_command('redraw')
    local msg = ''
    msg = msg .. 'ts=' .. vim.bo.tabstop
    msg = msg .. ', sts=' .. vim.bo.softtabstop
    msg = msg .. ', sw=' .. vim.bo.shiftwidth
    msg = msg .. ', et=' .. (vim.bo.expandtab and 1 or 0)
    print(msg)
  end

  map('n', '<Leader>ti=', function()
    local input = trim_str(vim.fn.input('ts=sts=sw='))
    local indent_level = tonumber(input)
    if indent_level then
      set_indent_to(indent_level)
    else
      print('invalid indent: ' .. input)
    end
  end, {
    desc = 'set indentation',
  })
  map('n', '<Leader>ti2', function() set_indent_to(2) end, {
    desc = 'indent 4 spaces',
  })
  map('n', '<Leader>ti4', function() set_indent_to(4) end, {
    desc = 'indent 2 spaces',
  })
  map('n', '<Leader>ti<Tab>', function() set_indent_to(4, { tabs = true }) end, {
    desc = 'indent with tabs',
  })

  -- colorcolumn
  map('n', '<Leader>tcd', '<cmd>setlocal colorcolumn=<CR>', {
    desc = 'disable colorcolumn',
  })
  map('n', '<Leader>tc1', '<cmd>setlocal colorcolumn=+1<CR>', {
    desc = 'colorcolumn at textwidth + 1',
  })
  map('n', '<Leader>tc=', function() vim.wo.colorcolumn = trim_str(vim.fn.input('colorcolumn=')) end, {
    desc = 'set colorcolumn',
  })
end
-- }}}

-- Wiki {{{
do
  map('n', '<Leader>wo', "<cmd>edit ~/wiki/index.md<CR>", {
    desc = "open the wiki",
  })
  map('n', '<Leader>wt', function()
    vim.cmd('edit ~/wiki/notes/thoughts/' .. os.date('%Y-%W') .. '.md')
  end, { desc = "open this week's thoughts page" })
  map('n', '<Leader>wl', function()
    vim.cmd('edit ~/wiki/notes/thoughts/' .. os.date('%Y') .. '-' .. (os.date('%W') - 1) .. '.md')
  end, { desc = "open last week's thoughts page" })
  map('n', '<Leader>wd', function()
    vim.cmd('edit ~/wiki/diary/' .. os.date('%Y-%m-%d') .. '.md')
  end, { desc = "open today's diary page" })
end
-- }}}

-- Abbreviations {{{
do
  local function iabbrev(k, v, opts)
    local optstr = ''
    if opts.expr then
      optstr = optstr .. '<expr> '
    end
    vim.api.nvim_command('iabbrev ' .. optstr .. k .. ' ' .. v)
  end

  -- Common sequences
  iabbrev('xaz', "<C-r>='abcdefghijklmnopqrstuvwxyz'<CR>", {})
  iabbrev('xAZ', "<C-r>='ABCDEFGHIJKLMNOPQRSTUVWXYZ'<CR>", {})
  iabbrev('x09', "<C-r>='0123456789'<CR>", {})
end
-- }}}

-- vim:foldmethod=marker
