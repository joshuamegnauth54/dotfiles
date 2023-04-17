-- Debug adapter protocol
-- https://github.com/mfussenegger/nvim-dap

return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("dap")
			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
			sign("DapBreakpointRejected", { text = "◆", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
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
			local handle = io.popen("which python 2> /dev/null")
			if handle then
				local result = handle:read("*a")
				handle:close()
				require("dap-python").setup(result)
			else
				require("dap-python").setup("/usr/bin/python")
			end
		end,
	},
}
