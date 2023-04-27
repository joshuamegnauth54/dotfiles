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
			sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" })
			sign(
				"DapBreakpointCondition",
				{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "DapBreakpointCondition" }
			)
			sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "DapStopped" })
			sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" })
			sign(
				"DapBreakpointRejected",
				{ text = "◆", texthl = "DapBreakpointRejected", linehl = "", numhl = "DapBreakpointRejected" }
			)

			-- Debug adapters

			-- Rust and C
			dap.adapters.lldb = {
				type = "executable",
				command = which("lldb-vscode"),
				name = "lldb",
			}

			-- Go
			dap.adapters.delve = {
				type = "server",
				port = "${port}",
				executable = {
					command = "dlv",
					args = { "dap", "-l", "127.0.0.1:${port}" },
				},
			}

			-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}

			dap.adapters.haskell = {
				type = "executable",
				command = "haskell-debug-adapter",
				args = { "--hackage-version=0.0.33.0" },
			}
			dap.configurations.haskell = {
				{
					type = "haskell",
					request = "launch",
					name = "Debug",
					workspace = "${workspaceFolder}",
					startup = "${file}",
					stopOnEntry = true,
					logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
					logLevel = "WARNING",
					ghciEnv = vim.empty_dict(),
					ghciPrompt = "λ: ",
					-- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
					ghciInitialPrompt = "λ: ",
					ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
				},
			}

			-- TypeScript
			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
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
				"<Leader>cc",
				function()
					require("dap").terminate()
				end,
				desc = "Stop debugging",
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
				"<Leader>cd",
				function()
					require("dapui").toggle()
					vim.cmd([[DapVirtualTextToggle]])
				end,
				desc = "Toggle dapui and virtual text",
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
	-- https://github.com/mxsdev/nvim-dap-vscode-js
	{
		"mxsdev/nvim-dap-vscode-js",
		ft = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		opts = {
			-- FIXME
			debugger_path = "",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
		},
	},
	-- https://github.com/theHamsta/nvim-dap-virtual-text
	{
		"theHamsta/nvim-dap-virtual-text",
		cmd = { "DapVirtualTextEnable", "DapVirtualTextToggle" },
		opts = {
			highlight_new_as_changed = true,
			commented = true,
		},
	},
}
