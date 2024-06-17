clc; clear all; close all;
% Datos
m = 2;          % masa
mnom = m; % masa nominal 
m = 1.1*mnom;
b = 0.4;        % coeficiente de rozamiento
l = 1;          % longitud
G = 10;         % constante gravitatoria
delta = 180;    % ángulo de referencia

[A,B,C,D] = linmod('pendulo_mod_tarea',delta*pi/180);

eig(A);          % Calculo los valores propios de la matriz A

rank(ctrb(A,B)); % Calculo el rango de la matriz controlabilidad

if rank(ctrb(A,B)) == rank(A)
    disp('El sistema es completamente controlable');
else
    disp('El sistema no es completamente controlable');
end

% Matrices ampliadas
Aa = [A, zeros(size(A,1), 1); 
      C, 0];
Ba = [B; 
      0];

% Cálculo de los valores propios de la matriz ampliada
eigenvalues = eig(Aa);

% Cálculo del rango de la matriz de controlabilidad ampliada
if rank(ctrb(Aa, Ba)) == size(Aa, 1)
    disp('El sistema ampliado es completamente controlable');
else
    disp('El sistema ampliado no es completamente controlable');
end

p1 = -2 ; % posición del polo triple
p2 = p1 ;
p3 = p2 ;

% Se calcula el controlador aplicando Ackermann
K = acker(Aa,Ba,[p1 p2 p3]);

k1 = K(1);
k2 = K(2);
k3 = K(3);

disp('Verificación de la ubicación de los polos asignados: ');
eig(Aa-Ba*K)

tscalc = 7.5/(-p1) % Tiempo de respuesta

sim('pendulo_pid_tarea')

% Gráficos
figure(1);
plot(tout, yout);
title('Salida');
legend('masa m%')
grid on;

figure(2);
plot(yout, velocidad); % Plano de fase
title('Plano de fase')
legend('masa m%')
grid on;

figure(3);
plot(tout, torque);
title('Torque'); % Torque
legend('masa m%')
grid on;

figure(4);
plot(tout, -accint); % Acción integral
title('Acción integral');
legend('masa m%')
grid on;

ymax = max(yout); % máximo valor de salida
S = (ymax - delta)/delta*100; % sobrepaso en %
erel = (delta - yout)/delta; % error relativo
efinal = erel(end); % error final, debe ser cero
ind = find(abs(erel)>0.02); % índice elementos con error relativo absoluto menor a 2%
tss = tout(ind(end)); % tiempo de establecimiento (último valor del vector)
yte = yout(ind(end)); % salida al tiempo ts
uf = torque(end); % torque final
intf = -accint(end); % acción integral final



