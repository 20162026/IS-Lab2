clear ;
close all;
clc;

disp('start')

[x1,x2]=meshgrid(0.1:1/22:1);
 

d = ( cos(x1 * 3))  + sin (2 * pi * x2);
  d = ( (x1 * 3))  + sin (2 * pi * x2);
% d = ((1 + 0.6 * sin (2 * pi * x1 / 0.7)) + 0.3 * sin (2 * pi * x2)) / 2;
 

 
w11=[rand(1) rand(1) rand(1) rand(1) rand(1)];
w12=[rand(1) rand(1) rand(1) rand(1) rand(1)];
b1=[rand(1) rand(1) rand(1) rand(1) rand(1)];
w2=[rand(1) rand(1) rand(1) rand(1) rand(1)];
b2=rand(1);

 
len=5;
n=0.25;
 


v1=zeros(1,len);
y1=zeros(1,len);
 
cnt=0;
e=1;
while cnt<100000 
  
    for k=1:length(x1)
        for t=1:length(x2)
            
            v_2=b2;
            for i=1:length(b1)
                v1(i)=w11(i)*x1(t,k)+w12(i)*x2(t,k)+b1(i);
                y1(i)=1/(1+exp(-v1(i)));
                 
                v_2=v_2+y1(i)*w2(i);
            end
    
            e= d(t,k)-v_2;  
 
            
            %atnaujinimas
            
             b2=b2 + n*e;
 
            for i=1:len
                w2(i)=w2(i)+n*e*y1(i);
                
                delta=y1(i)*(1-y1(i))*e*w2(i);
                w11(i)=w11(i)+n*delta*x1(t,k);
                w12(i)=w12(i)+n*delta*x2(t,k);
                b1(i)=b1(i)+n*delta;
            end
        end
    end
    cnt=cnt+1;
    if(mod(cnt,10000)==0)
        disp('---------')
        disp(cnt)
    end
end

for k=1:length(x1)
    for t=1:length(x2)
        v_2(t,k)=b2;
        for i=1:len
            v1(i)=w11(i)*x1(t,k)+w12(i)*x2(t,k)+b1(i);
            y1(i)=1/(1+exp(-v1(i)));
            v_2(t,k)=v_2(t,k)+y1(i)*w2(i);
        end
        e(t,k) = d(t,k)-v_2(t,k);
    end
end
disp('err')
disp(e)

err_max=max(abs(e(:)))

surf(x1,x2,d, 'FaceColor','g', 'FaceAlpha',0.6 )

hold on;

surf(x1,x2,v_2, 'FaceColor','blue', 'FaceAlpha',0.9 )
 
