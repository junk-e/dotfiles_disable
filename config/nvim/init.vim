" Required
filetype plugin indent off
syntax off

" Required
filetype plugin indent on
syntax enable

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
