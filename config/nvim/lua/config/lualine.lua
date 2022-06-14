require('lualine').setup {
  options = {
    component_separators = {},
    section_separators = {}
  },
  sections = {
    lualine_b = { 'diagnostics', 'filename' },
    lualine_c = { 'g:coc_status' },
    lualine_x = {
      { 'filetype', icon_only = true }
    }
  },
  extensions = {
    'fugitive',
    'nvim-tree',
    'quickfix'
  }
}
