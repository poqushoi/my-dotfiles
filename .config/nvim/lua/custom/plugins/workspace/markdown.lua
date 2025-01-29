return {
  {
    -- Demo: https://github.com/artempyanykh/marksman/blob/main/docs/demo.md
    -- preview, completions, renaming, gotos
    'artempyanykh/marksman',
    ft = 'markdown',
  },

  { -- preview
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup()
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },

  { -- Shortcuts
    'tadmccorkle/markdown.nvim',
    ft = 'markdown', -- or 'event = "VeryLazy"'
    opts = {
      mappings = {
        inline_surround_delete = 'dms', -- (string|boolean) delete emphasis surrounding cursor
        inline_surround_change = 'cms', -- (string|boolean) change emphasis surrounding cursor
      },
    },
  },
  -- {
  --   'OXY2DEV/markview.nvim',
  --   lazy = false, -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --     'nvim-tree/nvim-web-devicons',
  --   },
  -- },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons

    config = function()
      require('render-markdown').setup {
        heading = { enabled = false },
        bullet = { enabled = false },
        enabled = false,
        link = {
          custom = {
            web = { pattern = '^http', icon = '󰖟 ' },
            youtube = { pattern = 'youtube%.com', icon = '󰗃 ' },
            github = { pattern = 'github%.com', icon = '󰊤 ' },
            neovim = { pattern = 'neovim%.io', icon = ' ' },
            stackoverflow = { pattern = 'stackoverflow%.com', icon = '󰓌 ' },
            discord = { pattern = 'discord%.com', icon = '󰙯 ' },
            reddit = { pattern = 'reddit%.com', icon = '󰑍 ' },
            huggingface = { pattern = 'huggingface%.co', icon = '🤗' },
          },
        },
      }
    end,
  },
  -- {
  --   'iamcco/markdown-preview.nvim',
  --   cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  --   ft = { 'markdown' },
  --   build = function()
  --     vim.fn['mkdp#util#install']()
  --   end,
  -- },
}
