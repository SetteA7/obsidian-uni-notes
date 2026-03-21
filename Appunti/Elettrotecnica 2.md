# 1) Elettrotecnica (EC) (_salute_)
## 1.1) Introduction

^be8250

The **electric current** is defined $i(t)=\frac{dq}{dt}$. The sign of the current depends on how the surface is oriented. In 2018 the unit of measure of charge, Coulomb $[C]$ is defined as $[A\cdot s]$.

The **voltage** is defined as $\int_A^B E dt$. The result depends o the path between $A, B$. A positive quantity means the work is done by the field, otherwise it goes against such forces. The **positive pole $(+)$** corresponds with the start of the path. The unit of measure is Volt $[V]=[J/C]$ This force correlates with the **electric potential** since $V_{AB}=U_A-U_B$. We define $U = \frac{dW}{dq}$ With $U = 0$ at infinite distance
## 1.2) Measuring Devices

^086f88

> [!col]
> ![[Pasted image 20240710233404.png|Ammeter example|250]]
> >[!col]
> >This is an ammeter, it uses the **load convention**. It measures the current passing through this bipole/branch. An ideal ammeter doesn't alter the current.
> >
> >In AC regime, it only measures the effective value that is always positive

>[!col]
>![[Pasted image 20240710233302.png|Voltmeter example|250]]
>>[!col]
>>This is a voltmeter, it measures the difference of potential on its two poles. An ideal Voltmeter has infinite resistance in order to create an open circuit.
>>
>>In AC regime, it only measures the effective value that is always positive

There are two ways to measure the voltage and current in a circuit:
- V-I Resistance measurement with Voltmeter directly in parallel with the Resistance: This causes a systematic error in the Ammeter by adding the internal resistance of the ammeter
- V-I Resistance measurement with Ammeter directly in series with the Resistance: This causes a systematic error in the Voltmeter by adding the resistance of the Ammeter

There is also a way to measure a resistance: **The Wheatstone bridge**
![[wheat.png|Wheatstone bridge|250]]
R_2 is changed until the Ammeter (Galvanometer) measures 0 current, then:
$V_{CD}=V_{CB}$ and also $V_{AD}=V_{AB}$, then $R_XI_X=R_2I_2$ and $R_1I_1=R_3I_3$, but since $I_1 = I_2$ and $I_X=I_3$ we can divide both sides 

>[!col]
>![[Pasted image 20240716155312.png|Wattmeter example|350]]
>>[!col]
>>In order to measure the power a wattmeter is used. This device is essentially a voltmeter and an ammeter combined.
>>.
>>In AC regime it only measures the mean power, i.e. the real/active power $P=VI\cos(\phi)$ 
## 1.3) Electric Network Model
A network is a model that can describe electromagnetic phenomena under the following conditions:
- It is possible to define integral parameters of the scalar and vector fields
- We can assume an infinite speed of propagation
Moreover it must also be in **quasi stationary regime**. this means:
- No radiation
- Small dimension s.t. the propagation is instantaneous

We base our network on **bipoles** connected together via **conductors**.  We define the following fundamental conditions:
- The conductors are ideal
- The space outside of network components is insulated (quasi stationary)
- The field is conservative outside of bipoles, i.e. a conductor has no difference of potential
- No charge is accumulated outside of bipoles

We mainly study bipoles, but generally we can define n-poles. Let's focus on bipoles:
A bipole must follow these two fundamental conditions:
- The current entering is the same as the one exiting
- Between the two terminals there is a difference of potential
These are just a recap of the fundamental conditions described above, in particular the second one states that outside of the bipole the field is conservative.

On a bipole we also define a convention based on how the current should enter:
> [!col]
>![[Pasted image 20240624151439.png|Load convention in a generic bipole|250]]
>
>> [!col-md]
>>1) Load convention: I is positive if it enters on + side
>>2) Source convention: I is negative if it enters on + side

There are various categories of bipoles:
- Active bipole: $I = 0, \ V_{AB}\not= 0$
- Passive bipole: $I$ and V$_{AB}$ have the same sign
	-  it is always an inert bipole: I=0, V=0
- Linear/Non-linear: self explanatory
## 1.4) Power
An important parameter to define is power $p(t) = v_{AB}(t)i(t) = \lim_{\Delta t \to 0}\frac{\Delta Q}{\Delta T}$. Based on the convention used for a bipole, we can better understand the sign of this parameter: A _source convention(generator)_ will have a positive power if it is delivering power, while a _load convention(resistor)_ will have a positive power when it is absorbing power.

>[!thm] Energy Conservation Principle
>Using load convention on all bipoles (even sources), the sum of all powers is 0:
>$$\sum p_i = 0 \iff \sum p_{\text{abs}} = \sum p_{\text{sup}}$$
>`\begin{proof}`
>By recalling the definition of power: $\displaystyle\sum p_k = \sum v_ki_k$ 
>By recalling then the definition of potential we can arrive to: $\displaystyle{\frac{1}{2}}\sum_{i}^{n}\sum_{j}^{n}(U_i-U_j)i_{ij} \ \forall \ i \neq j$
>We are doing this sum on all branches (i, j are the two nodes), this means we are considering every node, ths the division by 2 is necessary
>by distributing and permuting we obtain: $\displaystyle\frac{1}{2}(\sum_{i}^{n}U_i\sum_{j}^{n}i_{ij}-\sum_{j}^{n}U_j\sum_{i}^{n}i_{ij})$
>keep in mind that for every branch (i.e. when $i=j$ in the first sum of the pairs ) the $i_j$ sum represents all entering currents, while the other are the exiting ones, thus by KCL they equal to $0$, this is true for every pair, thus:
>$$\sum p_k=\frac{1}{2}(\sum_{i}^{n}U_i\sum_{j}^{n}i_{ij}-\sum_{j}^{n}U_j\sum_{i}^{n}i_{ij})=0$$
>`\end{proof}`

From here we can also define the non amplification theorem
>[!thm] Non Amplification Theorem
>The theorem works both for voltage and current:
>At any time the module of the current/voltage supplied by all sources is greater or equal than the module of the current/voltage on any other bipole
>
>`\begin{proof}`
>For the voltage part:
>Suppose the source between nodes $A,B$ and the passive bipoles between nodes $M, N_k$. By KCL $\sum i_k = i_{MN_1} + i_{MN_2} + ... + i_{MN_n} = 0$
>this means that there must be at least one negative current. by chosing $i_{MN_r} > 0, \ I_{MN_s} < 0$ we have $v_{MN_r} = v_M - v_{N_r}, \ v_{MN_s} = v_M -v_{N_s}$ this means that $v_{N_r}<v_M<v_{N_s}$ and is intermediate between the two connecting ones
>`\end{proof}`

**AC Regime:**
It gets a bit more complicated in AC regime, since
$$p(t) = v(t)i(t) = V_M\sin(\omega t + \alpha)I_M\sin(\omega t + \beta)=V_M\sin(\omega t + \alpha)I_M\sin(\omega t + \alpha - \phi)$$
Recall that: $\sin(x)\sin(y) = \frac12 (cos(x-y) - cos(x+y))$
$$p(t) = \frac{V_MI_M}{2}(\cos(\phi)-\cos(2\omega t + 2\alpha -\phi)) = VI\cos(\phi) - VI\cos(2\omega t -\phi)$$
Where the first term, called **active/real power**  is constant, and the second, called **fluctuating power** has pulsation $2\omega$.

>[!thm] Mean power theorem
>In AC regime, the mean power over one period $T$ corresponds to the real power. 
>
>`\begin{proof}`
>The proof is easy and consists in a simple integration: $P=1/T\int_{[T]} p(t)dt$
>Since the fluctuating power is sinusoidal it has 0 mean, on the other hand the real power is constant.
>`\end{proof}`

By rewriting $p(t)$ it is possible to find another meaningful data:
$$p(t) = VI[\cos\phi -(\cos2\omega t\cos\phi+\sin2\omega t\sin\phi)]=VI\cos\phi(1-2\cos2\omega t)-VI\sin\omega t\sin2\omega$$
Define the **reactive power** as $Q = VI\sin(\phi)$, it corresponds to the maximum power of exchange of energy, while $P$ is just dissipated/supplied

From $P$ and $Q$ we can define the **apparent power** $S=VI = \sqrt{P^2 + Q^2}$
This is just the modulus of the **complex power** $\dot S=\dot V \overline{\dot I}$
This highlights how $P,Q$ are the real/imaginary parts of the complex power
## 1.5) Bipoles
### 1.5.1) Voltage/Current Sources
**Ideal:**
Both these sources use the source convention, we have:
> [!col]
> The voltage source is a bipole that keeps a constant voltage: $V_{AB}=E$. If $E=0$ we call this a short circuit. They can't be put in parallel if they generate different voltages
>.![[Pasted image 20240710170220.png|Current source|300]]
>  
> >[!col]
> >
>> ![[Pasted image 20240710165706.png|Voltage source|300]]
>> The current source is a bipole that keeps a constant current: $I=J$. If $J=0$ we call this an open circuit. They can't be put in series if they generate different currents.

**How is a generator made?**
A generator doesn't create energy, it converts another type of energy (e.g. chemical) into electric by creating a difference of potential. The field separating the charges is called $E_g$ and goes $- \rightarrow +$ inside the generator. This produces a difference of potential in the the two terminals. The integral of this field is called fem (electromotive force) $\int_-^+E_gdt$. 
>[!col]
>By looking at the picture it is clear that this field isn't conservative since $\oint E_g=\int_B^AE_gdt=\int_B^A-E_cdt=v_0 \neq 0$. On the other hand the columbian filed is conservative since $\oint E_c=\int_A^BE_cdt\int_B^A-E_cdt=v_0-v_0 = 0$
>>[!col]
>>![[Pasted image 20240710181821.png|Generator with paths and directions|250]]

**Real:**
In real voltage sources the voltage delivered isn't constant, but it depends on the current given from dissipative fenomena. This voltage drop can be represented by an internal resistance put in series with the an ideal generator.
In a branch with a generator 
>[!col]
>![[Diagramma senza titolo.drawio (1).png|Real Voltage Source Branch|350]]
>From this image it is clear that $V_{AB}=-V_R+E=-RI+E$
>>[!col-md] 
>>![[Pasted image 20240710194228.png|Diagram of voltage dependency of I|250]]

It is clear that with 0 current the voltage generator acts as an open circuit, while holding the ideal voltage, while with $I = I_{cc} = \frac{E-V}{I}$ it acts as a short circuit.

![[Pasted image 20240710194930.png|Basic Circuit with an ideal voltage source|300]]
For a **current source** we have a similar discourse, but with a parallel connection with the following characteristic equations:
$$\begin{align}
&I = J - I_R = J-\frac{V}{R_i} \\ &V =R_i(J-I)
\end{align}$$

Now we will show the **performance** of a real voltage source, and it's theoretical maximum:
In this circuit we can easily find:
 $$I=\frac{E}{R_i+R_u}, \ V=R_uI=E\frac{R_u}{R_i + R_u}$$
 Let's define the supplied and absorbed power of the generator (and $R_i$):
$$\begin{align}
&P_g = VI=EI=\frac{E^2}{R_i + Ru} \\
&P_d=VI=R_iI^2=R_i \frac{E^2}{(R_i + Ru)^2}
\end{align}$$
then the supplied power is: $P = P_g-P_d =R_u \frac{E^2}{(R_i + Ru)^2}$
Which is the same as the direct calculation:
$$P_g = VI=R_uI^2=R_u \frac{E^2}{(R_i + Ru)^2}$$
We define the performance as: $\eta=\frac{P}{P_g}=\frac{R_u}{R_i+R_u}$
The maximum value of $P$ can be found by derivating with respect to $R_u$: 
$$\frac{dP}{dR_u} = E^2\frac{R_i-R_u}{(R_i + R_u)^3}$$
Thus the max value for $R_i$ is $R_u$, then, $\eta = 0.5$

### 1.5.2) Resistor
**DC Regime:**
> [!col]
>![[Pasted image 20240628120827.png|Resistor bipole|150]]
>
>> [!col-md]
>>For a linear resistor we use the **Load Convention**. The characteristic equation is: $v_{AB}(t)=R\ i(t)$ given from Ohm's law
The inverse of a resistance is the **Conductance** $G=1/R$ and then: $i(t) = G\ v_{AB}(t)$
For a resistor the power corresponds to Joule's law: $P = -|V_{AB}I| = RI^2$ and **it is always negative** since it is a passive bipole using the load convention

>[!thm] Series/Parallel connection of resistors
The **series connection** is: $R_{eq} = \sum Ri$
>
>`\begin{proof}`
In a series connection The current going through all the resistors is the same: $$V_i=R_iI\text{, then: }V_{AB}=\sum V_i = \sum R_i I=I\sum R_i \implies R_{eq}=\frac{V}{I}=\sum R_i$$
>`\end{proof}`
>
The **parallel connection** is: $\frac{1}{R_{eq}}=\sum \frac{1}{R_i}$, $R_{eq} = (\sum \frac{1}{R_i})^{-1}$
>
>`\begin{proof}`
In a parallele connection the voltage at the terminals is the same:
$$V=R_iI_i\text{, then: } I = \sum I_i = V\sum\frac{1}{R_i} \implies R_{eq}^{-1}=\frac{I}{V}=\sum \frac{1}{R_i}$$
>`\end{proof}`

>[!corollary] Voltage/Current Divider
>In a **series connection**, the **voltage** of a single resistor can be found using the formula:
>$$V_i=R_iI_i=R_iI = V\frac{R_i}{R_{eq}}=V\frac{R_i}{\sum R_{n}}$$
>In a **parallel connection**, the **current** on a single resistor is:
>$$I_i = G_iV = G_i \frac{I}{G_{eq}}=I_i \frac{G_i}{\sum G_n}$$
>From here the case with 2 resistors is obvious:
>$$I_a=I\frac{R_b}{R_a+R_b}$$

>[!theorem] Star/Triangle transformation
>It is possible to transform the following shapes using these relations
![[Pasted image 20240623190232.png|Triangle and Star|350]]
>$$
>R_{ab} = R_a+R_b + \frac{R_aR_b}{R_c} \iff R_a=\frac{R_{ab}R_{ac}}{\sum R_{ij}}
>$$

In AC it is interesting to study the resistive impedance:
$$Z_R=X_R=R$$
It is also important to notice that in a resistance, both current and voltage are in phase.

**Proof:**
By using the definition of voltage and current:
$$v(t) = V_Msin(\omega t + \alpha) \rightarrow i(t) = \frac{v(t)}{R}=\frac{V_M}{R}sin(\omega t + \alpha)$$
In symbolic representation:
$$\dot I = \frac{\dot V}{R} \implies \dot Z = \frac{\dot V}{\dot I}=R$$
$$\begin{flalign} &&\square\end{flalign}$$
![[Pasted image 20240716132706.png|V and I phasors in phase|250]]

It is also useful to study the power:
Since $\phi = 0$, we have only active power: $\dot S = \dot V \overline{\dot I} =VI = P$


### 1.5.3) Capacitor
> [!col]
>A capacitor is made of two plates of conducting material put near each other. These plates get charged $\pm Q$ and create an electric field inside the bipole proportional to $Q$ in equilibrium conditions. We define a constant called **capacitance** $C=\frac{Q}{v}$ measured in farad $[F]$ positive and constant in time since it is shape dependant.
>Being a bipole, the current entering must be the same as the exiting one: $i_a(t)=i_b(t) \implies q_a(t)+q_b(t)=0$. 
>> [!col-md]
>>![[Pasted image 20240628122424.png|Capacitor bipole|200]]

The bipole uses the **load convention**. Let's define it's characteristic function:
By definition of current $i =\frac{dq}{dt}$ and capacitance $C=\frac{Q}{v}$ we can find $i(t) = \frac{d(Cv(t))}{dt}$
$$\begin{align}
i(t) &= C\frac{dv(t)}{dt} \\
v(t) &= v(0) + \frac1C \int_0^t i(\tau)d\tau
\end{align}$$
**DC Regime:**
It is important to notice that in DC regime v(t) is constant, thus $i(t)=0$ and C behaves as an open circuit.

**AC Regime**
In AC it is interesting to study the capacitive impedance:
$$Z_C=jX_C=j\frac{-1}{\omega C}$$
It is also important to notice that in a capacitor, current and voltage are in quadrature anticipation .

**Proof:**
By using the definition of voltage and current:
$$v(t) = V_M\sin(\omega t + \alpha) \rightarrow i(t) = C\frac{dv(t)}{dt}=\omega C V_M \cos(\omega t + \alpha)=\omega C V_M \sin(\omega t + \alpha + \pi/2)$$
from here we get $I = \omega C V_M$. In symbolic representation:
$$\dot I = \omega C \dot V e^{j\pi/2}= j\omega C \dot V \implies \dot Z = \frac{\dot V}{\dot I}=\frac{1}{j\omega C}=\frac{-j}{\omega C}$$
$\begin{flalign} &&\square \end{flalign}$
![[Pasted image 20240716131801.png|Quadrature delay|250]]

It is also useful to study the power:
Since $\phi = \pi/2$, we have only reactive power: $\dot S = \dot V \overline{\dot I}=\omega C V^2 e^{-j\phi}=-j\omega CV^2=-j\frac{V^2}{X_C}=-jVI=Q_C$


**Variale regime**
An important study in variable regime is the charge/discharge process of a capacitor:
![[Pasted image 20240711162621.png|Circuit for charge/discharge of capacior|400]]
- **Charge process:**
The switch is set in position 1 with initial condition $v_c(\pm 0) = v_c(0) = 0$.
In this case the expressions are:
$$\begin{align}
v_C(t)&=E(1-e^{-t/RC}) \\
i_C(t) &= C\frac{dv(t)}{dt} =\frac{E}{R}e^{\frac{-t}{RC}}
\end{align}$$
>[!note] Calculations
>By Kirchhoff and the definition of capacity we have:
>$$\begin{cases}
\begin{cases}
i_C(t)&=i_R(t)=i_E(t) \\
E &= v_C + v_R \end{cases} \\
i_C(t) = C\frac{dv_C(t)}{dt}
\end{cases}
\implies E = v_C + RC\frac{dv_C(t)}{dt}
>$$
The forced solution, having an open circuit is: $v_{Cf} = E$
The free evolution is given by: $RCs +1 = 0 \implies s= -\frac{1}{RC} \implies v_{Co}=Ae^{-t/RC}$
Then we have: $v_C(t)=E+Ae^{-t/RC}$
To find $A$ we impose the initial condition: $v_c(0)=0=E-A \implies A = -E$
Finally we have: $v_C(t)=E(1-e^{-t/RC})$
And $i_C(t)$ can be found by derivation

We can find the **stored energy in a capacitor**:
$$E=\int_{0}^{\infty}v(t)i(t)dt=\int_{0}^{Q} v(t)dq = \frac12\frac{Q^2}{C}=\frac12 CV^2$$
- **Discharge process**
The switch is then set in position 2 with initial condition $v_c(\pm 0) = v_c(0) = E$
$$\begin{align}
v_C(t) &= Ee^{-t/RC} \\
i_C(t) &= -\frac ER e^{-t/RC}
\end{align}$$
>[!note] Calculations
>Now we can set:
>$$\begin{cases}
\begin{cases}
i_C(t)=i_R(t) \\
0 = v_C + v_R \end{cases} \\
i_C(t) = C\frac{dv_C(t)}{dt}
\end{cases} 
\implies 0 = v_C + RC\frac{dv_C(t)}{dt}
>$$
The forced solution is null, while the free solution is the same as before, then we have:
$v_C(t) = Ae^{-t/RC}$
by imposing the initial condition we can find A: $v_C(0) = E = A$
Finally we have: $v_C(t) = Ee^{-t/RC}$

Another way to look at energy is infinitesimally by setting:
$$\begin{align}
&dW_{\text{supp}} &= &dW_{\text{acc}} &+ dW_{\text{diss}} \\
&\int Eidt &= &\int R i^2dt &+ \int vidt \\
&EQ&=&\frac12 E Q &+ \frac12 EQ
\end{align}$$
thus the efficiency of charge is $\eta = 0.5$.

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


### 1.5.4) Inductor

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

**DC Regime:**
It is important to notice that in DC regime i(t) is constant, thus $v(t)=0$ and L behaves as a closed circuit.

**AC Regime**
In AC regime it is interesting to study the inductive impedance:
$$Z_L = jX_L = \omega L$$
It is also important to notice that in an inductor, current and voltage are in quadrature delay.

**Proof:**
By using the definition of voltage and current:
$$v(t) = V_M\sin(\omega t + \alpha)$$
$$i(t) = \int \frac{v(t)}{L}dt=\frac{V_M}{L}\int\sin(\omega t + \alpha)=-\frac{V_M}{\omega L}\cos(\omega ta + \alpha)=\frac{V_M}{\omega L}\sin(\omega t + \alpha - \pi/2)$$
from here we get $I =\frac{V_M}{\omega L}$. In symbolic representation:
$$\dot I = \frac{\dot V}{\omega L}e^{j(-\pi/2)}=-j\frac{1}{\omega L}\dot V \implies \dot Z = \frac{\dot V}{\dot I} = \frac{\omega L}{-j}=j\omega L$$
![[Pasted image 20240716134609.png|Quadrature anticipation|250]]

It is also useful to study the power:
Since $\phi = -\pi/2$, we have only reactive power: $\dot S = \dot V \overline{\dot I}=\frac{V^2}{\omega L}e^{-j\phi}=j\frac{V^2}{X_L}=jVI=Q_L$

**Variale regime**
An important study in variable regime is the charge/discharge process of an inductor:
![[Pasted image 20240712183731.png|Circuit for charge/discharge of an inductor|400]]
- **Charge process:**
The switch is set in position 1 with initial condition $i_L(\pm 0) = i_L(0) = 0$.
In this case the expressions are:
$$\begin{align}
i_L(t)&=\frac{E}{R}(1-e^{-\frac RL t}) \\
v_L(t)&=L\frac{di(t)}{dt}=Ee^{-\frac RL t}
\end{align}$$
>[!note] Calculations
>By Kirchhoff we have:
>$$\begin{cases}
\begin{cases}
i_L(t)=i_R(t)=i_E(t) \\
E = v_L + v_R \end{cases} \\
v_L(t) = L\frac{di_L(t)}{dt}
\end{cases} 
\implies E = L\frac{di_L(t)}{dt} + Ri_L
>$$
>The forced solution is $i_{L_f}= \frac ER$
>The free solution is given by: $Ls +R = 0 \rightarrow s=-\frac{R}{L}$
>then: $i_L(t) = \frac ER + Ae^{-\frac RL t}$
>By imposing the initial condition: $A = -\frac ER$

- **Discharge process**
The switch is set in position 2 having initial condition $i_L(\pm 0) = i_L(0) = \frac ER$
in this case the expressions are:
$$
\begin{align}
i_L(t)&=\frac{E}{R}e^{-\frac RL t} \\
v_L(t)&=L\frac{di(t)}{dt}=-Ee^{-\frac RL t}
\end{align}
$$
>[!note] Calculations
>By Kirchhoff we have:
>$$\begin{cases}
\begin{cases}
i_L(t)=i_R(t) \\
0 = v_L + v_R \end{cases} \\
v_L(t) = L\frac{di_L(t)}{dt}
\end{cases} 
\implies 0 = L\frac{di_L(t)}{dt} + Ri_L
>$$
>The forced solution is $i_{L_f}= 0$
>The free solution is given by: $Ls +R = 0 \rightarrow s=-\frac{R}{L}$
>then: $i_L(t) = Ae^{-\frac RL t}$
>By imposing the initial condition: $A = \frac ER$

Another way to look at energy is infinitesimally by setting:
$$\begin{align}
&dW_{\text{supp}} &= &dW_{\text{acc}} &+ dW_{\text{diss}} \\
&\int Lidt &= &\int R i^2dt &+ \int Lidt \\
&LI^2&=&\frac12 LI^2 &+ \frac12 LI^2
\end{align}$$
thus the efficiency of charge is $\eta = 0.5$.

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
## 1.6) Kirchhoff Laws
From the assumptions of an electrical network we can define 2 main laws called Kirchhoff laws.
- **Kirchhoff Current Law (KCL)** 
The sum of the currents entering and exiting a node (or a surface cutting the network, insieme di taglio) is null:
$$\sum I_i = 0 \iff \sum I_{\text{in}} = \sum I_{\text{out}}$$
- **Kirchhoff Voltage Law (KVL)**
The sum of the voltages in a loop or mesh is 0
$$\sum V_i = 0 \iff \sum V_+ = \sum V_-$$
These two laws can be used to solve any network: define with $n$ as the number of nodes and $l$ the number of branches, than the following equations are needed:
- $n-1$ KCL equations
- $l-(n-1)$ KVL equations
these are all linearly independent

## 1.7) Theorems
>[!thm] Substitution Theorem
>Any branch made of bipoles that admit univocal v-i relation can be rewritten as just a voltage/current source. $E$ must be the difference of potential of the branch, $J$ must be the current entering/exiting.
>
>`\begin{proof}`
>Simply, if the branch has the same current/voltage then it can be either made of 1 bipole or 100, it doesn't change the workings of the network
>`\end{proof}`

>[!thm] Thevenin theorem: Equivalent Voltage Generator
>In a **linear circuit** the behaviour of any bipole network, in terms of voltage at the terminals $A, \ B$ is equivalent to a real voltage source ($E_{eq} +  R_{eq}$) called **equivalent voltage source**.
>![[Pasted image 20240624183358.png|Thevenin theorem representation|400]]
>
>with $E_{eq} = V_0$ the tension between the terminals $A, \ B$ and $R_{eq}$ the equivalent resistance with all generators turned off. Keep in mind $R_{eq} = \frac{V_0}{I_{cc}}$
>
>`\begin{proof}`
>![[Pasted image 20240711154130.png||400]]
>Any bipole network on the right side can be substituted by an ideal current source by substitution theorem. Then, by superimposition principle $V = V'+V''$.
>$V'$ is the voltage with $J$ switched off. This coincides with $V_0$ since $J$ acts as an open circuit
>$V''$ is the voltage with all the generators on the left side switched off. This becomes: $V''=-JR_{eq}$
>then we have: $V = V_0 - JR_{eq}$ which is the characteristic equation of a branch with a real voltage source
>`\end{proof}`

>[!thm] Norto theorem: Equivalent Current Source
>In a **linear circuit** the behaviour of any bipole network, in terms of voltage at the terminals $A, \ B$ is equivalent to a real current source ($J_{eq}//R_{eq}$) called **equivalent current source**.
>![[Pasted image 20240711160349.png|Norton Theorem representation|400]]
>
>with $J_{eq} = I_{cc}$ the tension between the terminals $A, \ B$ and $R_{eq}$ the equivalent resistance with all generators turned off. Keep in mind $R_{eq} = \frac{V_0}{I_{cc}}$
>
>`\begin{proof}`
>Totally analogous as before.
>Any bipole network on the right side can be substituted by an ideal voltage source by substitution theorem. Then, by superimposition principle $V = V'+V''$.
>$V'$ is the voltage with $E$ switched off. This coincides with $V_0$ since $E$ acts as a closed circuit
>$V''$ is the voltage with all the generators on the left side switched off. This becomes: $V''=-R_{eq}I_{cc}$
>then we have: $V = V_0 -R_{eq}I_{cc}$ which is the characteristic equation of a branch with a real voltage source.
>`\end{proof}`

>[!thm] Equivalent Symbolic Current / Voltage Source
>The behaviour of any bipole network in AC regime can be written as either an equivalent voltage source and impedance, or an equivalent current source and an admittance.
>![[Pasted image 20240628190159.png|Representation of the theorem|350]]
>
>`\begin{proof}`
>a
>`\end{proof}`


## 1.8) DC Regime
The DC regime is defined as having sources that generate their parameter constantly from infinite time for infinite time. In this regime capacitors act as open circuits and inductors as closed circuits, since they are in phase quadrature
## 1.9) AC Regime
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

It is important to note that in symbolic representation the RMS is used, so $A=\frac{A_M}{\sqrt 2}$
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
### 1.9.1) Phasor Representation
> [!col]
![[Pasted image 20240628111726.png|Graphical representation of a phasor]]
>
>> [!col-md]
>>The phasorial representation shows $a(t)$ as a vector of modulus $A_M$ rotating counterclockwise with angular velocity $\omega$ and starting angle $\alpha$. The projection of the phasor on the x and y axis show respectively the cosine and sine function.
### 1.9.2) Symbolic representation
More useful is the symbolic representation. Usually a sinusoidal is expressed in the form:
$$
\dot A = \sqrt2A_{\text{eff}}e^{j\alpha}e^{j\omega t}=A_Me^{j\alpha}e^{j\omega t}=A_Me^{j(\omega t + \alpha)}
$$
A simple proof consists of taking the phasorial representation in complex terms: $\dot A = A_Mcos(\omega t + \alpha)+jA_Msin(\omega t + \alpha)$. 
By using: 
$cos(a+b)=cos(a)cos(b)-sin(a)sin(b)$, $sin(a+b)=sin(a)cos(b)+sin(b)cos(a)$
we get:
$$\begin{align}
&A_M(cos(\omega t)cos(\alpha)-sin(\omega t)sin(\alpha)+jsin(\omega t)cos(\alpha)+jcos(\omega t)sin(\alpha))= \\
&A_M(cos(\alpha)(cos(\omega t)+jsin(\omega t))+jsin(\alpha)(cos(\omega t)+jsin(\omega t))= \\
&A_M(cos(\alpha)+jsin(\alpha))(cos(\omega t)+jsin(\omega t)
\end{align}$$
with the term $A_M(cos(\alpha)+jsin(\alpha))$ being $\dot A$ at $t=0$.

### 1.9.3) Impedance
Define a passive bipole using load convention(resistor, capacitor, inductance) in a AC circuit, we define the impedance as : 
$$\dot Z = \frac{\dot V}{\dot I}=\frac{V e^{j\alpha}e^{j\omega}}{I e^{j\beta}e^{j\omega}}= Ze^{j(\alpha-\beta)}=Ze^{j\phi}$$This complex operator shows the tendency of the bipole to resiste the change of current passing through it. In particular, the term $\phi$ shows the phase difference (delay ) of $\dot I$ with respect to  $\dot V$.

The admittance is the reciprocal of the inductance

It is possible to define a parallel and series connection of all passive bipoles and find their equivalent impedance:
$$\begin {align}
&\dot{Z_{\text{series}}} = R_{\text{series}} + jX_{\text{series}} = \sum \dot{Z_i}\\
&\dot{Z_{\text{parallel}}} = (R_{\text{parallel}} +jX_{\text{parallel}})^{-1}=(\sum 1/\dot{Z_i})^{-1}
\end{align}$$
Here is a quick recap of impedance for the passive bipoles we are studying:

|     | $Z$    | $X$           | phase with $\overline V$               |
| --- | ------ | ------------- | -------------------------------------- |
| $R$ | $R$    |               | $\phi =0$: in phase                    |
| $C$ | $jX_C$ | $-1/\omega C$ | $\phi =\pi/2$: anticipation quadrature |
| $L$ | $jX_L$ | $\omega L$    | $\phi =-\pi/2$: delay quadrature       |
### 1.9.4) Resonance
A series/parallel connection of an inductor and a capacitor bipole can cause some strange behaviours. An easy way to check if two bipoles are in resonance is to see if the fundamental pulsation is given by: $w = \frac{1}{\sqrt{LC}}$

**Series resonance:**
>[!col]
>![[Pasted image 20240716151125.png|Circuit for series resonance|350]]
>>[!col]
>>In such a circuit, if $\omega_0 = \frac{1}{\sqrt{LC}}$, then the inductor-capacitor series acts as a closed circuit since $\dot Z$ has no imaginary part:$$\begin{align}
Im(\dot Z)&= \omega L - \frac{1}{\omega C}= \frac{\omega^2LC-1}{\omega C} \\
&= \frac{\frac{1}{LC}LC-1}{\omega C}=0
\end{align}$$

The **resonance pulsation** was found by finding the min value of:
$$|\dot Z(\omega)|=\sqrt{R^2+(\omega L -\frac{1}{\omega C})}$$
Instead of doing the derivative it is sufficient to notice that the minimum value is when $X_L = -X_C \implies \omega_0=\frac{1}{\sqrt{LC}}$ an thus current and voltage are in phase

By studying other pulsations we can come to other conclusions:
- $\omega < \omega_0$: $$\lim_{\omega \rightarrow 0}\dot Z(w) = \infty \rightarrow \lim_{\omega \rightarrow 0}\phi(w) = -\pi/2$$ this means that the capacitive impedance prevails on the inductive one.
-  $\omega > \omega_0$: $$\lim_{\omega \rightarrow \infty}\dot Z(w) = \infty \rightarrow \lim_{\omega \rightarrow \infty}\phi(w) = \pi/2$$ this means that the inductive impedance prevails on the capacitive one.
>[!col]
>By doing a phasorial study of the voltage, the short circuit is evident: the differences of potential in the two bipoles are equal and opposite. Moreover their Reactive power is null: $$Q_L+Q_C = (X_L+X_C)I^2=0$$
>>[!col]
>>![[Pasted image 20240716153402.png|Phasorial representation|350]]

**Parallel resonance**
>[!col]
>In such a circuit, if $\omega_0 = \frac{1}{\sqrt{LC}}$, then the inductor-capacitor parallel acts as an open circuit since $\dot Y$ has no imaginary part:$$\begin{align}
Im(\dot Y) &=\omega C - \frac{1}{\omega L}= \frac{\omega^2LC-1}{\omega L} \\
&= \frac{\frac{1}{LC}LC-1}{\omega L}=0
\end{align}$$
>>[!col]
>>![[Pasted image 20240716153706.png|Circuit for parallel resonance|350]]

The reasoning is analogous with the series resonance. Let's study what impedance prevails in with other pulses:

- $\omega < \omega_0$: $$\lim_{\omega \rightarrow 0}\dot Y(w) = \infty \rightarrow \lim_{\omega \rightarrow 0}\phi(w) = \pi/2$$ this means that the inductive impedance prevails on the capacitive one.
-  $\omega > \omega_0$: $$\lim_{\omega \rightarrow \infty}\dot Y(w) = \infty \rightarrow \lim_{\omega \rightarrow \infty}\phi(w) = -\pi/2$$ this means that the capacitive impedance prevails on the inductive one.

>[!col]
>By doing a phasorial study of the current, the open circuit is evident: the currents in the two bipoles are equal and opposite. Moreover their Reactive power is null: $$Q = \frac{V^2}{X_L + X_C}=(\frac{1}{\omega_0 L} - \omega_0C)V^2=0$$
>>[!col]
>>![[Pasted image 20240716154826.png|Phasorial representation|250]]

### 1.9.5) Periodic Regime
Any periodic function can be written as a sum of sinusoidal waves with different amplitudes and integer multiple of one fundamental pulsation (see SESI notes).

Every generator can be written as a sum of a generator with the $n-th$ harmonic and dan by superimposition we can find $V=\sqrt{\sum V_n^2}$,  $I=\sqrt{\sum I_n^2}$ and $|\dot S|=\sqrt{{\sum V_n^2}{\sum I_n^2}}$ and thus $S^2\neq P^2+Q^2$ and a higher apparent power is present in a  circuit.

## 1.10) Variable Regime
We have studied this chapter in a less theoretical way, focusing more on the methods of resolution of an exercise.

An exercise will be divided in 2 parts divided at $t = 0$ by a topological change in the circuit.

First it is necessary to find $i_L(0^-), v_C(0^-)$ for every inductor and capacitor in the circuit with $t<0$. These values will also hold in $t=0^+$ after the topological change in the circuit.

Then, at $t>0$, it is necessary to write all the KVL and KCL and find the differential equation that describe the desired $i_L(t)$ and/or $v_C(t)$.

once found it will look something like this: $a\frac{d^2v}{dt^2}+b\frac{dv}{dt}+cv = d$
the result will be of form: $v(t)=v_f(t) + v_o(t)$
- The forced solution is obtained by solving the circuit at t>0 as if it were at regime
- The free solution is obtained by transforming the differential equation in: $as^2 + bs +c = 0$ and then by finding s that can be:
	- s real: $s \in \mathbb{R}$ will have solution of type $Ae^{-st}$
	- s imaginary complementary couple: $s_{1,2} = \sigma \pm \omega$ will have solution of form $e^{\sigma t}(A\sin(\omega t)+B\cos(\omega t))$

To find A, B impose the initial conditions and the exercise is solved

>[!rmk]
>Be careful of open/closed circuits and single branches. It often happens that a circuit must be solved as many smaller independent circuits

