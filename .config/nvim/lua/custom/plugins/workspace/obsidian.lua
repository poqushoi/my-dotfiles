local obsidian_path = '~/Desktop/notes/obsidian'
local main_vault_path = string.format('%s/my-obsidian', obsidian_path)

local opts = {
  workspaces = {
    {
      name = 'my-obsidian',
      path = main_vault_path,
    },
  },

  notes_subdir = 'Efforts/On',
  new_notes_location = 'notes_subdir',
  disable_frontmatter = true,

  ui = { enable = false },
  -- conseallevel = 1,

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

    local function CreateNoteWithDefaultTemplate()
      -- [Notes creation from templates](https://github.com/epwalsh/obsidian.nvim/issues/467)
      local TEMPLATE_NAME = 'basic'
      local obsidian_client = require('obsidian').get_client()
      local cur_file_path = vim.api.nvim_buf_get_name(0)
      local base, cur_fname = string.match(cur_file_path, '(.*)/(.*).md')

      -- yank selected text and set it to variable
      vim.cmd.normal 'y'
      local selected_text = vim.fn.getreg '0'

      -- create note
      local note = obsidian_client:create_note {
        title = selected_text,
        no_write = false,
        template = TEMPLATE_NAME,
      }

      -- add [[...]] to create wiki-link
      vim.cmd.normal('`]a]]')
      vim.cmd.normal('`<i[[')

      -- open new note and add backlink to it
      obsidian_client:open_note(note, { sync = true })
      vim.cmd.normal('ggjA [[' .. cur_fname .. ']]')
    end

    vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianNewFromTemplate<CR>', { desc = 'New [o]bsidian note from [t]emplate' })
    vim.keymap.set('v', '<leader>ot', CreateNoteWithDefaultTemplate, { desc = 'New [o]bsidian note from [t]emplate' })

    -- Checkboxes fix: https://github.com/epwalsh/obsidian.nvim/issues/286
    -- vim.opt.conceallevel = 1
  end,
}

return M
