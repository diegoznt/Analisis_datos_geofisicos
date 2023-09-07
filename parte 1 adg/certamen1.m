%1 
%BASE DE DATOS 
%acá leo la matriz entregada con un readmatrix 
%luego elimino manualmente los comentarios del incicio
%del documento 
%a

a=readmatrix('SUR.dat'); 
%los datos comienzan desde 1979 

%b
%eliminando la primera y la ultima fila 
%de forma manual 
%me quedo con los datos desde 1980 a 2021


%c 
%sustituyendo los NaN 
a(a==-999.9)=NaN;

%ahora que ya están cambiados los -999.9 por NaN, tengo que encontrarlos,
 %cuales son las posiciones, para eso 
[filas,columnas]= find(isnan(a));
mdnans=[filas,columnas];

%D
%pasando a matriz B 
B=peso(a);

%E
plot(B(:,1),B(:,2),'color','r','LineWidth',2)
grid on 
set(gcf,'color','w') %color del fondo 
xlabel('Años')
ylabel('[10^6 km2].')
legend('datos')
title('Amplitus v/s tiempo')
axis tight 

%AÑO A INTERPORLAR 1984

%%
%2
%%interpolar 
%para interpolar necesito
%fechas sin nan 
%fechas con nan 
%datos sin nan

M=B;

k=find(isnan(M(:,2)));%datos sin nan 
M(k,:)=[];

M(:,3)=M(:,1)%fechas con nan 
j=find(isnan(M(:,1)));%fechas sin nan 
M(j,:)=[];

%columna 1 de M fechas con nan 
%columna 2 de M datos sin nan 
%columna 3 de M fechas sin nan 

Vq=interp1(M(:,3),M(:,2),B(:,1),'spline');
C(:,1)=B(:,1)
C(:,2)=Vq;
%vq es la serie interpolada y a esta le saco los estadisticos 
%si quiero graficar esto deberia sacarlo con nan 
figure
subplot 211
plot(C(:,1),C(:,2),'k','linewidth',2)%datos interpolados 
grid on 
set(gcf,'color','w') %color del fondo 
xlabel('Años')
ylabel('[10^6 km2].')
legend('datos')
title('Amplitus v/s tiempo')
axis tight

subplot 212
plot(C(:,1),C(:,2),'r','linewidth',2)%datos interpolados 
grid on 
set(gcf,'color','w') %color del fondo
xlabel('años')
xlim([1983 1985])
ylabel('[10^6 km2].')
legend('datos')
title('Amplitus v/s tiempo')

%%
%3
%estadisticos 
%a

[me_c de_c ~]=medidasdedispersion(C(:,2));

%3b 
%los datos se pierden al final 
[mm61 std61]=mmstdm(C(:,2),61);
%PARA QUE LA PERDIDA ME QUEDE AL FINAL 
%AL VECTOR FECHAS LE QUITO (VENTANA-1) FILAS AL FINAL 
 %B((216-12):216,:)=[] ejemplo
%para quitar 
D=C;%por precaución duplicamos la matriz C
C(1:60,:)=[] 


%graficando 
C(:,3)=me_c %media de c
C(:,4)=de_c %desviacion de d

figure()
plot(C(:,1),C(:,2),'k','linewidth',2) %datos
hold on 
plot(C(:,1),C(:,3),'r','linewidth',2)%MEDIA
plot(C(:,1),C(:,3)+C(:,4),'b','LineWidth',2)%desviacion 
plot(C(:,1),C(:,3)-C(:,4),'b','LineWidth',2)
plot(C(:,1),mm61,'g','LineWidth',2)
axis tight
grid on %cuadraditos
legend('datos','mean','+sdt','-sdt','mmovil')
xlabel('años','linewidth',2)
ylabel('[10^6 km2].','linewidth',2)
title('Amplitus v/s tiempo','linewidth',2)

%%
%4
%calculamos los cuartiles
%cuartiles para 

Q1_C=quantile(C(:,2),0.25);
%Q1_do=prctile(D_O,25);
Q2_C=quantile(C(:,2),0.5); %calcular el cuartil 2 es calcular la mediana
Q3_C=quantile(C(:,2),0.75);

% calcular rango intercuatil

RIQ_do=Q3_C-Q1_C;%rango intercuartil matriz c

%calculando la trimedia
tm_C=(Q1_C+2*Q2_C*Q3_C)/4;

%calculando boxplot
figure()
boxplot(C(:,2),'label',{'Serie Original'})
grid minor 
hold on 
plot(tm_C,'r*','linewidth',3) % trimean
plot(Q2_C,'g*','linewidth',3) % mediana 
plot(me_c,'b*','linewidth',3) % media 
legend('TM','Me','Media')
title('boxplot de C')
ylabel('[10^6 km2].')

%CALCULANDO OTRO BOXPLOT






