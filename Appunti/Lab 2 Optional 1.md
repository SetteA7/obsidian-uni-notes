[[Microelectronics Theory]]
# 1) Optional: BJT-based Astable Multivibrator
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
## 1.1) In the Laboratory

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

