local set = vim.api.nvim_set_keymap
local ns = { noremap = true, silent = true }

-- Close buffer but keep window
set('n', '<Leader>bd', ':BW<CR>', ns)
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
-- Dap
set('n', '<F6>', [[<cmd>lua require'dap'.continue()<CR>]], ns)
set('n', '<F7>', [[<cmd>lua require'dap'.step_over()<CR>]], ns)
set('n', '<F8>', [[<cmd>lua require'dap'.step_into()<CR>]], ns)
set('n', '<F9>', [[<cmd>lua require'dap'.step_out()<CR>]], ns)
set('n', '<leader>b', [[<cmd>lua require'dap'.toggle_breakpoint()<CR>]], ns)
set('n', '<leader>B', [[<cmd>lua require'dap'.set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>]], ns)
set('n', '<leader>lp', [[<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>]], ns)
set('n', '<leader>dr', [[<cmd>lua require'dap'.repl.open()<CR>]], ns)
set('n', '<leader>dl', [[<cmd>lua require'dap'.run_last()<CR>]], ns)
set('n', '<leader>dc', [[<cmd>Telescope dap commands<CR>]], ns)
set('n', '<leader>ds', [[<cmd>Telescope dap configurations<CR>]], ns)
set('n', '<leader>db', [[<cmd>Telescope dap list_breakpoints<CR>]], ns)
set('n', '<leader>dv', [[<cmd>Telescope dap variables<CR>]], ns)
set('n', '<leader>df', [[<cmd>Telescope dap frames<CR>]], ns)
set('n', '<leader>dk', [[<cmd>lua require'dap.ui.widgets'.hover()<CR>]], ns)
