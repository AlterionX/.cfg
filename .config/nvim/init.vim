" disable vi + per file vim
set nocompatible
set modelines=0
set hidden history=1000 undolevels=1000 
set wildignore=*.swp,*.bak,*.pyc,*.class

" backspace
set backspace=indent,eol,start
set nobackup

" tabs and indents
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround smarttab autoindent copyindent

" search
set ignorecase smartcase incsearch hlsearch

set showmatch " show matching parens

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax enable
endif

" numbering
set number numberwidth=5
set ruler

set visualbell " no bell sound
set nowrap " don't wrap lines past edge

" mapping starts
let g:mapleader="\\"

inoremap <c-n> <nop>
inoremap <c-space> <c-n>

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" Easy cut + paste
nnoremap <C-d> ddk
inoremap <C-d> <esc>ddki
nnoremap <C-y> yy
inoremap <C-y> <esc>yyi
inoremap <C-p> <esc>pi

nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>i
vnoremap <C-s> <esc>:w<cr>v

nnoremap <leader>se :vsp $MYVIMRC<cr>
nnoremap <leader>sv :w<cr>:source $MYVIMRC<cr>

" better splits
set splitbelow
set splitright

" better window nav
nnoremap <c-s-w> <nop>
nnoremap <c-W> <nop>
nnoremap <c-h> <c-W><c-h>
nnoremap <c-j> <c-W><c-j>
nnoremap <c-k> <c-W><c-k>
nnoremap <c-l> <c-W><c-l>

" tab navigation
nnoremap <m-h> :tabprev<cr>
nnoremap <m-j> :tablast<cr>
nnoremap <m-k> :tabfirst<cr>
nnoremap <m-l> :tabnext<cr>
nnoremap <m-t> :tabnew<cr>
nnoremap <m-q> :tabclose<cr>
nnoremap <expr> <m-e> "\<esc>:tabedit " . input("file ", "", "file") . "\<cr>"
inoremap <m-h> <esc>:tabprev<cr>
inoremap <m-j> <esc>:tablast<cr>
inoremap <m-k> <esc>:tabfirst<cr>
inoremap <m-l> <esc>:tabnext<cr>
inoremap <m-t> <esc>:tabnew<cr>
inoremap <m-q> <esc>:tabclose<cr>
inoremap <expr> <m-e> "\<esc>:tabedit " . input("file ", "", "file") . "\<cr>"

" search highlight removal
nnoremap <silent> <esc> :nohl<cr>

" cosmetics
set listchars=tab:▸\ ,eol:¬
map <leader>l :set list!<cr>
set title

" go to previous: word level
nnoremap E ge

" folds!
nnoremap <Space> za
nnoremap <leader>ref :set foldmethod=syntax<cr>
set foldmethod=syntax


" single line comments
augroup comments
    autocmd!
    autocmd FileType python noremap <buffer> <C-c> I#<esc>
    autocmd FileType vim noremap <buffer> <C-c> I"<esc>
    autocmd FileType javascript, java noremap <buffer> <C-c> I//<esc>
augroup END

" Entry plugin stuff
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    augroup pluginmanager
        autocmd!
        autocmd VimEnter * PlugInstall --sync | source $ MYVIMRC
    augroup END
endif

filetype off
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --rust-completer --go-completer --clang-completer --ts-completer --java-completer
  endif
endfunction
call plug#begin('~/.local/share/nvim/plugged')
    " Color schemes
    Plug 'joshdick/onedark.vim' " onedark
    Plug 'badacadabra/vim-archery' " archery
    Plug 'cocopon/iceberg.vim' " iceberg
    " Code stuff
    Plug 'sheerun/vim-polyglot'
    Plug 'w0rp/ale'
    Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
    " status line
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
call plug#end()

set background=dark
colorscheme iceberg

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

let g:airline#extenstions#tabline#enabled = 1
let g:airline#extenstions#tabline#left_sep = ' '
let g:airline#extenstions#tabline#left_alt_sep = '|'

let g:ale_completion_enabled = 0
let g:ale_c_build_dir_names = ['build']

":silent PlugUpgrade
":silent PlugUpdate

" single line comments
augroup vim_greeting
    autocmd!
    autocmd VimEnter * echo ">^.^< Welcome back >^.^<"
augroup END

