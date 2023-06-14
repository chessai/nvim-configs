-- code minimap

return {
  'wfxr/minimap.vim',
  keys = {
    {
      '<Leader>tm',
      '<cmd>MinimapToggle<CR>',
      mode = 'n',
      noremap = true,
      desc = 'toggle minimap',
    }
  },
}
