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
set smarttab
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
set mouse=nvcr

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

" wrap lines at 140 chars
set textwidth=120

" set colorcolumn color
highlight ColorColumn ctermbg=1
" set column of colorcolumn
set colorcolumn=+1
" if markdown file: disable colorcolumn
autocmd FileType markdown highlight ColorColumn ctermbg=0

" set reb background when there are more then 120 char in a line
"autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)

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
nmap <F9> :TagbarToggle<CR>

augroup markdownbindings
    autocmd! markdownbindings
    " compile with pandoc and open zathura
    autocmd FileType markdown nnoremap <buffer> <silent> <F4> :w<CR>:!~/.script/pandoc-pdf.sh %<CR><CR>
    autocmd FileType markdown inoremap <buffer> <silent> <F4> <ESC>:w<CR>:!~/.script/pandoc-pdf.sh %<CR><CR>i
augroup end

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


" autoinstall vim-plug
if !has('nvim')
	let plug_dir = '~/.vim/plugged'
    if empty(glob('~/.vim/autoload/plug.vim'))
  		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    let plug_dir = '~/.local/share/nvim/plugged'
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif


" vim-plug plugin manager
call plug#begin(plug_dir)
Plug 'junegunn/vim-plug'
Plug 'tpope/vim-commentary' " gc + movement to comment
" Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'tpope/vim-surround' " s + movement + char  to surround with char
Plug 'amperser/proselint'
Plug 'vim-syntastic/syntastic'
Plug 'bronson/vim-trailing-whitespace' " fix whitespace error with :FixWhitespace
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'unblevable/quick-scope'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

" quick-scope settings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" LanguageClient config
let g:LanguageClient_serverCommands = {'rust': ['rust-analyzer'],}
nnoremap <F8> :call LanguageClient_contextMenu()<CR>

" fix alacritty mouse issue
if !has('nvim')
    set ttymouse=sgr
endif

