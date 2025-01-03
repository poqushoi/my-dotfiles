return {
  -- Enable buffer-like file operations
  -- https://www.youtube.com/watch?v=q1QhV-24DNA
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    CustomOilBar = function()
      local path = vim.fn.expand '%'
      path = path:gsub('oil://', '')

      return '  ' .. vim.fn.fnamemodify(path, ':.')
    end

    require('oil').setup {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        natural_order = true,
        is_always_hidden = function(name, _)
          return name == '..' or name == '.git'
        end,
      },
      float = {
        padding = 2,
        max_width = 90,
        max_height = 0,
      },

      columns = { 'icon' },
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-k>'] = false,
        ['<C-j>'] = false,
        ['<M-s>'] = 'actions.select_split',

        -- Config for quitiing
        ['<C-c>'] = false,
        ['q'] = 'actions.close',
        ['<esc>'] = 'actions.close',
      },
      win_options = {
        wrap = true,
        winblend = 0,
        -- winbar = '%{v:lua.CustomOilBar()}',
      },
    }

    -- Open parent directory in current window
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    -- Open parent directory in floating window
    -- vim.keymap.set('n', '<space>-', require('oil').toggle_float)
    vim.keymap.set('n', '<space>-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
  end,
}
