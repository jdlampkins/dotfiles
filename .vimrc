" Obviously
syntax on

" Do nice indentation.
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" Misc.
set number
set hlsearch
set incsearch
set laststatus=2

" Change status line color based on mode.
au InsertEnter * hi StatusLine ctermbg=black ctermfg=cyan
au InsertLeave * hi StatusLine ctermbg=black ctermfg=white

" Show lines above and below cursor.
set scrolloff=5

" Limits delay after using <esc> to exit insert mode.
set timeoutlen=1000

" Display cursor line only in current window.
autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline

" Highlight the line number for the cursor instead of the whole line.
hi clear CursorLine
hi clear CursorLineNr
hi CursorLineNr ctermfg=black ctermbg=cyan

" Filename autocompletion works like it does in bash.
set wildmenu
set wildmode=longest,list

" Automatically resize window width when containing window is resized.
autocmd VimResized * wincmd =

" Colors
hi Search ctermbg=darkcyan ctermfg=black
hi LineNr ctermfg=magenta

" Open new split panes to the right and bottom.
set splitbelow
set splitright

" Remapping for easy moving between windows.
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


" Rename tmux windows on vim start/stop.
" autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
" autocmd VimLeave * call system("tmux rename-window bash")

" When <space> is pressed, toggle between (1) displaying a grey line at the 81st
" column, (2) highlighting all characters past the 80th, (3) neither.
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
hi LongLine ctermbg=green ctermfg=black
nnoremap <silent> <space> :call ToggleColorColumn()<cr>
function! ToggleColorColumn()
    if &colorcolumn==""
        if getmatches()==[]
            set colorcolumn=81
            echo "Highlighting the 81st column."
        else
            call clearmatches()
            echo "Clearing all long line highlighting."
        endif
    else
        set colorcolumn=
        let w:m1=matchadd('LongLine', '\%>80v.\+', -1)
        echo "Highlighting all characters past the 80th."
    endif
endfunction

" Makes the mouse work well.
set ttymouse=sgr

" Function that toggles mouse mode.
nnoremap <leader>m :call ToggleMouse()<cr>
function! ToggleMouse()
    if &mouse==""
        set mouse=a
    else
        set mouse=
    endif
endfunction

" Toggle line number display when <tab> is pressed.
nnoremap <tab> :set number!<cr>

" Allows using the :sb command to swtich tabs/windows.
set switchbuf=useopen,usetab

" Macro to switch a capital letter to a lowercase letter preceded
" by an underscore.  Useful for switching from camel to snake case.
let @s = "vui_\<esc>"

" Highlight .pro files as prolog files
autocmd BufNewFile,BufRead *.pro set syntax=prolog

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

