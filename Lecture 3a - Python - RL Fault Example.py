# Plots for RL Circuit Fault
import math
import matplotlib.pyplot as plt

# Theta represents the point on wave for fault inception
pi=math.pi
# theta=pi/2
theta=-69.2*pi/180
phi=71.9*pi/180


current=list()
voltage=list()
time=list()
for step in range(1,160):
   # plot at 32 points per cycle
    t=(1/60)*(step-1)/32
    inew=8914*math.cos(377*t-phi+theta)+6908*math.exp(-125.6*t)
    vnew=math.sqrt(2)*(34500/math.sqrt(3))*math.cos(377*t+theta)
    tnew=t

    # print(step,tnew,inew,vnew)
    current.append(inew)
    voltage.append(vnew)
    time.append(tnew)

plt.title('theta=-69.2 degrees')
plt.xlabel('time (seconds)')
plt.ylabel('Current (Amperes), Voltage (Volts)')
plt.plot(time,current,time,voltage)
plt.show()
