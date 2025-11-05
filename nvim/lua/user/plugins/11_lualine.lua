-- dotfiles/nvim/lua/user/plugins/11_statusline.lua

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local use_nerd_font = vim.g.have_nerd_font or false

    -- Nerd Font の有無に応じてアイコンを設定
    local icons = {}
    if use_nerd_font then
      icons = {
        error = '',
        warn = '',
        info = '',
        hint = '',
        modified = '●',
        readonly = '',
        git_branch = '',
        git_added = '',
        git_modified = '',
        git_removed = '',
      }
    else
      icons = {
        error = 'E',
        warn = 'W',
        info = 'I',
        hint = 'H',
        modified = '*',
        readonly = 'RO',
        git_branch = 'BR',
        git_added = '+',
        git_modified = '~',
        git_removed = '-',
      }
    end

    require('lualine').setup({
      options = {
        icons_enabled = use_nerd_font,
        theme = 'auto',
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          {
            'branch',
            icon = icons.git_branch
          },
          {
            'diff',
            symbols = {
              added = icons.git_added,
              modified = icons.git_modified,
              removed = icons.git_removed
            }
          }
        },
        lualine_c = {
          {
            'filename',
            symbols = {
              modified = icons.modified,
              readonly = icons.readonly,
            }
          }
        },
        lualine_x = {
          {
            'diagnostics',
            symbols = {
              error = icons.error,
              warn = icons.warn,
              info = icons.info,
              hint = icons.hint,
            }
          },
          'encoding',
          'fileformat',
          'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
    })
  end,
}
