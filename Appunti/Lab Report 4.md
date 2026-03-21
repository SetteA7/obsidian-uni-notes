[[Microelectronics Theory]]
# 1) Laboratory Activity: Class A and B Audio Amplifiers

**Group No. B2**
**Date 10/04/25**

| Last Name/First Name | ID Number |
| -------------------- | --------- |
| Miotto Isabella      | 2066715   |
| Orso Marco           | 2074059   |
| Sette Andrea         | 2066747   |


**Purpose of the laboratory activity:** to study - through appropriate experiments – the properties of class A and B power amplifiers; to evaluate crossover distortion; to analyze a possible methodology for reducing crossover distortion (based on feedback).

The circuit analyzed within this exercise is an audio amplifier suitable for amplifying the signal generated at the 3.5 mm output of a phone, pc or a tablet.
## 1.1) First Experiment
**Purpose of the experiment:** to size, build and study a class A amplifier biased through a current-mirror

**Instrumentation Needed:**
- Arbitrary waveform generator
- 2-channel oscilloscope
- 1 BNC "T" connector
- 2 BNC male/banana female connector
- 1 female-female BNC connector
- 1 BNC cable
- Cable 1 mm
- Wire stripper
- MP3 player (Laptop) (low value)

![[Pasted image 20250411104342.png|Circuit Diagram|550]]
The circuit consists of three main blocks. The first stage (left) is a buffer, connected to an RC network ($R_1$ and $C_1$), which is intended to filter out the dc component of the $V_{in}$ signal (which – if amplified – could damage the speaker). 
The second operational amplifier is connected in an inverting configuration, and is used to control the volume. The maximum volume is limited by the presence of resistor $R_2$ . 

The third stage (output stage) is a class A amplifier, biased through a current mirror. The two mirror transistors are bipolar power transistors and - for achieving the best performance – should be identical to one another. 

>[!hypothesis|*]
Some components (BJTs, resistors) may reach high temperatures during operation. Avoid touching components during operation, use heatsinks for bipolar transistors.

**Components Needed:**

| Component type                              | Manufacturer Code/Value   |
| ------------------------------------------- | ------------------------- |
| Q1, Q2, Q3: power NPN transistors           | TIP41CG                   |
| Op-amp, dual output, rail to rail           | MCP6002                   |
| $C_1$ : Coupling capacitor                  | 220 $[nF]$, film          |
| $R_1$ : Input resistor                      | 220 $[k\ohm]$, 0.25 $[W]$ |
| $R_2$ : Volume limitation resistor          | 500 $[k\ohm]$, 0.25 $[W]$ |
| $R_{var}$ : Volume adjustment potentiometer | 10 $[k\ohm]$, logarithmic |
| $R_L$ : Load resistor                       | 8 $[\ohm]$, 2 $[W]$       |
| $R_S$ : Current mirror resistor             | 8 $[\ohm]$, 2 $[W]$       |
| Speaker 8 $[\ohm]$, 200 $[mW]$              | AS05008PR-2-R             |
The circuit is supplied with dual voltage ±$V_{CC}$ =±3 $[V]$. 

### 1.1.1) Introduction
1) Find component datasheets
2) Given the current mirror in the figure, define the value of the resistor RS that allows the dc current on the load ($R_L$ =8 $[\ohm]$) to be 0.3$[A]$
![[Pasted image 20250411105157.png|Circuit Diagram|450]]
$$I=\frac{V_{CC}-V_{BE3}}{R_S}=0.3 \ [A]\implies R_S=6.66 \ [\ohm]\approx 8 \ [\ohm]$$

3) Calculate the cut-off frequency of the input RC filter; draw the Bode plot of the transfer function $V_F/V_{in}$ (here $V_F$ is the voltage across resistor $R_1$) $$G(s)=sRC/(1+sRC)$$
![[Pasted image 20250411105243.png|Bode Plots|650]]
$$f=0.0484 \ [Hz]>0$$

4) Calculate the value of $R_2$ that allows the gain of the inverting stage ($V_A/V_F$ ) to be limited to the maximum value of 26.0 $[dB]$. This resistor will be used to limit the maximum volume of the circuit and prevent the transistors from overheating
$$\text{Inverting Amplifier: } A_v=-\frac{R_{var}}{R_2}=26 \ [dB]\implies R_2=500 \ [\ohm]$$
### 1.1.2) In the Laboratory
1) Mount the current mirror on the breadboard
2) Bias the mirror with $-V_{CC}$ =$-3$ $[V]$; measure the current on resistor $R_S$ and the current on resistor $R_L$ . Are there any differences? How can they be explained? Comment briefly (pay attention to component heating!).
$$\begin{gather}
I_{RS}=0.2984 &[A] \\
I_{RL}=0.2875 &[A]
\end{gather}$$
The slight difference is given by the non ideality of the BJTs used, moreover we ignored the $I_B$ currents of the BJTs since they are of a lower order of magnitude.

3) Turn off the power supply. Mount the filter and preamplifier on the breadboard; also connect the ±$V_{CC}$ power supply , without turning on.
![[Pasted image 20250411110034.png|Circuit Diagram|450]]
4) Connect - through a "T" connector – the function generator to the Vin input; connect the other end of the "T" connector to the first channel of the oscilloscope. Connect the output of the inverting amplifier to the second channel of the oscilloscope, via appropriate leads and BNC/banana connector (see figure below)
![[Pasted image 20250411110101.png|Diagram|450]]
![[Pasted image 20250411110121.png|Measurements|650]]

5) Turn on the dual power supply ±$V_{CC}$ =±$3$ $[V]$; adjust the potentiometer $R_{var}$ so as to have maximum gain (at this stage it is recommended to disconnect the current mirror, to avoid transistor heating during measurements)
6) Measure the gain ($V_A/V_{in}$) of the circuit, in the frequency range between 1 $[Hz]$ and 1000 $[Hz]$, by applying a signal with the following characteristics to the input of the circuit:

| Frequency $[Hz]$ | $V_{A_{pp}}$ $[V_{pp}]$ | $\| V_A /V_{in} \|$ $[dB]$ |
| ---------------- | ----------------------- | -------------------------- |
| 1                | 0.720                   | 16.4                       |
| 3                | 1,61                    | 23.39                      |
| 5                | 1,93                    | 24.96                      |
| 10               | 2,25                    | 26.30                      |
| 30               | 2,33                    | 26.60                      |
| 50               | 2,33                    | 26.60                      |
| 100              | 2,33                    | 26.60                      |
| 300              | 2,33                    | 26.60                      |
| 500              | 2,33                    | 26.60                      |
| 1000             | 2,33                    | 26.60                      |
7) Plot the Bode diagram of the modulus of $V_A/V_{in}$  and compare it with the theoretical trend calculated during PRELAB; verify that the value of $R_2$ chosen actually allows the circuit gain to be limited to 26.0 $[dB]$
8) Connect the class A stage to the filter, as shown in Figure. Connect the circuit to the power supply, signal generator, and 8 $[\ohm]$  speaker 
![[Pasted image 20250411110654.png|Diagram|650]]
9) Apply an input signal to the circuit, with the following characteristics:
	 - Waveform: sinusoidal
	- Frequency: 330 $[Hz]$ (corresponding to the tone E)
	- Amplitude: 100 $[mV_{pp}]$
10) Adjust the oscilloscope so that you can analyze the input signal; adjust the potentiometer (volume) so that you reach an amplitude of 1 $[V_{pp}]$ on the output signal (if you do not reach 1 $[V_{pp}]$, explain why). Can you hear an output signal at the speaker??!
11) Measure the input ($V_{in}$) and output ($V_{out}$) signals with the oscilloscope and save the corresponding waveforms 
![[Pasted image 20250411110953.png|Mesurements|550]]

From here the amplification is evident and by looking at the peak-to-peak voltages it is clear that the gain is less than $26 \ [dB]$.

12)  Display and measure the signals $V_{out}$ and $V_{Base, Q1}$ by oscilloscope. Measure the difference between the two signals (also use xy mode if necessary)
![[Pasted image 20250411111049.png|Measurements|550]]
Here the blue line is $V_{BE}$ and it is clearly constant. This allows the BJT to remain in saturation region and is able to supply the correct current.

13) Estimate the efficiency of the circuit under these conditions (evaluating both the power transferred to the load and the power absorbed by the supplies, during a period); report waveforms and the considerations made
In input we deliver $P=V_{PP}I=366 \ [mW]$ at the output we can calculate the power as $P=V^2/R_L=115 \ [mW]$. As expected we deliver $31$% of power.

![[Pasted image 20250412163508.png|Proof of 330 Hz wave|450]]

14) Do you have a device (phone, PC, tablet, …) with a 3.5 mm jack output? It's time to try connecting it to the input of the circuit! (Be aware that errors in cable connection or circuit configuration can damage the device itself! We do not take responsibility for any damage!!!). Here's what to do:
	- Turn off the circuit power supply
	- Disconnect the function generator from the circuit input
	- Connect the 3.5 mm jack to the MP3 player
	- Connect the two output cables to the jack between Vin and ground
	- Turn on the circuit power supply
	- Turn on and use the MP3 player
	- Listen. In the second part of the experiment we will test the audio quality of a class B amplifier. We will use feedback to reduce distortions

## 1.2) Second Experiment (Optional)
**Purpose of the experiment:** to build and study a class B amplifier.

The circuit is supplied with dual voltage ±$V_{CC}$ =±$12 \ [V]$ (CHANGE OP AMP TO TL082!!!)
Modify the circuit by replacing the class A schematic with a class B stage (see figure below). Connect the circuit to the power supply, signal generator and 8 $[\ohm]$ speaker 

![[Pasted image 20250411113342.png|Diagram|450]]
1) Apply an input signal to the circuit, with the following characteristics:
	- Waveform: sinusoidal
	- Frequency: 330 $[Hz]$
	- Amplitude: 100 $mV_{pp}$
2) Adjust the oscilloscope so as to display the input signal; adjust the potentiometer (volume) so as to achieve an amplitude of 1 $[V_{pp}]$ on the output signal. Can you hear an output signal at the speaker??!
3) Measure the output signal with the oscilloscope and save the waveforms of the input and output signals

4)  Measure - through cursors – the effect of crossover distortion. Indicate in the table the dead time due to crossover distortion
$$\text{Dead Time: } 520 \ [\mu s]$$
![[Pasted image 20250411113618.png|measurements|550]]
5) Do you have a device (phone, PC, tablet, …) with a 3.5 mm jack output? It's time to try connecting it to the input of the circuit! (Be aware that errors in cable connection or circuit configuration can damage the device itself! We do not take responsibility for any damage!!!). Here's what to do:
	- Turn off the circuit power supply
	- Disconnect the function generator from the circuit input
	- Connect the 3.5 mm jack to the MP3 player
	- Connect the two output cables to the jack between Vin and ground
	- Turn on the circuit power supply
	- Turn on and use the MP3 player
	- Listen: can you recognize the effect of crossover distortion? In the third part of the experiment we will use feedback to reduce this effect

## 1.3) Third Experiment (Optional) 
**Purpose of experiment:** to build and study a push-pull (class B) amplifier with feedback; to evaluate the effect of feedback on crossover distortion.

![[Pasted image 20250411113855.png|Diagram|550]]
How does this circuit work? Briefly explain
As before we have a pre amplification step made by the two opamps. The BJTs amplify in the following way:
- QN amplifies the positive half wave
- QP amplifies the negative half waves
The waveforms approximately $\in[-0.5, 0.5]  \ [V]$ won't be correctly amplified since both transistors are off, this is called *crossover* effect

The TL082 op-amp was chosen in this experiment; how much is the slew rate of this op-amp, compared with that of the LM741 and LM1458 op-amps that have been used in previous experiments?

| BJT    | Slew Rate $[V/\mu s]$ |
| ------ | --------------------- |
| TL082  | 13                    |
| LM741  | 0.5                   |
| LM1458 | 0.5                   |

Why is it important to use op-amps with high slew rate?
Higher slew rate means that they will give a higher frequency response, that is less distorted.


**Components Needed:**

| Component type                         | Manufacturer Code/Value          |
| -------------------------------------- | -------------------------------- |
| Dual output operational amplifier      | TL082CP                          |
| Q1: power NPN transistor               | TIP41CG                          |
| Q2: PNP power transistor               | TIP42                            |
| C1 : Coupling capacitor                | 220 $[nF]$, film                 |
| R1 : Input resistor                    | 220 $[k\ohm]$, 0.25 $[W]$        |
| R2 : Volume limitation resistor        | calculated in step 1, 0.25 $[W]$ |
| Rvar : Volume adjustment potentiometer | 10 $[k\ohm]$, logarithmic        |
| Speaker 8 $[\ohm]$, 200 $[mW]$         | AS05008PR-2-R                    |
### 1.3.1) In the Laboratory
1) Build the circuit in the figure
2) Connect-through a "T" connector-the function generator to the Vin input; connect the other end of the "T" connector to the first channel of the oscilloscope. Connect the output Vout to the second channel of the oscilloscope, via appropriate leads and BNC/banana connector (see figure below)
3) Turn on the dual circuit power supply ±$V_{CC}$ =±12 $[V]$
4) Apply an input signal to the circuit, with the following characteristics:
	- Waveform: sinusoidal
	- Frequency: 330 $[Hz]$
	- Amplitude: 100 $[mV_{pp}]$
5) Adjust the oscilloscope so as to display the input signal; adjust the potentiometer (volume) so as to achieve an amplitude of 1 $V_{pp}$ on the output signal. Can you hear an output signal at the speaker??!
6) Measure the output signal with the oscilloscope and save the waveforms of input and output signals

![[Pasted image 20250411114305.png|Measurements|550]]

7) Measure - through cursors – the effect of crossover distortion. Indicate in the table the dead time due to crossover distortion
$$\text{Dead Time: }50 \ [\mu s]$$
# 2) Single-Stage Audio Amplifier
**Purpose of the laboratory activity:** to design and test a single-stage (CE) audio amplifier
![[Pasted image 20250412172218.png|Schematic|450]]
Considering the schematic circuit in figure (where the BJT is a 2N2222 transistor, and $R_{in}$ represents the 50 $\ohm$ output resistance of the waveform generator):

1) Set $V_{CC}=15 \ [V], R_3=100 \ [k\ohm]$
2) Design the circuit so that the transconductance of the transistor is $g_m=50 \ [mS]$
From here it is possible to find $I_C$ since at 300 $[K]$ the thermal voltage is $U_T=\frac{kT}q\rightarrow 1/U_T\approx 40$. Therefore $g_m\approx 40 I_C\rightarrow I_C=1.25 \ [mA]$.
Moreover at this operating point the current gain is $\beta=50$ and therefore $I_B=I_C/\beta=25 \ [\mu A]$.
3) Define the value of the collector resistor $R_C$ to ensure a proper dc operating point at the output node
The BJT amp works with the BJT is saturation region. In order to work in said region these two conditions must hold: $I_B>0 \ [V]$ (already verified) and $V_{CE}>V_{CE_{sat}}$

During the DC analysis the capacitors act as open circuits. By applying Thevenin to $V_{DD},R_1,R_2$ and using the BJT equivalent model in the saturation region we can derive the following circuit:
![[Pasted image 20250412172803.png|DC Analysis|550]]
With $R_{BB}=R_1//R_2$ and $V_{BB}=\frac{R_2}{R_1+R_2}V_{DD}$.

We want to have $V_C=V_{DD}/2=V_{DD}-R_C I_C\implies \boxed{R_C=6 \ [k\ohm]}$.
Now to find $V_E$ we need to find values of $R_1, R_2$ that satisfy the condition $V_{CE}>V_{CE_{sat}}$. By choosing $\boxed{R_1=100 \ [k\ohm], R_2 = 15 [k\ohm]}$ we end up with the following values:
$$\begin{align}
&V_C=\frac{V_{DD}}2=7.5  &&[V]\\
& V_E=V_{BB}-I_BR_{BB}-V_{BE_{sat}}=1.05 && [V] \\
& V_{CE}=6.45 \ [V]>V_{CE_{sat}}=0.3 && [V]
\end{align}$$
Where $V_{CE_{sat}}=0.3 \ [V]$ and $V_{BE_{sat}}\approx0.9 \ [V]$ where found from the datasheet.

4) Choose the value of $R_{E1}$ to obtain an ac gain equal to 27 $[dB]$, and show the related calculations

The configuration of the amplifier is clearly a Common Emitter with degeneration Resistance (CER) and it is possible to directly apply its small signals model:

$$\begin{align}
&\begin{cases}
g_m=50 &[mS] \\
r_\pi=\frac{\beta}{g_m}=1 &[\ohm]
\end{cases} \\
&\begin{cases}
R_i=r_\pi +(\beta+1)R_{E1} \\
R_o=R_C//R_3=5.6 & [k\ohm] \\
G_m=\frac{g_m}{1+g_mR_{E1}}
\end{cases} 
\end{align}$$
By also recalling that the capacitors act as closed circuits and that $V_{DD}$ acts as AC ground we can arrive to the following equivalent circuit:
![[Pasted image 20250412174618.png|AC Analysis|450]]
By applying a bunch of times Kirchhoff we arrive to $$\begin{gather}
&v_o(v_i)=-G_mR_ov_i \\
&v_i(v_{in})=\frac{R_{BB}//R_i}{R_{BB}//R_i+R_{in}}v_{in} \\
&\implies v_o(v_{in})=-\frac{R_o(R_{BB}//R_i)}{R_{BB}//R_i+R_{in}}G_mv_{in}\implies A_v=-\frac{R_o(R_{BB}//R_i)}{R_{BB}//R_i+R_{in}}G_m
\end{gather}$$
Since $A_v=26 \ [dB]=22.387$ by tediously solving the equation it is possible to find the following value of $\boxed{R_{E1}=228 \ [\ohm]\approx 230 \ [\ohm]}$.

5) Choose the value of $R_{E2}$ (and motivate your choice)
We want to have 
$$R_E=R_{E1}+R_{E2}\approx \frac{R_c}{10}\implies \boxed{R_{E2}=370 \ [\ohm]}$$
6) Choose the value of $C_{in}$ , $C_{E2}$, $C_3$  to ensure a minimum (3 $[dB]$) operating frequency of 100 $[Hz]$, and show the related calculations (use capacitance values available in the lab)
We have that $C=\frac{1}{2\pi R_c f_c}$ where for the values of C we use in order $R_{in}=6.2 \ [k\ohm], R_{E2}=R_{E2}=370 \ [k\ohm], R_3=R_{out}=5.6 \ [\ohm]$
We obtain the following values that where the closest capacitance in the lab is to be used
$$\boxed{C_{in}=284 \ [nF], C_{E2}=4.3 \ [nF], C_{3}=257 \ [\mu F]}$$
7) Simulate the circuit in LTSpice and evaluate the DC operating point
![[Pasted image 20250412175809.png|LTSpice Simulation|450]]
The analytical results of the operating points were pointed out above, here are the voltages to recap:
$$V_B=1.64 \ [V], V_E=1.05 \ [V], V_C=7.5 [V]$$

![[Pasted image 20250412180005.png|Simulation Result|550]]
8) What are the input and output resistance of the amplifier?
$$\begin{align}
&R_{in}=R_{BB}//R_i + R_{in}=5.6 && [k\ohm] \\
& R_{out}=R_o=5.6 && [k\ohm]
\end{align}$$