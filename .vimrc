hi comment ctermfg=6
set noshowmode
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2
set hlsearch
set laststatus=2

set showcmd
set cursorline
set ignorecase
set showmatch
set number
set ruler

" set noic
" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
