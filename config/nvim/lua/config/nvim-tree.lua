require('nvim-tree').setup {
  disable_netrw = true,
  view = {
    width = 50
  },
  git = {
    enable = false
  },
  renderer = {
    group_empty = true,
    highlight_opened_files = 'name',
    special_files = {}
  }
}
