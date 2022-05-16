" to pure vim

" ----------------------------------------------------------------------------
" KEY MAPS
" ----------------------------------------------------------------------------

let mapleader = ','

" Useful macros I use the most
nmap \A :set formatoptions+=a<CR>:echo "autowrap enabled"<CR>
nmap \F :NERDTreeFind<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \W mt:Goyo<CR>'tzz
nmap \a :set formatoptions-=a<CR>:echo "autowrap disabled"<CR>
nmap \b :set nocin tw=80<CR>:set formatoptions+=a<CR>
nmap \c :call TmuxPaneClear()<CR>
nmap \d :ALEToggleBuffer<CR>
nmap \e :NERDTreeToggle<CR>
nmap \f :ALEFix<CR>
nmap \g :GitGutterToggle<CR>
nmap \i vip:sort<CR>
nmap \l :setlocal number!<CR>:setlocal number?<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \o :set paste!<CR>:set paste?<CR>
nmap \p :ProseMode<CR>
nmap \q :nohlsearch<CR>
nmap \r :call TmuxPaneRepeat()<CR>
nmap \s :setlocal invspell<CR>
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \u :setlocal list!<CR>:setlocal list?<CR>
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap \x :cclose<CR>
nmap \z :w<CR>:!open %<CR><CR>

" Turn off linewise keys. Normally, the `j' and `k' keys move the cursor down one entire line. with
" line wrapping on, this can cause the cursor to actually skip a few lines on the screen because
" it's moving from line N to line N+1 in the file. I want this to act more visually -- I want `down'
" to mean the next line on the screen
nmap j gj
nmap k gk

" Marks should go to the column, not just the line. Why isn't this the default?
nnoremap ' `

" You don't know what you're missing if you don't use this.
nmap <C-e> :e#<CR>

" Move between open buffers.
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" Emacs-like bindings in normal mode
nmap <C-x>0 <C-w>c
nmap <C-x>1 <C-w>o
nmap <C-x>1 <C-w>s
nmap <C-x>1 <C-w>v
nmap <C-x>o <C-w><C-w>
nmap <M-o>  <C-w><C-w>

" Emacs-like bindings in insert mode
imap <C-e> <C-o>$
imap <C-a> <C-o>0

" Emacs-like bindings in the command line from `:h emacs-keys`
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Del>
cnoremap <C-e>  <End>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" Super fast window movement shortcuts
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Resize panes when window/terminal gets resize
autocmd VimResized * :wincmd =

" Search for the word under the cursor in the current directory
nmap <M-k>    mo:Ack! "\b<cword>\b" <CR>
nmap <Esc>k   mo:Ack! "\b<cword>\b" <CR>
nmap ˚        mo:Ack! "\b<cword>\b" <CR>
nmap <M-S-k>  mo:Ggrep! "\b<cword>\b" <CR>
nmap <Esc>K   mo:Ggrep! "\b<cword>\b" <CR>

" Alt-W to delete a buffer and remove it from the list but keep the window via bufkill.vim
nmap <Esc>w :BD<CR>
nmap <M-w>  :BD<CR>
nmap ∑      :BD<CR>

" Quickly fix spelling errors choosing the first result
nmap <Leader>z z=1<CR><CR>

" Fix annoyances in the QuickFix window, like scrolling too much
autocmd FileType qf setlocal number nolist
autocmd Filetype qf wincmd J " Makes sure it's at the bottom of the vim window

" Commands to send common keystrokes using tmux
let g:tmux_console_pane = '0:0.0'
let g:tmux_server_pane = '0:0.0'
function TmuxPaneRepeat()
  write
  silent execute ':!tmux send-keys -t' g:tmux_console_pane 'C-p' 'C-j'
  redraw!
endfunction
function TmuxPaneClear()
  silent execute ':!tmux send-keys -t' g:tmux_server_pane 'C-j' 'C-j' 'C-j' 'C-j' 'C-j' 'C-j' 'C-j'
  redraw!
endfunction

" These are things that I mistype and want ignored.
nmap Q  <silent>
nmap q: <silent>
nmap K  <silent>

" Make the cursor stay on the same line when window switching
function! KeepCurrentLine(motion)
  let theLine = line('.')
  let theCol = col('.')
  exec 'wincmd ' . a:motion
  if &diff
    call cursor(theLine, theCol)
  endif
endfunction
nnoremap <C-w>h :silent call KeepCurrentLine('h')<CR>
nnoremap <C-w>l :silent call KeepCurrentLine('l')<CR>

" ----------------------------------------------------------------------------
" ABBREVATIONS
" ----------------------------------------------------------------------------

" Typing `$c` on the command line expands to `:e` + the current path, so it's easy to edit a file in
" the same directory as the current file.
cnoremap $c e <C-\>eCurrentFileDir()<CR>
function! CurrentFileDir()
   return "e " . expand("%:p:h") . "/"
endfunction

" I can't spell :(
abbr conosle console
abbr comopnent component

" Debugging helpers
autocmd BufEnter *.py iabbr xxx print('XXX
autocmd BufEnter *.py iabbr yyy print('YYY
autocmd BufEnter *.py iabbr zzz print('ZZZ
autocmd BufEnter *.coffee iabbr xxx console.log 'XXX',
autocmd BufEnter *.coffee iabbr yyy console.log 'YYY',
autocmd BufEnter *.coffee iabbr zzz console.log 'ZZZ',
autocmd BufEnter *.js,*.ts iabbr xxx console.log('XXX',
autocmd BufEnter *.js,*.ts iabbr yyy console.log('YYY',
autocmd BufEnter *.js,*.ts iabbr zzz console.log('ZZZ',
autocmd BufEnter *.rb iabbr xxx puts "XXX
autocmd BufEnter *.rb iabbr yyy puts "YYY
autocmd BufEnter *.rb iabbr zzz puts "ZZZ
autocmd BufEnter *.rb iabbr ppp require 'pp'; pp

" ----------------------------------------------------------------------------
" OPTIONS
" ----------------------------------------------------------------------------

set autoindent              " Carry over indenting from previous line
set autoread                " Don't bother me hen a file changes
set autowrite               " Write on :next/:prev/^Z
set backspace=indent,eol,start
                            " Allow backspace beyond insertion point
set cindent                 " Automatic program indenting
set cinkeys-=0#             " Comments don't fiddle with indenting
set cino=                   " See :h cinoptions-values
set clipboard=unnamed       " yank and paste with the system clipboard
set commentstring=\ \ #%s   " When folds are created, add them to this
set copyindent              " Make autoindent use the same chars as prev line
set directory-=.            " Don't store temp files in cwd
set encoding=utf8           " UTF-8 by default
set expandtab               " No tabs
set fileformats=unix,dos,mac  " Prefer Unix
set fillchars=vert:\ ,stl:\ ,stlnc:\ ,fold:-,diff:┄
                            " Unicode chars for diffs/folds, and rely on
                            " Colors for window borders
silent! set foldmethod=marker " Use braces by default
" set formatoptions=tcqn1     " t - autowrap normal text
                            " c - autowrap comments
                            " q - gq formats comments
                            " n - autowrap lists
                            " 1 - break _before_ single-letter words
                            " 2 - use indenting from 2nd line of para
set hidden                  " Don't prompt to save hidden windows until exit
set history=200             " How many lines of history to save
set hlsearch                " Hilight searching
" set ignorecase              " Case insensitive
set incsearch               " Search as you type
set infercase               " Completion recognizes capitalization
set laststatus=2            " Always show the status bar
set linebreak               " Break long lines by word, not char
set list                    " Show whitespace as special chars - see listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things
set matchtime=2             " Tenths of second to hilight matching paren
set modelines=5             " How many lines of head & tail to look for ml's
silent! set mouse=nvc       " Use the mouse, but not in insert mode
set nobackup                " No backups left after done editing
" set nonumber                " No line numbers to start
set number
set nowrap
set relativenumber
set cursorline
" set cursorcolumn
set colorcolumn=120
set visualbell t_vb=        " No flashing or beeping at all
set nowritebackup           " No backups made while editing
set printoptions=paper:letter " US paper
set ruler                   " Show row/col and percentage
set scroll=4                " Number of lines to scroll with ^U/^D
set scrolloff=1             " Keep cursor away from this many chars top/bot
set sessionoptions-=options " Don't save runtimepath in Vim session (see tpope/vim-pathogen docs)
set shiftround              " Shift to certain columns, not just n spaces
set shiftwidth=2            " Number of spaces to shift for autoindent or >,<
set shortmess+=A            " Don't bother me when a swapfile exists
set showbreak=              " Show for lines that have been wrapped, like Emacs
set showmatch               " Hilight matching braces/parens/etc.
set sidescrolloff=3         " Keep cursor away from this many chars left/right
set smartcase               " Lets you search for ALL CAPS
set softtabstop=2           " Spaces 'feel' like tabs
set suffixes+=.pyc          " Ignore these files when tab-completing
set tabstop=2               " The One True Tab
set textwidth=100           " 100 is the new 80
set thesaurus+=~/.vim/mthes10/mthesaur.txt
set wildmenu                " Show possible completions on command line
set wildmode=list:longest,full " List all options and complete
set wildignore=*.class,*.o,*~,*.pyc,.git,node_modules  " Ignore certain files in tab-completion

set nofoldenable

set viminfo='100,f1


" plugins

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'Chiel92/vim-autoformat'
Plug 'easymotion/vim-easymotion'
Plug 'farmergreg/vim-lastplace'
Plug 'jiangmiao/auto-pairs'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pbrisbin/vim-mkdir'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale'
Plug '907th/vim-auto-save'
Plug 'pseewald/vim-anyfold'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-jdaddy'

"" colorful parentheses
Plug 'luochen1990/rainbow'

" Language Server
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

"" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


"" Buffer management
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

"" language
Plug 'sheerun/vim-polyglot'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"" pytest"
Plug 'vim-test/vim-test'

"" Indent line
Plug 'lukas-reineke/indent-blankline.nvim'


"" color
Plug 'tomasr/molokai'
Plug 'fneu/breezy'
Plug 'kaicataldo/material.vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'phanviet/vim-monokai-pro'
Plug 'crusoexia/vim-monokai'

Plug 'chriskempson/base16-vim'
Plug 'daviesjamie/vim-base16-lightline'
Plug 'emhaye/ceudah.vim'
Plug 'jdsimcoe/panic.vim'
Plug 'alexanderjeurissen/lumiere.vim'
Plug 'trusktr/seti.vim'
Plug 'schickele/vim-nachtleben'

Plug 'nightsense/stellarized'
Plug 'gkjgh/cobalt'
Plug 'srcery-colors/srcery-vim'
Plug 'kiddos/malokai'
Plug 'kiddos/kiddo'
Plug 'jacoborus/tender.vim'
Plug 'beigebrucewayne/Turtles'
Plug 'mkarmona/colorsbox'
Plug 'daylerees/colour-schemes', { 'rtp': 'vim/' }
Plug 'vim-scripts/xterm16.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'mr-ubik/vim-hackerman-syntax'
Plug 'flrnprz/plastic.vim'
Plug 'pablopunk/sick.vim'
Plug 'crater2150/vim-theme-chroma'
Plug 'zeis/vim-kolor'
Plug 'Haron-Prime/Antares'
Plug 'Rigellute/rigel'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'romainl/flattened'
Plug 'arzg/vim-colors-xcode'
Plug 'eemed/sitruuna.vim'
Plug 'flrnprz/candid.vim'
Plug 'apazzolini/vim-wave'
Plug 'tfkhsr/nomolo'
Plug 'caglartoklu/borlandp.vim'
Plug 'jeffkreeftmeijer/vim-dim'
Plug 'lewis6991/moonlight.vim'
Plug 'aliou/moriarty.vim'
Plug 'mcmartelle/vim-monokai-bold'
Plug 'sainnhe/forest-night'
Plug 'sainnhe/edge'
Plug 'sk1418/last256'
Plug 'sainnhe/gruvbox-material'
Plug 'notpratheek/vim-sol'
Plug 'ayu-theme/ayu-vim'
Plug 'jdsimcoe/hyper.vim'
Plug 'broduo/broduo-color-scheme'
Plug 'vim-scripts/dante.vim'
Plug 'vim-scripts/Relaxed-Green'
Plug 'foooomio/vim-colors-japanesque'
Plug 'tomasiser/vim-code-dark'
Plug 'zefei/vim-colortuner'
Plug 'ghifarit53/tokyonight-vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'morhetz/gruvbox'
Plug 'bluz71/vim-moonfly-colors'
Plug 'agude/vim-eldar'
Plug 'evgenyzinoviev/vim-vendetta'
Plug 'bratpeki/truedark-vim'
Plug 'dikiaap/minimalist'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'google/vim-colorscheme-primary'
Plug 'preservim/vim-colors-pencil'
Plug 'saltdotac/citylights.vim'
Plug 'tobi-wan-kenobi/zengarden'
Plug 'lucasprag/simpleblack'
Plug 'uloco/vim-bluloco-dark'

Plug 'chrisbra/Colorizer'

"" Semshi for python syntax based hilighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

"" Conqueror of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"" From Ian Langford's settings"
Plug 'airblade/vim-gitgutter'
Plug 'alampros/vim-styled-jsx'
Plug 'ap/vim-css-color'
Plug 'docunext/closetag.vim'
" Plug 'ervandew/supertab'
Plug 'haya14busa/incsearch.vim'
Plug 'itchyny/lightline.vim'
Plug 'jparise/vim-graphql'
Plug 'junegunn/goyo.vim'
Plug 'mileszs/ack.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdtree'
Plug 'statico/vim-inform7'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

call plug#end()

" rainbow colorful parentheses
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" enable deoplete
" let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" make sure semshi and deoplete play well together
" https://github.com/numirias/semshi#semshi-is-slow-together-with-deopletenvim
" let deoplete#custom#auto_complete_delay = 100

" Essential for filetype plugins.
filetype plugin indent on

" ----------------------------------------------------------------------------
" CUSTOM COMMANDS AND FUNCTIONS
" ----------------------------------------------------------------------------

" I always hit ":W" instead of ":w" because I linger on the shift key...
command! Q q
command! W w

" Trim spaces at EOL and retab. I run `:CLEAN` a lot to clean up files.
command! TEOL %s/\s\+$//
command! CLEAN retab | TEOL

" Close all buffers except this one
command! BufCloseOthers %bd|e#



" For any plugins that use this, make their keymappings use comma
let mapleader = ","
let maplocalleader = ","

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Rg!<CR>
nmap <Leader>c :Colors<CR>
let $FZF_DEFAULT_COMMAND = 'rg --files --follow -g "!{.git,node_modules}/*" 2>/dev/null'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "!{*.lock,*-lock.json}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:40%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" FZF color scheme updater from https://github.com/junegunn/fzf.vim/issues/59
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['String',       'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['String',       'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code != ''
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ (empty(cols) ? '' : (' --color='.join(cols, ',')))
endfunction

augroup _fzf
  autocmd!
  autocmd VimEnter,ColorScheme * call <sid>update_fzf_colors()
augroup END

" Ctrl-C has a long delay in SQL files - https://unix.stackexchange.com/a/150769
let g:ftplugin_sql_omni_key = '<Leader>s'

" More space with NERDTree
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMarkBookmarks = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeStatusLine = -1

" Tell ack.vim to use ripgrep instead
let g:ackprg = 'rg --vimgrep --no-heading'

" GitGutter styling to use · instead of +/-
let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
nmap ]g :GitGutterNextHunk<CR>
nmap [g :GitGutterPrevHunk<CR>
augroup VimDiff
  autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | GitGutterDisable | endif
augroup END

" SuperTab
let g:SuperTabLongestEnhanced = 1
let g:SuperTabLongestHighlight = 1
au Filetype typescript let b:SuperTabDefaultCompletionType = "<C-x><C-o>"

" Use incsearch.vim to highlight as I search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Highlight YAML frontmatter in Markdown files
let g:vim_markdown_frontmatter = 1

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
nmap ]w :ALENextWrap<CR>
nmap [w :ALEPreviousWrap<CR>
nmap <Leader>f <Plug>(ale_fixers)
augroup VimDiff
  autocmd!
  autocmd VimEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

" ----------------------------------------------------------------------------
" CODE FOLDING
" ----------------------------------------------------------------------------
autocmd Filetype * AnyFoldActivate
let g:anyfold_fold_comments=1
set foldlevel=0

" ----------------------------------------------------------------------------
" COLORS
" ----------------------------------------------------------------------------
set background=dark
if (has("termguicolors"))
  set termguicolors
endif

set t_Co=256

" Make sure colored syntax mode is on, and make it Just Work with 256-color terminals.
set background=dark
let g:rehash256 = 1 " Something to do with Molokai?
colorscheme molokai
" let g:seoul256_background = 233
if !has('gui_running')
  let g:solarized_termcolors = 256
  if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
  elseif has("terminfo")
    colorscheme default
    set t_Co=8
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm
  else
    colorscheme default
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif
  " Disable Background Color Erase when within tmux - https://stackoverflow.com/q/6427650/102704
  if $TMUX != ""
    set t_ut=
  endif
endif

" solarized options
let g:solarized_termcolors= 256
let g:solarized_termtrans = 0
let g:solarized_degrade = 0
let g:solarized_bold = 1
let g:solarized_underline = 0
let g:solarized_italic = 1
let g:solarized_contrast = "high"
let g:solarized_visibility= "high"

" " gruvbox options
let g:gruvbox_italic = 1
let g:gruvbox_improved_strings = 1
let g:gruvbox_contrast_dark = "medium"
let g:gruvbox_contrast_light = "medium"

" xterm options
let g:xterm16_termcolors=   256
let g:xterm16_termtrans =   0
let g:xterm16_degrade   =   0
let g:xterm16_bold      =   1
let g:xterm16_underline =   1
let g:xterm16_italic    =   1
let g:xterm16_contrast  =   "low"
let g:xterm16_visibility=   "normal"
let g:xterm16_colormap  =   "soft"
let g:xterm16_brightness=   "high"

" " quantum options
" let g:quantum_black=1
" let g:quantum_italics=0

" " Monokai options
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
let g:vim_monokai_tasty_italic = 1


" " srcery options
let g:srcery_italic = 1
let g:srcery_bold = 1
let g:srcery_underline = 1
let g:srcery_undercurl = 0
let g:srcery_inverse = 1
let g:srcery_inverse_matches = 1
let g:srcery_inverse_match_paren = 1

" material options
" let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker'
let g:material_theme_style = 'darker'
let g:material_terminal_italics = 1

" hybrid options
" let g:enable_bold_font = 1
" let g:enable_italic_font = 1
" let g:hybrid_transparent_background = 1
"

" Enable italic. Default: 1
let g:kolor_italic=1

" Enable bold. Default: 1
let g:kolor_bold=1

" Enable underline. Default: 0
let g:kolor_underlined=1

" Gray 'MatchParen' color. Default: 0
let g:kolor_alternative_matchparen=0

" White foreground 'MatchParen' color that might work better with some terminals. Default: 0
let g:kolor_inverted_matchparen=1

" Additional variables to control vim-polyglot's python.vim behavior
" let g:python_version_2=1
" let b:python_version_2=1
" let g:python_highlight_builtins=1
" let g:python_highlight_exceptions=1
" let g:python_highlight_string_formatting=1
" let g:python_highlight_string_format=1
" let g:python_highlight_string_templates=1
" let g:python_highlight_indent_errors=1
" let g:python_highlight_space_errors=1
" let g:python_highlight_doctests=1
" let g:python_highlight_class_vars=1
" let g:python_highlight_operators=1

" For 'breezy' colorscheme and for vim-polyglot to support python syntax highlighting
let g:python_highlight_all=1

" PaperColor options
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }

" For colorsbox
" let g:colorsbox_contrast_dark = 'hard'

" For molokai
let g:molokai_original = 1
let g:rehash256 = 1

" For xcodedark | xcodelight
augroup vim-colors-xcode
    autocmd!
augroup END

autocmd vim-colors-xcode ColorScheme * hi Comment        cterm=italic gui=italic
autocmd vim-colors-xcode ColorScheme * hi SpecialComment cterm=italic gui=italic


" For gruvbox-material
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'



let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" let g:rigel_airline = 1

" for chroma
" let g:chroma_underline_style = "underline" | "bold"
let g:chroma_underline_style = "bold"
" For fonts, that do not work well in italic, you may also want to
" change all other occurrences of italic, e.g.:
let g:chroma_italic_style = "italic"
" If you prefer the nontext background (the window background after
" the last line of the file) to be the same as the main background, use:
let g:chroma_nontext_dark = 1

" the configuration options should be placed before `colorscheme forest-night`
let g:forest_night_enable_italic = 1
let g:forest_night_disable_italic_comment = 1


" edge theme settings
" the configuration options should be placed before `colorscheme edge`
let g:edge_style = 'neon'
let g:edge_enable_italic = 1
" let g:edge_disable_italic_comment = 1
"
" ayu theme settings
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of themek

" airline theme
" let g:airline_theme='edge'
" lightline theme
let g:lightline = {'colorscheme' : 'gruvbox_material'}

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1


" neodark settings
let g:neodark#background = '#000010'
let g:neodark#use_256color = 1 " default: 0
let g:neodark#terminal_transparent = 0 " default: 0
let g:neodark#solid_vertsplit = 1 " default: 0
" let g:lightline = {}
" let g:lightline.colorscheme = 'neodark'

" mirage settings
"if (has("nvim"))
"  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"endif
" let g:mirage_terminal_italics=1

" Fox
let g:fox_type='regular' " regular | day | night

if (&t_Co == 256 || has('gui_running'))
  if (($TERM_PROGRAM == 'iTerm.app') || ($TERM_PROGRAM == 'Apple_Terminal'))
    """ MY TOP SCHEMES
    " colorscheme breezy " ---> best colorscheme for python highlighting{{{}}}
    " colorscheme simpleblack " --> this is REALLY good
    " colorscheme blackbird
    " colorscheme dante
    " colorscheme codedark
    " colorscheme tokyonight
    " colorscheme challenger_deep
    " colorscheme dark_themer
    " colorscheme vividchalk
    " colorscheme gruvbox-material
    " colorscheme gruvbox
    " colorscheme fogbell
    " colorscheme material
    " colorscheme moonlight
    " colorscheme xterm16
    " colorscheme last256
    " colorscheme flattened_dark
    " colorscheme flattened_light
    " colorscheme antares
    " colorscheme forest-night
    " colorscheme breezy
    " colorscheme kolor
    " colorscheme sick
    " colorscheme vim-monokai-tasty
    " colorscheme molokai " the original
    " colorscheme monokai-bold
    " colorscheme sublimemonokai
    " colorscheme monokai_pro
    " colorscheme malokai
    " colorscheme monokai "the best
    " colorscheme dim
    " colorscheme nachtleben
    " colorscheme darkside-contrast
    " colorscheme juicy-contrast
    " colorscheme jumper-contrast
    " colorscheme legacy-contrast
    " colorscheme lichen-contrast
    " colorscheme overflow-contrast
    " colorscheme glowfish-contrast
    " colorscheme PaperColor
    " colorscheme turtles
    " colorscheme kiddo
    " colorscheme ceudah
    " colorscheme vendetta
    " colorscheme base16-bright
    " colorscheme base16-atelier-seaside
    " colorscheme base16-google-light
    " colorscheme seti
    " colorscheme colorsbox-stbright
    " colorscheme relaxedgreen
    " colorscheme rigel
    " colorscheme srcery
    " colorscheme deep-space
    " colorscheme xcodewwdc
    " colorscheme sitruuna
    " colorscheme panic
    " colorscheme borlandp
    " colorscheme truedark
    " colorscheme base16-3024
    colorscheme blackbird
  else
    colorscheme blackbird
  endif
endif

if &diff
  colorscheme chroma
endif


syntax on

" Make the damned tildes less visible
highlight link EndOfBuffer Comment

" Custom colors for NERDTree
highlight def link NERDTreeRO NERDTreeFile

" Make trailing spaces very visible
highlight SpecialKey ctermbg=Yellow guibg=Yellow

" Make menu selections visible
highlight PmenuSel ctermfg=black ctermbg=magenta

" Custom mode for distraction-free editing
function! ProseMode()
  call goyo#execute(0, [])
  set spell noci nosi noai nolist noshowmode noshowcmd
  set complete+=s
  set bg=light
  colors solarized
endfunction
command! ProseMode call ProseMode()


" Lightline
let g:lightline = {
\ 'colorscheme': 'molokai',
\ 'active': {
\   'left': [['mode', 'paste'], ['gitbranch', 'absolutepath', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ 'component_function': {
\   'gitbranch': 'fugitive#head'
\ },
\ }


function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" Update the lightline scheme from the colorscheme. Hopefully.
function! s:UpdateLightlineColorScheme()
  let g:lightline.colorscheme = g:colors_name
  call lightline#init()
endfunction

augroup _lightline
  autocmd!
  autocmd User ALELint call s:MaybeUpdateLightline()
  autocmd ColorScheme * call s:UpdateLightlineColorScheme()
augroup END


" ----------------------------------------------------------------------------
" FILE TYPE TRIGGERS
" ----------------------------------------------------------------------------

" Reset all autocommands
augroup vimrc
autocmd!

au BufNewFile,BufRead *.cson    set ft=coffee
au BufNewFile,BufRead *.d.ts    ALEDisableBuffer
au BufNewFile,BufRead *.glsl    setf glsl
au BufNewFile,BufRead *.gyp     set ft=python
au BufNewFile,BufRead *.html    setlocal nocindent smartindent
au BufNewFile,BufRead *.i7x     setf inform7
au BufNewFile,BufRead *.ini     setf conf
au BufNewFile,BufRead *.input   setf gnuplot
au BufNewFile,BufRead *.json    set ft=json tw=0
au BufNewFile,BufRead *.less    setlocal ft=less nocindent smartindent
au BufNewFile,BufRead *.lkml    setf yaml
au BufNewFile,BufRead *.md      setlocal ft=markdown nolist spell
au BufNewFile,BufRead *.md,*.markdown setlocal foldlevel=999 tw=0 nocin
au BufNewFile,BufRead *.ni      setlocal ft=inform nolist ts=2 sw=2 noet
au BufNewFile,BufRead *.plist   setf xml
au BufNewFile,BufRead *.rb      setlocal noai
au BufNewFile,BufRead *.rxml    setf ruby
au BufNewFile,BufRead *.sass    setf sass
au BufNewFile,BufRead *.ttml    setf xml
au BufNewFile,BufRead *.vert,*.frag set ft=glsl
au BufNewFile,BufRead *.xml     setlocal ft=xml  ts=2 sw=2 et
au BufNewFile,BufRead *.zone    setlocal nolist ts=4 sw=4 noet
au BufNewFile,BufRead *.zsh     setf zsh
au BufNewFile,BufRead *templates/*.html setf htmldjango
au BufNewFile,BufRead .conkyrc set ft=lua
au BufNewFile,BufRead .git/config setlocal ft=gitconfig nolist ts=4 sw=4 noet
au BufNewFile,BufRead .gitconfig* setlocal ft=gitconfig nolist ts=4 sw=4 noet
au BufNewFile,BufRead .vimlocal,.gvimlocal setf vim
au BufNewFile,BufRead .zshlocal setf zsh
au BufNewFile,BufRead /tmp/crontab* setf crontab
au BufNewFile,BufRead COMMIT_EDITMSG setlocal nolist nonumber
au BufNewFile,BufRead Makefile setlocal nolist
au BufNewFile,BufRead dist/* set ft=text

au FileType gitcommit setlocal nolist ts=4 sts=4 sw=4 noet
au FileType inform7 setlocal nolist tw=0 ts=4 sw=4 noet foldlevel=999
au FileType json setlocal conceallevel=0 foldmethod=syntax foldlevel=999
au FileType make setlocal nolist ts=4 sts=4 sw=4 noet
au FileType markdown syn sync fromstart
au Filetype gitcommit setlocal tw=80

augroup END

" ----------------------------------------------------------------------------
" MY GOLDEN CONFIGS
" ----------------------------------------------------------------------------
set ttyfast         " smoother changes
set shortmess=atI   " Abbreviate messages
set nostartofline   " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]   " move freely between files


" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>


" http://vim.wikia.com/wiki/Search_for_visually_selected_text
" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" http://vim.wikia.com/wiki/Ignore_white_space_in_vimdiff
if &diff
   " diff mode
    set diffopt+=iwhite
    colorscheme monokai
endif


" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


" Disambiguate ,a & ,t from the Align plugin, making them fast again.
"
" This section is here to prevent AlignMaps from adding a bunch of mappings
" that interfere with the very-common ,a and ,t mappings. This will get run
" at every startup to remove the AlignMaps for the *next* vim startup.
"
" If you do want the AlignMaps mappings, remove this section, remove
" ~/.vim/bundle/Align, and re-run rake in maximum-awesome.
function! s:RemoveConflictingAlignMaps()
  if exists("g:loaded_AlignMapsPlugin")
    AlignMapsClean
  endif
endfunction
command! -nargs=0 RemoveConflictingAlignMaps call s:RemoveConflictingAlignMaps()
silent! autocmd VimEnter * RemoveConflictingAlignMaps

" ==== CYCLE THROUGH VIM BUFFERS ====
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>


" ==== Background color toggle ==== "
map <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>


" ==== EXECUTE PYTHON CODE DIRECTLY FROM VIM ==== "
" ==== SOURCE: https://stackoverflow.com/questions/18948491/running-python-code-in-vim ===== "
" Bind F5 to save file if modified and execute python script in a buffer.
nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>

function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction


" ----------------------------------------------------------------------------
" Language Server
" https://github.com/autozimu/LanguageClient-neovim
" ----------------------------------------------------------------------------
" Required for operations modifying multiple buffers like rename.
set hidden

" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"     \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
"     \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"     \ 'python': ['/usr/local/bin/pyls'],
"     \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
"     \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" https://about.sourcegraph.com/blog/code-intelligence-in-vim
" nnoremap <silent> <leader>d :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <leader>fr :call LanguageClient_textDocument_references()<CR>
" nnoremap <silent> <leader>r :call LanguageClient_contextMenu()<CR>

" ----------------------------------------------------------------------------
" HOST-SPECIFIC VIM FILE
" ----------------------------------------------------------------------------

" Now load specifics to this host
if filereadable(expand("~/.vimlocal"))
  source ~/.vimlocal
endif

" Some plugin seems to search for something at startup, so this fixes that.
silent! nohlsearch


" insert comment line automatically after a <CR>
set formatoptions+=cro

" vim:set tw=100:
"

" https://til.hashrocket.com/posts/wa1bvrgjdd-escaping-terminal-mode-in-an-nvim-terminal
" 2020-11-04 update: we noticed that this setting below causes Buffers to not escape with Esc
" :tnoremap <Esc> <C-\><C-n>
"
" So trying a fix suggested in: https://github.com/junegunn/fzf.vim/issues/544#issuecomment-457456166
if has("nvim")
  au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
  au FileType fzf tunmap <buffer> <Esc>
endif

" " Pytest
" nmap <silent><Leader>tf <Esc>:Pytest file<CR>
" nmap <silent><Leader>tc <Esc>:Pytest class<CR>
" nmap <silent><Leader>tm <Esc>:Pytest method<CR>

" Enable italics, Make sure this is immediately after colorscheme
" https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
highlight Comment cterm=italic gui=italic
