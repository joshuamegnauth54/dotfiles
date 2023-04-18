-- Debug adapter protocol
-- https://github.com/mfussenegger/nvim-dap

local function which(bin)
	local cmd = string.format("which %s 2> /dev/null", bin)
	local handle = io.popen(cmd)

	if handle then
		local result = handle:read("*a")
		handle:close()

		-- Return the path of the binary found by which or an empty string
		if result then
			return result
		end
	end

	-- Return an empty string instead of nil
	return ""
end

return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local sign = vim.fn.sign_define

			-- Key mapping
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign("DapBreakpointRejected", { text = "◆", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })

			-- Debug adapters
			dap.adapters.lldb = {
				type = "executable",
				command = which("lldb-vscode"),
				name = "lldb",
			}
		end,
		keys = {
			{
				"<Leader>B",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<Leader><C-c>",
				function()
					require("dap").terminate()
				end,
			},
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "(Debugging) Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Step over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Step into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Step out",
			},
		},
	},
	-- https://github.com/rcarriga/nvim-dap-ui
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{
				"C-d",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle dapui",
			},
		},
	},
	-- https://github.com/mfussenegger/nvim-dap-python
	{
		"mfussenegger/nvim-dap-python",
		ft = { "python" },
		config = function()
			-- This path should be a Python installation which has `debugpy`
			-- The documentation recommends installing it in a virtual environment. Oh well.
			local path = which("python")
			require("dap-python").setup(path)
		end,
	},
}
