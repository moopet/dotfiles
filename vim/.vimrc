"{{{ Plugins

"{{{ Auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  let vimdir = expand("~/.vim")

  if !isdirectory(vimdir)
    call mkdir(vimdir)
  endif

  let autoloaddir = expand("~/.vim/autoload")

  if !isdirectory(autoloaddir)
    call mkdir(autoloaddir)
  endif

  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  autocmd VimEnter * PlugInstall
endif
"}}}

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-templates'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gorodinskiy/vim-coloresque' " better than colorizer because it works with Vim 7.3 :)
Plug 'itchyny/lightline.vim'
Plug 'kshenoy/vim-signature'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'

"{{{ Colorschemes
Plug 'morhetz/gruvbox'
"}}}

"{{{ Currently unused but good to keep as bookmarked

"Plug 'junegunn/vim-emoji'
"Plug 'chrisbra/vim-diff-enhanced'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'evanmiller/nginx-vim-syntax'
"Plug 'joonty/vdebug'
"Plug 'mbbill/undotree'
"Plug 'sodapopcan/vim-twiggy'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-surround'
"Plug 'Valloric/MatchTagAlways'
"Plug 'Valloric/YouCompleteMe'
"Plug 'vim-scripts/showcolor.vim'
"Plug 'vim-scripts/YankRing.vim'
"}}}

call plug#end()
"}}}

"{{{ Common settings
let mapleader = "\<Space>"
let maplocalleader = "\\"

let g:loaded_getscriptPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_rrhelper = 1
let g:gitgutter_max_signs = 1000
let g:SignatureMarkTextHLDynamic = 1

" examples of good indentLine_chars: ¦ ┆ │ ⎸ ▏
let g:indentLine_char = '┊'
let g:indentLine_enabled = 0

syntax on

" Searching
set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase
nnoremap / /\v
xnoremap / /\v

" Layout and indenting
set autoindent
set cursorline
set expandtab
set formatoptions=tcqrn1j
set scrolloff=2
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=80
set wrap

set dictionary+=/usr/share/dict/words
set diffopt+=iwhite
set encoding=utf-8
set fillchars=diff:⣿
set hidden
" set lazyredraw
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak="↪\ "
set splitbelow
set splitright

set autoread
set autowrite
set backspace=indent,eol,start

set laststatus=2
set linebreak
set nolist
set number
set ruler
set title
set ttyfast
set updatetime=100

set timeout timeoutlen=3000 ttimeoutlen=100

" matching
set wildignore+=.hg,.git,.svn,*.orig
set wildignore+=.DS_Store,thumbs.db,__MACOSX
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.ico
set wildignore+=*.flv,*.mp4,*.webm,*.ogv,*.ogg,*.mp3,*.fla,*.swf
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc,*.lib,*.so
set wildignore+=*.sw?
set wildignore+=*.bak,*.out,*.old,*.oot,*.ffs,*.wtf
set wildignore+=.o,.info,.aux,.idx,.out,.toc
set wildignore+=*.zip,*.rar,*.r00,*.gz,*.bat
set wildignore+=migrations,fixtures

set wildignorecase
set wildmenu
" sane (bash-like) tab expansion
set wildmode=longest,list

inoremap <F2> <esc>:set list!<CR>i
nnoremap <F2> :set list!<CR>

inoremap <F3> <esc>:set paste!<CR>i
nnoremap <F3> :set paste!<CR>

nnoremap <F4> :IndentLinesToggle<CR>

" Completion
set completeopt=longest,menuone,preview

autocmd BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix" || &buftype=="nofile"
    " if this window is last on screen quit without warning
    if winnr('$') < 2
      quit!
    endif
  endif
endfunction

function! ListTodo()
  vimgrep TODO **/*.py
  cw
endfunction
:command! Todo call ListTodo()

" if we've opened a file and don't have the required root permissions...
cmap w!! w !sudo tee % >/dev/null
"}}}

"{{{ Plugin-specific settings
let g:ackprg = 'ag --nogroup --nocolor --column'
"}}}

"{{{ GVim settings
if has('gui_running')
  set guioptions=e
  set guifont=Monospace\ 9
endif
"}}}

"{{{ Mac fixes
" Macs are dumb and crontab -e fails with "temp file must be edited in place"
set backupskip=/tmp/*,/private/tmp/*
"}}}

"{{{ Autocomplete
set omnifunc=syntaxcomplete#Complete
"}}}

" Quick way to remember to paste the last yanked item
nnoremap yp "0p

" On the mac I kind of hate scroll shifiting the whole terminal, so...
set mouse=a

" Keep visual selection while indenting.
xnoremap < <gv
xnoremap > >gv

" Add more robustness to <c-l>
" https://github.com/mhinz/vim-galore#saner-ctrl-l
nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Unipoo.
iabbr :poo: 💩
iabbr :tm: ™

"{{{ Grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor
  let g:ack_default_options = " --smart-case --type-add=php=.tpl,.inc,.module,.install --type-set=csv=.csv --type-set=ini=.ini,.cfg,.rc --type-set=min=.min.js --type-set=vim=.vim --type-set=log=.log --type-set=test=.test --type-set=sass=.sass,.scss --type-set=scss=.sass,.scss --nomin --notest --nocsv --nosql --ignore-dir=var --ignore-dir=nbproject --ignore-dir=cache --ignore-dir=migrations --ignore-dir=webroot/static"
endif
"}}}

" Persistent undo                                                           
if has('persistent_undo')
  let undodir = expand("~/.vim/undo")
  if !isdirectory(undodir)
    call mkdir(undodir)
  endif
  set undodir=~/.vim/undo/
  set undofile
endif

let backupdir = expand("~/.vim/backups")
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif
set backupdir=~/.vim/backups/
set backup
set noswapfile

" Resize splits when the window is resized
augroup neat_resizing
  autocmd!
  autocmd VimResized * exe "normal! \<c-w>="
augroup END

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc><right>

" Make K do the same as J just in the opposite direction.
" I don't usually use the default K action (lookup keyword).
nnoremap K kJ

" Emacs bindings
cnoremap <c-a> <home>
cnoremap <c-e> <end>
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

"{{{ Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': '', 'right' : '' },
      \ 'subseparator': { 'left': '', 'right' : '' },
      \ }
"}}}

"{{{ Colorschemes
" Regardless of the colorscheme I'm running, I always want certain things
function! CustomColorscheme()
  set background=dark
  let g:gruvbox_contrast_dark = 'hard'
  silent! colorscheme gruvbox

  highlight! link Exception Keyword

  if has("&colorcolumn")
    set colorcolumn=+1
    highlight ColorColumn ctermbg=52
  endif

  " Highlight VCS conflict markers
  match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

  " Lets us use italics.
  set t_ZH=[3m
  set t_ZR=[23m

  " Customise things so there are nice transparent backgrounds.
  highlight Search cterm=NONE ctermbg=yellow ctermfg=black
  highlight Normal ctermbg=NONE
  highlight NonText ctermbg=NONE
  highlight LineNr ctermbg=NONE
  highlight Visual cterm=NONE ctermbg=162 ctermfg=white
  highlight CursorLine ctermbg=232
  highlight SignColumn ctermbg=232
  highlight GitGutterAdd ctermbg=232
  highlight GitGutterChange ctermbg=232
  highlight GitGutterDelete ctermbg=232
  highlight SignatureMarkText ctermbg=232 ctermfg=14
  highlight Comment cterm=italic
  highlight Folded ctermbg=black
  highlight SpellBad cterm=underline,italic ctermfg=darkred
endfunc

function! ToggleBackground()
  if &background == 'dark'
    set background=light
  else
    set background=dark
    call CustomColorscheme()
  endif
endfunc

" Show syntax highlighting groups for word under cursor
nnoremap <leader>ss :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nnoremap <f5> :call ToggleBackground()<cr>

call CustomColorscheme()
"}}}

nnoremap <silent> <BS> :nohlsearch<CR>

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on * or #
nnoremap # #<c-o>
nnoremap * *<c-o>

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

nnoremap <leader>u :UndotreeToggle<CR>

" select the last changed (or pasted) text, and the visual mode will be the same
" as was last used http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

"{{{ Django
augroup ft_django
  autocmd!

  autocmd BufNewFile,BufRead urls.py           setlocal nowrap
  autocmd BufNewFile,BufRead urls.py           normal! zR
  autocmd BufNewFile,BufRead dashboard.py      normal! zR
  autocmd BufNewFile,BufRead local_settings.py normal! zR

  autocmd BufNewFile,BufRead admin.py     setlocal filetype=python.django
  autocmd BufNewFile,BufRead urls.py      setlocal filetype=python.django
  autocmd BufNewFile,BufRead models.py    setlocal filetype=python.django
  autocmd BufNewFile,BufRead views.py     setlocal filetype=python.django
  autocmd BufNewFile,BufRead *_tags.py    setlocal filetype=python.django
  autocmd BufNewFile,BufRead functions.py setlocal filetype=python.django
  autocmd BufNewFile,BufRead settings.py  setlocal filetype=python.django
  autocmd BufNewFile,BufRead settings.py  setlocal foldmethod=marker
  autocmd BufNewFile,BufRead forms.py     setlocal filetype=python.django
augroup END
"}}}

augroup ft_css
  autocmd!

  xnoremap <leader>i :s/\v\s+!important;/;/g<cr>gv:s/\v;/ !important;/g<cr>:nohl<cr>
  xnoremap <leader>I :s/\v\s+\!important;/;/g<cr>:nohl<cr>

  autocmd BufNewFile,BufRead *.less setlocal filetype=less
  autocmd BufNewFile,BufRead *.scss setlocal filetype=scss

  autocmd Filetype scss,less,css setlocal foldmarker={,}
  autocmd Filetype scss,less,css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd Filetype scss,less,css setlocal iskeyword+=-

  " Use <leader>S to sort properties.  Turns this:
  "
  "     p {
  "         width: 200px;
  "         height: 100px;
  "         background: red;
  "
  "         ...
  "     }
  "
  " into this:

  "     p {
  "         background: red;
  "         height: 100px;
  "         width: 200px;
  "
  "         ...
  "     }
  autocmd BufNewFile,BufRead *,scss,*.less,*.css nnoremap <buffer> <leader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

  " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
  " positioned inside of them AND the following code doesn't get unfolded.
  autocmd BufNewFile,BufRead *.scssm*.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

"{{{ Quickfix window
augroup ft_quickfix
  autocmd!
  autocmd Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap
augroup END
"}}}

"{{{ Vim
augroup ft_vim
  autocmd!

  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim setlocal foldlevel=0
  autocmd FileType help setlocal textwidth=78
  autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
"}}}

"{{{ Git
augroup git
  autocmd!

  autocmd BufNewFile,BufRead .git/index setlocal nolist
augroup END
"}}}

"{{{ Nginx
augroup ft_nginx
  autocmd!

  autocmd BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
  autocmd BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
  autocmd BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
  autocmd BufRead,BufNewFile vhost.nginx                            set ft=nginx

  autocmd FileType nginx setlocal foldmethod=marker foldmarker={,}
augroup END
"}}}

" Motion for "next/last object". For example, "din(" would go to the next "()"
" pair and delete its contents.

onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
    let c = "("
  elseif c ==# "B"
    let c = "{"
  elseif c ==# "d"
    let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" I don't like having :w etc. scattered in non-saved files
" and for some reason my setup fucks up and sometimes ignores <esc>
inoremap :w<cr> <esc>:w<cr>
inoremap :wq<cr> <esc>:wq<cr>
inoremap :x<cr> <esc>:x<cr>

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

noremap <F1> <nop>
nnoremap j gj
nnoremap k gk

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"{{{ Ctags
let GtagsCscope_Auto_Load = 1
let GtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1
set cscopetag
"}}}

"{{{ CtrlP
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_root_markers = 'all'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/ctrlp'
"}}}

"{{{ Drupal
augroup drupal
  autocmd!

  autocmd BufNewFile *.info setlocal ft=info
  autocmd BufNewFile *.install,*.module setlocal ft=php
augroup END
"}}}

"{{{ HTML
augroup ft_html
  autocmd!

  autocmd FileType html setlocal indentkeys-=*<Return>
  autocmd BufNewFile,BufRead *.html setlocal filetype=htmldjango
  autocmd FileType html,jinja,htmldjango setlocal foldmethod=manual

  " Use <localleader>f to fold the current tag.
  autocmd FileType html,jinja,htmldjango nnoremap <buffer> <localleader>f Vatzf

  " Use Shift-Return to turn this:
  "     <tag>|</tag>
  "
  " into this:
  "     <tag>
  "         |
  "     </tag>
  autocmd FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

  " Indent tag
  autocmd FileType html,jinja,htmldjango nnoremap <buffer> <localleader>= Vat=

  " Django tags
  autocmd FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

  " Django variables
  autocmd FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>

  autocmd FileType htmldjango setlocal commentstring={#\ %s\ #}
augroup END
"}}}

"{{{ i3
augroup i3
  autocmd BufWritePost ~/.config/i3/config call system('which i3-msg && i3-msg reload')
augroup END
"}}}

"{{{ Javascript
" Simple re-format for minified Javascript
command! UnMinify call UnMinify()
function! UnMinify()
  %s/{\ze[^\r\n]/{\r/g
  %s/){/) {/g
  %s/};\?\ze[^\r\n]/\0\r/g
  %s/;\ze[^\r\n]/;\r/g
  %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
  normal ggVG=
endfunction
"}}}

"{{{ PHP
augroup php
  autocmd!
  autocmd BufNewFile,BufFilePre,BufRead *.install set filetype=php
  autocmd BufNewFile,BufFilePre,BufRead *.test set filetype=php
  autocmd FileType php nnoremap <buffer> <leader>cc :!drush cc all
  autocmd FileType php nnoremap <buffer> <leader>f ?}o/**/function () {}kf(:nohl<cr>i
  autocmd FileType php nnoremap <buffer> <leader>dump Oob_get_clean(); echo '<pre>'; var_dump(); die;<esc>F(a

  autocmd FileType php set nofoldenable
  " autocmd FileType php cnoremap drush !drush scr %

  " Dirty text object for PHP functions
  autocmd FileType php,javascript nnoremap <buffer> cif $?^\s*function<CR>:noh<CR>$ci{
  autocmd FileType php,javascript nnoremap <buffer> caf $?^\s*function<CR>:noh<CR>$V%c
  autocmd FileType php,javascript nnoremap <buffer> dif $?^\s*function<CR>:noh<CR>$di{
  autocmd FileType php,javascript nnoremap <buffer> daf $?^\s*function<CR>:noh<CR>$V%d
  autocmd FileType php,javascript nnoremap <buffer> yif mz$?^\s*function<CR>:noh<CR>$yi{`z
  autocmd FileType php,javascript nnoremap <buffer> yaf mz$?^\s*function<CR>:noh<CR>V$%y`z
  autocmd FileType php,javascript nnoremap <buffer> vif $?^\s*function<CR>:noh<CR>$vi{
  autocmd FileType php,javascript nnoremap <buffer> vaf $?^\s*function<CR>:noh<CR>$v%
  autocmd FileType php,javascript nnoremap <buffer> Vif $?^\s*function<CR>:noh<CR>$V%
  autocmd FileType php,javascript nnoremap <buffer> Vaf $?^\s*function<CR>:noh<CR>$V%

  autocmd FileType php,javascript nnoremap <buffer> ciF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$ci{
  autocmd FileType php,javascript nnoremap <buffer> caF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%c
  autocmd FileType php,javascript nnoremap <buffer> diF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$di{
  autocmd FileType php,javascript nnoremap <buffer> daF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%d
  autocmd FileType php,javascript nnoremap <buffer> yiF mz$?^\s*function<CR>?^\s*$<CR>j:noh<CR>$yi{`z
  autocmd FileType php,javascript nnoremap <buffer> yaF mz$?^\s*function<CR>?^\s*$<CR>j:noh<CR>V$%y`z
  autocmd FileType php,javascript nnoremap <buffer> viF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$vi{
  autocmd FileType php,javascript nnoremap <buffer> vaF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$v%
  autocmd FileType php,javascript nnoremap <buffer> ViF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%
  autocmd FileType php,javascript nnoremap <buffer> VaF $?^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%

  autocmd FileType php,javascript nnoremap <buffer> cinf $/^\s*function<CR>:noh<CR>$ci{
  autocmd FileType php,javascript nnoremap <buffer> canf $/^\s*function<CR>:noh<CR>$V%c
  autocmd FileType php,javascript nnoremap <buffer> dinf $/^\s*function<CR>:noh<CR>$di{
  autocmd FileType php,javascript nnoremap <buffer> danf $/^\s*function<CR>:noh<CR>$V%d
  autocmd FileType php,javascript nnoremap <buffer> yinf mz$/^\s*function<CR>:noh<CR>$yi{`z
  autocmd FileType php,javascript nnoremap <buffer> yanf mz$/^\s*function<CR>:noh<CR>V$%y`z
  autocmd FileType php,javascript nnoremap <buffer> vinf $/^\s*function<CR>:noh<CR>$vi{
  autocmd FileType php,javascript nnoremap <buffer> vanf $/^\s*function<CR>:noh<CR>$v%
  autocmd FileType php,javascript nnoremap <buffer> Vinf $/^\s*function<CR>:noh<CR>$V%
  autocmd FileType php,javascript nnoremap <buffer> Vanf $/^\s*function<CR>:noh<CR>$V%
  autocmd FileType php,javascript nnoremap <buffer> cinF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$ci{
  autocmd FileType php,javascript nnoremap <buffer> canF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%c
  autocmd FileType php,javascript nnoremap <buffer> dinF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$di{
  autocmd FileType php,javascript nnoremap <buffer> danF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%d
  autocmd FileType php,javascript nnoremap <buffer> yinF mz$/^\s*function<CR>?^\s*$<CR>j:noh<CR>$yi{`z
  autocmd FileType php,javascript nnoremap <buffer> yanF mz$/^\s*function<CR>?^\s*$<CR>j:noh<CR>V$%y`z
  autocmd FileType php,javascript nnoremap <buffer> vinF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$vi{
  autocmd FileType php,javascript nnoremap <buffer> vanF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$v%
  autocmd FileType php,javascript nnoremap <buffer> VinF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%
  autocmd FileType php,javascript nnoremap <buffer> VanF $/^\s*function<CR>?^\s*$<CR>j:noh<CR>$V%

  autocmd FileType php,javascript nnoremap <buffer> gf mz$?^\s*function<CR>:noh<CR>w"zyiw`z:echo @z<cr>
  autocmd FileType php,javascript nnoremap <buffer> gnf mz$/^\s*function<CR>:noh<CR>w"zyiw`z:echo @z<cr>
augroup END
"}}}

"{{{ Python
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

augroup ft_python
  let g:pymode_folding = 0
  let g:pymode_lint_ignore = "E501,E302,E303"
  let g:pymode_lint_onfly = 1
  let g:pymode_rope = 0
  autocmd!

  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType python setlocal define=^\s*\\(def\\\\|class\\)

  "au FileType python compiler nose
  autocmd FileType man nnoremap <buffer> <cr> :q<cr>

  " Jesus tapdancing Christ, built-in Python syntax, you couldn't let me
  " override this in a normal way, could you?
  autocmd FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif

  " Jesus, Python.  Five characters of punctuation for a damn string?
  autocmd FileType python inoremap <buffer> <d-'> _(u'')<left><left>

  autocmd bufwrite *.py :call DeleteTrailingWS()
augroup END
"}}}

"{{{ Startify
let g:startify_custom_header = []
let g:startify_bookmarks = [
      \ { 'a': '~/.bash_aliases' },
      \ { 'b': '~/.bashrc' },
      \ { 'i': '~/.config/i3/config' },
      \ { 'r': '~/.config/ranger/rc.conf' },
      \ { 'p': '~/.config/polybar/config' },
      \ { 'x': '~/.Xresources' },
      \ { 'v': '~/.vimrc' },
      \ ]

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ $HOME . '/.bashrc',
      \ $HOME . '/.bash_aliases',
      \ $HOME . '/.config',
      \ $HOME . '/.dotfiles',
      \ $HOME . '/.Xresources',
      \ $HOME . '/.vimrc',
      \ ]
"}}}

"{{{ Text
augroup ft_text
  autocmd!

  autocmd FileType text,markdown setlocal wrap
  autocmd FileType text,markdown setlocal spell
  autocmd FileType text,markdown setlocal linebreak
augroup END
"}}}

"{{{ Tmux
" Alt + cursor keys to mimic tmux behaviour
nnoremap <m-left> <c-w>h
nnoremap <m-right> <c-w>l
nnoremap <m-up> <c-w>k
nnoremap <m-down> <c-w>j
"}}}

"{{{ Vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>
"}}}

"{{{ Vagrant
augroup ft_vagrant
  autocmd!
  autocmd BufRead,BufNewFile Vagrantfile set ft=ruby
augroup END
"}}}

"{{{ XML
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
  set filetype=xml
endfunction
command! PrettyXML call DoPrettyXML()
"}}}

"{{{ Yankring
let tmpdir = expand("~/.vim/tmp")
if !isdirectory(tmpdir)
  call mkdir(tmpdir)
endif
let g:yankring_history_dir=tmpdir

nnoremap <leader>y :YRShow<cr>
"}}}
