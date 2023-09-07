%%FUNCION PARA sinNaN mediante metodo 1 de interpolacion
%OJO al interpolar no tomar las fechas por que los valores se dispararan
% matriz_inter=(matriz(:,2:end),peso,peso)
%funcion para interpolar 2D por metodo de filas y columnas 
%p1-->peso filas-->uno lo asigna
%p2-->peso columnas--->uno lo asigna
function matriz_interp=inter2D(matriz,p1,p2)
[i,j] = find(isnan(matriz));%Localizamos las posiciones de los nan
P=[i,j];%posiciones de los NaN's
%antes de hacer el ciclo for duplicaremos nuestra matriz original para no
%perder esos datos
matriz_interp=matriz;
for i=1:length(P(:,1))
  matriz_interp(P(i),P(i,2))=p1*mean(matriz_interp(P(i),2:end),'omitnan')+p2*mean(matriz_interp(:,P(i,2:end)),'omitnan'); 
end
%ojo aca me interpola desde la columna 2 pq en la primera columna se
%encuentran las fechas, entonces para que no interfieran en la
%interpolacion 
end