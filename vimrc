" vimrc
set nocompatible
filetype off

" Vundle
""""""""
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'
Plugin 'altercation/vim-colors-solarized'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'fatih/vim-go'
Plugin 'honza/vim-snippets'
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'

call vundle#end()

" Preamble
""""""""""
filetype plugin on
filetype indent on
syntax enable
colorscheme solarized

let mapleader=","

" General
"""""""""
set autoread
set background=dark
set cursorline
set diffopt=filler,vertical
set encoding=utf-8
set gdefault
set grepprg=ack
set hidden
set history=1000
set lazyredraw
set mouse=a
set nobackup
set noswapfile
set number
set pastetoggle=<F12>
set scrolljump=5
set scrolloff=3
set shell=zsh
set shortmess+=aoOtT
set showbreak=↪
set showcmd
set noshowmode
set splitright
set t_Co=256
set tags=./tags;
set timeoutlen=500
set ttyfast

" Search/Complete
"""""""""""""""""
set completeopt=menu,menuone,longest
set hlsearch
set ignorecase
set incsearch
set magic
set smartcase

" Wildmenu
""""""""""
set wildmenu
set wildmode=list:longest

set wildignore+=*hg,*.git,*.svn                 " Version control
set wildignore+=*aux,*.out,*.toc,*.log          " LaTeX intermediate files
set wildignore+=*jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*o,*.obj,*.exe,*.hi             " compiled object files
set wildignore+=*spl                            " compiled spelling word lists
set wildignore+=*sw?                            " Vim swap files
set wildignore+=*DS_Store                       " OSX bullshit
set wildignore+=*luac                           " Lua byte code
set wildignore+=mgrations                       " Django migrations
set wildignore+=*pyc                            " Python byte code
set wildignore+=target                          " SBT target directories
set wildignorecase

" Folding
"""""""""
set foldmethod=manual
set foldnestmax=3
set nofoldenable

" Formatting & Whitespace
"""""""""""""""""""""""""
set autoindent
set smartindent
set backspace=eol,indent,start
set expandtab
set formatoptions=crq
set linebreak
set list
set listchars=tab:▷•,trail:•,nbsp:⋅
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4
set textwidth=80
set nowrap

" Plugins
"""""""""

" ctrlp
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = "~/.cache/ctrlp"
let g:ctrlp_custom_ignore = { "dir": "dist" }

" easy-align
vnoremap <Enter> <Plug>(EasyAlign)

" lightline
set laststatus=2
let g:lightline = { 'colorscheme': 'solarized' }

" supertab
let g:SuperTabDefaultCompletionType='<C-n>'

" tagbar
noremap <silent> <leader>t :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_compact=1
let g:tagbar_foldlevel=0

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" YouCompleteMe
let g:ycm_global_ycm_extra_conf='~/.ycm_global_conf.py'
let g:ycm_key_list_select_completion=['<C-n>']
let g:ycm_key_list_previous_completion=['<C-p>']

" Command mode
""""""""""""""
cnoremap ww w !sudo tee % >/dev/null
cnoremap qq qa!
cnoremap cwd lcd %:p:h

" Visual mode
"""""""""""""
vnoremap <leader>s :w !curl -sF 'sprunge=<-' http://sprunge.us<CR>

" Normal mode
"""""""""""""
" jump between parentheses with <tab>
nnoremap <tab> %

" save 1,000,000 keystrokes
nnoremap ; :
" preserve ; functionality
nnoremap ;; ;

" prefer to jump to exact column/row
nnoremap ' `
nnoremap ` '

" autoindent entire file
nnoremap <leader>= :call Preserve("normal gg=G")<CR>
" autoformat entire file
nnoremap <leader>q :call Preserve("normal gggqG")<CR>
" remove multiple lines of whitespace
nnoremap <leader>l :call Preserve(":v/./,/./-j")<CR>
" remove trailing whitespace
nnoremap <leader>w :call Preserve("%s/\\s\\+$//e")<CR>

" go to older change
nnoremap g; g;zz
" go to newer change
nnoremap g, g,zz
" go to last position
nnoremap '' ''zz

nnoremap j gj
nnoremap k gk

" center search results
nnoremap n nzzzv
nnoremap N Nzzzv

" make Y behave like C and D
nnoremap Y y$

" execute 'q' macro instead of the annoying Ex mode
nnoremap Q @q

nnoremap <silent> <space> :nohlsearch<CR>

if &diff
    " last/next diff
    nnoremap <leader>p [czz
    nnoremap <leader>n ]czz

    nnoremap <leader>g :diffget<CR>
    nnoremap <leader>o :diffoff!<CR>
    nnoremap <leader>p :diffput<CR>
    nnoremap <leader>u :diffupdate<CR>
endif

" show last search results in quickfix window
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen 6<CR>

" syntax highlighting information
noremap <leader>si :call <SID>SynStack()<CR>

" sane window movement
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l

" Autocommands
""""""""""""""
autocmd InsertLeave * set nopaste

augroup ft_glsl
    autocmd!
    autocmd BufNewFile,BufRead *.glsl set filetype=glsl
augroup END

augroup ft_haskell
    autocmd!
    autocmd BufRead *.dump-simpl set filetype=haskell
    autocmd BufRead *.lhs set filetype=lhaskell
    autocmd BufRead *.hsc set filetype=lhaskell
    autocmd FileType haskell,lhaskell nnoremap <F4> :!ghci %<CR>
    autocmd FileType haskell setlocal makeprg=cabal\ repl
augroup END

augroup ft_html
    autocmd!
    autocmd FileType html,xml setlocal shiftwidth=4 tabstop=4
augroup END

augroup ft_python
    autocmd!
    autocmd FileType python nnoremap <F4> :!./%<CR>
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
augroup END

augroup ft_markdown
    autocmd!
    autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END

augroup ft_tex
    autocmd!
    autocmd BufNewFile,BufRead *.tex set filetype=tex
    autocmd FileType tex nnoremap <F4> :!pdflatex %<CR>
    autocmd FileType tex setlocal commentstring=%\ %s
    autocmd FileType tex setlocal formatoptions+=t
    autocmd BufWrite tex :!pdflatex %<CR>
augroup END

" Custom Functions
""""""""""""""""""
function! Preserve(command)
    " Preparation: save last search, and cursor position
    let s = @
    let l = line(".")
    let c = col(".")
    " Do the deed:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/ = s
    call cursor(l, c)
endfunction

function! <SID>SynStack()
    if exists("*synstack")
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endif
endfunction

" GViM settings
"""""""""""""""
if has('gui_running')
    set guioptions=
    set guiheadroom=0

    autocmd FocusLost * silent! wa
endif
