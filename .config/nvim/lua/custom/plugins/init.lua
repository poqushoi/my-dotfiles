-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'mg979/vim-visual-multi',
  {
    'ggandor/leap.nvim',
    config = function()
      local leap = require 'leap'
      leap.create_default_mappings()
      leap.opts.case_sensitive = true
    end,
  },
}
