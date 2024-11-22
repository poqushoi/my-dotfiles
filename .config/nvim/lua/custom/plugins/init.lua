-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
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

  {
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
  },

  {
    'kiyoon/jupynium.nvim',
    build = 'pip install .',
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),

    config = function()
      require('jupynium').setup {
        auto_attach_to_server = {
          enable = false,
        },
        auto_download_ipynb = false,
        -- firefox_profiles_ini_path = '~/.mozilla/firefox/profiles.ini',
        -- firefox_profile_name = 'default',
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
      -- auto_set_mode_filetype_denylist = {
      --   'json',
      -- },
      auto_set_mode_heuristically = true,
    },
    config = function()
      vim.keymap.set('n', '<m-w>', ':ToggleWrapMode<CR>', { desc = 'Toggle [W]rap Mode' })
      require('wrapping').setup()
    end,
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      vim.keymap.set('n', '<m-m>', function()
        harpoon:list():add()
      end, { desc = '[h]arpoon add [m]ark' })
      vim.keymap.set('n', '<m-p>', function()
        harpoon:list():prev()
      end, { desc = '[h]arpoon [p]revious' })
      vim.keymap.set('n', '<m-n>', function()
        harpoon:list():next()
      end, { desc = '[h]arpoon [n]ext' })
      vim.keymap.set('n', '<m-h>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[h]arpoon [l]ist' })

      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      vim.keymap.set('n', '<m-t>', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open [h]arpoon [t]elescope' })

      -- Set <space>1..<space>5 be my shortcuts to moving to the files
      for _, idx in ipairs { 1, 2, 3, 4, 5 } do
        vim.keymap.set('n', string.format('<m-%d>', idx), function()
          harpoon:list():select(idx)
        end)
      end
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
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
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
}
