function [fa]=utility(target,ap,ar,zavie)
n=size(target,1);
m=size(ap,1);
wei=zeros(n,1);
fq=1;
sum=0;
fa=0;
for i=1:1:n
    for j=1:1:m
    dis=sqrt((target(i,1)-ap(j,1))^2+(target(i,2)-ap(j,2))^2);
    if (target(i,2)-ap(j,2))>=0&&(target(i,1)-ap(j,1))>=0
        diff = 45;
    elseif (target(i,2)-ap(j,2))>=0&&(target(i,1)-ap(j,1))<=0
        diff = 135;
    elseif (target(i,2)-ap(j,2))<=0&&(target(i,1)-ap(j,1))<=0
        diff = 225;
    else
        diff = 315;
    end
    if dis <= ar(j)&& diff>=zavie(j,1) && diff<=zavie(j,2)
        wei(i)=fq;
        break;
    end
    end
    
    fa=fa+wei(i);
end


    
