-- local obsidian_path = require('obsidian')['workspaces'][1]['path']
-- print(require("obsidian")['opts'])
--
-- local keyset={}
-- local n=0
-- local tab = require('obsidian').get_client().current_workspace.path
-- for k,v in pairs(tab) do
--   n=n+1
--   keyset[n]=k
--   print(k, v)
-- end
-- print(require('obsidian').get_client().current_workspace.path.filename)

local M = { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    {
      -- Live-Grep-Args allows to search in specific files
      -- `"Hello" -tmd` will search for hello in Markdown
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
    -- 'nvim-telescope/telescope-media-files.nvim',
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`

    local telescope = require 'telescope'
    local lga_actions = require 'telescope-live-grep-args.actions'

    -- Clone the default Telescope configuration
    local vimgrep_default_arguments = {
      'rg',
      '--follow', -- Follow symbolic links
      '--hidden', -- Search for hidden files
      '--no-heading', -- Don't group matches by each file
      '--with-filename', -- Print the file path with the matched lines
      '--line-number', -- Show line numbers
      '--column', -- Show column numbers
      '--smart-case', -- Smart case search
    }

    -- Exclude some patterns from search
    local ignore_patterns = {
      '--glob=!**/.git/*',
      '--glob=!**/.idea/*',
      '--glob=!**/.vscode/*',
      '--glob=!**/build/*',
      '--glob=!**/dist/*',
      '--glob=!**/yarn.lock',
      '--glob=!**/package-lock.json',
      '--glob=!**/.venv',
    }

    -- Include some patterns back
    local include_patterns = {
      '--glob=**/.env',
      '--glob=**/.gitignore',
    }

    -- Search arguments
    local vimgrep_arguments = {}
    vim.list_extend(vimgrep_arguments, vimgrep_default_arguments)
    vim.list_extend(vimgrep_arguments, ignore_patterns)
    vim.list_extend(vimgrep_arguments, { '--glob=!**/*.ipynb' })
    -- vim.list_extend(vimgrep_arguments, include_patterns)

    -- print(table.concat(vimgrep_arguments, ', '))

    local find_command = {
      'rg',
      '--files',
      '--hidden',
    }
    vim.list_extend(find_command, ignore_patterns)
    -- vim.list_extend(find_command, include_patterns)

    telescope.setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      defaults = {
        vimgrep_arguments = vimgrep_arguments,
        pickers = {
          find_files = {
            hidden = true,
            -- needed to exclude some files & dirs from general search
            -- when not included or specified in .gitignore
            find_command = find_command,
          },
        },
        -- pickers = {
        --   find_files = {
        --     -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        --     find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
        --   },
        -- },
        --
        mappings = {
          i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        },
      },

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },

        live_grep_args = {
          -- theme = 'vertical',
          -- layout_strategy = 'vertical',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              width = { padding = 10 },
              -- height = { padding = 0 },
              preview_width = 0.5,
            },
          },
          auto_quoting = true, -- enable/disable auto-quoting
          smartcase = true,
          hidden = true,

          -- define mappings, e.g.
          mappings = { -- extend mappings
            i = {
              ['<C-k>'] = lga_actions.quote_prompt(),
              -- ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
              -- -- freeze the current list and start a fuzzy search in the frozen list
              -- ['<C-space>'] = actions.to_fuzzy_refine,
            },
          },
          -- ... also accepts theme settings, for example:
          -- theme = "dropdown", -- use dropdown theme
          -- theme = { }, -- use own theme spec
          -- layout_config = { mirror=true }, -- mirror preview pane
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'live_grep_args')
    pcall(require('telescope').load_extension, 'media_files')

    -- Load customgreps
    local customgrep = require 'custom.plugins.workspace.telescope.customgrep'
    local live_grep_basic = customgrep.live_grep_basic
    local live_grep_func = live_grep_basic

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', function()
      builtin.find_files { find_command = find_command }
    end, {
      noremap = true,
      silent = true,
      desc = '[S]earch [F]iles',
    })
    vim.keymap.set(
      'n',
      '<leader>sF',
      '<CMD>Telescope find_files hidden=true no_ignore=true<CR>',
      { noremap = true, silent = true, desc = '[S]earch [F]iles Without Ignore' }
    )
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', '<cmd>Telescope live_grep hidden=true no_ignore=true<CR>', { desc = '[S]earch by [G]rep without ignore' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    vim.keymap.set('n', '<space>sp', function()
      require('telescope.builtin').find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy'),
      }
    end, { desc = '[S]earch Neovim [P]ackages' })

    vim.keymap.set('n', '<leader>sg', live_grep_func, { desc = 'Live [G]rep' })

    -- Shortcut for searching Obsidian
    local obsidian_path = require('obsidian').get_client().current_workspace.path.filename

    -- Search Obsidian files
    vim.keymap.set('n', '<leader>sof', function()
      builtin.find_files { cwd = obsidian_path }
    end, { desc = '[S]earch [O]bsidian files' })

    -- Search Obsidian with live grep
    vim.keymap.set('n', '<leader>sog', function()
      live_grep_func { cwd = obsidian_path, search_dirs = { obsidian_path } }
    end, { desc = 'Live [G]rep [O]bsidian files' })
  end,
}

return M
