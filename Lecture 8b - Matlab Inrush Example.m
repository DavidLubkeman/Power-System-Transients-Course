%  Routine for Plotting Current Inrush based on BH Curve


delT=pi/(180*377)
for i=1:181;
	time(i)=(i-1)*delT;
	v(i)=1.0*cos(377*(i-1)*delT-(pi/2));
	b(i)=0.8*(sin(377*(i-1)*delT-(pi/2))-sin(-pi/2))+.1;
	
	% Use linear interpolation to calculate current;
	if (b(i) >= 0) & (b(i) < .56);
		cur(i)=((.5-0)/(.56-0))*(b(i)-0)+0;

	elseif (b(i) >= .56) & (b(i) < 0.8);
		cur(i)=((1.0-0.5)/(0.8-0.56))*(b(i)-.56)+0.5;

	elseif (b(i) >= .8) & (b(i) < 1.34);
		cur(i)=((3.0-1.0)/(1.34-0.8))*(b(i)-0.8)+1.0;

	elseif (b(i) >= 1.34) & (b(i) < 1.52);
		cur(i)=((5.0-3.0)/(1.52-1.34))*(b(i)-1.34)+3.0;

	elseif (b(i) >= 1.52) & (b(i) < 1.64);
			cur(i)=((10.0-5.0)/(1.64-1.52))*(b(i)-1.52)+5.0;

	elseif (b(i) >= 1.64) & (b(i) < 1.68);
			cur(i)=((14.0-10.0)/(1.68-1.64))*(b(i)-1.64)+10.0;

	elseif (b(i) >= 1.68) ;
		cur(i)=((19.0-14.0)/(1.70-1.68))*(b(i)-1.68)+14.0;

	end;


end;

plot(time,cur,time,v)
xlabel('Time (Sec)')
ylabel('Voltage and Current')