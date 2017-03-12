"vim-plug-----------------------"
call plug#begin('~/.vim/plugged')

" Display the files in tree type
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
" Integrated user interface
Plug 'Shougo/unite.vim'
" Display recently used files
Plug 'Shougo/neomru.vim'

" Visualize indent
Plug 'nathanaelkane/vim-indent-guides'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File search
Plug 'kien/ctrlp.vim'

" Edit
Plug 'tpope/vim-surround'

" Go
Plug 'fatih/vim-go'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'Vimjas/vim-python-pep8-indent'

" Rust
Plug 'rust-lang/rust.vim'

" Ruby / Ruby on Rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'

" Scala
Plug 'derekwyatt/vim-scala'

" Syntax
Plug 'vim-syntastic/syntastic'

" Colorscheme
Plug 'altercation/vim-colors-solarized'

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
set tabstop=4                   " tab width
set shiftwidth=4                " tab width
set smarttab                    " tab width
set backspace=indent,eol,start  " back space
set ignorecase                  " ignore case of search
set t_Co=256
set background=dark             " color scheme
syntax enable
colorscheme solarized
let g:solarized_termtrans=1

" Line number color
highlight LineNr ctermfg=darkyellow

" Auto input }])
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" Search
" auto escape
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'


" unit.vim
" launch with Space + u?
nnoremap <silent> <Space>ub :Unite buffer<CR>
nnoremap <silent> <Space>uf :UniteWithBufferDir file<CR>


" neomru.vim
" display limit
let g:unite_source_file_mru_limit = 200
" launch with Space + m
nnoremap <silent> <Space>m :Unite file_mru<CR>


" NERDTree
" launch with Space + n
nnoremap <silent> <Space>n :NERDTreeToggle<CR>
" display dotfiles
let NERDTreeShowHidden=1


" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_exclude_filetypes = ['nerdtree']
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=240
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=245


" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'


" Python
autocmd FileType python setlocal completeopt-=preview

" jedi-vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_definitions_command = "<leader>t"

" syntastic
let g:syntastic_python_checkers = ["flake8"]
