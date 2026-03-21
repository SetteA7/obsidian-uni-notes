# 1) Recap
## 1.1) Wave Fundamentals
A harmonic sinusoidal wave is expressed as $$y(x,t)=A\cos(\frac{2\pi t}{T}-\frac{2\pi x}{\lambda}+\phi_0)=A\cos(\omega t-kx+\phi_0)$$
Where $\omega=\frac{2\pi}{T}=2\pi f \ [rad\cdot s^{-1}]$ is the angular frequency (often I will refer to it as $w$), and $k=\frac{2\pi}{\lambda} \ [m^{-1}]$ the wavenumber.

>[!thm|*] Phase Velocity
>Fix a height $y_0$ and follow it's progress. Therefore $y_0=A\cos(wt-kx+\phi_0)\rightarrow\arccos(\frac{y_0}A)=wt-kx+\phi_0=\text{constant}$.
>If we differentiate with respect to time we end up with the **phase velocity:**
>$$u_p=\frac\lambda T=f\lambda=\frac{2\pi f}k=\frac wk \ [m/s]$$
>This is the speed of propagation of the wave

In an EM wave the speed is equal to the speed of light. Notice that the frequency in our study case is fixed by the generator and thus $\lambda=c/f$.

This wave is the **carrier wave** and since it is periodic all it's values are known and doesn't contain information. To transmit information we need to modulate the carrier with the information signal. The information signal is given by some rectangular pulses of duration $T$.
By Fourier series expansion with the first 2 frequencies if we calculate the convolution the modulated signal will be given by various harmonics placed around the carrier frequency.
![[33704.png|Frequencies|550]]
To increase the bitrate we must shorten the length of the pulse. This requires more bandwidth.
![[43325.png|Bandwidth Requirements|550]]


#### Transmission Lines Intro
In a transmission line the signal propagates a distance $l$ with speed $c$. So there is a propagation time $\tau=l/c$ such that $V_A=V_0\cos(wt)\rightarrow V_B=V_0\cos(w(t-\tau))$. **Their difference depends on the wavelength** since it determines the minimum distance at which the amplitude is the same.

What matters is the ratio $\displaystyle\frac{f\cdot l}{c}$. If the ratio is $<<1$ the distance is negligible and therefore no noticeable delay, otherwise a delay is introduced. This is the main difference with the electrics circuit course where the circuit was much smaller than the wavelength.

>[!def|*] Lumped
>A circuit whose physical size is much smaller than the wavelength is said to be **lumped.**

## 1.2) Phasor Representation
In the sinusoidal regime it is advantageous to represent the single wave with a phasor, that is, the real part of a complex function associated to the real function. Keep in mind that $\displaystyle\Re z=\frac{z+z^*}2$

$$\begin{cases}
&v_g=V_0\cos(\omega t+\phi_0)=\frac{V_0}2e^{j(\omega t+\phi_0)}+\frac{V_0}2e^{-j(\omega t+\phi_0)} \\
&\Re [V_ge^{j\omega t}]=\frac{V_g}2e^{j\omega t}+\frac{V_g}2e^{-j\omega t} 

\end{cases}
\implies
V_g=V_0e^{j\varphi_0}\text{ is the phasor}$$
**The phasor is time independent** and contains all info of the domain function (phase and amplitude)

If we see the phasor as a single frequency and keeping in mind Fourier transforms it doesn't surpire us that the phasor of the integral and derivative are:
$$\begin{align}
&\frac{dv(t)}{dt}=\Re[jwV(w)] \\
&\int v(t)dt=\Re[\frac{V(w)}{jw}]
\end{align}$$

A load has **complex power** which is made of the active (real) and reactive (imaginary) part. **The active power is the average power on one period.**

Differential equations can be solved easily using phasors.

# 2) Transmission Line Theory
This chapter shows the *analytical theory*, but it is important to recontextualize this chapter when we introduce the smith table

A transmission line is made of 2+ conductors separated by an insulator. In this course we will learn the model for coaxial and two-wire lines. This theory can be also applied as a good approximation for other cables.
![[Pasted image 20250226162222.png|Coaxial and two-wire lines|650]]
Since we are supposing a long line, that is $\displaystyle\frac{f\cdot l}c\gtrapprox1$. We will model the electrical representation of the line as a series of lumped passive circuits. We can therefore define parameters per unit length (p.u.l): Series Resistance, shunt conductance, series inductance, shunt capacities.
![[29823.png|Electrical Model for One Lumped Component|550]]
## 2.1) How do signals (waves) behave in this circuit?
By applying Kirchhoff's laws for both voltage and current and dividing them by an infinitesimal distance (lumped) we derive the **telegraphist's equations**
$$\frac{\partial v(z,t)}{\partial z}=-R'i(z,t)-L'\frac{\partial i(z,t)}{\partial t}, \ \ \ \frac{\partial i(z,t)}{\partial z}=-G'v(z,t)-C'\frac{\partial v(z,t)}{\partial t}$$
[Proof.](#^060b47) ^18ca09

These forms can be rewritten as phasors. Moreover by taking the derivative we get the **telephone equations**
$$\frac{d^2 V(z)}{dz^2}-\gamma^2V(z)=0, \ \frac{d^2 I(z)}{dz^2}-\gamma^2I(z)=0$$
Where $\gamma=\sqrt{(R'+jwL')(G'+jwC')}=\alpha+j\beta$ is the **complex propagation constant** and depends on the geometry of the cable ^4331d6

One solution to the telegraphist's equations is the following:
$$\begin{align}
&V(z)=V_+e^{-\gamma z}+V_-e^{\gamma z}\\
&I(z)=I_+e^{-\gamma z}+I_-e^{\gamma z}=\frac{V_+}{Z_c}e^{-\gamma z}-\frac{V_-}{Z_c}e^{\gamma z}
\end{align}$$
[Proof.](#^99bf74)

Where $Z_c=\gamma/Y=\sqrt{\frac{R'+jwL'}{G'+jwC'}}$ is the **characteristic impedance**. $V_+, V_-$ are given by the current generator and the load impedance.
[Proof.](#^5ce037) ^45e5b3

This solution suggests the presence of 2 waves traveling in opposite directions ($u_p=\pm w/\beta$)which get attenuated the more they travel (by $e^{\pm\gamma z}$). This can be explained by a reflection of the em wave as it encounter the load.
$$v(t,z)=|V_+|e^{-\alpha z}\cos(wt-\beta z+\varphi_+)+|V_-|\cos(wt+\beta z+\varphi_-)$$
[Proof.](#^64a8b5) ^ab8f3a

>[!rmk] Ideal Case
>The ideal case is **lossless**, and thus $R'=G'=0$.
>Therefore $\gamma=jw\sqrt{L'C'}\rightarrow\alpha=0, \ \beta=w\sqrt{L'C'}$
>This means that there is no signal attenuation when propagating since $e^{\pm\alpha z}=1$.

It can also be shown **that** $1/\sqrt{L'C'}=1/\sqrt{\mu\epsilon}=c$
The minimum distance between two points is the wavelength and is given by $\lambda=2\pi/\beta$

A line of length $l$ has the origin $l=0$ at the load and at $-l$ the generator. The **load impedance** is given by $$Z_L=Z(0)=\frac{V(0)}{I(0)}=Z_C\frac{V_++V_-}{V_+-V_-}$$
And therefore we can define $V_-=\displaystyle V_+\frac{Z_L-Z_C}{Z_L+Z_C}$

#### Impedance and Reflection Coefficient
The impedance is a periodic function of position. We will use the **normalized impedance** 
$$z(-l)=\frac{Z(-l)}{Z_C}=\frac{z_L+j\tan(\beta l)}{1+jz_L\tan(\beta l)}$$
and clearly the normalized admittance $y(-l)=1/z(-l)$. These measures are unitless

The relationship between normalized impedance and reflection coeff. is:
$$\begin{align}
z(-l)=\frac{1+\Gamma(-l)}{1-\Gamma(-l)} \\
\Gamma(-l)=\frac{z(-l)-1}{z(-l)+1}
\end{align}$$

Two particular cases arise:
$$\boxed{\begin{align}
\Gamma_L=\Gamma(0)&=\frac{V_-}{V_+}=\frac{Z_L-Z_C}{Z_L+Z_C} \\
\Gamma(-l)&=\frac{V_-e^{-j\beta l}}{V_+e^{j\beta l}}=|\Gamma_L|e^{j\varphi_L}e^{-j2\beta l}
\end{align}}$$
We can notice the **half wave symmetries**
 $$\begin{align}
 z(-l\mp\lambda/2)&=z(-l) \\
 \Gamma(-l\mp\lambda/2)&=\Gamma(-l)
 \end{align}$$
 And also the **quarter wave symmetries:** with admittance
 $$z(-l\mp(2n+1)\lambda/4)=\frac 1{z(-l)}=y(-l)$$
## 2.2) Voltage and Current Behavior Along the Line
#### Traveling Wave
To have a traveling wave we must have $$\Gamma_L=0=\frac{Z_L-Z_C}{Z_L+Z_C}\iff Z_L=Z_C$$
If that occurs then the impedance is constant and we have just one wave (no reflected one). Moreover **the voltage and current phasors have constant modulus**
$$v(t)=|V_+|\cos(wt+\beta l+\varphi_+)$$
#### Totally Standing Wave
This is found if $|\Gamma|=1$. The 2 "easy" cases if that we have $Z_L=0$ or $Z_L\rightarrow\infty$.
A more interesting case if that we set $Z_L=jX$ purely imaginary. In this case the reflection coeff. has the complex conjugate of the numerator at the denominator, and thus it's abs value is 1. Then $|V_+|=|V_-|$.
The 2 waves will sovrappose and create a standing wave with nodes ($v=0$) separated by $\lambda/2$ and antinodes $v=V_{\pm}$ a distance of $\lambda/4$ from the nodes
![[Pasted image 20250317094935.png|Nodes and Antinodes|550]]
The phasor modulus will respect this:
$$|V(-l)|=|V_+||1-e{-j2\beta l}|$$
![[Pasted image 20250317095200.png|Phasor Nodes and Antinodes|550]]
The current will yield the same results but shifted by $\lambda/4$ and with a magnitude divided by $Z_C$

#### Partially Standing Wave
The general situation is a mix between the two previous cases , $|\Gamma_L|\in(0,1)$.
$$V(-l)=(|V_+|-|V_-|)e^{j\phi_+}e^{j\beta l}+|V_-|(e^{j\phi_+}e^{j\beta l}+e^{j\phi_-}e^{-j\beta l})$$
The first is a traveling wave of amplitude $|V_+|-|V_-|$, the second a standing wave of amplitude $2|V_-|$.

The maximum is a phasor translated by 1 on the real axis. The maximum is found when $-2\beta l + \phi_L=1$. Analogously the minimum is when the phase is $-1$
![[Pasted image 20250317100812.png|Max Phasor|450]]
with these values it is possible to define the **standing wave ratio (SWR)** as $$S=\frac{|V_{max}|}{|V_{min}|}=\frac{1+|\Gamma|}{1-|\Gamma|}\geq 1$$
#### Power
The important phenomenon in transmission lines is the power transfer from the generator to the load. We know the definition of complex power $P_c(-l)=\frac12V(-l)I^*(-l)=P+jQ$
The real part $P$, called **active power** is **constant along the line** and corresponds to the **avg power** which is a difference between the power of the generated wave and the reflected wave
$$P_L=\frac{|V_+|^2}{2Z_C}(1-|\Gamma_L|^2)$$

Exploiting the fact of constant real power is possible to determine also $V_{min/max}, I_{min/max}$ 
Recalling the half wave phase shift between currents and voltage the following relationship holds: $$\begin{cases}V_{Max}=Z_{Max}I_{min} \\ Z_{Max}=SZ_C\in\mathbb R\end{cases}\implies I_{min}=\frac{V_{Max}}{SZ_C}$$
And since the power is given by $VI^*$ we can write
$$P=\Re(\frac{V_{Max}I_{min}^*}2)=\Re(\frac{V_{Max}V_{Max}^*}{2Z_{Max}^*})=\frac{|V_{max}|^2}{2SZ_c}$$ Analogously $$P=\frac{SZ_C|I_{min}|^2}{2}$$

#### Special Cases
##### Line terminates on $Z_L=0$: Stub
Due to the short circuit the current isn't stopped. Logically this would result in a reflection coeff of -1
$$V(0)=|V_+|\cdot 1+V_-|\cdot 1\implies V_+=-V_-\implies \Gamma_L=-1$$
Most importantly, by choosing the right length it is possible to create any imaginary impedance
$$Z(-l)=jZ_C\tan(\beta l)=jX(-l)$$
##### Line terminating on $Z_L\rightarrow\infty$ 
In this case the current is null at the load
$$I(0)=\frac{V_+-V_-}{Z_C}=0\implies \Gamma_L=1$$
Most importantly, by choosing the right length it is possible to create any imaginary impedance
$$Z(-l)=jZ_C\cot(\beta l)=jX(-l)$$
##### Fixed Length 
Here 2 special cases arise:
1) Multiples of $\lambda/2$: $Z_{in}=Z(-l)=Z(-n\lambda/2)=Z_L$
2) Odd multiples of $\lambda/4$: $Z_{in}=Z(-l)=Z(-(2n+1)\lambda/4)=\frac{Z_C^2}{Z_L}$

##### Changing characteristic impedance

^c36e3a

By supposing that the line doesn't reflect, we can find a reflection coeff at the change point
$$\Gamma=\frac{Z_1-Z_0}{Z_1+Z_0}$$
The transmission coefficient, that is the part of the wave that is not reflected is
$$T=1+\Gamma=\frac{2Z_1}{Z_0+Z_1}$$

#### Maximum Power Transfer
To transmit the maximum power we must have $Z(-l)=Z_g^*$. From now on this condition is assumed.
Moreover, since $V_+$ depends on both load and generator, we must set $\boxed{Z_g=Z_C}$ to have the incident wave dependent only by the generator. $$V_+=\frac{V_g}2e^{-j\beta l}$$
Under these conditions we have maximum delivered power.
$$P=\frac18\frac{|V_g|^2}{Z_C}$$

We must also consider the **non distortion conditions**, that is, we want $\beta$ to have linear behaviour with frequency. This is possible only if $\boxed{Z_L=Z_C}$. By keeping in mind the maximum power delivery, it is clear that $Z_L=Z_C=Z_g$ isn't easily obtainable.

#### Matching
##### Quarter Wave Transformer
Suppose to have a line with $Z_1$. Let's add a quarter wavelength line of impedance $Z_2$ with purely resistive load. This can be achieved by adding the line at distance $d$ from the load in order to guarantee real impedance.
![[Pasted image 20250329151803.png|Example|450]]
By choosing a point of real impedance (call $Z_R=Z(-d)\in \mathbb R$):$$Z_{in}=\frac{Z_2^2}{Z_R}$$
Two cases arise:
1) $z=-d$ is a point of voltage maximum ($Z(-d)=SZ_1$) $$Z_2=Z_1\sqrt S\rightarrow S'=\sqrt S$$
2) $z=-d$ is a point of voltage minimum ($Z(-d)=Z_1/S$) $$Z_2=Z_1/\sqrt S\rightarrow S'=1/\sqrt S$$
This transformer can be inserted by calculating $d$ and then $Z_2$

This makes it so that $Z_{01}=Z_{in}$ and therefore the feedline has a traveling wave (keep in mind there is a [change in characteristic impedance](#^c36e3a)).

##### Admittance Stub
In this case we insert a stub at distance $d$ such that the normalized admittance is $y(-d)=1+jb$. By exploiting the stub we must create it such that it's load impedance is $y_s(-l)=j\frac1{\tan\beta l}=jb_s=-jb$. Keep in mind that the stub has $Z_L=0\implies Y_L\rightarrow\infty$

![[Pasted image 20250329153207.png|Example|450]]
This transformer can be inserted by calculating $d$ and then $l$ of the stub

This works by having $y(-d_1)=1\implies z(-d_1)=1\implies Z(-d_1)=Z_C$ and therefore there is a standing wave
## 2.3) Smith Chart
We will develop a tool that is capable of telling **magnitude, phase and displacement** of the reflection coefficient.

![[Pasted image 20250317153609.png|Smith Chart|650]]

Any dissipative load can be mapped into it's complex plane $\Re[r_L],\Im[z_L]$ but plotting it's transformations is quite difficult. Since the value can also be calculated with the reflection coeff, we notice that it's transformations in his plane are more consistent they are always circles:
- **Clockwise rotation if moving TO the generator**
- **Counterclockwise rotation if moving AWAY from the generator**
It is possible to define a circle for any real and imaginary part of the load. They follow the equations:
- Real: Center $\frac{r_L}{1+r_L},0$. Radius $R=1/1+r_L$
- Imaginary: Center $1, 1/x_L$. Radius $1/|x_L|$
[Proofs.](#^3b2378)

#### Reading the Information
Once the (normalized) load is known, the intersections of the two circles corresponds to our reflection coefficient. The circles are labeled.
- The **magnitude** either by the formula $\boxed{|\Gamma|=|\frac{Z_L-1}{Z_L+1}|=\frac{S-1}{S+1}}$ or by measuring the distance from the origin.
- The **displacement** can be read by extending the modulus vector to the outer circles. Here the outer circle shows the normalized displacements towards the generator, the adjacent circle is the displacement towards the load
- The **phase** is measured analogously in the inner circles
- The **standing wave ratio (SWR)** can be found by looking at the circumference with radius $|\Gamma|$ and center in origin. Its intersection on the right part of the real axis is $P_{max}=S$ or $P_{min}=1/S$

The upper half corresponds to inductive reactances ($x_L>0$), the lower half capacitive reactances $x_l<0$. The x axis is a real impedance (no phase/displacement) $x_L=0$.

One entire rotation corresponds to a half normalized wavelength translation. Due to the symmetry this allows us to have a full picture of the line. Moreover the antipodes of two a point is it's quarter wavelength corresponding point. It is also possible to find the **admittance** by considering the same $180^\circ$ rotaion, since $z(-\Gamma)=y(\Gamma)$ 

Remark: Maximum Voltage (minimum Current) is found with the highest (right side) real impedance. The minimun Voltage (Max current) is found at the minimum real impedance (left side).

# 3) Plane Waves
Now we aren't limited to a cable, but we extend our waves to the entire cartesian reference frame, where our electric field in one point is defined by:
$$\vec e(x,y,z,t)=\vec e(\vec r, t)=e_x(\vec r, t)\hat x + e_y(\vec r, t)\hat y+e_z(\vec r, t)\hat z$$
where $\vec r =x\hat x+y\hat y+z\hat z$ is the position vector

Since we are considering an harmonic case we can use the phasor representation:
$$\vec E(\vec r)= \sum_{i=x,y,z}A_i(\vec r)e^{j\varphi_i(\vec r)}\hat i$$
where clearly $\vec e (\vec r,t)=\Re\{\vec E(\vec r,w)e^{jwt}\}$.

## 3.1) Maxwell Equations
Before writing the maxwell equations, let's recall some important values:
![[Pasted image 20250423133227.png|values|550]]
Moreover we also have the following relations: $$\mathcal{\vec B}=\mu \mathcal {\vec H}, \ \mathcal{\vec D}=\varepsilon \mathcal {\vec E}, \ \mathcal{\vec J}=\sigma \mathcal {\vec E}$$
where $\mu$ is the **relative permeability**, $\varepsilon$ the **relative permittivity** and $\sigma$ the **medium conductivity**. 
Moreover the speed of propagation is given by $c=1/\sqrt{\varepsilon\mu}=c_0/n$ with $n=\sqrt{\varepsilon_r\mu_r}$ the **refractive index**.

**Integral Form:**
$$\begin{align}
&\text{Gauss Law 1: } &&\oint_S\mathcal{\vec D}\cdot \hat n dS=\int_V\rho dV \\
&\text{Gauss Law 2: } &&\oint_S\mathcal{\vec B}\cdot \hat n dS=0 \\
&\text{Faraday Law: } &&\oint_C\mathcal{\vec E} \cdot d\vec l=-\frac{\partial}{\partial t}\int_S\mathcal{\vec B}\cdot\hat ndS \\
&\text{Ampere-Maxwell Law: } &&\oint_C\mathcal {\vec H}\cdot d\vec l=\int_S\mathcal{\vec J}\cdot\hat n dS+\frac{\partial}{\partial t}\int_S\mathcal{\vec D}\cdot d\vec l
\end{align}$$
**Differential Form:**
$$\begin{align}
&\text{Gauss Law 1: } &&\nabla\cdot\mathcal{\vec D}=\rho\\
&\text{Gauss Law 2: } &&\nabla\cdot\mathcal{\vec B}=0 \\
&\text{Faraday Law: } &&\nabla\cdot\mathcal{\vec E} =-\frac{\partial \mathcal{\vec B}}{\partial t} \\
&\text{Ampere-Maxwell Law: } &&\nabla \cdot\mathcal {\vec H}=\mathcal{\vec J}+\frac{\partial \mathcal{\vec D}}{\partial t }
\end{align}$$
**Complex Vectors (phasors):**
$$\begin{align}
&\text{Gauss Law 1: } &&\nabla\cdot\mathcal{\vec D}=\rho\\
&\text{Gauss Law 2: } &&\nabla\cdot\mathcal{\vec B}=0 \\
&\text{Faraday Law: } &&\nabla\times{\vec E} =-j\omega\mu\vec H \\
&\text{Ampere-Maxwell Law: } &&\nabla \times {\vec H}=j\omega\varepsilon\vec E+\vec J
\end{align}$$
The case where $\sigma\not = 0$ arises. in that case we have $\nabla\times\mathcal{\vec H}=j\omega\varepsilon\vec E+\sigma\vec E=j\omega(\varepsilon-j\frac{\sigma}{\omega})\vec E$. where $\varepsilon_C=\varepsilon(1-j\frac{\sigma}{\omega \varepsilon})$ is the **complex dielectric permittivity.**  If $\sigma>>\omega\varepsilon$ we have a good electric *conductor*, if $\sigma<<\omega\varepsilon$ we have a good electric *insulator*.

**Continuity Conditions at The Interface of 2 Media:** ^56b7f6
$$\begin{align}
&D_{2n}-D_{1n}=\rho_S \\
&B_{2n}=B_{1n} \\
&H_{2t}-H_{1t}=J_S \\
&E_{2t}=E_{1t}
\end{align}$$
[Proof.](#^10c3dc)
where if there are no electric charges / currents (insulating media) $\rho_S$ and $J_S$ are 0.
![[Pasted image 20250423140614.png|Representation|450]]
The perpendicular component of $E$ is conserved, and the parallel component of $B$ is also conserved

## 3.2) Helmholtz's Equations:
The Helmholtz's equations are one solution of Maxwell's laws for waves in homogeneous, linear and perfect insulator medium. 
$$\begin{cases}
\nabla^2\vec E+k^2\vec E=0 \\
\nabla^2\vec H+k^2\vec H=0 \\
\end{cases}$$
where $k=\omega\sqrt{\mu\varepsilon}$ is the **propagation constant/phase constant/wavenumber**.

By supposing a source with spherical waves, due to Huygens principle we can approximate the waves at a great distance as **plane waves.** 
$$\begin{align}
&\vec E(\vec r)=\frac{\nabla \times\vec H}{j\omega\varepsilon} =\eta \vec H\times \vec k\\
&\vec H(\vec r)=\frac j{\omega\mu}\nabla\times\vec E=\frac{\hat k\times \vec E}{\eta}
\end{align}$$

The curl was calculated by finding the determinant of:
$$
\begin{bmatrix}
\hat x & \hat y & \hat z\\
\frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z}\\
A_x(r) & A_y(r) & A_z(r)\\
\end{bmatrix}$$
Moreover usually the result will have a constant of type $\displaystyle\frac{k}{\omega\varepsilon}=1/\eta$ or $\displaystyle\frac{k}{\omega\mu}=\eta$.  Where $\eta=\sqrt{\mu/\varepsilon}=\eta_0\sqrt{\mu_r/\varepsilon_r}$ with $\eta_0=120\pi\approx377 \ [\ohm]$.

But $\eta$ might be unknown. Don't be scared it can be easily found since we can rewrite $\displaystyle\eta=\eta_0\sqrt{\frac{\mu_r}{\varepsilon_r}}=\frac{\eta_0}n$ and $\boxed{\displaystyle n=\frac{c_0}{\lambda f}=\frac{k c_0}{2\pi f}}$

By supposing E on x and y plane:
$$\vec H=H_x\hat x+H_y\hat y, \
\begin{cases}
\displaystyle H_x=-\frac{k}{\omega\mu}E_y \\
\displaystyle H_y=\frac{k}{\omega\mu}E_x
\end{cases}$$

The general solution will be the following:
$$\vec H=\frac{\hat k\times \vec E}{\eta}$$
where $\hat k$ is the direction of propagation $\displaystyle\eta=\frac{E_x^+}{H_y^+}=\sqrt{\frac{\mu}{\varepsilon}}$
[Proof.](#^55956f) ^4ce214

## 3.3) Power 
Prior to talking about power, let's understand what the modulus of a complex vector is:
**The mean value of the square of a sinusoidal quantity is equal to half of the squared modulus of its complex vector**
$$<\mathcal E^2>=\frac12|E|^2$$
[Proof.](#^4bcc9d) ^eb2785

#### Poynting Vector
By some algebraic manipulation on maxwell equations we get to a **power balance equation of the EM field:**
$$-\frac12\int_V\vec E\cdot\vec J^*dV=\frac12\oint_S\vec E\times\vec H\cdot \hat ndS+\frac\sigma2\int_V|E|^2dV+j\frac\omega2\int_V\mu|\vec H|^2-|\vec E|^2dV$$
[Proof.](#^54b374) ^e758b4

##### 1st Term: Power supplied by generator
This term is a complex number, that is there is **active and reactive power**. Where the active power is the **time average of the power**
##### 2nd Term: Poynting Vector
We define the poynting vector as $$\vec S=\frac{\vec E \times \vec H^*}2$$this represents the power density transported by the EM field. In particular the **real part provides the intensity and direction of the avg surface power density carried by the EM field**
##### 3rd term: Active power dissipated on conductors
This is given due to joule effect 
##### 4th Term: Reactive Energy Density
This term is complex and represents an energy density since it is $J/m^3$ and is associated to the *mean* magnetic/electric energy. It is positive if inductive, or negative if capacitive

## 3.4) Wave Polarization (sinusoidal regime)
Polarization of a uniform plane wave is defined as the closed curve described by the tip of the vector $\vec e(t)$ in the plane orthogonal to the direction of propagation at a certain point in space as time varies.

In general the curve will be an **ellipse** with the special cases of **linear and circular** polarizations. 

By looking at the complex vector of $\vec E$ and keeping in mind that $E_{x0}=a_xe^{j\varphi_x}$ and $E_{y0}=a_ye^{j\varphi_y}$
$$\vec E=E_x\hat x+E_y\hat y=E_{x0}e^{-jkz}\hat x+E_{y0}e^{-jkz}\hat y = (a_x\hat x+a_ye^{j\varphi}\hat y)e^{-jkz}$$
where in the last step we assumed $\varphi=\varphi_y-\varphi_x$ and $\varphi_x=0$.
The corresponding domain vector is:
$$\vec e (t,z)=a_x\cos(\omega t -kz)\hat x+a_y\cos(\omega t-kz +\varphi)\hat y$$
and it has the following modulus and phase:
$$\begin{align}
&|\vec e(t,z)|=\sqrt{a_x^2\cos^2(\omega t - kz)+a_y^2\cos^2(\omega t - kz+\varphi)} \\
&\psi(t,z)=\arctan\left(\frac{e_y(z,t)}{e_x(z,t)}\right)
\end{align}$$

#### Linear Polarization
Linear polarization happens when 
$$\begin{align}
\text{In-phase: }&\varphi=0\\ 
\text{Out-of-phase: }&\varphi=\pi
\end{align}$$
In the **out-of-phase** case the vector traces the path $(a_x,-a_y)\rightarrow(-a_x,a_y)$ all on the same plane $\perp$ to $z$. This plane is called **polarization plane.**
We have $$\begin{align}
&\vec E=(a_x\hat x-a_y\hat y)e^{-jkz}\rightarrow \vec e(t,z)=(a_x-a_y)\cos(\omega t)
\end{align}$$
And therefore:
$$\begin{align}
&|\vec e(t,z)|=\sqrt{a_x^2+a_y^2}\cos(\omega t) \\
&\psi(t,z)=\arctan\left(\frac{-a_y}{a_x}\right)
\end{align}$$
#### Left Handed Circular Polarization
This happens when
$$\begin{align}
&a_x=a_y=a \\
&\varphi=\frac\pi2
\end{align}$$
Therefore we have:$$\begin{align}
&\vec E=a(\hat x+j\hat y)e^{-jkz}\rightarrow\vec e(t,z)=a\cos(\omega t -kz)\hat x-a\sin(\omega t -kz)\hat y
\end{align}$$
>[!col]
>this was done by keeping in mind that $$\begin{align}\Re(jae^{-jkz})&=\Re(ae^{j\pi/2}e^{-jkz})\\&=a\cos(\omega t-kz+\pi/2)\\&=a\sin(\omega t-kz)\end{align}$$
>$$ $$
>By placing the thumb parallel to $\hat z$ it is possible to see how $\vec E$ rotates by looking at where the hand closes. (See Image)
>
>![[Pasted image 20250424110857.png|LHC Polarization|250]]

From here we have:
$$\begin{align}
&|\vec e(t,z)|=|a| \\
&\psi(t,z)=\arctan\left(\frac{-a\sin(\omega t-kz)}{a\cos(\omega t-kz)}\right)=-(\omega t -kz)
\end{align}$$
#### Right Handed Circular Polarization
This happens when
$$\begin{align}
&a_x=a_y=a \\
&\varphi=-\frac\pi2
\end{align}$$
Therefore we have:$$\begin{align}
&\vec E=a(\hat x-j\hat y)e^{-jkz}\rightarrow\vec e(t,z)=a\cos(\omega t -kz)\hat x+a\sin(\omega t -kz)\hat y
\end{align}$$
>[!col]
>
>$$ $$
>By placing the thumb parallel to $\hat z$ it is possible to see how $\vec E$ rotates by looking at where the hand closes. (See Image)
>
>![[Pasted image 20250424111314.png|RHC Polarization|250]]

From here we have:
$$\begin{align}
&|\vec e(t,z)|=|a| \\
&\psi(t,z)=\arctan\left(\frac{-a\sin(\omega t-kz)}{a\cos(\omega t-kz)}\right)=(\omega t -kz)
\end{align}$$
#### Elliptical (Generic) Polarization
The general case doesn't fix a specific value for $\varphi$ and therefore the superposition of effects doesn't create a symmetric case:
![[Pasted image 20250424111504.png|Elliptical Polarization|]]
## 3.5) Propagation in a Lossy Medium
In this case the equation becomes $$\nabla^2\vec E^2-\gamma^2\vec E=0$$
where the propagation constant $\gamma=\alpha+j\beta$ becomes a complex quantity. This is due to how the **complex permittivity** is defined:
$$\begin{align}
&\varepsilon_c=\varepsilon_{re}-j\varepsilon_{im}=\varepsilon_{re}-j\frac\sigma\omega\rightarrow\gamma^2=(\alpha+j\beta)^2=\omega^2\mu\varepsilon_c \\
&\implies \begin{cases}
\alpha=\omega\left\{\sqrt{1+\frac{\varepsilon_{im}}{\varepsilon_{re}}^2}-1\right\}^\frac12 \\
\beta=\omega\left\{\sqrt{1+\frac{\varepsilon_{im}}{\varepsilon_{re}}^2}+1\right\}^\frac12
\end{cases}
\end{align}$$
>[!def] Penetration Depth
>We define the **penetration depth** as the distance where the field modulus is attenuated by $1/e$
>$$\delta_S=\frac{1}{\alpha} \ [m]$$
>This is found by setting $$E(d)=E_0e^{-d/\delta_s}$$

there is the **special case of a good conductor** $\sigma>>\omega\varepsilon\implies\varepsilon_{re}\approx0$ this yields to the following results:
$$\begin{align}
&\alpha=\beta=\sqrt{\frac{\mu\sigma}{2\omega}}=\sqrt{\pi f \mu \sigma} \\
&\delta_S=\frac{1}{\sqrt{\pi f \mu \sigma}} \\
&\eta_c=\frac{1+j}{\sigma\delta_S}
\end{align}$$
Where to be a good conductor we must have values around
$$\sigma\approx 10^7 \ [\ohm^{-1}m^{-1}], \ \space  \ f<<2\cdot10^{17} \ [Hz]$$


# 4) Reflection, Refraction and Optical Fibers
Before heading into optical fibers, we must first understand reflective and refractive phenomena.

A **normally incident** plane wave at the interface of two mediums will be separated into a refracted(transmitted) and a reflected wave. **The sum of the energy of two waves will be the same as the incident one.**

Let's write the expressions:
$$\begin{align}
&\vec E_i(z)=E_0^ie^{-jk_1z}\hat x &&\vec H_i(z)=+\frac{E_0^i}{\eta_1}e^{-jk_1z}\hat y \\
&\vec E_r(z)=E_0^re^{+jk_1z}\hat x &&\vec H_r(z)=-\frac{E_0^r}{\eta_1}e^{jk_1z}\hat y \\
&\vec E_t(z)=E_0^te^{-jk_2z}\hat x &&\vec H_t(z)=+\frac{E_0^t}{\eta_2}e^{-jk_2z}\hat y
\end{align}$$
where $k_n=\omega \sqrt{\mu_n\varepsilon_n}$ and $\eta_n=\sqrt{\mu_n/\varepsilon_n}$.
![[Pasted image 20250430151634.png|Representation|450]]
The field in medium 2 is already given, but the one in medium one is obtained as the superposition of the incident and reflected ones:
$$\vec E_1(z)=(E_0^ie^{-jk_1z}+E_0^re^{+jk_1z})\hat x \ \space \ \vec H_1(z)=\frac1{\eta_1}(E_0^ie^{-jk_1z}-E_0^re^{jk_1z})\hat y$$
By the continuity conditions, all tangent components are continuous at the interface and therefore we can define the reflection and refraction coefficients:
>[!def] Reflection and Refraction Coefficients
>We define the reflection coefficient as
>$$\Gamma=\frac{E_0^r}{E_0^i}=\frac{\eta_2-\eta_1}{\eta_2+\eta_1}=\frac{n_2-n_1}{n_2+n_1}$$
>And the refraction coefficient as:
>$$\tau=\frac{E_0^t}{E_0^i}=\frac{2\eta_2}{\eta_1+\eta_2}=\frac{2n_2}{n_1+m_2}=\Gamma+1$$

By finding the phase of $\Gamma$ we can rewrite the field in medium 1 as:
$$\vec E_1(z)=E_0^ie^{-jk_1z}(1+|\Gamma|e^{j\varphi_\Gamma}e^{j2k_1z})\hat x \ \space \ \vec H_1(z)=\frac{E_0^i}{\eta_1}e^{-jk_1z}(1-|\Gamma|e^{j\varphi_\Gamma}e^{j2k_1z})\hat y$$

>[!rmk|*] TODO
>A negative reflection coefficient is possible. This implies that the wave gets reflected "upside down". Keep in mind that (supposing 0 phase) $\Gamma=-|\Gamma|$ and an expreession of type $E_1=E(1+\Gamma)=E(1-|\Gamma|)$ is a actually a minima

Let's study the **modulus**:
From the phasors associated to the fields it is clear that there is a maximum and minimum for each field:
$$\begin{align}
&|\vec E_1|_{Max}=|E_0^i|(1+|\Gamma|) &&|\vec E_1|_{min}=|E_0^i|(1-|\Gamma|)\\
&|\vec H_1|_{min}=|\frac{E_0^i}{\eta_1}|(1-|\Gamma|) && |\vec H_1|_{Max}=|\frac{E_0^i}{\eta_1}|(1+|\Gamma|)
\end{align}$$
These have a periodicity of $2\pi$ ($\lambda_1/2$) and most importantly occur simultaneously ($E_{Max}\iff H_{min}$)
![[Pasted image 20250430153053.png|Phasor Representation|450]]
By calculating the **poynting vector** and finding it's **real/active part** we get:
$$\Re[\vec S_1\cdot\hat z]=P[E_i]-P[E_r]=\frac{|E_0^i|^2}{2\eta_1}-\frac{|E_0^i|^2}{2\eta_1}|\Gamma|^2=\frac{|E_0^i|^2}{2\eta_1}(1-|\Gamma|^2)$$
which is **independent from z**: **The flux of the active power is conserved**

In medium 2 we have the exact same result $\Re[\vec S_1\cdot\hat z]=\Re[\vec S_2\cdot\hat z]$

$$\begin{align}
&\text{Avg. Incident Power Density: } &&\frac{E_0^i}{2\eta_1} \\
&\text{Avg. Reflected Power Density: } &&\frac{E_0^i}{2\eta_1}|\Gamma|^2 \\
&\text{Avg. Transmitted Power Density: } &&\frac{E_0^i}{2\eta_1}(1-|\Gamma|^2)
\end{align}$$

## 4.1) Snell's Law
This law allows us to calculate the angle at which waves get reflected/refracted if they are not perpendicular to the interface.

>[!col]
>In general:$$\begin{align}
&\theta_i=\theta_r\\
&\frac{\sin(\theta_t)}{\sin(\theta_i)}=\sqrt\frac{\mu_1\varepsilon_1}{\mu_2\varepsilon_2}\\
\end{align}$$
>In non-magnetic medium ($\mu=\mu_0$):$$n_1\sin(\theta_i)=n_2\sin(\theta_t)$$
>The **critical angle** is the angle where there is only reflection $|\Gamma|=1$. This is possiblo only if medium 2 is LESS dense than 1
>
>
>![[Pasted image 20250430160036.png|Representation|250]]
## 4.2) Total Reflection (Simplified Theory)
We will consider the following model of a fiber cable
![[Pasted image 20250519111935.png|Optical Fiber|450]]
Critical angle for internal reflection:$$\theta_{cr}=\arcsin(n_c/n_f)$$
Angles that satisfy total reflection: $$\sin(\theta_3)=\cos(\theta_2)\geq n_c/n_f$$
Attenuation:
$$a=a_{0}\cdot d\ [dB], \ \space \ P=P_0\cdot 10^{a/10},\ \space \ a=\log_{10}(P/P_0)$$
In a multimode fiber the longest path is the one launched with the critical angle:
$$l_{max}=\frac l{\cos(\theta_2)}=l\frac{n_f}{c_f}$$
Recall that the speed in the core is $c_f=c/n_f$. The delay between the fastest and slowest beam is given by:$$\tau=\frac{l_{Max}-l_{min}}{c_f}=\frac{l(\frac{n_f}{n_c}-1)}{c_f}=l\frac{n_f}{c_0}\left(\frac{n_f}{n_c}-1\right)$$
# 5) Antennas
We will study antennas in a lossless conductor ($\sigma=0$, air or vacuum). Antennas work by havinga  known current density $\vec J_i$ in the solution of Maxwell's equations
$$\begin{align}
&\nabla\times\vec H=j\omega\varepsilon\vec E+\vec J_i\\
&\nabla\vec E=-j\omega\mu\vec H
\end{align}$$
The solution consists of 2 steps:
1) Solve the equation for an infinitesimal current element called dipole
2) Since the equations are linear we can find the field related to $\vec J_i$ as an integral of the dipole solution
## 5.1) Dipole
We define the current of a dipole with the use of the dirac delta:
$$\vec J_i=I\delta(x)\delta(y)f(z)\hat z, \ \space \ f(z)=\begin{cases}1, & |z|\leq\Delta z/2\\0, & |z|\geq\Delta z/2\end{cases}$$
This dipole is the center of our reference system. Since the waves are emitted circularly it is possible to use a spherical reference system:
- $\hat r$ is the radial component, $\perp$ to the sphere surface, it exits the surface
- $\hat\varphi$ is the rotation on the x,y plane, it is tangent to the sphere surface
- $\hat\theta$ is the rotation on the z,y plane, it is tangent to the sphere surface
>[!todo] Where the order is $r,\theta,\varphi$

![[Pasted image 20250519115048.png|Reference System|250]]
We obtain the following solution
$$\begin{align}
&E_r=\eta\frac{I\Delta z}{4\pi}\left(jk+\frac 1R+\frac{1}{jkR^2}\right)\sin(\theta)\frac{e^{-jkR}}{R} \\
&E_\theta=\eta\frac{I\Delta z}{2\pi}\left(0+\frac 1R+ \frac1{jkR^2}\right)\cos(\theta)\frac{e^{-jkR}}{R}\\
&H_\varphi=\frac{I\Delta z}{4\pi}\left(jk+\frac 1R+0\right)\sin(\theta)\frac{e^{-jkR}}{R}
\end{align}$$
Where we can clearly distinguish 4 main features:
1) The last term is the s**pherical wave** that decreases with R
2) The term with $1/R^2$ ($1/R$ for $H$) is the **near field**, that is, this term dominates the wave behaviour with small values of $R$
3) The term with $jk$ (no term for $E_r$) is the **far field**, that is, the terms that ddominate for high values of $R$
4) the radial component is null at $\cos(\theta)=0$

Let's calculate the poynting vector:
$$\vec S=\frac{\vec E\times\vec H^*}2=\frac{E_\theta H_\varphi^*\hat r-E_rH_\varphi\hat \theta}2$$
And the flux through a sphere of fixed radius:
$$P_{rad}+jQ_{rad}=\int_S\vec S\cdot\hat r dS=\frac\pi3\eta|I|^2\left(\frac{\Delta z}{\lambda}\right)^2\left[1-j\left(\frac\lambda{2\pi R}\right)^3\right]$$
As before $Q_{rad}$ is negligible if $R>>\lambda$.

## 5.2) Transmission parameters
Recall that we have found $P_{rad}$ of a dipole. By recalling the expression of the Dissipated power ina resistance $P=R|I|/2$ we obtain:
$$P_{rad}=\frac\pi3\eta |I|^2\left(\frac{\Delta z}\lambda\right)^2=R_{rad}\frac{|I|^2}2\rightarrow R_{rad}=\frac{2\pi}3\eta\left(\frac{\Delta z}\lambda\right)^2$$
The physical meaning of $R_{rad}$ is that it is the fictious resistance to dissipate $P_{rad}$ with current $|I|$ flowing

By looking at the far field (plane wave) we can calculate
$$S(R,\theta)=\left(\frac{\eta k^2|I|^2z^2}{32\pi^2R^2}\right)\sin^2(\theta)\rightarrow \overline S=S\hat r$$
We can define the **radiation intensity** the ratio between the power density at distance R and the maximum:
$$F(\theta,\phi)=\frac{S(R,\theta,\phi)}{S_\max}\stackrel{\text{dipole}}\rightarrow F(\theta,\phi)=\sin^(\theta)$$
We can define the **directivity** of the antenna as the ratio between the max of normalized rad intensity (1) and the avg value of $F$. An **isotropic antenna** would have $D=1$ but no such antenna exists.
$$D=\frac1{\displaystyle\frac1{4\pi}\int\int_{4\pi}Fd\Omega}$$
For a dipole we have (recall $d\Omega=R^2\sin(\theta)d\theta d\phi$)
$$D=\frac{4\pi}{\int_0^{2\pi}d\phi\int_0^\pi\sin^3\theta d\theta}=1.5\approx1.76 [dB]$$
We can also say that $$D=\frac{4\pi R^2S_\max}{P_{rad}}$$
We define the **Antenna power Gain** as the active power entering the antenna terminals
$$G=\frac{4\pi R^2S_\max}{P_{t}}\text{ where }P_t=P_{rad}+P_{diss}$$
And from here the **radiation efficiency** as the ratio between the radiated and supplied power
$$\zeta=\frac{P_{rad}}{P_t}=\frac{R_{rad}}{R_{rad}+R_{diss}}$$
And it is clear that $$\boxed{G=\zeta D \text{ and }S_\max=\frac{GP_t}{4\pi R^2}}$$
## 5.3) Receiving Parameters: Effective Area
Again at great distance we can consider the wave to be planar and therefore to have constant electric field on the antenna

Define **effective area**$$A_e=\frac{P_{rec}}{\displaystyle\frac{|\vec E_i|^2}{2\eta}}$$
With $P_{rec}$ the maximum transferred power and $\vec E_i$ the measured electric field where the antenna should be. If the pointing is optimal we have that $$P_{rec}=A_eS_\max=A_e\frac{GP_t}{4\pi R^2}$$
The maximum conditions means that the two lobes are facing the position of the other antenna in order to avoid current induction. With optimal pointing $l//\vec E$ and therefore there is no current induction.

>[!thm] Reciprocity Theorem
Under optimal pointing if we exchange the role of transmitter and reciever with the same supply power we have that$$A_{e2}G_1=A_{e1}G_2\rightarrow\frac{A_{e1}}{G_1}=\frac{A_{e2}}{G_2}=\text{const}$$
>And finally also
>$$A_e=G\frac{\lambda^2}{4\pi}\rightarrow P_{rec}P_tG_1G_2\left(\frac{\lambda}{4\pi R}\right)^2$$



## 5.4) Radiation Diagrams
These diagrams are helpful to see the radiated power density in a said direction (2D graph one angle is fixed).
>[!col]
>Here it is clear that the dipole propagates the maximum power on the xy plane ($\theta$=0). We call this dipole to be **omnidirectional** on this plane.
>$$ $$
>Moreover it is clear that in the z direction (current direction) the power density is null
>$$ $$
>If we instead represent it in polar coordinates it is clear where the best propagation directions are
>
>![[Pasted image 20250523190136.png|Diagrams|350]]

Some strongly oriented antennas use $F_{dB}=10\log_{10}F$ the logarithmic scale.
# 6) Proofs

## 6.1) Recap
No proofs for this chapter!
## 6.2) Transmission Lines
#### Telegraphist's Equations

^060b47

[Theory Chapter.](#^18ca09)

Kirchhoff Laws:
$$\begin{align}
&v(z,t)-R'\Delta z\cdot i(z,t)-L'\Delta z\frac{\partial i(z,t)}{\partial t}-v(z+\Delta z, t)=0 \\
&i(z,t)-G'\Delta z\cdot v(z+\Delta z, t)-C'\Delta z\frac{\partial v(z+\Delta z,t)}{\partial t}-i(z+\Delta z, t)=0
\end{align}$$
By dividing the equations by $\Delta z$ we get:
$$\begin{align}
&\frac{v(z,t)-v(z+\Delta z, t)}{\Delta z}-R'\cdot i(z,t)-L'\frac{\partial i(z,t)}{\partial t}=0 \\
&\frac{i(z,t)-i(z+\Delta z, t)}{\Delta z}-G'\cdot v(z+\Delta z, t)-C'\frac{\partial v(z+\Delta z,t)}{\partial t}=0
\end{align}$$
By calculating the limit as $\Delta z\rightarrow 0$ and by noticing that $\frac{v(z,t)-v(z+\Delta z, t)}{\Delta z}$ is a derivative and that $\frac{\partial v(z+\Delta z,t)}{\partial t}\rightarrow\frac{\partial v(z,t)}{\partial t}$ we end up with the equations.
`\end{proof}`
#### Telephone Equations and Complex Propagation Constant
^99bf74

[Theory Chapter.](#^4331d6)

Take the Telegraphist's Equations and express them via phasors:
$$\begin{align}
\frac{d V(z)}{dz}&=-R'I(z)-jwL'I(z)=-(R'+jwL')I(z) \\
\frac{d I(z)}{dz}&=-G'V(z)-jwC'V(z)=-(G'+jwC')V(z)
\end{align}$$
Now take the second derivative (I will show the calculations only on $V(z)$, the other is left to the reader :) ).
$$\begin{align}\frac{d^2 V(z)}{dz^s}=-(R'+jwL')\frac{dI(z)}{dz}=(R'+jwL')(G'+jwC')V(z)=\gamma^2 V(z)\rightarrow\frac{d^2 V(z)}{dz^s}-\gamma^2V(z)=0 \\ \frac{d^2 I(z)}{dz^s}-\gamma^2I(z)=0
\end{align}$$
`\end{proof}`
#### Characteristic Impedance
^5ce037

[Theory Chapter.](#^45e5b3)

By looking at the traveling wave solution and remembering the solution of type $\frac{d I(z)}{dz}=-(G'+jwC')V(z)=-YV(z)$ we end up with the values for $I_+=V_+/(\gamma/Y)$ , $I_-=-V_-/(\gamma/Y)$. Then by Kirchhoff we know that $\gamma/Y=Z=\sqrt{\frac{R'+jwL'}{G'+jwC'}}$
`\end{proof}`
#### From Phasor to Signal Solution
^64a8b5

[Theory Chapter.](#^ab8f3a)

This proof consists in a series of phasorial calculations. I will explicitly show the calculations of $V_+$. Recall that since $V_+\in\mathbb C$ then we can write it as $|V_+|e^{j\varphi_+}$ and by recalling that $\gamma=\alpha+j\beta$ is also complex we end up with: $$V_+e^{-\gamma z}=|V_+|e^{j\varphi_+}e^{-(\alpha+j\beta)z}=|V_+|e^{-\alpha z}e^{j(\varphi_++\beta z)}=|V_+|e^{-\alpha z}\cos(wt+\beta z+\varphi_+)$$
From here the proof follows.
`\end{proof}`
#### Smith Chart

^3b2378

Here are some proofs
 no lmao troppo sbatti e poi sono inutili

## 6.3) Planar Waves
#### Continuity Conditions

^10c3dc

[Theory Chapter.](#^56b7f6)
Consider the following image:
![[Pasted image 20250423140614.png|Representation|450]]
>[!col]
>Recall the 2 Gauss Laws in integral form. With a cylinder of $h\rightarrow0$ it's lateral surface tends to 0. Clearly we have that $\oint_S \vec D \cdot \hat ndS= \Delta S(D_1-D_2)\hat n$ where $n_1=-n_2$. This also holds for $\oint \vec B\cdot\hat ndS$. 
>Moreover the integral of the charge density has as result $\Delta S\rho_S$
>![[Pasted image 20250423141535.png|Circuitation Representation|250]]
>
>![[Pasted image 20250423141357.png|Gauss Laws Volume Representation|250]]
>For Ampere-Maxwell and Faradays laws we consider the circuitation and the calculations are analogous

`\end{proof}`
#### General Helmholtz Solution

^55956f

[Theory Chapter](#^4ce214)
Recall the Helmholtz equation for the E component. It can be rewritten in it's 3 parts:
$$\frac{\partial^2E_i}{\partial x^2}+\frac{\partial^2E_i}{\partial y^2}+\frac{\partial^2E_i}{\partial z^2}+k^2E_i=0 \text{ with } 
\begin{cases}
i=x,y,z \\
k^2=\sum_ik_i^2
\end{cases}$$
and therefore the electric field can be rewritten as:
$$E_x=E_x^+e^{-j\vec k\cdot\vec r}+E_x^-e^{j\vec k\cdot\vec r}$$
By only considering the positive direction $\vec E=\vec E_0e^{-j\vec k\cdot\vec r}$ with $\vec E_0=\sum_iE_i^+\cdot\hat i$
The divergence (by gauss) will be:
$$\nabla\cdot\vec E=-j\vec k \cdot\vec E_0e^{-j\vec k\cdot\vec r}=0$$
whose only solution is $\vec k\cdot\vec E_0=0$. **This means that the Electric field lies on a plane $\perp$ to the propagation direction**.

From Maxwells equation:
$$\vec H=\frac j{\omega\mu}\nabla\times\vec E=
\frac j{\omega\mu}\nabla\times(\vec E_0e^{-j\vec k\cdot\vec r})=
-\frac{j}{\omega\mu}\vec E_0\times \nabla e^{-j\vec k\cdot\vec r}=
\frac{k}{\omega \mu}\hat k\times \vec E_0e^{-j\vec k\cdot\vec r}$$
where $\hat k$ is the direction of propagation $\displaystyle\eta=\frac{E_x^+}{H_y^+}=\sqrt{\frac{\mu}{\varepsilon}}$. The curl makes it so that $H\perp E\perp k$.
`\end{proof}`

#### Meaning Of Modulus Of Complex vector

^4bcc9d

[Theory Chapter](#^eb2785)
$$\mathcal E(z,t)=E^+\cos(\omega t-kz+\varphi_+)+E^-\cos(\omega t+kz+\varphi_-)\iff E=E^+e^{-jkz+\varphi_+}+E^-e^{jkz+\varphi_-}$$

First analyze the mean value of the square
$$\begin{align}
<\mathcal E^2>=
&\frac 1T\int\mathcal E^2dt=\frac 1T\int_0^T {E^+}^2\cos_+^2+{E^-}^2\cos_-^2+2E^+E^-\cos_+\cos_-dt\\
&\frac12\left({E^+}^2+{E^-}^2+2E^+E^-\cos(2kz+\varphi_-+\varphi_+)\right)
\end{align}$$
Where the first two integrals were known and the last was made with the relation $\cos(a)\cos(b)=\frac12(\cos(a+b)+\cos(a-b))$

Now analyze the complex vector
$$\begin{align}
|E|^2=
&(E\cdot E^*)^2={E^+}^2+{E^-}^2+E^+E^-e^{-j(2kz+\varphi_+-\varphi_-)}+E^+E^-e^{j(2kz+\varphi_+-\varphi_-)} \\
&(E\cdot E^*)^2={E^+}^2+{E^-}^2+2E^+E^-\cos(2kz+\varphi_+-\varphi_-)=2<\mathcal E^2>
\end{align}$$
`\end{proof}`

#### Power Balance Equation

^54b374

[Theory Chapter](#^e758b4)
Recall the following maxwell eq:
$$\begin{align}
&\text{Faraday Law: } &&\nabla\times{\vec E} =-j\omega\mu\vec H \\
&\text{Ampere-Maxwell Law: } &&\nabla \times {\vec H}=j\omega\varepsilon\vec E+\sigma\vec E+\vec J
\end{align}$$
First calculate the complex conj. of Ampere-Maxwell
$$\nabla \times {\vec H}^*=-j\omega\varepsilon\vec E^*+\sigma\vec E^*+\vec J^*$$
Do the following scalar products
$$\begin{align}
&\vec H^*\cdot\nabla\times{\vec E} =-j\omega\mu\vec H\cdot\vec H^* \\
&\vec E\cdot \nabla \times {\vec H}^*=-j\omega\varepsilon\vec E^*\cdot\vec E+\sigma\vec E\cdot\vec E^*+\vec J^*\cdot\vec E
\end{align}$$
By subtracting the second from the first and using a vector identity:
$$\vec H^*\cdot(\nabla\times\vec E)-\vec E\cdot(\nabla\times\vec H^*)=-\sigma|\vec E|^2+j\omega(\varepsilon |\vec E|^2-\mu |\vec H|^2)-\vec J^*\cdot\vec E$$
Finally the equation is obtained by integrating all over $dV$.
`\end{proof}`
# 7) Formulas to remember
## 7.1) Recap
todo
## 7.2) Transmission Lines
Voltage and current vary according to:
$$\begin{align}
&V(z)=V_+e^{-\gamma z}+V_-e^{\gamma z}\\
&I(z)=I_+e^{-\gamma z}+I_-e^{\gamma z}=\frac{V_+}{Z_c}e^{-\gamma z}-\frac{V_-}{Z_c}e^{\gamma z}
\end{align}$$
If the line is lossless it has has 2 parameters:
$$\beta=\omega\sqrt{L'C'}, \ Z_C=\sqrt\frac{L'}{C'}$$
The normalized admittance depends on the position:
$$z(-l)=\frac{Z(-l)}{Z_C}=\frac{z_L+j\tan(\beta l)}{1+jz_L\tan(\beta l)}$$
and so does the reflection coeff.:
$$\Gamma(-l)=\frac{z(-l)-1}{z(-l)+1}$$
$$\Gamma(-l)=\frac{V_-e^{-j\beta l}}{V_+e^{j\beta l}}=|\Gamma_L|e^{j\varphi_L}e^{-j2\beta l}$$
$$\beta=\frac{2\pi}{\lambda}$$

Reflection Coefficient:
$$|\Gamma_L|=|\frac{z_L-1}{z_L+1}|=\frac{S-1}{S+1}$$
SWR:
$$S=\frac{1+|\Gamma_L|}{1-|\Gamma_L|}=\frac{V_{Max}}{V_{min}}$$
Impedance:
$$\begin{align}
Z_{Max}=SZ_C& &&Z_{min}=\frac{Z_C}{S} \\
V_{Max}=SZ_CI_{min}& &&V_{min}=\frac{Z_C}SI_{Max}
\end{align}$$

Powers:
$$P=\frac{|V_+|^2}{2Z_C}(1-|\Gamma_L|^2)$$
$$P_L=\frac{R_L}2|I_L|^2=\frac{R_L}{2|Z_L|^2}|V_L|^2$$
$$\begin{align}
&|V_{Max}|=\sqrt{2PSZ_C} &&|I_{min}|=\sqrt{\frac{2P}{SZ_C}}=\frac{|V_{Max}|}{SZ_C}\\
&|V_{min}|=\sqrt{\frac{2PZ_C}{S}}=\frac{|V_{Max}|}{S} &&|I_{Max}|=\sqrt{\frac{2PS}{Z_C}}=\frac{|V_{Max}|}{Z_C}
\end{align}$$
Where the formulas with $V_{Max}$ are a good enough approximation. There are also the following approximations, just use abs value for modulus (see $|I_{Max}|$ as example):
$$\begin{align}
&V_{Max}=V_+e^{j\beta d}(1+\Gamma_L) &&I_{min}=\frac{V_+}{Z_C}e^{j\beta d}(1-\Gamma_L)\\
&V_{min}=V_+e^{j\beta d}(1-\Gamma_L) &&|I_{Max}|=\frac{|V_+|}{Z_C}e^{j\beta d}(1+|\Gamma_L|)
\end{align}$$
In general:
$$V(-d)=V_+e^{j\beta l}(1+\Gamma(-l)), \ I(-d)=\frac{V_+}{Z_C}e^{j\beta l}(1-\Gamma(-l))$$

Matching conditions, if $Z_G=Z_C$:
$$V_+=\frac{V_g}{2}e^{-j\beta l}=\frac{V_g}2e^{-j\frac{2\pi}{\lambda}L}, |V_+|=|V_G|/2$$
Quarter wavelength adapter
$$\begin{align}
&\text{Max Impedance: }&&Z_2=Z_1\sqrt S\rightarrow S'=\sqrt S\\
&\text{min Impedance: }&&Z_2=Z_1/\sqrt S\rightarrow S'=1/\sqrt S\\
& &&\Gamma=\frac{Z_{\lambda/4}-Z_C}{Z_{\lambda/4}+Z_C} \\
&&& V(d+\lambda/4)=V_+=\frac{V_g}2e^{-j\beta L_{feedline}}
\end{align}$$
## 7.3) Plane Waves
#### Vectors
$$\begin{gather}
&\vec d\rightarrow \vec d (t)=\Re[\vec d\cdot e^{j\omega t}] \\ \\
&\sin(x\pm\frac\pi2)=\pm\cos(x) \\
&\cos(x\pm\frac\pi2)=\mp\sin(x) \\ \\
&\hat x \times \hat y=-\hat y \times \hat x=\hat z \\
&\hat y \times \hat z=-\hat z \times \hat y=\hat x \\
&\hat z \times \hat x=-\hat x \times \hat z=\hat y \\
\end{gather}$$

#### Wave Fundamentals
$$\begin{align}
&\text{Intrinsic Impedance: }&&\eta=\sqrt\frac\mu\varepsilon=\eta_0\sqrt\frac{\mu_r}{\varepsilon_r}\text{ with }\eta_0=120\pi\approx377\\
&\text{Phase Velocity: }&&v_f=\frac\omega k=\frac cf=\frac cn\\
&\text{Wavelength: }&&\lambda=\frac{v_f}f=\frac{2\pi}k=\frac c{nf}\\
&\text{Propagation Constant:}&&k=\omega\sqrt{\mu\varepsilon}=\frac{2\pi}\lambda=\frac{\omega n}{c_0}=\frac\omega{v_f}\\
&\text{Refractive Index: }&&n=\sqrt{\mu_r\varepsilon_r}=\frac c{v_f}=\frac c{\lambda f}\\
&\text{Propagation Constant: }&&k=\omega\sqrt{\mu\varepsilon}=\frac{2\pi}\lambda=\frac{\omega n}{c_0}
\end{align}$$
Moreover recall that $\displaystyle \frac k {\omega\varepsilon}=\sqrt\frac{\mu}{\epsilon}=\eta$
#### Constants
In vacuum:
$$\begin{align}
&\text{Magnetic Permeability: }&&\mu_o=4\pi\cdot10^{-7}[ H/m]\\ &\text{Dielectric Permeability: }&&\varepsilon_0=8.854\cdot 10^{-12}[ F/m]\\
&\text{Speed of Light: } &&c_0=3\cdot10^{8}[m/s]\\
&\text{Intrinsic Impedance: }&&\eta_0=120\pi=377[\ohm]
\end{align}$$
In lossless ($\sigma=0$), non magnetic ($\mu = \mu_0$) medium
$$\begin{align}
&\text{Diel. Perm.: }&&\varepsilon=\varepsilon_0\varepsilon_r\\
&\text{Refractive Index: }&&n=\sqrt{\varepsilon_r}\\
&\text{Intrinsic Impedance: }&&\eta=\sqrt\frac\mu\varepsilon=\frac{\eta_0}n
\end{align}$$
#### Helmholtz
$$\begin{align}
&\vec E(\vec r)=\frac{\nabla \times\vec H}{j\omega\varepsilon} =\eta \vec H\times \vec k\\
&\vec H(\vec r)=\frac j{\omega\mu}\nabla\times\vec E=\frac{\hat k\times \vec E}{\eta}
\end{align}$$
#### Power
$$\begin{align}
\text{Poynting Vector: }\vec S=\frac{\vec E \times \vec H^*}2\rightarrow\oint\vec S\cdot\hat n\ dS \space \text{ Real part is avg power.}
\end{align}$$
$$\begin{align}
&\text{Avg. Incident Power Density: } &&\frac{E_0^i}{2\eta_1} \\
&\text{Avg. Reflected Power Density: } &&\frac{E_0^i}{2\eta_1}|\Gamma|^2 \\
&\text{Avg. Transmitted Power Density: } &&\frac{E_0^i}{2\eta_1}(1-|\Gamma|^2)
\end{align}$$
$$\begin{align}
&\text{Plane Wave Mean Power Density Lossless Medium: }\Re[\vec S]=\frac{|\hat E_0|^2}{2\eta}\hat k=\eta\frac{|\vec H_0|^2}{2}\hat k\\
&\text{Plane Wave Mean Power Density Good Conductor: }\Re[\vec S]=\frac{|E_0|^2}{4R_s}e^{-2\alpha z}\hat z
\end{align}$$
#### Polarization
Linear polarization happens when 
$$\begin{align}
\text{In-phase: }&\varphi=0\\ 
\text{Out-of-phase: }&\varphi=\pi
\end{align}$$
$$\begin{gather}
&\vec E=(a_x\hat x-a_y\hat y)e^{-jkz}\rightarrow \vec e(t,z)=(a_x-a_y)\cos(\omega t) \\
&|\vec e(t,z)|=\sqrt{a_x^2+a_y^2}\cos(\omega t) \\
&\psi(t,z)=\arctan\left(\frac{-a_y}{a_x}\right)
\end{gather}$$ 

LHCP happens when
$$\begin{align}
&a_x=a_y=a \\
&\varphi=\frac\pi2
\end{align}$$
$$\begin{gather}
&\vec E=a(\hat x+j\hat y)e^{-jkz}\rightarrow\vec e(t,z)=a\cos(\omega t -kz)\hat x-a\sin(\omega t -kz)\hat y \\
&|\vec e(t,z)|=|a| \\
&\psi(t,z)=\arctan\left(\frac{-a\sin(\omega t-kz)}{a\cos(\omega t-kz)}\right)=-(\omega t -kz)
\end{gather}$$
RHCP happens when
$$\begin{align}
&a_x=a_y=a \\
&\varphi=-\frac\pi2
\end{align}$$

$$\begin{gather}
&\vec E=a(\hat x-j\hat y)e^{-jkz}\rightarrow\vec e(t,z)=a\cos(\omega t -kz)\hat x+a\sin(\omega t -kz)\hat y \\
&|\vec e(t,z)|=|a| \\
&\psi(t,z)=\arctan\left(\frac{-a\sin(\omega t-kz)}{a\cos(\omega t-kz)}\right)=(\omega t -kz)
\end{gather}$$

|                   | LHCP                               | Linear                                                   | RHCP                               |
| ----------------- | ---------------------------------- | -------------------------------------------------------- | ---------------------------------- |
| $\varphi$         | $\varphi=\frac\pi2$                | In Phase $\varphi=0$ or in Phase Opposition$\varphi=\pi$ | $\varphi=-\frac\pi2$               |
| $a_x,a_y$         | $a_x=a_y=a$                        | no conditions                                            | $a_x=a_y=a$                        |
| $\vec E$          | $\vec E=a(\hat x+j\hat y)e^{-jkz}$ | $E=(a_x\hat x-a_y\hat y)e^{-jkz}$                        | $\vec E=a(\hat x-j\hat y)e^{-jkz}$ |
| $\|\vec e(t,z)\|$ | $\|a\|$                            | $\sqrt{a_x^2+a_y^2}\cos(\omega t)$                       | $\|a\|$                            |
| $\psi$            | $-(wt-kz)$                         | $\arctan(-a_y/a_x)$                                      | $wt-kz$                            |
In general we have that:
$$
\begin{gather}
\vec e(z,t)=\Re[\vec Ee^{j\omega t}]=\hat x e_x(z,t)+\hat ye_y(z,t)=\hat xa_x\cos(\omega t-kz)+\hat ya_y\cos(\omega t-kz+\varphi)\\
|\vec e(z,t)|=\sqrt{a_x^2\cos^2(\omega t-kz)+a_y^2\cos^2{\omega t-kz+\varphi}}\\
\psi=\arctan\left(\frac{e_y(z,t)}{e_x(z,t)}\right)
\end{gather}$$
#### Lossy Medium $\sigma\not = 0$
$$\begin{gather}
&\text{Complex Electric Permittivity: } \varepsilon_C=\varepsilon -j\frac{\sigma}{\omega}\\
&\gamma=\alpha+j\beta:=
\begin{cases}
\alpha=\omega\left[\sqrt{1+\frac{\varepsilon_{im}}{\varepsilon_{re}}^2}-1\right]^\frac12 \\
\beta=\omega\left[\sqrt{1+\frac{\varepsilon_{im}}{\varepsilon_{re}}^2}+1\right]^\frac12
\end{cases}
\end{gather}$$
Recall:
$$\begin{align}
&\text{Lossless: } \sigma=0\rightarrow \varepsilon_{im}=0 \\
&\text{Low-Loss: } \sigma<<\omega\varepsilon\rightarrow\varepsilon_{im}<<1
\end{align}$$
$$\begin{align}
&\sigma >> \omega\varepsilon \implies \text{good conductor}: \left(\sigma\approx 10^7 \ [\ohm^{-1}m^{-1}], \ \space  \ f<<2\cdot10^{17} \ [Hz]\right)\\
&\sigma << \omega\varepsilon \implies \text{good insulator}
\end{align}$$
In a good conductor($\sigma>>\omega\varepsilon$):
$$\alpha=\beta=\omega\sqrt\frac{\mu\sigma}{2\omega}=\sqrt{\pi f \mu\sigma }\ \space \ \delta_s=\frac1{\sqrt{\pi f \mu\sigma }}\ \space \ \eta_c=\frac{1+j}{\sigma\delta_s}$$
$$E=E_0e^{\displaystyle -d/\delta_s}$$
## 7.4) Reflection, Refraction And Optical Fibers
#### Reflection And Refraction

Wave travels in medium 1 and has perpendicular discontinuity with medium 2:

In Medium 1 we have:
$$\begin{align}
&\vec E_1(z)=\hat x E_0^ie^{-jk_1z}(1+|\Gamma|e^{j\varphi_\Gamma}e^{2jk_1z})\\
&\vec H_i(z)=\hat y\frac{E_0^i}{\eta_1}e^{-jk_iz}(1-|\Gamma|e^{j\varphi_\Gamma}e^{2jk_1z})
\end{align}$$
The **reflection coefficient is:**
$$\Gamma=\frac{E_0^r}{E_0^i}=\frac{\eta_2-\eta_1}{\eta_2+\eta_1}=\frac{n_1-n_2}{n_1+n_2}$$
And the refraction coefficient as:
$$\tau=\frac{E_0^t}{E_0^i}=\Gamma+1$$

The Max/min of the fields is at $\varphi_\Gamma+2k_1z=2N\pi$ or $\varphi_\Gamma+2k_1z=(2N+1)\pi$ and depends on where the reflection coefficient has min/max contribution.
$$\begin{align}
&|\vec E_1|_{Max}=|E_0^i|(1+|\Gamma|) &&|\vec E_1|_{min}=|E_0^i|(1-|\Gamma|)\\
&|\vec H_1|_{min}=|\frac{E_0^i}{\eta_1}|(1-|\Gamma|) && |\vec H_1|_{Max}=|\frac{E_0^i}{\eta_1}|(1+|\Gamma|)
\end{align}$$
These have a periodicity of $2\pi$ ($\lambda_1/2$) and most importantly occur simultaneously ($E_{Max}\iff H_{min}$). Maxima and minima are separated by $\lambda_1/4$ ($\pi$)

In Medium 2 we have:
$$\begin{align}
&\vec E_t(z)=\hat x E_0^te^{-jk_2z}\\
&\vec H_t(z)=\hat y\frac{E_0^t}{2\eta_2}e^{-jk_2z}
\end{align}$$
The **poyinting vector** gives the following results

$$\begin{align}
&\text{Avg. Incident Power Density: } &&\frac{{E_0^i}^2}{2\eta_1} \\
&\text{Avg. Reflected Power Density: } &&\frac{{E_0^i}^2}{2\eta_1}|\Gamma|^2 \\
&\text{Avg. Transmitted Power Density: } &&\frac{{E_0^i}^2}{2\eta_1}(1-|\Gamma|^2)
\end{align}$$
which is **independent from z**: **The flux of the active power is conserved**
Notice also that since the power is conserved the total power of the incident wave we have:
- The avg incident power can be seen as the starting power and it is equal to the reflected+refracted power
- The powers in the two mediums are the same to have continuity
**Remark:** do not forget about the power flow! Suppose the wave is propagating towards $\hat z$ the powers are actually: $\vec P_{i}=P_i\hat z, \vec P_t=P_t\hat z$ but $\vec P_r=P_r (-\hat z)$ and therefore it is clear that $\vec P_{\text{medium 1}}=\vec P_i+\vec P_r=\vec P_{\text{medium 2}}$

>[!todo] $k_2$ Good Conductor

#### Fiber
We will consider the following model of a fiber cable
![[Pasted image 20250519111935.png|Optical Fiber|450]]
Critical angle for internal reflection:$$\theta_{cr}=\arcsin(n_c/n_f)$$
Angles that satisfy total reflection: $$\sin(\theta_3)=\cos(\theta_2)\geq n_c/n_f$$
Attenuation:
$$\begin{align}
&a=a_{0}\cdot d\ [dB]\\
&P_0=P\cdot10^{a_{dB}/10}&&\rightarrow P=P_0/10^{a_{dB}/10}\\
\end{align}$$
Where $10^{a_{dB}/10}$ is $a$ in linear scale

In a multimode fiber the longest path is the one launched with the critical angle:
$$l_{max}=\frac l{\cos(\theta_2)}=l\frac{n_f}{c_f}$$
Recall that the speed in the core is $c_f=c/n_f$. The delay between the fastest and slowest beam is given by:$$\tau=\frac{l_{Max}-l_{min}}{c_f}=\frac{l(\frac{n_f}{n_c}-1)}{c_f}=l\frac{n_f}{c_0}\left(\frac{n_f}{n_c}-1\right)$$
#### Other

- Uniform Plane Wave
$$\begin{align}
&\text{Lossless Medium }(\sigma=0):\vec E(\vec r)=\vec E_0e^{-j\vec k\vec r}, \vec H(\vec r)=\frac1\eta\hat k\times\vec E_0e^{-j\vec k\vec r}=\vec H_0 e^{-j\vec k\vec r}\\
&\text{Good Conductor }(\sigma>>\omega\varepsilon): \vec E(\vec r)=\vec E_0e^{-\alpha(1+j)z}. \vec H_0(\vec r)=\frac1{\eta_c}\hat z\times \vec E_0e^{-\alpha(1+j)z}
\end{align}$$
With
$$\begin{align}
&\text{Impedance of good conductor: } \eta_c=R_S(1+j)\\
&\text{Surface Resistance: }R_S=\sqrt\frac{\pi f\mu_o}{\sigma}\\
&\text{Attenuation + Phase Constants: }\alpha=k=\sqrt{\pi f \mu_0\sigma}\\
&\text{Penetration Depth: }\delta_S=\frac1\alpha=\frac1{\sqrt{\pi f \mu\sigma}}
\end{align}$$
## 7.5) Antennas
#### Elementary Dipole
$$ $$
$$\begin{aligned}
&E_r=\eta\frac{I\Delta z}{4\pi}\left(jk+\frac 1R+\frac{1}{jkR^2}\right)\sin(\theta)\frac{e^{-jkR}}{R} \\
&E_\theta=\eta\frac{I\Delta z}{2\pi}\left(0+\frac 1R+ \frac1{jkR^2}\right)\cos(\theta)\frac{e^{-jkR}}{R}\\
&H_\varphi=\frac{I\Delta z}{4\pi}\left(jk+\frac 1R+0\right)\sin(\theta)\frac{e^{-jkR}}{R}
\end{aligned}
\stackrel{R>>\lambda}\rightarrow
\begin{aligned}
&E_r=0\\
&E_\theta=\eta\frac{jkI\Delta z}{4\pi}\sin(\theta)\frac{e^{-jkR}}R\\
&H_{\varphi}=\frac{jkI\Delta z}{4\pi}\sin(\theta)\frac{e^{-jkR}}R
\end{aligned}$$
with:
$$\begin{align}
k=\omega \sqrt{\mu \varepsilon}\\
\eta=\sqrt\frac\mu\varepsilon
\end{align}$$
Poynting Vector: $$
\vec S=S(R,\theta)\hat r=\eta\left(\frac{k|I|\Delta z}{4\pi R}\right)^2\sin^2(\theta)\hat r
\rightarrow
\begin{aligned}
&P_{rad}=\eta\frac\pi3|I|^2\left(\frac{\Delta z}\lambda\right)^2=R_{rad}\frac{|I|^2}2\\
&R_{rad}=\eta\frac{2\pi}3\left(\frac{\Delta z}\lambda\right)^2
\end{aligned}$$
#### Wireless Link
$$\begin{align}
&\text{(Normalized) Radiation Intensity:} &&F(\theta,\phi)=\frac{S(R,\theta,\phi)}{S_{\max}} \\
&\text{Directivity: } &&D=\frac{F_{\max}}{F_{AV}}=\frac{4\pi R^2S_\max}{P_{rad}}>1 \\
&\text{Power Gain: } &&G=\frac{4\pi R^2S_{\max}}{P_t} \text{ where }P_t=P_{rad}+P_{diss}\\
&\text{Radiation Efficiency: } &&\xi=\frac{P_{rad}}{P_t}=\frac{R_{rad}}{R_{rad}+R_{diss}}=\frac GD
\end{align}$$

Radiation Intensity: gives info about radiated power density in one direction. A plane with constant $F$ is plane of omnidirectionality.

Directivity: ratio between max rad int (1) and avg. A isotropic antenna has $D=1$ but does not exist
#### Effective Area
$$A_e=\frac{P_{rec}}{\displaystyle\frac{|\vec E_i|^2}{2\eta}}\space [m^2]$$
Friis:
$$\begin{align}
&P_{rec}=A_eS_\max=A_e\frac{G_tP_t}{4\pi R^2}=P_tG_tG_r\left(\frac\lambda{4\pi R}\right)^2\\
&S_\max=\frac{DP_{rad}}{4\pi R^2}=\frac{G_TP_T}{4\pi R^2}
\end{align}$$
The term $\displaystyle{\frac1{A_{sl}}=\left(\frac{\lambda}{4\pi R}\right)^2}$ is the attenuation factor

Where under reciprocity condition the following holds: $$\frac{A_e}{G_r}=\frac{\lambda^2}{4\pi}$$ 

#### Short Dipole Antenna $l<<\lambda$
![[Pasted image 20250619151112.png|Short Dipole Antenna|450]]
$$\begin{gather}
E_\theta=j\eta\frac{I}{2\lambda}\frac{l}2\sin(\theta)\frac{e^{-jkR}}R\\
F(\theta,\phi)=F(\theta)=\sin^2(\theta)\\
D=1.5\\
R_{rad}=\frac{2\pi}3\eta\left(\frac{l}{2\lambda}\right)^2\\
A_e=\xi\frac{3\lambda^2}{8\pi}
\end{gather}$$

#### Half-Wave Dipole Antenna $l=\lambda/2$
![[Pasted image 20250619151550.png|Half-Wave Dipole|250]]
$$\begin{gather}
E_\theta=j\eta\frac{I}{2\lambda}\frac{l}2\sin(\theta)\frac{e^{-jkR}}R\\
F(\theta,\phi)=F(\theta)=\sin^2(\theta)\\
D=1.64\\
R_{rad}=72\ [\ohm]
\end{gather}$$

#### Parabolic Antenna
$$\begin{gather}
G=\xi\left(\frac{\pi d}\lambda\right)^2\\
A_e=\xi\frac{\pi d^2}{4}\stackrel{\text{Geometric}}=\pi r^2
\end{gather}$$


# 8) Common Exercise Solutions
#### 8) Find E or H
Here you use the Helmholtz formulas
$$\begin{align}
&\vec E(\vec r)=\frac{\nabla \times\vec H}{j\omega\varepsilon} =\eta \vec H\times \vec k\\
&\vec H(\vec r)=\frac j{\omega\mu}\nabla\times\vec E=\frac{\hat k\times \vec E}{\eta}
\end{align}$$
Where $\nabla\times \vec A$ is done with the determinant of the matrix
$$\begin{bmatrix}
\hat x &\hat y &\hat z\\
\frac{\partial}{\partial x} &\frac{\partial}{\partial y} &\frac{\partial}{\partial z}\\
A_x &A_y &A_z
\end{bmatrix}$$
Recall that the field usually propagates in a specific direction. Suppose $\hat k = \hat z$, then $A_z=0$ and the partial derivatives $\frac{\partial}{\partial x}A=\frac{\partial}{\partial y}A=0$ while $\frac{\partial}{\partial z}A_{x,y}\not = 0$.

Often it is also required to find $k/\omega \varepsilon$ or $k/\omega \mu$. By recalling that $k=\omega\sqrt{\mu\varepsilon}$ we have:
$$\begin{align}
&\frac{k}{\omega\varepsilon}=\sqrt\frac{\mu}{\varepsilon}=\eta=\eta_0\sqrt\frac{\mu_r}{\varepsilon_r}\\
&\frac{k}{\omega\mu}=\sqrt\frac{\varepsilon}{\mu}=\frac1\eta=\frac{1}{\eta_0}\sqrt\frac{\varepsilon_r}{\mu_r}
\end{align}$$
If $\eta$ is unknown it is useful to remember that $\lambda=\frac{2\pi}k=\frac{c}{nf}$ and that in a lossless non magnetic medium $\mu=\mu_0$ and therefore $n=\sqrt{\mu_r\varepsilon_r}=\sqrt{\varepsilon_r}$

#### Vectors to Time Domain
A vector $\hat s$ can be written in time domain as $\vec s(t)\Re[\hat s\cdot e^{j\omega t}]$
Example:
$$\begin{align}
&\hat s=a(\hat x-j\hat y)\\
&\vec s(t)=\Re[\hat s\cdot e^{j\omega t}]=a\cdot\Re[\hat xe^{j\omega t}-j\hat y\cdot e^{j\omega t}]\\
&\text{Where: } \Re[j\hat ye^{-j\omega t}]=\Re[\hat ye^{j\frac\pi2}e^{j\omega t}]\\
\implies&\vec s(t)=a(\cos(\omega t)\hat x+\cos(\omega t-\frac\pi2)\hat y)=a(\cos(\omega t)\hat x-\sin(\omega t)\hat y)
\end{align}$$
#### Complex Vector/Vector Field to Time Domain
Given a complex vector $\vec E$ it is possible to find $\vec e(t,z=0)=\Re[\vec Ee^{j\omega t}]$
Example:
$$\begin{align}
&\vec E=(-\hat x+2\hat ye^{\frac {j2\pi}3})e^{-jkz}\\
&\vec e(t,z=0)=\Re[(-\hat x+2\hat ye^{\frac {j2\pi}3})e^{j\omega t}]\\
\implies&\vec e(t,z=0)=\cos(\omega t)\hat x+2\cos(\omega t +\frac{2\pi}3)\hat y
\end{align}$$
The same procedure holds for a vector field $\vec A$. In this new example the **coefficients are complex numbers**:
$$\vec A=\left[(2\sqrt3+j2)\hat x-(\frac{3-j3\sqrt 3}2)\hat y\right]e^{-jkz}$$
First we find modulus and phase of $A_x, A_y$:
$$\begin{align}
&|A_x|=\sqrt{(2\sqrt 3)^2+2^2}=4&&\angle A_x=\arctan{\frac{2}{2\sqrt 3}}=\frac\pi6\\
&|A_y|=\sqrt{(\frac 32)^2+(\frac{3\sqrt3}2)^2}=3&&\angle A_y=\arctan{\frac{\frac{-3\sqrt 3}2}{\frac 32}}=-\frac\pi3
\end{align}$$
Here it's not the case but remember: **the arctan with negative real part has inverted sign**.
Now we can rewrite:
$$\begin{align}
&\vec A(z=0)=4e^{j\frac\pi6}\hat x+3e^{-j\frac\pi3}\hat y\\
\implies&\vec a(t,z=0)=4\cos(\omega t+\frac\pi6)\hat x-3\cos(\omega t-\frac\pi3)\hat y\\&=4\cos(\omega t+\frac\pi6)\hat x-3\sin(\omega t+\frac\pi6)\\
\end{align}$$
The phase shift is of $\pi/2\implies$ LH polarization but not circular since $4\not = 3$.

#### Find Phase $\varphi$ of a Vector
This is straight forward from the definition:$$\hat s(t)=a_x\cos(\omega t)\hat x+a_y\cos(\omega t+\varphi)\hat y$$
Example:$$\hat s(t)=\cos(\omega t)\hat x+\sin(\omega t)\hat y=\cos(\omega t)\hat x+\cos(\omega t-\frac\pi2)\hat y\implies \varphi=-\frac\pi2$$
Moreover this is a RHCP. This was done by recalling that $\cos(x\pm\frac\pi2)=\mp\sin(x)$
#### Draw The Type of Polarization
First you must recognize what type of polarization it is, then do a quick table with some values $\in[0,\pi]$ and you can draw half of the polarization. The second half is symmetrical to the first.
Recall that if the starting vector is complex you must choose the propagation direction = 0 and then the polarization will be on the plane $\hat k =0$.

#### Reflection, Refraction
This exercises generally only need the knowledge of the formulas since more often than not all analytical calculations can be reduced to actually proving the formulas that we obtained in class. Here are some useful tips:
- To find $\vec H^*$ starting from $\vec H=Ae^{jkt}$ you just invert the sign of the complex exponential $\vec H^*=A^{-jkt}$
todo
>[!rmk|*] TODO
>A negative reflection coefficient is possible. This implies that the wave gets reflected "upside down". Keep in mind that (supposing 0 phase) $\Gamma=-|\Gamma|$ and an expreession of type $E_1=E(1+\Gamma)=E(1-|\Gamma|)$ is a actually a minima

#### Optical Fibers
Here again just the use of direct formulas is required. Here are some useful tips:
todo

#### Dipole Find Components
First recall that at large distances $l>>\lambda$ the components depend only on $R,\theta$ and not on $\phi$. 
Let's analyze the formulas:
Call $\displaystyle{\beta=\frac{jkI\Delta z}{4\pi}}$ the far field and $\displaystyle{s(R)=\frac{e^{jkR}}{R}}$ the spherical wave contribution. Then the components can be rewritten as:
$$\begin{aligned}
&E_r=0\\
&E_\theta=\eta\beta\sin(\theta)s(R)\\
&H_{\varphi}=\beta\sin(\theta)s(R)
\end{aligned}$$
Just to have a mnemonic way to better recall the formulas: Moreover the modulus of $|s(R)|=1/R$ while $|\beta|$ just loses the $j$ and thus:$$\begin{aligned}
&|E_r|=0\\
&|E_\theta|=\eta\frac{|\beta|\sin(\theta)}R\\
&|H_{\varphi}|=\frac{|\beta|\sin(\theta)}R
\end{aligned}$$
Usually a value of the field  is given $(\theta_\max=90^\circ,\theta_\min=0^\circ,180^\circ,\ \theta\in[0,180^\circ])$. Then you can use the following trick:
$$|E(R',\theta')|=\eta\beta\frac{\sin(R')}{R'}=\eta\beta\frac{\sin(R')}{R'}\frac{\sin(R)}{R}\frac{R}{\sin(R)}=|E(R,\theta)|\frac{R\sin(\theta')}{R'\sin(\theta)}$$
Where $R,\theta$ and $E(R,\theta)$ can be the value that was already given.
The same goes for the magnetic field
$$|H(R',\theta')|=|H(R,\theta)|\frac{R\sin(\theta')}{R'\sin(\theta)}$$
If the maximum is given: $$|E(R,\theta)|=|E_\max|R_\max\frac{\sin(\theta)}R$$
#### Wireless Link
Good knowledge of formulas