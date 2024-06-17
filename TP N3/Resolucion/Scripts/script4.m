clc; clear all; close all;

% Comparación de los dos sistemas
p1 = 1  ;    %Polo 1
p2 = -3 ;    %Polo 2
K  = 5  ;    %Ganancia
T2 = 2  ;    %Tiempo de respuesta 2%

% SIMULACIÓN LINEAL
disp("Datos Simulación de Simulink:")
Kc = 0.57668;             % Ganancia del controlador
a = 3;                    % Cero del controlador con cero invertido
M = 1;                    % Ganancia Relé 
T = 0.1;                  % Histéresis 
lineal = 1;               % Simual el control lineal
sim('bang_bang_hist_DI_PD')

% Trazamos la salida lineal
figure(1);
%plot(tout,yout(:,4))      % Respuesta
plot(tout,yout(:,1))       % Error 
hold on;

% SIMULACIÓN NO LINEAL
Kc = 0.57668*2;           % Ganancia del controlador
a = 3;                    % Cero del controlador con cero invertido
M = Kc;                   % Relé es la Ganancia relé += ganancia Kc
T = K*Kc/100;             % Histéresis 
lineal = 0;               % Simual el control lineal
sim('bang_bang_hist_DI_PD')

% Trazamos la salida no lineal
%plot(tout,yout(:,4))      % Respuesta
plot(tout,yout(:,1))       % Error

% SIMULACIÓN NO LINEAL --> T 25 veces menos
Kc = 0.57668*2;           % Ganancia del controlador
a = 3;                    % Cero del controlador con cero invertido
M = Kc;                   % Relé es la Ganancia relé += ganancia Kc
T = K*Kc/25;              % Histéresis 
lineal = 0;               % Simual el control lineal
sim('bang_bang_hist_DI_PD')

% Trazamos la salida no lineal
% plot(tout,yout(:,4))      % Respuesta
plot(tout,yout(:,1))      % Error

% SIMULACIÓN NO LINEAL --> T 10 veces menos
Kc = 0.57668*2;           % Ganancia del controlador
a = 3;                    % Cero del controlador con cero invertido
M = Kc;                   % Relé es la Ganancia relé += ganancia Kc
T = K*Kc/10;              % Histéresis 
lineal = 0;               % Simual el control lineal
sim('bang_bang_hist_DI_PD')

% Trazamos la salida no lineal
% plot(tout,yout(:,4))      % Respuesta
plot(tout,yout(:,1))      % Error

legend('Sistema Lineal','Sistema No Lineal T/100','Sistema No Lineal T/25','Sistema No Lineal T/10');
grid on;
hold on;