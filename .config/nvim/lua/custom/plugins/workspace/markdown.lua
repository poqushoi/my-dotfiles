return {
  { 'tpope/vim-markdown', ft = 'markdown' },
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

  {
    '3rd/image.nvim',
    opts = {},
    config = function(_, opts)
      require('image').setup {
        backend = 'kitty',
        processor = 'magick_rock', -- or "magick_cli"
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            floating_windows = false, -- if true, images will be rendered in floating markdown windows
            filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            filetypes = { 'norg' },
          },
          typst = {
            enabled = true,
            filetypes = { 'typst' },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', 'snacks_notif', 'scrollview', 'scrollview_sign' },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
      }
    end,
  },
}
