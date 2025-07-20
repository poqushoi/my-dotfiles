return {
  {
    'GCBallesteros/jupytext.nvim',
    config = true,
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
  },

  -- {
  --   'GCBallesteros/NotebookNavigator.nvim',
  --   ft = 'py',
  --   keys = {
  --     {
  --       ']j',
  --       function()
  --         require('notebook-navigator').move_cell 'd'
  --       end,
  --     },
  --     {
  --       '[j',
  --       function()
  --         require('notebook-navigator').move_cell 'u'
  --       end,
  --     },
  --     {
  --       '<leader>X',
  --       "<cmd>lua require('notebook-navigator').run_cell()<cr>",
  --       desc = 'Run Cell',
  --       ft = 'ipynb',
  --     },
  --     {
  --       '<leader>x',
  --       "<cmd>lua require('notebook-navigator').run_and_move()<cr>",
  --       desc = 'Run Cell and Move',
  --       ft = 'ipynb',
  --     },
  --   },
  --   dependencies = {
  --     'echasnovski/mini.comment',
  --     'hkupty/iron.nvim', -- repl provider
  --     -- "akinsho/toggleterm.nvim", -- alternative repl provider
  --     -- "benlubas/molten-nvim", -- alternative repl provider
  --     'anuvyklack/hydra.nvim',
  --   },
  --   event = 'VeryLazy',
  --   config = function()
  --     local nn = require 'notebook-navigator'
  --     nn.setup { activate_hydra_keys = '<leader>h' }
  --   end,
  -- },

  {
    'hkupty/iron.nvim',
    event = 'VeryLazy',
    ft = 'py',
  },
}

-- {
--   'kiyoon/jupynium.nvim',
--   build = 'pip install .',
--   -- build = "conda run --no-capture-output -n jupynium pip install .",
--   -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
--
--   config = function()
--     require('jupynium').setup {
--       auto_attach_to_server = {
--         enable = false,
--       },
--       auto_download_ipynb = false,
--       -- firefox_profiles_ini_path = '~/.mozilla/firefox/profiles.ini',
--       -- firefox_profile_name = 'default',
--     }
--   end,
-- },
