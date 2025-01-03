return {
  {
    'GCBallesteros/jupytext.nvim',
    config = true,
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
  },

  {
    'linux-cultist/venv-selector.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
    opts = {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
    },
    branch = 'regexp',
    event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = {
      -- Keymap to open VenvSelector to pick a venv.
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
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
