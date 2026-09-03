-- Debug adapter protocol
-- https://github.com/mfussenegger/nvim-dap

local dap = require("dap")

vim.keymap.set("n", "<F5>", function()
	if vim.bo.filetype == "rust" and not dap.session() then
		vim.cmd.RustLsp("debuggables")
	else
		dap.continue()
	end
end, { desc = "Debug: Continue" })

vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
vim.keymap.set("n", "<leader>cc", dap.terminate, { desc = "Debug: Stop" })

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpoint",
})
vim.fn.sign_define("DapStopped", {
	text = "→",
	texthl = "DapStopped",
})

dap.adapters.lldb = {
	type = "executable",
	command = "lldb-dap",
	name = "lldb",
}

local lldb = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.c = vim.deepcopy(lldb)
dap.configurations.cpp = vim.deepcopy(lldb)
dap.configurations.zig = vim.deepcopy(lldb)

local python = vim.fn.getcwd() .. "/.venv/bin/python"
if vim.fn.executable(python) == 1 then
	require("dap-python").setup(python)
else
	require("dap-python").setup("python")
end

vim.keymap.set("n", "<leader>cd", function()
	require("dapui").toggle()
end, { desc = "Debug: Toggle UI" })
