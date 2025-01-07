local obsidian_path = '/home/groot/Desktop/notes/obsidian'

local opts = {
  workspaces = {
    {
      name = 'my-obsidian',
      path = string.format('%s/my-obsidian', obsidian_path),
    },
  },

  notes_subdir = 'Efforts/On',
  new_notes_location = 'notes_subdir',
  disable_frontmatter = true,

  daily_notes = {
    -- Optional, if you keep daily notes in a separate directory.
    folder = 'Calendar/Notes',
    -- Optional, if you want to change the date format for the ID of daily notes.
    date_format = '%Y-%m-%d',
    -- Optional, if you want to change the date format of the default alias of daily notes.
    -- alias_format = "%B %-d, %Y",
    -- Optional, default tags to add to each new daily note created.
    -- default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = 'daily.md',
  },

  -- Optional, for templates (see below).
  templates = {
    folder = 'Templates',
    date_format = '%d %b, %Y',
    time_format = '%H:%M',
    -- A map for custom variables, the key should be the variable and the value a function
    substitutions = {},
  },
  note_id_func = function(title)
    return title
  end,
}

local M = {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    string.format('BufReadPre %s/*.md', obsidian_path),
    string.format('BufNewFile %s/*.md', obsidian_path),
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local obsidian = require 'obsidian'
    obsidian.setup(opts)

    vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianNewFromTemplate<CR>', { desc = 'New [o]bsidian note from [t]emplate' })
    -- vim.api.nvim_create_user_command('ObsidianNewFromTemplate', function()
    --   vim.cmd 'ObsidianNew'
    --   vim.cmd 'normal! G' -- go to end of file
    --   vim.cmd 'ObsidianTemplate'
    -- end, {})
  end,
}
return M
