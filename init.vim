" Install vim-plug if it's not installed yet
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | nested source $MYVIMRC
endif

" Load plugins
call plug#begin()

" IDE
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'
Plug 'vim-syntastic/syntastic'
Plug 'neomake/neomake'
Plug 'majutsushi/tagbar'
Plug 'nacitar/a.vim' " Switch between .h and .c/.cpp files

" Utilities
Plug 'farmergreg/vim-lastplace' " Restore cursor position
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/vinarise.vim' " HEX editor
Plug 'Raimondi/delimitMate'
Plug 'gregsexton/MatchTag'
Plug 'rbgrouleff/bclose.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Syntax
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script'
Plug 'tikhomirov/vim-glsl'
Plug 'moll/vim-node'

" Appearance
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

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

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Syntastic 
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 0

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
  if (getcwd() != $HOME)
    let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
    if (filewritable(b:sessiondir) != 2)
      exe 'silent !mkdir -p ' b:sessiondir
      redraw!
    endif
    let b:filename = b:sessiondir . '/session.vim'
    exe "mksession! " . b:filename
  endif
endfunction

function! LoadSession()
  if (getcwd() != $HOME)
    let b:sessiondir = $HOME . "/.config/nvim/sessions" . getcwd()
    let b:sessionfile = b:sessiondir . "/session.vim"
    if (filereadable(b:sessionfile))
      exe 'source ' b:sessionfile
    else
      echo "No session loaded."
    endif
  endif
endfunction

" Load session for the current directory and save it on close
autocmd VimEnter * nested call LoadSession() | Lexplore | wincmd p
autocmd VimLeave * call MakeSession()

" Config netrw to be similar to NERDTree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = -25
let g:netrw_list_hide = '^\.git/,^\.hg/,^\.svn/,^\.bundle/'

" Close nvim if netrw is the last buffer
augroup netrw_close
  autocmd!
  autocmd QuitPre * if winnr('$') == 2 && winnr() != 1
        \ && getbufvar(winbufnr(1), "&filetype") == "netrw"
        \ | Lexplore | endif
augroup END

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" Only filename on tabs, no path
let g:airline#extensions#tabline#fnamemod = ':t'

" Tagbar
let g:tagbar_compact = 1
let g:tagbar_width = 30

" Mappings

" Close buffer but keep window
nnoremap <silent> <Leader>bd :Bclose<CR>
" Jump between quickfixes
map cn :cn<CR>
map cp :cp<CR>
" Toggle netrw on left split
map <silent> <F5> :Lexplore<CR>
" Tagbar
nmap <F2> :TagbarToggle<CR>
" Ctrl+A to select all
map <C-a> <esc>ggVG<CR>
" Ctrl+C/Ctrl+V to copy/paste
vmap <C-c> "+y
imap <C-v> <esc>"+pi
" Run current file on terminal
nmap <F9> :terminal ./%<CR>
" Run "make" and "make clean" on current directory
nmap <F8> :Neomake! "make -j$(nproc)"<CR>
nmap <F7> :Neomake! "make clean"<CR>
" Syntastic
nmap <leader>e :Errors<CR>
" Create tab with new buffer
nnoremap tt  :tabnew<CR>
" Buffer Next and Previous
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>
" Open terminal on split
nmap <leader>t :8split \| terminal<CR>
" Start rails server on split terminal
nmap <leader>r :8split \| terminal rails s<CR><C-\><C-n>:wincmd p<CR>

" Theme
set termguicolors
colorscheme molokai

" Highlight the 80th column
set tw=79
set colorcolumn=+1

" Set indent to 2 spaces, not expanded, but let plugins to override it
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
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
let g:tex_flavor = "latex"
