[[Microelectronics Theory]]
# 1) Laboratory on Voltage Converters
**Group No. B2**
**Date 13/03/25**

| Last Name/First Name | ID Number |
| -------------------- | --------- |
| Miotto Isabella      | 2066715   |
| Orso Marco (absent)  | 2074059   |
| Sette Andrea         | 2066747   |

## 1.1) First Experiment
**Goals of the experiment:** 
- to investigate a switching mode power converter (SMPC) with Buck topology, in open loop
List of components:

**List Of Components**

| Tipo componente        | Codice costruttore/Valore                           |
| ---------------------- | --------------------------------------------------- |
| Switch: MOSFET         | IRF630                                              |
| Gate driver            | LTC7001                                             |
| D: pn diode            | 1N4004                                              |
| $R_L$: Load resistance | 50 $[\ohm]$ (two $100\ [\ohm]$ in parallel, 1 Watt) |
| L: inductor            | 400 $[\mu H]$ ideal, 684 $[\mu H]$ in lab           |
| C: capacitor           | 1.6 $[\mu F]$ ideal, 1 $[\mu F]$ in lab             |
![[Pasted image 20250328162313.png|LC Low-Pass Schematic|350]]
### 1.1.1) Prelab
1) Considering a switching frequency of 50 $[kHz]$, and an input voltage $V_i$=8 $[V]$, determine the minimum value of the inductance to guarantee continuous conduction mode for duty cycles higher than 20 % (discuss, with the help of formulas)
$$L_{min}=\frac{(1-\delta)R_L}{2 f}=400\ [\mu H]$$
2) Choose a proper inductor, from those available in the laboratory
$$L=684 \ [\mu H]\geq L_{min}$$
3) Calculate the expected minimum and maximum inductor current and add the results to the report
By keeping in mind that $V_o=\frac{t_{on}}{T}V_i=\delta V_i$
$$\begin{gather}
i_{L,min}=V_o\left(\frac1R-\frac{1-\delta}{2L_{min}f}\right)=0 &[A] \\
i_{L,max}=V_o\left(\frac1R+\frac{1-\delta}{2L_{min}f}\right)=64 &[mA]
\end{gather}$$
4) Find a proper value of the capacitance $C$, to ensure that the output voltage ripple is smaller than 100 $[mV]$ (discuss, with the help of formulas)
$$\Delta V_C=\frac{\Delta I_L}{8fC}\rightarrow C=\frac{i_{L,max}-i_{L,min}}{8f\Delta V_o}\stackrel{\Delta V_o\leq 100 \ [mV]}{\geq}1.6 \ [\mu F]$$
However, the capacitance used in the lab was smaller since the calculations were adjusted to the inductance that was actually used:
$$\begin{gather}
i_{L,min}'=V_o\left(\frac1R-\frac{1-\delta}{2Lf}\right)=13.29 &[mA] \\
i_{L,max}'=V_o\left(\frac1R+\frac{1-\delta}{2Lf}\right)=50.71 &[mA]
\end{gather}$$
And therefore $$C'\geq0.935 \ [\mu F]$$
$C=1 \ [\mu F]$ was chosen in the Lab

### 1.1.2) In the Lab
1) Build the circuit, following the schematic below
2) Use the bipolar voltage output on the right of the power supply (channel 2), to generate the $8 \ [V]$ voltage necessary for the circuit
![[Pasted image 20250328155011.png|Complete Circuit Schematic|550]]
3) Apply a square wave ($V_{pp}$= 5 $[V]$, $V_{offset}$=2.5 $[V]$, $f$=50 $[kHz]$, duty cycle=50 %) to the INP terminal of the LTC7001
4) Check the voltages on the gate and on the source of the transistor and add the related plots to the report, with a short comment

>[!col]
>The voltage at the gate should be a square wave with a lower peak-to peak voltage. The voltage difference is given by the MOSFET since it doesn't require the maximum voltage to operate. Our wave isn't perfectly square either, this can be due to many factors, from Eddy currents to parasitic capacitances of the breadboard. 
>
>![[Pasted image 20250328162544.png|Voltage at the Gate|450]]

>[!col]
>At the source we can see a similar effect of disturbances, but we have a remarkably good rise time.  
>
>![[Pasted image 20250328162712.png|Voltage on the Source|450]]




5) Measure the output voltage across the load resistor R, as a function of time and add the related plot to the report, with a short comment
![[Pasted image 20250328163512.png|Voltage On The Load Resistor|450]]
The aim of the SMPC is to deliver a direct voltage to the output. The measurement shows an output voltage as a smooth wave with small $V_{pp}$. This was the expected behaviour of the low-pass filter.

6) By using the current probe (clamp it on one of the leads of the inductor), measure the current through the inductor during few switching periods. Compare the results to the expected value (point 3, PRELAB) 
![[Pasted image 20250328163549.png|Current through the inductor|450]]
Ideally the output current should exhibit a triangular wave. Our measurements don't quite respect that. Despite that the measured $\Delta I_L=27 \ [mA]$ corresponds to the theoretical expected values $\Delta I_L=24 \ [mA]$ which was calculated using the formulas in the prelab


7) Measure the ripple of the output voltage and add the related plot to the report, with a short comment
![[Pasted image 20250328164213.png|Voltage Ripple|450]]
The ripple at the voltage of the capacitor is given by:
$$\Delta V_C=\frac1C\int i_cdt=\frac1C\int i_l-i_odt=\frac1{2C}(I_{C,max}\frac{t_{ON}-t_{OFF}}{2})=\frac{\Delta I_L}{8fC}$$
Our measure is of $\Delta V_C=74 \ [mV]$. During the converter operation, the capacitor voltage exhibits a ripple caused by the energy exchange with the inductor. This ripple can be estimated by considering that within one period the average current on the capacitor has to be zero. This assumption is a direct consequence of steady-state operation and of the capacitor equation.

8) Measure the dependence of the output voltage on duty cycle, and fill the table below

| Duty cycle (%) | Min/Max Output Voltage (V) | Mean Output Voltage (V) |
| -------------- | -------------------------- | ----------------------- |
| 20             | 1.73 / 1.81     1,77       | 1.77                    |
| 30             | 1.98 / 2.06 V    2,02 V    | 2.02                    |
| 40             | 2.28 / 2.36  V   2,32 V    | 2.32                    |
| 50             | 2.64 / 2.71 V   2,68 V     | 2.68                    |
| 60             | 3.04 / 3.10 V   3,07 V     | 3.07                    |
| 70             | 3.44 / 3.48 V  3,46 V      | 3.46                    |
| 80             | 3.78 / 3.81 V   3,79 V     | 3.79                    |
![[Pasted image 20250329103701.png|Duty Cycle-Vout Graph|550]]
This curve empirically approximates the ideal curve $V_{o}=\delta\cdot V_i$.

## 1.2) Second Experiment
**Goal of the experiment:**
- to investigate a switching mode power converter (SMPC) with Buck topology, in closed loop

![[Pasted image 20250328172630.png|Schematic|450]]
### 1.2.1) Prelab
1) Consider now to set $C_1=20 \ [\mu F]$, and use the same values of $L_1$ and $R_1$ used in the first part of the experiment
2) Calculate and plot the Bode diagram of the LRC filter
$$G_f(s)=\frac{1}{\frac{s^2}{w_0^2}+\frac{s}{Qw_0}+1}=\frac{1}{LCs^2+\frac LRs+1}$$

![[Pasted image 20250328173133.png|Asymptotic and Real Bode Plot|650]]
3) Add a feedback loop, by modifying the circuit as follows (for $V_{ref}$, use the left CH1 output of the power supply; for powering the op amp use the positive/negative voltage output CH2 and CH3 on the right; set +$V_{cc}=8 \ [V]$; -$V_{cc}=0 \ [V]$).
![[Pasted image 20250328173307.png|Complete Schematic|450]]
4) Choose proper values for the resistors $R_6, R_7$, with the goal of having an output voltage on the load equal $V_{ref}$); $R_6=R_7$ note that the presence of the voltage divider $R_1, R_2$ connected to the output will modify the loop gain compared to what seen during the lecture
$$R_6=R_7=10 \ [k\ohm]$$
5) Choose proper values for the capacitors $C_F$ and $C_I$ (the goal is to have a stable system, as discussed during the lecture; set $R_F$ and $R_I$ to 10 $[k\ohm]$)
The transfer function is given by:
$$G_R(s)=k\frac{(1+s\tau_1)(1+s\tau_2)}{s\tau_1}$$
with $k=-R_f/R_I=1$, $\tau_1=R_FC_F$ and $\tau_2=R_IC_I$. To have a stable system, the phase margin must be positive and by choosing both capacitors of $10 \ [nF]$ we end up with

![[Pasted image 20250328174123.png|real and Asymptotic Bode Plot|550]]
6) Connect a 10 $[\mu F]$ capacitor in parallel to the supply of the OP amp (between +$V_{cc}$ and -$V_{cc}$)
7) Calculate and plot the Bode diagram of the loop gain (completo), as discussed during the lecture
$$T(s)=G_R(s)G_f(s)\frac{V_i}{W_{max}}$$
![[Pasted image 20250331192335.png|Bode Plot Real + Asymptotic|650]]

8) Turn on the circuit and evaluate the behavior, by adding proper plots to the report (for $V_{ref}$=4 $[V]$, plot the output voltage,  the signal on the INP input of the LTC7001, the saw-tooth signal, the signal at the output of U1)

![[Pasted image 20250401181337.png|Final Circuit (Not working)|350]]

9) Measure the dependence of the output voltage on $V_{ref}$, and fill the table below
Unfortunately, the circuit didn't work correctly and we weren't able to fill the table. In the lab we would have expected the following behaviour:

The Buck Converter steps down $V_{in}$ to a smaller $V_{out}$ by keeping it as constant as possible using a MOSFET. Moreover, the presence of $C_5$ allows the voltage to gradually build up instead of spiking and potentially damaging the devices that are connected to it. The PID controller is able to dynamically change the duty cycle in order to balance $V_{out}=\delta V_{in}$ to a constant output. The controller measures the difference between $V_{out}, V_{ref}$ and tries to minimize it, therefore the duty cycle is directly proportional to $V_{ref}$.



10) Future of electronics: new semiconductors like GaN and SiC are much better than silicon for efficient power conversion in energy efficiency applications (electric cars, photovoltaics, etc.). Why?

>[!col]
>New semiconductor materials like GaN (Gallium Nitride) and SiC (Silicon Carbide) offer significant advantages that make them well-suited for applications in electric vehicles, renewable energy, and high-power industrial systems.
>Thanks to their superior thermal conductivity they providing better heat dissipation and their wide bandgaps allow them to handle higher voltages and temperatures than silicon.
>
>![[Pasted image 20250402111127.png|Example of GaN Power Converter|350]]

Due to these several unique properties GaN and SiC can operate in harsher environments, they are more compact, powerful and reliable while also offering reduced switching losses enabling faster operation and higher efficiency.