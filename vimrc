" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" Install plugins here
execute pathogen#infect()
" call pathogen#helptags()

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on

  " I like highlighting strings inside C comments.
  " Revert with ":unlet c_comment_strings".
  let c_comment_strings=1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif " has("autocmd")

" Vim-Instant-Markdown settings
let g:instant_markdown_autostart = 0
"let g:instant_markdown_slow = 1
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1 
  
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex';
let g:tex_flavor='latex'

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
if exists('skip_defaults_vim')
  finish
endif

"########################################################
"                                                       #
"                      Vim defaults                     #
"                                                       #
"########################################################
"
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=2000        " keep 2000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

"########################################################
"                                                       #
"                        .vimrc                         #
"                                                       #
"########################################################

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" if &t_Co > 2 || has("gui_running")
"  " Switch on highlighting the last used search pattern.
"  set hlsearch
" endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 72 characters.
  autocmd FileType text setlocal textwidth=72

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Map the <Leader> key to "," (comma)
let mapleader =","

" Splits open at the bottom and right.
set splitbelow splitright

" Search current directory recursively
set path+=**

" Set no backup for file being edited
set nobackup
set noswapfile

" Remove pipes | that act as seperators on splits
set fillchars+=vert:\ 

" Edit .vimrc file
nnoremap <Leader>ev :vsplit $MYVIMRC<Enter>

" Source edited .vimrc file
nnoremap <Leader>sv :source $MYVIMRC<Enter>

" Remap navigation keybindings and key-chords
" nnoremap 0 g0
" nnoremap j gj
" nnoremap k gk
" nnoremap $ g$

" Remap window navigation keys-chords
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Switch on line numbering.
set number

augroup mySyntax
autocmd!

" Switch own syntax highlighting
autocmd BufRead,BufNewFile *.geo set filetype=cpp
autocmd BufNewFile,BufRead * if &syntax == '' | set syntax=cpp | endif

augroup END

" Remap semicolon to colon
nnoremap ; :
nnoremap : ;
" inoremap ; :
" inoremap : ;
vnoremap ; :
vnoremap : ;

" Remap Escape key to jk
inoremap jk <Esc>

" Set relative numbering
set relativenumber

" Inspired by Luke Smith
"
" Settings pertaining to searches
set nohlsearch
set ignorecase

" Line wrapping toggle
nnoremap <F2> :set wrap!<CR>

" Navigating with guides
inoremap <Leader><Leader> <Esc>/<++><Enter>"_c4l
vnoremap <Leader><Leader> <Esc>/<++><Enter>"_c4l
nnoremap <Leader><Leader> <Esc>/<++><Enter>"_c4l

augroup myGMSH
autocmd!

" Create new point
autocmd BufRead,BufNewFile *.geo inoremap <Leader>pt p# = newp; Point(p#) = {<++>, <++>, <++>, 1.0};<Esc>

" Create new line
autocmd BufRead,BufNewFile *.geo inoremap <Leader>ln ln# = newl; Line(ln#) = {<++>, <++>};<Esc>

"Create new surface
autocmd BufRead,BufNewFile *.geo inoremap <Leader>sf s# = news; Line Loop(s#) = {<++>, <++>, <++>, <++>}; Plane Surface(s#) = {s#};<Esc>

augroup END

augroup myLaTeX
autocmd!

" Execute Biber
autocmd BufRead,BufNewFile *.tex nnoremap <Leader>bb :!biber  <Left>
" Input degree (angle)
autocmd BufRead,BufNewFile *.tex inoremap <Leader>ta \SI{}{\degree}<++><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Compile RMarkdown file
autocmd Filetype rmd nnoremap <leader>m :w<Enter>:!echo<Space>"require(rmarkdown);<Space>render('<C-R>%')"<Space>\|<Space>R<Space>--vanilla<Enter>

" Autosave markdown documents
" autocmd TextChanged,TextChangedI <buffer> silent write


augroup END

" Search and replace entire file
nnoremap sf :%s///g<Left><Left><Left>

" Search and replace for GMSH
nnoremap sg :s/#//g<Left><Left>

" Search and replace in line
nnoremap sl :s///g<Left><Left><Left>

" Bulk renumber line
nnoremap <Leader>rl 0df)k0yf)j0P0llt)j0

" Indent settings
set shiftwidth=2    " Indents will have a width of 2

" Powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
