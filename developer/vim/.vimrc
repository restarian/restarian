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

let project_dir = system('git rev-parse --show-toplevel 2> /dev/null | sed s/[\\n,\\r,\\t]*$//')

if project_dir =~ '/..*/'
	let project_dir = substitute(project_dir, '\n*$', '', '') . "/vim_view_file.cfg"
endif

exec "autocmd BufWritePost *.* mkview! " . project_dir
exec "autocmd BufWinEnter *.* silent loadview " . project_dir


