augroup pyformatting
    autocmd!
    "autocmd BufWritePre *.py execute ':Black'
    autocmd BufWritePre *.py Black
augroup end
