-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'mg979/vim-visual-multi',

  {
    -- https://www.youtube.com/watch?v=eJ3XV-3uoug
    -- A package for quick navigation
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
          ['<M-h>'] = 'actions.select_split',

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
      }
    end,
  },
  'rcarriga/nvim-notify', -- optional
  -- 'stevearc/dressing.nvim', -- optional, UI for :JupyniumKernelSelect

  {
    -- Enables `;` `,` repeat last move https://neovimcraft.com/plugin/mawkler/demicolon.nvim/
    'mawkler/demicolon.nvim',
    -- keys = { ';', ',', 't', 'f', 'T', 'F', ']', '[', ']d', '[d' }, -- Uncomment this to lazy load
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {},
  },
}
