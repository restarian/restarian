set viewoptions-=options

augroup vimrc
    autocmd BufWritePost *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview
    \|  endif
    autocmd BufRead *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif
augroup END

set spell spelllang=en_us
set shiftwidth=3 
set tabstop=3 
set history=500
set smartindent

hi clear SpellBad 
hi clear SpellWrong 
hi clear SpellRare

hi SpellBad cterm=underline
hi SpellWrong ctermfg=004
hi SpellCap ctermfg=010
hi Visual cterm=NONE ctermbg=239 ctermfg=112

function Configure_view()

	let cur_dir = expand('%:p:h')
	let file_name = expand('%:t')

	" The current working directory of the shell which started vim will be checked for a git repository. If one is found, then the vim files will be
	" stored in that location. Otherwise, no view files are created or stored. 
	let project_dir = system('cd ' . cur_dir . '; git rev-parse --show-toplevel 2> /dev/null | sed s/[\\n,\\r,\\t]*$//')
	" This removes the newline from the git rev-parse system output
	let project_dir = substitute(project_dir, '\n*$', '', '') 

	if project_dir != "" 

		if isdirectory(project_dir . "/developers")
			let &viewdir = project_dir . "/developers/vimfiles"
		endif
	
		autocmd BufWritePost *.* mkview!
		autocmd BufWinLeave *.* mkview!
		autocmd BufWinEnter *.* silent loadview .

	endif

endfunction

autocmd BufWinEnter *.* call Configure_view() 
