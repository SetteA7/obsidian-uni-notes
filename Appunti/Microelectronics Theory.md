# 1) Lab Instrumentation
#### Oscilloscope
The Oscilloscope is a device that graphically displays the electric signals as a function of voltage over time. It is used to measure the wave shape, amplitude, frequency, time between events, noise.

It works by acquiring the signal in an op-amp, samples it, converts the samples to digital, stores and then displays them. Here is the generic architecture:
![[Pasted image 20250526110727.png|Architecture|650]]We measure the **performance** with the following parameters:
>[!def] Bandwidth
>This is the frequency range of the oscilloscope measured in $[MHz]$. It corresponds with the frequency of the  sine wave that is attenuated to 70.7% of the original amplitude. 
>
>It is recommended that the oscilloscope has at least 5 times the bandwidth of the desired signal

>[!def] Sample Rate
>Since the oscilloscope uses digital samples it must be able to acquire them fast enough. The sample rate is defined as samples/seconds $[S/sec]$. By **Nyquist** it is required that the sample rate is at least twice the highest measured frequency. In practice we need 5 times more

>[!def] Record Length
>For each acquired waveform the oscilloscope captures a set number of samples. 
>$$\text{acquired time}=\frac{\text{record length}}{\text{sample rate}}$$

There are multiple controls. Two dilate the scales, one changes the position of the displayed 0 of one signal, one is used for **triggering** and one for **coupling**. 
What is it, how does it work?
It is used to horizontally align repetitions of the signal. This allows periodic signals to be displayed correctly without jumping around.
>[!col]
>What is coupling, how does it work?
>it is divided in AC and DC coupling. 
>In image (a) we have the standard DC coupling. In image b) AC coupling is applied and therefore the DC level becomes the 0 of the signal, this displays the **original zero-to-peak voltage**. It is not centered since the duty cycle is 1/3. It might also cause **droop** (image (c)) due to the loss of some frequencies. 
>Moreover it is possible to change the impedance between $1 \ [M\ohm]$ and $50 \ [\ohm]$. The mega ohm option allows to protect from high input voltages.
>![[Pasted image 20250526112014.png|Coupling|350]]
#### Function Generator
This simply allows to output a desired waveform

# 2) Op-Amps
This chapter is not just a recap of op-amps as seen in the electronics course, but it focuses on **performance and limitations** of real life utilization of such devices.
A **ideal** op-amp has infinite gain, wide bandwidth, infinite input resistance, zero output resistance
A **real** op-amp has 


|                   | Ideal    | Real                              |
| ----------------- | -------- | --------------------------------- |
| Gain              | $\infty$ | finite, $10^5\div10^9$            |
| Input resistance  | $\infty$ | finite, $10^6\div 10^{12} [\ohm]$ |
| Output resistance | 0        | non zero $100\div1000\ [\ohm]$    |
| Bandwdth          | wide     | limited                           |
| Slew rate         | $\infty$ | $0.1\div10 \ [V/\mu s]$           |
Moreover a **real** opamp has also errors given from dc sources (offset voltage, bias current), output voltage and current limits We will see these soon.

**Recap**
>[!todo]

#### Input-Offset Voltage
>[!col]
>We can measure that with a 0 input **the op-amp rests at some non zero dc value** that is given by
>$$V_{OS}=\frac{V_0}{A}$$
>Usually we have $v_0=A(v_{id}+V_{OS})$. Moreover the sign is unknown and there is only an upper bound
>
>![[Pasted image 20250526114108.png|Real-Vs ideal|300]]



>[!exercise|*]
>![[Pasted image 20250526113604.png|Circuit|300]]
>Consider the following circuit with $R_1=1.2, R_2=99 \ [k\ohm]$ and $|V_{OS}|\leq 3 \ [mV]$. Moreover we assume an ideal op-amp but with non-zero offset voltage.
>Now we have a non inverting op-amp:
>$$|V_O|<\left(1+\frac{R_2}{R_1}\right)|V_{OS}|=0.25 \ [V]\rightarrow -0.25 \ [V]<V_O<0.25\ [V] $$

![[Pasted image 20250526114015.png|Note|300]]
#### Input-Bias and Offset Currents
>[!col]
>As seen in the image a real op-amp has two bias currents, whose values determine the offset current$$I_{OS}=I_{B1}-I_{B2}$$
>As before the sign is unknown and there is only an upper bound.
>
>![[Pasted image 20250526114349.png|Real op-amp|300]]

we can redraw any circuit with a real op amp as a circuit with an ideal op-amp in the following way:
![[Pasted image 20250526114511.png|Real to Ideal|350]]
This is an inverting configuration where $V_O=I_{B2}R_2$. Where $I_{B2}$ and $R_2$ can be read in the datasheet as the bias current and input resistance and therefore the value of $V_O$ can be calculated.

The offset current is 5 to 10 times smaller than the individual bias currents. The dc output voltage error can be reduced by using bias compensation.

>[!col]
>We can resort to **bias current compensation** by adding a resistor $R_B$ in parallel with $I_{B1}$ to not short the voltage generator. By superimposition we have that$$\begin{align}
&V_{O1}=-I_{B1}R_B\left(1+\frac{R_2}{R_1}\right) \\
&V_{O2}=I_{B2}R_2\\
&\rightarrow V_{O}=V_{O1}+V_{O2}
\end{align}$$
>If we choose $$R_B=\frac{R_1R_2}{R_1+R_2}$$
>
>![[Pasted image 20250526115143.png]]

we have that $$V_{O}=(I_{B2}-I_{B1})R_2=-I_{OS}R_2$$
#### Real Integrator
Now we will study the real integrator circuit at $t=0$ with the switch just opened.
![[Pasted image 20250526173933.png|Circuit and Formulas|400]]
(As seen before with the switch closed $V_O=V_{OS}$)
Now by solving the circuit we get:$$v_O=V_{OS}+\frac{V_{OS}}{RC}t+\frac{I_{B2}}Ct$$

#### Output Voltage and Current Limits
The **voltage** is limited not directly by the supplied voltage, but it is a few volts shorter.
![[Pasted image 20250526120319.png|Voltage Swing|350]]

The **current** is limied by additional circuitry to limit power dissipation and/or accidental shorts

>[!def] Current Limit
>The current limit is specified as the minimum load resistance that the amplifier can drive with a said voltage swing
>$$i_o<\frac{V_S}{R_L}$$

>[!exercise|*]
>![[Pasted image 20250526120657.png|Circuit|300]]
>Consider the following non-inverting op-amp with $A_v=20\ [dB]$, $R_L\geq 5 \ [k\ohm]$, $v_o\leq 10 \ [V]$ and max output current $i_O\leq2.5 \ [mA]$
>First of all notice that $$R_2//R_L\rightarrow R_{EQ}=R_2//R_L\geq\frac{v_O}{i_O}=\frac{10 \ [V]}{2.5 \ [mA]}=4 \ [k\ohm]$$
>By choosing $R_L=5 \ [k\ohm]\rightarrow R_2\geq20 \ [k\ohm]$ and since $A_v=\frac{R_2}{R_1}=10$ we can choose $R_1= 10, R_2=100 \ [k\ohm]$ to provide an output resistance of $R_{EQ}=10 \ [k\ohm]>4 \ [k\ohm]$. Finally the maximum current will be:
>$$i_O\leq\frac{v_O}{R_2}+\frac{v_O}{R_1}=2.1 \ [mA]\leq2.5 \ [mA]$$

While for an inverting amplifier we can use $$i_O=i_F+i_L=\frac{v_O}{R_L//(R_1+R_2)}$$
#### Slew Rate and Limited Bandwidth
>[!col]
>The **slew rate** is the maximum rate of change of the op-amp. This will limit the maximum amplitude displayed
>
>![[Pasted image 20250526133640.png|Slew Rate|250]]

Fo rno signal distortion we have the following condition:
$$\begin{gather}v_O=V_M\sin(\omega t)\rightarrow\frac{dv_0}{dt}|_{\max}=V_M\omega\cos(\omega t)|_{\max}=V_M\omega\\
V_M\omega<SR\text{ or }V_M<\frac{SR}{\omega}\\
\end{gather}$$
The full power bandwidth is the highest frequancy that can be displayed
$$f_M=\frac{SR}{2\pi V_{FS}}$$
![[Pasted image 20250526134100.png|Example|450]]
In this example the output is a triangular wave since we exceed the slew rate of the real op-amp. The black line is the ideal output
#### Design
If the resistances are too slow we might need an exaggerated amount of voltage, while if they are too big the noise can couple the output. We can do the following:
- limit the gain to a much lower one with respect to te open loop gain ($\approx 10^3$)
- small external resistors with respect to input resistance (input $\approx 1\div100 \ [M\ohm]$)
- big resistors with respect to the output resistance (output $\approx10-1000 \ [\ohm]$)
Then the resistors should be around $1\div100 \ [k\ohm]$

#### Lab Tests

>[!todo] Optional tho

# 3) Signal Generators
These op-amps based circuits will generate elementary waveforms that can be used in many applications such as clocks, test measurements, information transmission. We will use non-linear oscillators

#### Bistable Circuit (Schmitt Trigger)
A bistable circuit has two stable states that can be changed only when appropriately triggered. 
>[!col]
>Here we define the parameter $\beta$ of the voltage divider$$\beta=\frac{R_1}{R_1+R_2}$$
The circuit works by using the **positive feedback**. Suppose we start from $v_+=0$ and have a small perturbation that increases the voltage. This signal will now be amplified by the large gain of the op-amp. The voltage divider will feed $\beta$ to $v_+$ that will be then again amplified until we reach the stable condition $v_+=\beta L_+$. 
>
>![[Pasted image 20250526135532.png|Bistable Circuit|300]]

Now add a generator at the negative input, we have a **inverting bistable circuit**:
![[Pasted image 20250526140056.png|Inverting Bistable Circuit|300]]
>[!col]
>We start with $v_O=L_+$ and thus also $v_+=\beta L_+$. As we increase $v_i$ from 0 to $v_i=v_+=\beta L_+=V_{TH}$ nothing happens. As we increase it further a net **negative voltage appears at the input of the terminals** and $v_O$ goes negative.
>$$ $$
>To go to the other state we must decrease $v_i$ until below $v_i=v_+=\beta L_-)=V_{TL}$. In this case a net positive appears and the output spikes to a high value.
>
>![[Pasted image 20250526140729.png|Transfer Characeristic|350]]

>[!rmk|*] 
>Once we reach one of the two states we remain with the same output level $\forall v_i$ that do not cross the threshold of the other state. **We have a state memory**

Now add a generator between $R_1$ and GND, we have a **non- inverting bistable circuit**:
![[Pasted image 20250526140924.png|Non Inverting Bistable Circuit|350]]
>[!col]
>By superimposition we have:$$v_-=v_i\frac{R_2}{R_1+R_2}+v_O\frac{R_2}{R_1+R_2}$$
>and thus $$\begin{align}
V_{TH}=-L_+\frac{R_1}{R_2}\\
V_{TL}=-L_-\frac{R_1}{R_2}
\end{align}$$
>
>![[Pasted image 20250526170237.png|Transfer Characteristic|300]]
#### Comparator
>[!col]
>The comparator is an analog circuit that detects if a signal is higher or lower than a threshold value. To avoid multiple zeroes due to noise we use **hysteresis, that is, the usage of two thresholds**.
>
>![[Pasted image 20250526170512.png|Comparator|300]]

This component is built using a **inverting bistable circuit with offset**
![[Pasted image 20250526170610.png|Offset Inverting Bistable Circuit|300]]
Again, by superimposition, and by defining $V_R'=V_R\displaystyle\frac{R_2//R_3}{R_1+R_2//R_3}$ and $R'=\displaystyle\frac{R_1//R_2}{R_3+R_1//R_2}$we obtain:
$$\begin{align}
&v_+=V_R'+v_OR'\\
&V_{TH}=V_R'+L_+R'\\
&V_{TL}=V_R'+L_-R'
\end{align}$$
#### Better Accuracy
By adding a **limiter circuit** we can better approximate $L_+$ and $L_-$

>[!col]
>One approach is given by two back-to-back facing zener diodes and a resistance (that allows zener to work $I_z>I_{z,min}$). 
>In this configuration we have that$$\begin{align}
&L_+=V_{Z1}+V_D\\
&L_-=-(V_{Z2}+V_D)\end{align}$$
>
>![[Pasted image 20250526171834.png|Zener Back-to Back|300]]

>[!col]
>A better approach is the use of a **full-wave bridge rectifier** and a resistance (as before)
>In this case we have:$$\begin{align}
&L_+=V_{Z}+V_{D1}+V_{D2}\\
&L_-=-(V_{Z}+V_{D3}+V_{D4})\end{align}$$
>
>![[Pasted image 20250526172405.png|FW BR|300]]

#### Triangular Waveform Generator
By concatenating an integrator and a non inverting bistable circuit it is possible to generate a triangular waveform.
The bistable circuit generates square waves as an input to the integrator. By integrating we get a square wave.

![[Pasted image 20250526173230.png|Triangular Waveform Generator|350]]
Let's analyze this circuit
Start with $v_{O2}=L_+$, on $R$ we have constant $i=L_+/R$. This will cause the integrator to linearly decrease with slope $-L_+/RC$.
Proof: $$i=C\frac{dV_C}{dt}=\frac{L_+}{R}\rightarrow V_{O1}=V_{O1}(0)-\int\frac{L_+}{RC}dt=V_{O1}-\frac{L_+}{RC}t$$
This continues until $v_{O1}=V_{TL}\rightarrow v_{O2}=L_-$. Now the current on the capacitor will reverse and the output will start to linearly increase until $V_{TH}$.
Due to the symmetry we have that $L_+=-L_-$ and thus $$T=T_1+T_2=2RC\frac{V_{TH}-V_{TL}}{-L_-}$$
by analyzing the expression of the integrator the times are found by setting $\displaystyle\frac{V_{TH}-V_{TL}}{T_1}=\frac{L_+}{RC}$
>[!todo] numerical example

#### Sine Wave Generator
Here we use a square wave generator (bistable circuit) and a low-pass filter (op-amp)
![[Pasted image 20250526180342.png|Low Pass|300]]
>[!col]
>A simple low pass filter might not be enough since the third harmonic is only attenuated by $\approx$ 30% as seen in the image.
>
>![[Pasted image 20250526180538.png|Bode Plot|300]]

#### Astable Multivibrator

>[!todo] but it's optional tho
# 4) Voltage Converters
We will base this chapter on zener regulators:
>[!todo] recap zener regulator


First let's start with a bit of **terminology**
We define the **ability to maintain a constant voltage output in changes in the load as load regulation**. Commercially available PSU have $\approx 1\%$
$$ \% \text{Load regulation}=\frac{V_{\text{min load}}-V_{\text{max load}}}{V_{\text{non load}}}\cdot100$$
The **ability to maintain a constant output voltage with change sin the input as line regulation**$$\%\text{Line regulation}=\frac{\Delta V_O}{\Delta V_i}\cdot100$$
#### DC/DC Converter
A DC/DC Switching Mode Power Converter (SMPC) changes the output by opening and closing a switch. In this way we have a square wave with a duty cycle $\delta =t_{ON}/T$. By integrating we find the average output voltage . By changing duty cycle we can change the avg. output value. $$V_{O}=\frac1T\int_0^{t_{ON}}V_id\tau+\int_{t_{ON}}^T0\cdot d\tau=\frac{t_{ON}}{T}V_i=\delta V_i$$
By adding a LC low pass filter we can better aim for a **constant output value** as it limits the harmonic content of the output waveform![[Pasted image 20250527165819.png|Bode And Circuit|350]]
The diode solves the problem of the stored inductive energy. The **operating condition** of this circuit is that $I_L>0$ always. Let's analyze the circuit in the **steady state operation**:
- During $t_{ON}$ the diode is off and the inductor has constant voltage $v_L=V_i-V_O$ and thus the current in the switch is the same one of the inductor that is linearly increasing: $$v_L=L\frac{di_L}{dt}\rightarrow i_L(t)=i_L(0)+\frac1L\int v_L(\tau)d\tau=I_{L,min}+\frac{V_i-V_O}{L}t$$ and thus the variation of the current is $$\Delta I_{ON}=\frac{V_i-V_O}{L}\delta T=\frac{V_i-V_O}{Lf_S}\delta$$
- During $t_{OFF}$ the current continues flowing through the inductor but the diode turns on. and therefore $v_L=-V_O$. The current decreases as $$i_L(t)=i_L(0)+\frac1L\int_0^tv_L(\tau)d\tau=I_{L,max}-\frac{V_O}{L}t\rightarrow I_{L,off}=\frac{V_O}Lt_{off}$$
>[!col]
>It is clear how the current has always the same maximum/minimum $\Delta I_{L,on}=\Delta I_{L,off}$. And the max/min can be found$$\begin{align}
i_{L,max}=V_O\left(\frac1R+\frac{1-\delta}{2Lf}\right)\\
i_{L,min}=V_O\left(\frac1R+\frac{1+\delta}{2Lf}\right)
\end{align}$$
>
>![[Pasted image 20250527171109.png|Diagram|300]]

Based on this 


Now let's study the **voltage ripple:**
The avg current on the capacitor is 0: $I_C=\int_0^Ti(c)dt\rightarrow I_C=I_L-I_O=0\rightarrow I_L=I_O$
![[Pasted image 20250527172140.png|Graph|350]]
Consider the interval $t_i,t_2$. On the capacitor, the voltage ripple is$$\Delta V_C=\frac1C\int i_Cdt=\frac1C\int(i_L-I_O)dt=\frac1c\frac12\left(I_{C,max}\frac{t_{on}+t_{off}}2\right)=\frac1{2C}\frac{\Delta I_L}2\frac T2=\frac{\Delta I_L}{8fC}$$
Final notes:
- In continuous conduction mode (CCM) we always have $I_{L,min}>0$
- The conversion ratio $V_O=\delta V_i$ does not depend on load and current
- In steady state the avg voltage on the inductor is zero and so is the avg current on the capacitor
- The avg input power is the same as the avg output power (perfect theoretical efficiency)
- The output current is discontinuous and with high harmonic content

##### Properties of the Filter
We can evaluate the gain of the filter$$G_f=\frac{V_2}{V_1}=\frac{\frac R{1+sRC}}{\frac R{1+sRC}+sL}=\frac R{R+sL+s^2LRC}=\frac 1{s^2LC+s\displaystyle\frac LR+1}$$
The poles are $$s_{1,2}=-\frac{a_1}{2a_2}\left(1\mp\sqrt{1-\frac{4a_2}{a_1^2}}\right)$$ with $a_1=\frac LR$ and $a_2=LC$
These gives as a result two complex conjugate poles. That is a underdamped response with cutoff frequency $\omega_0=\frac 1{\sqrt{LC}}$
By putting some values we obtain
![[Pasted image 20250527182715.png|Bode Plots|350]]
#### Control of Output Voltage
We use a comparator to compare a triangular wave with a constant signal $w$. Then the output value is a square wave with the following duty cycle that depends on the mean of the tri wave: $$\delta=\frac{t_{on}}T=\frac{m}{W_{max}}$$![[Pasted image 20250527183235.png|Comparator|400]]
This will be used to control the switch of the converter. The working hypothesis is that **m varies at a lower frequency $f_m$ compared to the switching frequency $f$**

#### Feedback Loop
The image shows the full feedback loop that will be analyzed, the comparator and LC circuit are already known.
![[Pasted image 20250527183741.png|Feedback Loop|450]]
1) we analyze $v_O$ with a reference value and we obtain the error $\epsilon$
2) this error is fed to an amplifier $G_R$ whose properties are to assure the stability of the system
3) the output of the amp controls m and thus controls the switch

The transfer function between the duty cycle and $v_O$ is $$G_{vd}=\frac{V_O(s)}{D(s)}=\frac{V_iDG_f}{D}=V_iG_f(s)$$
where $G_f=\frac1{1+\frac s{Q\omega_0}+\frac{s^2}{\omega_0^2}}$ as discussed with the low pass filter.
And the comparator $$G_{PWM}=\frac{D(s)}{M(s)}=\frac1{W_\max}$$
**The full circuit can be modeled as:**
![[Pasted image 20250527184514.png|Full Circuit|400]]
We must be able to ensure that the system is stable and thus **$G_R$ needs to be able to compensate a second order system**. We use a PID controller.
![[Pasted image 20250527184825.png|PID|400]]
Where $Z_1=R_I/(1+sC_IR_I)$ and $Z_2=1+sR_FC_F/sC_F$. from here we have the classic PID expression$$G_R=-\frac{R_F}{R_I}\frac{(1+sR_FC_F)(1+sC_IR_I)}{sC_FR_F}=k\frac{(1+s\tau_1)(1+s\tau_2)}{s\tau_1}$$

The full loop is then:
$$T(s)=G_RG_{PWM}G_{vd}=k\frac{(1+s\tau_1)(1+s\tau_2)}{s\tau_1}\frac{V_i}{W_\max}\frac1{s^2LC+s\displaystyle\frac LR+1}$$
![[Pasted image 20250527190154.png|Final Bode Plots|450]]


# 5) Output Stages

BJT and MOSFET based amplifiers only work with small signals. Real world applications also need to be able to amplify bigger signals (audio amplifiers, RF transmitters). Output stages are large amplifiers. We divide them in 4 classes: A, B, AB, C. The classification is given according to the collector current waveform and the resulting signal
![[Pasted image 20250528153210.png|Classes Output|350]]
#### Class A
Class A amplifiers are characterized by their **low internal resistance**. 
![[Pasted image 20250528153346.png|Diode and Current Mirror based Class A Amplifier|350]]

We use the **emitter-follower** approach. The name comes from the fact that $v_{BE1}\approx0.7$ as long as it is in FAR and thus the variation in **input voltage is the same in the output.**
The transfer function is $$v_O=v_i-v_{BE1}$$
The maximum value is given by reaching the saturation region:
$$v_{O,\max}=V_{CC}-V_{CE1,sat}$$
And the minimum is reached by either the turn off of $Q_1$ or by the saturation of $Q_2$
$$v_{O,\min}=-I_{C2}R_L \ \text{ or } \ v_{O,\min}=-V_{CC}+V_{CE2,sat}$$
If we neglect the dependance of $v_{BE1}$ on $i_E$ we obtain the following transfer characteristic![[Pasted image 20250528155740.png|Transfer Characteristic|350]]
It is clear that the minimum is reached if $I_E=|-V_{CC}+V_{CE,sat}|/R_L<I$


The current of $Q_1$ is biased by the one generated by $Q_2$: $I_{E1}=I_{C2}+I_L$ where $|I_L|<I_{C2}$ to ensure that $Q_1$ doesn't turn off.

For the diode circuit we have $$I_{C2}=I_S(e^{V_{BE2}/V_T}-1)$$
The current mirror allows for a more granular choice in $I_{C2}$ by changing $R$. But with higher power dissipation. $P_{Q3}=V_{BE3}I$ and $P_{Q2}=(v_O+V_{CC})I$. Where $$I=\frac{V_{CC}-V_{BE3}}{R}$$

By choosing $I=V_{CC}/R_L$, $V_{CE,sat}$ can be neglected and the output varies between $\pm V_{CC}$![[Pasted image 20250528160329.png|Plots|350]]
- The max power is dissipated when $V_o=0$ since $P_{Q1}=V_{CC}I$
- If we have $R_L=\infty$ then $I_{C1}=I$ and we dissipate $P_{Q1}=2V_{CC}I$ when $v_O=-V_{CC}$
- Moreover if we have $R_L=0$ we have a short circuit and thus an infinite(very high) current on the load and thus we break $Q_1$

On $Q_2$ we have the maximum dissipation when $V_O=V_{CC}$, the the current is equal to I and the voltage is $2V_{CC}$ then we have $P_{Q2}=2V_{CC}I$ and it has a minimum at 0.

>[!def] Power Conversion Efficiency
>The **power conversion efficiency** is defined as:$$\eta=\frac{\text{load power}(P_L)}{\text{supply power}(P_S)}$$

In the diode representation $P_L=\displaystyle\frac{V_{OP}^2}{2R_L}$. Since $I_2$ is constant the power dissipated by $Q_2$ is $V_{CC}I$ and so is the one on $Q_1\implies P_S=2V_{CC}I$
Then the efficiency is $$\eta=\frac{V_{OP}^2}{2R_L\cdot 2V_{CC}I}=\frac14\frac{V_{OP}^2}{IR_LV_{CC}}$$
And is maximum at $0.25$ when $V_{Op}=V_{CC}=IR_L$

| Pros           | Cons                                      |
| -------------- | ----------------------------------------- |
| Simple         | Requires much power (max utilized is 25%) |
| Low distortion | limited voltage swing                     |
>[!def] Total Harmonic Distortion (THD)
>THD is the measure of quality of an amp by describing the purity of the output sine wave. $$THD=\frac{\sqrt{\sum_{i\geq2} V_i}}{V_1}$$

#### Class B

A class B amplifier is biased so that it is in linear for $180^\circ$ of the input cycle, and in cut-off for the remaining 180. We will see that it has **better efficency** than class A but has more distortion.

>[!def] Push-Pull
>We use push-pull as a term to indicate two resistors that are used on alternating half-cycles

![[Pasted image 20250528172721.png|Psuh Pull|350]]
>[!col]
>With $v_i=0$ both transistors are off, otherwise $v_i>0.5$ $Q_N$ behaves as emitter follower ($v_o=v_i-v_{BE,N}$) and at $v_i<0.5$ the other transistor is the emitter-follower ($v_o=v_i+v_{EB,P}$). The distortion appears at signals $\in[-0.5,0.5]V$ since the output is null, as also seen by the transfer characteristic
>
>![[Pasted image 20250528173114.png|transfer Characteristic|350]]

**It can be demonstrated that the maximum efficiency is** $$\eta=\frac{\pi V_{CC}}{4 V_{CC}}\approx 78.5\%$$

How can we reduce crossover distortion?
![[Pasted image 20250528173248.png|Distortion of Pure Sine Wave|350]]

>[!col]
>With a high gain opamp and negative feedback we can reduce the bounds to $\pm0.5/A_0$ but this introduces slew rate limitations and then the alternation is noticeable at high frequencies.
>
>![[Pasted image 20250528173550.png|Circuit|300]]

#### Class AB
The distortion can be eliminated by biasing the output transistors at a small non zero current.
![[Pasted image 20250528173804.png|Circuit|300]]
For $v_o=0$ we have that $v_{BE}=V_{BB}/2$ and thus (matched devices) $i_N=i_P=I_Q=I_Se^{V_{BB}/2V_T}$
When $v_i$ increases we have that the output becomes positive $v_o=v_i+\frac{V_{BB}}2-v_{BE,N}$. Therefore $i_N=i_P+i_L$. since $i_L$ increases **The product $I_Q^2=I_NI_P$ remains constant**. Bo solving the system of the current equations we obtain:$i_N^2-i_Li_N-I_Q^2=0$. this means that:
- Positive output voltages: $Q_N$ supplies the load current and $Q_P$ will decrease in current
- Negative output voltages: the opposite

We will have a small quiescent value


# 6) Arduino
Let's first analyze the ports:
#### Ports
##### Power and Auxiliary I/O
- 5V: This port is the Arduino power and can be used to supply other external devices
- 3.3V: This is also for power and draws a max of 50 mA
- $V_{in}$: This supplies the same voltage that the arduino is supplied at
##### Analog Pins
These pins have 10bits of precision from ground to 5 V in steps of 4.9 mV. To have a better accuracy in the arduino due we can go up to 12 bits or use an external ADC with higher resolution
##### Digital Pins
- Serial: these pins (0 RX, 1 TX) are used for comunication with TTL devices
- PWM: These pins can provide Pulse Width Modulated signals with 8 bit precision
- SPI: These pins (10 SS, 11 MOSI, 13 SCK) are used to provide Serial Peripheral Interface (SPI) communications
- External Interrupts: These pins can trigger interrupts based on the signal they receive
- LED: This pin turns on the on-board led when it is turned on

Since the board is at 500Hz (Uno) the 0% duty cycle is with peaks at 2ms apart
##### Other
These ports are the RESET, AREF (external reference), TWI (SDA and SCL pin for TWI communication)

On the DUE we can deliver $3\div15$ mA and accept $6\div9$ mA
##### Programming vs Native USB Port
- The programming port is reccomended for programming the arduino. It sends a 1200bps hard reset signal 
- The native usb port sends a soft erease that can sometimes fail
They use a bootloader that is a piece of firmware that allows to program over usb directly
#### Data Types
We program in C++ and since we are on a relatively low performant chip we must ensure to use the right data types to optimize memory usage and performance in calculations.
![[Schermata 2025-05-28 alle 20.24.04.png|Data Types Table|400]]

#### Asynchronous Serial Protocol
We can send data with different timing with respect to the main clock. To do so both devices must know the target (baud) rate
#### Interrupts
Some ports allow to cause a sudden break in the main code and to execute a specific Interrput Service Routine (ISR). This function has some limits as it must return void and can't run for too long, therefore millis() and delay() are disabled. Only delayMicroseconds() can be called but should be avoided. A ISR must be as quick as possible and global variables can be updated to then execute a more complex function during the loop(). It is also useful to classify these variables as **volatile**.

#### Port Registers

>[!todo]

#### Serial Peripheral Interface (SPI)
This is a synchronous data protocol used to communicate with one or more peripheral devices. This uses 3 (+1 chip select) lines called
- SDI/MISO: Master In Slave Out, this sends data to the master
- SDO/MOSI: Master Out Slave In, this sends data to the slave
- SCK: Serial ClocK, clock pulse that synchronizes data
- SS: Slave Select, when this goes low the slave will listen for SPI clock and data

This is a single master communication protocol, that is that one device controls multiple other that can communicate only with the master. It selects the slave with the SS, activates the CLK and generates information on MOSi while sampling on MISO. We must then code the arduino with the correct ports for Chip Select (CS), Data Command (DC) and ReSeT (RST)

The bits for the RGB display are 16 bits ordered as 5R6G5B

#### $I^2C$ Protocol
This is again a synchronous protocol. The data is clocked with a clock signal (SCL) that controls when data is changed and when it is read. The clock can vary. It sends two signals:
- SDA: Serial DAta, the data goes here
- SCL: Serial CLock, it is generated by the master and controls when data is sent/read. It can be forced low to block data when a device is oversaturated
# 7) Microcontrollers

# 8) Q&A
- **What is the bias current of an operational amplifier? Discuss the impact of bias current on the output voltage of an inverting amplifier. How can the effect be compensated?**
Real amplifiers have a non zero current flowing through the inputs, these currents are called bias currents and their difference is called offset current. To see how this currents impact the output we can study an inverting configuration with only the bias current as inputs. We will see that with no input voltage, the output will be non zero.

![[Pasted image 20250603104256.png|Disegno|300]]
$v_+$ and $R_1$ are short circuited, and thus we have that $v_O=I_{B1}R_2\not = 0$.
To reduce this error we can add a resistor in series to change the VSC voltage. ![[Pasted image 20250603104917.png|Disegno|250]]Now by superimposition we have:
$$\begin{align}
&v_{O}|_{I_{B2=0}}=I_{B1}R_2\\
&v_{O}|_{I_{B1=0}}=-I_{B2}R_B(1+\frac{R_2}{R_1})\\
\end{align}$$
with $R_B=R_1//R_2$ we can find that $$v_O=(I_{B1}-I_{B2})R_2=I_{OS}R_2$$
which is typically 5 to 10 times smaller than the single bias current.

- **Describe the operation of a class A amplifier, by showing one or more schematic circuits and the transfer characteristic. What is the maximum theoretical efficiency? Discuss with the help of formulas.**
A class A amplifier operates using the emitter-follower configuration where the output voltage directly follows the input voltage with a slight difference given by the BJT's $V_{BE}\approx 0.7 \ [V]\implies v_O=v_i-0.7$. They are characterized by a low internal resistance and low amplification noise but require a lot of power.
![[Pasted image 20250603111243.png|Circuit|350]]
The circuit works until $Q1$ is in FAR and thus we have the following bounds (sat, turn off):
$$v_{o,\max}=V_{CC}-V_{CE,sat} \ \space \ v_{O,\min}=-IR_L$$
another minimum is obtained by saturating $Q_2$. $v_{O,\min}=-V_{CC}+V_{CE2,sat}$

Now we can draw the transfer characteristic:![[Pasted image 20250603111938.png|TC|300]]

- **Draw the type of amplifier where crossover distortion happens, explain what crossover distortion is, and describe one way to reduce it, by showing the related schematics.**
This is a type B amplifier:
![[Pasted image 20250603112704.png|Disegno|300]]
This uses the push-pull principle where only one of the two transistors is always on. The crossover distortion happens in the region hwere both are off, that is $\approx v_i\in[-0.5,0.5]$.  And the upper/lower bounds are given by the saturations of the two transistors $v_{O,\max}=V_{CC}-V_{CEN,sat} \ \space \ v_{O,\min}=-V_{CC}+V_{CEP,sat}$. The transfer characteristic is:
![[Pasted image 20250603113240.png|TC|300]]
The theoretical maximum is of $\eta=\pi/4$.
We can reduce distortion with
- a high gain negative feedback opamp (bad slew rate) 
- a class AB amplifier, that is:
Adding a $\pm V_{DD}/2$ generator at the transistor base. This completely solves the problem:

- **What is the purpose of the current mirror circuit, when it is used and what is its working principle? explain with the help of schematic.**

Risposta amp di tipo A. Moreover the current mirror acts as a current source. It is possible to better decide the value of the generated current by changing the resistance. The drawback is that it uses mire power since we must drive not only Q2 but also Q3 which fortunately has a constant disspated power of $P_{Q3}=V_{BE3}I$

- **Describe how the communication between two I2C devices works, by summarizing the related signals**
The Inter-Integrated Circuits protocol is a serial synchronous protocol. It is a 2 BUS protocol since it sends 2 signals: SDA, Serial DAta and SCL, Serial CLock.

SDA carries the information bits and is able to do so bidirectionally. The SCL is the clock signal generated by the master.

SDA and SCL are both open-drain lines, meaning that they can be pulled low by the devices and are pulled up by the resistors. There are 2 particular conditions

Start condition: SCL is high and SDA is pulled from high to low
End condition: SCL is high and SDA is pulled low to high

The first communication contains the 7-bit address of the slave to talk to followed by a W/R bit. At the ninth bit we have an ACK that is generated by the slave by pulling SDA low. The other Data is senti in 8 bits with no R/W condition.

The data is sampled when SCL is high and the value is changed when SCL is low, otherwise, if when SCL is high SDA changes we can have the start/stop condition.

![[Pasted image 20250603160531.png|Diagram|450]]
- **Explain how we can make a sine wave generator by using a non-linear oscillator that we have studied. Show the related schematics and discuss the operation of the circuit**
It is easy to see that, by applying a square or sine wave to the input of a Schmitt trigger gives a square wave as an output. By exploiting this we can build a triangular wave generator: we just need to give the output square wave to a integrator that will integrate it into a triangular wave with slope $\pm L_\pm/RC$ depending on if it is rising or decreasing. If we have symmetric output values and input thresholds the duty cycle is of $50\%$.
This wave is then used as input for the Schmitt trigger and is also the desired output. 
![[Pasted image 20250603163329.png|Circuit|350]]
Finally, by recalling the Fourier Series of a triangular wave it is possible to obtain a sine wave by passing the triangular wave through a low pass filter. Unfortunately this approach might need more than one filters since a simple low pass doesn't perfectly attenuate the higher order harmonics. As seen in this example:
![[Pasted image 20250603164017.png|Low Pass Circuit|300]]
![[Pasted image 20250603163754.png|Low Pass Transfer Function|300]]
Here we get an attenuation of the third harmonic of only around 30%.

- **What are the differences between the delay and millis functions and why should we use one instead of the other?**

- **Explain the SPI communication protocol, by showing the related signals. What happens to the wiring when multiple peripherals are present?**
The Serial Peripheral Interface is a synchronous data protocol to communicate with one or more peripherals. there are 3 lines common to all device. Each slave has also a chip select while the master can have one or more chip select lines. The lines/signals are:
- SCK: clock
- MISO/SDI: incoming data
- MOSI/SDO: outgoing data
- CS/SS: chip select

The master selects a slave by pulling down the CS line and sends and receives data simultaneously.

- **Explain what a bistable circuit is. Draw the transfer characteristic and describe the operation.**
At the heart of the non-linear oscillator is a op-amp that with a positive feedback works as a Schmitt trigger. ![[Pasted image 20250603161500.png|Circuit|300]]
Here the two resistor act as a voltage divider with $\beta=R_1/R_1+R_2$. Moreover we have an inverting configuration if the input is applied at the node $v-$, otherwise if it is applied at the node $v$ we have a non inverting configuration useful for building a  comparator.
The name bi-stable comes from the fact that we have 2 stable states. The circuit has memory, this means that once a stable output value is obtained it remains constant at the output and changes only once a threshold value is crossed. 
The working principle is based on positive feedback, this means that the output of the amplifier is again re-amplified until a threshold output value $v_O=L_+\text{ or } L_-$.
![[Pasted image 20250603162157.png|Inverting Transfer function|300]]
To have a better precision of $L_\pm$ it is possible to put a two zener diodes back to back or a diode full bridge rectifier. 

![[Pasted image 20250603164333.png|Back To Back Zener Diodes|300]]
Here it is clear to see that with symmetric zener diodes $v_O=\pm(V_Z+V_D)$. This works with a resistance that allows $I_O>I_{Z,\min}$.

- **Explain the voltage offset, how to measure it and how to compensate for it.**
In an ideal opamp when there is no input signal the output is also 0. With real operational amplifiers this isn't true as it is possible to measure a small non zero voltage even with zero input. This is given by $V_{OS}=V_0/A$. Once an input is applied this voltage still influences the output: $v_O=A(v_{id}+V_{OS})$.

To measure this voltage it is possible to use a voltage buffer configuration but with zero input.![[Pasted image 20250603171353.png|Voltage Buffer|350]]
To reduce this offset it is possible to use an external potentiometer that has to be adjusted based on the specific parameters of the used op-amp.

- **How does a voltage regulator based on a zener diode work?** 


- **What is an Asynchronous Serial protocol?**
This protocol comes from the words: "Serial", that is sending information in series and "Asynchronous", that is the devices have their own clock but must decide on a bad rate to use before sending data. The Serial() on arduino is the implementation of the serial async protocol UART. During the course this protocol was used with the USB-to-Serial chip to display a log from the arduino on the computer via Arduino IDE, it could also be used to send data from the computer to an arduino.

- **for Amplifier type A, when do we need to use short circuit protection? why?**


- **What is the purpose of the inductor in a dc-dc buck converter?** 
