vim.keymap.set("n", "<leader>dd", ":lua require'dap'.continue()<CR>", { desc = "Toggle debugger & continue to breakpoint" })

vim.keymap.set("n", "<leader>dj", ":lua require'dap'.step_into()<CR>", { desc = "Debug | Step Into" })
vim.keymap.set("n", "<leader>dk", ":lua require'dap'.step_out()<CR>", { desc = "Debug | Step Out" })
vim.keymap.set("n", "<leader>dl", ":lua require'dap'.step_over()<CR>", { desc = "Debug | Step Over | Next line" })
vim.keymap.set("n", "<leader>dc", ":lua require'dap'.run_to_cursor()<CR>", { desc = "Debug | Run To Cursor" })
vim.keymap.set("n", "<leader>dh", ":lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debug | Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debug | Toggle Conditional Breakpoint" })


vim.keymap.set("n", "<leader>dm", ":lua require'dap-python'.test_method()<CR>", { desc = "Test Method" })

vim.keymap.set("n", "<leader>do", ":lua require'dapui'.open()<CR>", { desc = "Test Method" })
vim.keymap.set("n", "<leader>dc", ":lua require'dapui'.close()<CR>", { desc = "Test Method" })

local dap = require("dap")
local dapui = require("dapui")

-- require("dap-
-- dap.adapters.python = {
--   type = 'executable';
--   command = '/Users/alphabrain/Workspace/docs/yolo/anim/anim/bin/python',
--   args = { '-m', 'debugpy.adapter' };
-- }
-- dap.configurations.python = {
--   {
--     type = 'python';
--     request = 'launch';
--     name = "Launch file";
--     program = "${file}";
--     pythonPath = '/Users/alphabrain/Workspace/docs/yolo/anim/anim/bin/python',
--     console = 'integratedTerminal';
--   },
-- }

require('nvim-dap-virtual-text').setup()

dapui.setup()
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open(
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

require('dap-python').setup('/Users/alphabrain/Workspace/docs/yolo/anim/anim/bin/python')
require('dap-python').test_runner = 'pytest'


