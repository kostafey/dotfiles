vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  use 'Olical/aniseed'
  use 'Shatur/neovim-session-manager'

  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }  

  use { 
    'TimUntersberger/neogit', 
    requires = 'nvim-lua/plenary.nvim', 
    config = function()
      local neogit = require('neogit')
      neogit.setup {}   
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup{
	
        signs = {
          add          = {hl = 'GitSignsAdd'   , text = '▐', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
          change       = {hl = 'GitSignsChange', text = '▐', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          delete       = {hl = 'GitSignsDelete', text = '▐', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          topdelete    = {hl = 'GitSignsDelete', text = '▐', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
          changedelete = {hl = 'GitSignsChange', text = '▐', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
	signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm = {
          enable = false
        },
      }
    end
  }

  use {
    "terrortylor/nvim-comment",
    config = function()
      require'nvim_comment'.setup()
    end
  }

  use 'andymass/vim-matchup'

  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    -- requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
          show_buffer_icons = false, -- disable file type icons
	  buffer_close_icon = 'x',
        }
      }
    end
  }
  vim.opt.termguicolors = true

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
     ensure_installed = { "c", "lua", "rust", "java", "clojure", "fennel"},
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
      colors = {"#666666", "#5544EE", "#0065CC", "#00A89B", "#119911", "#859900", "#b8860b"}, -- table of hex strings
      termcolors = {"Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"}, -- table of colour name strings      
    },
    matchup = {
      enable = true, -- mandatory, false will disable the whole extension
      disable = {},  -- optional, list of language that will be disabled
    }
  }


  use 'kostafey/organicgreen.nvim'
  vim.cmd[[colorscheme organicgreen]]

end)

