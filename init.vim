""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                       NEOVIM CONFIGURATION FILE                          """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""" [ PLUGINS ]

call plug#begin('~/.local/share/nvim/plugged')

" async linting
Plug 'w0rp/ale'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" design & appearance
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" language specific
Plug 'plasticboy/vim-markdown'
Plug 'JamshedVesuna/vim-markdown-preview'

" moving/editing around
Plug 'brooth/far.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'yuttie/comfortable-motion.vim'

" useful features
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-fugitive'

call plug#end()

"""""""""""""""""""""""""""""" [ / PLUGINS ]

"""""""""""""""""""""""""""""""""""""""" [ GENERAL SETTINGS ]

""""" [ APPEARANCE ]

colorscheme PaperColor
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
set encoding=utf-8
set expandtab  " use spaces instead of tabs
set history=1000  " command history
set incsearch  " highlight match while typing
set linebreak  " wrap long lines
set mouse=a  " allows the use of the mouse
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
set textwidth=79  " number of characters in a line

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

" allows to search recursively for files with pattern matching (:find)
set path+=**

" show command in bottom bar
set showcmd

" visual autocomplete for command menu
set wildmenu

" settings based on file type
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

""" [ / VIM FEATURES ]

" disable background color erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
if &term =~ '256color'
    set t_ut=
endif

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

""""" [ GOYO ]
nnoremap <F11> :Goyo<CR>
""" [ / GOYO ]

""""" [ LIMELIGHT ]
" Let search highlight be first priority in all dimmed text
let g:limelight_priority = -1

" activate/deactivate limelight when using/not using goyo
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
""" [ / LIMELIGHT ]

""""" [ VIM-AIRLINE ]
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'
let g:airline#extensions#ale#enabled = 1
""" [ / VIM-AIRLINE ]

""""" [ VIM-EASYMOTION ]
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

""" [ / VIM-EASYMOTION ]

""""" [ VIM-MARKDOWN-PREVIEW ]
let vim_markdown_preview_github=1
""" [ / VIM-MARKDOWN-PREVIEW ]

"""""""""""""""""""""""""""""" [ / PLUGINS SETTINGS ]

"""""""""""""""""""""""""""""""""""""""" [ MAPPINGS ]

" Jump to next error in ALE (with É=previous and é=next)
map <Char-201> <Plug>(ale_previous_wrap)
map <Char-233> <Plug>(ale_next_wrap)

" display help in new tab
nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>

" close buffer
nnoremap <leader>q :q<CR>

" reset edits made in current buffer
nnoremap <leader>e :e!<CR>

" list buffers
nnoremap <leader>b :b#<CR>
nnoremap <leader>B :bn<CR>
nnoremap <leader>l :ls<CR>

" shortcut to save a buffer
nnoremap <leader>w :w!<CR>

" toggle nerdtree on/off
nnoremap <leader>n :NERDTreeToggle<CR>

" press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" use space to toggle folds
nnoremap <space> za

" add newline without leaving normal mode and stay on current line
nnoremap <leader>j o<Esc>
nnoremap <leader>k O<Esc>

" save file and regenerate ctags
nnoremap <leader>W :w<CR>:MakeTags<CR>:echo 'ctags have been updated.'<CR>


""""" [ FUNCTIONS ]

" remove all whitespace at the end of every line in the file.
noremap <F5> :%s/\s\+$//<CR>:echo 'all whitespace removed.'<CR>

" display text in red over column limit
let s:activatedh = 0
function! ToggleH()
    if s:activatedh == 0
        let s:activatedh = 1
        highlight OverLength ctermbg=red ctermfg=white guibg=#592929
        match OverLength /\%81v.\+/
    else
        let s:activatedh = 0
        match none
    endif
endfunction
" Mapping to character «
nnoremap <Char-171> :call ToggleH()<CR>

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

" search for previous/next function
nnoremap <F2> ?def <CR>
nnoremap <F3> /def <CR>


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

