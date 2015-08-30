function zdot = fun(t, z, const)
    z1 = z(1);
    z2 = z(2);
    beta = const(1);
    epsilon = const(2);
    omega = const(3);
    zdot = [z(2); -beta*z2 + (omega^2 - epsilon*cos(t))*sin(z1)];

endfunction

function [T Z] = rk4(t0, tf, paso, z0, const)
    M = (tf-t0)/paso;
    N = length(z0);
    T = zeros(M+1, 1);
    Z = zeros(M+1, N);
    K_1 = zeros(1,  N);
    K_2 = zeros(1, N);
    K_3 = zeros(1, N);
    K_4 = zeros(1, N);
    T = t0:paso:tf;
    T = T';

    for i = 1:N
        Z(1, i) = z0(i);
        endfor

    for j = 1:M
        K_1(1, :) = paso * fun(T(j),Z(j, :), const);
        K_2(1, :) = paso * fun(T(j) + paso/2, Z(j, :) + K_1(1, :)/2, const);
        K_3(1, :) = paso * fun(T(j) + paso/2, Z(j, :) + K_2(1, :)/2, const);
        K_4(1, :) = paso * fun(T(j) + paso, Z(j, :) + K_3(1, :), const);

        Z(j+1, :) = Z(j, :) + 1/6*(K_1(1, :) + 2*K_2(1, :) + 2*K_3(1, :) + K_4(1, :));
        endfor
    endfunction

######################################CALCULOS###########################################

const = [0.1, 0.1, 0.05;
         0.1, 0.1, 0.01;
         0.1, 0.1, 0.01;
         0.1, 0.1, 0.01;
         0.1, 0.1, 0.1;
         0.1, 0.1, 0.1;
         ];
ciniciales = [0.1, -0.1;
              0.2, -0.2;
              0.05, -0.05;
              0.1, -0.1;
              0.1, -0.1;
              0.01, -0.01;
              ];

nombres = ["rk41"; "rk42"; "rk43"; "rk44"; "rk45"; "rk46"];
extension = ".png";
paso = 0.05;
paso1 = 0.1;
paso2 = 0.5;
t0 = 0;
tf = 200;
for i = 1:6       
    [vt, vz] = rk4(t0,tf, paso, ciniciales(i, [1,2]), const(i, [1,2,3]));        
    [vt1, vz1] = rk4(t0,tf, paso1, ciniciales(i, [1,2]), const(i, [1,2,3]));            
    [vt2, vz2] = rk4(t0, tf, paso2, ciniciales(i, [1,2]), const(i, [1,2,3]));                
    plot(vt, vz(:, 1), '-k');                    
    hold on
    plot(vt1, vz1(:, 1), '--r');                            
    plot(vt2, vz2(:, 1), ':b');                                
    xlabel('Tiempo / s');                                    
    print(strcat(nombres(i,:), extension));                                        
    hold off                                            
    endfor

