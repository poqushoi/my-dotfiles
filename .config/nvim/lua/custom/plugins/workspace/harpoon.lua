return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<m-m>', function()
      harpoon:list():add()
    end, { desc = '[h]arpoon add [m]ark' })
    vim.keymap.set('n', '<m-p>', function()
      harpoon:list():prev()
    end, { desc = '[h]arpoon [p]revious' })
    vim.keymap.set('n', '<m-n>', function()
      harpoon:list():next()
    end, { desc = '[h]arpoon [n]ext' })
    vim.keymap.set('n', '<m-h>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[h]arpoon [l]ist' })

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<m-t>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open [h]arpoon [t]elescope' })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set('n', string.format('<m-%d>', idx), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
