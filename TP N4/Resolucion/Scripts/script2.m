clc;
clear all;
close all;

% Datos iniciales
m = 2;          % masa inicial
b = 0.4;        % coeficiente de rozamiento
l = 1;          % longitud
G = 10;         % constante gravitatoria
delta = 180;    % ángulo de referencia

% Parámetros para variar la masa (10% arriba y abajo del valor inicial)
m_values = m * [0.9, 1, 1.1];

% Inicialización de matrices para almacenar resultados
num_iteraciones = length(m_values);
resultados = cell(num_iteraciones, 1);

% Ciclo para iterar sobre diferentes valores de masa
for i = 1:num_iteraciones
    % Asignar el valor de masa actual
    m_current = m_values(i);
    
    % Calcular el modelo lineal del sistema con el valor actual de masa
    [A,B,C,D] = linmod('pendulo_mod_tarea', delta*pi/180);
    
    % Verificar controlabilidad del sistema
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
    
    % Verificar controlabilidad del sistema ampliado
    if rank(ctrb(Aa, Ba)) == size(Aa, 1)
        disp('El sistema ampliado es completamente controlable');
    else
        disp('El sistema ampliado no es completamente controlable');
    end
    
    % Posiciones de los polos deseados
    p1 = -2 ; % posición del polo triple
    p2 = p1 ;
    p3 = p2 ;
    
    % Calcular el controlador usando Ackermann
    K = acker(Aa,Ba,[p1 p2 p3]);
    
    % Descomponer K en k1, k2, k3
    k1 = K(1);
    k2 = K(2);
    k3 = K(3);
    
    % Verificar la ubicación de los polos asignados
    disp('Verificación de la ubicación de los polos asignados: ');
    eig(Aa-Ba*K);
    
    % Calcular tiempo de respuesta
    tscalc = 7.5/(-p1); % Tiempo de respuesta
    
    % Simulación del sistema con el modelo
    sim('pendulo_pid_tarea');
    
    % Obtener variables de la simulación
    yout_sim = yout;
    velocidad_sim = velocidad;
    torque_sim = torque;
    accint_sim = accint;
    tout_sim = tout;
    
    % Calcular métricas adicionales
    ymax = max(yout_sim); % máximo valor de salida
    S = (ymax - delta)/delta*100; % sobrepaso en %
    erel = (delta - yout_sim)/delta; % error relativo
    efinal = erel(end); % error final, debe ser cero
    ind = find(abs(erel)>0.02); % índice elementos con error relativo absoluto menor a 2%
    tss = tout_sim(ind(end)); % tiempo de establecimiento (último valor del vector)
    yte = yout_sim(ind(end)); % salida al tiempo ts
    uf = torque_sim(end); % torque final
    intf = -accint_sim(end); % acción integral final
    
    % Guardar resultados en la celda de resultados
    resultados{i} = struct('ymax', ymax, 'S', S, 'efinal', efinal, ...
        'tss', tss, 'yte', yte, 'uf', uf, 'intf', intf);
    
    % Gráficos para la masa actual
    figure(1);
    hold on;
    plot(tout_sim, yout_sim, 'DisplayName', sprintf('masa = %.2f', m_current));
    title('Salida');
    xlabel('Tiempo');
    ylabel('Salida yout');
    legend('-DynamicLegend');  % Actualiza la leyenda automáticamente
    grid on;
    
    figure(2);
    hold on;
    plot(yout_sim, velocidad_sim, 'DisplayName', sprintf('masa = %.2f', m_current));
    title('Plano de fase');
    xlabel('Salida yout');
    ylabel('Velocidad');
    legend('-DynamicLegend');
    grid on;
    
    figure(3);
    hold on;
    plot(tout_sim, torque_sim, 'DisplayName', sprintf('masa = %.2f', m_current));
    title('Torque');
    xlabel('Tiempo');
    ylabel('Torque');
    legend('-DynamicLegend');
    grid on;
    
    figure(4);
    hold on;
    plot(tout_sim, -accint_sim, 'DisplayName', sprintf('masa = %.2f', m_current));
    title('Acción integral');
    xlabel('Tiempo');
    ylabel('Acción integral');
    legend('-DynamicLegend');
    grid on;
    
end

% Ajustar leyendas y otros detalles finales fuera del ciclo
figure(1);
legend('show');
hold off;

figure(2);
legend('show');
hold off;

figure(3);
legend('show');
hold off;

figure(4);
legend('show');
hold off;

% Acceder a los resultados almacenados
for i = 1:num_iteraciones
    fprintf('Resultados para masa %.2f:\n', m_values(i));
    fprintf('ymax = %.4f\n', resultados{i}.ymax);
    fprintf('S = %.4f\n', resultados{i}.S);
    fprintf('efinal = %.4f\n', resultados{i}.efinal);
    fprintf('tss = %.4f\n', resultados{i}.tss);
    fprintf('yte = %.4f\n', resultados{i}.yte);
    fprintf('uf = %.4f\n', resultados{i}.uf);
    fprintf('intf = %.4f\n\n', resultados{i}.intf);
end
