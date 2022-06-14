require('telescope').setup {
  defaults = {
    layout_config = {
      prompt_position = 'top'
    },
    sorting_strategy = 'ascending',
    path_display = { 'truncate' },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    },
    preview = {
      treesitter = false
    }
  },
  pickers = {
    buffers = {
      mappings = {
        i = {
          ['<c-d>'] = 'delete_buffer'
        }
      }
    },
    find_files = {
      disable_devicons = true,
      path_display = { 'truncate' }
    }
  },
  extensions = {
    -- executor = {
    --   commands = {
    --     { 'Buffer: Clear', '%d' },
    --     { 'Config: Re-source $MYVIMRC', { cmd = 'source', args = { '$MYVIMRC' } } },
    --     { 'Config: Re-source current file', { cmd = 'source', args = { '%' } } },
    --     { 'Coc: Restart', { cmd = 'CocRestart' } },
    --   }
    -- }
  }
}

-- require('telescope').load_extension('executor')
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
