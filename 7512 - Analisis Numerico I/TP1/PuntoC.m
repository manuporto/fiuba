function [resultado_final] = erf_taylor(x, n)
    k = 0;
    error = 10^(-n);
    constante = 2/sqrt(pi);
    kiesimo_termino = calculo_kiesimo_termino(x, k);
    resultado_temporal = kiesimo_termino;
    while (abs(kiesimo_termino) > error)
        k++;
        kiesimo_termino = calculo_kiesimo_termino(x, k);
        resultado_temporal += kiesimo_termino;
    endwhile

    resultado_final = constante * resultado_temporal;
        
endfunction

function [resultado] = calculo_kiesimo_termino(x, k)
    resultado = ((-1)^k * x^(2 * k + 1))/((2 * k + 1) * factorial(k));
endfunction
