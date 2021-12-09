local set = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }

-- Close buffer but keep window
set("n", "<Leader>bd", ":Bclose<CR>", ns)
-- Jump between quickfixes
set("", "cn", ":cn<CR>", ns)
set("", "cp", ":cp<CR>", ns)
-- Toggle NvimTree
set("n", "<F5>", ":NvimTreeToggle<CR>", ns)
-- Vista
set("n", "<F2>", ":Vista!!<CR>", ns)
-- Ctrl+A to select all
set("", "<C-a>", "<esc>ggVG<CR>", ns)
-- Ctrl+C/Ctrl+V to copy/paste
set("v", "<C-c>", "\"+y", ns)
set("i", "<C-v>", "<esc>\"+pi", ns)
-- Buffer Next and Previous
set("n", "bp", ":bprevious<CR>", ns)
set("n", "bn", ":bnext<CR>", ns)
-- Open terminal on split
set("n", "<leader>t", ":12split \\| terminal<CR>", ns)
-- Create session for current directory
set("", "<leader>m", ":call MakeSession()<CR>", ns)
-- Vimux
-- Run npm scripts
set("", "<Leader>vd", ":VimuxRunCommand('npm run dev')<CR>", ns)
set("", "<Leader>vb", ":VimuxRunCommand('npm run storybook')<CR>", ns)
set("", "<Leader>vs", ":VimuxRunCommand('npm start')<CR>", ns)
set("", "<Leader>vt", ":VimuxRunCommand('npm test')<CR>", ns)
set("", "<Leader>vc", ":VimuxRunCommand('npm ci')<CR>", ns)
-- Prompt for a command to run
set("", "<Leader>vp", ":VimuxPromptCommand<CR>", ns)
set("", "<Leader>vn", ":VimuxPromptCommand('npm run ')<CR>", ns)
-- Run last command executed by VimuxRunCommand
set("", "<Leader>vl", ":VimuxRunLastCommand<CR>", ns)
-- Inspect runner pane
set("", "<Leader>vi", ":VimuxInspectRunner<CR>", ns)
-- Close vim tmux runner opened by VimuxRunCommand
set("", "<Leader>vq", ":VimuxCloseRunner<CR>", ns)
-- Interrupt any command running in the runner pane
set("", "<Leader>vx", ":VimuxInterruptRunner<CR>", ns)
-- Zoom the runner pane (use <bind-key> z to restore runner pane)
set("", "<Leader>vz", ":call VimuxZoomRunner()<CR>", ns)
set("n", "<F6>", ":lua require'dap'.continue()<CR>", ns)
set("n", "<F7>", ":lua require'dap'.step_over()<CR>", ns)
set("n", "<F8>", ":lua require'dap'.step_into()<CR>", ns)
set("n", "<F9>", ":lua require'dap'.step_out()<CR>", ns)
set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", ns)
set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", ns)
set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", ns)
set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", ns)
set("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", ns)
