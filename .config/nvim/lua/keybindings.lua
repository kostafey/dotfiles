-- Functional wrapper for mapping custom keybindings
function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Center screen to cursor pos
vim.api.nvim_set_keymap("n", "<c-l>", '"+zz', {noremap=true, silent=true})
-- Move viewport up & down
keymap("n", "<C-Up>", "<C-y>")
keymap("n", "<C-Down>", "<C-e>")
keymap("i", "<C-Up>", "<C-c>l<C-y>i", {noremap=true})
keymap("i", "<C-Down>", "<C-c>l<C-e>i", {noremap=true})
-- Reload buffer file
keymap("n", "<C-r>", ':e<CR>', {noremap=true, silent=true})
keymap("i", "<C-r>", ':<C-c>:e<CR>i', {noremap=true, silent=true})

