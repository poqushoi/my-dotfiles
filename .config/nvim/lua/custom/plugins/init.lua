-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { import = 'custom.plugins.workspace' },
  { import = 'custom.plugins.editing' },

  'mg979/vim-visual-multi',
  { -- Adds [<space> to add space to the line above
    'tummetott/unimpaired.nvim',
    event = 'VeryLazy',
    opts = {
      -- add options here if you wish to override the default settings
    },
  },
  {
    'Wansmer/langmapper.nvim',
    lazy = false,
    priority = 1, -- High priority is needed if you will use `autoremap()`
    config = function()
      -- Configure langmap
      local function escape(str)
        -- You need to escape these characters to work correctly
        local escape_chars = [[;,."|\]]
        return vim.fn.escape(str, escape_chars)
      end

      -- Recommended to use lua template string
      local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
      local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
      local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
      local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

      vim.opt.langmap = vim.fn.join({
        -- | `to` should be first     | `from` should be second
        escape(ru_shift)
          .. ';'
          .. escape(en_shift),
        escape(ru) .. ';' .. escape(en),
      }, ',')

      -- Setup
      require('langmapper').setup {--[[ your config ]]
        map_all_ctrl = false,
      }
    end,
  },
  {
    -- A package for quick navigation https://www.youtube.com/watch?v=eJ3XV-3uoug
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      jump = {
        autojump = true,
      },
      modes = {
        char = {
          jump_labels = false, -- f, t, F, T with labels
          multi_line = true,
          highlight = { backdrop = false }, -- Do not dim text
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n" },           function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    -- A package for quickly surrounding text
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  'rcarriga/nvim-notify', -- optional

  -- {
  --   'm4xshen/autoclose.nvim',
  --   config = function()
  --     require('autoclose').setup {
  --       keys = {
  --         ['$'] = { escape = true, close = true, pair = '$$', disabled_filetypes = { 'shell' } },
  --       },
  --     }
  --   end,
  -- },

  {
    'andrewferrier/wrapping.nvim',
    opts = {
      create_commands = false,
      create_keymaps = false,
      -- auto_set_mode_filetype_denylist = {
      --   'json',
      -- },
      -- auto_set_mode_heuristically = true,
    },
    config = function()
      vim.keymap.set('n', '<m-w>', ':ToggleWrapMode<CR>', { desc = 'Toggle [W]rap Mode' })
      require('wrapping').setup()
    end,
  },

  {
    'mogulla3/copy-file-path.nvim',
    config = function()
      vim.keymap.set('n', '<leader>wc', ':CopyRelativeFilePath<CR>', { desc = '[c]opy relative file path' })
    end,
  },
  { -- better folding
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
      vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
      vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
      vim.keymap.set('n', 'zK', function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = 'Peek Fold' })

      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'lsp', 'indent' }
        end,
      }
    end,
  },
  { 'stefandtw/quickfix-reflector.vim' }, -- edit quickfix list
}
