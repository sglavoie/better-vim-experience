""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                       NEOVIM CONFIGURATION FILE                          """
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""" [ PLUGINS ]

call plug#begin($HOME . '/.local/share/nvim/plugged')

" async linting
Plug 'w0rp/ale'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" design & appearance
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajmwagar/vim-deus'
Plug 'altercation/vim-colors-solarized'
Plug 'jacoborus/tender.vim'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" language specific
Plug 'iamcco/markdown-preview.vim'

" moving/editing around
Plug 'brooth/far.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'yuttie/comfortable-motion.vim'

" Note-taking
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" useful features
Plug 'junegunn/fzf', { 'dir': $HOME . '/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

call plug#end()

"""""""""""""""""""""""""""""" [ / PLUGINS ]

"""""""""""""""""""""""""""""""""""""""" [ GENERAL SETTINGS ]

""""" [ APPEARANCE ]
set background=dark
"colorscheme onedark
colorscheme PaperColor
"colorscheme seoul256
"colorscheme solarized
"colorscheme tender
"colorscheme deus
set colorcolumn=80  " visually set maximum width
set cursorline  " highlight current line

" make the cursor blink in normal mode
:set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

" make the folds look pretty and pretty visible, calming blue as background
highlight Folded ctermfg=black ctermbg=031
""" [ / APPEARANCE ]

""""" [ VIM FEATURES ]
filetype plugin on
let mapleader = " "
let python_highlight_all=1
set cmdwinheight=100  " open command list window in maximized state
set encoding=utf-8
set expandtab  " use spaces instead of tabs
set history=1000  " command history (default: 10,000)
set linebreak  " wrap long lines
set mouse=a  " allows the use of the mouse
set nrformats=  " <C-a>/<C-x> with leading zeros → decimal instead of octal
set number  " displays absolute number of current line
set relativenumber  " displays relative number of the lines around current one
set scrolloff=2  " always leaves 2 lines above or below the current line
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

" allows to search recursively for files with pattern matching (e.g. :find)
set path=$PWD/**

" ignores certain files/directories in current path
set wildignore+=*.pyc,*.git*,*.db,*__pycache__*,*.png,*.jpg,*.jpeg,*.pdf
set wildignore+=*.svg,*.xcf

" multiple matches in command mode occupy more space, like in Bash
set wildmode=full

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

""" [ / VIM FEATURES ]

""""" [ NEOVIM FEATURES ]
let g:python3_host_prog = '/usr/local/bin/python3.7'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Show interactive modifications with search & replace before applying changes
set inccommand=nosplit
""" [ / NEOVIM FEATURES ]


"""""""""""""""""""""""""""""" [ / GENERAL SETTINGS ]

"""""""""""""""""""""""""""""""""""""""" [ PLUGINS SETTINGS ]

""""" [ ALE ]
let g:ale_fixers = ['autopep8', 'yapf']
let g:ale_linters = {
            \   'python': ['flake8', 'pylint'],
            \}
let g:ale_completion_enabled = 1
""" [ / ALE ]

""""" [ COMFORTABLE-MOTION ]
let g:comfortable_motion_friction = 150  " default = 80
let g:comfortable_motion_air_drag = 2.5  " default = 2.0
""" [ / COMFORTABLE-MOTION ]

""""" [ DEOPLETE ]
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3.7'

""" [ / DEOPLETE ]

""""" [ FZF ]
" Allows FZF to ignore patterns in .gitignore
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

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
" (expand word completing window)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '25%'})

" Make use of FZF command instead of CtrlP
map <C-p> :FZF<cr>
""" [ / FZF ]

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

""""" [ VIM-HIGHLIGHTEDYANK ]
let g:highlightedyank_highlight_duration = 800
""" [ / VIM-HIGHLIGHTEDYANK ]

""""" [ VIMWIKI ]
let g:vimwiki_list = [{'path': '~/Dropbox/university_london/notes/', 'path_html': '~/Dropbox/university_london/notes/html/', 'auto_tags': 1}]

" 'b' for 'reBuild' ('r' is for renaming wiki page)
nnoremap <Leader>wb :VimwikiRebuildTags<CR>

" 'g' for 'generate'
nnoremap <Leader>wg :VimwikiGenerateTags<CR>

" 'f' for 'find' ('s' is for selecting wiki)
nnoremap <Leader>wf :VimwikiSearchTags<space>
""" [ / VIMWIKI ]

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
" Make the current window the only one visible.
nnoremap <leader>w :on<CR>

" Remove all buffers except the active one.
nnoremap <leader>b :%bd\|e#\|bd#<CR>

" open a buffer to edit Neovim configuration file
nnoremap <leader>c :e ~/Dropbox/programming/github/sglavoie/better-vim-experience/init.vim<CR>

" close active buffer if there are no pending changes to save
nnoremap <leader>x :bd<CR>
nnoremap <M-q> :bd<CR>

" close active buffer even if there are pending changes to save
nnoremap <leader>X :bd!<CR>
nnoremap <M-Q> :bd!<CR>

" reset edits made in current buffer if file hasn't been saved
nnoremap <leader>e :e!<CR>

" in order: previous, next, alternate, first, last, list
nnoremap <M-1> :bp<CR>
nnoremap <M-2> :bn<CR>
nnoremap <M-3> :b#<CR>
nnoremap <M-4> :bf<CR>
nnoremap <M-5> :bl<CR>
nnoremap <leader>l :ls<CR>

" list buffers and quickly jump to one by entering a number
nnoremap gb :ls<CR>:b<Space>

" open list of buffers ready for fuzzy finder
nnoremap <leader>p :Buffers<CR>

" redraw screen and clear highlighted search as well
nnoremap <silent> <C-c> :<C-u>nohlsearch<CR><C-l>

""" [ / BUFFERS ]

""""" [ MOVEMENTS ]
" jump to next error in ALE (with |=next and °=previous)
map <char-124> <Plug>(ale_next_wrap)
map <char-176> <Plug>(ale_previous_wrap)

" move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" adjust size of current window vertically
map <M-_> <C-w>+
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
" bind K to grep word under cursor
map <silent> <M-k> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search with The Silver Search
nnoremap \ :Ag<SPACE>

" Start a search in normal mode (forward, backward)
nnoremap ñ /
nnoremap Ñ ?
""" [ / SEARCH ]

" toggle nerdtree on/off
nnoremap <leader>n :NERDTreeToggle<CR>

" press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" display help in new tab
nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>

" save file and regenerate ctags
nnoremap <leader>W :w<CR>:MakeTags<CR>:echo 'ctags have been updated.'<CR>

" close current window (closes Vim if there's only one window)
nnoremap <leader>q :q<CR>

" close all buffers without saving
nnoremap <leader>Q :qall!<CR>

" use space to toggle current fold
"nnoremap <space> za

" use leader + space to toggle all folds
nnoremap <expr> <leader><space> &foldlevel ? 'zM' :'zR'

" Set language for spelling
nnoremap <leader>Ls :set spelllang=es<CR>
nnoremap <leader>Le :set spelllang=en<CR>
nnoremap <leader>Lf :set spelllang=fr<CR>

" Show Markdown preview in web browser
"nnoremap <C-m> :MarkdownPreview<CR>

" Add link to MathJax
nnoremap <leader>m o<script type="text/javascript" src="/home/sglavoie/Dropbox/programming/github/others/MathJax/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script><Esc>


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
" Mapping to character ¬
nnoremap <Char-172> :call ToggleH()<CR>
""" [ / FUNCTIONS ]

"""""""""""""""""""""""""""""" [ / MAPPINGS ]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               CUSTOM COMMANDS                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 'MakeTags' command to generate ctags in project
command! MakeTags !ctags -R .

" Clear all opening and closing tags in XML and HTML
command! RemoveHTMLTags %s/<\_.\{-1,\}>//g



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
nnoremap <F12> :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

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
ab impotr import

" search for previous/next method / function
nnoremap <F2> ?def <CR>
nnoremap <F3> /def <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              DEBUGGING MAPPINGS                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" add breakpoint() to allow for debugging
nnoremap <F7> :s/\(^\s*\)\(.*$\)/\1breakpoint\(\)\r\1\2/<CR>:echo 'breakpoint: ADDED'<CR>:let @/ = ""<CR>

" comment all lines where 'breakpoint' is found
noremap <F8> :%s/\(^.*\)\(breakpoint()\)\(.*$\)/\1# \2\3/ge<CR><C-O>:echo 'breakpoint: COMMENTED'<CR>

" uncomment all lines where 'breakpoint' is found
nnoremap <F9> :%s/\(^.*\)\(# \)\(breakpoint()\)\(.*$\)/\1\3\4/ge<CR><C-O>:echo 'breakpoint: UNCOMMENTED'<CR>

" remove all lines where the 'breakpoint' debugging statement is found
nnoremap <F10> :%g/^.*breakpoint().*$/d<CR><C-O>:echo 'breakpoint: REMOVED'<CR>
