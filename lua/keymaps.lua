local set = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }

-- Close buffer but keep window
set('n', '<Leader>bd', ':bd<CR>', ns)
-- Jump between quickfixes
set('', 'cn', ':cn<CR>', ns)
set('', 'cp', ':cp<CR>', ns)
-- Toggle NvimTree
set('n', '<F5>', ':NERDTreeToggle<CR>', ns)
-- Vista
set('n', '<F2>', ':Vista!!<CR>', ns)
-- Ctrl+A to select all
set('', '<C-a>', '<esc>ggVG<CR>', ns)
-- Ctrl+C/Ctrl+V to copy/paste
set('v', '<C-c>', '"+y', ns)
set('i', '<C-v>', '<esc>"+pi', ns)
-- Buffer Next and Previous
set('n', 'bp', ':bprevious<CR>', ns)
set('n', 'bn', ':bnext<CR>', ns)
-- Open terminal on split
set('n', '<leader>t', ':12split | terminal<CR>', ns)
-- Telescope
set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', ns)
set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', ns)
set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', ns)
set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', ns)
-- Sessions
-- restore the session for the current directory
set('n', '<leader>qs', [[<cmd>lua require'persistence'.start()<cr>]], ns)
-- restore the last session
set('n', '<leader>ql', [[<cmd>lua require'persistence'.load({ last = true })<cr>]], ns)
-- stop Persistence => session won't be saved on exit
set('n', '<leader>qd', [[<cmd>lua require'persistence'.stop()<cr>]], ns)
-- Vimux
-- Run npm scripts
set('', '<Leader>vd', ':VimuxRunCommand("npm run dev")<CR>', ns)
set('', '<Leader>vb', ':VimuxRunCommand("npm run storybook")<CR>', ns)
set('', '<Leader>vs', ':VimuxRunCommand("npm start")<CR>', ns)
set('', '<Leader>vt', ':VimuxRunCommand("npm test")<CR>', ns)
set('', '<Leader>vc', ':VimuxRunCommand("npm ci")<CR>', ns)
-- Prompt for a command to run
set('', '<Leader>vp', ':VimuxPromptCommand<CR>', ns)
set('', '<Leader>vn', ':VimuxPromptCommand("npm run ")<CR>', ns)
-- Run last command executed by VimuxRunCommand
set('', '<Leader>vl', ':VimuxRunLastCommand<CR>', ns)
-- Inspect runner pane
set('', '<Leader>vi', ':VimuxInspectRunner<CR>', ns)
-- Close vim tmux runner opened by VimuxRunCommand
set('', '<Leader>vq', ':VimuxCloseRunner<CR>', ns)
-- Interrupt any command running in the runner pane
set('', '<Leader>vx', ':VimuxInterruptRunner<CR>', ns)
-- Zoom the runner pane (use <bind-key> z to restore runner pane)
set('', '<Leader>vz', ':call VimuxZoomRunner()<CR>', ns)
set('n', '<F6>', ':lua require"dap".continue()<CR>', ns)
set('n', '<F7>', ':lua require"dap".step_over()<CR>', ns)
set('n', '<F8>', ':lua require"dap".step_into()<CR>', ns)
set('n', '<F9>', ':lua require"dap".step_out()<CR>', ns)
set('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>', ns)
set('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', ns)
set('n', '<leader>lp', ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', ns)
set('n', '<leader>dr', ':lua require"dap".repl.open()<CR>', ns)
set('n', '<leader>dl', ':lua require"dap".run_last()<CR>', ns)
