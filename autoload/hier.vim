function! s:Getlist(winnr, type)
	if a:type == 'qf'
		return getqflist()
	else
		return getloclist(a:winnr)
	endif
endfunction

let s:hier_highlight_group_list = [
	\	g:hier_highlight_group_qf,
	\	g:hier_highlight_group_qfw,
	\	g:hier_highlight_group_qfi,
	\	g:hier_highlight_group_loc,
	\	g:hier_highlight_group_locw,
	\	g:hier_highlight_group_loci]

function! hier#hier(clearonly)
	for m in getmatches()
		for h in s:hier_highlight_group_list
			if m.group == h
				try
					call matchdelete(m.id)
				catch
				endtry
			endif
		endfor
	endfor

	if g:hier_enabled == 0 || a:clearonly == 1
		return
	endif

	let bufnr = bufnr('%')

	for type in ['qf', 'loc']
		for i in s:Getlist(0, type)
			if i.bufnr == bufnr
				let hi_group = get(g:, 'hier_highlight_group_'.type)
				if i.type == 'I' || i.type == 'info'
					let hi_group = get(g:, 'hier_highlight_group_'.type.'i')
				elseif i.type == 'W' || i.type == 'warning'
					let hi_group = get(g:, 'hier_highlight_group_'.type.'w')
				elseif get(g:, 'hier_highlight_group_'.type) == ""
					continue
				endif
        let lastcol = col([i.lnum, '$'])
				if i.lnum > 0 && i.col
					let c = (lastcol == i.col) ? i.col - 2 : i.col - 1
					call matchadd(hi_group, '\%'.i.lnum.'l\%>' . c . 'c\%<' . lastcol . 'c')
				elseif i.lnum > 0
					call matchadd(hi_group, '\%'.i.lnum.'l\%<' . lastcol . 'c')
				elseif i.pattern != ''
					call matchadd(hi_group, i.pattern)
				endif
			endif
		endfor
	endfor
endfunction
