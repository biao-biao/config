execute pathogen#infect()
set nocompatible
syntax on        "this is needed to see syntax
colorscheme solarized "set theme in ./vim/colors folder
set background=dark "makes it easier to read with black background
set encoding=utf-8
set fileencoding=utf-8
set ls=2            " allways show status line
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set cursorline
filetype plugin on
set ruler           " show the cursor position all the time
set visualbell t_vb=    " turn off error beep/flash
set ignorecase        "ignore case while searching
set number            "put numbers on side
set t_Co=256          "set color
set tabstop=4
set shiftwidth=4
set autoindent
set noswapfile
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

"mark.vim configration
map <F3> \n\m
map <F5> :!clear; cols=`tput cols`; eval printf \%.s* {1..$cols}; echo; % 
"imap <Tab> <C-n>
"window atuo-resize
set winheight=5
set winminheight=5
set winheight=999

"jedi-vim configration
"let g:jedi#usages_command = "0"
let g:jedi#usages_command = "<leader>u"
autocmd FileType python setlocal completeopt-=preview

let perlpath=".,,"
set makeprg=perl\ -c\ %\ $*
set makeprg=gcc\ -o\ %:r:p\ %
