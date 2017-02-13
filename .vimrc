" **************************************                                                                                                                                                                            
" * VARIABLES
" **************************************

" map xdate to fill in date
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


" **************************************
" * ESSENTIAL REMAPS 
" **************************************
" Enable jk becomes es
imap jk <Esc>
" Use l; to save and quit
noremap l; :wq<CR>
" set shortcut delay time - first is mapping delay, second is key code delay
set timeout timeoutlen=250 ttimeoutlen=100
" Mapleader
" make space do nothing
" make space the leader
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"
" **************************************


" **************************************
" * Leader shortcuts
" **************************************
" Fast saving
noremap <leader>w :w!<cr>

" Let '<leader>b' toggle between this and the last accessed buffer
noremap <leader>l :b#<cr>

" Let '<leader>q' quit all
noremap <leader>q :qa<cr>

" Toggle paste mode on and off
noremap <leader>p :setlocal paste!<cr>

" Turn off highlighting until next search
noremap <leader>/ :noh<cr>

" Vertical and horizontal splitting
noremap <leader>v :vs<cr>
noremap <leader>h :sp<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" **************************************

" **************************************
" * Nice General Settings
" **************************************
set term=screen-256color
set nocompatible                " get rid of strict vi compatibility!
set nu                          " line numbering on
set autoindent                  " autoindent on
set noerrorbells                " bye bye bells :)
set visualbell                  " Since IntelliJ doesn't understand noerrorbells it will understand to switch to visualbells.
set modeline                    " show what I'm doing
set showmode                    " show the mode on the dedicated line 
set nowrap                      " no text wrapping
set ignorecase                  " search without regards to case
set backspace=indent,eol,start  " backspace over everything
set fileformats=unix,dos,mac    " open files from mac/dos
set exrc                        " open local config files
set nojoinspaces                " don't add white space when I don't tell 
set ruler                       " which line am I on?

set showmatch                   " ensure Dyck language; show matching {()} or as typed.

set incsearch                   " incremental searching
set hlsearch                    " highlight searches (can be turned off with <leader>/)
set bs=2                        " fix backspacing in insert mode
set cursorline                  " highlights current line
set formatoptions+=r            " auto add askerus for comments
set whichwrap +=>,l
set whichwrap +=<,h             " let l and h wrap around.
set rnu                         " Set relative numbers
set clipboard^=unnamed          " Use system copy/paste keyboard for yank and delete
set colorcolumn=120             " Mark the 120th column
set confirm                     " Prompt if unsaved changes in buffer
set splitbelow                  " More natural file splitting
set splitright

" vertical/horizontal scroll settings
set scrolloff=3                 " keep this many lines between cursor and top/bottom when scrolling
set sidescrolloff=7             " if <7 columns from end or beginning, scroll
set sidescroll=1                " scroll by 1 char at a time (0 for half a string)
 
" sets tab to fill wildchars for buffers
set wildchar=<tab> wildmenu wildmode=full

" Easier split navigations - remap left and right, up and down
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" **************************************

" Show syntax colors
syntax on                          

" **************************************
" * Intelligent Indenting
" **************************************
set tabstop=4                   " Smart indenting
set shiftwidth=4                " 1 tab == 4 spaces
set expandtab                   " Use spaces instead of tabs
set nosmartindent

" switch tabs on for makefiles (they won't work with spaces):
au BufRead,BufNewfile Makefile set ts=4 sw=4 noexpandtab
" **************************************



" **************************************
" * COLOR HIGHLIGHTING 
" **************************************
"Themes
colorscheme zellner  

" Highlight color of Matching parentheses 
highlight MatchParen cterm=underline ctermbg=none ctermfg=white

" Line number highlight
"highlight LineNr ctermfg=white
highlight CursorLineNr ctermfg=white

" Highlight color of VISUAL mode
highlight Visual  ctermbg=darkblue
highlight Visual  ctermfg=white

" DiffAdd - line was added
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" DiffDelete - line was removed
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" DiffChange - part of line was changed (highlights whole line)
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
" DiffText - exact part of the line that changed
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" **************************************
" * Format statusline
" **************************************
" Format statusline coloring to change on insert/normal
if version >= 700
  highlight statusline cterm=bold ctermfg=black ctermbg=red
  au InsertLeave * highlight Statusline cterm=bold ctermfg=black ctermbg=red
  au InsertEnter * highlight Statusline cterm=bold ctermfg=black ctermbg=white
endif
function! HighlightSearch()
  if &hls
    return '_H'
  else
    return ''
  endif
endfunction
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
highlight StatusLineNC ctermbg=0 cterm=none gui=none
highlight Search ctermbg=27
set laststatus=2      " always show statusline
" **************************************

" Remove background/foreground flipping by italic style
highlight htmlItalic term=NONE cterm=NONE gui=NONE
" **************************************

" **************************************
" * => Turn persistent undo on 
" *   means that you can undo even when you close a buffer/VIM
" **************************************
try
    set undodir=~/.vim/undodir
    set undofile
catch
endtry
" **************************************

" **************************************                                                                                                                                                                            
" * Uncomment the following to have Vim jump to the last position when reopening a file
" **************************************                                                                                                                                                                            
if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" **************************************                                                                                                                                                                            


" **************************************                                                                                                                                                                            
" * Vundle plugin package manager 
" **************************************                                                                                                                                                                            

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/.vim/bundle')

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
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"highlight SyntasticErrorLine guibg=#2f0000
"hi SpellBad ctermfg=255 ctermbg=160 guifg=#yyyyyy guibg=#zzzzzz
"hi SpellCap ctermfg=255 ctermbg=016 guifg=#yyyyyy guibg=#zzzzzz

Plugin 'jiangmiao/auto-pairs'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'scroloose/nerdtree'

" let g:ycm_global_ycm_extra_conf = 'path to .ycm_extra_conf.py'
"let g:ycm_register_as_syntastic_checker = 0
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Plugin indentLine - show matching indents
Plugin 'Yggdroot/indentLine'
"let g:indentLine_color_term = 8
"let g:indentLine_char = '»'
let g:indentLine_char = '|'
"let g:indentLine_leadingSpaceChar = '·'
"let g:indentLine_leadingSpaceChar = ' '
"let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_faster = 1
let g:tex_conceal = ""

"call vundle#rc()

" more bundles here
call vundle#end()

" load ftplugins and indent files

filetype plugin indent on
filetype on

" **************************************

" **************************************
" * COMMANDS THAT MUST COME AFTER VUNDLE
" **************************************
set showcmd                     " show commands
" **************************************
