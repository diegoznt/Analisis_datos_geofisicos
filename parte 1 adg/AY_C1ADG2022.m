%% Ayudantía ADG Extra 11-05-2022
%
%
%    por Manuel Suazo, msuazo2018@udec.cl
%
%
%
%    Aspectos a visualizar:
%
%    Carga de los datos, agregamos NaNs, plot, estadísticos básicos,
%    estadísticos móviles, boxplot, histogramas con ancho óptimo
%    e interpolación lineal.
%
%
%    Desafío para estudiar: recrear todo lo visto en este código, pero para
%    los datos sn tendencia.
%% 1. Carguemos los datos
pp=load('santiag.dmc');

%% 2. Inventemos algunos NaNs pues los datos no tienen.
pp2=pp
pp2(7:10,5:6)=NaN

[i j]=find(isnan(pp2)); 
%% 3. Pasar a 2 columnas, luego en la tercera guardar los datos s/t 
B=peso(pp2);
B(:,3)=detrend(B(:,2),'omitnan'); % acá la columna sin tendencia, recreen todo para estos datos

%% 4. Graficar con su media, y +/- 3 d.e, comentar (para ambas series)
m=mean(B(:,2),'omitnan')
B(:,4)=m; % mean(x,'omitnan')
B(:,5)=std(B(:,2),'omitnan');

plot(B(:,1),B(:,2),'o')
hold on 
plot(B(:,1),B(:,4),'--k','linewidth',2) % media
plot(B(:,1),B(:,4)+B(:,5)) % media
plot(B(:,1),B(:,4)+2*B(:,5)) % media
plot(B(:,1),B(:,4)+3*B(:,5)) % media
%axis tight para que no quede el espacio en blanco 
%% 5. Graficar con su mm y dem de 13,25 y 121 meses. (para ambas series)
[mm13 std13]=mmstdm(B(:,2),13);
[mm25 std25]=mmstdm(B(:,2),25);
[mm121 std121]=mmstdm(B(:,2),121);

%% mm. del tiempo para que perdida quede centrada
[tm13 ]=mmstdm(B(:,1),13);
[tm25 ]=mmstdm(B(:,1),25);
[tm121 ]=mmstdm(B(:,1),121);
%% grafiquemos....
plot(B(:,1),B(:,2),'ko','markerfacecolor','k')
hold on 
plot(tm13,mm13,'r','linewidth',2)
plot(tm13,mm13+std13,'--r','linewidth',2)
plot(tm13,mm13-std13,'--r','linewidth',2)

plot(tm25,mm25,'b','linewidth',2)
plot(tm25,mm25+std25,'--b','linewidth',2)
plot(tm25,mm25-std25,'--b','linewidth',2)

plot(tm121,mm121,'m','linewidth',2)
plot(tm121,mm121+std121,'--m','linewidth',2)
plot(tm121,mm121-std121,'--m','linewidth',2)




%% 6. Hacer un histograma con su ancho optimo para ambas series

c=2.6
ri=iqr(B(:,2))
raiz_datos=(length(B(:,2)))^(1/3)
 h=(c*ri)/raiz_datos
 
  figure(3)
 h1=histogram(B(:,2))
 h1.BinWidth=h
%% 7. Hacer un histograma y un boxplot para cada mes (ambas series)
%        sobreponer la media serie original).
for i=1:12
      subplot(4,3,i)    
      histogram(pp2(:,i+1))
      title([num2str(i)])
      ylim([0 150])
      xlim([0 300])
end 

mensual=mean(pp2(:,2:13),'omitnan');

boxplot(pp2(:,2:13))
hold on 
plot(1:12,mensual)

%% 9. Interpolar los NaNs con interp1, mostrar el valor real y el valor interpolado. 
%         Cuantificar su diferencia (solo a la serie original)
plot(B(:,1),B(:,2))
f=B(:,1); % fechas
d=B(:,2); % datos 
b_interp=interp1(f(~isnan(d)),d(~isnan(d)),f,'pchip');

plot(B(:,1),b_interp,'linewidth',2)
hold on 
plot(B(:,1),B(:,2),'linewidth',2)


%% 10. A los datos interpolados, ajustar un polinomio de grado 1, 3 y 5.
p1=ajustapol(f,b_interp,1)
p3=ajustapol(f,b_interp,3)
p5=ajustapol(f,b_interp,5)

figure(7)
subplot(211)
plot(B(:,1),b_interp,'-k','linewidth',2)
hold on 
plot(f,p1,'-r','linewidth',2)
plot(f,p3,'-b','linewidth',2)
plot(f,p5,'-g','linewidth',2)
axis tight
legend('S.I','P. 1', 'P.3', 'P.5')


figure(1)
plot(B(:,1),b_interp-p1,'-k','linewidth',2)

figure(2)
plot(B(:,1),b_interp-p3,'-b','linewidth',2)

figure(3)
plot(B(:,1),b_interp-p5,'-g','linewidth',2)
%% Algunos comentarios previos al certamen:
%    Aspectos no vistos que podrían entrar: Primer ejemplo de interpolación
%    en cuadrados y calculo de estadísticos varios (mediana, skewnees,
%    trimedia, IQR, etc).
%%
%    Estimad@s,          
%    Se que la vuelta a presencialidad para el semestre en que esta la
%    mayoría de uds. puede ser bastante intimidante (no me imagino en esos
%    ramos en presencial la vdd). Y se que la Universidad no colabora en
%    algo, que debería estar garantizado, como son las condiciones mínimas
%    para tener un óptimo desempeño, esas clase con un temporal de aquellos
%    y con mascarilla no debe ser muy agradable la verdad. Pero se que
%    podrán sacarlo todo adelante <3, y pese a todo, las notas y esta
%    presión de los certamenes jamás va a reflejar su verdadero proceso de
%    aprendizaje... las notas no lo son todo, y una vez que uno se libera
%    de ese pensamiento, vives mucho más tranquilo académicamente.
%
%    Ánimo con el semestre, y que todo lo que venga sea para mejor <3.
%
%                                                                                              Atentamente, 
%                                                                                                                  Manuel.
%
%   PD: Síganme en ig si llegaron hasta acá: @m_suazo.xls
%
%
%