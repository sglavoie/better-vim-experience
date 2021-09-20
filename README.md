# Tips and tricks for [Vim](https://github.com/vim/vim) / [Neovim](https://github.com/neovim/neovim)

[Link to up-to-date current Neovim configuration file](https://github.com/sglavoie/dotfiles/tree/master/.config/nvim).

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [General Tips And Tricks](#general-tips-and-tricks)
  * [Display the main help buffer in a new tab](#display-the-main-help-buffer-in-a-new-tab)
  * [Remove all whitespace at the end of every line in the buffer](#remove-all-whitespace-at-the-end-of-every-line-in-the-buffer)
  * [Add newline without leaving normal mode and stay on current line](#add-newline-without-leaving-normal-mode-and-stay-on-current-line)
  * [Completions with Ctrl+x (eXpand)](#completions-with-ctrlx-expand)

<!-- vim-markdown-toc -->

---

## General Tips And Tricks

This is obviously far from being an exhaustive list: those are some tips and tricks that I have found useful.

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

### Add newline without leaving normal mode and stay on current line

```vim
   nnoremap <M-o> o<Esc>
   nnoremap <M-S-O> O<Esc>
```

### Completions with Ctrl+x (eXpand)

Those are the combinations that I tend to use the most.

- `Ctrl + x  Ctrl + p` will find a word and suggest a list to complete it. If there's only a match, it is automatically inserted.
- `Ctrl + x  Ctrl + l` will complete a whole line automatically if there's only one match, else it will suggest a list.
- `Ctrl + x  Ctrl + k` will complete a word from the dictionary.
- `Ctrl + x  Ctrl + ]` will complete a word from available tags.
