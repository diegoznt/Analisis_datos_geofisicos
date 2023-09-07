%practica 3
%1
%son las mismas de las otra vez pero ya estan listas 
%
%hay que cargar el B.mat
%matriz A 18x13
%no es necesario cargarlas pq en el sgte archivo se encuentran las 2
%matrices que necesitamos 
%A y B
load('ws_19042022_ADG.mat')

%2
%B(:,3)=detrend(B(:,2)); %esto esta lleno de Nan por lo tanto hay que sacarlos
%se usa el omitnan 
%matriz B columna 3 datos linealizados 

B(:,3)=detrend(B(:,2),'omitnan'); %datos sin tendencia 

%3

figure()
subplot 221 
histogram(B(:,2),'FaceColor','r') %c2 frecuencia datos
title('datos')
subplot 222
histogram(B(:,3),'FaceColor','r')%c3 frecuencia datos, detrend
title('datos sin tendencia')
subplot 223
histogram(B(:,2),'normalization','probability','FaceColor','g')
title('datos porcentaje')%frecuencia relativa
subplot 224
histogram(B(:,3),'normalization','probability','FaceColor','g')
title('datos sin tendencia porcentaje')

%4 
%ahora lo mismo pero calculando las barritas adecuadas para los datos
%con nbins
%la formula la dieron en la practica 
%los nbins son las barritas, por lo tanto el n° de barritas

nbins=2.59*(iqr(B(:,2))/(216)^(1/3)); %con tendencia %son 216 datos c2
nbinss=2.59*(iqr(B(:,3))/(216)^(1/3)); %sin tendencia %son 216 datos c3

figure()
subplot 221 
histogram(B(:,2),'BinWidth',nbins,'FaceColor','r') %c2 frecuencia datos
title('datos')
subplot 222
histogram(B(:,3),'BinWidth',nbinss,'FaceColor','r')%c3 frecuencia datos, detrend
title('datos sin tendencia')
subplot 223
histogram(B(:,2),'BinWidth',nbins,'normalization','probability','FaceColor','g')
title('datos porcentaje')%frecuencia relativa
subplot 224
histogram(B(:,3),'Binwidth',nbinss,'normalization','probability','FaceColor','g')
title('datos sin tendencia porcentaje')


%5 
%ciclo for
meses={'enero','febrero','marzo','abril','mayo','junio','julio',...
    'agosto','septiembre','octubre','noviembre','diciembre'}
colors={'r','r','g','r','c','c','b','m','m','y','y','k'}

for i=1:12
    subplot(4,3,i)
    histogram(A(:,i+1),'Facecolor',colors{i})
    title(meses{i},'Fontsize',10)
    sgtitle('Histogramas','Fontsize',15)
    xlabel('Data Value','Fontsize',10)
    ylabel('frecuency','Fontsize',10)
    set(gcf,'color','w')%color de fondo grafico
    set(gca,'fontsize',10)%tamaño de numeros
    %saca contorno de legend 
    grid on 
    grid minor 
end

%6
%calcular: mediana, trimean, media,cuartiles,rango intercuatil,
%desviacion estandar 
%recuerda siempre omitiendo los nan's


d_o=B(:,2);%datos originales
d_st=B(:,3);%datos sin tendencia

%media 

media_do=nanmean(d_o);%media datos originales
media_dst=nanmean(d_st);


%mediana
mediana_do=nanmedian(d_o);
mediana_dst=nanmedian(d_st);

%recordar que el cuartil 2 es la mediana 

%calculamos los cuartiles
%cuartiles para d_0

Q1_do=quantile(d_o,0.25);
%Q1_do=prctile(D_O,25);
Q2_do=quantile(d_o,0.5);
Q3_do=quantile(d_o,0.75);

%ahora con los datos sin tendencia
%osea cuartiles do_st
Q1_dst=quantile(d_st,0.25);
Q2_dst=quantile(d_st,0.5);
Q3_dst=quantile(d_st,0.75);

% calcular rango intercuatil

RIQ_do=Q3_do-Q1_do;%rango intercuartil datos originales
%RIQ_1=iqr(d_o); %funcion de matlab, rango intercuatil +facil+directo
RIQ_dst=Q3_dst-Q1_dst; 

%trimedia, ignora valores extremos
%variable robusta iwal que la mediana
%calculando trimean

tm_do=(Q1_do+2*Q2_do*Q3_do)/4;
tm_dst=(Q1_dst+2*Q2_dst*Q3_dst)/4;

%REVISAR ESTA PARTE
%desviacion estandar(ocupar funcion)
%o funciones de matlab

de_do=nanstd(d_o); %DESVIACION ESTANDAR DATOS ORIGINALES 
de_dst=nanstd(d_st); %DESVIACION ESTANDAR DATOS SIN TENDENCIA


%7
%calcular skewness
%
%

sk_do=skewness(d_o); %skewness datos originales
sk_dst=skewness(d_st); %skewness datos sin tendencia
%distribucion normal media moda mediana =
%sk_do negativo -0.2544
%sk_dst negativo -0.5
% estan corridos
%hacia la derecha 
%skewness va del -1 al 1 



%8
%generar un boxplot por cada serie, y mostrar media trimean 
figure()

subplot(211)
boxplot(B(:,2),'label',{'Serie Original'})
grid minor 
hold on 
plot(tm_do,'r*','linewidth',3) % trimean
plot(mediana_do,'g*','linewidth',3) % mediana 
plot(media_do,'b*','linewidth',3) % media 
legend('TM','Me','Media')

subplot(212)
boxplot(B(:,3),'label',{'Serie Sin Tendencia'})
hold on 
grid minor
plot(tm_dst,'r*','linewidth',3) % trimean
plot(mediana_dst,'g*','linewidth',3) % mediana 
plot(media_dst,'b*','linewidth',3) % media
legend('TM','Me','Media')



%9
%matriz A que contiene todas las columnas
%diagrama de caja para cada mes 
%

c_a=nanmean(A(:,2:13))
figure(5)
             boxplot(A(:,2:end),'labels',{'Enero','Febrero','Marzo','Abril'...
      ,'Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'})
hold on 
plot(1:12,c_a,'-ok')
grid minor














