" Modern Vim Configuration
" Set compatibility to Vim only
set nocompatible

" Auto-install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" Modern plugin manager
Plug 'junegunn/vim-plug'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP support
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Treesitter for better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Modern status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File explorer
Plug 'preservim/nerdtree'

" Commenting
Plug 'preservim/nerdcommenter'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Modern themes
Plug 'tomasiser/vim-code-dark'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

" Better search
Plug 'easymotion/vim-easymotion'

" Indent guides
Plug 'Yggdroot/indentLine'

" Git diff in gutter
Plug 'airblade/vim-gitgutter'

" Auto-completion
Plug 'dense-analysis/ale'

" Multiple cursors
Plug 'mg979/vim-visual-multi'

" Surround
Plug 'tpope/vim-surround'

" Repeat
Plug 'tpope/vim-repeat'

" End plugins
call plug#end()

" Enable filetype detection
filetype plugin indent on

" Turn on syntax highlighting
syntax on

" Basic settings
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" UI
set number
set relativenumber
set cursorline
set showmatch
set matchtime=2
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
set t_vb=

" Performance
set lazyredraw
set ttyfast
set updatetime=300

" Backup and swap
set nobackup
set noswapfile
set nowritebackup

" Scrolling
set scrolloff=5
set sidescrolloff=5

" Text formatting
set wrap
set linebreak
set textwidth=0
set formatoptions=tcqrn1

" Backspace
set backspace=indent,eol,start

" Status line
set laststatus=2

" Whitespace
set list
set listchars=tab:→\ ,trail:·,extends:»,precedes:«,nbsp:×

" Folding
set foldmethod=indent
set foldlevel=99

" Mouse
set mouse=a

" Clipboard
set clipboard=unnamed,unnamedplus

" Key mappings
let mapleader=" "

" Quick save
nnoremap <leader>w :w<CR>

" Quick quit
nnoremap <leader>q :q<CR>

" Toggle search highlighting
nnoremap <leader>h :set hlsearch!<CR>

" Clear search
nnoremap <leader>c :nohlsearch<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows
nnoremap <leader>< <C-w><
nnoremap <leader>> <C-w>>

" FZF mappings
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>r :Rg<CR>

" NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>

" EasyMotion
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" Paste toggle (keeping your original F2 mapping)
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Space to toggle folds (keeping your original mapping)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Auto-save folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Plugin configurations

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='codedark'
let g:airline_powerline_fonts = 1

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.git$', '\.DS_Store$', 'node_modules$']

" GitGutter
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0

" IndentLine
let g:indentLine_char = '│'
let g:indentLine_color_term = 239

" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'python': ['flake8'],
\   'go': ['gofmt'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'python': ['black'],
\   'go': ['gofmt'],
\}
let g:ale_fix_on_save = 1

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
\}

" Colorscheme
set background=dark
colorscheme codedark

" Auto-install plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
