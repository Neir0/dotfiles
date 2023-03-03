require("tmux").setup({
	copy_sync = {
		redirect_to_clipboard = true,
	},
	resize = {
		enable_default_keybindings = true,
		resize_step_x = 1,
		resize_step_y = 1,
	},
})
