load('ws_19042022_ADG.mat')
%ACA TENGO LA INTERPOLACIÓN EN 1D
%B columna
%eliminando fechas con NaN
%primero sacar los NaN de B
%clonamos la matriz, extraemos las posiciones de NaN con k 
%y las borramos 
C=B;
k=find(isnan(C(:,2)));
C(k,:)=[];

%regresion lineal 
%usando polyfit 
%polyfit x,y,grado (xfechas)(ydatos)(grados que te piden) %evaluaba
%polinomio & y=mx+n te da m y n  
p=polyfit(C(:,1),C(:,2),1);%polyfit
pv=polyval(p,C(:,1)); %polyval (x,y) (xpoly)(yfechas) %evalua polyfit
figure(1)
subplot(2,2,1)
plot(C(:,1),C(:,2),'o');
hold on
plot(C(:,1),pv,'-m')%regresion lineal (polyfit(grado1),polyval)
hold off
title('Regresion lineal grado 1');
xlabel('fechas');
ylabel('datos');
grid on
legend('datos originales','curva ajustada')
%ahora haciendo lo mismo con mas grados

p=polyfit(C(:,1),C(:,2),3);%polyfit
pv=polyval(p,C(:,1)); %polyval (x,y) (xpoly)(yfechas) %evalua polyfit
subplot(2,2,2)
plot(C(:,1),C(:,2),'o');
hold on
plot(C(:,1),pv,'-m')
hold off
title('Regresion lineal grado 3')
xlabel('fechas');
ylabel('datos');
grid on
legend('datos originales','curva ajustada')

p=polyfit(C(:,1),C(:,2),5);%polyfit
pv=polyval(p,C(:,1)); %polyval (x,y) (xpoly)(yfechas) %evalua polyfit
subplot(2,2,3)
plot(C(:,1),C(:,2),'o');
hold on
plot(C(:,1),pv,'-m')
hold off
title('Regresion lineal grado 5')
xlabel('fechas');
ylabel('datos');
grid on
legend('datos originales','curva ajustada')

p=polyfit(C(:,1),C(:,2),7);%polyfit
pv=polyval(p,C(:,1)); %polyval (x,y) (xpoly)(yfechas) %evalua polyfit
subplot(2,2,4)
plot(C(:,1),C(:,2),'o');
hold on
plot(C(:,1),pv,'-m')
hold off
title('Regresion lineal grado 7')
xlabel('fechas');
ylabel('datos');
grid on
legend('datos originales','curva ajustada')

%22 de junio cumple poly
%el 22 cumple 21
%17 de agosto kathy

%tools basic fitting, se pueden ajustar desde la foto del grafico 
%para tener un buen ajuste
%cual residual (grafico se acerca al cero)
%el de grado 7 se ajusta mejor que la lineal 
%detrend saca pendiente de los datos
%si los residuales tienden a cero mejor

% interpolacion consigo el dato que me falta  
%extrapolacion tengo datos fuera del intervalo  de los datos

%interpolar datos de fechas que no hay registro 


%interpolar 
%rellenar los datos que faltan 
%Vq=interp1(X,V,Xq) X fechas sin nan V datos sin nan Xq fechas con NaN
%%
Vq=interp1(C(:,1),C(:,2),B(:,1)); %fechas sin nan,datos sin nan,fechas con nan, modo de iterpolar(ej spline)
%graficando 
figure(2)
subplot(2,2,1)
plot(B(:,1),B(:,2),'o')%nan
hold on 
plot(B(:,1),Vq,'--r')%fechas con nan y la interpo
title('Interpolación Lineal')
xlabel('fechas')
ylabel('datos')

%datos faltantes sin nan
subplot(2,2,2)
plot(B(:,1),B(:,2),'o')
title('matriz con datos faltantes')

%matriz interpolada
%con 216 datos
subplot(2,2,[3,4])
plot(B(:,1),Vq,'o')
title('matriz con datos faltantes')










