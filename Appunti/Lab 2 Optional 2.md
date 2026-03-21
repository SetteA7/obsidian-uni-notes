[[Microelectronics Theory]]
# 1) Optional: Relaxation Oscillator
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