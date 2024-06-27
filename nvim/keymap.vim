" key map

" mapleader
let mapleader = ";"

" Switching Panes
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" 快速打开vimrc文件
nnoremap <leader>v :vs $MYVIMRC<CR>
" 重读vimrc文件
nnoremap <leader>sv :source $MYVIMRC<CR>
" 快速输入命令
nnoremap <space> :
" 切换buffer
nnoremap <C-B> :bp<CR>
nnoremap <C-F> :bn<CR>
