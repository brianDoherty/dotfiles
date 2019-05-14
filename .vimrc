set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Chun-Yang/vim-action-ag'
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'elzr/vim-json'
Plugin 'gregsexton/gitv'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mhinz/vim-startify'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mxw/vim-jsx'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'
Plugin 'neoclide/coc.nvim'
Plugin 'styled-components/vim-styled-components'

call vundle#end()
filetype plugin indent on

" Use Deoplete.
let g:deoplete#enable_at_startup = 1

" Let <Tab> also do completion
"inoremap <silent> <expr> <Tab> utils#tabComplete()

"===========
let mapleader = "\<Space>"

" Linting
let g:ale_sign_column_always = 1
let airline#extensions#ale#error_symbol = '✗'
let airline#extensions#ale#warning_symbol = '◆'
let g:ale_open_list = 'on_save'
let g:airline#extensions#ale#enabled = 1
let g:ale_list_window_size = 8
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['json'] = ['jq']

let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
nnoremap <silent> <Leader>e :ALENext<cr>

"let g:ale_change_sign_column_color = 1
"
"" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"<Paste>
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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

nnoremap <C-j> :let g:ctrlp_default_input = expand('<cword>') \|
    \ call ctrlp#init(0) \| unlet g:ctrlp_default_input<CR><CR>
nnoremap <Leader>fr gd/'<CR>g_hh<C-j><esc>

nnoremap <Leader>k <C-W>k
nnoremap <Leader>j <C-W>j
nnoremap <Leader>h <C-W>h
nnoremap <Leader>l <C-W>l

nnoremap <Leader>b :!jq .<CR>

nnoremap <Leader>s :setlocal spell spelllang=en_us<CR>
nnoremap <Leader>ss z=

noremap ; :ALEFix<cr>

" Easier folding
nnoremap zz za

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" Coffee Script Configuration
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

autocmd BufNewFile,BufReadPost *.jsfl setl shiftwidth=2 expandtab syntax=js

autocmd BufEnter * EnableStripWhitespaceOnSave

" Syntax highlighting + indentation
syntax on
" colorscheme monokai
filetype plugin indent on
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
let g:jsx_ext_required = 0
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

" Git Fugitive plugin config
map <Leader>gd :Gvdiff<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gh :Gbrowse<CR>
let g:fugitive_github_domains = ['https://git.hubteam.com']
" Used to walk through history of file
map <Leader>gl :Gllog<CR>:lwindow<CR>
map <Leader>gq :Gedit<CR>
map <Leader>gn :lnext<CR>
map <Leader>gp :lprev<CR>

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
set background=light

set termguicolors
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
hi DiffAdd      ctermbg=28 ctermfg=15
hi DiffDelete   ctermbg=9 ctermfg=15
hi DiffChange   ctermbg=237 ctermfg=15
hi DiffText     ctermbg=68 ctermfg=15
hi ALEError ctermbg=red ctermfg=white
hi ALEWarning ctermbg=yellow ctermfg=white

hi Visual ctermbg=239 ctermfg=white
hi Search ctermbg=green ctermfg=black
hi TabLineSel   ctermfg=White  ctermbg=239  cterm=NONE
hi TabLine   ctermfg=247  ctermbg=235  cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=233     cterm=NONE
hi SignColumn ctermbg=233

hi notesInProgress ctermfg=yellow

hi DiffAdd      guibg=limegreen guifg=white
hi DiffDelete   guibg=red guifg=white
hi DiffChange   guibg=cyan guifg=white
hi DiffText     guibg=darkcyan guifg=white
hi ALEError guibg=red guifg=white
hi ALEWarning guibg=yellow guifg=white

hi Visual guibg=grey guifg=white
hi Search guibg=limegreen guifg=black
hi IncSearch guibg=green guifg=white
hi TabLineSel   gui=bold guifg=White  guibg=239
hi TabLine   guifg=white  guibg=grey
hi TabLineFill  guifg=Black  guibg=grey
hi SignColumn guibg=233
hi Pmenu guibg=grey guifg=white
hi PmenuSel gui=bold guibg=darkgrey guifg=white

hi notesInProgress guifg=yellow
hi myThis gui=italic guibg=orange guifg=white
hi String gui=none guifg=red
hi Special gui=italic guifg=red
hi jsStorageClass gui=bold guifg=green
hi xmlAttrib guifg=green
hi xmlTagName gui=bold guifg=skyblue
hi xmlEndTag gui=bold guifg=skyblue
hi Statement guifg=darkgoldenrod
hi CursorLine gui=bold guibg=grey guifg=white

syn match   myTodo   contained   "\<\(TODO\|FIXME\):"
hi def link myTodo Todo

map <Leader>sh :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


nmap <silent> gd <Plug>(coc-definition)
