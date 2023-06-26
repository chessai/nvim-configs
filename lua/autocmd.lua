local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general_group = augroup('general_group', { clear = true })

autocmd({ 'FileType' }, {
  group = general_group,
  pattern = 'help',
  command = 'wincmd L',
  desc = 'Open help window on right by default',
})

autocmd({ 'BufReadPost' }, {
  group = general_group,
  command = [[
    if line("'\"") > 1 && line("'\"") <= line("$")
      execute "normal! g`\""
    endif
  ]],
  desc = 'Return to last edit position when opening files',
})

-- Highlighting

local highlight_group = augroup('highlight_group', { clear = true })

autocmd({ 'ColorScheme' }, {
  group = highlight_group,
  command = 'highlight SpecialKey guifg=LightBlue',
  desc = 'Highlight non-printable characters',
})
autocmd({ 'ColorScheme' }, {
  group = highlight_group,
  command = 'highlight NonText guifg=LightBlue',
  desc = 'Highlight listchars',
})
autocmd({ 'ColorScheme' }, {
  group = highlight_group,
  command = 'highlight Whitespace guifg=LightBlue',
})

-- Highlight trailing whitespace

local trailspace_group_name = 'ExtraWhitespace'

local function trailspace_unhighlight()
  for _, match in ipairs(vim.fn.getmatches()) do
    if match.group == trailspace_group_name then
      pcall(vim.fn.matchdelete, match.id)
      return
    end
  end
end

autocmd({ 'BufRead', 'BufWinEnter', 'InsertLeave' }, {
  group = general_group,
  callback = function()
    trailspace_unhighlight()
    if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
      vim.fn.matchadd(trailspace_group_name, [[\s\+$]])
    end
  end,
  desc = 'Highlight trailing whitespace',
})
autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
autocmd({ 'InsertEnter' }, {
  group = general_group,
  callback = function()
    trailspace_unhighlight()
    if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
      vim.fn.matchadd(trailspace_group_name, [[\s\+\%#\@<!$]])
    end
  end,
  desc = 'Highlight trailing whitespace in insert mode, except at end of line',
})
autocmd({ 'ColorScheme' }, {
  command = 'highlight ' .. trailspace_group_name .. ' guibg=DarkGray',
  desc = 'Highlight trailing whitespace',
})
