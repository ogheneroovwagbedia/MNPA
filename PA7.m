%declaration of matries
G=zeros(8,8);
C=zeros(8,8);
F=zeros(8,1);

%variables
c=0.25;
L=0.2;
a = 100;
R1 = 1; 
R2=2;
R3=10;
R4=0.1;
R0=1000;
%conductances
G(1,1)=1/R1; G(1,2)=-1/R1; G(1,6)=1;
G(2,1)=-1/R1; G(2,2)=1/R1 +1/R2;G(2,7)=1;
G(3,3)=1/R3; G(3,7)=-1;
G(4,4)=1/R4; G(4,5)=-1/R4; G(4,8)=1;
G(5,4)=1/R4; G(5,5)=1/R4 +1/R0;
G(6,1)=1;
G(7,2)=1; G(7,3)=-1;
G(8,3)=-a/R3; G(8,4)=1;

C(1,1)=c;
C(1,2)=-c;
C(2,2)=c;
C(2,1)=-c;
C(7,7)=-L;

vin=linspace(-10,0.1,100);
V0=zeros(length(vin),1);
V3=zeros(length(vin),1);

for i=1:length(vin)
    F(6)=vin(i);
    V=G\F;
    V3(i)=V(3);
    V0(i)= V(5);
end 
%DC sweep from -10 to 10
figure(1)
plot(vin,V3)
hold on;
plot(vin,V0)
title('DC sweep');
xlabel('Vin')
ylabel('Voltage')
legend('V3','V0')


f= linspace(0,50,1000);
V0 = zeros(length(f),1);
gain=zeros(length(f),1);
for i=1:length(f)
    S=1i*2*pi*f(i);
    V=inv((G+S.*C))*F;
    V0(i)=abs(V(5));
    gain(i) = 20*log10(abs(V(5))/abs(V(1)));
end 
%plot of Gain vs frequency
figure(2)
plot(2*pi*f,V0);
hold on;
semilogx(2*pi*f, gain);
legend('V3','V0')
xlabel('w')
ylabel('V')
title('Gain vs Freq');

V0=zeros(length(f),1);
gain=zeros(length(f),1);
for i=1:length(V0)
    p = randn()*0.05;
    C(1,1)=c*p;
    C(2,2)=c*p;
    C(1,2)=-c*p;
    C(2,1)=-c*p;
    s=2*pi;
    V=inv((G+S.*C))*F;
    V0(i)=abs(V(5));
    gain(i) = 20*log10(abs(V(5))/abs(V(1)));
end

figure(3);
hist(gain,80);
xlabel('V0/Vin')
ylabel('Number')
title('Histogram of Gain')
figure(4);
hist(V0);
xlabel('C')
ylabel('Number')
title('Histogram of Gain')
