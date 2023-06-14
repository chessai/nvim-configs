-- Fix bug with indentLine hiding chars
vim.opt.conceallevel = 0

vim.bo.expandtab = true
vim.bo.textwidth = 80
vim.opt.breakindent = true

-- Wrap at textwidth
vim.opt.formatoptions:append('t')

