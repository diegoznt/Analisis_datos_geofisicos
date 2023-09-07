%Practica 2 
%1 
%matriz A original 13 columnas %en mi caso a
%matriz B 2 columnas %en mi caso D 
%BORRA LA PRIMERA Y LA ULTIMA DE a PARA QUE QUEDE 18X13!!
clear,clc
a = load('igreenland_mass.dat.txt');
a(a==-999.9)=NaN;
[filas,columnas]= find(isnan(a));
a(1,:)=[];
a(end,:)=[];
cont=0;
%creando la matriz D
for i=1:18
    for j=2:13
        cont=cont+1;
        D(cont,2)=a(i,j);
        D(cont,1)=a(1,1)+1/24+(cont-1)./12;
        
    end
end


%detrend
%2
%clonamos la de 216x2 
F=D;

%c=detrend(D(:,2)); %esto dara puros NaN
%figure(1)%esta figura no da nada 
%plot(c,'r','LineWidth',2)

c=detrend(F(:,2),'omitnan');%esto omite los nan 

%quitando los nan's
k=find(isnan(F(:,2)))%da las posiciones de Nan
F(k,:)=[];%quito los nan 
figure(2)
plot(c,'r','LineWidth',2)%esto dará unas lineas 

N=F(:,2)-c; %para que sea lineal y se vea la pediente tiene que ser la 2da
figure(3)
plot(F(:,1),N,'r','LineWidth',2)%F(:,1) son los años, se grafica eso y los N

%3
%sacando los estadisticos de c 
media=nanmean(F(:,1));
desv=nanstd(F(:,1));
mediamov=movmean(F(:,1),25);%aca estoy sacando la media movil con un ancho de 25
desvestandarmovil=movstd(F(:,1),25);
for i=1:216
    me(i,1)=media
    desviacion(i,1)=desv
    
end

figure(4)
plot(c(:,1),'r','LineWidth',2)
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



