" Enable filetype plugins
filetype plugin on
filetype indent on

syntax enable
colorscheme desert
set background=dark

if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

command W w !sudo tee % > /dev/null
