%1. Recupere de la carpeta entregada la base de datos igreenland_mass.dat, asígnele un nombre a esta
%variable fácil de manejar. Esta base corresponde a mediciones mensuales de masa (en Gt) de
%Groenlandia. Estos datos parten desde el 2002 y llegan hasta mayo del 2021. (es decir, tienen una
%dimensión de 20x13) con la primera columna los años, y las otras 12 las mediciones mensuales

a = load('igreenland_mass.dat.txt');
%2
%luego de eso borrar manualmente los comentarios, desde el script
%para borrar las ultimas 2 filas (2021 y 2020) puede ser manual o 
%a(1,:)=[] con esto borro 2021
a(1,:)=[];
a(end,:)=[];
%para cambiar los -999.9 por NaN
 a(a==-999.9)=NaN;
 %ahora que ya están cambiados los -999.9 por NaN, tengo que encontrarlos,
 %cuales son las posiciones, para eso 
[filas,columnas]= find(isnan(a));
mdnans=[filas,columnas];

% pregunta 3, hay que hacer un ciclo for 

cont=0;
for i=1:18
    for j=2:13
        cont=cont+1;
        D(cont,2)=a(i,j);
        D(cont,1)=a(1,1)+1/24+(cont-1)./12;
        
    end
end


%pregunta 4

%ploteando D

% para llamar algo load('nombre.mat')


plot(D(:,1),D(:,2),'color','r','LineWidth',2)
grid on 
set(gcf,'color','w') %color del fondo 
xlabel('Años')
ylabel('Mass')
legend('Green mass')
title('Greeland mass')

%pregunta 5 
%esta es una funcion, quedara guardada en funciones
%function media = promedio(x)
%   D(isnan(D))=[];
%  suma=sum(vector);
% media=suma/n
%end

%PRACTICA PROFE
%parte estadisticos 
%para la matriz de 2 columnas 
%[m,d,v]=est(D(:,2));%ESTA FUNCION LA HIZO EL PROFE
%68%de los datos se encuentran en la desvia estan DATO 


%estadisticos para comparar

me=nanmean(D(:,2));
de=nanstd(D(:,2));
ve=nanvar(D(:,2));


%para la matriz de 13 columnas (debemos cortar la columna de los años)
%
%an1=a(:,2:13);
%[ma,da,va]=set(an1);
%maa=nanmean(an1);
%daa=nanstd(an1);
%vaa=nanvar(an1);

%estadisticos con las funciones de matlab para la de 13 columnas
mee=nanmean(a(:,2));
dee=nanstd(a(:,2));
vee=nanvar(a(:,2));


%creando  grafico para matriz de 2 columnas 
%creando vectores para que no sea un solo punto
for i=1:216
    media(i,1)=me
    desviacion(i,1)=de
    varianza(i,1)=ve
end


mediamov=movmean(D(:,2),25); %aca estoy sacando la media movil con un ancho de 25

desvestandarmovil=movstd(D(:,2),25)%Aca estoy sacando la desviacion estandar movil 

%desviacion estandar - media
desvmasmedia=mediamov+desvestandarmovil;


% media - desviacion estandar
mediamenosdesve=mediamov-desvestandarmovil;

%ploteando
figure(2)
plot(D(:,2),'r','LineWidth',2)
hold on 
plot(media,'b','LineWidth',2)
hold on 
plot(desviacion,'g','LineWidth',2)
hold on 
plot(mediamov,'y','LineWidth',2)
hold on 
plot(desvmasmedia,'--k','LineWidth',2)
hold on 
plot(mediamenosdesve,'--m','LineWidth',2)
grid on %cuadraditos
legend('datos','media','desviacion','media movil','ds movil')













