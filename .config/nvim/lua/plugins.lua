vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'Olical/aniseed'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }  

  use 'Shatur/neovim-session-manager'
  
  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  vim.opt.termguicolors = true
  require("bufferline").setup{}

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
          clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
          min_level = vim.log.levels.INFO, -- Minimum log level to print the notification
        },
        component_name_recall = false -- Whether to prefix the title of the notification by the component name
      }
    end
  }

  use 'norcalli/nvim-colorizer.lua'
  require 'colorizer'.setup()

  use 'nvim-treesitter/nvim-treesitter'
  use 'p00f/nvim-ts-rainbow'
  require("nvim-treesitter.configs").setup {
     ensure_installed = { "c", "lua", "rust", "java", "clojure" },
      -- Automatically install missing parsers when entering buffer
     auto_install = true,  
    highlight = {
 	    enable = true,
       additional_vim_regex_highlighting = false,
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      colors = {"#666666", "#5544EE", "#0065CC", "#00A89B", "#119911", "#b8860b", "#ce5c00"}, -- table of hex strings
      termcolors = {"Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"}, -- table of colour name strings      
    }
  }


  use 'kostafey/organicgreen.nvim'
  vim.cmd[[colorscheme organicgreen]]

end)

