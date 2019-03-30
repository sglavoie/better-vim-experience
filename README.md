# Tips and tricks for [Vim](https://github.com/vim/vim) / [Neovim](https://github.com/neovim/neovim)

[Link to up-to-date current Neovim configuration file](https://github.com/sglavoie/dotfiles/blob/master/config/nvim/init.vim).

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [General Tips And Tricks](#general-tips-and-tricks)
    * [Display the main help buffer in a new tab](#display-the-main-help-buffer-in-a-new-tab)
    * [Remove all whitespace at the end of every line in the buffer](#remove-all-whitespace-at-the-end-of-every-line-in-the-buffer)
    * [Access command mode more easily by swapping colon with semi-colon](#access-command-mode-more-easily-by-swapping-colon-with-semi-colon)
    * [Add newline without leaving normal mode and stay on current line](#add-newline-without-leaving-normal-mode-and-stay-on-current-line)
    * [Completions with Ctrl+x (eXpand)](#completions-with-ctrlx-expand)
* [Programming in Python](#programming-in-python)
    * [tmux integration](#tmux-integration)
        * [Configuration file: ~/.tmux.conf](#configuration-file-tmuxconf)
        * [Automating the launch of a default session: ~/.tmux_default_session.sh](#automating-the-launch-of-a-default-session-tmux_default_sessionsh)
        * [Aliases to make use of .tmux_default_session.sh](#aliases-to-make-use-of-tmux_default_sessionsh)
        * [tmux demo](#tmux-demo)
    * [Navigate to definitions and tags](#navigate-to-definitions-and-tags)
        * [Navigate inside the current buffer](#navigate-inside-the-current-buffer)
        * [Navigate inside all buffers within the current project](#navigate-inside-all-buffers-within-the-current-project)
    * [Quick and effective way to use PDB (Python Debugger)](#quick-and-effective-way-to-use-pdb-python-debugger)
        * [Adding the debugging statement](#adding-the-debugging-statement)
            * [Before Python 3.7](#before-python-37)
            * [Python 3.7+](#python-37)
        * [Commenting all the lines where the debugging statement is found](#commenting-all-the-lines-where-the-debugging-statement-is-found)
        * [Uncommenting all the lines where the debugging statement is found](#uncommenting-all-the-lines-where-the-debugging-statement-is-found)
        * [Removing all traces of pdb.set_trace()](#removing-all-traces-of-pdbset_trace)
    * [Add TODO/FIXME comment to the end of the line and place into insert mode](#add-todofixme-comment-to-the-end-of-the-line-and-place-into-insert-mode)
    * [Find next TODO/FIXME comment in current buffer](#find-next-todofixme-comment-in-current-buffer)
    * [Simple abbreviations for the main Python keywords](#simple-abbreviations-for-the-main-python-keywords)
    * [Search for previous/next function](#search-for-previousnext-function)
    * [Display text in red over column limit](#display-text-in-red-over-column-limit)
    * [Display Python help for word under cursor](#display-python-help-for-word-under-cursor)
    * [Quickly toggle all folds in current buffer](#quickly-toggle-all-folds-in-current-buffer)

<!-- vim-markdown-toc -->

---

## General Tips And Tricks

This is obviously far from being an exhaustive list, but those are some tips and tricks that I find really useful on a daily basis.

### Display the main help buffer in a new tab

```vim
   " Display help in new tab
   nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>
```
This is useful to maximize the help window and read more easily. You can quickly switch back to the next tab with the keystrokes `gt` (especially useful if you don't have any other tab opened). Simply do `:q` on the help tab and you're back to work! 

### Remove all whitespace at the end of every line in the buffer

This also works for lines that only contain whitespace. It keeps the line in place but remove the extra space(s) or tab(s) that might have been left by accident.
```vim
   noremap <F5> :%s/\s\+$//<CR>:echo 'all whitespace removed.'<CR>
```

### Access command mode more easily by swapping colon with semi-colon

If you (almost) never use the key `;`, you can swap it with `:` to get to the command line more easily. You can still continue to use `;` by typing `:`.
```vim
   nnoremap ; :
   nnoremap : ;
```

### Add newline without leaving normal mode and stay on current line 
```vim
   nnoremap <C-J> o<Esc>
   nnoremap <C-K> O<Esc>
```

### Completions with Ctrl+x (eXpand)
Those are the combinations that I tend to use the most.
- `Ctrl + x  Ctrl + p` will find a word and suggest a list to complete it. If there's only a match, it is automatically inserted. 
- `Ctrl + x  Ctrl + l` will complete a whole line automatically if there's only one match, else it will suggest a list.
- `Ctrl + x  Ctrl + k` will complete a word from the dictionary.
- `Ctrl + x  Ctrl + ]` will complete a word from available tags.

---

## Programming in Python

### tmux integration

[tmux](https://github.com/tmux/tmux) offers many advantages in the context of remote access to another machine, but it also shines on a local setup! Here is how I currently like to set it up.

#### Configuration file: ~/.tmux.conf
```
# split panes using | and -
bind | split-window -h
bind - split-window -v
unbind '"'
unbind %

# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D


# Enable mouse mode (tmux 2.1 and above)
set -g mouse on

source-file "${HOME}/.tmux-themepack/blue.tmuxtheme"
```

This is all very self-explanatory. [Many themes can be found here](https://github.com/jimeh/tmux-themepack).


#### Automating the launch of a default session: ~/.tmux_default_session.sh
This is a small Bash script that I like to have for automatic set up of a development environment with tmux and Vim/Neovim. As my current workflow, I enjoy the following:
```
#!/bin/bash
# var for session name (to avoid repeated occurences)
sn=dev

tmux new-session -s "$sn" -d

# Create 3 windows
tmux new-window -t "$sn:0" -n "nvim"
tmux new-window -t "$sn:9" -n "python"
tmux new-window -t "$sn:8" -n "terminal"

# Split terminal window vertically, then split the right pane horizontally,
# then switch to the left pane
# _________________
# | >_    |>      |
# |       |       |
# | FOCUS |-------|
# | HERE  |>      |
# |       |       |
# -----------------
tmux split-window -h
tmux split-window -v
tmux select-pane -L

# Set up Neovim ready to open files
tmux send-keys -t "$sn:0" C-z 'nvim .' Enter

# Set up alias for IPython and clear the screen when entering IPython
tmux send-keys -t "$sn:9" C-z 'ipython' Enter
tmux send-keys -t "$sn:9" 'clear' Enter

# Select window #0 and attach to the session
tmux select-window -t "$sn:0"
tmux -2 attach-session -t "$sn"
```

#### Aliases to make use of .tmux_default_session.sh
I add the following aliases in `~/.bash_aliases` to automate a chunk of the workflow:
```
# This will launch tmux with the desired configuration
alias dev='bash ~/.tmux_default_session.sh'

# This will kill the tmux server if the need arises. By detaching from the tmux
# session, you simply run this command and can reattach easily to the default
# session configuration on another project.
alias kdev='pkill tmux'

# If the session has been detached but the tmux server is still running, I use
# the following alias to quickly reattach to the default session named `dev`
# in that example.
alias adev='tmux attach-session -t dev'
```

#### tmux demo

![](tmux-demo.gif)

### Navigate to definitions and tags

#### Navigate inside the current buffer
There is a command `gd` that stands for "Goto local Declaration". It is quite useful when looking for a variable inside the current buffer as it allows to jump to where it is declared when the variable is under the cursor. Using that command, you can also find where a function is declared and it will find the first occurrence in the current function. If looking for the first occurrence in the buffer, `gD`  ("Goto global Declaration") will do the trick. You can jump back and forth to where you were with the commands `Ctrl + O` (older position) and `Ctrl + I` (newer position) in normal mode.

#### Navigate inside all buffers within the current project
To be able to jump between buffers and go back to the origin of a declaration when it is imported in the current module, generating tags comes in very handy as it allows you to use the command `Ctrl + ]` to jump to a tag, just like when using the help pages in Vim.

To make this work, we can conveniently use `ctags`. You can put the following command in your configuration file to be able to generate the necessary tags inside Vim by typing `MakeTags` in command mode:
```vim
command! MakeTags !ctags -R .
```

This will make it easy to remember how to do it. After that, open an existing project in its root directory and use this newly created `MakeTags` command to generate the tags. This will create a file named `tags` in the current working directory. Now, you will be able to open any file inside your project and jump to all the available declarations with `Ctrl + ]`.

If you go to a tag that leads you a few declarations away in one file or another, you can come back with `Ctrl + T`. Here is a clear explanation from Vim's help:
```
The most obvious way to use this is while browsing through the call graph of
a program.  Consider the following call graph:

	main  --->  FuncA  --->  FuncC
	      --->  FuncB

(Explanation: main calls FuncA and FuncB; FuncA calls FuncC).
You can get from main to FuncA by using CTRL-] on the call to FuncA.  Then
you can CTRL-] to get to FuncC.  If you now want to go back to main you can
use CTRL-T twice.  Then you can CTRL-] to FuncB.
```

To keep those tags useful when you update your project, you can map a sequence that saves the buffer you are working on and then regenerates the tags automatically. Here is an example:
```vim
nnoremap <leader>W :w<CR>:MakeTags<CR>:echo 'ctags have been updated.'<CR>
```

### Quick and effective way to use PDB (Python Debugger)

I have found that using **pdb.set_trace()** is quite useful to debug a program and I now use the following mappings in Vim's configuration file to facilitate the work.

#### Adding the debugging statement

##### Before Python 3.7
```vim
   " Add pdb.set_trace() to allow for debugging
   nnoremap <F7> :s/\(^\s*\)\(.*$\)/\1import pdb; pdb.set_trace\(\)\r\1\2/<CR>:echo 'pdb debugging: ADDED'<CR>:let @/ = ""<CR>
```
This adds a new line with the content `import pdb; pdb.set_trace()` above the current line with the same amount of leading whitespace as the line where the cursor is located. This is how the following snippet of code is affected (the cursor should be located on line `2`):
```python
1  def main_execution() -> str:
2      string_input = input()
3      return compare_scores(string_input)
```
It then becomes:
```python
1  def main_execution() -> str:
2      import pdb; pdb.set_trace()
3      string_input = input()
4      return compare_scores(string_input)
```

##### Python 3.7+

Since Python 3.7, there is a new built-in function, `breakpoint()`, which will basically do the same as importing pdb and adding `set_trace` in one step:
```python
1  def main_execution() -> str:
2      breakpoint()
3      string_input = input()
4      return compare_scores(string_input)
```

The corresponding mapping with Python 3.7+ could be something as follow:
```vim
" Add breakpoint() to allow for debugging
nnoremap <F7> :s/\(^\s*\)\(.*$\)/\1breakpoint\(\)\r\1\2/<CR>:echo 'breakpoint: ADDED'<CR>:let @/ = ""<CR>
```

#### Commenting all the lines where the debugging statement is found
```vim
   " Comment all lines where 'pdb.set_trace()' is found
   nnoremap <F8> :%s/\(^.*\)\(import pdb; pdb.set_trace()\)\(.*$\)/\1# \2\3/ge<CR><C-O>:echo 'pdb debugging: COMMENTED'<CR>
   
   " Python 3.7+:
   noremap <F8> :%s/\(^.*\)\(breakpoint()\)\(.*$\)/\1# \2\3/ge<CR><C-O>:echo 'breakpoint: COMMENTED'<CR>
```
This works wherever you are in the buffer and leaves you on the line where the command is executed. The only change that is being made is to add `# ` right before `import pdb; pdb.set_trace()`, keeping the indentation intact.

#### Uncommenting all the lines where the debugging statement is found 
```vim
   " Uncomment all lines where 'pdb.set_trace()' is found
   nnoremap <F9> :%s/\(^.*\)\(# \)\(import pdb; pdb.set_trace()\)\(.*$\)/\1\3\4/ge<CR><C-O>:echo 'pdb debugging: UNCOMMENTED'<CR>

   " Python 3.7+:
   nnoremap <F9> :%s/\(^.*\)\(# \)\(breakpoint()\)\(.*$\)/\1\3\4/ge<CR><C-O>:echo 'breakpoint: UNCOMMENTED'<CR>
```
Working just like for commenting, this mapping removes only the `# ` part before the `import` statement and keeps you where the command is being executed.


#### Removing all traces of pdb.set_trace()
```vim
   " Remove all lines where the 'pdb.set_trace()' debugging statement is found
   nnoremap <F10> :%g/^.*import pdb; pdb.set_trace().*$/d<CR><C-O>:echo 'pdb debugging: REMOVED'<CR>

   " Python 3.7+:
   nnoremap <F10> :%g/^.*breakpoint().*$/d<CR><C-O>:echo 'breakpoint: REMOVED'<CR>
```
Like with commenting and uncommenting, you are left at the same location in the current buffer... Now with a code hopefully at least as good as when you started debugging!


### Add TODO/FIXME comment to the end of the line and place into insert mode
```vim
    map <leader>t <Esc>A  # TODO: <Esc>A
    map <leader>f <Esc>A  # FIXME: <Esc>A
```


### Find next TODO/FIXME comment in current buffer
```vim
    map <leader>T <Esc>/\C# TODO: <CR>
    map <leader>F <Esc>/\C# FIXME: <CR>
```


### Simple abbreviations for the main Python keywords
```vim
   " Abbreviations
   ab ass assert
   ab bk break
   ab cl class
   ab con continue
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
```


### Search for previous/next function
```vim
   nnoremap <F2> ?def <CR>
   nnoremap <F3> /def <CR>
```

### Display text in red over column limit

The function can easily be toggled (like shown on the last line). Here, it is set to go red from position 81 and above.
```vim
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
   nnoremap <F3> :call ToggleH()<CR>
```


### Display Python help for word under cursor
```vim
   nnoremap <buffer> <F12> :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>
```
This opens a new window where you can move just like in VIM with a complete definition of the keyword you were looking for. When closing the help window, you are back exactly to where you left off.


### Quickly toggle all folds in current buffer

This will greatly compact the visible length of the buffer and allows for quick movements. This will apply a toggle globally in the current buffer:
```vim
" Use leader + space to toggle all folds
nnoremap <expr> <leader><space> &foldlevel ? 'zM' :'zR'
```

To toggle a selected fold:
```vim
" Use space to toggle current fold
nnoremap <space> za
```

This coupled with strong visual feedback for folds becomes very useful to split the buffer in smaller working units. The following combination of colors works great with the color scheme `solarized`:
```vim
" Make the folds look pretty and pretty visible
highlight Folded ctermfg=black ctermbg=white
```

Those settings apply to a terminal. If working in a GUI version of Vim/Neovim:
```vim
highlight Folded guifg=black guibg=white
```
