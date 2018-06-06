" This is a HACK

function! CloseTerminal(prev_window) 
    let n = input('Press Enter to continue...')
    echo ""
    let cargo_win_nr=-1
    windo if bufname('%')=="CARGO BUILD" | let cargo_win_nr=winnr() | endif
    execute cargo_win_nr . 'wincmd q'
    execute a:prev_window . 'wincmd w'
endfunction

function! CargoCmd()
    write
    let l:curwin = winnr()
    let l:fdir = expand('%:p:h')
    botright split
    lcd `=l:fdir`

    let s:exit_closure = {'wn': l:curwin}
    function! s:exit_closure.f(x)
        call CloseTerminal(self.wn)
    endfunction 

    function! ExitCallback(ch, msg)
        call s:exit_closure.f(1)
    endfunction

    let trm_args = { 'term_name': "CARGO BUILD", 'exit_cb': 'ExitCallback', 'curwin': 1 }
    let trm = term_start('cargo run', trm_args) 
endfunction

noremap <leader>re :call CargoCmd()<cr>
