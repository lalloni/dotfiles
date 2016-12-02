filetype off                        " required by vundle
set rtp+=~/.vim/bundle/Vundle.vim   " required by vundle
call vundle#begin()                 " required by vundle
Plugin 'VundleVim/Vundle.vim'       " required by vundle

" ======================================
" Add plugins from here ================
" ======================================

" Solarized
Plugin 'altercation/vim-colors-solarized'

" git support
Plugin 'fugitive.vim'

" status/buffers/tabs bars
Plugin 'vim-airline/vim-airline'

" ctrl-p navigation
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tacahiroy/ctrlp-funky'

" TagBar
Plugin 'majutsushi/tagbar'

" match with % improvements
Plugin 'matchit.zip'

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Go
Plugin 'fatih/vim-go'

" TOML
Plugin 'cespare/vim-toml'

" Automatically close HTML tags
Plugin 'amirh/HTML-AutoCloseTag'

" Improve CSS3 syntax highlighting
Plugin 'hail2u/vim-css3-syntax'

" Preview colors in CSS
Plugin 'gorodinskiy/vim-coloresque'

" Better JSON syntax highlighting
Plugin 'elzr/vim-json'

" Better JavaScript indentation and syntax highlighting
Plugin 'pangloss/vim-javascript'

" Autocompletion framework
Plugin 'Shougo/neocomplete.vim'

" ======================================
" No more plugins from here ============
" ======================================

call vundle#end()
filetype plugin indent on           " required by vundle
