" Important vimhelp topics for understanding vimrc:
"  - initialization ('startup')
"  - options ('option-list' for a terse summary of all) / guioptions
"  - set_env
" See how vim was compiled with :version.
" See all values that differ from defaults with :se all
" See an option's current value with :se {option}?
"  (To see where it was last set, use :verb se {option}?)
" Browse options with :opt
" Help on an option shadowed by a command via :help '{option}'
" Spaces in string options must be escaped!

" The existence of ~/.vimrc causes 'compatible' to be unset, so we note
" the 'virtual' set nocompatible via a comment here.
"set nocompatible

" Disable reading .vimrc, .exrc from the current directory. This was the
" default last I checked (vim 7), but important enough to make explicit.
set noexrc

" Turn on additional checks for exrc and friends. See trojan-horse. 
set secure

" Modelines are vim commands embedded into a file, setting options for that
" file. They're generally better handled via filetype support. Weaknesses
" have historically been found in VIM modeline support allowing execution
" of arbitrary code (trojaned text files) -- leave them disabled.
set nomodeline

" 'autoindent' is rather naïve and turning on filetype-specific indentation
" (via "filetype indent on") is usually a better choice. Debian prior to
" 2008-08 turns it on.
set noautoindent

set encoding=utf-8
set fileencoding=utf-8

filetype plugin on
filetype indent on

setlocal spell spelllang=en_us
set spellfile=~/.vim/dict.add

set backspace="2"
set display="lastline,uhex"
set ignorecase				" case-insensitive matching
set smartcase				" 'smart' case-matching
set incsearch				" incremental search
set infercase
"set number				" too annoying
set lazyredraw
"set mouse=a				" enable mouse w/o gvim (all modes)
set nobackup
set noerrorbells
set nofsync
set nohlsearch
set nojoinspaces
set nowritebackup
"set noshowmode
set nowarn
set nowrap
set ruler
set rulerformat=%20(%f\ %y\ %2l\ (%p%%)\ %3c\ (%B)\ %o%)
set scrolloff=7
set shiftwidth=8
set shiftround
" set showcmd
set showmatch				" match brackets
set shortmess=atI
set tags=.tags,out/tags,~/var/cache/glibc-tags
set notagrelative
"set t_Co=256
set vb t_vb=
set visualbell
set tabstop=8

" Set the terminal window's title. This can be done without X11 support.
set title
" If compiled without X11 support, we can't reset the title properly, so
" provide a default for title resetting.
if !has( "X11" )
	set titleold=terminal\ motherfucker,\ this\ is\ a\ terminal
endif

" Extensions to defaults
set suffixes+=class,cl
set viminfo+=h

let c_gnu=1

if version > 500
    set background=dark
    set confirm
    set directory+=.
    set makeef=vim.err
    set pastetoggle=<F8>
endif

" Why doesn't vim do struct/union/enum by default?
set cinwords="if,else,while,do,for,switch,struct,union,enum"

" As documented in 'define' help, this is a better default for C++ support
set define="^\(#\s*define\|[a-z]*\s*const\s*[a-z]*\)"

" cycle buffers
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
if has("syntax")
    syntax on
endif

" platform-specific initialization

if has( "unix" )
    " gcc
    set errorformat=\ \ File\ \"%f\"\\,\ line\ %l\\,\ in\ %m
    if version > 500
	set errorformat+=%f:%l:%m
	set grepprg=grep\ -Hn
    endif
    nmap nmap T :!dict <cword><CR> 
    map <F9> :!p4 edit %<CR>
endif

if has("autocmd")
	" jump to last line edited when opening files
	" taken from vim7's debian default vimrc (was: autocmd BufEnter *,.* :normal '")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

	if version > 500
	    augroup cindent
	    au!
	endif
		au BufRead * set formatoptions=tcql nocindent comments&
		au BufRead,BufNewFile *.cc,*.c,*.h,*.cpp,*.java,*.cu set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// nospell
		au BufRead *.scm set lisp nospell
		au BufRead,BufNewFile *.ptx,*.nvir set nospell filetype=nvir
	if version > 500
	    augroup END
	endif

	au BufReadPost .letter %g/^\(Path\|Bytes\|Return-[Pp]ath\|Envelope-to\|Delivery-date\|Delivered-To\|Message-ID\|M[iI][mM][eE]-Version\|Content-Type\|Content-Disposition\|Precedence\|Sender\|Lines\|Xref\|X-Mailer\|X-Accept-Language\|Content-Transfer-Encoding\|X-Mailing-List\):/d

endif

"colorscheme django
"colorscheme advantage
colorscheme blugrine

" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')

function! s:CombineSelection(line1, line2, cp)
	execute 'let char = "\u'.a:cp.'"'
	execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]\%V/&'.char.'/ge'
endfunction
