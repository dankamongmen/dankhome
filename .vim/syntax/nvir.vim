" For version 5.x: Clear all syntax items
" For version 6.0 and later: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn match asmReg0	"v\?R[0-9]*0\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg1	"v\?R[0-9]*1\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg2	"v\?R[0-9]*2\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg3	"v\?R[0-9]*3\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg4	"v\?R[0-9]*4\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg5	"v\?R[0-9]*5\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg6	"v\?R[0-9]*6\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg7	"v\?R[0-9]*7\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg8	"v\?R[0-9]*8\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmReg9	"v\?R[0-9]*9\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmPReg	"P[0-9][0-9]*\(\.B\|\.F\|\.U\?\(I\|L\)\|\([^0-9]\)\@=\)"
syn match asmBB		"BB[0-9][0-9]*\([^0-9]\)\(_\d+\)\@="
syn match nvirNT	".NEXT_TRUE.*"
syn match nvirNF	".NEXT_FALSE.*"
syn match hexconst	"0x\x\+\(\.F\|\.U\?\(I\|L\)\)\?"

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_asm_syntax_inits")
  if version < 508
    let did_asm_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink asmReg0        nvirR0
  HiLink asmReg1        nvirR1
  HiLink asmReg2        nvirR2
  HiLink asmReg3        nvirR3
  HiLink asmReg4	nvirR4
  HiLink asmReg5	nvirR5
  HiLink asmReg6        nvirR6
  HiLink asmReg7        nvirR7
  HiLink asmReg8	nvirR8
  HiLink asmReg9        nvirR9

  HiLink asmPReg	nvirPR
  HiLink asmBB		nvirBB
  HiLink nvirNT		nvirNTH
  HiLink nvirNF		nvirNFH

  HiLink hexconst       Number
  HiLink decconst       Number
  "HiLink octNumber      Number
  "HiLink binNumber      Number

hi Number ctermfg=DarkGreen guifg=DarkGreen
hi nvirR0 ctermfg=Magenta guifg=Magenta
hi nvirR1 ctermfg=Green guifg=Green
hi nvirR2 ctermfg=Cyan guifg=Cyan
hi nvirR3 ctermfg=DarkRed guifg=DarkRed
hi nvirR4 ctermfg=Brown guifg=Brown
hi nvirR5 ctermfg=Yellow guifg=Yellow
hi nvirR6 ctermfg=DarkMagenta guifg=DarkMagenta
hi nvirR7 ctermfg=LightRed guifg=LightRed
hi nvirR8 ctermfg=Grey guifg=Grey
hi nvirR9 ctermfg=Blue guifg=Blue
hi nvirPR  ctermfg=DarkBlue guifg=DarkBlue cterm=bold gui=bold
hi nvirBB  ctermfg=DarkBlue guifg=DarkBlue
hi nvirNTH ctermfg=Black ctermbg=LightGreen guifg=Black guibg=LightGreen
hi nvirNFH ctermfg=Black ctermbg=LightRed guifg=Black guibg=LightRed

  delcommand HiLink
endif

let b:current_syntax = "asm"

" vim: ts=8
