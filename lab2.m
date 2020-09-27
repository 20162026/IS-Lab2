clc
clear
close all

disp('start')

  x = [ 0.1:(1/22):1 ];

 d = [((1 + 0.6.*sin(2.*pi.*x./0.7)) + 0.3.*sin(2.*pi.*x))./2];
 
%d = [((1 + 0.6.*sin(2.*pi.*x )))];
 
%rng(33)%fixed rng value for testing dif learning rates and err max

w1=[randn(1) randn(1) randn(1) randn(1) randn(1)]
b1=[randn(1) randn(1) randn(1) randn(1) randn(1)] ;

w2=[randn(1) randn(1) randn(1) randn(1) randn(1)] ;
b2=randn(1) ;

len=5;

n=0.1; 
max_err=0.005;

v1=zeros(1,len);
y1=zeros(1,len);

e_x_check=zeros(1,length(x));
cnt=0;
e=1;
while e>max_err && cnt<10*1000000
    
    for i_x=[1:length(x)]
        
        v_2=b2; %calc v2   
        for i1=1:len
            v1(i1)=w1(i1)*x(i_x)+b1(i1);
            y1(i1)=1/(1+exp(-v1(i1)));
            
            v_2=v_2+y1(i1)*w2(i1);%calc v2   
        end
        e_x=d(i_x)-v_2;
        
 %      if abs(e_x)>max_err% nezinau ar sito reikia?
%       if abs(e_x)>max_err/10% nezinau ar sito reikia?
         if 1
        
            
            b2=b2+e_x*n;
            
            for i4=1:len
                 w2(i4)=w2(i4)+n*e_x*y1(i4);
                
%                 delta=y1(i4)*(1-y1(i4))*w2(i4)*x(i_x);
%                 w1(i4)=w1(i4)+n*e_x*delta;
%                 b1(i4)=b1(i4)+n*e_x;
                
                delta=y1(i4)*(1-y1(i4))*e_x*w2(i4);
                w1(i4)=w1(i4)+n*delta*x(i_x);
                b1(i4)=b1(i4)+n*delta;
                
                
            end
        end  
    end
    
    
    for i_x=[1:length(x)]
        v_2=b2;
        for i1=1:len
        v1(i1)=w1(i1)*x(i_x)+b1(i1);
        y1(i1)=1/(1+exp(-v1(i1)));
          v_2=v_2+y1(i1)*w2(i1);
        end

        e_x_check(i_x)=d(i_x)-v_2;
 
     end

    e=max(abs(e_x_check));
    
    
    cnt =cnt+1;
    if mod(cnt,100000)==0
        disp('---100k---')
        disp(cnt)
        disp(e)
        disp(e_x_check)

    end
end
        disp('-------')

y_ans=zeros(1,length(x));
for i_x=[1:length(x)]
    for i1=1:len
    v1(i1)=w1(i1)*x(i_x)+b1(i1);
    y1(i1)=1/(1+exp(-v1(i1)));
    end
    v_2=b2;
    for i2=1:len%v2 calc
        v_2=v_2+y1(i2)*w2(i2);
    end
    e_x(i_x)=d(i_x)-v_2;
    y_ans(i_x)=v_2;
 end
%  disp(e_x);
%  disp(d);
%  disp(y_ans);
 
 
disp(max(abs(e_x)));


% w1
% w2
% b1
% b2
 plot(x,d,x,y_ans)
