""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                       NEOVIM CONFIGURATION FILE                          """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""" [ PLUGINS ]

call plug#begin('~/.local/share/nvim/plugged')

" async linting
Plug 'w0rp/ale'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi-vim'

" design & appearance
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" language specific
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'plasticboy/vim-markdown'

" moving/editing around
Plug 'brooth/far.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'yuttie/comfortable-motion.vim'

" useful features
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'

call plug#end()

"""""""""""""""""""""""""""""" [ / PLUGINS ]

"""""""""""""""""""""""""""""""""""""""" [ GENERAL SETTINGS ]

""""" [ APPEARANCE ]
colorscheme gruvbox
"colorscheme PaperColor
"colorscheme solarized
set background=dark
set colorcolumn=80  " visually set maximum width
set cursorline  " highlight current line

" make the folds look pretty with grey background
highlight Folded guibg=black guifg=yellow
""" [ / APPEARANCE ]

""""" [ VIM FEATURES ]
filetype plugin on
let mapleader = "-"
let python_highlight_all=1
set cmdwinheight=100  " open command list window in maximized state
set encoding=utf-8
set expandtab  " use spaces instead of tabs
set history=1000  " command history
set incsearch  " highlight match while typing
set linebreak  " wrap long lines
set mouse=a  " allows the use of the mouse
set nrformats=  " <C-a>/<C-x> with leading zeros → decimal instead of octal
set number  " displays absolute number of current line
set relativenumber  " displays relative number of the lines around current one
set scrolloff=1  " always leaves 1 line above or below the current line
set shiftwidth=4  " number of spaces for indents
set smartcase  " match uppercase in search if used in pattern, else, no
set softtabstop=4  " number of spaces to insert when TAB is pressed
set spell
set spellfile=~/.config/nvim/spell/en.utf-8.add
set splitbelow  " put new window below current one when splitting
set splitright  " put new window to the right of the current one when splitting
set tabstop=4  " ideally, same value as 'shiftwidth'
set textwidth=0  " number of characters in a line (0 = no limit)

" use the system clipboard by default
set clipboard=unnamedplus

" enable folding of blocks of code
set foldlevel=99

" allows to switch to other buffers without raising error
" when the current buffer remains unsaved
set hidden

" search regardless of case by default
set ignorecase

" always displays status line
set laststatus=2

" allows to search recursively for files with pattern matching (e.g. :find)
set path=$PWD/**

" ignores certain files/directories in current path
set wildignore+=*.pyc,*.git*,*.db,*__pycache__*,*.png,*.jpg,*.jpeg,*.pdf
set wildignore+=*.svg,*.xcf

" show normal command being typed in bottom right corner
set showcmd

" visual autocomplete for command menu
set wildmenu

" multiple matches in command mode occupy more space, like in Bash
set wildmode=full

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" settings based on file type
"au BufNewFile,BufRead *.js, *.html, *.css
    "\ set tabstop=2
    "\ set softtabstop=2
    "\ set shiftwidth=2
""" [ / VIM FEATURES ]

" disable background color erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
"if &term =~ '256color'
    "set t_ut=
"endif

""""" [ NEOVIM FEATURES ]
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Show interactive modifications with search & replace before applying changes
set inccommand=nosplit
""" [ / NEOVIM FEATURES ]


"""""""""""""""""""""""""""""" [ / GENERAL SETTINGS ]

"""""""""""""""""""""""""""""""""""""""" [ PLUGINS SETTINGS ]

""""" [ ALE ]
let g:ale_linters = {
            \   'python': ['pycodestyle'],
            \}
let g:ale_completion_enabled = 1
""" [ / ALE ]

""""" [ COMFORTABLE-MOTION ]
let g:comfortable_motion_friction = 200  " default = 80
let g:comfortable_motion_air_drag = 3.0  " default = 2.0
""" [ / COMFORTABLE-MOTION ]

""""" [ DEOPLETE ]
let g:deoplete#enable_at_startup = 1
""" [ / DEOPLETE ]

""""" [ FZF ]
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Make use of FZF command instead of CtrlP
map <C-p> :FZF<cr>
""" [ / FZF ]

""""" [ JEDI-VIM ]
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_select_first = 0
""" [ / JEDI-VIM ]

""""" [ VIM-AIRLINE ]
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='onedark'
" The following settings are used to get a tab navigation bar at the top
"let g:airline#extensions#tabline#left_alt_sep = ' '
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#formatter = 'unique_tail'
""" [ / VIM-AIRLINE ]

""""" [ VIM-EASYMOTION ]
let g:EasyMotion_do_mapping = 1 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{char}{label}`
nmap ¿ <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
""" [ / VIM-EASYMOTION ]

""""" [ VIM-MARKDOWN-PREVIEW ]
let vim_markdown_preview_github=1
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='firefox'
" In order to change the default browser which is Google Chrome, the following
" command need to be entered in the terminal:
" update-alternatives --install /usr/bin/x-www-browser x-www-browser /path/to/other-browser 100
" If using GNOME, also this command:
" update-alternatives --install /usr/bin/gnome-www-browser gnome-www-browser /path/to/other-browser 100
""" [ / VIM-MARKDOWN-PREVIEW ]

"""""""""""""""""""""""""""""" [ / PLUGINS SETTINGS ]

"""""""""""""""""""""""""""""""""""""""" [ MAPPINGS ]

""""" [ TERMINAL SPECIFIC ]
" Exit from terminal buffer (Neovim) more easily (remaps Esc key in terminal)
tnoremap <C-[> <C-\><C-n>

" Open terminal buffer (Neovim)
nnoremap <M-t> :te<CR>

" Switch to terminal buffer automatically (when only one terminal is open)
nnoremap <M-0> :b term://<CR>

tnoremap <C-j><C-k> <C-\><C-N>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
""" [ / TERMINAL SPECIFIC ]

""""" [ BUFFERS ]
" open a buffer to edit Neovim configuration file
nnoremap <leader>C :e ~/Dropbox/programming/github/better-vim-experience/init.vim<CR>

" close active buffer if there are no pending changes to save
nnoremap <leader>x :bd<CR>
nnoremap <M-q> :bd<CR>

" close active buffer even if there are pending changes to save
nnoremap <leader>X :bd!<CR>

" reset edits made in current buffer
nnoremap <leader>e :e!<CR>

" in order: previous, next, alternate, first, last, list
nnoremap <M-1> :bp<CR>
nnoremap <M-2> :bn<CR>
nnoremap <M-3> :b#<CR>
nnoremap <M-4> :bf<CR>
nnoremap <M-5> :bl<CR>
nnoremap <leader>l :ls<CR>

" shortcut to save a buffer
nnoremap <leader>w :w!<CR>
""" [ / BUFFERS ]

""""" [ MOVEMENTS ]
" jump to next error in ALE (with |=previous and °=next)
map <char-124> <Plug>(ale_previous_wrap)
map <char-176> <Plug>(ale_next_wrap)

" move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" adjust size of current window vertically
map <M-+> <C-w>+
map <M--> <C-w>-

" adjust size of current window horizontally
map <M->> <C-w>>
map <M-<> <C-w><

" add newline without leaving normal mode and stay on current line
nnoremap <leader>j o<Esc>
nnoremap <leader>k O<Esc>

" moves more easily with long lines that wrap
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" remaps Escape key to more accessible keys in Insert mode
inoremap kj <esc>

" allows to expand directory without filename of current open buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
""" [ / MOVEMENTS ]

""""" [ SEARCH ]
" find word under cursor in all files in current path
nnoremap <leader>a :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" find a file in current path (works well with "set path+=**")
nnoremap <leader>G :find<space>*

" bind K to grep word under cursor
map <silent> <M-k> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search with The Silver Search
nnoremap \ :Ag<SPACE>

" Start a search in normal mode (forward, backward)
nnoremap ñ /
nnoremap Ñ ?
""" [ / SEARCH ]

" toggle nerdtree on/off
nnoremap <leader>N :NERDTreeToggle<CR>

" press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" display help in new tab
nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>

" save file and regenerate ctags
nnoremap <leader>W :w<CR>:MakeTags<CR>:echo 'ctags have been updated.'<CR>

" close current window (closes Vim if there's only one window)
nnoremap <leader>q :q<CR>

" use space to toggle folds
nnoremap <space> za

""""" [ FUNCTIONS ]
" remove all whitespace at the end of every line in the file.
noremap <F5> :%s/\s\+$//<CR>:echo 'all whitespace removed.'<CR>

" display text in red over column limit
"let s:activatedh = 0
"function! ToggleH()
    "if s:activatedh == 0
        "let s:activatedh = 1
        "highlight OverLength ctermbg=red ctermfg=white guibg=#592929
        "match OverLength /\%81v.\+/
    "else
        "let s:activatedh = 0
        "match none
    "endif
"endfunction
" Mapping to character ¬
"nnoremap <Char-172> :call ToggleH()<CR>
""" [ / FUNCTIONS ]

"""""""""""""""""""""""""""""" [ / MAPPINGS ]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               CUSTOM COMMANDS                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 'MakeTags' command to generate ctags in project
command! MakeTags !ctags -R .


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                GIT SECTION                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" add git capability to the status line with vim-fugitive
set statusline+=%{fugitive#statusline()}

" git status when appropriate
nnoremap <leader>s :Gstatus<CR>

" git diff when appropriate
nnoremap <leader>D :Gdiff<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              PYTHONIC SECTION                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" display python help for word under cursor
nnoremap <buffer> <F12> :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

" add TODO comment to the end of the line and place into insert mode
map <leader>t <Esc>A  # TODO: <Esc>A

" find next TODO comment in current file
map <leader>T <Esc>/\C# TODO: <CR>

" add FIXME comment to the end of the line and place into insert mode
map <leader>f <Esc>A  # FIXME: <Esc>A

" find next FIXME comment in current file
map <leader>F <Esc>/\C# FIXME: <CR>

" Abbreviations
ab ass assert
ab bk break
ab cl class
ab cont continue
ab ex except
ab fi finally
ab fro for
ab glo global
ab nlo nonlocal
ab ret return
ab teh the
ab wh while
ab wi with
ab yi yield

" search for previous/next method / function
nnoremap <F2> [m
nnoremap <F3> ]m


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              DEBUGGING MAPPINGS                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" add set_trace() to allow for debugging
nnoremap <F7> :s/\(^\s*\)\(.*$\)/\1import pdb; pdb.set_trace\(\)\r\1\2/<CR>:echo 'pdb debugging: ADDED'<CR>:let @/ = ""<CR>

" comment all lines where 'pdb' is found
noremap <F8> :%s/\(^.*\)\(import pdb; pdb.set_trace()\)\(.*$\)/\1# \2\3/ge<CR><C-O>:echo 'pdb debugging: COMMENTED'<CR>

" uncomment all lines where 'pdb' is found
nnoremap <F9> :%s/\(^.*\)\(# \)\(import pdb; pdb.set_trace()\)\(.*$\)/\1\3\4/ge<CR><C-O>:echo 'pdb debugging: UNCOMMENTED'<CR>

" remove all lines where the 'pdb' debugging statement is found
nnoremap <F10> :%g/^.*import pdb; pdb.set_trace().*$/d<CR><C-O>:echo 'pdb debugging: REMOVED'<CR>
