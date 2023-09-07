%función que calcula para datos x y 
%regresion lineal 
%regresion lineal =/= interpolar 
function [p]=ajustapol(x,y,n)

pf=polyfit(x,y,n);
p=polyval(pf,x)

end

%mejor para esto guiate de la practica 4 y hazlo pasito a pasito 
