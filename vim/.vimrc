" First things first
set nocompatible

" Must be here
source ~/.vim/plugins.vim

" Simple options
set autoindent                          " Autoindent new lines
set autoread                            " Automatically read externally modified files
set autowrite                           " Automatically save before commands like :next and :make
set backspace=indent,eol,start          " Backspace through autoindentation, insertion point and begining/ending of lines
set display+=lastline                   " Always show lastline
set expandtab                           " Expand tabs as spaces
set formatoptions+=j                    " Delete comment character when joining commented lines
set hidden                              " Hide buffers when they are abandoned
set history=1000                        " Keep history of 1000 commands and 1000 patterns
set hlsearch                            " Highlight pattern matches
set ignorecase                          " Do case insensitive matching
set incsearch                           " Incremental search
set laststatus=2                        " Always show window status line
set list                                " Show non-printable characters
set mouse=a                             " Enable mouse usage (all modes)
set nobackup                            " Do not keep backup files
set nowrap                              " Do not wrap long lines
set number                              " Show line numbers
set numberwidth=4                       " Show line numbers using 4 digits
set ruler                               " Show cursor position in lower right screen corner
set scrolloff=1                         " Keep 1 line above/under cursor when scrolling
set shiftwidth=0                        " Use &tabstop value for autoindent width
set showcmd                             " Show (partial) command in status line
set showmatch                           " Show matching brackets
set showmode                            " Show current mode in status line
set sidescrolloff=5                     " Keep 1 line left/right of cursor when scrolling
set smartcase                           " Do smart case matching
set smarttab                            " Do smart indent insertion/deletion
set tabpagemax=50                       " Maximum number of tab pages to open with CLI or tab command
set tabstop=4                           " Use 4 characters wide tabs
set t_Co=256                            " Force vim to use 256 colors
set wildmenu                            " Show command completion menu

" Set nicer non-visible characters representation
set listchars=tab:⇥\ ,trail:•,extends:⇢,precedes:⇠,nbsp:‥

" Set file encoding to UTF-8 and terminal encoding to locale
let &termencoding=&encoding
set encoding=utf-8

" Enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" Set color scheme
colorscheme slate
set background=dark

" Jump to last editing position when opening a file
if has('autocmd')
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Auto break text file lines at 78 characters
if has('autocmd')
    autocmd FileType text setlocal textwidth=78
endif

" Load indentation rules and plugins according to the detected filetype
if has('autocmd')
    filetype plugin indent on
endif

" Easily edit vimrc
if !exists(':VimRC')
    command VimRC :edit ~/.vimrc
endif

