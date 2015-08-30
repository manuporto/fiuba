############################# Punto C ################################

function [resultado_final] = erf_a(x, n)
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

############################# Punto D ################################

function [resultado_final] = erf_d(x, n)
    k = 0;
    error = 10^(-n);
    constante = (2/sqrt(pi)) * exp(-(x)^2);
    kiesimo_termino = calculo_kiesimo_termino_erf_d(x, k);
    resultado_temporal = kiesimo_termino;
    while (abs(kiesimo_termino) > error)
        k++;
        kiesimo_termino = calculo_kiesimo_termino_erf_d(x, k);
        resultado_temporal += kiesimo_termino;
    endwhile

    resultado_final = constante * resultado_temporal;
        
endfunction

function [resultado] = calculo_kiesimo_termino_erf_d(x, k)
    denominador = 1;
    for i = 0:k
        denominador *= (2 * i + 1);
    endfor
    resultado = (2^k * x ^(2 * k + 1))/denominador;
endfunction

############################# Punto E ################################

function [resultado_final] = erf_e(n, alpha, c)
    sumatoria = 0;
    
    for i = 1:n
        sumatoria += c(i) * e^(-((alpha(i))**2)); 
    endfor

    resultado_final = sumatoria * 1/sqrt(pi);

endfunction

############################# Resultados ################################

printf("Resultados del Punto C. \n");
solucion_c_1 = erf_a(1, 4);
solucion_c_2 = erf_a(1, 6);
solucion_c_3 = erf_a(1, 8);

printf("Con n = 4: %f \n", solucion_c_1);
printf("Con n = 6: %f \n", solucion_c_2);
printf("Con n = 8: %f \n", solucion_c_3);
printf("\n");

printf("Resultados del Punto D. \n");
solucion_d_1 = erf_d(1, 4);
solucion_d_2 = erf_d(1, 6);
solucion_d_3 = erf_d(1, 8);

printf("Con n = 4: %f \n", solucion_d_1);
printf("Con n = 6: %f \n", solucion_d_2);
printf("Con n = 8: %f \n", solucion_d_3);
printf("\n");

printf("Resultados del Punto E. \n");
solucion_e_1 = erf_e(2, [0.5773502692, -0.5773502692],                                  [1, 1]);
solucion_e_2 = erf_e(3, [0.7745966692, 0, -0.7745966692],                               [0.5555555556, 0.8888888889, 0.5555555556]);
solucion_e_3 = erf_e(4, [0.8611363116, 0.3399810436, -0.3399810436, -0.8611363116],     [0.3478548451, 0.6521451549, 0.6521451549, 0.3478548451]);
solucion_e_4 = erf_e(5, [0.9061798459, 0.5384693101, 0, -0.5384693101, -0.9061798459],  [0.2369268850, 0.4786286705, 0.5688888889, 0.4786286705, 0.2369268850]);

printf("Con n = 2: %f \n", solucion_e_1);
printf("Con n = 3: %f \n", solucion_e_2);
printf("Con n = 4: %f \n", solucion_e_3);
printf("Con n = 5: %f \n", solucion_e_4);
printf("\n");

############################# Punto G ################################

printf("Resultados Punto G (erf(4)) \n");
solucion_c_1 = erf_a(4, 4);
solucion_c_2 = erf_a(4, 6);
solucion_c_3 = erf_a(4, 8);

printf("Serie A con n = 4: %f \n", solucion_c_1);
printf("Serie A con n = 6: %f \n", solucion_c_2);
printf("Serie A con n = 8: %f \n", solucion_c_3);
printf("\n");

solucion_d_1 = erf_d(4, 4);
solucion_d_2 = erf_d(4, 6);
solucion_d_3 = erf_d(4, 8);

printf("Serie B con n = 4: %f \n", solucion_d_1);
printf("Serie B con n = 6: %f \n", solucion_d_2);
printf("Serie B con n = 8: %f \n", solucion_d_3);
printf("\n");
