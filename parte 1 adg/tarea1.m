%TAREA 1 
%1
%para comenzar, primero subire el archivo ANCUD.txt al workspace
%para eso, primero borro los comentarios del inicio manualmente 
%tambien la designare como B,para posteriormente asignarla como 
%A que es de la forma que se pide en el enunciado de la tarea 
% 
B=readmatrix('ANCUD.txt'); %ocupo la función readmatrix que me cambia los * 
%por NaN automaticamente 

%elimino las filas de datos antes del 2000
B([1,2,3,4,5,6,7,8,9],:)=[]; 
%esto nos sirve por que mas adelante trabajaremos con los datos  
%del 2000 en adelante
%otra forma 
%B=B(9:260,:) %mantenemos datos entre fila 9 y 260


%asigno una variable a cada columna 
fechas=B(:,1);
datos=B(:,2);

%antes de cambiar la fecha como año.fraccion de año 
%tenemos que cambiar la forma en la que se entrega la fecha 
%de 199101 = 1991
%para eso 
fechas=num2str(fechas); %lo transforma a caracteres
fechas=fechas(:,1:4); %considera sólo los 4 primeros n°
fechas=str2num(fechas);%lo vuelve a convertir en vector
B=[fechas,datos];%aquí la matriz ya esta lista

%cambiando las fechas 

cont=0;
for i=1:251 %filas
    for j=2:2 %columnas
        cont=cont+1;
        A(cont,2)=B(i,j);
        A(cont,1)=B(1,1)+1/24+(cont-1)./12;
        
    end
end

%con esto, obtenemos nuestra matriz A
%Además damos por realizado lo que pide el enunciado de la 1 

%2 
%ploteando
%Utilizando solo la información de 2000 a fines de 2020;
%Calcular la media
%Calcular las diferentes desviaciones estándar

me=nanmean(A(:,2)); %determinamos la media de los datos
des=nanstd(A(:,2));%determinamos la d.estandar de los datos


%ahora creando vectores (columnas) para la media y d.estandar
%(para de esta forma poder graficarlas)
% crearemos una columna con media y desviacion estandar, 251 veces

for i=1:251
    media(i,1)=me;
    desviacion(i,1)=des;
    
end

%ahora creando un vector que contenga 
%[años,datos,media,desviación estandar]
A=[A(:,1),A(:,2),media,desviacion];

%ploteando
figure()
hold on
plot(A(:,1),A(:,2),'k','LineWidth',3) %datos
plot(A(:,1),A(:,3),'r','LineWidth',2) % media
plot(A(:,1),A(:,4),'g','LineWidth',2) %desviacion
%primera desv estandar (media+-desviacion)
plot(A(:,1),A(:,3)+A(:,4),'color','g','linewidth',2)%1era desv estandar
plot(A(:,1),A(:,3)-A(:,4),'color','g','linewidth',2)%1era desv estandar
%segunda desv estandar(media+-2desviacion)
plot(A(:,1),A(:,3)+(2*A(:,4)),'--','color','g','linewidth',2)%2da desv estandar 
plot(A(:,1),A(:,3)-(2*A(:,4)),'--','color','g','linewidth',2)%2da desv estandar
%tercera desv estandar (media+-3desviacion)
plot(A(:,1),A(:,3)+(3*A(:,4)),'-','color','g','LineWidth',2)%3era desv estandar
plot(A(:,1),A(:,3)-(3*A(:,4)),'-','color','g','LineWidth',2)%3era desv estandar
grid on %cuadraditos
xlabel('años')
ylabel('datos mm')
title('Datos de un Oceanografo frente a Ancud')
legend('datos','media','desviacion','+1era desv','-1era desv','+2da desv', ...
    '-2da desv','+3era desv','-3era desv')

%3
%Calcular una media móvil de ventana de 13 y 25 meses.
%para eso creamos una funcion que calcule la media movil 
%funcion media movil 
%function [mm] = mediamovil(x,m) 
%n=length(x);  
 
%if m>n
%   disp('ingrese un ancho correcto')
%else 
%   mm=NaN(1,n);  
     
 %  for i=m:n %desde m hasta n hay n-(m-1) 
 %     mm(i)=sum(x(i-(m-1):i))/m;  
   %end
%end
%end




%antes de usar la media movil 
%le saco los NaN a la matriz A 
AA=A(~isnan(sum(A,2)),:); %Ahoa AA no tiene NaNs'

%por lo que el gráfico no saldrá cortado 


%llamo a la función desde aca 
%Ventana de 13
MM13=mediamovil(AA(:,2),13); %le asigno una variable
%esto me genera una vector fila, lo que pasare a vector columna 
%MM13=MM13'; %media movil venatana de 13 


%ventana de 25 
MM25=mediamovil(AA(:,2),25);%Mediamovil ventana de 25, vector fila
%MM25=MM25';%vector columna


%sacando la desviacion estandar movil con ventana de 25
%se usa la funcion 
%DEM=stdmovil(x,m)

DEM25=stdmovil(AA(:,2),25);%este lo ejecuto en el command window 
%ahora llenando el DEM25 de NaN para que me calze con la media 



% grafico B de la 3 
%Con los NaN al inicio 
figure()

plot(AA(:,1),AA(:,2),'-','color','k','linewidth',3)%datos
hold on 
plot(AA(:,1),MM13(:,1),'-','color','r','linewidth',2)%media movil 13
plot(AA(:,1),MM25(:,1),'-','color','g','linewidth',2)%media movil 25
%la desv estandar hay que sumarla y restarla a la media SIEMPRE
%media+-desvestandar
%en este caso media mov 25 +- desv esta mov 25
plot(AA(:,1),MM25(:,1)+DEM25(:,1),'--','color','g','linewidth',2)
plot(AA(:,1),MM25(:,1)-DEM25(:,1),'--','color','g','linewidth',2)
grid on 
legend('datos','mmovil13','mmovil25',...
    'media+desv','media-desv')
title('estadisticos de los datos')
axis tight


%GRAFICO 3A
%creando las fechas moviles, de 13 y 25
fechamovil13=mediamovil(AA(:,1),13);
fechasmovil25=mediamovil(AA(:,1),25);

%BORRANDO NAN 
fechamovil13(1:12)=[];
fechasmovil25(1:24)=[];
MM25(1:24)=[];
MM13(1:12)=[];
DEM25(1:24)=[];


figure()
hold on
plot(AA(:,1),AA(:,2),'-','color','k','linewidth',3);
plot(fechamovil13(:,1),MM13(:,1),'-','color','r','linewidth',2)%media movil 13
plot(fechasmovil25(:,1),MM25(:,1),'-','color','g','linewidth',2)%media movil 25
plot(fechasmovil25(:,1),MM25(:,1)+DEM25(:,1),'--','color','g','linewidth',2)
plot(fechasmovil25(:,1),MM25(:,1)-DEM25(:,1),'--','color','g','linewidth',2)
grid on 
legend('datos','mmovil13','mmovil25',...
    'media+desv','media-desv')
title('estadisticos de los datos')
axis tight






