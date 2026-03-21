[[Microelectronics Theory]]
# 1) **Laboratory on Operational Amplifiers – Performance and Limitation**
**Group No. B2**
**Date 13/03/25**

| Last Name/First Name | ID Number |
| -------------------- | --------- |
| Miotto Isabella      | 2066715   |
| Orso Marco           | 2074059   |
| Sette Andrea         | 2066747   |

**Laboratory analysis Operational amplifiers**

**Purpose of the lab:** to study and evaluate through laboratory measurements the non-idealities of operational amplifiers. Through appropriate experiments, the effects of output voltage limitation, output current limitation, slew rate, and bias current will be evaluated. Finally, the frequency response of a low-pass filter will be measured.

**Instrumentation needed:**
- Arbitrary waveform generator
- 2- or 4-channels oscilloscope
- 1 BNC "T" connector
- 2 BNC male/banana female connectors
- 1 female-female BNC connector
- 1 BNC cable
- Electric cable
- Wire strippers

## 1.1) First Experiment
Purpose of the experiment: evaluation of output signal clipping (due to limitation of the maximum output voltage of the op-amp)

![[Pasted image 20250314094347.png|Circuit Diagram|450]]
**Components needed:**

| Component type            | Manufacturer Code/Value                      |
| ------------------------- | -------------------------------------------- |
| Operational amplifier 741 | LM741CN                                      |
| $R_1$ : Input resistor    | Value to be calculated, max power 0.25 $[W]$ |
| $R_2$ : Feedback resistor | Value to be calculated, max power 0.25 $[W]$ |
>[!col]
>By looking at the datasheet it is possible to determine the layout and the Max. supply voltage of the operational amplifier
>$$ $$
>Max Supply Voltage: $\pm 18$
>
![[Pasted image 20250314094538.png|LM741CM Layout|250]]

#### Prelab
1) Define the values of $R_1$ and $R_2$ to obtain a voltage gain of $23.5 dB$.
$$\begin{align}
&R_1=1 \ [k\ohm] \\
&R_2=15 \ [k\ohm]
\end{align}$$
2) Based on the information in the datasheet, estimate the maximum voltage that can be reached by the circuit output when the op-amp is supplied with $\pm \text{VCC}=\pm10 \ [V]$.
$$\text{Max V}_\text{out}= 10 \ [V]$$
3) Prepare the circuit layout by drawing the location of components and their cables on the breadboard shown below. Tips: minimize the length of cables. Use Fritzing to draw the circuit.

![[Pasted image 20250314101019.png|Breadboard|550]]

#### In the Laboratory
1) Build the circuit on the breadboard, based on the layout defined in PRELAB
2) Connect the dual ±VCC power supply =±10 V to the circuit, keeping it off
![[Pasted image 20250314103337.png|Ideal Representation|450]]
![[Pasted image 20250314103513.png|Real Circuit|450]]
3) Connect the BNC "T" to the output of the waveform generator; connect one end of the "T" to the input of Channel 1 of the oscilloscope. Connect the other end of the "T" to the male BNC/female banana connector. Use the BNC/banana connector to bring ground and signal to the circuit. Use a second BNC/banana connector to read the output signal through the Channel 2 of the oscilloscope, as represented in the figure.
4) Once the circuit connections have been checked, keeping the waveform generator output off, turn on the power supply at $\pm \text{VCC}=\pm10 \ [V]$
5) Set the waveform generator as follows:

a. Waveform: square
b. Amplitude: 100 $[mV]$ peak-to-peak
c. Frequency: 300 $[Hz]$
d. Duty cycle: 50 %

6) Set the oscilloscope to display the signals $V_{in}$ and $V_{out}$ simultaneously. Measure the following parameters

| Frequency of input signal=            | 300 $[Hz]$           |
| ------------------------------------- | -------------------- |
| Peak/peak amplitude of input signal=  | 109 ± 2 $[mV]$       |
| Peak/peak amplitude of output signal= | 1.51 ± 2 $[V]$       |
| Amplifier voltage gain=               | 13,9 -  22.86 $[dB]$ |
7) Measure the clipping voltage of the output signal, according to the following steps. Set the waveform generator as follows.

a. Waveform: sinusoidal
b. Initial amplitude: 100 mV peak-to-peak
c. Frequency: 300 Hz
d. Increase the peak-to-peak amplitude of the input signal until clipping of the output voltage is e. observed
e. Save the waveforms at the point where clipping occurs; show the related plots in the report 
f. Take note of the following parameters

![[Pasted image 20250314104203.png|Measures|550]]

| Input voltage at which output signal clipping is observed=                | 1.3 $[V]$   |
| ------------------------------------------------------------------------- | ----------- |
| Output signal clipping voltage (positive half-wave)=                      | 18.3 $[V]$  |
| Output signal clipping voltage (negative half-wave)=                      | 18.3 $[V]$  |
| Difference between positive clipping voltage and positive supply voltage= | 16.97 $[V]$ |
| Difference between negative clipping voltage and negative supply voltage= | 17 $[V]$    |
## 1.2) Second Experiment: Output Current Limitation
**Purpose:** To evaluate the output voltage limitation due to the maximum current that can be delivered by the op-amp
![[Pasted image 20250314112747.png|Circuit Diagram|450]]
**Components needed:**

| Component type            | Manufacturer Code/Value                 |
| ------------------------- | --------------------------------------- |
| Operational amplifier 741 | LM741CN                                 |
| $R_1$ : Input resistor    | $1 \ [k\ohm]$ (as the previous point)   |
| $R_2$ : Feedback resistor | $15 \ [k\ohm]$  (as the previous point) |
| $R_L$ : Load resistor     | $27 \ [\ohm]$, max power $0.25 [W]$     |
|                           |                                         |

#### Prelab
1) Find - from the component's datasheet - the value of the maximum output current that can be delivered by the LM741CN op-amp.
$$\text{Max }I_{out}=25 \ [mA]$$
2) Calculate, from the value determined in 1, the maximum voltage that can be reached by the output of the op-amp (in the circuit configuration shown above)
$$\text{Max }V_{out}=I_{out}R_{eq}=I_{out}(R_L//R_2)=0,674 \ [V]$$
#### In the Laboratory
1) Build the circuit in the figure below (this is the same circuit used during the first experiment, with the addition of the load resistor RL); connect the circuit to the waveform generator (off) and power supply (off)
![[Pasted image 20250314113438.png|Representation|550]]
2) Turn on the power supply $\pm \text{VCC}=\pm10 \ [V]$
3) Turn on the current generator as follows
  
a. Waveform: sinusoidal
b. Initial amplitude: 50 $[mV]$ peak-to-peak
c. Frequency: 300 $[Hz]$
 
4) Gradually increase (step $10 \ [mV]$) the amplitude of the input voltage, while observing the waveform of the output signal with the oscilloscope. Take note of the voltage value $V_{out}$ by which clipping of the output signal is reached
$$\text{Max } V_{out}=1,25 \ [mV_{PP}]=0,625 \ [mV]$$

5) Calculate the value of the current flowing across the resistors $R_L$ and $R_2$ under these conditions and compare it with the maximum voltage that can be delivered at the output of the operational amplifier

| $\text{Max } I_{R_L}$            | 25-24,95 $[mA]$ |
| -------------------------------- | --------------- |
| $\text{Max }I_{R_2}$             | 24,95 $[mA]$    |
| $\text{Max }I_{out}$ (measured)  | 23,15 $[mA]$    |
| $\text{Max }I_{out}$ (datasheet) | 25 $[mA]$       |
6) Explain the observed behavior
Since we are working with *non ideal* op-amps the voltage and current outputs are limited, more importantly the current output is limited by additional security circuits. By design, an *inverting amplifier* with gain $A_v=23.5\ dB$ is used, while, by construction, the maximum output current of the LM741CN is $25 \ [mA]$ .

By a direct application of Kirchhoff's laws we find that $$i_o=\frac{v_o}{R_2}+\frac{v_o}{R_L}=
\begin{cases}
23,19 \ [mA] <\text{Max } I_{out}, &v_0=\text{Max measured } V_{out}\\
25,01 \ [mA] \approx\text{Max } I_{out}, &v_0=\text{Max calculated } V_{out}
\end{cases}$$

From here it is clear that the measured current is correctly lower than the maximum specified.

## 1.3) Third Experiment: Evaluation of the Slew Rate of the Operational Amplifier
**Purpose:** To measure the slew rate of the LM741CN op-amp using a buffer circuit
![[Pasted image 20250314114251.png|Circuit Diagram|350]]
**Components Needed:**

| Component type            | Manufacturer Code/Value |
| ------------------------- | ----------------------- |
| Operational amplifier 741 | LM741CN                 |
#### In the Laboratory
1) Mount the buffer circuit on the breadboard
2) Build the experimental setup below (input $V_{in}$ connected - via "T" - to the waveform generator, output $V_{out}$ connected to oscilloscope channel 2)
![[Pasted image 20250314115713.png|Diagram|650]]
3) Connect the power supply $V_{CC}=\pm 10 \ [V]$ to the circuit
4) Apply a square wave with the following characteristics to the input:

a. Peak-to-peak voltage = $10 \ [V]$
b. Frequency = $20 \ [kHz]$

5) Measure the slew rate; save (picture or data format) the input and output waveforms and add it to the report; then calculate the slew rate

$$\begin{align}
&\text{Rising Slew Rate: } &&689,23 \ [kV/s] \\
&\text{Decreasing Slew Rate: } &&576,0, \ [kV/s] 
\end{align}$$
![[Pasted image 20250314115904.png|Measurement of Descending Slew Rate|550]]
## 1.4) **Fourth Experiment: Effect of Bias Currents on the Performance of an Integrator**

For this experiment, the 1458 operation amplifier is chosen, since it has a rather high bias current (this is usually a considered a flaw, especially if you are interested in integrator circuits).

**Components Needed:**

| Component type        | Manufacturer Code/Value             |
| --------------------- | ----------------------------------- |
| Operational amplifier | MC1458                              |
| $C$                   | 100 $[nF]$, film                    |
| $R$                   | 330 $[k\ohm]$, max power 0.25 $[W]$ |
| Switch                | FSM2JART, RS Code 745-5185          |
>[!col]
>![[Pasted image 20250314132905.png|Circuit Diagram 1|250]]
>
>![[Pasted image 20250314132949.png|Circuit Diagram 2|250]]
#### In the Laboratory
1) Mount the circuit in the figure
2) Read the 1458 datasheet: what is the typical bias current?
$$\text{Current Bias = 80 \ [nA]}$$
3) Connect a digital multimeter to the $V_{out}$ output; with circuit disconnected and capacitance C discharged, the reading should be 0 $[V]$
4) Turn on the dual power supply $VCC =±10 \ [V]$
![[Pasted image 20250314133047.png|Diagram|550]]
5) Once the power supply is connected, if the operational amplifier were ideal, the output voltage would remain zero
6) However, the bias current of the operational amplifier is integrated by the operational amplifier, generating a voltage drop across capacitor $C$. The output voltage $V_{out}$ will then show a linear increase over time until saturation
7) Switch S allows the capacitor to discharge; when the switch is released, the process of integrating the bias current begins again
8) Press switch S, thus discharging capacitor $C$. Release the switch and measure – by the multimeter  - the time it takes for the output voltage $V_{out}$ to rise to the value 2.5 $[V]$
$$t(V_{out}=2.5 \ [V])=14.73 \ [s]$$
9) What is the value of the bias current (approximately)?
$$I_{bias}=\begin{cases}
17 \ &[nA], \text{ calculated} \\
16.6\ &[nA], \text{ measured}
\end{cases}$$





What calculation was made?

Since it is a charge of a capacitor, which is characterized by the functions $i(t)=C\frac{dV}{dt}$ we can approximate the derivative with a time interval since it was possible to measure it.
$$\begin{gather}
i(t)=C\frac{dV_{out}}{dt}=C\frac{\Delta V_{out}}{\Delta t}=C\frac {V_{out}-0}{t-0}\approx17 \ [nA]
\end{gather}$$
On the other hand the measured result was obtained by measuring the voltage on the resistor and the current is therefore $I=V/R$

10) The effect of bias current can be significantly reduced by connecting a second resistor to the non-inverting terminal, see diagram 2

Check the operation of the circuit; how long does it take - in this case - for the output voltage $V_{out}$ to rise from 0 $[V]$ to 2.5 $[V]$ after releasing switch S?
$$t(V_{out}=2.5 \ [V])=62 \ [s]$$
![[Pasted image 20250314134119.png|Diagram|550]]
Explain the observed behavior through the use of formulas.

By looking at the effect in the two cases we have the formulas that remain the same for the output behaviour , so:
$$i(t)=C\frac{dV}{dt}, \ V(t)=\int\frac{i(t)}Cdt$$

In the second case, by looking at the contribution at the inputs of the opamp we have that: $V=I_{bp}R-I_{bn}R$, which is smaller than the first case in which we have only $V=I_{bn}R$ at the non inverting input, where V is the resulting tension by superposition.

These results leads in a smaller offset current in the second case which integrated in time and divided by C results in reaching the target voltage of $2.5 \ [V]$in a larger amount of time than in the fist case.

## 1.5) Fifth Experiment
The purpose of this activity is to experimentally measure the characteristics (gain, cutoff frequency, Bode diagrams) of a low-pass filter based on the LM741 op-amp.

**Components Needed:**

| Component type            | Manufacturer Code/Value              |
| ------------------------- | ------------------------------------ |
| Operational amplifier 741 | LM741CN                              |
| C                         | 100 $[nF]$, film                     |
| R1                        | $10 \ [k\ohm]$, max power 0.25 $[W]$ |
| R2                        | $10 \ [k\ohm]$, max power 0.25 $[W]$ |
#### Prelab

1) Calculate the frequency response of the filter in Figure
2) Determine the value of the resistors R1 , R2 that allow for low-frequency gain of 0 dB and cut-off frequency of 1 kHz
3) Plot the Bode diagram of the modulus and phase of the filter

![[Pasted image 20250318174206.png|Magnitude Bode Plot Real and Asymptotic|650]]
#### In the Simulation
1) Build the circuit in Figure and connect it to the signal generator 
![[Pasted image 20250318174528.png|LTSpice Circuit|650]]
2) Apply a sinusoidal signal $V_{in}$ of amplitude $2 \ [V_{PP}]$ and frequency to $10 \ [Hz]$ to the input of the circuit. Display on the oscilloscope the signals $V_{in}, \ V_{out}$.
3) Measure the low-frequency gain of the circuit and report its value
$$\text{LF gain = }0$$
4) Measure the Bode plot of the filter (modulus); to do so, carry out the measurement in Step 5 at different frequency values; report the results in Table

| Frequency (Hz) | VoutPP (V) | Gain  | Gain (dB) |
| -------------- | ---------- | ----- | --------- |
| 10             | 2          | 1     | 0         |
| 30             | 2          | 1     | 0         |
| 50             | 2          | 1     | 0         |
| 100            | 2          | 1     | 0         |
| 300            | 1,92       | 0,96  | -0,4      |
| 500            | 1,88       | 0,94  | -0,5      |
| 1000           | 1,65       | 0,825 | -1,7      |
| 3000           | 0,85       | 0,425 | -7,4      |
| 5000           | 0,53       | 0,265 | -11,5     |
| 10000          | 0,28       | 0,14  | -17,0     |


![[Pasted image 20250318175542.png|1kHZ Output: Blue is Input, Green is Output|850]]
5) Plot the measured Bode plot of the modulus and compare it with the theoretical trend
![[Pasted image 20250318180418.png|Measured Magnitude Bode Plot|650]]
Here the time scale is referring to the n-th measure, and the y axis the gain in dB. We can see that this plot resembles the real bode plot we previously plotted.