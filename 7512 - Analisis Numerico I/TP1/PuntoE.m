function [resultado_final] = erf_cuadratura_de_gauss(n, alpha, c)
	sumatoria = 0;
	
	for i = 1:n
		sumatoria += c(i) * e^(-((alpha(i))**2)); 
	endfor

	resultado_final = sumatoria * 1/sqrt(pi);

endfunction

resultado = erf_cuadratura_de_gauss(2, [0.5773502692, -0.5773502692], [1, 1]);
printf("erf(1) con cuadratura de gauss :  %f \n", resultado);

resultado = erf_cuadratura_de_gauss(3, [0.7745966692, 0, -0.7745966692], [0.5555555556, 0.8888888889, 0.5555555556]);
printf("erf(1) con cuadratura de gauss :  %f \n", resultado);

resultado = erf_cuadratura_de_gauss(4, [0.8611363116, 0.3399810436, -0.3399810436, -0.8611363116], [0.3478548451, 0.6521451549, 0.6521451549, 0.3478548451]);
printf("erf(1) con cuadratura de gauss :  %f \n", resultado);

resultado = erf_cuadratura_de_gauss(5, [0.9061798459, 0.5384693101, 0, -0.5384693101, -0.9061798459], [0.2369268850, 0.4786286705, 0.5688888889, 0.4786286705, 0.2369268850]);
printf("erf(1) con cuadratura de gauss :  %f \n", resultado);
