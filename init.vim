" Install vim-plug if it's not installed yet
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | nested source $MYVIMRC
endif

" Load plugins
call plug#begin()

Plug 'nanotech/jellybeans.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'Raimondi/delimitMate'
Plug 'gregsexton/MatchTag'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script'
Plug 'tomtom/tcomment_vim'
Plug 'nacitar/a.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/vinarise.vim'

call plug#end()

" Hidden buffers (to change from unsaved file and keep it open)
set hidden
" Show current line
set cul
" Show line numbers
set number
" Ignore case when predicting commands and searching
set ic
" Não cria arquivos .swp
set noswapfile

" Theme
set termguicolors
colo jellybeans
set background=dark

" Highlight the 80th column
set tw=79
set colorcolumn=+1
set wrap linebreak nolist

" Deoplete + Neosnippet
let g:deoplete#enable_at_startup = 1 
let g:deoplete#enable_smart_case = 1 
let g:deoplete#auto_complete_start_length = 1
imap <expr><TAB> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Syntastic 
nmap <leader>e :Errors<CR>
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 0

" Ctrlp
set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" The Silver Searcher
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
  let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Load session for the current directory and save it on close
au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()

" Run current file on terminal
nmap <F9> :terminal ./%<CR>
" Run "make" on current directory using "number of cores" jobs
nmap <F8> :Neomake! "make -j$(nproc)"<CR>
" Run "make clean" on current directory
nmap <F7> :Neomake! "make clean"<CR>

" Config netrw to be similar to NERDTree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
" Toggle netrw on left split
map <silent> <F5> :Lexplore<CR>

" Taskbar
nmap <F2> :TagbarToggle<CR>

" Ctrl+C/Ctrl+V to copy/paste
vmap <C-c> "+y
imap <C-v> <esc>"+pi

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" Only filename on tabs, no path
let g:airline#extensions#tabline#fnamemod = ':t'

" Set indent to 2 spaces, not expanded, but let plugins to override it
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
filetype plugin indent on

" Create tab with new buffer
nnoremap tt  :tabnew<CR>

" Buffer Next and Previous
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>

let g:tex_flavor = "latex"
