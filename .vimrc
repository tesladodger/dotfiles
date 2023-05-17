" ~/.vimrc

" -------- "
" Settings "
" -------- "
if &compatible
    set nocompatible
endif
silent! while 0
    set nocompatible
silent! endwhile

set history=50
set ruler

set ttimeout        " timeout for key codes
set ttimeoutlen=100 " wait up to len after Esc for special key

set mouse=a

filetype plugin indent on
set autoindent
" set smartindent    " these should not be set when filetype
" set cindent        " ident is on

set t_Co=256
syntax on

set autoread
set shiftwidth=4
set tabstop=4

set background=dark
set backspace=indent,eol,start
set cursorline
set encoding=utf-8
set expandtab       " replace tabs with spaces
set hlsearch
set incsearch       " show search matches while typing
set lazyredraw      " don't redraw while running macros, registers, or any non-typed commands
" set list            " show tabs
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵
set noerrorbells
set nomodeline
set noshowmode
set number
set relativenumber  " relative line numbers
set scrolloff=5
set shortmess=atI
set splitbelow      " split below instead of over
set splitright      " vsplit right instead of left
set visualbell
set wrapscan
set hidden          " don't force saving when changing buffer

" access command line wildmenu with Tab
set wildchar=<Tab> wildmenu wildmode=full

" Absolute number on command mode, back to relative on exit
au CmdLineEnter * set norelativenumber | redraw
au CmdLineLeave * set relativenumber   | set number

" -------------- "
" File templates "
" -------------- "
augroup templates
    au!
    autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END

" -------- "
" Mappings "
" -------- "
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Switch windows with Control+[movement key]
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Close current window with Control+q
noremap <C-Q> <C-W><C-Q>
" Close all other windows with Control+o
noremap <C-O> <C-W><C-O>

nnoremap tt :ter<CR>

imap jh <Backspace>
imap jj <Esc>o
imap jk <Esc>O
imap jl <Esc>

" full substitution of visual selection
xnoremap gs y:%s/<C-r>"//g<Left><Left>

" change content inside parentheses or brackets with dp, db, cp, cb, etc
onoremap b i[|
onoremap p i(|

" bring search results to midscreen
nnoremap n nzz
nnoremap N Nzz

" automatic brackets
inoremap {<CR> {<CR>}<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'<Left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"<Left>"

function! GetPreCursorChar()
    if col('.') <= 1
        return ''
    endif
    let before_cursor = getline('.')[:col('.')-2]
    return strcharpart(before_cursor, strchars(before_cursor)-1)
endfunction

" ---------------------- "
" Automatic closing tags "
" ---------------------- "
" only enable auto tags for certain regions in a filetype
function! AssertRegion()
    if (&filetype == 'typescriptreact')
        let l:regionStack = synstack(line('.'), col('.'))
        for id in l:regionStack
            let l:regionName = synIDattr(id, "name")
            if regionName == "tsxRegion"
                return 1
            endif
        endfor
        return 0
    endif
    return 1
endfunction
function s:CompleteTags()
    inoremap <buffer> <expr> > AssertRegion()
                \   ? "></\<C-x>\<C-o>\<Esc>:startinsert!\<CR>\<C-O>?</\<CR>"
                \   : ">"
    inoremap <buffer> ><Leader> >
    inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction
autocmd BufRead,BufNewFile *.html,*.xml call s:CompleteTags()

" --------------------------------------- "
" Filetype specific settings and mappings "
" --------------------------------------- "
" Tex setup
function! Tex_setup()
    " automatic newline at 90 chars
    setlocal textwidth=90
    " compile with F4 in a split terminal
    nnoremap <F4> :w<bar>term ++shell pdflatex %:p<CR>
    " set spell checking
    setlocal spell
endfunction
autocmd Filetype tex call Tex_setup()

" vim - disable automatic closing '"'
autocmd Filetype vim iunmap "
" c - compile and run (F4) in a split terminal
autocmd Filetype c nnoremap <F4> :w<bar>term ++shell gcc %:p -o %:p:r.out && %:p:r.out<CR>
" typescriptreact - indentation
autocmd Filetype typescriptreact setlocal shiftwidth=2 tabstop=2
" typescript - indentation
autocmd Filetype typescript setlocal shiftwidth=2 tabstop=2
" gitcommit - spell checking
autocmd Filetype gitcommit setlocal spell spelllang=en
" go - use tabs instead of spaces
autocmd Filetype go setlocal noexpandtab
" go - line width marker
autocmd Filetype go setlocal colorcolumn=90

" -------- "
" Pluggins "
" -------- "
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" commands:
"   PlugInstall [name ...] [#threads]
"   PlugUpdate [name ...] [#threads]z
"   PlugUpgrade
"   PlugStatus
call plug#begin('~/.vim/plugged')

Plug 'ycm-core/YouCompleteMe'
Plug 'dense-analysis/ale'
Plug 'tesladodger/minimalist'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()

" ---------------- "
" Pluggin Settings "
" ---------------- "
" Ale
" ---
let g:syntastic_tex_checkers = ['lacheck']
let g:ale_fixers = {
            \ 'json': ['prettier'],
            \ 'javascript': ['eslint', 'prettier'],
            \ 'typescript': ['eslint', 'prettier'],
            \ 'typescriptreact': ['eslint', 'prettier'],
            \ 'css': ['prettier'],
            \ 'go': ['gofmt', 'remove_trailing_lines', 'trim_whitespace']
            \}
let g:ale_fix_on_save = 1

" Airline
" -------
let g:airline_theme='deus'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" YouCompleteMe
" -------------
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" NerdTree
" --------
let g:NERDTreeShowHidden = 1
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" Close vim when NERDTree is the only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" highlight script in ~/.vim/after/syntax/nerdtree.vim
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeGitStatusConcealBrackets = 1
let g:NERDTreeShowLineNumbers = 1

" Minimalist
" ----------
colorscheme minimalist
