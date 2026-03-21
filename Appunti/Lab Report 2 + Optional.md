[[Microelectronics Theory]]
# 1) Laboratory on Signal Generators Based on Op-amps
**Group No. B2**
**Date 13/03/25**

| Last Name/First Name | ID Number |
| -------------------- | --------- |
| Miotto Isabella      | 2066715   |
| Orso Marco           | 2074059   |
| Sette Andrea         | 2066747
## 1.1) First Experiment
**Purpose of the laboratory:** 
- Design and study signal generators based on operational amplifiers

**Instrumentation needed:**
- Arbitrary waveform generator
- 2-channels oscilloscope
- Power supply
- 1 BNC "T" connector
- 2 BNC male/banana female connectors
- 1 female-to-female BNC connector
- 1 BNC cable
- Cable 1 $[mm]$
- Wire stripper

**Components needed:**

| Component Type                       | Manufacturer Code/Value                      |
| ------------------------------------ | -------------------------------------------- |
| 2 dual-output operational amplifiers | TL082CP                                      |
| Resistors                            | 1 $[k\ohm]$                                  |
| Capacitors                           | 100 $[nF]$, 220 $[nF]$, 1 $[\mu F]$ provided |
| Zener Diodes                         | 1N5229BTR $V_F=1.2 \ [V], \ V_Z=4.3 \ [V]$   |
### 1.1.1) In the Laboratory
The purpose of the experiment is to evaluate the transfer characteristic of the bistable circuit shown in the figure. The signal $v_i$ is applied by a waveform generator, the output $v_O$ is connected to the oscilloscope.

![[Pasted image 20250321113130.png|Circuit Diagram|250]]

The TL082 contains two operational amplifiers, and has the following pinout.
![[Pasted image 20250321103656.png|TL082CP Pinout|250]]
1) Mount the circuit on the breadboard, connecting the positive and negative supplies to the positive and negative outputs of the bench-top power supply.
2) Choose two resistors $R_1=R_2$ of appropriate value, and connect the positive feedback network. What values did you choose? Based on what reasoning?
The two resistors were chosen with the same resistance as this would result in a symmetry between the trigger thresholds $V_{TH}=-V_{TL}$. Moreover we chose the value of $1 \ [k\ohm]$ since it is in a reasonable order of magnitude in order to work well on a real op-amp.

What thresholds do you expect for the bistable circuit?
$$\begin{align}
&V_{TH}=5 &&[V] \\ 
&V_{TL}=-5 &&[V]
\end{align}$$

Based on what reasoning?
The supplied voltage of the op-amp was $V_{CC}=\pm10 \ [V]$ which limits the output at such levels ($L_\pm=\pm10 \ [V]$). Then by analyzing the bistable circuit, in particular the voltage divider ($\beta=\frac{R_1}{R_1+R_2}$), the resulting outputs we arrive to the following formulas
$$\begin{align}
&V_{TH}=\beta v_O=\beta L_+ &&[V] \\ 
&V_{TL}=\beta v_O=\beta L_- &&[V]
\end{align}$$

3) Connect - through a T - the output of the signal generator to both Channel 1 of the oscilloscope and the inverting terminal of the operational amplifier
4) Connect Channel 2 of the oscilloscope to the output of the op amp.
![[Pasted image 20250321113156.png|Diagram|550]]

5) Set the voltages $V_{CC}$ =10 $[V]$, $V_{EE}$ =-10 $[V]$ on the power supply
6) Set the waveform generator so that it delivers a symmetrical triangular wave with $f=100 \ [Hz]$, $V_{pp} =15\ [V]$, and average value equal to zero
7) Display the input and output waveforms, and add the screenshot of the oscilloscope in the report
![[Pasted image 20250321115642.png|Oscilloscope with VTH and VTL Measurements|450]]
 ^336e52
8) What are the maximum and minimum values of the output voltage ($L_\pm$)?
$$\begin{align}
&L_+=8.00 &&[V] \\ 
&L_-=-7.79 &&[V]
\end{align}$$
9) What are thresholds $V_{TH}$ and $V_{TL}$?
$$\begin{align}
&V_{TH}=3.51 &&[V] \\ 
&V_{TL}=-4.09 &&[V]
\end{align}$$
10) Plot the transfer characteristics, measured by using the oscilloscope in xy mode (refer to lab assistants for oscilloscope settings, if needed). This data was already included in the [previous picture](#^336e52)
11) Connect two back-to-back Zener diodes to the output, and add the resistor $R_3$ (choose a value in order to limit the maximum current on the diodes to the value 3 $[mA]$). What value was chosen for $R_3$?
$$R_3=1.5 \ [k\ohm]$$
![[Pasted image 20250321113255.png|Circuit Diagram|350]]
Since we limit the current to $3 \ [mA]$ we must consider a lower forward voltage of the diode with respect to the one in the datasheet, which is given at $200 \ [mA]$; $V_F=0.5<1.2$. When the output of the op-amp is at it's maximum $10 \ [V]$ we can set a fixed value of $v_O$ given by the two zener diodes in the back-to-back implementation, that is: $v_O=V_D+V_Z=0.5+4.3=4.8 \ [V]$. 

To fix a minimum voltage of $3 \ [mA]$ in the diodes, it is sufficient to set this as the current through $R_3$ and by direct application of Kirchhoff laws we can determine the resistance: $$R_3=\frac{\Delta V}{i}=\frac{v_{\text{op-amp}}-v_O}{i_{max}}=\frac{10-4.8 \ [V]}{3 \ [mA]}=1.7 \ [k\ohm]\approx1.5 \ [k\ohm]$$
The rounding was done due to the existing resistances.

12) What voltage do you expect at the output?
$$\begin{align}
&L_+=4.8 &&[V] \\ 
&L_-=-4.8 &&[V]
\end{align}$$
13) Plot the transfer characteristic in this new configuration, measured by using the oscilloscope in xy mode
![[Pasted image 20250321141446.png|Oscilloscope|550]]

## 1.2) Second Experiment
The aim of the experiment is to analyze a triangular, square and sine wave generator based on an astable multivibrator, according to the following schematic.
![[Pasted image 20250321113430.png|Circuit Diagram|450]]

1) Use $R_1 =10 \ [k\ohm], \ R_2 =39\ [k\ohm]$. Assuming that the op-amps are supplied with $V_{CC} =10\ [V], -V_{EE} =-10 \ [V]$, calculate the values of the thresholds $V_{TH}$ and $V_{TL}$
$$\begin{align}
&V_{TH}=2.56 &&[V] \\ 
&V_{TL}=-2.56 &&[V]
\end{align}$$
2) Define the values of $R$ and $C$ be so that the oscillation frequency is 1 $[kHz]$ (10 % deviation is acceptable)
$$\begin{align}
&R=9.77\approx10 &&[k\ohm] \\ 
&C=100 &&[nF]
\end{align}$$
How were these values chosen?
By looking at the time characteristic of the circuit, due to symmetry we can set $$T=\frac1f=2\tau\frac{(V_{TH}-V_{TL})}{L_+}\rightarrow\tau=RC=9.77\cdot10^{-4} \ [s]$$
From here the values of $R, C$ were chosen by keeping in mind the components found in the lab. By setting $C=100 \ [nF]$ the resistance results to be $R=9.77 \ [k\ohm]$. Then a resistance of $10 \ [k\ohm]$ was chosen and the 10% bound was respected

### 1.2.1) In the Laboratory
3) Mount the circuit on the breadboard and connect the oscilloscope to the outputs $v_{O1}$ and $v_{O2}$
4) Turn on the outputs of the power supply ($V_{CC} =10\ [V], -V_{EE} =-10 \ [V]$)
5) Measure the waveforms $v_{O1}$ and $v_{O2}$, and add to the report; evaluate the frequency of the two signals, the peak-to-peak amplitude of the two signals, and include the corresponding values in the report
$$\begin{align}
&\text{Both have same frequency: } 930 \ &&[Hz]\\
&V_{pp1}=4.7 &&[V]\\
&V_{pp2}=18.1 &&[V]\\
\end{align}$$
6) Report the measured waveforms
![[Pasted image 20250321144459.png|Oscilloscope|550]]

7) We now want to generate a sine wave. To do this, we connect a low-pass filter with following schematic to the output $v_{O1}$
![[Pasted image 20250321110337.png|Low-pass Filter Diagram|350]]
8) Choose the values of the resistors (using $C=100 [nF]$) so as to obtain cut-off frequency equal to 100 $[Hz]$ and unity gain at low frequencies
$$\begin{align}
&R_3=R_4=4.7 \ &&[k\ohm]\\
&C=100 &&[n F]
\end{align}$$
![[Pasted image 20250321114749.png|Real and Asymptotic Bode Diagram|450]]
9) Build the circuit. Use an additional TL082, and connect it to the output v01
10) Measure and relate the waveforms $v_{O1}$ and $v_{O3}$
![[Pasted image 20250321143940.png|Oscilloscope|550]]
11) Analyze the peak-to-peak amplitude of the generated sine wave. What is the phase shift with respect to the generated triangular wave? Comment the results
$$\begin{align}
&\text{Triangular wave anticipates by: } 95^\circ \ &&[\deg]\\
&V_{pp1}=4.7 &&[V]\\
&V_{pp3}=400 &&[mV]\\
\end{align}$$
12) Now, compare the sine wave generated by your circuit with that generated by the function generator set with the same parameters (displaying both waveforms on the oscilloscope). Do you notice any differences? Compare the two waveforms and comment on them

![[Pasted image 20250321145340.png|Oscillator|550]]
Due to the non ideality of the low-pass filter some harmonics of the triangular wave are still present and add unwanted contributions to the output sine wave (in green). In person it was possible to see a small difference in period (green wave shifted), this resulted in a constantly changing difference of phase. This is due to the non ideality of the circuit.
# 2) Optional: BJT-based Astable Multivibrator
**Purpose of the laboratory:** 
- To study a BJT-based astable multivibrator that alternately turns on and off two LED diodes
- Understand and describe the operation of this circuit

**Instrumentation needed:**
- Arbitrary waveform generator
- 2-channel oscilloscope
- Power supply
- 1 BNC "T" connector
- 2 BNC male/banana female connectors
- 1 female-to-female BNC connector
- 1 BNC cable
- Cable 1 $[mm]$
- Wire stripper

**Components needed:**

| Component Type            | Manufacturer Code/Value            |
| ------------------------- | ---------------------------------- |
| 2 bipolar npn transistors | BC548                              |
| Resistors                 | R =R14 =470 Ω<br><br>R =R23 =47 κΩ |
| Capacitors                | C =C12 =10 µF                      |
| Red LEDs                  | CREE C503B-RCS-CW0Z0AA1            |
![[Pasted image 20250321111041.png|BJT and Led Diagram|250]]
## 2.1) In the Laboratory

>[!col]
>1) Mount the circuit in the figure, and turn on the power supply with VCC =12 V.
>$$ $$
>![[Pasted image 20250321113549.png|Circuit Diagram|250]]
>
>![[Pasted image 20250321114306.png|Real Life Circuit|250]]


2) Measure the waveforms at the base and collector of transistor Q1 and analyze them. Unfortunately this was not done due to lack of time.
3) Report the waveform out1 and out2 and comment
![[Pasted image 20250321151007.png|Oscilloscope|550]]
Before doing an analysis it is important to describe how the signals are displayed. On a first look it might seem that the two signals are in phase but it is a byproduct of how  the reference of the signals were set. Originally, with the same reference they were sovrapposed so by displacing them it was possible to see the alternation. In the yellow signal, what might look as the minimum (near the green signal) is actually the maximum, this can be verified by looking at the phase which is of $170^\circ\approx180^\circ$. Now it is clear how the circuits work and how the leds were blinking by alternating.

4) Evaluate the period, frequency and duty cycle of the waveform generated at the outputs out1 and out2
In point 3) it was already stated that the two signals were symmetrical (this will be briefly explained later). Since the signal can be approximated in two states $0, V_{CC}$ the duty cycle can be calculated by comparing the duration of the OFF and ON times. This results in 50%. The period is given by the inverse of the frequency $T=1/f=0.54 \ [s]$. This also equals to the sum of the ON and OFF times. 

5) Describe the operation of the circuit
At $t<0$ both transistors are off. By turning on the circuit and only one of the two will turn on due to small fabrication differences. Assuming it is Q1, $V_{BE1}=0.7 \ [V]$ and therefore $v_{O1}=0$.  Since $C_1$ is not charged, Q2 is OFF and therefore $v_{O2}=V_{CC}$. $C_1$ starts to charge and $V_{BQ2}$ will grow. At the same time also $C_2$ charges until $V_{CC}$. Once $V_{BQ2}$ reaches $0.7 \ [V]$ Q2 turns on and $v_{O2}=0$. As this happens the left side of $C_1$ goes to 0.7V and Q1 turns OFF. Therefore $v_{O1}=V_{CC}$, $C_2$ starts to change and the process repeats cyclically.

6) How can the period of the waveform be calculated from the values of the resistors and capacitors? Explain in the report how the circuit works
The analytical formula shows that the period is given by the sum of the duration of the two ON states. Ideally, by construction we have a symmetry between the two times since $R_2C_1=R_3C_2$. By expliciting the formula:
$$T=-\ln\left(\frac{V_{CC}-V_{BE}}{2V_{CC}-V_{BE}-V_{\text{led}}}\right)(R_2C_1+R_3C_2)$$

# 3) Optional: Relaxation Oscillator
**Purpose of the laboratory work:** 
- Analyze and describe the operation of the relaxation oscillator described below (refer to handouts and/or electronics book)
The relaxation oscillator uses an op-amp with positive feedback to generate periodic waveforms. The circuit is a bistable multivibrator, where the output switches between two stable states based on capacitor charging. As the capacitor charges through a resistor, the voltage reaches a threshold, causing the op-amp to switch states and produce a square wave. The period of oscillation depends on the resistor and capacitor values.

- Calculate the values of the components so that the circuit has an oscillation frequency of 100 $[Hz]$, and include the values of $R_1 , R_2 , R$ and $C$ in the report
As in the first experiment $R_1=R_2=1 \ [k\ohm]$ to achieve symmetry and $\beta=\frac{R_1}{R_1+R_2}$=0.5.
The characteristic time is given by the period and therefore we can apply the formula:
$$T=\frac1f=2\tau\ln\frac{1+\beta}{1-\beta}\rightarrow\tau=RC=4.55\cdot10^{-3} \ [s]$$
An real capacity is $1 \ [\mu F]$ and therefore the resistance is $R=4.5 \ [k\ohm]$

- Add the waveforms of $v_- , v_o , v_+$ to the report
![[Pasted image 20250321160746.png|Oscilloscope|450]]
- Save the data related (txt or csv) to the waveform of $v_-$, and derive the time constants of capacitor charge and discharge. Check whether the values match the theoretical ones
>[!col]
>![[Pasted image 20250321113519.png|Circuit Diagram|250]]
>
>![[Pasted image 20250321161343.png|Oscilloscope Charge/Discharge|350]]

From the oscilloscope it is possible to directly measure the time difference between the maximum and minimum voltages at the capacitor. Due to time limitations only the picture is avilable and the distance is $\approx2.5$ squares. This equals to $\approx5 \ [ms]$ which corresponds with our theoretical result of $4.77 \ [ms]$.