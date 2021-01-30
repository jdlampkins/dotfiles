" Obviously
syntax on

" Do nice indentation.
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" Do nice searching.
set hlsearch
set incsearch

" Line numbering.
set number rnu
augroup number_toggle
    autocmd!
    autocmd BufEnter,WinEnter * set rnu
    autocmd BufLeave,WinLeave * set nornu
augroup END

" Always show status line.
set laststatus=2

" Enable 256 colors.
set t_Co=256

" Doing this to keep the status line from reversing colors by default.
hi StatusLine cterm=bold



" Functions for controlling coloring.

function! s:hl(group, fg, bg)
    execute 'hi '.a:group.' ctermfg='.a:fg.' ctermbg='.a:bg
endfunction

function! SetColors()
    call s:hl('Normal', s:almost_white, s:almost_black)
    call s:hl('Comment', s:steel, 'none')
    call s:hl('Constant', s:purple, 'none')
    call s:hl('Identifier', s:blue_green, 'none')
    call s:hl('Statement', s:brown, 'none')
    call s:hl('PreProc', s:dull_yellow, 'none')
    call s:hl('Type', s:swamp_green, 'none')
    call s:hl('Special', s:dull_yellow, 'none')
    call s:hl('Ignore', 'none', 'none')
    call s:hl('Error', s:almost_black, s:mild_red)
    call s:hl('Todo', s:almost_black, s:dull_yellow)

    call s:hl('Search', s:almost_black, s:blue_green)
    call s:hl('LineNr', s:purple, 'none')

    call s:hl('ColorColumn', s:almost_black, s:almost_white)
    call s:hl('LongLine', s:almost_black, s:swamp_green)
endfunction

function! ChangeInsertColor(mode)
    if a:mode == 'i'
        call s:hl('StatusLine', s:almost_white, s:blue_green)
        call s:hl('CursorLineNr', s:almost_white, s:blue_green)
    elseif a:mode == 'r'
        call s:hl('StatusLine', s:almost_white, s:mild_red)
        call s:hl('CursorLineNr', s:almost_white, s:mild_red)
    endif
endfunction

function! SetNormalModeColor()
    " Highlight the line number for the cursor instead of the whole line.
    hi clear CursorLine
    hi clear CursorLineNr
    call s:hl('CursorLineNr', s:almost_black, s:almost_white)
    call s:hl('StatusLine ', s:almost_black, s:almost_white)
endfunction

function! SetDefaultColors()
    let s:blue_green=30
    let s:almost_black=233
    let s:almost_white=250
    let s:mild_red=131
    let s:purple=133
    let s:swamp_green=28
    let s:steel=66
    let s:dull_yellow=185
    let s:brown=94
    call SetNormalModeColor()
    call SetColors()
endfunction

function! SetWarmColors()
    let s:blue_green=106 "148 " 154
    let s:almost_black=233
    let s:almost_white=229
    let s:mild_red=131
    let s:purple=125
    let s:swamp_green=172
    let s:steel=66
    let s:dull_yellow=184
    let s:brown=94
    call SetNormalModeColor()
    call SetColors()
endfunction

function! SetSaturatedColors()
    let s:blue_green=6
    let s:almost_black=0
    let s:almost_white=15
    let s:mild_red=1
    let s:purple=13
    let s:swamp_green=2
    let s:steel=14
    let s:dull_yellow=11
    let s:brown=3
    call SetNormalModeColor()
    call SetColors()
endfunction

" Change status line color based on mode.
augroup status_line_color_change
    autocmd!
    au InsertEnter,InsertChange * call ChangeInsertColor(v:insertmode)
    au InsertLeave * call SetNormalModeColor()
augroup END

nnoremap <leader><leader> :call ToggleColors()<cr>
function! ToggleColors()
    let schemes = ['SetWarmColors', 'SetSaturatedColors', 'SetDefaultColors']
    let spl = schemes[s:scheme_index]
    execute 'call '.spl.'()'
    let s:scheme_index = (s:scheme_index+1)%len(schemes)
endfunction

let s:scheme_index=0
call ToggleColors()



" Show lines above and below cursor.
set scrolloff=5

" Limits delay after using <esc> to exit insert mode.
set timeoutlen=200
set ttimeoutlen=10

" Display cursor line only in current window.
augroup cursorline_in_current_window
    autocmd!
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" Filename autocompletion works like it does in bash.
set wildmenu
set wildmode=longest,list

" Automatically resize window width when containing window is resized
" or when switching to a new tab.
autocmd VimResized,TabEnter * wincmd =

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
if !has('nvim')
    set ttymouse=sgr
endif

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
nnoremap <tab> :set number! rnu!<cr>

" Allows using the :sb command to swtich tabs/windows.
set switchbuf=useopen,usetab

" Macro to switch a capital letter to a lowercase letter preceded
" by an underscore.  Useful for switching from camel to snake case.
let @s = "vui_\<esc>"

" Highlight .pro files as prolog files
autocmd BufNewFile,BufRead *.pro set syntax=prolog

" Shift-tab acts as escape
nnoremap <S-Tab> <Esc>
vnoremap <S-Tab> <Esc>gV
onoremap <S-Tab> <Esc>
cnoremap <S-Tab> <C-C><Esc>
inoremap <S-Tab> <Esc>`^

" local customizations in ~/.vimrc_local
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
    source $LOCALFILE
endif

