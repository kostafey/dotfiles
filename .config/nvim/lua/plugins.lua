vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'Olical/aniseed'
  use 'Olical/conjure'
  vim.cmd[[let g:conjure#client#fennel#aniseed#aniseed_module_prefix = "aniseed."]]

  use 'Shatur/neovim-session-manager'

  -----------------------------------------------------------------------------
  -- Navigation
  -----------------------------------------------------------------------------
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
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
        require("telescope").setup {
          defaults = {
            mappings = {
              i = {
                ["<Esc>"] = require('telescope.actions').close,
              },
            },
          },
          extensions = {
            file_browser = {
              theme = "ivy",
              -- disables netrw and use telescope-file-browser in its place
              hijack_netrw = true,
            },
          },
        }
    end
  }

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      require'telescope-file-browser.nvim'.setup()
    end
  }
  require("telescope").load_extension "file_browser"

  -- Project management
  use {
    "airblade/vim-rooter",
    config = function()
      require'vim-rooter'.setup()
    end
  }

  -----------------------------------------------------------------------------
  -- Version control
  -----------------------------------------------------------------------------
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

  -----------------------------------------------------------------------------
  -- GUI
  -----------------------------------------------------------------------------  
  -- Tabs
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    -- requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup {
        options = {
          show_buffer_icons = false, -- disable file type icons
	        buffer_close_icon = 'x',
          tab_size = 8,
          max_name_length = 24,
        },
        highlights = {
          buffer_selected = {
                fg = '#444d56',
                bg = "#f0fff0",
                bold = false,
                italic = false,
            },
          }
      }
    end
  }
  vim.opt.termguicolors = true

  -- Mode-line
  use {
    'nvim-lualine/lualine.nvim',
    -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  require ('lualine').setup{
    options = {
        icons_enabled = false,
        theme = 'auto',
        -- options = { theme  = organicgreen },
        disabled_filetypes = { 'packer' }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
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
          clear_time = 5000, -- Time in milliseconds before removing a vim.notify notification, 0 to make them sticky
          min_level = vim.log.levels.INFO, -- Minimum log level to print the notification
        },
        component_name_recall = false -- Whether to prefix the title of the notification by the component name
      }
    end
  }

  -----------------------------------------------------------------------------
  -- Tree-sitter
  -----------------------------------------------------------------------------  
  -- Hint: run TSUpdate after plugin update (via packer) is required.
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
      colors = {"#666666", "#5544EE", "#0065CC", "#00A89B", "#119911", "#999900", "#b8860b"}, -- table of hex strings
      termcolors = {"Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White"}, -- table of colour name strings      
    },
    matchup = {
      enable = true, -- mandatory, false will disable the whole extension
      disable = {},  -- optional, list of language that will be disabled
    }
  }

  use 'kostafey/organicgreen.nvim'
  vim.cmd[[colorscheme organicgreen]]

  use 'norcalli/nvim-colorizer.lua'
  require 'colorizer'.setup()

  -----------------------------------------------------------------------------
  -- Highlight
  -----------------------------------------------------------------------------  
  -- Highlight word under cursor
  use 'RRethy/vim-illuminate'
  require('illuminate').configure({
    delay = 0,
  })
  -- Highlight selected words and expressions
  use 'azabiong/vim-highlighter'
  -- Highlight matching parenthesis
  use 'andymass/vim-matchup'

  -----------------------------------------------------------------------------
  -- LSP
  -----------------------------------------------------------------------------
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

  require'lspconfig'.metals.setup{}
  require'lspconfig'.sumneko_lua.setup{
    settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
      },
    },
  }
  require'lspconfig'.clojure_lsp.setup{}
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  })

  local lspconfig = require('lspconfig')
  -- inform lspconfig about fennel-ls
  require("lspconfig.configs")["fennel-ls"] = {
    default_config = {
        cmd = {"fennel-ls"}, -- path
        filetypes = {"fennel"},
        root_dir = function(dir) return lspconfig.util.find_git_ancestor(dir) end,
        settings = {}
    }
  }
  -- setup fennel-ls
  -- If you're using a completion system like nvim-cmp, you probably need to modify this line.
  lspconfig["fennel-ls"].setup(
    vim.lsp.protocol.make_client_capabilities()
  )

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  vim.api.nvim_command("set completeopt=menu,menuone,noselect")
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require'cmp'

      cmp.setup({
         snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
          -- { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
        })
      })
    end
  }

end)

