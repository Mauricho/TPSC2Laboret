clc; clear all; close all;

% SIMULACIÓN LINEAL

%Datos asignados:
disp("Datos asignados: ")
 p1 = 1  ;    %Polo 1
 p2 = -3 ;    %Polo 2
 K  = 5  ;    %Ganancia
 T2 = 2  ;    %Tiempo de respuesta 2%
 
disp("Función de Transferencia");
G = zpk([],[p1 p2],K)

disp("Controlador");
C = zpk([-3],[],0.57668)

disp("Datos Simulación de Simulink:")
Kc = 0.57668;             % Ganancia del controlador
a = 3;                    % Cero del controlador con cero invertido
M = 1;                    % Ganancia Relé 
T = 0.1;                  % Histéresis 
lineal = 1;               % Simual el control lineal

sim('bang_bang_hist_DI_PD')

% Gráficas
figure(1)  ;   
plot(tout,yout(:,1)) ;   %Error

figure(2)  ;   
plot(yout(:,1),yout(:,3)) ;%Plano de fases: eje x error, eje y derivada del error

figure(3)  ;   
plot(tout,yout(:,2)) ;   %Señal de control

