return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    config = function()
      vim.keymap.set('n', '<space>wb', ':IBLToggle<CR>', { desc = 'Toggle indent [b]lankline guides' })

      require('ibl').setup {
        enabled = false,
        indent = {
          -- char = '▏',
          char = '┊',
        },
        scope = {
          enabled = false,
        },
      }
    end,
  },
}
