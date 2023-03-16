function! Writer ()
		setlocal spell spelllang=en_us
		setlocal formatoptions=t1
		setlocal textwidth=80
		setlocal noautoindent
		setlocal shiftwidth=5
		setlocal tabstop=5
endfunction

com! WR call Writer()

