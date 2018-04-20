# better-vim-experience: Little tips and tricks for VIM

## Table of Contents

- **[General Tips And Tricks](#general-tips-and-tricks)**
  - [Display the main help file in a new tab](#display-the-main-help-file-in-a-new-tab)
  - [Remove all whitespace at the end of every line in the file](#remove-all-whitespace-at-the-end-of-every-line-in-the-file)
  - [Access command mode more easily by swapping colon with semi-colon](#access-command-mode-more-easily-by-swapping-colon-with-semi-colon)
  - [Add newline without leaving normal mode and stay on current line](#add-newline-without-leaving-normal-mode-and-stay-on-current-line)
  - [Completions with Ctrl+x (eXpand)](#completions-with-ctrlx-expand)

- **[Programming in Python](#programming-in-python)**
  - [Quick and effective way to use PDB (Python Debugger)](#quick-and-effective-way-to-use-pdb-python-debugger)
    - [Adding the debugging statement](#adding-the-debugging-statement)
    - [Commenting all the lines where the debugging statement is found](#commenting-all-the-lines-where-the-debugging-statement-is-found)
    - [Uncommenting all the lines where the debugging statement is found](#uncommenting-all-the-lines-where-the-debugging-statement-is-found)
    - [Removing all traces of pdb.set_trace()](#removing-all-traces-of-pdbset_trace)
  - [Simple abbreviations for the main Python keywords](#simple-abbreviations-for-the-main-python-keywords)
  - [Search for previous/next function](#search-for-previousnext-function)
  - [Display text in red over column limit](#display-text-in-red-over-column-limit)
  - [Display Python help for word under cursor](#display-python-help-for-word-under-cursor)

## General Tips And Tricks

This is obviously far from being an exhaustive list, but those are some tips and tricks that I find really useful on a daily basis.

---
### Display the main help file in a new tab

```vim
   " DISPLAY HELP IN NEW TAB
   nnoremap <leader>h :tabnew<CR>:help<CR><C-w><C-w>:quit<CR>
```
This is useful to maximize the help window and read more easily. You can quickly switch back to the next tab with the keystrokes `gt` (especially useful if you don't have any other tab opened). Simply do `:q` on the help tab and you're back to work! 


---
### Remove all whitespace at the end of every line in the file

This also works for lines that only contain whitespace. It keeps the line in place but remove the extra space(s) or tab(s) that might have been left by accident.
```vim
   noremap <F5> :%s/\s\+$//<CR>:echo 'all whitespace removed.'<CR>
```


---
### Access command mode more easily by swapping colon with semi-colon

If you (almost) never use the key `;`, you can swap it with `:` to get to the command line more easily. You can still continue to use `;` by typing `:`.
```vim
   nnoremap ; :
   nnoremap : ;
```

---
### Add newline without leaving normal mode and stay on current line 
```vim
   nnoremap <C-J> o<Esc>
   nnoremap <C-K> O<Esc>
```

### Completions with Ctrl+x (eXpand)
- `Ctrl + x  Ctrl + p` will find a word and suggest a list to complete it. If there's only a match, it is automatically inserted. 
- `Ctrl + x  Ctrl + l` will complete a whole line automatically if there's only one match, else it will suggest a list.


## Programming in Python

---
### Quick and effective way to use PDB (Python Debugger)

I have found that using **pdb.set_trace()** is quite useful to debug a program and I now use the following mappings in **~/.vimrc** to facilitate the work.


---
#### Adding the debugging statement
```vim
   " ADD PDB.SET_TRACE() TO ALLOW FOR DEBUGGING
   nnoremap <F7> :s/\(^\s*\)\(.*$\)/\1import pdb; pdb.set_trace\(\)\r\1\2/<CR>:echo 'pdb debugging: ADDED'<CR>
```
This adds a new line with the content `import pdb; pdb.set_trace()` above the current line with the same amount of leading whitespace as the line where the cursor is located. This is how the following snippet of code is affected (the cursor should be located on the line `string_input = input()`):
```python
   def main_execution() -> str:
       string_input = input()
       return compare_scores(string_input)
```
It then becomes:
```python
   def main_execution() -> str:
       import pdb; pdb.set_trace()
       string_input = input()
       return compare_scores(string_input)
```


---
#### Commenting all the lines where the debugging statement is found
```vim
   " COMMENT ALL LINES WHERE 'PDB.SET_TRACE()' IS FOUND
   nnoremap <F8> :%s/\(^.*\)\(import pdb; pdb.set_trace()\)\(.*$\)/\1# \2\3/ge<CR><C-O>:echo 'pdb debugging: COMMENTED'<CR>
```
This works wherever you are in the file and leaves you on the line where the command is executed. The only change that is being made is to add `# ` right before `import pdb; pdb.set_trace()`, keeping the indentation intact.


---
#### Uncommenting all the lines where the debugging statement is found 
```vim
   " UNCOMMENT ALL LINES WHERE 'PDB.SET_TRACE()' IS FOUND
   nnoremap <F9> :%s/\(^.*\)\(# \)\(import pdb; pdb.set_trace()\)\(.*$\)/\1\3\4/ge<CR><C-O>:echo 'pdb debugging: UNCOMMENTED'<CR>
```
Working just like for commenting, this mapping removes only the `# ` part before the `import` statement and keeps you where the command is being executed.


---
#### Removing all traces of pdb.set_trace()
```vim
   " REMOVE ALL LINES WHERE THE 'PDB.SET_TRACE()' DEBUGGING STATEMENT IS FOUND
   nnoremap <F10> :%g/^.*import pdb; pdb.set_trace().*$/d<CR><C-O>:echo 'pdb debugging: REMOVED'<CR>
```
Like with commenting and uncommenting, you are left at the same location in the current file... now with a code hopefully at least as good as when you started debugging!


---
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

---
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


---
### Display Python help for word under cursor
```vim
   nnoremap <buffer> <F12> :<C-u>execute "!pydoc3 " . expand("<cword>")<CR>
```
This opens a new window where you can move just like in VIM with a complete definition of the keyword you were looking for. When closing the help window, you are back exactly to where you left off.
