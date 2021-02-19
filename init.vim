" Install vim-plug if it's not installed yet
if empty(glob(stdpath('data').'/site/autoload/plug.vim'))
  exe "silent !curl -fLo ".stdpath('data')."/site/autoload/plug.vim --create-dirs"
        \." 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
  autocmd VimEnter * PlugInstall | nested source $MYVIMRC
endif

" Load plugins
call plug#begin()

" IDE
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'liuchengxu/vista.vim'

" Fern (file explorer)
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

" Utilities
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'farmergreg/vim-lastplace' " Restore cursor position
Plug 'ctrlpvim/ctrlp.vim' " Search files, mru, etc
Plug 'scrooloose/nerdcommenter' " Toggle comments
Plug 'Shougo/vinarise.vim' " HEX editor
Plug 'Raimondi/delimitMate'
Plug 'gregsexton/MatchTag'
Plug 'rbgrouleff/bclose.vim' " Close buffer without close window
Plug 'danro/rename.vim' " Rename file in place
Plug 'benmills/vimux'
Plug 'hugolgst/vimsence' " Discord rich presence
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

" Appearance
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'

call plug#end()

let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'

" Coc
let g:coc_global_extensions = [
      \ 'coc-vimlsp',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-prettier',
      \ 'coc-deno',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-java',
      \ 'coc-rust-analyzer',
      \ 'coc-xml',
      \ 'coc-highlight',
      \ 'coc-python',
      \ 'coc-cmake',
      \ 'coc-vetur',
      \ 'coc-clangd',
      \ 'coc-solargraph',
      \ 'coc-sh',
      \ ]
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

function! CurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

" Show current function on Airline
let g:airline_section_x = '%{airline#util#prepend("",0)}'
      \. '%{airline#util#prepend(CurrentFunction(),0)}'
      \. '%{airline#util#prepend("",0)}'
      \. '%{airline#util#prepend("",0)}'
      \. '%{airline#util#wrap(airline#parts#filetype(),0)}'

" Vista
let g:vista_default_executive = 'coc'
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
autocmd VimEnter * nested call LoadSession() | Fern . -drawer | wincmd p
autocmd VimLeave * :call SaveSession()

" Fern
let g:fern#renderer = "nerdfont"

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
" Javascript with styled-components
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
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
" Toggle Fern
nmap <silent> <F5> :Fern . -drawer -toggle \| wincmd p<CR>
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
" Coc
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <C-LeftMouse> <LeftMouse><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Theme
set termguicolors
colorscheme dracula

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
