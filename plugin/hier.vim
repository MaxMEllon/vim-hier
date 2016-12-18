" hier.vim:		Highlight quickfix errors
" Last Modified: Tue 03. May 2011 10:55:27 +0900 JST
" Author:		Jan Christoph Ebersbach <jceb@e-jc.de>
" Version:		1.3

if (exists("g:loaded_hier") && g:loaded_hier) || &cp
    finish
endif
let g:loaded_hier = 1

let g:hier_enabled = get(g:, 'hier_enabled', 1)
let g:hier_highlight_group_qf  = get(g:, 'hier_highlight_group_qf', 'SpellBad')
let g:hier_highlight_group_qfw = get(g:, 'hier_highlight_group_qfw', 'SpellLocal')
let g:hier_highlight_group_qfi = get(g:, 'hier_highlight_group_qfi', 'SpellRare')
let g:hier_highlight_group_loc	= get(g:, 'hier_highlight_group_loc', 'SpellBad')
let g:hier_highlight_group_locw = get(g:, 'hier_highlight_group_locw', 'SpellLocal')
let g:hier_highlight_group_loci = get(g:, 'hier_highlight_group_loci', 'SpellRare')

command! -nargs=0 HierUpdate call hier#hier(0)
command! -nargs=0 HierClear  call hier#hier(1)

command! -nargs=0 HierStart let g:hier_enabled = 1 | HierUpdate
command! -nargs=0 HierStop let g:hier_enabled = 0 | HierClear

augroup Hier
	au!
	au QuickFixCmdPost,BufEnter,WinEnter * :HierUpdate
augroup END
