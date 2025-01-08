local keymap = vim.keymap.set

-- Toggle line wrap
-- vim.keymap.set('n', '<C-w>z', '<cmd>set wrap!<cr>', { silent = true, buffer = 5 })

-- Resize with arrows
vim.keymap.set('n', '<C-w><C-j>', '<CMD>resize +10<CR>', { desc = 'Resize Horizontal Split Down' })
vim.keymap.set('n', '<C-w><C-k>', '<CMD>resize -10<CR>', { desc = 'Resize Horizontal Split Up' })
vim.keymap.set('n', '<C-w><C-h>', '<CMD>vertical resize -10<CR>', { desc = 'Resize Vertical Split Down' })
vim.keymap.set('n', '<C-w><C-l>', '<CMD>vertical resize +10<CR>', { desc = 'Resize Vertical Split Up' })

-- Quickly move from terminal
-- vim.keymap.set('n', '<C-a>h', '<ESC><ESC><shift-h>')
-- vim.keymap.set('n', '<C-a>j', '<ESC><ESC><shift-j>')
-- vim.keymap.set('n', '<C-a>k', '<ESC><ESC><shift-k>')
-- vim.keymap.set('n', '<C-a>l', '<ESC><ESC><shift-l>')

-- Visual mode --
-- Tabs
keymap('v', '<', '<gv', { desc = 'Untab' })
keymap('v', '>', '>gv', { desc = 'Tab' })

require 'custom.settings.execution'
