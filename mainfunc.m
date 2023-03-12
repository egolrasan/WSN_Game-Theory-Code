clc
clear all;
close all;
w=15;
l=15;
n=20;
tn=(w+1)*(l+1);
%number of step
st=10000;

uf=zeros(1,st+1);

uhat=zeros(1,st+1);
sl=round(0*rand(n,2)+(w/2));
%sl=zeros(n,2);
sr=3*ones(n,1);
%sr=[1;1;1;1;1;1;1;1;1;1;2;2;2;2;2;2;2;2;2;2;2;2;2;2;2]
%sr=ones(n,1);
sd=round((4-1)*rand(n,1)+1);
angl=zeros(n,2);
for zz=1:n
if sd(zz,1)==1
    angl(zz,1)=0;
    angl(zz,2)=90;
elseif sd(zz,1)==2
     angl(zz,1)=90;
     angl(zz,2)=180;
elseif sd(zz,1)==3
    angl(zz,1)=180;
    angl(zz,2)=270;
else
    angl(zz,1)=270;
    angl(zz,2)=360;
end
end
point=zeros(1,2);
for i=0:w
    for j=0:w
        point=[point;i,j];
    end
end
point(1,:)=[];
%determin baseline action and utility
figure(1)
hold on
%plot target
for nn=1:tn
    x=point(nn,1);
    y=point(nn,2);
    plot(x,y,'.','markeredgecolor','b','markerfacecolor','b');
end
%plot sensor
for ss=1:n
    x=sl(ss,1);
    y=sl(ss,2);
    plot(x,y,'bo','LineWidth',.5,'MarkerSize',2,'markerfacecolor','b');
end
%plot sensor

for ss=1:n
   
   % a is start of arc in radians,
% b is end of arc in radians,
% (h,k) is the center of the circle.
% r is the radius.
% Try this: plot_arc(pi/4,3*pi/4,9,-4,3)
% Author: Matt Fig
t = linspace(pi*angl(ss,1)/180,pi*angl(ss,2)/180);
x = sr(ss)*cos(t) + sl(ss,1);
y = sr(ss)*sin(t) + sl(ss,2);
x = [x sl(ss,1) x(1)];
y = [y sl(ss,2) y(1)];
P = plot(x,y,'r');
%axis([sl(ss,1)-sr(ss)-1 sl(ss,1)+sr(ss)+1 sl(ss,2)-sr(ss)-1 sl(ss,2)+sr(ss)+1])
axis square;
% if ~nargout
% clear P
% end
%axis([sl(ss,1)-range(1,ss)-1 sl(ss,1)+range(1,ss)+1 sl(ss,2)-range(1,ss)-1 sl(ss,2)+range(1,ss)+1])
%axis square;

end

axis([-2 w+1 -2 w+1]);
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=0.01;

range=zeros(3,n);
u=utility(point,sl,sr,angl);
uf(1,1)=u;
uhat(1,1)=u;


for i=1:1:st
    % entekhab hesgare i
    ssi=round((n-1)*rand(1,1)+1);
    aprimi=Aic(sl(ssi,:),w);
    alpha=exp(utilityia(point,ssi,sl(ssi,:),sl,sr,angl)/T);
    beta=exp(utilityia(point,ssi,aprimi,sl,sr,angl)/T);
    wp=alpha/(alpha+beta);
    s=rand();
    if s>wp
        sl(ssi,:)=aprimi;
    end
    u=utility(point,sl,sr,angl);
    
  
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    uf(1,i+1)=u;
    uhat(:,i+1)=(i*uhat(:,i)+u)/(i+1);
  
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
end

 uf=(100/tn)*uf;

figure(2)
hold on
%plot target
for nn=1:tn
    x=point(nn,1);
    y=point(nn,2);
    plot(x,y,'.','markeredgecolor','b','markerfacecolor','b');
end
%plot sensor
for ss=1:n
    x=sl(ss,1);
    y=sl(ss,2);
    plot(x,y,'bo','LineWidth',.5,'MarkerSize',2,'markerfacecolor','b');
end
%plot sensor
for ss=1:n
   
   % a is start of arc in radians,
% b is end of arc in radians,
% (h,k) is the center of the circle.
% r is the radius.
% Try this: plot_arc(pi/4,3*pi/4,9,-4,3)
% Author: Matt Fig
t = linspace(pi*angl(ss,1)/180,pi*angl(ss,2)/180);
x = sr(ss)*cos(t) + sl(ss,1);
y = sr(ss)*sin(t) + sl(ss,2);
x = [x sl(ss,1) x(1)];
y = [y sl(ss,2) y(1)];
P = plot(x,y,'r');
%axis([sl(ss,1)-sr(ss)-1 sl(ss,1)+sr(ss)+1 sl(ss,2)-sr(ss)-1 sl(ss,2)+sr(ss)+1])
axis square;
% if ~nargout
% clear P
% end
%axis([sl(ss,1)-range(1,ss)-1 sl(ss,1)+range(1,ss)+1 sl(ss,2)-range(1,ss)-1 sl(ss,2)+range(1,ss)+1])
%axis square;

end
% for ss=1:n
%     x=sl(ss,1);
%     y=sl(ss,2);
%     t=0:0.1:6.3;
%     xi=sr(ss).*sin(t)+x;
%     yi=sr(ss).*cos(t)+y;
%     if sr(ss)==1
%         plot(xi,yi,'-r');axis equal
%     else 
%         plot(xi,yi,'-b');axis equal
%         
%     end
%     
% % a=5;
% % b=4;
% % r=2;
% % x=r.*sin(t)+a;
% % y=r.*cos(t)+b;
% % plot(x,y);axis equal
% 
% 
%     plot(x,y,'ko','LineWidth',.5,'MarkerSize',3,'markerfacecolor','k');
% end
axis([-2 w+1 -2 w+1]);
hold off


figure(3)
t=1:st+1;
plot(t,uhat);
grid on
xlabel('Iteration Time')
ylabel('Average Potential Function of Sensor Nodes')
axis([0 st+1 0 140]);

figure(4)
t=1:st+1;
plot(t,uf);
grid on
xlabel('Iteration Time')
ylabel('Percentage of Covered Area')
axis([0 st+1 0 60]);

       
        
    


