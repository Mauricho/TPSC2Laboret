
 % Titulo: Tarea 1 Laboret
 % Materia: Sistema de Control 2
 % Alumno: Mugni Juan Mauricio
 %Software empleado: Matlab R2020a

 %Datos asignados:
 p1 = -1;   %Polo 1
 p2 = -3;   %Polo 2
 k  = 10;   %Ganancia
 Mp = 10; %Sobrepasamiento
 T2 = 4;    %Tiempo de respuesta 2%
 Tm = 0.12; %Periodo de muestreo
 E = 0;     %Error
 
 %Obtenemos la función de transferencia continua G(s)
 G=zpk([],[p1 p2],k);
 
 %Hallar la FT discreta de lazo abierto Gd(s) del sistema de la figura con
 % Z0H a la entrada y el tiempo de muestreo asignado Tm.
 Gd=c2d(G,Tm,'zoh'); %FT discreta de lazo abierto Gd(s) para Tm
 
 %Dibujamos el mapa de polos y ceros del sistema continuo
 pzmap(G)
 
 %Dibujamos el mapa de polos y ceros del sistema discreto
 pzmap(Gd);
 
 %¿Qué ocurre con el mapa si se multiplica por 10 el periodo de muestreo?
 Tm1 = Tm * 10; %Multiplicamos por 10 el periodo de muestreo
 Gd1 = c2d(G,Tm1,'zoh'); %FT discreta de lazo abierto Gd(s) para Tm1
 
 %Dibujamos el mapa de polos y ceros del nuevo sistema discreto
 pzmap(Gd1);
 
 %Obtener la respuesta al escalón del sistema discreto y determinar si es
 %estable.
 step(G);       %Para el sistema continuo
 step(Gd);      %Para el sistema discreto
 step(Gd1);     %Para el 2° sistema discreto
 
 %Determinar el tipo de sistema.
 %ES UN SISTEMA CRITICAMENTE AMORTIGUADO
 
 %Determinar la constante de error de posición Kp y el error ante un
 %escalón y verificar mediante la respuesta al escalón de lazo cerrado del
 %sistema discreto como se muestra.
 
 Kp=dcgain(Gd);
 F=feedback(Gd,1); %Lazo cerrado
 step(F);
 
 %Verificar error ante una rampa de entrada, ¿converge o diverge?
 %Expliquela causa
 t=0:Tm:100*Tm; %Genera la rampa
 lsim(F,t,t);
 
 %Graficar el lugar de raíces del sistema continuo G(s) y del discreto
 %Gd(s)indicando las ganacias criticas de estabilidad si las hubiera.
 G=zpk([],[p1 p2],k);   %Función de transferencia continua
 Gd=c2d(G,Tm,'zoh');
 Gd1=c2d(G,Tm1,'zoh');
 %rlocus(G);
 %rlocus(Gd)
 rlocus(Gd1)
%  
%  %¿Qué ocurre con la estabilidad relativa si se aumenta 10 veces el tiempo 
%  % de muestreo original?
%  rlocus=(Gd1)%
%  
 

