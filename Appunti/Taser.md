CAUTION. > 50 V DC IS DANGEROUS. KEEP CIRCUIT AROUND THIS THRESHOLD.

# 1) Theory
What humans experience as a shock is actually the current passing through the body. An average **dry** human skin has 50 k$\ohm$-1$\ohm$. We start to percieve the current once 5 mA pass through, while 20mA start to become dangerous.

$$V=RI\rightarrow V=\{250, 500\}V$$
But we will start from 50V DC.

A boost converter uses and inductor in order to resist changes in current by either increasing or decreasing the energy stored in the inductor's magnetic field.

$$D=1-\frac{V_{in}}{V_{out}}\rightarrow D_{50V}=0.9$$
![[Pasted image 20251002150129.png|Boost Converter|450]]





For now, the Arduino is used to control the MOSFET and therefore we are limited at 490 Hz (very low), from here $T=2.04 ms$.

The load (person) will be added later, for now we want the capacitor to charge to the full 50 V and we set the maximum output current to 10 mA and therefore $I_{L,avg}=I_{out}\frac{V_{out}}{V_{in}}=0.1 \ A$.

To design the inductor we consider $$\Delta I_L=I_{L,peak}-I_{L,valley}=\frac{V_L}{L}t_{on}=\frac{V_{in}}{L}\frac{D}{f_s}\rightarrow L=\frac{V_{in}}{\Delta I_L}\frac{D}{f_S}$$
$$C=\frac{I_{max}(1-D)}{V_{out}f_s}$$

With the 490 Hz of the arduino and $\Delta I_L=20 mA$ we get:
$$L=460 \ mH$$
$$C= 0.08\ \mu F$$
