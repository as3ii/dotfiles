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

set spelllang+=it
set spell

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

" enable 24bit color in TUI
set termguicolors
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

" format json file
command FormatJSON execute "%!python -m json.tool"

" wrap lines at 90 chars
set textwidth=91

" set colorcolumn color
highlight ColorColumn ctermbg=1
" set column of colorcolumn
set colorcolumn=81
" if markdown file: disable colorcolumn
autocmd FileType markdown highlight ColorColumn ctermbg=0

" enable persistent undo
if has("persistent_undo")
    set undodir=$XDG_DATA_HOME/vim/undodir
    set undofile
endif

" set red background when there are more then 120 char in a line
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

augroup markdownbindings
    autocmd! markdownbindings
    " compile with pandoc and open zathura
    autocmd FileType markdown nnoremap <buffer> <silent> <F4> :w<CR>:!~/.script/pandoc-pdf.sh "%:p"<CR><CR>
    autocmd FileType markdown inoremap <buffer> <silent> <F4> <ESC>:w<CR>:!~/.script/pandoc-pdf.sh "%:p"<CR><CR>i
augroup end

augroup rustbindings
    autocmd! rustbindings
    " cargo run
    autocmd FileType rust nnoremap <buffer> <silent> <F4> :RustRun<CR>
    " cargo run --release
    autocmd FileType rust nnoremap <buffer> <silent> <S-F4> :RustRun --release<CR>
    " cargo build
    autocmd FileType rust nnoremap <buffer> <silent> <F6> :! cargo build<CR>
    " cargo build --release
    autocmd FileType rust nnoremap <buffer> <silent> <S-F6> :! cargo build --relese<CR>
augroup end

augroup cppbindings
    autocmd! cppbindings
    " switch between header/source with <F4>
    autocmd FileType cpp nnoremap <buffer> <silent> <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
    " build using makeprg with <F6>
    autocmd FileType cpp nnoremap <buffer> <silent> <F6> :make<CR>
    " build using makeprg with <S-F6>
    autocmd FileType cpp nnoremap <buffer> <silent> <S-F6> :make clean all<CR>
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
Plug 'yuqio/vim-darkspace'              " theme
Plug 'junegunn/vim-plug'                " plugin manager
Plug 'tpope/vim-commentary'             " gc + movement to comment
Plug 'bronson/vim-trailing-whitespace'  " fix whitespace error with :FixWhitespace
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'unblevable/quick-scope'           " highlight character reachable with f, F, t or T
Plug 'mbbill/undotree'
" language server
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'mattn/vim-lsp-settings'
" auto completions
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" snippet
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()


" theme
colorscheme darkspace
let g:darkspace_italics=1
set background=light


" quick-scope settings
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline


" vim-lsp
let g:lsp_signs_enabled = 1	" enable signs
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text': '?'}
let g:lsp_settings_filetype_rust = 'rust-analyzer'	" change rust language server


" asyncomplete config
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"
imap <c-space> <Plug>(asyncomplete_force_refresh)


" vsnip config
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
let g:vsnip_snippet_dir = expand('~/.config/nvim/snippet')


" fix alacritty mouse issue
if !has('nvim')
    set ttymouse=sgr
endif

