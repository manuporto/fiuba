function [resultado_final] = erf_b(x, n)
    k = 0;
    error = 10^(-n);
    constante = (2/sqrt(pi)) * exp(-(x)^2);
    kiesimo_termino = calculo_kiesimo_termino_erf_b(x, k);
    resultado_temporal = kiesimo_termino;
    while (abs(kiesimo_termino) > error)
        k++;
        kiesimo_termino = calculo_kiesimo_termino_erf_b(x, k);
        resultado_temporal += kiesimo_termino;
    endwhile

    resultado_final = constante * resultado_temporal;
        
endfunction

function [resultado] = calculo_kiesimo_termino_erf_b(x, k)
    denominador = 1
    for i = 0:k
        denominador *= (2 * i + 1);
    endfor
    resultado = (2^k * x ^(2 * k + 1))/denominador
endfunction

solucion_1 = erf_b(1, 4);
solucion_2 = erf_b(1, 6);
solucion_3 = erf_b(1, 8);

printf("%f \n", solucion_1);
printf("%f \n", solucion_2);
printf("%f \n", solucion_3);
