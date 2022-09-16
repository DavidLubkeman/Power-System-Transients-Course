% EMTP-style Simulation - Extended Example
clear all;

% Set Circuit Parameters
L=.0022;
R=0.1;
C1=5.12*10^(-6);
C2=10.24*10^(-6);

% Determine Number Steps and DeltaT
Ceq=C1*C2/(C1+C2);
tal=R*Ceq
w0=1/sqrt(L*(C1+C2));
T0=2*pi/w0;
DelT=0.05*tal

% Look at cycles of high frequency oscillation
SimTime=50*T0;

% Trapezoidal Approach

% Set Initial Conditions
Time(1)=0;
il(1)=34.2;
v1(1)=0;
v2(1)=5000;

SwAng=29.4*pi/180;
Vs(1)=10182*sin(SwAng);

% Determine initial conditions for all element currents
is1(1)=il(1);
i20(1)=(v1(1)-v2(1))/R;
i10(1)=is1(1)-i20(1);

% Calculate Admittance Matrix
Y(1,1)=(1/(2*L/DelT)+1/(DelT/(2*C1))+1/R);
Y(1,2)=-1/R;
Y(2,1)=-1/R;
Y(2,2)=(1/R+1/(DelT/(2*C2)));

Tinit=0.0;
t=1;
cnt=1;
while Time(t) < SimTime;
	
	% increment time
	t=t+1;
	cnt=cnt+1;
	
	Time(t)=(cnt-1)*DelT+Tinit;

	Vs(t)=10182*sin(377*Time(t)+SwAng);

	% Calculate Current History Terms
	Is1(t-1)=is1(t-1)+(DelT/(2*L))*(Vs(t-1)-v1(t-1));
	I10(t-1)=-i10(t-1)-(2*C1/DelT)*(v1(t-1));
	I20(t-1)=-i20(t-1)-(2*C2/DelT)*(v2(t-1));
	
	% Calculate Current Vector
	I(1)=Is1(t-1)-I10(t-1)+Vs(t)/(2*L/DelT);
	I(2)=-I20(t-1);

	% Solve YV=I for Voltage Update
	Z=inv(Y);
	V=Z*I';
	v1(t)=V(1);
	v2(t)=V(2);

	% Update Branch Currents
	is1(t)=(Vs(t)-v1(t))/(2*L/DelT)+Is1(t-1);
	i10(t)=v1(t)/(DelT/(2*C1))+I10(t-1);
	i20(t)=v2(t)/(DelT/(2*C2))+I20(t-1);

end;

figure(1);
plot(Time,v1,Time,Vs);
ylabel('Capacitor 1 vs. Source Voltage (Volts)');
xlabel('Time (Seconds)');
title('EMTP Approach');


