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

let cur_dir = expand('%:p:h')
let file_name = expand('%:t')

let project_dir = system('git rev-parse --show-toplevel 2> /dev/null | sed s/[\\n,\\r,\\t]*$//')
" This removes the newline from the git rev-parse output

let project_dir = substitute(project_dir, '\n*$', '', '')
let is_in = system("find " . project_dir . " -type d -not -path '*/\.*' -path " . cur_dir)

" Do not create views for hidden files
if file_name !~ '^\..*' && is_in != ""
	if isdirectory(project_dir . "/developers")
		let &viewdir = project_dir . "/developers/vimfiles"
	else
		let &viewdir = project_dir . "/vimfiles"
	endif
		autocmd BufWritePost *.* mkview!
		autocmd BufWinLeave *.* mkview!
		autocmd BufWinEnter *.* silent loadview 
endif

