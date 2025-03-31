M = {
  'Exafunction/codeium.vim',
  event = 'BufEnter',

  config = function()

    -- Set Keybindings
    vim.g.codeium_disable_bindings = 1

    vim.keymap.set('i', '<M-y>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<M-k>', function()
      return vim.fn['codeium#AcceptNextWord']()
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<M-l>', function()
      return vim.fn['codeium#AcceptNextLine']()
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<M-i>', function()
      return vim.fn['codeium#Complete']()
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<M-n>', function()
      return vim.fn['codeium#CycleCompletions'](1)
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<M-p>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<M-x>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<M-r>', function()
      return vim.fn['codeium#Clear']()
    end, { expr = true, silent = true })

    vim.keymap.set('n', '<M-t>', '<CMD>CodeiumToggle<CR>')
  end,
}

return M
