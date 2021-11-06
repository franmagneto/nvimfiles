" Install vim-plug if it's not installed yet
if empty(glob(stdpath('data').'/site/autoload/plug.vim'))
  exe "silent !curl -fLo ".stdpath('data')."/site/autoload/plug.vim --create-dirs"
        \." 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
  autocmd VimEnter * PlugInstall | nested source $MYVIMRC
endif

" Load plugins
call plug#begin()

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" Utilities
Plug 'liuchengxu/vista.vim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'farmergreg/vim-lastplace' " Restore cursor position
Plug 'ctrlpvim/ctrlp.vim' " Search files, mru, etc
Plug 'scrooloose/nerdcommenter' " Toggle comments
Plug 'Shougo/vinarise.vim' " HEX editor
Plug 'cohama/lexima.vim'
Plug 'gregsexton/MatchTag'
Plug 'rbgrouleff/bclose.vim' " Close buffer without close window
Plug 'danro/rename.vim' " Rename file in place
Plug 'benmills/vimux'
Plug 'vimsence/vimsence' " Discord rich presence
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-characterize'

" Git
Plug 'airblade/vim-gitgutter' " Show modified lines
Plug 'tpope/vim-fugitive' " Git commands and status of files
Plug 'whiteinge/diffconflicts'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'ron-rs/ron.vim'
Plug 'kevinoid/vim-jsonc'
Plug 'boeckmann/vim-freepascal'
Plug 'ARM9/snes-syntax-vim'

" Appearance
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'ryanoasis/vim-devicons'

call plug#end()

lua <<EOF

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'jdtls' }

for _, name in pairs(servers) do
	local ok, server = lsp_installer.get_server(name)
	-- Check that the server is supported in nvim-lsp-installer
	if ok then
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      }
    }
    
    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --   opts.root_dir = function() return vim.loop.cwd() end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}


-- If you want to use this for rust and c, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require('rust-tools').setup({})

EOF

let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'

" Vista
let g:vista_default_executive = 'nvim_lsp'
let g:vista_executive_for = {
      \ 'vim': 'ctags',
      \ 'sh': 'ctags',
      \ }
let g:vista_disable_statusline = 1
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_close_on_jump = 1

" CtrlP
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" Use ripgrep with CtrlP
if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" Create session per directory (http://vim.wikia.com/wiki/Go_away_and_come_back)
function! MakeSession()
  let b:sessiondir = stdpath('config') . "/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:sessionfile = b:sessiondir . '/session.vim'
  exe "mksession! " . b:sessionfile
endfunction

" Save current session
function! SaveSession()
  if v:this_session != ""
    echo "Saving."
    exe 'mksession! ' . v:this_session
  else
    echo "No Session."
  endif
endfunction

" Loads a session if it exists and nvim was called with no arguments
function! LoadSession()
  if argc() == 0
    let b:sessiondir = stdpath('config') . "/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo "No session loaded."
    endif
  endif
endfunction

" Load session for the current directory and save it on close
autocmd VimEnter * nested call LoadSession() | CHADopen --nofocus
autocmd VimLeave * :call SaveSession()

" CHADTree
let g:chadtree_settings = { "options.session": v:false }

" Close Neovim if last window is CHADTree
" (based on https://vim.fandom.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last)
au BufEnter * call LastWindow()
function! LastWindow()
  if &filetype=="CHADTree"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" Only filename on tabs, no path
let g:airline#extensions#tabline#fnamemod = ':t'

" gitgutter
let g:gitgutter_max_signs = 1000

" nerdcommenter
let g:NERDSpaceDelims = 1

" Terminal settings (no line numbers; start in Terminal-mode)
autocmd TermOpen * setlocal nonumber norelativenumber | startinsert

" Vimux
let g:VimuxOrientation = 'h'
let g:VimuxHeight = 30

" Syntax
au BufNewFile,BufRead *.{ASM,INC,asm,inc} set filetype=snes_bass
" Java
let java_highlight_functions = 1
let java_highlight_all = 1
let java_highlight_debug = 1
highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProc

" Mappings

" Close buffer but keep window
nnoremap <silent> <Leader>bd :Bclose<CR>
" Jump between quickfixes
map cn :cn<CR>
map cp :cp<CR>
" Toggle CHADTree
nnoremap <F5> <cmd>CHADopen --nofocus<cr>
" Vista
nmap <silent> <F2> :Vista!!<CR>
" Ctrl+A to select all
map <C-a> <esc>ggVG<CR>
" Ctrl+C/Ctrl+V to copy/paste
vmap <C-c> "+y
imap <C-v> <esc>"+pi
" Buffer Next and Previous
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>
" Open terminal on split
nmap <leader>t :12split \| terminal<CR>
" Create session for current directory
map <leader>m :call MakeSession()<CR>
" Vimux
" Run npm scripts
map <Leader>vd :VimuxRunCommand('npm run dev')<CR>
map <Leader>vb :VimuxRunCommand('npm run storybook')<CR>
map <Leader>vs :VimuxRunCommand('npm start')<CR>
map <Leader>vt :VimuxRunCommand('npm test')<CR>
map <Leader>vc :VimuxRunCommand('npm ci')<CR>
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vn :VimuxPromptCommand('npm run ')<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>
nnoremap <silent> <F6> :lua require'dap'.continue()<CR>
nnoremap <silent> <F7> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F8> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F9> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

" Theme
set termguicolors
colorscheme gruvbox-material

" Highlight the 80th column
set colorcolumn=80

" Set indent to 2 spaces, not expanded, but let plugins to override it
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd filetype make setlocal noexpandtab
filetype plugin indent on

" Commands
command! W :execute ':silent w !sudo tee "%" > /dev/null' | :edit!

" Misc
set hidden
set cul
set number
set ic scs tc=followscs
set noswapfile
set linebreak
set nolist
set splitbelow
set mouse=a
set backupcopy=yes
set updatetime=300
set shortmess+=c
set signcolumn=yes
let g:tex_flavor = "latex"
