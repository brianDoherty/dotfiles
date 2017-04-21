set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Plugin 'galooshi/vim-import-js' " Must also npm install -g import-js
Plugin 'Chun-Yang/vim-action-ag'
Plugin 'Shougo/deoplete.nvim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'elzr/vim-json'
Plugin 'ervandew/supertab'
Plugin 'gregsexton/gitv'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mhinz/vim-startify'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'neomake/neomake'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Bundle 'wellle/tmux-complete.vim'
Plugin 'carlitux/deoplete-ternjs'

call vundle#end()
filetype plugin indent on

" Use Deoplete.
let g:deoplete#enable_at_startup = 1

" Let <Tab> also do completion
inoremap <silent> <expr> <Tab> utils#tabComplete()

"===========

" Linting
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
" Always make neomake lint column present even if there are no errors
augroup mine
    au BufWinEnter * sign define mysign
    au BufWinEnter * exe "sign place 1337 line=1 name=mysign buffer=" . bufnr('%')
augroup END
let g:neomake_warning_sign = {
  \ 'text': '>>',
  \ }
let g:neomake_error_sign = {
  \ 'text': '>>',
  \ }

" Gotta break the habit
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Searching
set ignorecase
set smartcase
set incsearch
" Type "//" after visually selecting text to search the rest of the buffer for
" it
vnoremap // y/<C-R>"<CR>
" use * to search selected text in visual mode
vmap * <Plug>AgActionVisual
" use * to search current word in normal mode
nmap * <Plug>AgActionWord


let mapleader = "\<Space>"

" Replace last searched word. Use something like viw//<Leader>r
map <Leader>r :%s///g<left><left>

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
nnoremap <Leader>ff :Ag<space>
nnoremap <Leader>jf :NERDTreeFind<CR>

nnoremap <Leader>k <C-W>k
nnoremap <Leader>j <C-W>j
nnoremap <Leader>h <C-W>h
nnoremap <Leader>l <C-W>l

nnoremap <Leader>b :!jq .<CR>

nnoremap <Leader>s :setlocal spell spelllang=en_us<CR>
nnoremap <Leader>ss z=

nnoremap <Leader>i :ImportJSWord<CR>
nnoremap <Leader>ii :ImportJSFix<CR>

" Easier folding
nnoremap zz za

" Coffee Script Configuration
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

autocmd BufNewFile,BufReadPost *.jsfl setl shiftwidth=2 expandtab syntax=js

" Syntax highlighting + indentation
syntax on
filetype plugin indent on
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
" Highlight character in 121st column to warn about lines too long
:2mat ErrorMsg '\%121v.'

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
autocmd FileType json
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
map gd :Gvdiff<CR>
map gs :Gstatus<CR>
map gb :Gblame<CR>
map gh :Gbrowse<CR>
let g:fugitive_github_domains = ['https://github.cainc.com']
" Used to walk through history of file
map gl :Gllog<CR>:lwindow<CR>
map gq :Gedit<CR>
map gn :lnext<CR>
map gp :lprev<CR>

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

" jsdoc plugin configuration
let g:jsdoc_underscore_private = 1
let g:jsdoc_enabled_es6 = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
nmap <silent> <Leader>d <Plug>(jsdoc)

" Use tern_for_vim.
let g:tern#command = ["$(npm -g bin)/tern"]
let g:tern#arguments = ["--persistent"]
let g:tern_request_timeout = 1

" JSON plugin
let g:vim_json_syntax_conceal = 0

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

:set wildmenu

" Colors
hi DiffAdd      ctermbg=28 ctermfg=15
hi DiffDelete   ctermbg=9 ctermfg=15
hi DiffChange   ctermbg=237 ctermfg=15
hi DiffText     ctermbg=68 ctermfg=15

hi Visual ctermbg=239 ctermfg=white
hi Search ctermbg=yellow ctermfg=black
hi TabLineSel   ctermfg=White  ctermbg=239  cterm=NONE
hi TabLine   ctermfg=247  ctermbg=235  cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=233     cterm=NONE
hi SignColumn ctermbg=233

hi notesInProgress ctermfg=yellow

hi NeomakeError ctermbg=red ctermfg=white
hi NeomakeErrorSign ctermbg=red ctermfg=white
hi NeomakeWarningSign ctermbg=yellow ctermfg=black
hi NeomakeWarning ctermbg=yellow ctermfg=black

