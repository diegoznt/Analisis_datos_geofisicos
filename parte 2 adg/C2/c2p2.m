%% trabajando un poco con la Parte2.mat 
load('Parte2.mat')

%en N34 hay un valor de -9999
%por lo tanto pasandolo a NaN

N34(N34==-9999)=NaN;

%ahora que ya están cambiados los -999.9 por NaN, tengo que encontrarlos,
%cuales son las posiciones, para eso 
[filas,columnas]= find(isnan(N34));
mdnans=[filas,columnas];

%% interpolando la matriz N34
N34_inter=inter2D(N34,0.5,0.5);

%datos interpolados encontrar los dato
%esto no funciona me entrega los años y yo quiero los valores de las
%interpolaciones
datos_inter=N34_inter([22,6;56,7;10,8]);



%%
figure()
plot(fecha,Tm_C)
hold on
plot(fecha,Tm_S)
datetick
xlabel('tiempo')
ylabel('')
title('')
grid on
axis tight



