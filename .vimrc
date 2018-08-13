" ------------------------------------------------------------------------------
" Basic Settings: {{{1

" ------------------------------------------------------------------------------
" Encoding: {{{2

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp

scriptencoding utf-8

" }}}

" ------------------------------------------------------------------------------
" Set Augroup: {{{2

augroup MyAutoCmd
    autocmd!
augroup END

" }}}"

" ------------------------------------------------------------------------------
" Vim Plug: {{{2

" Disable file type detection
filetype off

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

" Japanese help
Plug 'vim-jp/vimdoc-ja'

" Go
Plug 'fatih/vim-go'

" Python
Plug 'davidhalter/jedi-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'Vimjas/vim-python-pep8-indent'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" Ruby / Ruby on Rails
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'

" Scala
Plug 'derekwyatt/vim-scala'

" Asynchronous Lint Engine
Plug 'w0rp/ale'

" Colorscheme
Plug 'altercation/vim-colors-solarized'

call plug#end()

" Enable file type detection
filetype plugin indent on

" }}}

" ------------------------------------------------------------------------------
" Options: {{{2

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

" Line number color
highlight LineNr ctermfg=darkyellow

" }}}

" ------------------------------------------------------------------------------
" Color Scheme: {{{2

set background=dark             " dark background
syntax enable
let g:solarized_termcolors = 256
let g:solarized_termtrans=1
colorscheme solarized

" }}}

" ------------------------------------------------------------------------------
" Auto Command: {{{2

augroup MyAutoCmd

    " Do not comment out with a line feed
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o

    " Disable cursorline with insertmode
    autocmd WinEnter,InsertLeave * set cursorline
    autocmd WinLeave,InsertEnter * set nocursorline

    " File Type: {{{3

    " CSS
    autocmd FileType css setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

    " Go
    autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

    " HTML, Haml, htmldjango
    autocmd FileType html,haml,htmldjango setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

    " JavaScript
    autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

    " Python
    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 completeopt-=preview

    " Ruby
    autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

    " Rust
    autocmd FileType rust setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

    " Sass
    autocmd FileType scss setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

    " Scala
    autocmd FileType scala setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

    " Check spelling when git commit message
    autocmd FileType gitcommit setlocal nofoldenable spell

    " }}}

augroup END

" }}}

" ------------------------------------------------------------------------------
" Key Mappings: {{{2

" Disable dangerous keys
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Switch j,k and gj,gk
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

" Swap ; and :
nnoremap ; :
vnoremap ; :
nnoremap q; q:
vnoremap q; q:
nnoremap : ;
vnoremap : ;

" Don't use Ex mode
nnoremap Q gq

" Esc
inoremap jk <Esc>

" Move to beginning and end of line
noremap <Space>h ^
noremap <Space>l $

" Quick save and quit
" save
nnoremap <silent> <Space>w :<C-u>update<CR>
nnoremap <silent> <Space>W :<C-u>update!<CR>
" quit
nnoremap <silent> <Space>q :<C-u>quit<CR>
nnoremap <silent> <Space>Q :<C-u>quit!<CR>

" Auto input }])
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap ' ''<LEFT>
inoremap ` ``<LEFT>
inoremap " ""<LEFT>

" Auto escape '/' and '?'
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" }}}

" }}}

" ------------------------------------------------------------------------------
" Plugins: {{{1

" ------------------------------------------------------------------------------
" Unit: {{{2

" launch with Space + u
nnoremap [unite]  <Nop>
nmap     <Space>u [unite]

nnoremap <silent> [unite]s :<C-u>Unite source<CR>
nnoremap <silent> [unite]S :<C-u>Unite source -vertical<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]o :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]r :<C-u>UniteResume<CR>

" }}}

" ------------------------------------------------------------------------------
" NeoMRU: {{{2

" display limit
let g:unite_source_file_mru_limit = 200
" show date
let g:neomru#time_format = "%m/%d "

" launch with Space + u
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]d :<C-u>Unite directory_mru<CR>

" }}}

" ------------------------------------------------------------------------------
" NERDTree: {{{2

" launch with Space + n
nnoremap <silent> <Space>n :<C-u>NERDTreeToggle<CR>
" display dotfiles
let NERDTreeShowHidden = 1
let NERDTreeIgnore     = ['\.git$', '\.DS_Store$']

" }}}

" ------------------------------------------------------------------------------
" Indent Guides: {{{2

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_exclude_filetypes = ['nerdtree']
let g:indent_guides_auto_colors=0
autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=240
autocmd MyAutoCmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=245

" }}}

" ------------------------------------------------------------------------------
" Airline: {{{2

let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'

" }}}

" ------------------------------------------------------------------------------
" Jedi: {{{2

let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_definitions_command = "<leader>t"

" }}}

" ------------------------------------------------------------------------------
" Rust_Vim: {{{2

let g:rustfmt_autosave = 1
let g:rustfmt_command = "$HOME/.cargo/bin/rustfmt"

"}}}

" ------------------------------------------------------------------------------
" Rust_Racer: {{{2

let g:racer_cmd = "$HOME/.cargo/bin/racer"

"}}}

" ------------------------------------------------------------------------------
" ALE: {{{2

"let g:ale_rust_cargo_use_check = 1
let g:ale_linters = {'rust': ['cargo'], 'python': ['flake8']}
"}}}

" }}}
