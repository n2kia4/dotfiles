"vim-plug-----------------------"
call plug#begin('~/.vim/plugged')

" Display the files in tree type
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Integrated user interface
Plug 'Shougo/unite.vim'
" Display recently used files
Plug 'Shougo/neomru.vim'

" Visualize indent
Plug 'nathanaelkane/vim-indent-guides'

" File search
Plug 'kien/ctrlp.vim'

" Edit
Plug 'tpope/vim-surround'

" Go
Plug 'fatih/vim-go'

" Rust
Plug 'rust-lang/rust.vim'

" Ruby / Ruby on Rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'

call plug#end()
"End vim-plug-------------------"


set number                      " display line numbers
set autoindent                  " auto indent
set smartindent                 " smart indent
set nobackup                    " do not create backup file
set noundofile                  " do not create undo file
set noswapfile                  " do not create swap file
set ruler                       " display the cursor position
set laststatus=2                " always display the status line
set title                       " set the window title
set wildmenu                    " file name storage
set showcmd                     " display incomplete commands
set smartcase                   " ignore capital letters and child characters
set hlsearch                    " highlight matches
set expandtab                   " change tab into space
set incsearch                   " do incremental searching
set hidden                      " edit multiple files
set list                        " display invisible
set listchars=tab:>\ ,extends:< " display invisible
set showmatch                   " highlight the ()
set tabstop=2                   " tab width
set shiftwidth=2                " tab width
set smarttab                    " tab width
set backspace=indent,eol,start  " back space
set t_Co=256
set background=dark            " color scheme
syntax enable
colorscheme solarized
let g:solarized_termtrans=1

" Line number color
highlight LineNr ctermfg=darkyellow

" Auto input }])
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>


" Unit.vim
" start in input mode
let g:unite_enable_start_insert=1


" NERDTree
" launch with Control + n
noremap <C-n> :NERDTreeToggle<CR>


" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
