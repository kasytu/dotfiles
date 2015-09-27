" **************************************                                                                                                                                                                            
" * VARIABLES
" **************************************
set nocompatible               " get rid of strict vi compatibility!
set nu                          " line numbering on
set autoindent                  " autoindent on
set noerrorbells                " bye bye bells :)
set visualbell                  " Since intelliJ doesn't understand noerrorbells
                                    "it will understand to switch to visualbells.
set modeline                    " show what I'm doing
set showmode                    " show the mode on the dedicated line (see
set nowrap                      " no wrapping!
set ignorecase                  " search without regards to case
set backspace=indent,eol,start  " backspace over everything
set fileformats=unix,dos,mac    " open files from mac/dos
set exrc                        " open local config files
set nojoinspaces                " don't add white space when I don't tell 
set ruler                       " which line am I on?
set showmatch                   " ensure Dyck language
set incsearch                   " incremental searching
set nohlsearch                  " meh
set bs=2                        " fix backspacing in insert mode
set cursorline                  " highlighs current line
set formatoptions+=r            " auto add askerus for comments
set expandtab
set ts=4
set shiftwidth=4
set sm                          " show matching {()} or as typed.
set whichwrap +=>,l
set whichwrap +=<,h             "let l and h wrap around.
" :filetype on                    "Set it to recognize filetype 
      "Currently unsure of functionality^ 

" switch tabs on for makefiles (won't work with spaces):
au BufRead,BufNewfile Makefile set ts=4 sw=4 noexpandtab

" Enable arrow keys                    
imap ^[OA <ESC>ki                                    
imap ^[OB <ESC>ji                   
imap ^{OC <ESC>li
imap ^[OD <ESC>hi
" Enable jk becomes escape for leaving insert mode
imap jk <Esc>
" Use l; to save and quit
noremap l; :wq<CR>
noremap ns :wq<CR>
";TEMPORARY FOR INTERNATIONALIZATION SHORTCUT FOR IDENTITYMIND
noremap pq pxF"itr(<ESC>wf"a)<ESC>
noremap pa p0vf=y

"Allow all window commands in insert mode without accidentally
"deleting words
imap <C-w> <C-o><C-w>

" Autoclose tags

" Set open close brackets
"imap {<CR> {<CR><CR>}<ESC>ki<tab>
inoremap {<CR> {<CR>}<C-o>O

"Easier split navigations - remap left and right, up and down
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" nnoremap <C-S-Tab>   <C-W><C-H>
" nnoremap <C-Tab>     <C-W><C-L>

" Try insert mode
inoremap <C-J> <Esc><C-W><C-J>i
inoremap <C-K> <Esc><C-W><C-K>i
inoremap <C-L> <Esc><C-W><C-L>i
inoremap <C-H> <Esc><C-W><C-H>i


" Set splitirght
set splitright

"nmap :ba<CR> :b#<CR>


" Shows colors of syntax
syntax on                          
        
" Smart indent
set smartindent
set tabstop=4
set shiftwidth=4"originally 4
set expandtab

"Themes
colorscheme zellner  

" Line number highlight
highlight LineNr  ctermbg=black

" Highlight overlenght of 80
" highlight OverLength ctermbg=red ctermfg=white guibg=red 
" match OverLength /\%81v.\+/

" Highlight current line color
"highlight CursorLine   cterm=NONE ctermbg=black 

" Highlight color of VISUAL mode
highlight Visual  ctermbg=red
highlight Visual  ctermfg=white
  
" Highlight color of Matching paranthesis 
highlight MatchParen cterm=underline ctermbg=none ctermfg=white

ab FF /////////////////////////////////FIELDS/////////////////////////////////////
ab MM /////////////////////////////////METHODS////////////////////////////////////
ab CC //////////////////////////////CONSTRUCTORS//////////////////////////////////
ab SG ///////////////////////////SETTERS & GETTERS////////////////////////////////


"Testing Tab keyboard controls
"Movement between tabs OR buffers
"nnoremap <C-S-tab>  :tabprevious<CR>
"nnoremap <C-S-tab>  :call MyPrev()<CR>
"nnoremap <C-tab>    :tabnext<CR>
"nnoremap <C-tab>    :call MyPrev()<CR>
"nnoremap <C-t>      :tabnew<CR>
"inoremap <C-S-tab>  <Esc>:tabprevious<CR>i
"inoremap <C-tab>    <Esc>:tabnext<CR>i
"inoremap <C-t>      <Esc>:tabnew<CR>



" sets tab to fill wildchars for buffers
set wildchar=<tab> wildmenu wildmode=full

" Prompt if unsaved changes in buffer
set confirm

" Format statusline
 set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
" hi User1 ctermbg=white ctermfg=blue guibg=white guifg=blue
" hi User1 ctermbg=red ctermfg=blue 
"guibg=red guifg=blue

set statusline+=%1*
set laststatus=2
if version >= 700
  highlight statusline cterm=bold ctermfg=black ctermbg=red
  au InsertLeave * highlight Statusline cterm=bold ctermfg=black ctermbg=red
  au InsertEnter * highlight Statusline cterm=bold ctermfg=black ctermbg=green
endif

" nnoremap <C-W-W> :command vert 2ball<CR>
" nnoremap :vert 2ball<CR> <C-w-w>
"Switch to alternate file
" map <C-Tab> :bnext<cr>
" map <C-S-Tab> :bprevious<cr>

" set clipboard=unnamedplus

highlight LineNr ctermfg=white

" set colorcolumn=120

" Set Dedent.
" Handy function to search previous lines for indent levels and
" use those instead of multiples of shiftwidth.
function! DedentToPrevious()
python << EOF
import vim
tabsize = int(vim.eval("&ts"))
l = vim.current.line
rest = l.lstrip()
indent = l[:-len(rest)]
if indent != "":
    cur_size = len(indent.replace("\t", " "*tabsize))
    idx = vim.current.window.cursor[0]-2
    while idx >= 0:
        ll = vim.current.buffer[idx]
        indent = ll[:-len(ll.lstrip())]
        if len(indent.replace("\t", " "*tabsize)) < cur_size:
            vim.current.line = indent+rest
            break
        idx-=1
EOF
endfunction
" replace the <C-D> in insert mode with the above function
" imap <C-d> <C-o>:call DedentToPrevious()<CR>

" To get more sane behaviour with auto-indent, use this instead:
" imap <C-d> <Left><Right><C-o>:call DedentToPrevious()<CR>

" Use visual mode to indent/unindent:
vmap <TAB> >gv
vmap <S-TAB> <gv

imap <S-TAB> <ESC>hhhhh<TAB>i
noremap <S-LEFT> hxhxhxhx
noremap <S-RIGHT> i<SPACE><SPACE><SPACE><SPACE><ESC><RIGHT>

"set shortcut delay time
set timeout timeoutlen=250 ttimeoutlen=100

"Set relative numbers
set rnu
