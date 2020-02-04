" VIM Configuration File

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable vi compatibility
set nocompatible

" search down into subfolder \ provides tab-completion for all file-related task
set path+=**
" display all matching files when we tab complete
set wildmenu
" hit tab to :find by partial match \ :b lets you to autocomplete any open buffer

" file browsing tweaks
let g:netrw_banner=0    " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1      " open splits to the right
let g:netrw_liststyle=3 " tree view
let g:netrw_lists_hide=netrw_gitignore#Hide()
let g:netrw_lists_hide.=',\(^\|\s\s\)\zs\.\S\+'
" :edit a folder to open a file browser

" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
set showtabline=2    " show tab line

" show keystroke currently entering
set showcmd

set hlsearch         " enable highlight when searching
nnoremap <silent> <F3> :noh<CR>  " press F3 to disable last search highlight

" colorscheme wombat256
set t_Co=256
" turn syntax highlighting on
syntax on
" turn line numbers on
set number
" turn relative numbers on
set relativenumber
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" enable mouse navigation
set mouse=a

" automatic running of :RustFmt when you save a buffer
let g:rustfmt_autosave = 1

" new tab will appear on the right or below
set splitbelow
set splitright

" show status line
set laststatus=2

" show filename
set statusline+=%1*
set statusline+=\ [%n]
set statusline+=\ %m\ %<%F\%r
set statusline+=\ %=
" set statusline+=%#LineNr# %#GLname#
set statusline+=\ [%M%R%H%W%Y]
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}\]
set statusline+=\ \ \ \|\ \ col:%3c\ \ line:%3l/%L\ -\ %3p%%\ 
set statusline+=%0*
hi User1 ctermfg=black ctermbg=grey

" syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']

" format json file
command FormatJSON execute "%!python -m json.tool"

" toggle autocompiler
noremap <A-c> :!setsid autocompiler.sh % &<CR>

" wrap lines at 140 chars
set textwidth=140

" " set colorcolumn color
" highlight ColorColumn ctermbg=7
" " set column of colorcolumn
" set colorcolumn=+1

" set reb background when there are more then 120 char in a line
autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Enhanced keyboard mappings
"
" navigate split screen
nnoremap <silent> <A-up> :wincmd k<CR>
nnoremap <silent> <A-down> :wincmd j<CR>
nnoremap <silent> <A-S-h> :wincmd h<CR>
nnoremap <silent> <A-S-l> :wincmd l<CR>
nnoremap <silent> <A-S-up> <C-w>K
nnoremap <silent> <A-S-down> <C-w>J
nnoremap <silent> <A-S-left> <C-w>H
nnoremap <silent> <A-S-right> <C-w>L
" in normal mode F2 will save the file
nnoremap <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
inoremap <F2> <ESC>:w<CR>i

" toggle paste mode
set pastetoggle=<ins>

" toggle tagbar
nmap <F8> :TagbarToggle<CR>

augroup rustbindings
    autocmd! rustbindings
    " cargo check
    autocmd FileType rust nnoremap <buffer> <silent> <F4> :Cargo check
    " cargo run
    autocmd FileType rust nnoremap <buffer> <silent> <F5> :Crun
    " cargo run --release
    autocmd FileType rust nnoremap <buffer> <silent> <S-F5> :Crun --release
    " cargo build
    autocmd FileType rust nnoremap <buffer> <silent> <F6> :Cbuild
    " cargo build --release
    autocmd FileType rust nnoremap <buffer> <silent> <S-F6> :Cbuild --relese
augroup end

augroup cppbindings
    autocmd! cppbindings
    " switch between header/source with F4
    autocmd FileType cpp nnoremap <buffer> <silent> <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
    " recreate tags file with F5
    autocmd FileType cpp nnoremap <buffer> <silent> <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
    " build using makeprg with <F7>
    autocmd FileType cpp nnoremap <buffer> <silent> <F7> :make<CR>
    " build using makeprg with <S-F7>
    autocmd FileType cpp nnoremap <buffer> <silent> <S-F7> :make clean all<CR>
augroup end

"vundle plugin manager
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-commentary' " gc + movement to comment
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-surround' " s + movement +char  to surround with char
Plugin 'amperser/proselint'
Plugin 'vim-syntastic/syntastic'
Plugin 'bronson/vim-trailing-whitespace' " fix whitespace error with :FixWhitespace
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

":h vunndle -> help
