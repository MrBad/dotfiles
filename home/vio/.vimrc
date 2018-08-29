set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on
set tabstop=4       " a tab will be represented with 4 columns
set softtabstop=4   " <tab> is pressed in insert mode 4 columns
set shiftwidth=4    " indentation is 4 columns
" set noexpandtab " tabs are tabs, do not replace with spaces
set expandtab       " Expand TABs to spaces
set softtabstop=4   " when hitting <BS>, pretend like a tab is removed, even if spaces
set autoindent      " always set autoindenting on
set copyindent      " copy the previous indentation on autoindenting
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is all lowercase,
set cc=80

highlight Search cterm=underline

map <Leader>t :!phpunit %<cr>       

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>
" easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" show linenumbers
" set number

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
set path=$PWD/**

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set cursorline

filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'scrooloose/nerdtree.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'kien/ctrlp.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'padawan-php/padawan.vim'
" Plugin 'shawncplus/phpcomplete.vim'
" Plugin 'posva/vim-vue'
Plugin 'evidens/vim-twig'
Plugin 'darthmall/vim-vue'
Plugin 'Syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'gregsexton/MatchTag'
Plugin 'kristijanhusak/vim-hybrid-material'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
set laststatus=2
" clock
" function! AirlineInit()
"    let g:airline_section_y = airline#section#create(['ffenc', '%{strftime("%H:%M")}'])
" endfunction
" autocmd VimEnter * call AirlineInit()


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
" let g:jellybeans_background_color = "000000"
" colorscheme jellybeans
let g:enable_bold_font = 1
let g:enable_italic_font = 1
set background=dark
colorscheme hybrid_material
let g:airline_theme = "hybrid"

" in vim8, backspace does not erase on the start of the line...
set backspace=indent,eol,start

" YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files = 1
" Close preview window when autocomplete done!
au CompleteDone * pclose
let g:ycm_autoclose_preview_window_after_insertion = 1


let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
map <C-n> :NERDTreeToggle<CR>
map <C-b> :bNext<CR>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


let g:syntastic_cpp_compiler='g++'
let g:syntastic_cpp_compiler_options='-std=c++11 -Wall -Wextra -Wpedantic'

" let g:syntastic_c_compiler_options='-Wall -Wextra -std=gnu90 -nostdlib -fno-builtin -ffreestandingi -Wno-int-to-pointer-cast'
let g:syntastic_c_compiler_options='-Wall -Wextra -std=c++11'
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_mappings = {
   \ 'jump_to_def': '<C-]>',
   \ 'jump_to_def_split': '<C-W><C-]>',
   \ 'jump_to_def_vsplit': '<C-W><C-]>',
   \}


" write with sudo
" command W w !sudo tee % > /dev/null
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command R :execute ':SyntasticReset'

" I don't want to pull up these folders/files when calling CtrlP
set wildignore+=*/vendor/**

" Laravel "

" Abbreviations
" abbrev pft PHPUnit_Framework_TestCase
" abbrev mm !php artisan make:model
" abbrev mc !php artisan make:controller
" abbrev mmig !php artisan mkae:migration

" Concept - load underlying class for Laravel
function! FacadeLookup()
    let facade = input('Facade Name: ')
    let classes = {
\       'Form': 'Html/FormBuilder.php',
\       'Html': 'Html/HtmlBuilder.php',
\       'File': 'Filesystem/Filesystem.php',
\       'Eloquent': 'Database/Eloquent/Model.php'
\   }

    execute ":edit vendor/laravel/framework/src/Illuminate/" . classes[facade]
endfunction
nmap ,lf :call FacadeLookup()<cr>

au BufRead,BufNewFile *.asm set filetype=nasm
