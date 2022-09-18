vim.api.nvim_create_user_command(
    "NeogitCWD",
    function()
        local cwd = vim.fn.expand('%:p:h')
        vim.cmd(":lcd" .. cwd)
        require("neogit").open()
    end,
    {nargs = 0}
)

vim.api.nvim_create_user_command(
    "CommentToggleSelection",
    function()
	local l1 = vim.fn.getpos('v')[2]
	local l2 = vim.fn.getcurpos()[2]
	if l2 > l1 then
	  require("nvim_comment").comment_toggle(l1, l2)
	else
	  require("nvim_comment").comment_toggle(l2, l1)
	end
    end,
    {nargs = 0}
)

