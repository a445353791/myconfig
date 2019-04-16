""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on              " 侦测文件类型
syntax enable            " 开启语法高亮功能
syntax on                " 自动语法高亮
set showcmd      " 使输入的命令显示出来
set nobackup

"样式
set title
set encoding=utf-8       " 设置字符集
set t_Co=256             " 开启256色支持
set number               " 开启行号显示
set cursorline           " 高亮显示当前行
set laststatus=2
colorscheme molokai

"区域分割
set splitbelow
set splitright

"鼠标
set mouse=a
set selection=exclusive

"其他
set nocompatible  " 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限 
set helplang=cn   " 显示中文帮助
set scrolloff=3   
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编辑
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set clipboard+=unnamed   " 共享剪切板
set backspace=2          " 增强delete键的作用
set noexpandtab    " 不用空格代替制表符
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PEP8风格(python)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set textwidth=79
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch            " 高亮显示搜索结果
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 快捷键
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 切换分割布局
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"设置NerdTree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>

" 映射全选+复制  ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY

" 选中状态下 Ctrl+c 复制
map <C-c> y


"按F5自动执行代码
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    exec "!clear"
    exec "!time python3 %"
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
  elseif &filetype == 'mkd'
    exec "!~/.vim/markdown.pl % > %.html &"
    exec "!firefox %.html &"
  endif
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配置Vundle和Plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " required
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'          " ctrl+p 查找文件
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required

"YouCompleteMe的配置
set cot=longest,preview,menu
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前
let g:ycm_server_python_interpreter='/usr/local/bin/python3.7'
let g:ycm_filetype_whitelist = { 'python': 1,'java':1 }   "设置youCompleteMe白名单,通过:set ft? 来取文件类型
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示
let g:ycm_min_num_of_chars_for_completion=2     " 从第2个键入字符就开始
let g:ycm_min_num_identifier_candidate_chars = 4  " 补全框中单词最小字符数
let g:ycm_seed_identifiers_with_syntax=1      " 将这个关键子送到语法数据库
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_cache_omnifunc=0 " 禁止缓存匹配项,每次都重新生成匹配

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配置python操作
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设置python文件头
autocmd BufNewFile *py exec ":call SetPythonTitle()"
func SetPythonTitle()
  call setline(1,"#!/usr/bin/env python")
  call append( line("."),"#-*- coding: utf-8 -*-" )
  call append(line(".")+1," ")
  call append(line(".")+2, "\# File Name: ".expand("%"))
  call append(line(".")+3, "\# Author: 刘劲松")
  call append(line(".")+4, "\# mail: YourEmail")
  call append(line(".")+5, "\# Created Time: ".strftime("%Y-%m-%d",localtime()))
endfunc
