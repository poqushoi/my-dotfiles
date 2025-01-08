-- Executing lua
vim.keymap.set('n', '<space>Xl', ':% lua<CR>', { desc = 'E[x]ecute file in [l]ua' })
vim.keymap.set('n', '<space>xl', ':.lua<CR>', { desc = 'E[x]ecute in [l]ua' })
vim.keymap.set('v', '<space>xl', ':lua<CR>', { desc = 'E[x]ecute in [l]ua' })

-- Executing bash
vim.keymap.set('n', '<space>Xb', '<CMD>bash %<CR>', { desc = 'E[x]ecute file in [b]ash' })
vim.keymap.set({'n', 'v'}, '<space>xb', ':.w !bash<CR>', { desc = 'E[x]ecute in [b]ash' })

