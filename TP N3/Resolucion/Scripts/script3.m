clc; clear all; close all;

% SIMULACIÓN NO LINEAL

%Datos asignados:
disp("Datos asignados: ")
p1 = 1  ;    %Polo 1
p2 = -3 ;    %Polo 2
K  = 5  ;    %Ganancia
T2 = 2  ;    %Tiempo de respuesta 2%
 
disp("Datos Simulación de Simulink:")
Kc = 0.57668*2;           % Ganancia del controlador
a = 3;                    % Cero del controlador con cero invertido
M = Kc;                   % Relé es la Ganancia relé += ganancia Kc
T = K*Kc/100;             % Histéresis 
lineal = 0;               % Simual el control lineal

sim('bang_bang_hist_DI_PD')

% Gráficas
figure(1)  ;   
plot(tout,yout(:,1)) ;   %Error

figure(2)  ;   
plot(yout(:,1),yout(:,3)) ;%Plano de fases: eje x error, eje y derivada del error

figure(3)  ;   
plot(tout,yout(:,2)) ;   %Señal de control