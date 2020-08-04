" Vim syntax file
" For the Pico-8 - modified from the Vim builtin Lua syntax file

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn case match

" syncing method
syn sync minlines=100

" Comments
syn keyword luaTodo    contained TODO FIXME XXX
syn match   luaComment "--.*$" contains=luaTodo,@Spell
syn match   luaComment "//.*$" contains=luaTodo,@Spell
syn region  luaComment matchgroup=luaComment start="--\[\[" end="\]\]" contains=luaTodo,luaInnerComment,@Spell

" catch errors caused by wrong parenthesis and wrong curly brackets or
" keywords placed outside their respective blocks

syn region luaParen transparent start='(' end=')' contains=ALLBUT,luaError,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaCondStart,luaBlock,luaRepeatBlock,luaRepeat,luaStatement
syn match  luaError ")"
syn match  luaError "}"
syn match  luaError "\<\%(end\|else\|elseif\|then\|until\|in\)\>"

" Function declaration
syn region luaFunctionBlock transparent matchgroup=luaFunction start="\<function\>" end="\<end\>" contains=ALL

" if then else elseif end
syn keyword luaCond contained else if

" then ... end
syn region luaCondEnd contained transparent matchgroup=luaCond start="\<then\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaRepeat

" elseif ... then
syn region luaCondElseif contained transparent matchgroup=luaCond start="\<elseif\>" end="\<then\>" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat

" if ... then
syn region luaCondStart transparent matchgroup=luaCond start="\<if\>" end="\<then\>"me=e-4 contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat nextgroup=luaCondEnd skipwhite skipempty

" do ... end
syn region luaBlock transparent matchgroup=luaStatement start="\<do\>" end="\<end\>" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat

" repeat ... until
syn region luaRepeatBlock transparent matchgroup=luaRepeat start="\<repeat\>" end="\<until\>" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat

" while ... do
syn region luaRepeatBlock transparent matchgroup=luaRepeat start="\<while\>" end="\<do\>"me=e-2 contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaRepeat nextgroup=luaBlock skipwhite skipempty

" for ... do and for ... in ... do
syn region luaRepeatBlock transparent matchgroup=luaRepeat start="\<for\>" end="\<do\>"me=e-2 contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd nextgroup=luaBlock skipwhite skipempty

" Following 'else' example. This is another item to those
" contains=ALLBUT,... because only the 'for' luaRepeatBlock contains it.
syn keyword luaRepeat contained in

" other keywords
syn keyword luaStatement return local break goto
syn keyword luaOperator and or not
syn keyword luaConstant nil
syn keyword luaConstant true false

" Strings
syn match  luaSpecial contained "\\[\\abfnrtv\'\"]\|\\\d\{,3}"
syn region luaString2 matchgroup=luaString start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell
syn region luaString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=luaSpecial,@Spell
syn region luaString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=luaSpecial,@Spell

" integer number
syn match luaNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match luaFloat  "\<\d\+\.\d*\%(e[-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match luaFloat  "\.\d\+\%(e[-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match luaFloat  "\<\d\+e[-+]\=\d\+\>"

" hex and binary numbers
syn match luaNumber "\<0x\x\+\>"
syn match luaNumber "\<0b\x\+\>"

" tables
syn region  luaTableBlock transparent matchgroup=luaTable start="{" end="}" contains=ALLBUT,luaTodo,luaSpecial,luaCond,luaCondElseif,luaCondEnd,luaCondStart,luaBlock,luaRepeatBlock,luaRepeat,luaStatement

syn keyword luaFunc flip printh time stat extcmd
syn keyword luaFunc clip pget pset sget sset fget fset
syn keyword luaFunc print cursor color cls camera
syn keyword luaFunc circ circfill line rect rectfill
syn keyword luaFunc pal palt spr sspr fillp
syn keyword luaFunc add del all foreach pairs ipairs
syn keyword luaFunc btn btnp sfx music
syn keyword luaFunc mget mset map tline
syn keyword luaFunc peek poke peek2 poke2 peek4 poke4
syn keyword luaFunc memcpy reload cstore memset
syn keyword luaFunc max min mid flr ceil cos sin atan2
syn keyword luaFunc sqrt abs rnd srand
syn keyword luaFunc band bor bxor bnot shl shr lshr rotl rotr
syn keyword luaFunc menuitem sub tostr tonum chr ord type
syn keyword luaFunc cartdata dset dget serial stat
syn keyword luaFunc setmetatable getmetatable
syn keyword luaFunc rawset rawget rawequal rawlen
syn keyword luaFunc cocreate coresume costatus yield assert
syn keyword luaFunc pack unpack
syn keyword luaFunc oval ovalfill split deli

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_lua_syntax_inits")
    command -nargs=+ HiLink hi def link <args>

    HiLink luaStatement	Statement
    HiLink luaRepeat	Repeat
    HiLink luaString	String
    HiLink luaString2	String
    HiLink luaNumber	Number
    HiLink luaFloat		Float
    HiLink luaOperator	Operator
    HiLink luaConstant	Constant
    HiLink luaCond		Conditional
    HiLink luaFunction	Function
    HiLink luaComment	Comment
    HiLink luaTodo		Todo
    HiLink luaTable		Structure
    HiLink luaError		Error
    HiLink luaSpecial	SpecialChar
    HiLink luaFunc		Identifier

    delcommand HiLink
endif

let b:current_syntax = "lua"
