-- Functional wrapper for mapping custom keybindings
function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Reload buffer file
keymap("n", "<C-r>", ':e<CR>', {noremap=true, silent=true})
keymap("i", "<C-r>", ':<C-c>:e<CR>i', {noremap=true, silent=true})

