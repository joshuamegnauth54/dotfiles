-- Debug adapter protocol
-- https://github.com/mfussenegger/nvim-dap

return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<F5>",
				function()
					local dap = require("dap")
					if vim.bo.filetype == "rust" and not dap.session() then
						vim.cmd.RustLsp("debuggables")
					else
						dap.continue()
					end
				end,
				desc = "Debug: Continue",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Debug: Step over",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Debug: Step into",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Debug: Step out",
			},
			{
				"<leader>B",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Debug: Toggle breakpoint",
			},
			{
				"<leader>cc",
				function()
					require("dap").terminate()
				end,
				desc = "Debug: Stop",
			},
		},
		config = function()
			vim.fn.sign_define("DapBreakpoint", {
				text = "●",
				texthl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapStopped", {
				text = "→",
				texthl = "DapStopped",
			})

			local dap = require("dap")
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
						-- TODO: This is so ugly.
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
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local python = vim.fn.getcwd() .. "/.venv/bin/python"
			if vim.fn.executable(python) == 1 then
				require("dap-python").setup(python)
			else
				require("dap-python").setup("python")
			end
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		keys = {
			{
				"<leader>cd",
				function()
					require("dapui").toggle()
				end,
				desc = "Debug: Toggle UI",
			},
		},
	},
}
