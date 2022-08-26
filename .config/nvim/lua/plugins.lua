vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'shaunsingh/nord.nvim'
  vim.cmd[[colorscheme nord]]

-- use "lunarvim/horizon.nvim"
-- vim.cmd[[colorscheme horizon]] 

--   use "tenxsoydev/size-matters.nvim"
    
--     if vim.g.neovide or vim.g.goneovim or vim.g.nvui or vim.g.gnvim then
-- 	    require("size-matters")
--     end
  

end)



