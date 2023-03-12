function ui=utilityia(target,ns,ali,al,ar,zavie)
al(ns,:)=ali;
n=size(target,1);
m=size(al,1);
wei=zeros(n,m);
fq=1;
ui=0;
b=[1 0];
a=[0 0];
for i=1:1:n
    for j=1:1:m
    dis=sqrt((target(i,1)-al(j,1))^2+(target(i,2)-al(j,2))^2);
    if (target(i,2)-al(j,2))>=0&&(target(i,1)-al(j,1))>=0
        diff = 45;
    elseif (target(i,2)-al(j,2))>=0&&(target(i,1)-al(j,1))<=0
        diff = 135;
    elseif (target(i,2)-al(j,2))<=0&&(target(i,1)-al(j,1))<=0
        diff = 225;
    else
        diff = 315;
    end
    
    
    if dis <= ar(j)&& diff>=zavie(j,1) && diff<=zavie(j,2)
        wei(i,j)=fq;
    end
    end 
end
ma=find(wei(:,ns)==1);
k=size(ma,1);
for i=1:1:k
    re=ma(i,1);
    if nnz(wei(re,:))==1
        ui=ui+1;
    end
end
    





    
