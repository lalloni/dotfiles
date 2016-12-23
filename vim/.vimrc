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

    " CD to the file directory if there is only one arg and refers to a file
    " in an existent directory.
    autocmd BufEnter * call CDtoPWDonBufEnter()

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

" GVim configuration
if has('gui_running')
    set guioptions-=T " no toolbar
    set lines=40
    set guifont=Input\ Mono\ Narrow\ 11,PragmataPro\ Mono\ 10
endif

" Colorscheme configuration {
    set background=dark
    if isdirectory(expand("~/.vim/bundle/base16-vim"))
        colorscheme base16-google-dark
    endif
" }

" Plugins settings =============================================================

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
        autocmd FileType go nmap <Leader>s <Plug>(go-implements)
        autocmd FileType go nmap <Leader>i <Plug>(go-info)
        autocmd FileType go nmap <Leader>e <Plug>(go-rename)
        autocmd FileType go nmap <leader>r <Plug>(go-run)
        autocmd FileType go nmap <leader>b <Plug>(go-build)
        autocmd FileType go nmap <leader>t <Plug>(go-test)
        autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
        autocmd FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
        autocmd FileType go nmap <leader>co <Plug>(go-coverage)
    endif
" }

" NERDTree {
    if isdirectory(expand("~/.vim/bundle/nerdtree"))
        map <C-e> :NERDTreeToggle<CR>
        map <C-S-e> :NERDTreeFind<CR>
        let g:NERDTreeShowHidden=1
        let g:NERDTreeShowBookmarks=1
        let g:NERDTreeMinimalUI=1
        let g:NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
        let g:NERDTreeKeepTreeInNewTab=1
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
        let g:acp_enableAtStartup = 0
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#enable_auto_delimiter = 1
        let g:neocomplete#enable_auto_select = 1
        let g:neocomplete#enable_auto_close_preview = 1
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'
        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()
        inoremap <expr><Tab> pumvisible() ? "\<CR>" : "\<Tab>"
        " use TAB/S-TAB to select from completion menu
        "inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
        "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
    endif
" }

" NeoSnippets {
    if isdirectory(expand("~/.vim/bundle/neosnippet.vim"))
        imap <C-k> <Plug>(neosnippet_expand_or_jump)
        smap <C-k> <Plug>(neosnippet_expand_or_jump)
        xmap <C-k> <Plug>(neosnippet_expand_target)
        smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
        let g:neosnippet#enable_snipmate_compatibility=1
        let g:neosnippet#snippets_directory='~/.vim/bundle/vim-go/gosnippets/snippets/'
    endif
" }

" Airline {
    if isdirectory(expand("~/.vim/bundle/vim-airline"))
        let g:airline_powerline_fonts=1
        let g:airline#extensions#tabline#enabled=1
        "let g:airline#extensions#tabline#left_sep=' '
        "let g:airline#extensions#tabline#left_alt_sep='|'
        "let g:airline#extensions#tabline#right_sep=' '
        "let g:airline#extensions#tabline#right_alt_sep='|'
        "let g:airline_left_sep=' '
        "let g:airline_left_alt_sep='|'
        "let g:airline_right_sep=' '
        "let g:airline_right_alt_sep='|'
        if isdirectory(expand("~/.vim/bundle/vim-airline-themes"))
            let g:airline_theme='murmur'
        endif
    endif
" }

" CtrlP {
    if isdirectory(expand("~/.vim/bundle/ctrlp.vim"))
        let g:ctrlp_working_path_mode = 'ra'
        let g:ctrlp_custom_ignore = {
            \ 'dir':  '\.git$\|\.hg$\|\.svn$|target$',
            \ 'file': '\.so$\|\.pyc$|\.class$|\.a$'}
        if executable('ag')
            let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
        elseif executable('ack-grep')
            let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
        elseif executable('ack')
            let s:ctrlp_fallback = 'ack %s --nocolor -f'
        endi
        if exists("g:ctrlp_user_command")
            unlet g:ctrlp_user_command
        endif
        let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
            \ },
            \ 'fallback': s:ctrlp_fallback
        \ }
        if isdirectory(expand("~/.vim/bundle/ctrlp-funky"))
            " CtrlP extensions
            let g:ctrlp_extensions = ['funky']
            " funky
            nnoremap <Leader>fu :CtrlPFunky<Cr>
        endif
    endif
" }

" ctags {
    set tags=./tags;/,~/.vimtags
    " Make tags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
        let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
" }

" JSON {
    nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    let g:vim_json_syntax_conceal = 0
" }

" Rainbow {
    if isdirectory(expand("~/.vim/bundle/rainbow"))
        let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    endif
"}

" Fugitive {
    if isdirectory(expand("~/.vim/bundle/vim-fugitive"))
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    endif
"}

" Undotree {
    if isdirectory(expand("~/.vim/bundle/undotree"))
        nnoremap <Leader>u :UndotreeToggle<CR>
        let g:undotree_SetFocusWhenToggle=1
    endif
" }

" Syntastic {
    if isdirectory(expand("~/.vim/bundle/syntastic"))
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_aggregate_errors = 1
        let g:syntastic_check_on_wq = 0
    endif
" }

" Tabularize {
    if isdirectory(expand("~/.vim/bundle/tabular"))
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
        nmap <Leader>a=> :Tabularize /=><CR>
        vmap <Leader>a=> :Tabularize /=><CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a,, :Tabularize /,\zs<CR>
        vmap <Leader>a,, :Tabularize /,\zs<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
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
    normal I	
    call cursor(l, c)
endfunction

function! DedentCurrentLine()
    let l = line(".")
    let c = col(".")
    call cursor(l, 0)
    normal wi
    call cursor(l, c)
endfunction

function! CDtoPWDonBufEnter()
    let bn=bufname("")
    let p=fnamemodify(bn, ":p:h")."/"
    if bn !~ "^\[a-zA-Z0-9\]+://" && !empty(glob(p))
        lcd `=p`
    endif
endfunction

