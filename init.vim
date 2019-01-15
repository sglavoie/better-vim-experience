"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""                       NEOVIM CONFIGURATION FILE                         """
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""" [ PLUGINS ]

call plug#begin($HOME . '/.local/share/nvim/plugged')

" Async linting
Plug 'w0rp/ale'

" Autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

" Design & appearance
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'whatyouhide/vim-gotham'

" Language specific
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Moving/editing around
Plug 'brooth/far.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'yuttie/comfortable-motion.vim'

" Note-taking
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" Useful features
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
"colorscheme PaperColor
"colorscheme dracula
"colorscheme molokai
"colorscheme one
"colorscheme tender
colorscheme gruvbox
set colorcolumn=80  " Visually set maximum width
set cursorline  " Highlight current line

" Make the cursor blink in normal mode
":set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  "\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  "\,sm:block-blinkwait175-blinkoff150-blinkon175

" Make the folds look pretty and pretty visible, calming blue as background
highlight Folded ctermfg=black ctermbg=031
""" [ / APPEARANCE ]

""""" [ VIM FEATURES ]
filetype plugin on
let mapleader = " "
let python_highlight_all=1
set cmdwinheight=100  " Open command list window in maximized state
set encoding=utf-8
set expandtab  " Use spaces instead of tabs
set history=1000  " Command history (default: 10,000)
set linebreak  " Wrap long lines
set mouse=a  " Allows the use of the mouse
set nrformats=  " <C-a>/<C-x> with leading zeros → decimal instead of octal
set number  " Displays absolute number of current line
set relativenumber  " Displays relative number of the lines around current one
set scrolloff=2  " Always leaves 2 lines above or below the current line
set shiftwidth=4  " Number of spaces for indents
set smartcase  " Match uppercase in search if used in pattern, else, no
set softtabstop=4  " Number of spaces to insert when TAB is pressed
set spell
set spellfile=~/.config/nvim/spell/en.utf-8.add
set splitbelow  " Put new window below current one when splitting
set splitright  " Put new window to the right of the current one when splitting
set termguicolors  " Make colors look better in terminal
set tabstop=4  " Ideally, same value as 'shiftwidth'
set textwidth=0  " Number of characters in a line (0 = no limit)

" Use the system clipboard by default
set clipboard=unnamedplus

" Enable folding of blocks of code
set foldlevel=99

" Allows to switch to other buffers without raising error
" When the current buffer remains unsaved
set hidden

" Search regardless of case by default
set ignorecase

" Allows to search recursively for files with pattern matching (e.g. :find)
set path=$PWD/**

" Ignores certain files/directories in current path
set wildignore+=*.pyc,*.git*,*.db,*__pycache__*,*.png,*.jpg,*.jpeg,*.pdf
set wildignore+=*.svg,*.xcf

" Multiple matches in command mode occupy more space, like in Bash
set wildmode=full

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Disables automatic commenting on newline (from https://lukesmith.xyz/)
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

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
let g:comfortable_motion_friction = 150  " Default = 80
let g:comfortable_motion_air_drag = 2.5  " Default = 2.0
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
let g:airline_theme='papercolor'

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
" 'b' for 'reBuild' ('r' is for renaming wiki page)
nnoremap <Leader>wb :VimwikiRebuildTags<CR>

" 'g' for 'generate'
nnoremap <Leader>wg :VimwikiGenerateTags<CR>

" 'f' for 'find' ('s' is for selecting wiki)
nnoremap <Leader>wf :VimwikiSearchTags<space>

" Registered Wikis
let wiki_1 = {}
let wiki_1.path = '~/Dropbox/university_london/notes/'
let wiki_1.path_html = '~/Dropbox/university_london/notes/html/'
let wiki_1.auto_tags = 1

let wiki_2 = {}
let wiki_2.path = '~/Dropbox/notes/'
let wiki_2.path_html = '~/Dropbox/notes/html/'
let wiki_2.index = 'index'

let g:vimwiki_list = [wiki_1, wiki_2]
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
" Make the current window the only one visible
nnoremap <leader>o :on<CR>

" Save the current buffer
nnoremap <leader>w :write<CR>

" Remove all buffers except the active one.
nnoremap <leader>b :%bd\|e#\|bd#<CR>

" Open a buffer to edit Neovim configuration file
nnoremap <leader>c :e ~/Dropbox/programming/github/sglavoie/
            \better-vim-experience/init.vim<CR>

" Close active buffer if there are no pending changes to save
nnoremap <leader>x :bd<CR>
nnoremap <M-q> :bd<CR>

" Close active buffer even if there are pending changes to save
nnoremap <leader>X :bd!<CR>
nnoremap <M-Q> :bd!<CR>

" Reset edits made in current buffer if file hasn't been saved
nnoremap <leader>e :e!<CR>

" In order: previous, next, alternate, first, last, list
nnoremap <M-1> :bp<CR>
nnoremap <M-2> :bn<CR>
nnoremap <M-3> :b#<CR>
nnoremap <M-4> :bf<CR>
nnoremap <M-5> :bl<CR>
nnoremap <leader>l :ls<CR>

" List buffers and quickly jump to one by entering a number
nnoremap gb :ls<CR>:b<Space>

" Open list of buffers ready for fuzzy finder
nnoremap <leader>p :Buffers<CR>

" Redraw screen and clear highlighted search as well
nnoremap <silent> <C-c> :<C-u>nohlsearch<CR><C-l>

""" [ / BUFFERS ]

""""" [ MOVEMENTS ]
" Jump to next error in ALE (with |=next and °=previous)
map <char-124> <Plug>(ale_next_wrap)
map <char-176> <Plug>(ale_previous_wrap)

" Move between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Adjust size of current window vertically
map <M-_> <C-w>+
map <M--> <C-w>-

" Adjust size of current window horizontally
map <M->> <C-w>>
map <M-<> <C-w><

" Add newline without leaving normal mode and stay on current line
nnoremap <leader>j o<Esc>
nnoremap <leader>k O<Esc>

" Moves more easily with long lines that wrap without compromising default
" hjkl behavior
nmap <Down> gj
nmap <Up> gk

" Make use of Left and Right arrow keys to move text (indents)
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv

" Remaps Escape key to more accessible keys in Insert mode
inoremap kj <esc>

" Allows to expand directory without filename of current open buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
""" [ / MOVEMENTS ]

""""" [ SEARCH ]
" Bind K to grep word under cursor
map <silent> <M-k> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search with The Silver Search
nnoremap \ :Ag<SPACE>

" Start a search in normal mode (forward, backward)
nnoremap ñ /
nnoremap Ñ ?
""" [ / SEARCH ]

" Toggle nerdtree on/off
nnoremap <leader>n :NERDTreeToggle<CR>

" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

" Display help in new tab
nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>

" Save file and regenerate ctags
nnoremap <leader>W :w<CR>:MakeTags<CR>:echo 'ctags have been updated.'<CR>

" Close current window (closes Vim if there's only one window)
nnoremap <leader>q :q<CR>

" Close all buffers without saving
nnoremap <leader>Q :qall!<CR>

" Use space to toggle current fold
"nnoremap <leader><space> za

" Use leader + space to toggle all folds
"nnoremap <expr> <leader><space> &foldlevel ? 'zM' :'zR'

" Set language for spelling
nnoremap <leader>Ls :set spelllang=es<CR>
nnoremap <leader>Le :set spelllang=en<CR>
nnoremap <leader>Lf :set spelllang=fr<CR>

" Add link to MathJax
nnoremap <leader>m o<script type="text/javascript" src="/home/sglavoie/Dropbox/
            \programming/github/others/MathJax/MathJax.js?config=
            \TeX-AMS-MML_HTMLorMML"></script><Esc>


""""" [ FUNCTIONS ]
" Remove all whitespace at the end of every line in the file.
noremap <F5> :%s/\s\+$//<CR>:echo 'all whitespace removed.'<CR>

" Display text in red over column limit
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              CUSTOM COMMANDS                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 'MakeTags' command to generate ctags in project
command! MakeTags !ctags -R .

" Clear all opening and closing tags in XML and HTML
command! RemoveHTMLTags %s/<\_.\{-1,\}>//g



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               GIT SECTION                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add git capability to the status line with vim-fugitive
set statusline+=%{fugitive#statusline()}

" Git status when appropriate
nnoremap <leader>s :Gstatus<CR>

" Git diff when appropriate
nnoremap <leader>D :Gdiff<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             PYTHONIC SECTION                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Display python help for word under cursor
nnoremap <F12> :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>

" Add TODO comment to the end of the line and place into insert mode
map <leader>t <Esc>A  # TODO: <Esc>A

" Find next TODO comment in current file
map <leader>T <Esc>/\C# TODO: <CR>

" Add FIXME comment to the end of the line and place into insert mode
map <leader>f <Esc>A  # FIXME: <Esc>A

" Find next FIXME comment in current file
map <leader>F <Esc>/\C# FIXME: <CR>

" Abbreviations
ab ifname if __name__ == '__main__':
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

" Search for previous/next method / function
nnoremap <F2> ?def <CR>
nnoremap <F3> /def <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             DEBUGGING MAPPINGS                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add breakpoint() to allow for debugging
nnoremap <F7> :s/\(^\s*\)\(.*$\)/\1breakpoint\(\)\r\1\2/<CR>
            \:echo 'breakpoint: ADDED'<CR>:let @/ = ""<CR>

" Comment all lines where 'breakpoint' is found
noremap <F8> :%s/\(^.*\)\(breakpoint()\)\(.*$\)/\1# \2\3/ge<CR><C-O>
            \:echo 'breakpoint: COMMENTED'<CR>

" Uncomment all lines where 'breakpoint' is found
nnoremap <F9> :%s/\(^.*\)\(# \)\(breakpoint()\)\(.*$\)/\1\3\4/ge<CR><C-O>
            \:echo 'breakpoint: UNCOMMENTED'<CR>

" Remove all lines where the 'breakpoint' debugging statement is found
nnoremap <F10> :%g/^.*breakpoint().*$/d<CR><C-O>:echo 'breakpoint: REMOVED'<CR>
