# 1) OP Amp
>[!col]
>The basis to an OP Amp are the **differential components**
>$$ $$
>By defining the dc and ac components respectively as $V_{IC}$ and $v_{i\pm}$, each current can be written as: $$\begin{gather}
v_{I^+}(t)=V_{ic}+v_{i+}(t) \\
v_{I^-}(t)=V_{ic}+v_{i-}(t)
\end{gather}$$
>
>![[Pasted image 20241011135919.png|Differential Amplifier withDifferential Input and Single Ended Output|350]]

We can now define:
$$\begin{gather}
\text{Differential Component:}& v_{id}(t)=v_{i^+}(t)-v_{i^-}(t) \\
\text{Common Component:}& v_{ic}(t)=\frac{v_{i^+}(t)+v_{i^-}(t)}{2}
\end{gather}$$
Then the following relationships hold
$$\begin{gather}
v_{i^+}(t)=v_{ic}(t)+v_{id}(t)/2 \\
v_{i^-}(t)=v_{ic}(t)-v_{id}(t)/2 \\
\end{gather}$$

#### OP Amp
An **OP Amp** is defined by the following variables:

| Name                      | Formula                                       | Ideal Value | Real value     |
| ------------------------- | --------------------------------------------- | ----------- | -------------- |
| Differential Voltage Gain | $A_{dm}=\frac{v_o}{v_{id}}\mid_{v_{ic}=0}$    | $\infty$    | $60-120dB$     |
| Common Voltage Gain       | $A_{cm}=\frac{v_o}{v_{ic}}\mid_{v_{id}=0}$    | $0$         |                |
|                           | $\text{CMRR} = \mid\frac{A_{dm}}{A_{cm}}\mid$ | $\infty$    | $80-120dB$     |
| Input Resistance          | $R_{id}, R_{ic}$                              | $\infty$    | $1-100M\Omega$ |
| Output Resistance         | $R_o$                                         | $0$         | $10-100\Omega$ |
|                           |                                               |             |                |

Under the **linearity assumption** we have that the output voltage can be written as:
$$\boxed{v_o(t)=A_{dm}v_{id}(t)+A_{cm}v_{ic}(t)}$$
The supply voltage imposes some natural limits to the amplifier, by assuming that $V_{SS}=-V_{DD}$:
$$V_{ss}<V_{o,min}<v_o<V_{o,max}<V_{dd}$$
At the **dc operating point** it holds that the voltage difference between $V_I=V_{IC}=V_o=0$, and thus $v_o(t)=A_{dm}v_{id}$, this implies:
$$\frac{V_{SS}}{A_{dm}} \leq v_{id} \leq \frac{V_{DD}}{A_{dm}}$$
>[!col]
>In order for the amp to operate in the linear region we need a **negative feedback**
>First we write some relations we can easily deduce from the diagram: $$\begin{cases}
v_0=A\cdot v_d \\ v_d=v_s-v_f \\ v_f=\beta\cdot v_0 
\end{cases}
\implies v_0=\frac A{1+\beta A}v_s\xrightarrow{A\rightarrow\infty}\frac1\beta v_s$$
>from here we can also find $v_d$:
$$v_d=v_s-v_f=v_s-\beta v_0=\frac 1{1+\beta A}v_s\xrightarrow{A\rightarrow\infty}0$$
>
>![[Pasted image 20241011142012.png|Negative feedback loop|250]]

Moreover we have a **virtual short circuit** that states that $v_+=v_-$ and that no current is entering the op-amp.




#### Various Types of OP-Amp configurations
##### Non inverting amplifier
>[!col]
>A non inverting amplifier has the following values:
>$A_v=1+\frac{R_2}{R_1}$
>$R_i\rightarrow\infty$
>$R_o=0$
>
![[Pasted image 20241019155828.png|Circuit|200]]

Proofs:
**Voltage Gain:**
By the *vsc* (virtual short-circuit) we have that: $v_i=v_+=v_-=v_1$ and by the voltage divider: $v_1=\frac{R_1}{R_1+R_2}v_0=\frac{1}{1+\frac{R_2}{R_1}}v_0$ $\implies$ $A_v=\frac{v_0}{v_i}=\frac{v_0}{\frac{1}{1+\frac{R_2}{R_1}}v_0}=1+\frac{R_2}{R_1}$
**$R_i$:**
We know that $R_i=v_i/i_i$ but since $i_i=0$ due to the vsc, we have that $R_i$ diverges
**$R_o:$**
We know that $R_o=i_o/v_o$ in this case $i_o=0$ and thus the resistance is null
##### Inverting amplifier
>[!col]
>An inverting amplifier has the following values:
>$A_{v0}=-\frac{R_2}{R_1}$
>$R_i=R_1$
>$R_o=0$
>
![[Pasted image 20241019163522.png|Circuit|350]]

Proof:
**Voltage Gain:**
Due to the vsc we know $v_-=v_+=0$ and that $i_1=i_2=i$. Then we know that $i=v_i/R_1$ and that $v_0=-R_2i=-\frac{R_2}{R_1}v_i$ $\boxed{}$
**$R_i$:**
We know that $R_i=v_i/i_i$. In this case $i_i=i=v_i/R_1$ $\implies$ $R_i=R_1$.
**$R_o$:**
We know that $R_o=v_o/i_o$ but since $v_i=0$ to measure $R_o$ then also $i_o=i=0$. 
##### Voltage Buffer
>[!col]
>An inverting amplifier has the following values:
>$A_{v0}=1$
>$R_i\rightarrow\infty$
>$R_o=0$
>
>![[Pasted image 20241019165153.png|Circuit|350]]
##### Summing Amplifier
>[!col]
>To get a generalized form suppose we have $n$ resistances at the load and the resistance at negative feedback is $R_F$:
>$\displaystyle v_0=-R_k\sum_1^n\frac{v_k}{i_k}$
>
>![[Pasted image 20241019165818.png|Circuit|350]]

Proof:
Notice that $v_+=v_i=0$ then $i_k=\frac{v_k}{R_k}$ $\forall$ voltage source. Clearly $i_F=\sum_1^n i_k$, then $\displaystyle v_0=-R_Fi_F=R_F\sum_1^ni_k=-R_F\sum_0^n\frac{v_k}{R_k}=-\sum{R_F}{R_k}v_k$.
##### Difference Amplifier
>[!col]
>$v_0=-\frac{R_2}{R_1}(v_1-v_2)$
>This can be seen as a superposition of an inverting and a non inverting op-amp
>
>![[Pasted image 20241205130931.png|Circuit|350]]

It is possible to find circuits with transient components, but the analysis is the same when operating in Laplace domain and by considering the *"transfer functions"*, and thus the impedances and a *bode plot* representation to better analyze the response.
For the already seen Op-Amps nothing changes in Laplace domain.
First, a quick recap on the response of the basic circuit components:
$$\begin{gather}
R &\stackrel{\mathcal L}{\rightarrow}& R &\stackrel{\text{ac}}{\rightarrow}& R \\
C &\stackrel{\mathcal L}{\rightarrow}& \frac1{sC}&\stackrel{\text{ac}}{\rightarrow}&\frac{1}{j\omega C} \\
L &\stackrel{\mathcal L}{\rightarrow}& sL&\stackrel{\text{ac}}{\rightarrow}&j\omega L
\end{gather}$$
##### Low-Pass Filter/Amplifier
>[!col]
>$Z_1=R_1$ 
>$Z_2=\frac{R_2}{1+sR_2C}$
>$H(s)=-\frac{Z_2}{Z_1}=-\frac{R_2}{R_1}\frac1{1+sR_2C}$
>
>![[Pasted image 20241205132747.png|Circuit+Bode Plot|300]]
##### High Pass Filter/Amplifier
>[!col]
>$Z_1=R_1+\frac1{sC}=\frac{sCR_1+1}{sC}$
>$Z_2=R_2$
>$H(s)=-\frac{Z_2}{Z_1}=-\frac{sR_2C}{1+sR_1C}$
>
>![[Pasted image 20241205133210.png|Circuit+Bode Plot|300]]
##### Band Pass Filter/Amplifier
>[!col]
>This is a mix between a low and a high pass filter
>$Z_1=R_1+\frac1{sC_1}=\frac{sC_1R_1+1}{sC_1}$
>$Z_2=\frac{R_2}{1+sR_2C_2}$
>$H(s)=-\frac{Z_2}{Z_1}=-\frac{sR_2C_1}{(1+sR_1C_1)(sR_2C_2)}$
>
>![[Pasted image 20241205133709.png|Circuit|450]]

Recall that when I transform to the Laplace domain I must ignore any constant input and set it to 0 (ground) since it doesn’t depend on time.
# 2) Diode
This will Just be a quick recap of the PWL model approximation.
![[Pasted image 20241204121930.png|Pn - diode Structure|450]]
![[Pasted image 20241204121906.png|Diode, Zener Diode|650]]
>[!col]
>As seen in the graph in the image, it is possible to identify three different operation regions for the diode. From left to right:
-**Breakdown Region** $\in[-\infty,-V_Z]$
-**Reverse Region** $\in[V_Z,V_{ON}]$
-**Forward Region** $\in[V_{ON},+\infty]$
>$$ $$
>In our approximation we will set:$$i_D=\begin{cases}
\frac{V_D+V_Z}{R_Z}, \ &V_D<-V_Z \\
0 \ &-V_Z<V_D<V_{ON} \\
\frac{V_D-V_{ON}}{R_{ON}}, \ &V_D>V_{ON}
\end{cases}$$
>
>![[Pasted image 20241204111723.png|Graph of Zener Diode|350]]

If $R_{ON}=0$ then the PWL model becomes:
$$\begin{cases}
i_D=\frac{V_D+V_Z}{R_Z}, \ &V_D<-V_Z &\text{ i.e. break down region} \\
i_D=0 \ &-V_Z<V_D<V_{ON} &\text{ i.e. reverse region}\\
V_D=V_{ON}, \ &V_D>V_{ON} &\text{ i.e. forward region}
\end{cases}$$
This condition is often assumed.

Recall that $V_D=V_A-V_K$

>[!rmk|*] Breakdown Region and Zener Diode
The diode must **avoid the breakdown region unless it is a zener diode**. In the other 2 regions they behave exactly the same.

Here are the values for an ideal diode

|            Parameter            | Ideal Diode Value |
| :-----------------------------: | :---------------: |
|    Forward Voltage $V_{ON}$     |       $0V$        |
|     Forward Resistance $R$      |      $0\ohm$      |
| Reverse Breakdown Voltage $V_Z$ |     $\infty$      |


On an analysis of the circuit we can assume one of the three operation regions and solve the circuit using an equivalent model instead of the diode. The solution is valid if the hypothesis holds with the results:


|   $R_{ON}=0$   |                                Forward                                |                 Reverse                 |                               Breakdown                               |
| :------------: | :-------------------------------------------------------------------: | :-------------------------------------: | :-------------------------------------------------------------------: |
|   Condition    |                                $i_D>0$                                |            $-V_Z<V_D<V_{ON}$            |       $V_D<V_Z$, $-I_{Z_{max}}<i_D<I_{Z_{max}}$, must be zener        |
|    Circuit     |            Replace diode with voltage source $V_D=V_{ON}$             | Replace diode with open circuit $i_D=0$ |             Replace diode with voltage source $V_D=-V_Z$              |
| $R_{ON}\not=0$ |                              **Forward**                              |               **Reverse**               |                             **Breakdown**                             |
|   Condition    |                         $V_D>V_{ON}$, $i_D>0$                         |            $-V_Z<V_D<V_{ON}$            |       $V_D<V_Z$, $-I_{Z_{max}}<i_D<I_{Z_{max}}$, must be zener        |
|    Circuit     | $V_D=V_{ON}$![[Pasted image 20241204120848.png\|Forward Region\|200]] | Replace diode with open circuit $i_D=0$ | $V_D=-V_Z$![[Pasted image 20241204122740.png\|Breakdown Region\|200]] |

>[!rmk|*] Current Direction
>It is clear that in a diode the current can only pass in the direction where the triangle is "pointing". Therefore in a circuit analysis it can be used to make some informed guess on the behaviour of the current. 
>In a Zener diode the current can also go the opposite way, so it is good to start with that hypothesis

# 3) Bipolar Junction Transistor (BJT)
As it is shown in the image, the BJT is made from 2 diodes.
![[Pasted image 20241204123315.png|PNP-BJT Structure|250]]
![[Pasted image 20241205112908.png|NPN VS PNP|650]]
We can identify 4 operation regions (NPN BJT used for table):

| BE Junction | BC Junction | BJT Operation Region                                  |
| ----------- | ----------- | ----------------------------------------------------- |
| forward     | forward     | **saturation** (used in digital circuits)             |
| reverse     | reverse     | **cut-off** (used in digital circuits)                |
| forward     | reverse     | **forward-active (active)** (used in analog circuits) |
| reverse     | forward     | **reverse active** (usually not used)                 |
Here are the ideal values of a BJT:

| Parameter      | Ideal Value     |
| -------------- | --------------- |
| $V_{CE_{sat}}$ | $0,1\div0,3[V]$ |


**Forward Active Region Approx. Model:** 

| Type          | NPN                                                                     | PNP                                                               |
| ------------- | ----------------------------------------------------------------------- | ----------------------------------------------------------------- |
| Condition     | if $i_B>0$ and $V_{BC}<V_{BC_{ON}}\implies V_{CE}>V_{CE_{sat}}$         | if $i_B>0$ and $V_{CB}<V_{CB_{ON}}\implies V_{EC}>V_{EC_{sat}}$   |
| Result        | $V_{BE}=V_{BE_{ON}}$ and $i_C=\beta\cdot i_B$, $i_E=(\beta+1)i_B$       | $V_{EB}=V_{EB_{ON}}$ and $i_C=\beta\cdot i_B$, $i_E=(\beta+1)i_B$ |
| Approx. Model | ![[Pasted image 20241205112307.png\|NPN BJT Active Approx. Model\|200]] |                                                                   |

**Saturation Region Approx. Model**
![[Pasted image 20241205113734.png|NPN BJT Saturation Region Approx. Model|170]]
By setting $V_{CE}=V_{BE_{ON}}-V_{BC_{ON}}=V_{CE_{sat}}$ we get to the following table:

| Type          | NPN                                                          | PNP                                                          |
| ------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Condition     | if $i_B>0$ and $i_C<\beta_Fi_B$                              | if $i_B>0$ and $i_C<\beta_Fi_B$                              |
| Result        | $V_{BE}=V_{BE_{sat}}=V_{BE_{ON}}$, $V_{CE}=V_{CE_{sat}}$     | $V_{EB}=V_{EB_{sat}}=V_{EB_{ON}}$, $V_{EC}=V_{EC_{sat}}$     |
| Approx. Model | ![[Pasted image 20241205115843.png\|Even More Approx.\|200]] | ![[Pasted image 20241205115916.png\|Even More Approx.\|200]] |
**Cut-Off Region Approx. Model**

| Type          | NPN                                                                     | PNP                                              |
| ------------- | ----------------------------------------------------------------------- | ------------------------------------------------ |
| Condition     | if $V_{BE}<V_{BE_{ON}}$ and $V_{BC}<V_{BC_{ON}}$                        | if $V_{EB}<V_{EB_{ON}}$ and $V_{CB}<V_{CB_{ON}}$ |
| Result        | all currents $=0$                                                       | all currents $=0$                                |
| Approx. Model | ![[Pasted image 20241205115534.png\|Cut-Off Region Approx. Model\|150]] |                                                  |

The **dissipated power** is given by: $$P_{BJT}=I_C V_{CE}+I_B V_{BE}$$
Operation point of form: $\boxed{I_C=...;\ V_{CE}=...}$

# 4) Metal Oxide Semiconductor Field Effect Transistor (MOSFET)
The MOSFET is described by 4 parameters:
- $V_{TH}$: threshold voltage
- $K'_n$: normalized transconductance factor
- $W/L$: geometric form factor
- $\lambda$: channel length modulator factor
Moreover we have that: $K_n=K'_n\frac{W}{L}=\mu C_{ox}\frac{W}{L}$
<font color="gray"> notice that $\mu$ is either $\mu_n$ or $\mu_p$ if it's a n or p type mosfet </font>

|                       | nMosfet                                            | pMosfet                                            |
| --------------------- | -------------------------------------------------- | -------------------------------------------------- |
| **Symbol**            | ![[Pasted image 20241206103849.png\|nMosfet\|350]] | ![[Pasted image 20241206103908.png\|pMosfet\|350]] |

**Saturation Region:**

|                |                       nMosfet                        |                           pMosfet                            |
| :------------: | :--------------------------------------------------: | :----------------------------------------------------------: |
| **Conditions** | if $V_{GS}>V_{TH}$ and $V_{DS}>V_{OV}=V_{GS}-V_{TH}$ | if $V_{GS}<\|V_{TH}\|$ and $V_{DS}<V_{OV}=V_{GS}-\|V_{TH}\|$ |
|   **Result**   |          $i_D=\frac{K_n}2(V_{GS}-V_{TH})^2$          |              $i_D=\frac{K_p}2(V_{GS}-V_{TH})^2$              |
**Triode Region:**

|                |                            nMosfet                             |                            pMosfet                             |
| :------------: | :------------------------------------------------------------: | :------------------------------------------------------------: |
| **Conditions** |      if $V_{GS}>V_{TH}$ and $V_{DS}<V_{OV}=V_{GS}-V_{TH}$      |      if $V_{GS}<V_{TH}$ and $V_{DS}>V_{OV}=V_{GS}-V_{TH}$      |
|   **Result**   | $i_D=K_n\left((V_{GS}-V_{TH})V_{DS}-\frac{V_{DS}^2}{2}\right)$ | $i_D=K_p\left((V_{GS}-V_{TH})V_{DS}-\frac{V_{DS}^2}{2}\right)$ |

**Cut-Off Region:**

|                |      nMosfet       |      pMosfet       |
| :------------: | :----------------: | :----------------: |
| **Conditions** | if $V_{GS}<V_{TH}$ | if $V_{GS}>V_{TH}$ |
|   **Result**   |      $i_D=0$       |      $i_D=0$       |
The **dissipated power** is given by $V_{DS}I_D$.
# 5) Bode Diagram
The **Bode diagram** is a useful tool to represent a frequency response in a graph using a pwl (piecewise linear) model that asymptotically approximates the real plot . There are two types of plots, the **amplitude** and the **phase** plot, both in logarithmic scale.

#### Why $\log$ scale?
We know that $W(jw)$ can be represented in trigonometric form as $W(jw)= |W(jw)|e^{j\cdot\text{arg}(W(jw))}$. The, using the neperian complex logarithmic we end up with an expression of form $a+jb$:
$$
\ln(W(jw))=\ln\left(|W(jw)|\right)+\ln\left(e^{j\cdot\text{arg}(W(jw))}\right)=\ln\left(|W(jw)|\right)+j\cdot\text{arg}\left(W(jw)\right)
$$
Moreover we use the **bilogarithmic scale**, that is: $20\log_{10}()$

Recall how a transfer function is usually expressed:
$$
W(s)=\frac{n(s)}{d(s)}=\frac{\displaystyle\sum_{m=0}^{\text{deg(n(s))}} b_ms^m}{\displaystyle\sum_{n=0}^{\text{deg(d(s))}} a_ns^n}
$$
which can be rewritten as
$$
W(s)=\frac{b_m}{a_n}\frac{(s-z_1)...(s-z_m)}{(s-p_1)...(s-p_2)}
$$
With some more algebraic manipulation, and by considering the *Fourier transform* (i.e. the phase representation) it is possible to show that **constant terms, zeroes, poles (real and complex)** give different types of contribution to the bode plot, but all these **contributions are additive**

>[!rmk|*] Electronics
>In electronics we will have that $\frac{b_m}{a_n}=(\frac{\omega_0}{s})^r\tag{}$ which includes the $r$ poles in zero and has $(\omega_0)^r=(\frac{b_m}{a_n})^r$

From now on $\log_{10}$ will be simply referred as $\log$

>[!rmk|*] Semilog scale vs log scale
>Wolfram alpha, and many other representations are in **semilogarithmic scale**. The x axis is in $w$, not $\log w$.
>
>Notice that in log scale the slope becomes $[dB/\text{decade}^2]\stackrel{\text{log scale}}{\rightarrow}[dB/\text{decade}]$.
>
>I will write all results in semilog scale. However the plots are in semilogarithmic scale in order to show more of the graph

## 5.2) Constant Term
The first term ($K_B$) is called **Evans gain** and it is important since it is constant, and it also **determines the gain/attenuation**. A simple way to find it is by finding the **DC/Static gain**:

>[!def] DC/Static Gain
>Given a transfer function $W(s)$ with no pole in the origin, we define it's gain as the value in $W(0)=K_{B}$, Then we can group this term in the expression.
>
>This can also be extended to the case with some poles in the origin, by just ignoring the term $\frac{w_{0}}{s}$ in the calculation

Suppose we have
$$
W(s)=K_B
$$
##### Amplitude Plot
It is just a straight line of form $y=20\log|K_B|$
If $|K_B|>1$ we have a gain in the output, otherwise we have an attenuation

##### Phase Plot
Since $K_B\in\mathbb R$ we have that if $K_B>0$ the phase is null, otherwise it is $\pm 180^\circ$ it doesn't matter which one

![[Pasted image 20241120123659.png|Bode diagram of W(s)=-3|450]]
## 5.3) Pole in Origin
Suppose we have 
$$
W(s)=\frac1{s^v}
$$
where $v$ is the degree which coincides with the amount of poles in the origin.
##### Amplitude plot
The transfer function will be $|W(jw)|_{dB}=-20v\log w$

This means that the resulting plot will be a line passing trough the origin $[0,0]$ and it will:
- $v>0$ go downwards with slope $-20 |v| [dB/\text{decade}]$
- $v<0$ go upwards with slope $20 |v| [dB/\text{decade}]$

##### Phase Plot
The transfer function will be $\arg(W(jw))=-v\cdot90^\circ$.

This means that the resulting line will be of form $y=\mp90^\circ$
- $v>0\implies -|v|90^\circ$ 
- $v<0\implies |v|90^\circ$

![[Pasted image 20241120140348.png|Bode plot of W(s)=1/s|450]]

>[!rmk|*]
>A zero in the origin is the equivalent of a pole in the origin, just with different exponential term


>[!corollary] Pole in Zero with Gain
>As explained before in electronics we will have $(\frac{\omega_0}{s})^r\tag{}$ as the first term which includes the $r$ poles in zero and has $(\omega_0)^r=(K_B)^r$. 
>
>This is actually useful since you can draw just **one line with the contribution of the zero and constant term included**. 
>If we have poles in the origin ($r>0$) this line has negative slope ($-20|r|[{dB}/{\text{decade}}]$) and will pass trough $[|r|\log w_0,0]$.
>Otherwise, if there are zeros in the origin ($r<0$) the line has positive slope ($20|r|[{dB}/{\text{decade}}]$) and will still pass trough $[|r|\log w_0,0]$.
>
>Notice that the lines change sign in the slope and it would suggest that the intersection points would also be switched, but $w_{0}$ becomes it's reciprocal with $r<0$ and thus the effects cancel out.
>
>The phase plot depends on the sign of $(w_0)^r$.
>If it is positive it will give zero contribution to the phase and thus the phase plot will be identical to the case of a pole in the origin. 
>Otherwise, the phase will be shifted by a factor of $180^\circ$.

## 5.4) Real Poles and Zeroes
Suppose we have 
$$
W(s)=(1+sT)^\mu
$$

This is valid for zeroes if $\mu>0$, otherwise it is valid for poles, and $|\mu|$ is the number of poles/zeroes. Both cases are centered in $-1/T$, then we end up with:
$$\begin{align}
&\log|W(jw)|=\mu\log\sqrt{1+(wT)^2} \\
&\arg(W(jw))=\mu\arctan(wT)
\end{align}$$
$$ $$
>[!def] Cutoff frequency
>We define the **cutoff frequency** as $$w_c=\frac1{|T|}$$ This frequency is the minimum required frequency to not have a 0 in the Bode diagram approximation
>
>We can rewrite all the poles and zeroes as $s-p\rightarrow1+\frac{s}{p}\rightarrow1+Ts=1+\frac s{w_c}$
>I will write the results according to $w_c$

Here we see the first implementation of the pwl model, since we will consider the following 2 approximations: $|wT|<<1$, $|wT|>>1$ $\implies$ $w<<1/|T|$, $w>>1/|T|$.
Then we have the two cases:
- $w<<w_c$

$$
\begin{align}
&\log|W(jw)|\approx\mu\log1=0 \\
&\arg(W(jw))\approx\mu\arg1=0^\circ
\end{align}
$$

- $w>>w_c$

$$
\begin{align}
&\log|W(jw)|\approx\mu\log wT=\mu(\log w+\log T)\\
&\arg(W(jw))\approx\mu\arg1=\mu\cdot\text{sign}(T)\cdot90^\circ
\end{align}
$$

From here it is clear that **real zeroes and poles behave in the same way, but with inverted sign**.

##### Amplitude plot
It will be $y=0$ until point $[\log w_c,0]$ (cutoff frequency) on the x-axis, then it will be a line going upwards (zero) or downwards (pole) with slope $\pm20 |\mu|[dB/\text{decade}]$.

>[!rmk|*] Zero in origin
>From here we can see that usually the slope goes upwards for zeroes, and downwards for poles. You can also apply this reasoning for Zeroes and Poles in the origin.

##### Phase Plot
The phase will be 0 until point $[\log (w_c) -1 ,0]$, then it will be a straight line connecting to the point $[\log(w_c)+1,\pm|\mu|\cdot90^\circ]$ if it is zero or pole. 
>[!col]
![[Pasted image 20241120123345.png|Bode diagram of W(s)=1+0,1s|300]]
>
>![[Pasted image 20241120123445.png|Bode diagram of W(s)=(1+0,1s)^-1|300]]

The phase plot has a wrong approximation, but from the real curve it is evident how the slope should be
## 5.5) Complex Conjugate Poles and Zeroes
Suppose we have 
$$
W(s)=\left(1+2\epsilon\frac{s}{w_n}+(\frac{s}{w_n})^2\right)^\mu
$$
Now we have:
$$\begin{align}
|W(jw)|_{dB}&=&10\mu\log\left[\left(1-\left(\frac{w}{w_n}\right)^2\right)+\left(2\epsilon\frac w{w_n}\right)^2\right] \\

\arg(W(jw))&=&\begin{cases}
\arctan\left(\frac{2\epsilon\frac{w}{w_n}}{1-\frac{w^2}{w_n^2}}\right), \ &w<w_n \\

\text{sign}(\epsilon)\cdot\frac\pi2, \ &w=w_n \\

\arctan\left(\frac{2\epsilon\frac{w}{w_n}}{1-\frac{w^2}{w_n^2}}\right)+\text{sign}(\epsilon)\cdot\pi, \ &w>w_n
\end{cases}
\end{align}$$

Now we can find the asymptotic approximations for $w<<w_n$, $w>>w_n$:
- $w<<w_n$

$$\begin{align}
&\log|W(jw)|\approx\mu\log 1=0 \\
&\arg(W(jw))=\mu \arg 1 =0^\circ
\end{align}
$$
- $w>>w_n$

$$\begin{align}
&\log|W(jw)|\approx2\mu\log(\frac{w}{w_n})=2\mu(\log w-\log w_n) \\
&\arg(W(jw))=\mu \cdot\text{sign}(\epsilon)\cdot\pi =\mu \cdot\text{sign}(\epsilon)\cdot180^\circ
\end{align}
$$
So we have find another case of **cutoff**.

Again we have that $\mu$ shows the number of poles or zeroes

##### Amplitude Plot
It will be zero until $[\log w_n,0]$, then it will be a line going upwards (zero) or downwards (pole) with slope $\pm40 |\mu|[dB/\text{decade}]$.
##### Phase Plot
The phase will be 0 until point $[\log (w_c) -1 ,0]$, then it will be a straight line connecting to the point $[\log(w_c)+1,\pm |\mu|\cdot180^\circ]$ if it is zero or pole.

![[Pasted image 20241120140000.png|Bode plot of W(s)=s^2+1.9s+1|450]]
Here the approximation of the phase is correct. Moreover in the example we have $w_n=1,\ \epsilon=0.95,\ \mu = 1$
## 5.6) How to Draw a Bode Diagram With Multiples Zeroes and Poles
It's actually pretty easy by recalling the **additive** property that was given at the start

##### Amplitude Plot
1) Draw every single line corresponding to every zero/pole/constant term
2) In the resulting plot, every point will have a slope corresponding to the sum of the slopes of every line in that point
3) add the constant value gain/attenuation

>[!example|*]
>This is a very dumb example, but consider
>$$W(s)=\frac{1-s}{1-s}$$
>This is clearly 1. And the bode plot will be a straight line of form $y=0$. But suppose we are a dumb student who doesn't notice this and applies every rule.
>1) Zero in 1, that means it gives 0 contribution until $[1,0]$ and then rises with slope $+20 [dB/\text{decade}^2]$ 
>2) Pole in 1, that is 0 contribution until $[1,0]$ and then goes downwards with slope $-20 [dB/\text{decade}^2]$ 
>3) Until $[1,0]$ there is no contribution, then after that point the 2 contributions are $\pm20[dB/\text{decade}^2]$ and thus $20-20=0[dB/\text{decade}^2]$
>
>Applying the rules gives the same result of the "direct" computation $\boxed{}$

##### Phase Plot

4) Draw every single line corresponding to every zero/pole/constant term
5) In the resulting plot, every point will have a slope corresponding to the sum of the slopes of every line in that point
6) When the phase has a constant attribution add\subtract it

# 6) Small Signal Regime Analysis
To give a quick idea of what this analysis represents imagine solving a circuit in dc. You find a result of how it functions (voltages, currents, operating regions) but you don't know how it handles information. The SSR is an oscillating voltage applied on top of ur DC signal and this is the actual transmitter of information. To solve a circuit we will first find how it operates (DC) and then, via some equivalent models, we will find how it behaves with AC current. We will see that transistors behave as amplifiers.

## 6.1) BJT Equivalent Models
PNP and NPN BJT's have the same equivalent model
![[Pasted image 20241218124547.png|BJT AC Equivalent Model|550]]
The three important parameters are:
$$\begin{align}
&g_m=\frac{I_C}{U_T}\approx40\cdot I_C \\
&r_{\pi}=\frac\beta{g_m} \\
&r_o=\frac{V_A+|V_{CE}|}{I_C}\approx\frac{V_A}{I_C}
\end{align}$$
## 6.2) MOSFET Equivalent Models
n and p- MOSFET have the same equivalent model *but with slightly different equations*.
![[Pasted image 20241218125415.png|MOSFET AC Equivalent Model|550]]

|                                            nMOSFET                                            |                                              pMOSFET                                              |
| :-------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------: |
|       $\displaystyle g_m=\frac{2I_D}{V_{GS}-V_{TH}}=\sqrt{2K_nI_D}=K_n(V_{GS}-V_{TH})$        |      $\displaystyle g_m=\frac{2I_D}{\|V_{GS}-V_{TH}\|}=\sqrt{2K_nI_D}=K_n\|V_{GS}-V_{TH}\|$       |
| $\displaystyle r_0=\frac1{g_m}\frac{1+\lambda V_{ds}}{\lambda I_D}\approx\frac1{\lambda I_D}$ | $\displaystyle r_0=\frac1{g_m}\frac{1+\lambda \|V_{ds}\|}{\lambda I_D}\approx\frac1{\lambda I_D}$ |
## 6.3) Integrated Circuits
This is the *juicy part*. Usually we can find more complex circuits that happen to behave in a way that can be approximated again by an amplifier. The list is quite long but it's quite repetitive in the end, just practice until you get a feel on how to solve the exercises.
### 6.3.1) Common Emitter, Common Source (CE, CS)
>[!col]
>![[Pasted image 20241218140315.png|BJT CE|350]]
>
>![[Pasted image 20241218140343.png|MOSFET CS|350]]

The equivalent model is the same for both but with different equations:
![[Pasted image 20241218140427.png|CE Equivalent Model|350]]

|            |                                                   BJT                                                    |                  MOSFET                   |
| :--------: | :------------------------------------------------------------------------------------------------------: | :---------------------------------------: |
|   $R_i$    |                     $r_\pi=\frac{\beta}{I_C}=\frac{\beta U_T}{I_C}=\frac{v_i}{i_i}$                      |                 $\infty$                  |
|   $G_m$    |                                    $g_m=\frac{I_C}{U_T}\approx40I_D$                                     |    $g_m=\frac{2I_D}{V_{OV}}=K_nV_{OV}$    |
| $R_\sigma$ | $r_o//R_C=\frac{v_\sigma}{i_\sigma}\|_{v_i}$ with $r_o=\frac{V_A+\|V_{CE}\|}{I_C}\approx\frac{V_A}{I_C}$ | $r_o//R_D$ with $r_o=\frac1{\lambda I_D}$ |
|  $A_{v0}$  |                                              $-G_mR_\sigma$                                              |              $-G_mR_\sigma$               |
| $i_\sigma$ |                                    $G_mv_i+\frac{v_\sigma}{R_\sigma}$                                    |                                           |

### 6.3.2) Common Emitter, Common Drain with Degenerative Resistance (CER, CSR)

### 6.3.3) Common Base, Common Gate (CB, CG)
>[!col]
>![[Pasted image 20241218141525.png|BJT CB|350]]
>
>![[Pasted image 20241218141549.png|MOSFET CB|350]]

The equivalent model is the same for both but with different equations:
![[Pasted image 20241218141638.png|CE Equivalent Model|450]]
This works under the **assumption** that $r_o>>R_C, \ r_o>>R_E$.

|     | BJT | MOSFET |
| --- | --- | ------ |
|     |     |        |
|     |     |        |
|     |     |        |
|     |     |        |
|     |     |        |

### 6.3.4) Common Collector, Common Drain (CC, CD)

### 6.3.5) Current Mirror
![[Pasted image 20250102111252.png|MOSFET Current Mirror|350]]
In this case we have that $I_o=mI_i$ with $m=\frac{K_{n_2}}{K_{n_1}}$ and it is usually 1. Both transistores are in **saturation.**
### 6.3.6) Differential Couple

### 6.3.7) Common Mode