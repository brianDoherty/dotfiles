set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'ervandew/supertab'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mhinz/vim-startify'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tommcdo/vim-fubitive'
Plugin 'tpope/vim-fugitive'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

call vundle#end()
filetype plugin indent on

" Gotta break the habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Searching
set ignorecase
set smartcase
set incsearch

let mapleader = "\<Space>"

" Tmux navigator
nnoremap <silent> <Leader>h :TmuxNavigateLeft<cr>
nnoremap <silent> <Leader>j :TmuxNavigateDown<cr>
nnoremap <silent> <Leader>k :TmuxNavigateUp<cr>
nnoremap <silent> <Leader>l :TmuxNavigateRight<cr>
"nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>wqa :wqa<CR>
nnoremap <Leader>vs :vsp 
nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>coffee :CoffeeCompile<CR>
nnoremap <Leader>jj :NERDTreeToggle<CR>
nnoremap <Leader>nn :set invnumber<CR> 
" Remove highlight on searched words
nnoremap <Leader>c :nohl<CR>:set nospell<CR>
" Open command window to autocomplete a search
nnoremap <Leader>f /<C-F>i
nnoremap <Leader>ff :Ag 

nnoremap <Leader>k <C-W>k
nnoremap <Leader>j <C-W>j
nnoremap <Leader>h <C-W>h
nnoremap <Leader>l <C-W>l

nnoremap <Leader>b :!jq .<CR>

nnoremap <Leader>s :setlocal spell spelllang=en_us<CR>

" Coffee Script Configuration
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Syntax highlighting + indentation
syntax on
filetype plugin indent on
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
" Highlight character in 81st column to warn about lines too long
:2mat ErrorMsg '\%81v.'

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

autocmd FileType coffee 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2
autocmd FileType js 
  \ setlocal shiftwidth=2 |
  \ setlocal tabstop=2

" Toggle paste mode, to not auto indent text when pasting from clipboard
set pastetoggle=<F2>

" Copy and paste to clipboard when yanking text
set clipboard=unnamed

" Make backspace work like most apps
set backspace=2

" Line number display
:set number
:set ruler
:nmap <C-N><C-N> :set invnumber<CR>
highlight ColorColumn ctermbg=255 guibg=#ECECEC

" match ErrorMsg '\%>80v.\+'

" Nerdtree file browser plugin config
map <C-j><C-j> :NERDTreeToggle<CR>

" Git Fugitive plugin config
map gd :Gdiff<CR>
map gs :Gstatus<CR>
map gb :Gblame<CR>
map gh :Gbrowse<CR>
let g:fugitive_github_domains = ['https://github.roving.com']

" CSS highlighting stuff
nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>

" Search as words are typed, highlight them
:set incsearch
:set hlsearch
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Control + L + P Config
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" Ag configuration
let g:ag_working_path_mode="r"

" Run a command and restore search and cursor position.
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Indent Guides http://vimawesome.com/plugin/indent-guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=7
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=8

" airline config
set laststatus=2
let g:airline_powerline_fonts = 1

" Fix performance issues with highlighting
autocmd BufWinLeave * call clearmatches()

" Startify config
let g:startify_custom_header =
      \ map(split(system('fortune | cowsay -f ghostbusters'), '\n'), '"   ". v:val') + ['','']

" Linting
let g:syntastic_javascript_checkers = ['eslint']
