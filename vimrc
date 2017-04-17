set encoding=utf-8

execute pathogen#infect()

syntax enable

" Show line numbers
set number
set relativenumber

" Refresh any files that haven't been edited by vim
set autoread

autocmd BufReadPre,BufNewFile * let b:did_ftplugin = 1
filetype plugin on

" Fixes odd backspacing issues
set backspace=indent,eol,start

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Strip trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"" Margins
"highlight OverLength ctermbg=darkred ctermfg=white guibg=#000000
"match OverLength /\%81v.\+/

"" Searching
set hlsearch                        " highlight matches
set incsearch                       " start searching before pressing <ENTER>

"" Appearance
"set background=dark
set t_Co=256                        " 256 colors in terminal

colorscheme badwolf

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Use one space, not two, after punctuation.
set nojoinspaces

set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set cursorline

set colorcolumn=80,100

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" https://github.com/junegunn/fzf
set rtp+=/usr/local/opt/fzf

let g:gitgutter_sign_column_always = 1

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" NERDtree
"autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['node_modules']

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]node_modules$',
  \ }
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'

" Syntastic
"let g:syntastic_javascript_checkers = ['jscs']
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

