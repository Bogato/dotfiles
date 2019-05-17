set nocompatible "be iMproved
filetype off

" ---------------------------------------------------------------------------
" Plugin manager
" ---------------------------------------------------------------------------
" [vim-plug] [init] A minimalist Vim plugin manager.
" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" [vim-plug] [plugins]
" * API *
" * Utilities *
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'bling/vim-bufferline'
" Git
Plug 'tpope/vim-fugitive'
" Org-like
Plug 'tpope/vim-speeddating'
Plug 'jceb/vim-orgmode'
" Json
Plug 'mogelbrod/vim-jsonpath'
" Misc
Plug 'let-def/vimbufsync'

" * Languages *
" OCamL
Plug 'let-def/ocp-indent-vim'
Plug 'ELLIOTTCABLE/vim-menhir'
" SMT-LIB2
Plug 'bohlender/vim-smt2'
" Coq
Plug 'the-lambda-church/coquille'
" Python
Plug 'davidhalter/jedi-vim'
"Plug 'klen/python-mode'
" Scala
" Plug 'derekwyatt/vim-scala'
" LLVM
Plug 'rhysd/vim-llvm'
" Rust
Plug 'rust-lang/rust.vim',
" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'mzlogin/vim-markdown-toc'
" Latex
Plug 'lervag/vimtex'
" Syntastic, the syntax checker
Plug 'scrooloose/syntastic'
" And finally... YCM
if v:version > 702
  Plug 'Valloric/YouCompleteMe'
endif

" * Cosmetic *
" Colorscheme
"Plug 'reedes/vim-colors-pencil'
Plug 'itchyny/landscape.vim'
Plug 'altercation/vim-colors-solarized'
"Plug 'tomasr/molokai'

" [vim-plug] [end] plugins available after.
call plug#end()
filetype plugin indent on


" ---------------------------------------------------------------------------
" Vim options
" ---------------------------------------------------------------------------
set ai "auto indent
set ar "auto read (when file has changed outside of Vim)
set bg=dark "background
set bo=all "No bell at all
set bs=eol,start,indent "backspacing
"set cindent "automatic C program identing
set cc=81 "color column
set ch=1 "command-line height
set cul "highlight the cursor line
set enc=utf-8 "character encoding
set expandtab "insert mode: use appropriate number of spaces to insert a <Tab>
set ffs=unix,dos,mac "standard file formats
"set gui* TODO
set hid "a buffer becomes hidden when it is abandoned
set hls "highligth all search matches
set hi=100 "history of : commands
set ic "ignore case on search patterns
set is "incremental search
set laststatus=2 "always show status line
set lazyredraw "No redrawing while executing macros, registers or commands
set lbr "line breaking
set list listchars=tab:›─,trail:─,nbsp:␣
if has("mouse")
    set mouse=n "mouse enabled for normal mode
endif
set nobackup
set noswapfile
set ruler "show line and column number of cursor
set sw=4 "Number of spaces to use for each step of (auto)indent.
set sts=4 "Number of spaces that a <Tab> counts while editing.
set tm=3000 "timeoutlen (TODO): See below. See if delay occurs.
set ttm=250 "ttimeoutlen (TODO): Seems to be a special case for key codes
set wildmenu "cmd autocompletion menu
set wildmode=list:longest,full "cmd autocompletion longest match then one-line

syn on se title


" ---------------------------------------------------------------------------
" Global plugins
" ---------------------------------------------------------------------------
" [NERDTree] [options] A tree explorer plugin for vim.
" https://github.com/scrooloose/nerdtree
" Open NERDTree at startup if no file are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim when NERDTree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
    \ && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeRespectWildIgnore=1

" [Syntastic] [options] Syntax checking hacks for vim
" https://github.com/scrooloose/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" TODO: More
let g:syntastic_ignore_files = ['\m\c\.ml[ly]$']


" [ctrlp.vim] [options]  Fuzzy file, buffer, mru, tag, etc finder.
" http://kien.github.com/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'

set wildignore+=*.cm* "Ocaml

" [vim-airline] [options] Lean & mean status/tabline for vim that's light as
" air.
" https://github.com/vim-airline/vim-airline
" *airline-customization*
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
let g:airline_left_sep = "\u2599"
let g:airline_right_sep = "\u259F"

" *airline-extensions*
" Smarter tab line
" Automatically displays all buffers when there is only one tab open
let g:airline#extensions#tabline#enabled = 1 "Smarter tab line

set laststatus=2 "override default no status line if no split


" [YouCompleteMe] [options] A code-completion engine for Vim
" http://valloric.github.io/YouCompleteMe/
let g:ycm_autoclose_preview_window_after_insertion = 1


" [colors] [options]
"colorscheme landscape
if has("gui_running")
    set background="dark"
    silent! colorscheme solarized
    let g:airline_theme='solarized'
    set guioptions-=T
else
    set background="dark"
    silent! colorscheme landscape
endif

" ---------------------------------------------------------------------------
" Python
" ---------------------------------------------------------------------------
if exists('py2') && has('python')
    " TODO
elseif has('python3')
    " TODO
endif

" ---------------------------------------------------------------------------
" OCaml
" ---------------------------------------------------------------------------
let g:opamshare = substitute(system('opam config var share'),'\n$','',"")

" [ocp-indent] is a customizable tool to indent OCaml code.
" We don't use the default plugin provided by [ocp-indent] since it doesn't
" provide interactive indentation as you type.
"execute "set rtp^=" . g:opamshare . "/ocp-indent/vim"

" [Merlin] Context sensitive completion for OCaml in 'Vim' and 'M-x emacs'
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" [coquille] Interactive theorem proving with Coq in vim.
" Maps Coquille commands to <F2> (Undo), <F3> (Next), <F4> (ToCursor)
au FileType coq call coquille#FNMapping()

" [vim-smt2] A VIM plugin that adds support for the SMT-LIB2 format (including
" Z3's extensions)
let g:smt2_solver_command="z3 -smt2 -T:2"

" [Why] Why3 environment for deductive program verification.
let s:why3_datadir = substitute(system('why3 --print-datadir'),'\n$','',"")
if isdirectory(s:why3_datadir)
    execute "set rtp+=" . s:why3_datadir . "/vim"
endif

" [Syntastic] Let's add 'A Kind Of Magic'
let g:syntastic_ocaml_checkers = ['merlin']


" ---------------------------------------------------------------------------
" Rust
" ---------------------------------------------------------------------------
" rustlib source location (for autocomplet and stuff)
let g:rustsysroot = substitute(system('rustc --print sysroot'),'\n$','',"")
let g:ycm_rust_src_path = g:rustsysroot . "/lib/rustlib/src/rust/src"

" ---------------------------------------------------------------------------
" Latex
" ---------------------------------------------------------------------------
autocmd Filetype tex setlocal et ts=2 sw=2
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf, aux'


" ---------------------------------------------------------------------------
" General options
" ---------------------------------------------------------------------------
