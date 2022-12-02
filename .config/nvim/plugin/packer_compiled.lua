-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/kostafey/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/kostafey/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/kostafey/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/kostafey/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/kostafey/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  aniseed = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/aniseed",
    url = "https://github.com/Olical/aniseed"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\15highlights\20buffer_selected\1\0\0\1\0\4\tbold\1\abg\f#f0fff0\vitalic\1\afg\f#444d56\foptions\1\0\0\1\0\4\20max_name_length\3\24\rtab_size\3\b\22buffer_close_icon\6x\22show_buffer_icons\1\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  conjure = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/conjure",
    url = "https://github.com/Olical/conjure"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n�\a\0\0\5\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\vborder\vsingle\28current_line_blame_opts\1\0\4\ndelay\3�\a\22ignore_whitespace\1\18virt_text_pos\beol\14virt_text\2\17watch_gitdir\1\0\2\rinterval\3�\a\17follow_files\2\nsigns\1\0\n\14word_diff\1\15signcolumn\2\20max_file_length\3��\2\23current_line_blame\1\24attach_to_untracked\2\20update_debounce\3d\18sign_priority\3\6\vlinehl\1!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\nnumhl\1\17changedelete\1\0\4\nnumhl\21GitSignsChangeNr\ttext\b▐\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\14topdelete\1\0\4\nnumhl\21GitSignsDeleteNr\ttext\b▐\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\vdelete\1\0\4\nnumhl\21GitSignsDeleteNr\ttext\b▐\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\vchange\1\0\4\nnumhl\21GitSignsChangeNr\ttext\b▐\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\badd\1\0\0\1\0\4\nnumhl\18GitSignsAddNr\ttext\b▐\vlinehl\18GitSignsAddLn\ahl\16GitSignsAdd\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  neogit = {
    config = { "\27LJ\2\n8\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\nsetup\vneogit\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["neovim-session-manager"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/neovim-session-manager",
    url = "https://github.com/Shatur/neovim-session-manager"
  },
  ["notifier.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\5\0\16\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0026\3\5\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0006\4\n\0009\4\v\0049\4\f\0049\4\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\vnotify\14min_level\tINFO\vlevels\blog\bvim\1\0\1\15clear_time\3�'\15components\1\3\0\0\tnvim\blsp\17status_width\14something\20ignore_messages\1\0\1\26component_name_recall\1\nsetup\rnotifier\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/notifier.nvim",
    url = "https://github.com/vigoux/notifier.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim�\3\1\0\n\0\28\00066\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0034\4\0\0=\4\b\0039\4\t\0009\4\n\0049\4\v\0045\6\r\0009\a\t\0009\a\f\a)\t��B\a\2\2=\a\14\0069\a\t\0009\a\f\a)\t\4\0B\a\2\2=\a\15\0069\a\t\0009\a\16\aB\a\1\2=\a\17\0069\a\t\0009\a\18\aB\a\1\2=\a\19\0069\a\t\0009\a\20\a5\t\21\0B\a\2\2=\a\22\6B\4\2\2=\4\t\0039\4\23\0009\4\24\0044\6\3\0005\a\25\0>\a\1\0065\a\26\0>\a\2\0064\a\3\0005\b\27\0>\b\1\aB\4\3\2=\4\24\3B\1\2\1K\0\1\0\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17nvim_comment\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-comment",
    url = "https://github.com/terrortylor/nvim-comment"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["organicgreen.nvim"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/organicgreen.nvim",
    url = "https://github.com/kostafey/organicgreen.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    config = { "\27LJ\2\nI\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup telescope-file-browser.nvim\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\t\0\17\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\v\0005\3\t\0005\4\a\0005\5\5\0006\6\0\0'\b\3\0B\6\2\0029\6\4\6=\6\6\5=\5\b\4=\4\n\3=\3\f\0025\3\14\0005\4\r\0=\4\15\3=\3\16\2B\0\2\1K\0\1\0\15extensions\17file_browser\1\0\0\1\0\2\17hijack_netrw\2\ntheme\bivy\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<Esc>\1\0\0\nclose\22telescope.actions\nsetup\14telescope\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-highlighter"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/vim-highlighter",
    url = "https://github.com/azabiong/vim-highlighter"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15vim-rooter\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-vsnip"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope-file-browser.nvim
time([[Config for telescope-file-browser.nvim]], true)
try_loadstring("\27LJ\2\nI\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup telescope-file-browser.nvim\frequire\0", "config", "telescope-file-browser.nvim")
time([[Config for telescope-file-browser.nvim]], false)
-- Config for: nvim-comment
time([[Config for nvim-comment]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17nvim_comment\frequire\0", "config", "nvim-comment")
time([[Config for nvim-comment]], false)
-- Config for: vim-rooter
time([[Config for vim-rooter]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15vim-rooter\frequire\0", "config", "vim-rooter")
time([[Config for vim-rooter]], false)
-- Config for: neogit
time([[Config for neogit]], true)
try_loadstring("\27LJ\2\n8\0\0\4\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\1K\0\1\0\nsetup\vneogit\frequire\0", "config", "neogit")
time([[Config for neogit]], false)
-- Config for: notifier.nvim
time([[Config for notifier.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\5\0\16\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0026\3\5\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0006\4\n\0009\4\v\0049\4\f\0049\4\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\vnotify\14min_level\tINFO\vlevels\blog\bvim\1\0\1\15clear_time\3�'\15components\1\3\0\0\tnvim\blsp\17status_width\14something\20ignore_messages\1\0\1\26component_name_recall\1\nsetup\rnotifier\frequire\0", "config", "notifier.nvim")
time([[Config for notifier.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\t\0\17\0\0226\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\v\0005\3\t\0005\4\a\0005\5\5\0006\6\0\0'\b\3\0B\6\2\0029\6\4\6=\6\6\5=\5\b\4=\4\n\3=\3\f\0025\3\14\0005\4\r\0=\4\15\3=\3\16\2B\0\2\1K\0\1\0\15extensions\17file_browser\1\0\0\1\0\2\17hijack_netrw\2\ntheme\bivy\rdefaults\1\0\0\rmappings\1\0\0\6i\1\0\0\n<Esc>\1\0\0\nclose\22telescope.actions\nsetup\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n;\0\1\4\0\4\0\0066\1\0\0009\1\1\0019\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\20vsnip#anonymous\afn\bvim�\3\1\0\n\0\28\00066\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0003\5\3\0=\5\5\4=\4\a\0034\4\0\0=\4\b\0039\4\t\0009\4\n\0049\4\v\0045\6\r\0009\a\t\0009\a\f\a)\t��B\a\2\2=\a\14\0069\a\t\0009\a\f\a)\t\4\0B\a\2\2=\a\15\0069\a\t\0009\a\16\aB\a\1\2=\a\17\0069\a\t\0009\a\18\aB\a\1\2=\a\19\0069\a\t\0009\a\20\a5\t\21\0B\a\2\2=\a\22\6B\4\2\2=\4\t\0039\4\23\0009\4\24\0044\6\3\0005\a\25\0>\a\1\0065\a\26\0>\a\2\0064\a\3\0005\b\27\0>\b\1\aB\4\3\2=\4\24\3B\1\2\1K\0\1\0\1\0\1\tname\vbuffer\1\0\1\tname\nvsnip\1\0\1\tname\rnvim_lsp\fsources\vconfig\t<CR>\1\0\1\vselect\2\fconfirm\n<C-e>\nabort\14<C-Space>\rcomplete\n<C-f>\n<C-b>\1\0\0\16scroll_docs\vinsert\vpreset\fmapping\vwindow\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\15highlights\20buffer_selected\1\0\0\1\0\4\tbold\1\abg\f#f0fff0\vitalic\1\afg\f#444d56\foptions\1\0\0\1\0\4\20max_name_length\3\24\rtab_size\3\b\22buffer_close_icon\6x\22show_buffer_icons\1\nsetup\15bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n�\a\0\0\5\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\tyadm\1\0\1\venable\1\19preview_config\1\0\5\bcol\3\1\brow\3\0\rrelative\vcursor\nstyle\fminimal\vborder\vsingle\28current_line_blame_opts\1\0\4\ndelay\3�\a\22ignore_whitespace\1\18virt_text_pos\beol\14virt_text\2\17watch_gitdir\1\0\2\rinterval\3�\a\17follow_files\2\nsigns\1\0\n\14word_diff\1\15signcolumn\2\20max_file_length\3��\2\23current_line_blame\1\24attach_to_untracked\2\20update_debounce\3d\18sign_priority\3\6\vlinehl\1!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\nnumhl\1\17changedelete\1\0\4\nnumhl\21GitSignsChangeNr\ttext\b▐\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\14topdelete\1\0\4\nnumhl\21GitSignsDeleteNr\ttext\b▐\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\vdelete\1\0\4\nnumhl\21GitSignsDeleteNr\ttext\b▐\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\vchange\1\0\4\nnumhl\21GitSignsChangeNr\ttext\b▐\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\badd\1\0\0\1\0\4\nnumhl\18GitSignsAddNr\ttext\b▐\vlinehl\18GitSignsAddLn\ahl\16GitSignsAdd\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
