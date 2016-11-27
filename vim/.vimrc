" First things first
set nocompatible

" First initialize Vundle & plugins (if available)
if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    source ~/.vim/plugins.vim
endif

" Terminal options {
"    set t_Co=256                            " Force vim to use 256 colors
" }

" General options {
    set autoread                            " Automatically read externally modified files
    set autowrite                           " Automatically save before commands like :next and :make
    set backupdir=~/.vim/backup//           " Save backup files in a central temporal directory
    set backup                              " Keep backup files
    set clipboard=unnamedplus               " Use X clipboard as the unnamed register
    set directory=~/.vim/swap//             " Save swap files in a central temporal directory
    set hidden                              " Hide buffers when they are abandoned
    set history=1000                        " Keep history of 1000 commands and 1000 patterns
    set nospell                             " Disable spelling checking
    set undodir=~/.vim/undo//               " Save undo files in a central temporal directory
    set undofile                            " Have persistent undo
    set undolevels=1000                     " Maximum number of undos
    set undoreload=10000                    " Maximum number of lines a buffer must have to be persisted in undos
    set viewoptions=cursor,folds,options,slash,unix " Improve saved views compatibility
" }

" Matching options {
    set ignorecase                          " Do case insensitive matching
" }

" UI options {
    set display+=lastline                   " Always show lastline
    set hlsearch                            " Highlight pattern matches
    set incsearch                           " Incremental search
    set laststatus=2                        " Always show window status line
    set listchars=tab:⇥\ ,trail:•,extends:⇢,precedes:⇠,nbsp:‥ " Set nicer non-characters representation
    set list                                " Show non-printable characters
    set mouse=a                             " Enable mouse usage (all modes)
    set mousehide                           " Hide mouse cursor while typing
    set number                              " Show line numbers
    set numberwidth=4                       " Show line numbers using 4 digits
    set ruler                               " Show cursor position in lower right screen corner
    set scrolloff=1                         " Lines to keep above/under cursor when scrolling
    set shortmess=aoOtT                     " Shorten vim information messages
    set showcmd                             " Show (partial) command in status line
    set showmatch                           " Show matching brackets
    set showmode                            " Show current mode in status line
    set sidescrolloff=5                     " Characters to keep left/right of cursor when scrolling
    set tabpagemax=15                       " Maximum number of tab pages to open with CLI or tab command
    set wildmenu                            " Show command completion menu
    set wildmode=list:longest,full          " Command completion insert longest match and show wildmenu
" }

" Formatting options {
    set autoindent                          " Autoindent new lines
    set expandtab                           " Expand tabs as spaces
    set formatoptions+=j                    " Delete comment character when joining commented lines
    set nojoinspaces                        " Prevents inserting two spaces after punctuation on a join (J)
    set nowrap                              " Do not wrap long lines
    set shiftwidth=0                        " Use &tabstop value for autoindent width
    set tabstop=4                           " Use 4 characters wide tabs

    if has('autocmd')
        " Remove trailing whitespaces and ^M chars
        autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
        " Go format
        autocmd FileType go autocmd BufWritePre <buffer> Fmt
        " Small indentation file types
        autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    endif

" }

" Editing options {
    set backspace=indent,eol,start          " Backspace through autoindentation, insertion point and begining/ending of lines
    set pastetoggle=<F12>                   " Use F12 to toggle paste mode
    set smartcase                           " Do smart case matching
    set smarttab                            " Do smart indent insertion/deletion
    set whichwrap=b,s,h,l,<,>,[,]           " Backspace and cursor keys wrap too
" }


" Set file encoding to UTF-8 and terminal encoding to locale
let &termencoding=&encoding
set encoding=utf-8

" Enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" Set color scheme options
set background=dark
colorscheme slate

"colorscheme solarized|
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"

" Change leader keys
let mapleader=','
let localmapleader='_'

if has('autocmd')

    " Jump to last editing position when opening a file
    augroup restoreCursor
        autocmd!
        autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | silent! normal! g'" | endif
    augroup END
    " ...except on git commit messages
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Auto break text file lines at 78 characters
    autocmd FileType text setlocal textwidth=78

    " CD to the file directory if there is only one arg
    autocmd BufEnter * if argc()==1 && bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

endif

" Easily edit vimrc & plugins
command! EVimRC :edit ~/.vimrc
command! EPlugins :edit ~/.vim/plugins.vim
map <leader>ev :EVimRC<CR>
map <leader>ep :EPlugins<CR>

" Wrapped lines goes down/up to next row, rather than next line in file
noremap j gj
noremap k gk

" C-PageDown
map <C-PageDown> :tabn<CR>
map <C-PageUp> :tabp<CR>

" Hide/show search highlights
nmap <silent> <leader>- :set invhlsearch<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Allow using the repeat operator with a visual selection
vnoremap . :normal .<CR>

" Open files in current file's directory helpers
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :edit %%
map <leader>es :split %%
map <leader>ev :vsplit %%
map <leader>et :tabedit %%

" Indent / Dedent using tab & shift-tab
map <Tab> :call IndentCurrentLine()<CR>
map <S-Tab> :call DedentCurrentLine()<CR>

" Plugins settings =============================================================

" Ack.vim {
if isdirectory(expand("~/.vim/bundle/ack.vim"))
    " Use the-silversurfer-ag for ack
    let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
endif
" }

" matchit {
if isdirectory(expand("~/.vim/bundle/matchit.zip"))
    let b:match_ignorecase = 1
endif
" }

" Go {
if isdirectory(expand("~/.vim/bundle/vim-go"))
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
    let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
    au FileType go nmap <Leader>s <Plug>(go-implements)
    au FileType go nmap <Leader>i <Plug>(go-info)
    au FileType go nmap <Leader>e <Plug>(go-rename)
    au FileType go nmap <leader>r <Plug>(go-run)
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <Leader>gd <Plug>(go-doc)
    au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
    au FileType go nmap <leader>co <Plug>(go-coverage)
endif
" }

" NERDTree {
if isdirectory(expand("~/.vim/bundle/nerdtree"))
    map <C-e> :NERDTreeToggle<CR>
    map <C-S-e> :NERDTreeFind<CR>
    let g:NERDTreeShowHidden=1
    let g:NERDTreeShowBookmarks=1
    " close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
" }

" TagBar {
if isdirectory(expand("~/.vim/bundle/tagbar"))
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
endif
" }

" NeoComplete {
if isdirectory(expand("~/.vim/bundle/neocomplete.vim"))
    let g:neocomplete#enable_at_startup=1
endif
" }

" Airline {
if isdirectory(expand("~/.vim/bundle/Airline"))
    let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#tabline#left_sep=' '
    let g:airline#extensions#tabline#left_alt_sep='|'
    let g:airline#extensions#tabline#right_sep=' '
    let g:airline#extensions#tabline#right_alt_sep='|'
    let g:airline_left_sep=' '
    let g:airline_left_alt_sep='|'
    let g:airline_right_sep=' '
    let g:airline_right_alt_sep='|'
endif
" }

" FUNCTIONS ====================================================================

function! StripTrailingWhitespace()
    " save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do it
    %s/\s\+$//e
    " restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! IndentCurrentLine()
    let l = line(".")
    let c = col(".")
    :normal I	
    call cursor(l, c)
endfunction

function! DedentCurrentLine()
    let l = line(".")
    let c = col(".")
    :normal [7~wi
    call cursor(l, c)
endfunction
