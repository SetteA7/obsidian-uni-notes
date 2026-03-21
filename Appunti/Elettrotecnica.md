# 1) Electric Poles
In electrotechnic we are studying networks in _quasi stationary regimes_, this means that electric radiation is neglected and the parameters propagate instantaneously. The poles are connected via **ideal conductors**, in an **insulated space** with a **conservative electric field**. The main focus of the course will be with bipoles, but generally n-poles can be defined. These are the main components of an electric circuit. Let's see the 2 main properties for a bipole:
1) The current entering is the same as the one exiting, i.e. $\sum i_n = 0$ ^3b9319
2) The voltage between the terminals is a difference of potential, i.e. the electric field outside is conservative
> [!col]
>A pole is defined via it's characteristic equation of form:
>
>> [!col-md]
>>$$\begin{align*} 
v_{AB}(t)&=f(i(t)) \\ i(t)&=g(v_{AB}(t))
\end{align*}$$
## 1.1) Double bipoles
>[!todo]
## 1.2) Bipoles
As explained below bipoles are the main type of poles we are going to study, the specific ones are voltage and current sources, resistors, capacitors and inductances. For now let's just define the main properties of bipoles:
- Active bipole: $I = 0, \ V_{AB}\not= 0$
- Passive bipole: $I$ and V$_{AB}$ have the same sign
	-  it is always an inert bipole: I=0, V=0
- Linear/Non-linear: self explanatory

Various bipoles can be connected in a network in the following ways:
- Series: $V=\sum V_i$, the same current flows in every bipole
- Parallel: $I = \sum I_i$, they all have the same difference of potential
### 1.2.1) Ideal Voltage and Current sources
**DC Regime**
>[!todo] DC Regime

**AC Regime**
In **AC Regime** we can define these sources using a simple sinusoidal: $e(t) = E_Msin(\omega t + \alpha)$, $j(t) = J_Msin(\omega t + \alpha)$.
![[Pasted image 20240628115035.png|Graphical representation of the bipoles|450]]
^2aae3b
### 1.2.2) Linear Resistor
**Dc Regime**
^d6cbaa
> [!col]
>![[Pasted image 20240628120827.png|Resistor bipole|150]]
>
>> [!col-md]
>>For a linear resistor we use the **Load Convention**. The characteristic equation becomes: $v_{AB}(t)=R\ i(t)$.
The inverse of a resistance is the **Conductance** $G=1/R$ and then: $i(t) = G\ v_{AB}(t)$
For a resistor the power corresponds to Joule's law: $P = V_{AB}I = RI^2$

These are some useful theorems regarding resistors ^702ca8
>[!theorem] Voltage Divider
>In a series of n resistors, the difference in potential of the k-th resistor is:
>$$
>V_K= R_kI=R_k\frac{V_{AB}}{R_{eq}}=V_{AB}\frac{R_k}{\sum R_i}
>$$

>[!theorem] Current Divider
>In a parallel of n resistors, the difference current of the k-th resistor is:
>$$
>I_k=G_kV=G_k\frac{I}{G}
>$$

>[!corollary] Current Divider with n = 2
>In the case of n = 2 the current divider can be easily written with R instead of G:
>$$
>I_i = I\frac{R_j}{R_i+R_j}
>$$

>[!theorem] Star/Triangle transformation
>It is possible to transform the following shapes using these relations
![[Pasted image 20240623190232.png|Triangle and Star|350]]
>$$
>R_{ab} = R_a+R_b + \frac{R_aR_b}{R_c} \iff R_a=\frac{R_{ab}R_{ac}}{\sum R_{ij}}
>$$

**Ac Regime**
In **AC regime** a resistor keeps it's characteristic function.
Being subject to alternating current it is subject to $v(t)=V_Msin(\omega t + \alpha)$, and thus it imposes $i(t)=I_Msin(\omega t + \alpha)$. From here we can define $R=\frac{v(t)}{i(t)}=\frac{V_M}{I_M}=\frac{V}{I}=Z$

### 1.2.3) Capacitor
**DC Regime**
> [!col]
>![[Pasted image 20240628122424.png|Capacitor bipole|200]]
>
>> [!col-md]
>>A capacitor is made of two plates made of conducting material put near each other. The current entering the + side is different from the exiting one, since it **depends on the charges on each plate**. The capacitance $C=Q/V$ is a constant term since it is dependent on the geometric factor.
>>
>>In order for a capacitor to be a bipole it must be imposed that the enetering current is the same as the exiting one: $i_a(t)=i_b(t) \implies q_a(t)+q_b(t)=0$. The bipole uses the **load convention** and has characteristic function $i(t) = dq(t)/dt=C\frac{dv(t)}{dt}$. From here $v(t)=v(0)+\frac{1}{C}\int_0^ti(\tau)d\tau$.

To find the characteristic function these steps were taken: $i(t)=d(CV)/dt=Cd(V)/dt+Vd(C)/dt=i(t)Cd(v(t))/dt$
In a DC circuit it behaves like an open circuit.

In terms of power we have: $p=vi=vCv'$. form here we can define 2 works: ^c83ef3
$$\begin{align}
&\text{Charge: }&W_C &=\displaystyle \int_0^{V_M}pdt=\int Cvdv=\frac{1}{2}CV_M^2=\frac{1}{2}QV_M=\frac{1}{2} \frac{Q^2}{C}\\
&\text{Discharge: }&W_D &=\int_{V_M}^{0}pdt=\int Cvdv= -\frac{1}{2}CV_M^2
\end{align}$$
>[!thm] Series and Parallel connection of Capacitors
>The equivalent capacity is described as: 
>$$\begin{align}
>C_{eq}&=\displaystyle(\sum \frac{1}{C_i})^{-1}, &\text{ in series} \\
>C_{eq}&=\sum C_i, &\text{ in parallel}
>\end{align}$$
>`\begin{proof}`
>Proof for series connection:
>Since: $i = i_i = i_j$ and $v=\sum v_i$ it clearly becomes $v=q\sum \frac{1}{C_i} \implies  C_{eq}= \frac{v}{q}^{-1}=\displaystyle(\sum \frac{1}{C_i})^{-1}$
>Proof for parallel connection:
>Since: $i = \sum i_i$ and $v=v_i = v_j$ it clearly becomes $q= \sum q_i = \sum C_iv_i= v\sum C_i \implies C_{eq}=q/v=\sum {C_i}$
>`\end{proof}`

>[!todo] todo: Charge and Discharge of capacitor

**AC Regime**
In **AC regime** a capacitor keeps it's characteristic function.
Being subject to alternating current it has a voltage $v(t)=V_Msin(\omega t + \alpha)$ applied. This imposes that the current has the following amplitude: $I_M=\omega CV_M$ and is in anticipate quadrature with the voltage:   $i(t)=C \omega V_Mcos(\omega t + \alpha)= \omega CV_Msin(\omega t + \alpha + \pi/2)$. The symbolic representation is: $\overline I =\omega C\overline V e^{j\pi/2}=j\omega C\overline V$. From here the impedance is: $\overline Z = 1/j\omega C = -j/\omega C =jX_C$ with $X_C=-1/\omega C$.
### 1.2.4) Inductor Bipole
**DC Regime**
>[!col]
>![[Pasted image 20240628124104.png|Inductor bipole|200]]
>
>> [!col-md]
>>An inductor works in such a way that it inhibits current changes in a circuit due to magnetic induction.
>>
>>The bipole uses the **load convention** and in order for it to be a bipole it must hold the existence conditions: the current passing is constant and since _externally of $L$ the induction is null_ the bipole has a difference of potential on it's terminals. Here are the characteristic equations:

$$\begin{align}
v&=L\frac{di}{dt}\\
i(t) &= i(t_0)+\frac{1}{L}\int_{t_0}^tvdt
\end{align}$$
By recalling Lorentz law: $Li=\Phi_B$, by derivating $d\Phi_B/dt=Ldi/dt$ and by Faradays law: $d\Phi_B/dt=v$

A **real inductor bipole** is essentially a series of L and R: $v=v_L+v_R=Li'+Ri$

In power terms we define: $p=vi=Li'i$, then the infinitesimal work becomes: $dW=pdt=Lidi$ and the work done to charge is $$W_C=\int_0^{I}Lidi=\frac{1}{2}LI^2$$In **DC regime** they are a short circuit
>[!thm] Series and Parallel connection of inductors
>The equivalent inductance is:
>$$\begin{align}
>L_{eq}&=\displaystyle(\sum \frac{1}{L_i})^{-1}, &\text{ in parallel} \\
>L_{eq}&=\sum L_i, &\text{ in series}
>\end{align}$$
>`\begin{proof}`
>For series connection:
>All currents are the same, moreover $v=\sum v_i \rightarrow \sum L_ii' = i'\sum L_i$ then $v/i'=\sum L_i$
>For parallel connection:
>All voltages are the same, moreover $i = \sum i_i \rightarrow \sum i_i(0) + (\sum 1/L_i) \int_0^tvdt$, then $L_{eq}=(i'/v)^{-1}=(\sum 1/L_i)^{-1}$ where the last step was made by deriving i
>`\end{proof}`

>[!todo] Charge and discharge of Inductor

**AC Regime**
In **AC regime** the inductor keeps it's characteristic function.
By applying a voltage $v=V_Msin(\omega t + \alpha)$ we can find first $di/dt$, then by integration $i$.
$di/dt=\frac{V_M}{L}sin(\omega t + \alpha)$
$i = \frac{V_M}{L}\int sin(\omega t + \alpha)dt=-\frac{V_M}{\omega L}cos(\omega t + \alpha)=\frac{V_M}{\omega L}sin(\omega t + \alpha-\pi/2)$
Then in symbolic representation: $\overline I = \overline V e^{-j\pi/2}=-j\frac{1}{\omega L}\overline V$. This is clearly in delay quadrature with $\overline V$
From here $\overline Z=\frac{\overline V}{\overline I} = j\omega L = jX_L$ with $X_L = \omega L$
# 2) DC Regime 

## 2.1) Power and Conventions
An important parameter to define is power $p(t) = v_{AB}(t)i(t) = \lim_{\Delta t \to 0}\frac{\Delta Q}{\Delta T}$. It's sign is an important metric but in order to understand it's meaning we must first define 2 main conventions of bipoles:

> [!col]
>![[Pasted image 20240624151439.png|Load convention in a generic bipole|250]]
>
>> [!col-md]
>>1) Load convention: I is positive if it enters on + side
>>2) Source convention: I is negative if it enters on + side

Now we can better understand the meaning of the power. A _source convention(generator)_ will have a positive power if it is delivering power, while a _load convention(resistor)_ will have a positive power when it is absorbing power. This will come useful when talking about: [[#^76d3e8]] Tellegen Theorem

The work done do move an electron from point A to B is defined as:
$$
\Delta\cal{L}_{AB} = \int_{\Delta t} p(t)dt
$$
## 2.2) Measuring Devices
> [!col]
>![[Pasted image 20240626141132.png|Wattmeter Example|350]]
>
>> [!col-md]
>>In order to measure the power a wattmeter is used. This device is essentially a voltmeter and an ammeter combined.
>>
>>In this example the current enters the $A^+$ side and thus it is positive. On the other hand the $V^-$ side of the wattmeter faces the $V^+$ side of the bipole and thus the power measured will be: $P=-VI$.

# 3) AC Regime
In a periodic regime the time dependent quantities follow the following law: $a(t)=a(t+nT)$. We can then define the following values:
- Max value: $A_M = max\{a(t)\}$
- Mean over one period: $\displaystyle A_m = \frac{1}{T}\int_0^Ta(t)dt$
- Root Mean Square (RMS) : $\displaystyle A = \sqrt{\frac{1}{T}\int_0^Ta^2(t)dt}$ 

In order to be AC the mean $A_m=0$, and the period can be identified by two symmetric halves.

A sinusoidal function is the main function we study in this regime: $a(t)=A_Msin(\omega t+\alpha)$, where the parameters have the following relation: $\omega = 2\pi f$. Now we can calculate the values:
- Max value: $A_M$
- Mean over one period: $\displaystyle A_m = 0$
- Mean over a half period: $A'_m = \frac{1}{T/2}\int_0^{T/2}A_Msin(\omega t)dt = \frac{2A_M}{T}[-\frac{1}{\omega}cos(\omega t)\mid_0^{T/2}]=\frac{2}{\pi}A_M$
- Root Mean Square (RMS) : $\displaystyle A = \sqrt{\frac{1}{T}\int_0^Ta^2(t)dt}=\frac{A_M}{\sqrt2}$
- Form factor: $K_f=\frac{A}{A'_M}=\frac{\pi}{2\sqrt2}=1,11$

In the case of **2 isofrequency functions**, i.e. $a(t), b(t)$ with same frequency but different amplitude and phase the following relations might happen:
> [!col]
> ![[Pasted image 20240628102418.png|Two isofrequency functions|350]]
>
>> [!col-md]
>> - In phase: $\alpha = \beta$
>> - Phase Opposition: $\alpha - \beta = \pi$
>> - Phase Anticipation: $\alpha > \beta$, in quadrature if $\alpha - \beta = \pi/2$
>> - Phase Delay: $\beta > \alpha$, in quadrature if $\beta - \alpha = -\pi/2$

>[!rmk] Arctangent angle error
>When calculating the phase of the sinusoidal representation starting from the complex representation it is important to check the sign of the real part. **If the real part is smaller than 0 it is necessary to add $\pi$ to the resulting phase**
### 3.1.1) Phasor Representation
> [!col]
![[Pasted image 20240628111726.png|Graphical representation of a phasor]]
>
>> [!col-md]
>>The phasorial representation shows $a(t)$ as a vector of modulus $A_M$ rotating counterclockwise with angular velocity $\omega$ and starting angle $\alpha$. The projection of the phasor on the x and y axis show respectively the cosine and sine function.

### 3.1.2) Symbolic representation
More useful is the symbolic representation. Usually a sinusoidal is expressed in the form:
$$
\overline A = \sqrt2A_{\text{eff}}e^{j\alpha}e^{j\omega t}=A_Me^{j\alpha}e^{j\omega t}=A_Me^{j(\omega t + \alpha)}
$$
A simple proof consists of taking the phasorial representation in complex terms: $\overline A = A_Mcos(\omega t + \alpha)+jA_Msin(\omega t + \alpha)$. By using $cos(a+b)=cos(a)cos(b)-sin(a)sin(b)$ and $sin(a+b)=sin(a)cos(b)+sin(b)cos(a)$ we get:
$$\begin{align}
&A_M(cos(\omega t)cos(\alpha)-sin(\omega t)sin(\alpha)+jsin(\omega t)cos(\alpha)+jcos(\omega t)sin(\alpha))= \\
&A_M(cos(\alpha)(cos(\omega t)+jsin(\omega t))+jsin(\alpha)(cos(\omega t)+jsin(\omega t))= \\
&A_M(cos(\alpha)+jsin(\alpha))(cos(\omega t)+jsin(\omega t)
\end{align}$$
with the term $A_M(cos(\alpha)+jsin(\alpha))$ being $\overline A$ at $t=0$.

### 3.1.3) Impedance and admittance
Define a passive bipole using load convention(resistor, capacitor, inductance) in a AC circuit, we define the impedance as : $\overline Z = \frac{\overline V}{\overline I}= Ze^{j(\alpha-\beta)}=Ze^{j\phi}$. This complex operator shows the tendency of the bipole to resiste the change of current passing through it

The admittance is the reciprocal of the inductance

It is possible to define a parallel and series connection of all passive bipoles and find their equivalent impedance:
$$\begin {align}
&\overline{Z_{\text{series}}} = R_{\text{series}} + jX_{\text{series}} = \sum \overline{Z_i}\\
&\overline{Z_{\text{parallel}}} = (R_{\text{parallel}} +jX_{\text{parallel}})^{-1}=(\sum 1/\overline{Z_i})^{-1}
\end{align}$$
Here is a quick recap of impedance for the passive bipoles we are studying:

|     | $Z$    | $X$           | phase with $\overline V$ |
| --- | ------ | ------------- | ------------------------ |
| $R$ | $R$    |               | in phase                 |
| $C$ | $jX_C$ | $-1/\omega C$ | anticipation quadrature  |
| $L$ | $jX_L$ | $\omega L$    | delay quadrature         |

### 3.1.4) Power
By the standard definition of power, in AC regime it is going to be an oscillating value.
$$\begin{align}
p(t)=&v(t)i(t)=V_Msin(\omega t)I_Msin(\omega t - \phi)=\frac{V_MI_M}{2}(cos(\phi)-cos(2\omega t - \phi))=\\
&VIcos(\phi)-VIcos(2\omega t -\phi)
\end{align}$$
Where the first term, called **active/real power**  is constant, and the second, called **fluctuating power** has pulsation $2\omega$.

The active power mean is the mean value of the instantaneous power over the period. A quick proof of this fact is: $P=1/T\int_{[T]} p(t)dt$ and since the active power is constant and the fluctuating power is sinusoidal P=active power.
The cosine factor is called **power factor** an thus the sign of the active power is positive if $\phi \in [-\pi/2,\pi/2]$. 

We can also define the following two measures:
- The **Reactive power $Q=VIsin(\phi)$**
- The **Apparent power $S=VI$**
Active, reactive, and apparent power have the following relation: $S=\sqrt{P^2+Q^2}$ and thus $P = Scos(\phi), \ Q=Ssin(\phi) \implies cos(\phi)=P/S$

Finally we can also determine the complex power $\overline S = VIe^{j\phi} = P + jQ$

From the definition of Q it it easy to determine the reactive power of the bipole we studied:

|     | R    | C         | L         |
| --- | ---- | --------- | --------- |
| Q   | $0$  | $V^2/X_C$ | $V^2/X_L$ |
| P   | $VI$ | $0$       | $0$       |
### 3.1.5) Resonance
>[!todo]
# 4) Circuits
## 4.1) Theorems
>[!theorem] Tellegen Theorem
>In a circuit in DC regime, the total absorbed power is the same as the total supplied power
>$$
>\sum_{k = 1}^{R_n}p_{abs_k}(t)=\sum_{k = 1}^{E_n}p_{sup_k}(t)
>$$
>It also holds in a circuit in AC Regime 
>$$
>\sum_{k = 1}^{R_n}p_{abs_k}(t)=\sum_{k = 1}^{E_n}p_{sup_k}(t)
>$$
>

>[!theorem] Non Amplification Theorems
>In a circuit made only of bipoles with one single source bipole, at any time t, the following theorems are valid:
>
>Voltage non amplification:
>The module of the supplied power is greater or equal to the voltage on any other bipole.
>
>Current non amplification:
>The module of the current supplied by the source is always greater or equal to the current on any other bipole
>`\begin{proof}`
>>[!todo]
>`\end{proof}`

The following theorems hold in DC Regime:
>[!thm] Thevenin theorem: Equivalent Voltage Generator
>The behaviour of any bipole network, in terms of voltage at the terminals $A, \ B$ is equivalent to a series constituting of $E_{eq}, \ R_{eq}$
>![[Pasted image 20240624183358.png|Thevenin theorem representation|350]]
>
>with $E_{eq} = V_0$ the tension between the terminals $A, \ B$ and $R_{eq}$ the equivalent resistance with all generators turned off. Keep in mind $R_{eq} = \frac{V_0}{I_{cc}}$

>[!theorem] Norton Theorem: Equivalent Current Source
>The behaviour of any bipole network, in terms of voltage at the terminals $A, \ B$ is equivalent to a parallel constituting of $J_{eq}, \ G_{eq}$
>![[Pasted image 20240624184201.png|Norton theorem representation|350]]
>With $J_{eq} = I_{cc}$ and $G_{eq} = \frac{I_{cc}}{V_0} = \frac{1}{R_{eq}}$

The equivalent version of these theorems that holds in AC regime is:
>[!thm] Equivalent Symboli cCurrent / Voltage Source
>The behaviour of any bipole network in AC regime can be written as either an equivalent voltage source and impedance, or an equivalent current source and an admittance.
>![[Pasted image 20240628190159.png|Representation of the theorem|350]]

## 4.2) Resolution methods
### 4.2.1) Kirchhoff laws
**DC Regime**
In a circuit identify a graph
When using Kirchhoff laws in a circuit you have to grate 2 graphs:
- The main graph is connected to all nodes only once
- The second graph is made of all missing branches

then by defining $l$ as the number of branches, and $n$ the number of nodes a number of $n-1$ branches equations and $l-(n-1)$ loop equations are needed. Recall the 2 seconds law that state: In a closed and subset of branches cut by a surface (or a node) the sum of all currents is null, and for each mesh/loop the sum of all voltages is null. It is clear that the $n-1$ nodes equation will be of the form $\sum i_{in} = \sum i_{out}$ while the loop equations will have the following form:

|     | V +                                                      | V -                                                      |
| --- | -------------------------------------------------------- | -------------------------------------------------------- |
| R   | I same as loop                                           | I opposite as loop                                       |
| E   | If I in generator is $-\rightarrow+$: Loop enters + side | If I in generator is $-\rightarrow+$: Loop enters - side |
| J   | J opposite as loop                                       | J same as loop                                           |
**AC Regime**
Kirchhoff also holds in AC Regime:
- $\sum \overline I_h = 0$ on an insieme di taglio (node)
- $\sum \overline V_h = 0$ on a branch

>[!rmk] 
>Never use the abs. value of a phasor!

### 4.2.2) Superimposition
Works for both DC and AC regimes.

Given a **linear circuit** define the current direction for every branch. Now consider the circuit one generator at a time to find R, V while still keeping in mind the originally defined currents to keep the signs correct. After having found I, V for every source sum them to find I, V of the circuit in every branch. Unused sources become short circuit if they were generators, current generators become open circuits. Clearly I is positive if the current of the generator matches the one defined at the start. V is positive if the current touches first the "high" potential side
### 4.2.3) Loop current analysis

^04bfce

It is a way to solve a circuit using loop currents that implicitly satisfy the $n-1$ LKC equatons. Given a circuit it is necessary to define a loop direction for every loop (possibly all same orientation) $I_{A_n}$ that may or may not coincide with the current direction defined for that branch. Every branch can be expressed as a sum of the adjacent loop currents. This is possible for all branches except the one with a current generator.
The expression for the n-th loop is made of many terms:
- Sum of all resistances times $I_{A_n}$
- Subtraction of $RI$ in every branch with it's loop current.
- Are equal to the sum of the generators with respect to $I_{A_n}$ 

![[Pasted image 20240624123739.png|Example|350]] 
In this example $I_2=I_{A_2}-I_{A_1}$, moreover
$$
\begin{cases}
  (R_1+R_2)I_{A_1}-R_2I_{A_2} = + E_1-E_6, & \text{loop } A_1 \\
  (R_2+R_3+R_4)I_{A_2}-R_2I_{A_1}-R_4I_{A_4}=+E_3-E_4, & \text{loop } A_2 \\
  R_4I_{A_4}=+E_4+E_5+E_6, & \text{loop } A_3
\end{cases}
$$
### 4.2.4) Node voltage analysis
This resolution method is equivalent to the [Loop current analysis method]([[#^04bfce]]) but with voltages. This method satisfies implicitly the $l-(n-1)$ KVL equations. To apply this method it is necessary to put a potential of a node to 0 in order to assume sone reference potential, since the circuit is, by definition, [electrically floating](https://en.wikipedia.org/wiki/Floating_ground). Now all the potentials can be expressed as a difference of potential. In this case every voltage can be expressed as: $V_n = U_+ - U_-$ While the equation for each node is of form: $(\sum G_i) - \sum G_iU_i = \sum J_{\text{enter}} - \sum J_{\text{exit}}$
![[Pasted image 20240624160652.png|Example|350]]
Let's set $U_4=0$, for example, $V_1=U_1-U_2=$. Now:
$$ \begin{cases}
(G_1+G_5)U_1-G_1U_2-G_5U_3 = J_1 - J_5+J_6, & \text{for }N_1\\
(G_1+G_2+G_3)U_2-G_1U_1-G_3U_3 = -J_1+J_2+J_3, & \text{for }N_2\\
(G_3+G_4+G_6)U_3-G_5U_1-G_3U_2=J_3-J_4+J_5, & \text{for }N_3
\end{cases}$$
Then, recalling Ohm's law, $I=GV$. With $V = U_+ - U_-$
>[!rmk] 
>If there are G and J in series, G doesn't appear in the equation

### 4.2.5) Substitution Principle
**DC Regime**
In a circuit with a **series connection of $J,R$ can be substituted with just $J$**. This doesn't change $V, R, J$ on the branch and thus it is equivalent

Analogously, **a parallel connection of $E, R$ can be substituted with a single branch of $E$** This doesn't change $V, R, J$ on the branch and thus it is equivalent.

>[!rmk] 
>To gather informations on the branch it is necessary to transform it back.
>
>In the parallel connection of $E,R$ the current flows in opposite directions
>In the series connection $J,R$ the voltage is different between the bipoles

In a circuit it is possible to substitute a **parallel connection of $J, R$ in a series connection of $E,R$**  with $E=RJ$.

In a circuit it is possible to substitute a **series connection of $E, R$ in a parallel connection of $J,R$**  with $J=E/R$.
>[!rmk] 
>To gather informations on the branch it is necessary to transform it back.
>
>In the initial parallel connection of $J,R$ the current flows in opposite directions
>In the initial series connection $E,R$ the voltage is different between the bipoles

**AC Regime**
It essentially holds the same but by just considering every passive bipole, not just R