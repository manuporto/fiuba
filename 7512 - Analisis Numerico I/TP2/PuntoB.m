# Instrucciones:
# 1) PuntoBn representa cada tipo de funcion, dependiendo de los valores de Beta,
# Epsilon y Omega elegidos. Elegir la funcion deseada.
# 2) Cada PuntoBn tiene una serie de condiciones iniciales que se le puede 
# asignar. Las condiciones fueron separadas y agrupadas con distintos PuntoBn 
# segun el enunciado. Es decir que se puede usar cualquier condicion inicial con 
# cualquiera de las funciones.

# w = 0.05
PuntoB1 = @(t,y) [y(2); -0.1*y(2) + (0.05^2 - 0.1*cos(t))*sin(y(1))];
# B1 condiciones iniciales
y = [0.1 -0.1];

# w = 0.01
PuntoB2 = @(t,y) [y(2); -0.1*y(2) + (0.01^2 - 0.1*cos(t))*sin(y(1))];
# B2 condiciones iniciales
y2 = [0.2 -0.2];
y3 = [0.05 -0.05];
y4 = y;

# w = 0.1
PuntoB3 = @(t,y) [y(2); -0.1*y(2) + (0.1^2 - 0.1*cos(t))*sin(y(1))];
# B3 condiciones iniciales
y5 = y;
y6 = [0.01 -0.01];

T = [0 200];
ciniciales = [0.1, -0.1;
              0.2, -0.2;
              0.05, -0.05;
              0.1, -0.1;
              0.1, -0.1;
              0.01, -0.01;
              ];
nombres = ["b1"; "b2"; "b3"; "b4"; "b5"; "b6"];
extension = ".png";

#########################RESULTADOS##################################

# b1
[vt, vy] = ode23(PuntoB1, T, ciniciales(1, :));
[vt1, vy1] = ode45(PuntoB1, T, ciniciales(1, :));
plot(vt,vy(:,1),'-k');
hold on
plot(vt1,vy1(:,1),'--r');
xlabel('Tiempo / s');
print(strcat(nombres(1,:), extension));
hold off

# b2 - b4
for i = 2:4
    [vt, vy] = ode23(PuntoB2, T, ciniciales(i, :));
    [vt1, vy1] = ode45(PuntoB2, T, ciniciales(i, :));
    plot(vt,vy(:,1),'-k');
    hold on
    plot(vt1,vy1(:,1),'--r');
    xlabel('Tiempo / s');
    print(strcat(nombres(i,:), extension));
    hold off
endfor

# b5 - b6
for i = 5:6
    [vt, vy] = ode23(PuntoB3, T, ciniciales(i, :));
    [vt1, vy1] = ode45(PuntoB3, T, ciniciales(i, :));
    plot(vt,vy(:,1),'-k');
    hold on
    plot(vt1,vy1(:,1),'--r');
    xlabel('Tiempo / s');
    print(strcat(nombres(i,:), extension));
    hold off
endfor
