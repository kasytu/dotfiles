" **************************************                                                                                                                                                                            
" * VARIABLES
" **************************************

set term=screen-256color
set autoindent                  " autoindent on
set noerrorbells                " bye bye bells :)
set visualbell                  " Since intelliJ doesn't understand noerrorbells
                                    "it will understand to switch to visualbells.
set modeline                    " show what I'm doing
set showmode                    " show the mode on the dedicated line (see
set wrap                        " visually wrap long lines to the next line
set ignorecase                  " ignore case when searching
set bs=2                        " Delete of line breaks/automatically-inserted indentation
set fileformats=unix,dos,mac    " open files from mac/dos for line endings; order doesn't matter. builtin pref. for unix endings http://vim.wikia.com/wiki/File_format
set nojoinspaces                " when using join (j), don't add 2 spaces - just one
set ruler                       " display the ruler (bottom right) - line number, column number, virtual column number, relative position (%)
set incsearch                   " incremental searching - search as I type
set nohlsearch                  " disable highlighting
set cursorline                  " highlight current line
set formatoptions+=c            " auto wrap comments using textwidth; insert comment leader automatically. http://vi.stackexchange.com/questions/1983/how-can-i-get-vim-to-stop-putting-comments-in-front-of-new-lines
DoMatchParen                    " highlight matching parenthesis without jumping cursor like showmatch; from pi_paren plugin
set whichwrap +=>,l
set whichwrap +=<,h             "let l and h wrap around individual lines

""" Numbering """
autocmd InsertEnter * :set number         " use regular numbers on insert mode
autocmd InsertLeave * :set relativenumber " use relative numbering in normal mode
" set background color for line numbers to be white
highlight LineNr ctermfg=white

" Smart indent
set cindent                     " use c indentation style for C and C++ file types
set tabstop=2                   " specify number of spaces for tab
set shiftwidth=2                " number of spaces for autoindent
set expandtab                   " insert spaces for tab
set softtabstop=2 expandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab " use 4 for python

" set clipboard^=unnamed
set clipboard=unnamedplus       " alias unnamed register to + register, which is the X window clipboard
    
set splitright                  " have new :vsplit open on the right

syntax on                       " show syntax coloring                         

imap jk <Esc>                   " enable jk becomes escape for leaving insert mode
noremap l; :wq<CR>              " Use l; to save and quit
noremap ns :wq<CR>              " same as above for Dvorak

imap <C-w> <C-o><C-w>           " allow window commands in insert mode without accidentally deleting

" Easier split navigations - remap left and right, up and down
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" split navigations in insert mode
inoremap <C-J> <Esc><C-W><C-J>i
inoremap <C-K> <Esc><C-W><C-K>i
inoremap <C-L> <Esc><C-W><C-L>i
inoremap <C-H> <Esc><C-W><C-H>i

"Themes
colorscheme zellner  

" Line number highlight
highlight LineNr  ctermbg=black

" Highlight color of VISUAL mode
highlight Visual  ctermbg=darkblue
highlight Visual  ctermfg=white
  
" Highlight color of Matching paranthesis 
highlight MatchParen cterm=underline ctermbg=none ctermfg=white

set wildchar=<tab> wildmenu wildmode=full   " wildmenu and wildmode for command line completion

" Prompt if unsaved changes in buffer
set confirm

" Format statusline
" %t is tail of filename
" [%{strlen(&fenc)?&fenc:'none'} file encoding
" %{&ff} file format
" %h help file flag
" %m modified flag
" %r read only flag
" %y filetype
" %= left/right separator
" %c cursor column
" %l/%L cursor line/total lines
" %P percent through file
" source: http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
 set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

set laststatus=2          " always show statusline

" Change statusline based on which window you're in
if version >= 700
  highlight statusline cterm=bold ctermfg=black ctermbg=red
  au InsertLeave * highlight Statusline cterm=bold ctermfg=black ctermbg=red
  au InsertEnter * highlight Statusline cterm=bold ctermfg=black ctermbg=green
endif

" Remove background/foreground flipping by italic style
highlight htmlItalic term=NONE cterm=NONE gui=NONE

"set shortcut delay time
set timeout timeoutlen=250 ttimeoutlen=100

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" switch tabs on for makefiles (won't work with spaces):
au BufRead,BufNewfile Makefile set ts=4 sw=4 noexpandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""" BEGIN PLUGINS """"""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vundle plugin package manager
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"The following are examples of different formats supported.
" Keep Plugin commands between bundle#begin/end.
" Plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
"Plugin 'Valloric/YouCompleteMe'

"Plugin 'scrooloose/syntastic'
" let g:syntastic_cpp_check_header = 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
highlight SyntasticErrorLine guibg=#2f0000
"hi SpellBad ctermfg=255 ctermbg=160 guifg=#yyyyyy guibg=#zzzzzz
"hi SpellCap ctermfg=255 ctermbg=016 guifg=#yyyyyy guibg=#zzzzzz

Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'

" let g:ycm_global_ycm_extra_conf = 'path to .ycm_extra_conf.py'
let g:ycm_register_as_syntastic_checker = 0
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" call vundle#rc()
" more bundles here
call vundle#end()
filetype plugin indent on
filetype on

" End Vundle setup

" Mapleader
let mapleader = ','


" Use visual mode to indent/unindent:
vmap <TAB> >gv
vmap <S-TAB> <gv

function! Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
    return "\<C-X>\<C-O>"                         " plugin matching
  endif
endfunction

nnoremap <S-TAB> <<
inoremap <S-TAB> <C-d>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""" END PLUGINS """""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
