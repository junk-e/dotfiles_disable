" Required
filetype plugin indent off
syntax off

" Dein.vim "{{{
"-------------------------------------------------------------------------------

" Set dein paths
let s:config_home = expand('~/.config')
let s:nvimdir = s:config_home . '/nvim'
let s:cache_home = expand('~/.cache')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_github = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = 'Shougo/dein.vim'
let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

" Check dein has been installed or not.
if !isdirectory(s:dein_repo_dir)
    let s:git = system("which git")
    if strlen(s:git) != 0
        echo 'dein is not installed, install now.'
        let s:dein_repo = 'https://github.com' . '/' .  s:dein_repo_name
        echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
        call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
    endif
endif

" Add the dein installation directory into runtimepath
let &runtimepath = &runtimepath . ',' . s:dein_repo_dir

" Begin plugin installation
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
        let s:toml = s:nvimdir . '/dein.toml'
        let s:lazy_toml = s:nvimdir . '/dein_lazy.toml'
        call dein#load_toml(s:toml, {'lazy': 0})
        call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

" Required
filetype plugin indent on
syntax enable

" Installation check
if dein#check_install()
    call dein#install()
endif

"}}}

" System settings "{{{
"-------------------------------------------------------------------------------

" Assign line feed code as unix
set fileformats=unix

" Assign and convert all file encodings to UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Disable backup
set nowritebackup
set nobackup
set backupdir=

" Disable undofile
set noundofile

" Enable swapfile
set swapfile
" swap directory
set directory=~/.cache/nvim/swap

" Use vim backspace
set backspace=2

" Enable clipboard
set clipboard&
set clipboard^=unnamedplus

" auto comment off
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

" Storing cursor position
augroup storing_cursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \     exe "normal! g'\"" |
        \ endif
augroup END

" Storing folds
augroup storing_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END

"}}}

" Search / Replace "{{{
"-------------------------------------------------------------------------------

" Ignore capital & small letter
set ignorecase

" But recognize capital when including capital
set smartcase

" Assign g option by default at replacement
set gdefault

"}}}

" Display settings "{{{
"-------------------------------------------------------------------------------

" Show linenumbers
set number

" Hide cursorline
set nocursorline

" Tab Settings
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" Display invisible characters
set list
set listchars=tab:¦\ ,nbsp:%

" Settings of brackets
set matchpairs& matchpairs+=<:>
set showmatch
set matchtime=1

" Conceal
set conceallevel=2 concealcursor=niv

" Overwriting textwidth (Default:78)
augroup no_wrapping
    autocmd!
    autocmd BufEnter * set textwidth=0
augroup END

" Folding
set foldmethod=marker
set foldlevel=2
set foldcolumn=3

" Delete unnecessary spaces
augroup delete_unnrcessary_space
    autocmd!
    autocmd BufWritePre * call s:remove_unnecessary_space()
augroup END

function! s:remove_unnecessary_space()
    " delete last spaces
    %s/\s\+$//ge

    " delete last blank lines
    while getline('$') == ""
            $delete _
    endwhile
endfunction

"}}}

" Filetype "{{{
"-------------------------------------------------------------------------------

" Fix TeX filetype to tex (Default:plaintex)
augroup tex_fix_filetype
    autocmd!
    autocmd BufEnter *.tex setl filetype=tex
augroup END

" Fix Fish filetype to conf
augroup fish_fix_filetype
    autocmd!
    autocmd BufEnter *.fish setl filetype=conf
augroup END

"}}}

" Others "{{{
"-------------------------------------------------------------------------------

" Enable automatic line breaks and colorcolumn
augroup tex_auto_wrapping
    autocmd!
    autocmd BufEnter *.tex setlocal textwidth=100
    autocmd Filetype tex setlocal colorcolumn=101
    autocmd Filetype tex setlocal formatoptions+=tcmMq
augroup END

" Don't expand tab in snippet files
augroup snip_noexpand
    autocmd!
    autocmd Filetype neosnippet setlocal noexpandtab
augroup END

" Disable TeX conceal
let g:tex_conceal=''

"}}}

" Key mappings "{{{
"-------------------------------------------------------------------------------

" Disable help
nnoremap <F1> <Nop>
inoremap <F1> <Nop>
" Disable macros
nnoremap q <Nop>
" Disable EXmode
nnoremap Q <Nop>
" Disable substitution insert
nnoremap s <Nop>
nnoremap S <Nop>
" Disable screen down moving
nnoremap <C-f> <Nop>

nnoremap ZX :w<CR>
inoremap ZX <ESC>:w<CR>

nnoremap <silent> <ESC><ESC> :nohl<CR>

nnoremap j gj
nnoremap k gk

"}}}
