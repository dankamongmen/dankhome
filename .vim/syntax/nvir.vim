" For version 5.x: Clear all syntax items
" For version 6.0 and later: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn match asmReg0	"R[0-9]*0\([^0-9]\)\@="
syn match asmReg1	"R[0-9]*1\([^0-9]\)\@="
syn match asmReg2	"R[0-9]*2\([^0-9]\)\@="
syn match asmReg3	"R[0-9]*3\([^0-9]\)\@="
syn match asmReg4	"R[0-9]*4\([^0-9]\)\@="
syn match asmReg5	"R[0-9]*5\([^0-9]\)\@="
syn match asmReg6	"R[0-9]*6\([^0-9]\)\@="
syn match asmReg7	"R[0-9]*7\([^0-9]\)\@="
syn match asmReg8	"R[0-9]*8\([^0-9]\)\@="
syn match asmReg9	"R[0-9]*9\([^0-9]\)\@="
syn match asmPReg	"P[0-9][0-9]*\([^0-9]\)\@="
syn match asmBB		"BB[0-9][0-9]*\([^0-9]\)\@="
syn match nvirNT	".NEXT_TRUE.*"
syn match nvirNF	".NEXT_FALSE.*"

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
  HiLink asmReg0     Special
  HiLink asmReg1       Todo
  HiLink asmReg2     Comment
  HiLink asmReg3        Error
  HiLink asmReg4	nvirR4
  HiLink asmReg5	Include
  HiLink asmReg6        nvirR6
  HiLink asmReg7       Macro
  HiLink asmReg8	nvirR8
  HiLink asmReg9        Type

  HiLink asmPReg	Conditional
  HiLink asmBB		Label
  HiLink nvirNT		nvirNTH
  HiLink nvirNF		nvirNFH

  "HiLink hexNumber      Number
  "HiLink decNumber      Number
  "HiLink octNumber      Number
  "HiLink binNumber      Number

  if &background == "dark"
  	hi Conditional ctermfg=DarkGreen guifg=SeaGreen gui=bold
	hi Label ctermfg=Black guifg=Black ctermbg=Yellow guibg=Yellow gui=italic cterm=italic
	hi nvirR4 ctermfg=Brown guifg=Brown
	hi nvirR6 ctermfg=DarkMagenta guifg=DarkMagenta
	hi nvirR8 ctermfg=LightGrey guifg=LightGrey
	hi nvirNTH ctermfg=Black ctermbg=LightGreen guifg=Black guibg=LightGreen
	hi nvirNFH ctermfg=Black ctermbg=LightRed guifg=Black guibg=LightRed
  else
  	hi Conditional ctermfg=DarkGreen guifg=SeaGreen gui=bold
	hi Label ctermfg=Black guifg=Black ctermbg=Yellow guibg=Yellow gui=italic cterm=italic
	hi nvirR4 ctermfg=Brown guifg=Brown
	hi nvirR6 ctermfg=DarkMagenta guifg=DarkMagenta
	hi nvirNTH ctermfg=Black ctermbg=LightGreen guifg=Black guibg=LightGreen
	hi nvirNFH ctermfg=Black ctermbg=LightRed guifg=Black guibg=LightRed
  endif

  delcommand HiLink
endif

let b:current_syntax = "asm"

" vim: ts=8
