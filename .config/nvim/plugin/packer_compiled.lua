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
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["neovim-session-manager"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/neovim-session-manager",
    url = "https://github.com/Shatur/neovim-session-manager"
  },
  ["notifier.nvim"] = {
    config = { "\27LJ\2\ný\1\0\0\5\0\16\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0026\3\5\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0006\4\n\0009\4\v\0049\4\f\0049\4\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\vnotify\14min_level\tINFO\vlevels\blog\bvim\1\0\1\15clear_time\3ˆ'\15components\1\3\0\0\tnvim\blsp\17status_width\14something\20ignore_messages\1\0\1\26component_name_recall\1\nsetup\rnotifier\frequire\0" },
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/notifier.nvim",
    url = "https://github.com/vigoux/notifier.nvim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
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
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
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
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/kostafey/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: notifier.nvim
time([[Config for notifier.nvim]], true)
try_loadstring("\27LJ\2\ný\1\0\0\5\0\16\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0026\3\5\0=\3\6\0025\3\a\0=\3\b\0025\3\t\0006\4\n\0009\4\v\0049\4\f\0049\4\r\4=\4\14\3=\3\15\2B\0\2\1K\0\1\0\vnotify\14min_level\tINFO\vlevels\blog\bvim\1\0\1\15clear_time\3ˆ'\15components\1\3\0\0\tnvim\blsp\17status_width\14something\20ignore_messages\1\0\1\26component_name_recall\1\nsetup\rnotifier\frequire\0", "config", "notifier.nvim")
time([[Config for notifier.nvim]], false)

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
