" Install vim-plug if it's not installed yet
if empty(glob(stdpath('data').'/site/autoload/plug.vim'))
  exe "silent !curl -fLo ".stdpath('data')."/site/autoload/plug.vim --create-dirs"
        \." 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'"
  autocmd VimEnter * PlugInstall | nested source $MYVIMRC
endif

" Load plugins
call plug#begin()

" IDE
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'neomake/neomake'
Plug 'majutsushi/tagbar'
Plug 'nacitar/a.vim' " Switch between .h and .c/.cpp files

" Utilities
Plug 'scrooloose/nerdtree' " File browser
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'farmergreg/vim-lastplace' " Restore cursor position
Plug 'ctrlpvim/ctrlp.vim' " Search files, mru, etc
Plug 'scrooloose/nerdcommenter' " Toggle comments
Plug 'Shougo/vinarise.vim' " HEX editor
Plug 'Raimondi/delimitMate'
Plug 'gregsexton/MatchTag'
Plug 'rbgrouleff/bclose.vim' " Close buffer without close window
Plug 'danro/rename.vim' " Rename file in place

" Git
Plug 'airblade/vim-gitgutter' " Show modified lines
Plug 'tpope/vim-fugitive' " Git commands and status of files

" Syntax
Plug 'sheerun/vim-polyglot'

" Appearance
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'

call plug#end()

" Deoplete + Neosnippet
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
imap <expr><TAB> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" Neomake
call neomake#configure#automake('nrwi', 500)
let g:neomake_javascript_eslint_exe = $PWD .'/node_modules/.bin/eslint'

" CtrlP
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" Use ag (The Silver Searcher) with CtrlP
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
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
autocmd VimEnter * nested call LoadSession() | NERDTree | wincmd p
autocmd VimLeave * :call SaveSession()

" Close nvim if NERDTree is the last window
autocmd QuitPre * if winnr("$") == 2 && getbufvar(winbufnr(1), "&filetype") == "nerdtree" | NERDTreeClose | endif

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" Only filename on tabs, no path
let g:airline#extensions#tabline#fnamemod = ':t'

" Tagbar
let g:tagbar_compact = 1
let g:tagbar_width = 30

" gitgutter
let g:gitgutter_max_signs = 1000

" nerdcommenter
let g:NERDSpaceDelims = 1

" Terminal settings (no line numbers; start in Terminal-mode)
autocmd TermOpen * setlocal nonumber norelativenumber | startinsert

" Mappings

" Close buffer but keep window
nnoremap <silent> <Leader>bd :Bclose<CR>
" Jump between quickfixes
map cn :cn<CR>
map cp :cp<CR>
" Toggle NERDTree
map <silent> <F5> :NERDTreeToggle<CR>
" Tagbar
nmap <F2> :TagbarToggle<CR>
" Ctrl+A to select all
map <C-a> <esc>ggVG<CR>
" Ctrl+C/Ctrl+V to copy/paste
vmap <C-c> "+y
imap <C-v> <esc>"+pi
" Buffer Next and Previous
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>
" Open terminal on split or vsplit
nmap <leader>t :12split \| terminal<CR>
nmap <leader>vt :vsplit \| wincmd p \| terminal<CR>
" Create session for current directory
map <leader>m :call MakeSession()<CR>

" Theme
set termguicolors
let g:onedark_terminal_italics = 1
colorscheme onedark

" Highlight the 80th column
set colorcolumn=80

" Set indent to 2 spaces, not expanded, but let plugins to override it
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
autocmd filetype make setlocal noexpandtab
filetype plugin indent on

" Misc
set hidden
set cul
set number
set ic
set noswapfile
set linebreak
set nolist
set splitbelow
set mouse=a
set backupcopy=yes
let g:tex_flavor = "latex"
