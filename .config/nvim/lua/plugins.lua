vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }  

  use {
    "vigoux/notifier.nvim",
    config = function()
      require'notifier'.setup {
        ignore_messages = {}, -- Ignore message from LSP servers with this name
        status_width = something, -- COmputed using 'columns' and 'textwidth'
        components = {  -- Order of the components to draw from top to bottom (first nvim notifications, then lsp)
          "nvim",  -- Nvim notifications (vim.notify and such)
          "lsp"  -- LSP status updates
        },
        notify = {
          clear_time = 5000, -- Time in milisecond before removing a vim.notifiy notification, 0 to make them sticky
          min_level = vim.log.level.INFO, -- Minimum log level to print the notification
        },
        component_name_recall = false -- Whether to prefix the title of the notification by the component name
      }
    end
  }

  use 'norcalli/nvim-colorizer.lua'
  require'colorizer'.setup()

  vim.cmd[[colorscheme organicgreen]]

end)



