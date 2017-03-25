"
" Basic settings----------------"
"

" Set augroup
augroup MyAutoCmd
    autocmd!
augroup END

" Encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp

scriptencoding utf-8

set autoindent                  " auto indent
set autoread                    " automatically reload
set backspace=indent,eol,start  " back space
set expandtab                   " change tab into space
set foldenable                  " enable folding
set foldmethod=marker
set helplang=ja,en              " prefer Japanese help
set hidden                      " edit multiple files
set hlsearch                    " highlight matches
set ignorecase                  " ignore case of search
set incsearch                   " do incremental searching
set laststatus=2                " always display the status line
set lazyredraw                  " redraw only when we need to
set list                        " display invisible
set listchars=tab:>\ ,extends:< " display invisible
set nobackup                    " do not create backup file
set noswapfile                  " do not create swap file
set noundofile                  " do not create undo file
set novisualbell                " do not use visualbell
set number                      " display line numbers
set ruler                       " display the cursor position
set shiftwidth=4                " tab width
set showcmd                     " display incomplete commands
set showmatch                   " highlight the ()
set smartcase                   " ignore capital letters and child characters
set smartindent                 " smart indent
set smarttab                    " tab width
set softtabstop=4               " tab width
set spelllang=en,cjk            " do not check the Japanese spelling
set t_Co=256                    " 256 color
set tabstop=4                   " tab width
set textwidth=0                 " maximum width of the input text
set title                       " set the window title
set vb t_vb=                    " do not beep
set wildmenu                    " file name storage
set wrap                        " wrap with a long line
set wrapscan                    " when the search is finished, back to the top


" Change the color after position 81
execute "set colorcolumn=" . join(range(81, 999), ',')


augroup MyAutoCmd

    " Do not comment out with a line feed
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o

    " Disable cursorline with insertmode
    autocmd WinEnter,InsertLeave * set cursorline
    autocmd WinLeave,InsertEnter * set nocursorline

    " Do not display docstring
    autocmd FileType python setlocal completeopt-=preview

    " Check spelling when git commit message
    autocmd FileType gitcommit setlocal nofoldenable spell

augroup END


"
" Key Mappings------------------"
"

" Disable dangerous keys
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Swap ; and :
nnoremap ; :
vnoremap ; :
nnoremap q; q:
vnoremap q; q:
nnoremap : ;
vnoremap : ;

" Don't use Ex mode
nnoremap Q gq

" Auto input }])
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>

" Auto escape '/' and '?'
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'


"
"vim-plug-----------------------"
"

call plug#begin('~/.vim/plugged')

" Display the files in tree type
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Display git status in NERDTree.
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

"
"End vim-plug-------------------"
"


" Colorscheme
set background=dark             " dark background
syntax enable
colorscheme solarized
let g:solarized_termtrans=1


" Line number color
highlight LineNr ctermfg=darkyellow


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


" jedi-vim
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_definitions_command = "<leader>t"


" syntastic
let g:syntastic_python_checkers = ["flake8"]
