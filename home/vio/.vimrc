set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on
set tabstop=4   " a tab will be represented with 4 columns
set softtabstop=4 " <tab> is pressed in insert mode 4 columns
set shiftwidth=4 " indentation is 4 columns
set noexpandtab " tabs are tabs, do not replace with spaces
" show linenumbers
set number

" disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
set backup
set undofile
set noshowmode
set hlsearch
set scrolloff=4
set fileformat=unix
set fileformats=unix,dos
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,cp1250,iso-8859-1

filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'padawan-php/padawan.vim'
Plugin 'Syntastic'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:airline_powerline_fonts = 1
set laststatus=2
" clock
function! AirlineInit()
        let g:airline_section_y = airline#section#create(['ffenc', '%{strftime("%H:%M")}'])
endfunction
autocmd VimEnter * call AirlineInit()


silent execute '!mkdir -p $HOME/.vim/tmp/backup'
set backupdir=$HOME/.vim/tmp/backup " where to store backup
silent execute '!mkdir -p $HOME/.vim/tmp/swap'
set directory=$HOME/.vim/tmp/swap   " where to store swap
silent execute '!mkdir -p $HOME/.vim/tmp/views'
set viewdir=$HOME/.vim/tmp/views    " where to store views
silent execute '!mkdir -p $HOME/.vim/tmp/undo'
set undodir=$HOME/.vim/tmp/undo     " where to store undo

" theme
" set background=dark
" colorscheme PaperColor
let g:jellybeans_background_color = "000000"
colorscheme jellybeans

" in vim8, backspace does not erase on the start of the line...
set backspace=indent,eol,start

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" Close preview window when autocomplete done!
au CompleteDone * pclose

let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
map <C-n> :NERDTreeToggle<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" write with sudo
" command W w !sudo tee % > /dev/null
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command R :execute ':SyntasticReset'
