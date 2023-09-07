%% item 1: cargar datos
load ws_19042022_ADG.mat
%% item 2
B(:,3)=detrend(B(:,2),'omitnan')
%% item 3
figure(1)

subplot(221)
histogram(B(:,2))
grid minor 
title('D.O')

subplot(222)
histogram(B(:,3))
grid minor 
title('D. s/t')

subplot(223)
histogram(B(:,2),'normalization','probability')
grid minor 
title('D.O (%)')

subplot(224)
histogram(B(:,3),'normalization','probability')
grid minor 
title('D. s/t (%)')
%% item 4
c=2.6 % ~aprox. a una distribución normal
h_op1=(c*( prctile(B(:,2),75) - prctile(B(:,2),25))) / (216^(1/3))
h_op2=(c*( prctile(B(:,3),75) - prctile(B(:,3),25))) / (216^(1/3))

figure(2)

subplot(221)
histogram(B(:,2),'binwidth',h_op1,'facecolor','r')
grid minor 
title('D.O a.o')

subplot(222)
histogram(B(:,3),'binwidth',h_op2,'facecolor','r')
grid minor 
title('D. a.o s/t')

subplot(223)
histogram(B(:,2),'normalization','probability','binwidth',h_op1,'facecolor','r')
grid minor 
title('D.O a.o (%)')

subplot(224)
histogram(B(:,3),'normalization','probability','binwidth',h_op2,'facecolor','r')
grid minor 
title('D. a.o s/t (%)')
%% item 5 
figure(3)
for i=1:12
      subplot(4,3,i)
      histogram(A(:,i+1))
      title(['mes número: ',num2str(i)])
end
%% item 6
do=B(:,2)
dst=B(:,3)

m_do=nanmean(do)
m_dst=nanmean(dst)

de_do=nanstd(do)
de_dst=nanstd(dst)

me_do=nanmedian(do)
me_dst=nanmedian(dst)

q1_do=prctile(do,25)
q3_do=prctile(do,75)

q1_dst=prctile(dst,25)
q3_dst=prctile(dst,75)

IQR_do=q3_do-q1_do
IQR_dst=q3_dst-q1_dst

tm_do= (q1_do+2*me_do+q3_do)/4
tm_dst= (q1_dst+2*me_dst+q3_dst)/4

%% item 7 
sk_do=skewness(do)
sk_dst=skewness(dst) 
% YK=(Q3-2*Q2+Q1)/IQR
%% item 8

figure(4)

subplot(211)
boxplot(B(:,2),'label',{'Serie Original'})
grid minor 
hold on 
plot(tm_do,'r*','linewidth',3) % trimean
plot(me_do,'g*','linewidth',3) % mediana 
plot(m_do,'b*','linewidth',3) % media 
legend('TM','Me','Media')

subplot(212)
boxplot(B(:,3),'label',{'Serie Sin Tendencia'})
hold on 
grid minor
plot(tm_dst,'r*','linewidth',3) % trimean
plot(me_dst,'g*','linewidth',3) % mediana 
plot(m_dst,'b*','linewidth',3) % media
legend('TM','Me','Media')




%% item 9 
c_a=nanmean(A(:,2:13))
figure(5)
             boxplot(A(:,2:end),'labels',{'Enero','Febrero','Marzo','Abril'...
      ,'Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'})
hold on 
plot(1:12,c_a,'-ok')
grid minor
