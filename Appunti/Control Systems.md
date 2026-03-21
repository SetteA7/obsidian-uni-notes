This is a recap of the control systems course. The [last chapter](#^d685c2) is a quick recap of  the most useful knowledge to solve various exercises. These are my notes and they might be incorrect, especially the chapter on [Nyquist Diagrams](#^6858d8).
# 1) Laplace Transform
The Laplace transform is an operator that turns real valued functions into complex valued ones
$$\mathcal{L}_{\{x(t)\}}(s)=\int_{-\infty}^{\infty}x(t)e^{-st}dt, \ s=\sigma+j\omega$$
We will often consider the unilateral transform, which has the integral from $0$ to infinity.

>[!thm] Fourier and Laplace Transform
>The laplace transform is given as a function of $s=\sigma+j\omega$. But if we set $s=j\omega$ we have that
>$$\mathcal L(s=jw)=\mathcal F(jw)$$

In control systems we will study systems of differential equations, so the following property is really important:$$\boxed{ \begin{align}
&\mathcal{L}\left(\frac{d}{dt}x(t)\right)= sX(s)-x(0-) \\
&\mathcal{L}\left(\frac{d^n}{dt^n}x(t)\right)= s^nX(s)-s^{n-1}x(0-)-s^{n-2}x'(0-)-...-x^{(n-1)}(0-)
\end{align}}$$
Usually we will have an equation of the following type $\alpha y''+\beta y'+\gamma y=u(t)$. By applying the previous property and by explicating $Y(s)$ we will end up with the following equation:
$$Y(s)=\frac{C(s)}{A(s)}+\frac{B(s)}{A(s)}U(s)=Y_n(s)+Y_f(s)$$
- $Y_n(s)$ is called the *free/natural evolution* and **depends only on initial conditions and zero input**
- $Y_f(s)$ is called *forced evolution* and **depends on the input and zero initial conditions**

$A(s)$ is the **characteristic polynomial** and it is equivalent to the Laplace transform with no initial conditions and no input
$B(s)$ is equivalent to the laplace transform of the input

Now we can define the **transfer function**
$$H(s)=\frac{Y_f(s)}{U(s)}=\frac{\sum b_ms^m}{\sum a_ns^n}$$
it can be of three types:
- **Proper**: $M\leq N$
- **Strictly proper**: $M<N$
- **Improper**: $M>N$
A physically realizable system can exist only if $H(s)$ is proper.

#### How to decompose and anti-transform $H(s)$:
In most practical case the transfer function is a **rational function**
First, reduce the fraction as a sum of fractions such that every fraction has higher degree at a denominator, now for every fraction we can do the following **partial fractal expansion**

>[!rmk|*]
>It is important for the function to have $\text{degree}N(s)<\text{degree}D(s)$

Let $F(s)$ have n poles. Then it can be rewritten as:
$$F(s)=\frac{N(s)}{(s-\lambda_1)(s-\lambda_2)...(s-\lambda_n)}=\frac{A}{(s-\lambda_1)}+\frac{B}{(s-\lambda_2)}+...$$
The factors can be found in the following ways:
- **If the poles are real and different from each other:**$$A=\lim_{s\rightarrow\lambda}(s-\lambda)Y(s)$$
- **If the poles are real and 2 or more have the same value:**
	For those values the expansion will have the following form:$$\frac{A}{(s-\lambda)^n}+\frac{B}{(s-\lambda)^{n-1}}+...+\frac{N}{(s-\lambda)^{n-k}}+...\implies
\begin{align}
&A=\lim_{s\rightarrow\lambda}(s-\lambda)^nY(s) \\
&B=\lim_{s\rightarrow\lambda}\frac{d}{ds}[(s-\lambda)^{n}Y(s)] \\
&\vdots \\
&N=\lim_{s\rightarrow\lambda}\frac{1}{k!}\frac{d^{k}}{ds^{k}}[(s-\lambda)^nY(s)]
\end{align}$$
- **If the poles are complex valued**:
	Usually the poles will be a couple of coniugate complex poles: 
$$\frac{A}{(s-\sigma-j\omega)}+\frac{\overline A}{(s-\sigma+j\omega)}\implies
\begin{align}
&A=\lim_{s\rightarrow\sigma+j\omega}(s-\lambda)Y(s) \\
&\overline A=\lim_{s\rightarrow\sigma-j\omega}(s-\lambda)Y(s) \\
\end{align}$$That is exactly like the normal rational case, but the anti transform will be slightly different

The **anti transformation** is really simple by keeping in mind the following table:

| Transform                                                    |                                                                          | Properties                                                            |
| ------------------------------------------------------------ | ------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| $\delta(t)\stackrel{\mathcal L}{\rightarrow}1$               |                                                                          | $x(t+\beta)\stackrel{\mathcal L}{\rightarrow}e^{\beta s}X(s)$         |
| $u(t)\stackrel{\mathcal L}{\rightarrow}1/s$                  | $t^ku(t)\stackrel{\mathcal L}{\rightarrow}k!/s^{k+1}$                    | $e^{\beta t}x(t)\stackrel{\mathcal L}{\rightarrow}X(s-\beta)$         |
| $e^{\sigma t}\stackrel{\mathcal L}{\rightarrow}1/(s-\sigma)$ | $t^ke^{{\sigma t}}\stackrel{\mathcal L}{\rightarrow}k!/(s-\sigma)^{k+1}$ | $t^nx(t)\stackrel{\mathcal L}{\rightarrow}(-1)^n\frac{d^n}{ds^n}X(s)$ |
In the complex case $\omega\not=0$ and thus it is a bit more hard, but the inverse transform works the same
$$\frac{A}{s-(\sigma+j\omega)}\stackrel{\mathcal L^{-1}}{\rightarrow}Ae^{(\sigma+j\omega)t}=\mathopen\mid A\mathopen\mid e^{j\angle A}e^{(\sigma+j\omega)t}$$
if there are two complex conjugates:
$$\boxed{\frac{A}{(s-\sigma-j\omega)}+\frac{\overline A}{(s-\sigma+j\omega)}\stackrel{\mathcal L^{-1}}{\rightarrow}Ae^{(\sigma+j\omega)t}+\overline Ae^{(\sigma-j\omega)t}=2\mathopen\mid A\mathopen\mid e^{\sigma t}\cos(\omega t+\angle A)}$$
Last but not least we introduce one important property of the Laplace transform: 
>[!thm] Final value theorem
>If the system is BIBO stable, then
>$$\lim_{t\rightarrow\infty}f(t)=\lim_{s\rightarrow0^+}s\cdot Y_{\{f(t)\}}(s)$$

^1428a6


# 2) Equilibrium Points
Let's define a system of form and initial conditions it is in equilibrium: 
$$\sum a_n\frac{d^n y(t)}{dt^n}=\sum b_m\frac{d^m  u(t)}{dt^m}, \ \ \
\begin{cases}
x(0^-)&=[y(0^-),y'(0^-),...]^T \\
u(t) &= u, \ t\geq0
\end{cases}$$
>[!rmk|*]
>If $x(0^-)=u(t)=0$ then it is always an equilibrium point

Suppose we perturb an equilibrium point there, based on the system and the input various scenarios might happen.
![[Pasted image 20241020162129.png|Main equilibrium points|450]]
We give **2 different stability criterions:**
#### Asymptotically Stable
For an LTI system the impulse response doesn't depend on the equilibrium point and the perturbation amplitude. A system can be:
- **Stable:** $y_n$ is bounded
- **Asymptotically stable:** $\lim_{t\rightarrow\infty}y_n(t)=0$. Moreover asymptotic stability$\implies$stability
- **Unstable:** $\mathopen\mid Y_n(t)\mathopen\mid>M, \ \forall M>0$

>[!theorem] Stability w.r.t Initial conditions
>Let $A(s)$ be the characteristic polynomial (i.e. denominator of $H(s)$ before any semplification), then
>- It is asymptotically stable iff $\text{Re}[s_i]<0$
>- It is stable iff $\text{Re}[s_i]\leq0$ and there is just one $s_i=0$

In this case $A(s)$ has a specific name:

>[!def] Hurwitz Polynomial
>A polynomial where all zeros have negative real part is called **Hurwitz polynomial**.

^326f11

#### BIBO Stable
A system can also be **BIBO stable** if $u(t)\leq M_u\forall M_u>0\implies y_f(t)\leq M_y\forall M_y>0$

>[!theorem] Stability w.r.t input
>Let $H(s)$ be the transform function, then
>- It is BIBO stable iff $\Re[p_i]<0$

>[!thm]
>Keep in mind that:
>$$\text{Asymptotically stable}\implies\text{BIBO stable}$$
#### Hurwitz Discovery Criterion
Is there a quick way to find if a polynomial has all zeroes with negative real part (Hurwitz)?

>[!thm] Cartesio Rule
>A **necessary** condition for a polynomial to be Hurwitz is that all it's coefficients are non zero with same sign
>
>Moreover if at least one coefficient is zero, then the polynomial can't be Hurwitz

A quick corollary is:
>[!theorem] Newton Criterion
>Let $d(s)=a_2s^2+a_1s+a_3$ with all coefficients non zero with same sign, then the polynomial is **Hurwitz**. This holds also if $a_2=0$
>
>Moreover if $d(s)$ is the denominator of $H(s)$ we have that the transfer function is BIBO stable

>[!theorem] Routh Criterion
>Given a characteristic polynomial $A(s)=\sum_{i=0}^n a_is^{i}=d_G(s)+Kn_G(s)$ of degree n we can determine if it is Hurwitz with the following algorithm:

^d56942

1) We build the first two columns in the following ways

| Row $n$   | $a_n$     | $a_{n-2}$ | ... |
| --------- | --------- | --------- | --- |
| Row $n-1$ | $a_{n-1}$ | $a_{n-3}$ | ... |
 If there is a coefficient missing (n even), then put 0 
 
See images:
![[6487.png|Example of table 1|350]] 
![[77491.png||]]

After you find the table remember the following thorem:

>[!thm]
>If a polynomial $A(s)$ has a complete Routh Table, then it has no roots on the imaginary axis and the number of unstable roots is equivalent to the sign changes

If the table has a 0 in the first column, the table is said to be incomplete. In this case we replace that value with a $\epsilon$ and compute it as a parametric table, then compute the limit of those parameters for $\epsilon\rightarrow\pm0$ 

# 3) Negative Feedback
In this chapter we will study how a system with negative feedback works.
![[Pasted image 20241125161018.png|Negative Feedback System|550]]
In such a system the transfer function is given by:
$$W(s)=\frac{C(s)G(s)}{1+C(s)G(s)}$$
`\begin{proof}`
We have that $E=R-Y$ and also $Y=GCE$
From here we obtain: $Y=GC(R-Y)\rightarrow Y=\frac{GC}{1+GC}R$
`\end{proof}`

**Remark:** in classe we use the following notation: in the block we have the symbols $[C,P]$ instead of $[C,G]$ as $G$ is used fr the expression of $G=CP$

Here is a more complex negative feedback system, consisting of an additive noise to the feedback and an additive feedback between the controller and the motor
![[Pasted image 20241125172604.png|Full Negative Feedback System|550]]
Here the system can be studied by turning off all inputs but one:
$$Y(s)=Y_R+Y_T+Y_N=W_R(s)|_{N,T=0}R(s)+W_N(s)|_{R,T=0}N(s)+W_T(s)|_{N,R=0}T(s)$$
Here i will list all the transfer functions and then will use them to completely define $Y(s)$
$$\begin{gather}
&W_R(s)=\frac{C(s)P(s)}{1+C(s)P(s)} \\
&W_N(s)=-\frac{C(s)P(s)}{1+C(s)P(s)} \\
&W_T(s)=\frac{P(s)}{1+C(s)P(s)}
\end{gather}$$
Then clearly:
$$Y(s)=\frac{P(s)}{1+C(s)P(s)}(C(s)R(s)+C(s)N(s)+T(s))$$


# 4) Types of a System and Error
Here we can easily define two important objects of study:

>[!def] Type of a System
>Given an **open loop transfer function** $G(s)=C(s)P(s)$ we can write this function by expliciting the poles in 0:
>$$G(s)=\frac1{s^k}\tilde G(s)\text { (with) } \tilde G(s)=s^k C(s)P(s)$$
>Then we say that the transfer function is of **type k** 
>

The type of a system is useful in order to determine the value our error will have at steady state regime:

>[!def] Steady State Regime Error
>From the image above we can find the transfer function of the error as:
>$$E(s)=R(s)-Y(s)=\frac{R(s)}{1+G(s)}$$
>then we can use the [[#^1428a6]] to find the value of the error
>$$e_{ss}^R=\lim_{t\rightarrow\infty}e_{ss}^R(t)=\lim_{s\rightarrow0^+}s\cdot E(s)$$ 

The error depends both on the type of input $R(s)$ and the type of the system. Here is a table to quickly know how the error relates to input and type:

| type | step (1-st int)                        | ramp (2-nd int)                      | ...      | n-th integration                     |
| ---- | -------------------------------------- | ------------------------------------ | -------- | ------------------------------------ |
| 0    | $\displaystyle\frac{1}{1+\tilde G(0)}$ | $\infty$                             | $\infty$ | $\infty$                             |
| 1    | 0                                      | $\displaystyle\frac{1}{\tilde G(0)}$ | $\infty$ | $\infty$                             |
| 2    | 0                                      | 0                                    | $\infty$ | $\infty$                             |
| ...  | 0                                      | 0                                    | ...      | $\infty$                             |
| n-1  | 0                                      | 0                                    | 0        | $\displaystyle\frac{1}{\tilde G(0)}$ |
| n    | 0                                      | 0                                    | 0        | 0                                    |

# 5) Modes and Time Parameters
In this chapter we will define 3 parameters that **characterize the step response**.
- $t_r$ = rise time: $t_r=\min\{t\geq0:|w(t)-w(\infty)|\leq\%|w(\infty)|\}$
- $t_s$ = settling time: $t_s=\min\{t\geq0\forall\tau\geq t|w(\tau)-w(\infty)\leq\%|w(\infty)|\}$
- $s$ = overshoot $s=\sup(\frac{w(t)-w(\infty)}{w(\infty)}\cdot100)\%$

The **rise time** $[1\%\div10\%]$ is the time it takes to the exit to reach for the first time a specific interval around the expected final value.
The **settling time** $[1\%\div10\%]$ is the time it takes to actually remain stable in that interval.
The **overshoot** is the max value that the output reaches on top of the expected output ($\max w(t)-w(\infty)$). But instead of a distance it is defined as a difference in percentual

Notice that $w(t)$ was used to represent the forced output to a unit step $y_f(t)=w(t)=w*u(t)$

## 5.1) First Order System
Suppose we have a system of form
$$\tau y'(t)+y(t)=Ku(t)\rightarrow G(s)=\frac{K}{1+\tau s}$$
This system has exactly one pole (1st order) and no zeros. Notice that $\tau>0$ for BIBO stability.  Moreover, notice that $G(0)=K$ by how we defined the **Evans gain** in the chapter about the bode plot. This system will have the following output:
$$Y(s)=\frac{G(s)}{s}=\frac1s\frac{K}{\tau s+1}=K\left(\frac1s-\frac{1}{s-p}\right)\stackrel{\mathcal L^{-1}}{\rightarrow}y(t)=K(1-e^{-t/\tau})u(t)$$
with $p=-1/\tau$.

We have that: $\lim_{t\rightarrow\infty}y(t)=K$. Notice that if we set $t=\tau$ we end up with: $y(\tau)=K(1-e^{-1})=0.63K$, this means that **$\tau$ is the time it takes to reach 63% of the value.** 

**Rise Time:**
The analysis of the rise time is fairly straight forward. It is just necessary to set $y(t_r)=0.9y(+\infty)$. Then we just have: $y(t_r)=K(1-e^{-t_r/\tau})=0.9K\rightarrow \boxed{t_r=\tau\ln10}$

**Settling Time:**
The analysis is identical as before, since **in a first order system there is no overshoot.** In class we set this value to 0.05, by doing the same calculations as before we end up with: $\boxed{ t_s=\tau\ln20\approx3\tau}$

This means that $t_s$ is directly proportional to $\tau$: $\tau\nearrow\implies t_s\nearrow\implies\text{faster response}$.

![[Pasted image 20241126185325.png|Example of ts|450]]

Now **let's add a zero:**
$$\tau_p y'(t)+y(t)=K(\tau_z u'(t)+u(t))\rightarrow G(s)=K\frac{1+\tau_zs}{1+\tau_p s}$$
Notice that $\tau_p\not=\tau_z, \ \tau_p>0$. As before, the output is:
$$\begin{align}
Y(s)=\frac{G(s)}{s}=\frac Ks+K\frac{\tau_z/\tau_p-1}{s+1/\tau_p}=\frac Ks+K\frac{p/z-1}{s-p}
\stackrel{\mathcal L^{-1}}{\rightarrow}
y(t)=K(1+(\frac{p}{z}-1)e^{pt})u(t)
\end{align}$$
with $p=-\frac1{\tau_p}, \ z=-\frac{1}{\tau_z}$. We can still verify that $\lim_{t\rightarrow\infty}y(t)=K$ but now we have to keep a closer eye to the factor $p/z=\tau_z/\tau_p:=\alpha$ since this changes $t_s$ (and since no overshoot also $t_r$)

$$y(t)=Ku(t)+K(\tau_z/\tau_p-1)e^{-t/\tau_p}u(t)=Ku(t)+K(\alpha-1)e^{-t/\tau_p}u(t)$$

The first term is constant and it is our value at regime (persistent component)
The second term shows from which direction the starting asymptote comes, if $\alpha-1>0$ then the asymptote comes from $+\infty$. In this case $\tau_z>\tau_p>0\implies p<z<0$ and thus the zero is between the pole and the imaginary axis, both on the left side. In the other case the asymptote comes from $-\infty$ and $\tau_z<0\implies z>0$ that is the zero is on the right side of the imaginary axis.

$$\boxed{
\begin{align}
&\text{Recap:}
\\
&\text{-First Order:}\\
&\text{No Zeroes:}\\
&\frac K{1+\tau s} 
&&\begin{cases} t_r=H\tau=2.3\tau\\ t_s=3\tau\\ \text{no overshoot}\end{cases}
\begin{cases} B_p=1/\tau\\ \text{no } M_r\\ \text{no } w_r\end{cases}
\\
&\text{Add One Zero:} 
&&\begin{cases} ???\\ ???\\ ???\end{cases}
 \begin{cases} ???\\ ???\\ ???\end{cases}
\\
&\text{-Second Order, complex conjugates poles} \\
&\text{No Zeroes:}\\
&\frac K{\frac{s}{w_n}^2+2\delta\frac s{w_n}+1} 
&&\begin{cases} t_r=1.8/w_n\\ t_s=3/\delta w_n=3/|\sigma|\\ M_p=e^{-\frac{\delta\pi}{\sqrt{1-\delta^2}}} \\t_p=\frac{\pi}{w_n\sqrt{1-\delta^2}}\end{cases}
\\
&\text{Add One Zero:} 
&&\begin{cases}\tau_z<0 \text{ initial undershoot}\\\tau_z>0 \text{ large, + overshoot, -rise time}\\\tau_Z>0\text{ small, negiglible}\end{cases}
\\
&\text{-Second Order, complex conjugates poles:} \\
&\frac K{(1+\tau_{p1} s)(1+\tau_{p2} s)} 
&&\begin{cases}\tau_1>>\tau_2 \text{ response determined by } \tau_1 \end{cases}
\end{align}}$$


>[!todo] idk
**Rise Time:**
As before $y(t_r)=0.05K\rightarrow t_r=\tau_p\ln\left(\frac{20}{19}(1-\tau_z/\tau_p)\right)\approx\tau_p\ln(1,05(1-\alpha))$
This gives us a harder result to interpret.
>- First of all we have that $\alpha<1\rightarrow\boxed{\tau_z<\tau_p}$ by the logarithm domain conditions. If this condition is not met, as seen before the function starts above $K$ and thus the rise time can't be defined since it is not rising.
>- There is also the case with $t_s<0$, that is when $\alpha<1/20\rightarrow \tau_z<\tau_p/20$. I have no idea how to interpret this result
>
>**Settling time:**
>same as above

## 5.2) Second Order System
#### Real Poles
a
>[!todo]

#### Complex Conjugate Poles
Consider a system of the following type:
$$y''(t)+2\delta w_ny'(t)+w_n^2y(t)=Kw_nu(t)\rightarrow G(s)=\frac{Kw_n^2}{s^2+2\delta w_ns+w_n^2}$$
with $\delta\in[-1,1], w_n>0$ so that there are complex conjugate poles and the system is BIBO.
The with $\delta\in[0,1]$output will be:
$$y(t)=(K-\frac K{\sqrt{1-\delta^2}e^{\sigma t}}\sin(wt+\phi))u(t)$$
with $\sigma =-\delta w_n$, $w=w_n\sqrt{1-\delta^2}$. This will still tend to $K$.

- $\sigma<0$ states how fast the transient oscillation vanishes: $|\sigma|\nearrow\implies\text{faster vanishing}$. If $\rho>0$ the system is unstable and thus it states how fast it destabilises.
- $w$ control the frequency of the transient oscillation: $|w|\nearrow\implies\text{higher oscillation frequency}$

Then the following theorems hold:
>[!thm] $t_r$
>For this system, independently of $\delta\in[0,1]$ we have
>$$t_r\approx\frac{1.8}{w_n}$$

>[!thm] $t_s$
>$$t_s\approx\frac3{\delta w_n}=\frac{3}{|\sigma|}$$

>[!thm] $t_p, y_{\text{max}}, M_p$
>These parameters are computed by solving $dy(t)/dt=0$. Then we arrive to:
>$$\begin{align}
&t_p=\frac\pi{w_n\sqrt{1-\delta^2}}\\
&y_{max}=K(1+e^{-\frac{\delta\pi}{\sqrt{1-\delta^2}}})\\
&M_p\%=100e^{-\frac{\delta\pi}{\sqrt{1-\delta^2}}}
\end{align}$$

If an exercise gives me some requirements:
$$\begin{align}
t_r\leq t_{r,o}&\implies w_n\geq\frac{1.8}{t_{r,o}} \\
t_s\leq t_{s,o}&\implies|\sigma|\geq\frac{3}{t_{s,0}} \\
M_p\leq M_{p,0}&\implies\delta\geq\delta(M_{p,o})
\end{align}$$
these impose 3 areas for the allowed region of the result:
![[Pasted image 20241126201818.png|White area is allowed|450]]
![[Pasted image 20241126201856.png|Area on the left is allowed|450]]
**Add one zero:**
In this case we have:
$$y''(t)+2\delta w_ny'(t)+w_n^2y(t)=Kw_n(\tau_zu'(t)+u(t))\rightarrow G(s)=\frac{Kw_n^2(\tau_zs+1)}{s^2+2\delta w_ns+w_n^2}$$
We can rewrite the transfer function as:
$$G(s)=G_1(s)+\tau_zsG_1(s)\text{ with } G_1(s)=G(s)=\frac{Kw_n^2}{s^2+2\delta w_ns+w_n^2}$$
Then the output will be of form:
$$y(t)=y_1(t)+\tau_z y_1'(t)$$

in this case $\tau_z$ has an important role:
- $\tau_z<0$ the system has an undershoot
- $\tau_z>0 \nearrow\implies\text{overshoot}\nearrow, \ t_s\searrow$ 


>[!thm] Higher order
>For higher order systems we only care about the slowest pole, that is, the one nearest to the origin

# 6) Root Locus
Given a **open loop transfer function** $G(s)$ we can plot it's poles in a complex plane. These poles will evolve with the system if it is in a closed loop and thus change location. We will see how to study this movement and find some rules. It is important to notice that $G(s)$ should be in a form where the gain is parametric and the poles in 0 explicated: $G(s)=\frac K{s^k}\tilde G(s)$. The parameter is important as we will be able to set specific values as the new poles.

We have that
$$G(s)=\frac K{s^k}\tilde G(s)\rightarrow W(s)=\frac{K\tilde G(s)}{s^k+K\tilde G(s)}$$
moreover let $\tilde G(s)=\frac{p(s)}{q(s)}$
$$G(s)=\frac K{s^k}\tilde G(s)\rightarrow W(s)=\frac{Kp(s)}{s^kq(s)+Kp(s)}$$

We will study how the poles will form based on $s^kq(s)+Kp(s)$. Keep in mind that $K\in\mathbb R/\{0\}$ and we define 2 different locus': the **positive locus** for $K>0$ and **negative locus** for negative values, we will focus on the positive locus:

>[!thm] 1st Property: Appartenece
>A point $s$ is in the locus iff:
>- $\arg[G(s)]=\arg[s^kq(s)]-\arg[p(s)]=\pi$
>- $K=|\frac{s^kq(s)}{p(s)}|$

>[!thm] 2nd Property: Lines Start
>There are $n$ lines starting from the $n$ poles of $G(s)$. If a pole has a molteplicity $\mu$, then $\mu$ lines start from there

>[!thm] 3rd Property: Real Axis Appartenence
>The parts of the real axis belonging to the locus are those that have on the right an odd number of real poles and zeroes of $G(s)$

^dca292

>[!thm] 4th Property: Conjoined Symmetry
>That is: every line not in the real axis, there is another that is the mirror image to the real axis

>[!thm] 5th Property: Lines End
>The lines end in the zeroes of $G(s)$ or at infinity.
>Exactly $m$ (degree of **numerator**) lines go to the zeroes and $n-m$ to infinity (only if $n>m$).
>
>The divergent lines will follow some asymptotes. These asymptotes will: 
>- Have the center of the asymptotes at $\displaystyle C=\frac{\sum p_i-\sum z_i}{n-m}$, only if $n-m\geq2$.
>- Have asymptotic directions in the equally spaced directions starting from $\pi/(n-m)$

>[!thm] 6th Property: Multiple Points
>The equation that solves the case of multiple points is:
>$$s^kq(s)\frac{dp(s)}{ds}=p(s)\frac{ds^kq(s)}{ds}$$
>The acceptable solutions is the one with $s<0\in \text{locus}$. These are the points where the poles meet to leave and/or meet to join the real axis.
>If you substitute the obtained value in $s^kq(s)+Kp(s)=0$ and solve for $K$ you get the values for which $W(s)$ has poles in those points. The only solutions $s$ that are acceptable are those that return $K>0\in\mathbb R$.
>

How to draw:
1) Write all poles and zeroes. Write the degree of the **numerator** $m$ and the **denominator** $n$. Compute $n-m$.
2) if $n-m\geq2$ calculate C and the angles $\pi/n-m$. (if $n-m=1$ then the angle is $\pi$, otherwise 0). 
3) Draw all the poles and zeros. 
4) Connect all poles and zeros on the real line keeping in mind [[#^dca292]].
5) If you can, calculate $s^kq(s)\frac{dp(s)}{ds}=p(s)\frac{ds^kq(s)}{ds}$. Check if the solution is acceptable. Solve $s^kq(s)+Kp(s)=0$ with the obtained values in order to find K where they first encounter
7) ???
8) profit



# 7) Bode Diagram
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
W(s)=\frac{b_m}{a_n}\frac{(s-z_1)...(s-z_m)}{(s-p_1)...(s-p_n)}
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

>[!remark|*]
>One final remark regards the bode form. Usually every pole is expressed in the form $1+s/w$ if instead it is written as $1-s/w$ then the phase will have the opposite contribution.
>In the case of a second degree expression check if it is a pair of real poles and rewrite them. If it is the case of complex poles then the phase will be different only if the first degree term has a negative factor.
## 7.2) Constant Term
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
## 7.3) Pole in Origin
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

## 7.4) Real Poles and Zeroes
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
## 7.5) Complex Conjugate Poles and Zeroes
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
## 7.6) How to Draw a Bode Diagram With Multiples Zeroes and Poles
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

1) Draw every single line corresponding to every zero/pole/constant term
2) In the resulting plot, every point will have a slope corresponding to the sum of the slopes of every line in that point
3) When the phase has a constant attribution add\subtract it

# 8) Nyquist Diagram

^6858d8

The Nyquist Diagram consists in plotting the real and imaginary parts of the transfer function in cartesian coordinates $\forall w\in\mathbb R$. Due to the nature of a transfer function we have that $H(jw)=\Re H(jw)+\Im H(jw)=|H(jw)|e^{j\arg H(jw)}$ and thus the Nyquist plot also tells us information between the magnitude and the phase making it heavily connected to [[#7) Bode Diagram]].

Since we consider LTI systems with real-valued impulse response we have that $H(jw)$ has hermitian symmetry and thus it is necessary to determine the plot only for $w>0$. More precisely we need to find the values at $w\rightarrow0^+$ and $w\rightarrow+\infty$ for both the phase and magnitude.

Suppose to have $$H(s)=C\frac{b_m}{a_n}\frac{(s-z_1)...(s-z_m)}{(s-p_1)...(s-p_n)}$$
Where we define $K=C\frac{b_m}{a_n}$ as the Evans gain that can be obtained by setting $H(0)=K$ and ignoring the poles at 0.
## 8.1) Study what happens when $w\rightarrow0^+$
#### No Pole/Zero at Origin
In this case the nyquist diagram tends to a point on the real axis, that is at
$$\lim_{w\rightarrow 0^+}H(jw)=K$$
The departing angle is given by:
$$\varphi_d=\lim_{w\rightarrow0^+}\arg[H(jw)-K]$$
where $H(jw)-K$ can be rewritten as $W(s)=H(s)-K=K(\frac{(s-z_1)...(s-z_m)-s^h\cdot(s-p_1)...(s-p_n)}{s^h\cdot(s-p_1)...(s-p_n)})$.
#### Zero at Origin
In this case the nyquist diagram tends to the origin of the complex plane.
The departure angle is a multiple of $\pi/2$:$$\varphi_d=\begin{cases}
+|h|\frac\pi2, \ &\text{ if } K>0 \\
-|h|\frac\pi2, \ &\text{ if } K<0
\end{cases}$$
#### Pole at Origin
In this case the diagram tends to $\infty$:
$$\lim_{w\rightarrow0^+}H(jw)=\infty$$
The departure angle is a multiple of $\pi/2$:$$\varphi_d=\begin{cases}
-|h|\frac\pi2, \ &\text{ if } K>0 \\
+|h|\frac\pi2, \ &\text{ if } K<0
\end{cases}$$
In this case it is possible to delete the pole by using the following approximation $\hat H(s)=sH(s)$.  
## 8.2) Study what happens when $w\rightarrow+\infty$
Depending on the Degrees of the Numerator (m) and Denominator (n) we can find the following results:
#### $m=n$
$H(s)$ tends to a point on the real axis
$$\lim_{w\rightarrow+\infty}H(jw)=K$$
With angle:
$$\varphi_a=\lim_{w\rightarrow0^+}\arg[H(jw)-K]$$
#### $m<n$
$H(s)$ tends to the origin of the complex plane
$$\lim_{w\rightarrow+\infty}H(jw)=0$$
With angle:
$$\varphi_a=\begin{cases}
-\frac\pi2|n-m|, \ &\text{ if } K>0 \\
+\frac\pi2|n-m|, \ &\text{ if } K<0
\end{cases}$$
#### $m>n$
This system isn't casual anymore and not proper. The diagram will go to $\infty$ but we won't see these cases in practice


## 8.3) Axis Intersection
In some simpler cases it is possible to determine the intersections with the real and imaginary axis:
## 8.4) Relation With Bode Plot
As stated in the intro of the chapter the Nyquist plot is related to both phase and magnitude. Therefore it is possible to get some infos on how to draw the Nyquist diagram from the Bode plot.
#### Magnitude Bode Plot
Bode diagram shows the magnitude in $dB$ for every value of $w$. By converting the values back to absolute values it is possible to determine the magnitude (the length) of the vector at any given $w$
#### Phase Bode Plot
Here the values of w can be directly seen in the plot. **If the phase grows, the plot turns counterclockwise, if it decreases the plot turns clockwise.**


## 8.5) Steps to Correctly Draw an Approximation Of The Bode Plot
1) Draw a Bode Plot of $H(s)$ for both magnitude and phase

2) Write $H(jw)$ by also specifying real and imaginary part

3) Study at $w\rightarrow0^+$
The magnitude can easily be found by the bode plot: $\lim_{w\rightarrow0^+}H(jw)=K$
The phase is $\lim_{w\rightarrow0^+}\arctan[H(jw)-K]$
To do this you must find $H(jw)-K=\Re+\Im\rightarrow\arctan(\Im/\Re)$
Keep in mind that if the real part tends to a negative value you must add $\pi$ to the result
>[!example|*]
>This is computed for $w\rightarrow\infty$ (step 4))
>$H(jw)=\frac{1}{1-w^2}+j\frac{w}{1-w^2}$ The Real part tends to $-\infty$, thus the angle is
>$$\pi+\lim_{w\rightarrow\infty}\arctan[w]=\pi+\frac\pi2=\frac32\pi$$

If $K\rightarrow\infty$ or $K\rightarrow 0$ then the phase can be seen by bode

4) Study at $w\rightarrow\infty$
Same as step 3)

5) Compute $\Re(0),\Re(\infty), \Im(0),\Im(\infty)$ 

6) deduce the rotation from the angle of the phase bode plot. Angle increasing, counterclockwise rotation; decreasing, clockwise.

7) study what happens at the imaginary poles $w\rightarrow w_p^\pm$
Here we might find useful informations on asymptotes.
First compute $\lim H(jw)$ if it is infinity compute $\lim \Re$ and $\lim\Im$ if both are infinity compute oblique asymptote: $m=\lim\frac\Im\Re$, $q=\lim\Im-m\Re$ the asymptote is $y=mx+q$

8) Study the sign of $\Re, \Im$. Recall that $w\geq0$
# 9) Stability Margins
Let's start by stating an important theorem:
>[!thm] Nyquist Criterion
>By looking at the open loop transfer function $G(s)=P(s)C(s)$ and denote with $p$ all the poles on the right hand side of the imaginary axis. Then the system is BIBO stable iff the Nyquist plot doesn't pass through the critical point $-1+j\cdot0$ and encircles it p times counterclockwise

^108753

3 scenarios might happen:
1) No encirclement $\rightarrow$ it is BIBO stable iff it has 0 poles on the RHP
2) $N\geq1$ counterclockwise rotations around $-1\rightarrow$ it is stable iff it has $N$ poles on the RHP
3) Passes through -1 or clockwise rotations $\rightarrow$ system is unstable

We can define 2 frequencies:
$$\begin{align}
&\text{Gain Crossover Frequency: }&&w_{gc}=w:|G(w)|=1 \\
&\text{Phase Crossover Frequency: }&&w_{pc}=w:\arg G(w)=-\pi
\end{align}$$
Notice that both frequencies might be 0.
>[!col]
>For systems of higher order this criterion is useful since by plotting bode for $G(s)$ it is possible to see via $w_{fc}$ and $w_{pc}$ some of the useful crossing points
>$|G(w_{fc})|<1$
>
>![[Pasted image 20241211164514.png|Example|350]]


# 10) Recap

^d685c2

In this chapter I will recap the most important aspects to remember. The terminology is the following:
$$\begin{align}
&G(s)=\frac{p(s)}{q(s)}=C(s)P(s)=\frac{\tilde G(s)}{s^k}, \ \text{ where k is the mode of the system} \\
&W(s)=\frac{G(s)}{1+G(s)}= \frac{p(s)}{q(s)+p(s)}, \ \text{closed loop transfer function}\\
\end{align}$$
## 10.1) Stability and Errors
To check the BIBO stability of a transfer function we must see if the denominator is a [hurwitz polynomial][#^326f11], that is **all roots have negative real part**. To do so we can use various criteria:
- If of type $as^2+bs+c$ then it is hurwitz if $a,b,c$ all have the same sign
- If a $n$-th degree polynomial it is unstable if it has a null coefficient and/or a sign change in the coefficients. If it doesn't have them the stability can be studied via [[#^d56942]]
- If We want to study the stability of $W(s)$ we can build the root locus of $G(s)$ and check from there

The type of a system is determined by it's poles in the origin. Once you identify the type, you can find it's closed loop transfer function error with the following table:

| type | step (1-st int)                        | ramp (2-nd int)                      | ...      | n-th integration                     |
| ---- | -------------------------------------- | ------------------------------------ | -------- | ------------------------------------ |
| 0    | $\displaystyle\frac{1}{1+\tilde G(0)}$ | $\infty$                             | $\infty$ | $\infty$                             |
| 1    | 0                                      | $\displaystyle\frac{1}{\tilde G(0)}$ | $\infty$ | $\infty$                             |
| 2    | 0                                      | 0                                    | $\infty$ | $\infty$                             |
| ...  | 0                                      | 0                                    | ...      | $\infty$                             |
| n-1  | 0                                      | 0                                    | 0        | $\displaystyle\frac{1}{\tilde G(0)}$ |
| n    | 0                                      | 0                                    | 0        | 0                                    |

To calculate the values at $t\rightarrow\infty$ you can use [[#^1428a6]].

## 10.2) Routh Table
We want to check if a polynomial satisfies [[#^326f11]]. Here is an example of how to build such a table with the following polynomial: $a_4s^4+a_3s^3+a_2s^2+a_1s+a_0$

![[6487.png|Example of table 1|350]] 
![[77491.png||]]
Notice how the 0 was put since there wasn't any coefficient to add.
If in the first column the table has a 0 it is incomplete. We substitute that 0 with $\varepsilon\rightarrow0^+$ and compute the routh table

Once you complete the table you can inspect the coefficients in the first column. They must all have the same sign in order for the polynomial to be hurwitz. Any sign change is an instability point. Moreover you can build the table using parameters. If by any chance a coefficient

## 10.3) Root Locus
The root locus shows how the poles of $G(s)$ evolve in $W(s)$. There are a bunch of quick rules to follow. In the instructions I only refer to G(s). Call $n$ the degree of the denominator (# of poles) and $m$ the degree of the numerator (# of zeroes). **Every multiplicity is included**:
1) All poles go to one and only one zero. If there is a different numbers of poles and zeroes some find their match asymptotically.
2) The asymptotes are all lines starting from $C=\frac{\sum p_i-\sum z_i}{n-m}$ with equally spaced angles $\frac\pi{n-m}$
3) The real axis that belongs to the root locus is the one that has an odd number of poles and zeroes to it's right. All lines leave/enter with a $\pm90\textdegree$ angle.
4) Extra: If possible compute $q(s)\frac{dp(s)}{ds}=p(s)\frac{dq(s)}{ds}$. To find the points in which poles meet. With said $s$ it is possible to compute the values of $K$ for which they meet by substituting in $q(s)+p(s)=0$.

## 10.4) Approximations
Here is a series of useful approximations:
- Settling Time: $T_s=5\tau$ with $\tau=\frac{-1}{p}$ with $p<0$ the slowest (aka biggest pole)
- The damping factor $\delta$ is connected with the overshoot $M=e^{\frac{-\delta\pi}{\sqrt{1-\delta^2}}}\in[0,1]$ and also to the second degree equation $\frac{s}{w_n}^2+\frac{2\delta}{w_n}s+1$ and the phase margin associated to the open loop transfer function
- $w_B=w_{gc}$

## 10.5) Laplace
Everything expressed with the variable $s$ is in the Laplace domain. Here I will write the rules on how to do the inverse transform. 

Reduce the polynomial if possible
Use the partial fraction expansion that has the following rules:
Let $F(s)$ have n poles. Then it can be rewritten as:
$$F(s)=\frac{N(s)}{(s-\lambda_1)(s-\lambda_2)...(s-\lambda_n)}=\frac{A}{(s-\lambda_1)}+\frac{B}{(s-\lambda_2)}+...$$
The factors can be found in the following ways:
- **If the poles are real and different from each other:**$$A=\lim_{s\rightarrow\lambda}(s-\lambda)Y(s)$$
- **If the poles are real and 2 or more have the same value:**
	For those values the expansion will have the following form:$$\frac{A}{(s-\lambda)^n}+\frac{B}{(s-\lambda)^{n-1}}+...+\frac{N}{(s-\lambda)^{n-k}}+...\implies
\begin{align}
&A=\lim_{s\rightarrow\lambda}(s-\lambda)^nY(s) \\
&B=\lim_{s\rightarrow\lambda}\frac{d}{ds}[(s-\lambda)^{n}Y(s)] \\
&\vdots \\
&N=\lim_{s\rightarrow\lambda}\frac{1}{k!}\frac{d^{k}}{ds^{k}}[(s-\lambda)^nY(s)]
\end{align}$$
- **If the poles are complex valued**:
	Usually the poles will be a couple of coniugate complex poles: 
$$\frac{A}{(s-\sigma-j\omega)}+\frac{\overline A}{(s-\sigma+j\omega)}\implies
\begin{align}
&A=\lim_{s\rightarrow\sigma+j\omega}(s-\lambda)Y(s) \\
&\overline A=\lim_{s\rightarrow\sigma-j\omega}(s-\lambda)Y(s) \\
\end{align}$$That is exactly like the normal rational case, but the anti transform will be slightly different
The **anti transformation** is really simple by keeping in mind the following table:

| Transform                                                    |                                                                          | Properties                                                            |
| ------------------------------------------------------------ | ------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| $\delta(t)\stackrel{\mathcal L}{\rightarrow}1$               |                                                                          | $x(t+\beta)\stackrel{\mathcal L}{\rightarrow}e^{\beta s}X(s)$         |
| $u(t)\stackrel{\mathcal L}{\rightarrow}1/s$                  | $t^ku(t)\stackrel{\mathcal L}{\rightarrow}k!/s^{k+1}$                    | $e^{\beta t}x(t)\stackrel{\mathcal L}{\rightarrow}X(s-\beta)$         |
| $e^{\sigma t}\stackrel{\mathcal L}{\rightarrow}1/(s-\sigma)$ | $t^ke^{{\sigma t}}\stackrel{\mathcal L}{\rightarrow}k!/(s-\sigma)^{k+1}$ | $t^nx(t)\stackrel{\mathcal L}{\rightarrow}(-1)^n\frac{d^n}{ds^n}X(s)$ |
In the complex case $\omega\not=0$ and thus it is a bit more hard, but the inverse transform works the same
$$\frac{A}{s-(\sigma+j\omega)}\stackrel{\mathcal L^{-1}}{\rightarrow}Ae^{(\sigma+j\omega)t}=\mathopen\mid A\mathopen\mid e^{j\angle A}e^{(\sigma+j\omega)t}$$
if there are two complex conjugates:
$$\boxed{\frac{A}{(s-\sigma-j\omega)}+\frac{\overline A}{(s-\sigma+j\omega)}\stackrel{\mathcal L^{-1}}{\rightarrow}Ae^{(\sigma+j\omega)t}+\overline Ae^{(\sigma-j\omega)t}=2\mathopen\mid A\mathopen\mid e^{\sigma t}\cos(\omega t+\angle A)}$$
Last but not least we introduce one important property of the Laplace transform: 

In control systems we will study systems of differential equations, so the following property is really important:$$\boxed{ \begin{align}
&\mathcal{L}\left(\frac{d}{dt}x(t)\right)= sX(s)-x(0-) \\
&\mathcal{L}\left(\frac{d^n}{dt^n}x(t)\right)= s^nX(s)-s^{n-1}x(0-)-s^{n-2}x'(0-)-...-x^{(n-1)}(0-)
\end{align}}$$
Usually we will have an equation of the following type $\alpha y''+\beta y'+\gamma y=u(t)$. By applying the previous property and by explicating $Y(s)$ we will end up with the following equation:
$$Y(s)=\frac{C(s)}{A(s)}+\frac{B(s)}{A(s)}U(s)=Y_n(s)+Y_f(s)$$
- $Y_n(s)$ is called the *free/natural evolution* and **depends only on initial conditions and zero input**
- $Y_f(s)$ is called *forced evolution* and **depends on the input and zero initial conditions**
## 10.6) Bode and Nyquist
### 10.6.1) Bode
First of all find the gain by setting $W(0)$ and transform it in dB. If there is a pole/zero in the origin it will pass trough here. Otherwise it will add/subtract a contribution.

The poles/zeroes in the origin give a contribution along all $w$ values.

Find the poles/zeroes not in the origin and then their log values. The contribution will start from here.

Magnitude Contributions:
- Constant: already explained
- Pole: Each Multiplicity $-20dB/dec$
- Zero: Each Multiplicity $20dB/dec$ 
Phase Contributions:
- Constant: 0 if positive (linear scale), otherwise $\pm180^\circ$
- Pole: $-90^\circ$ if in form $1+s/w$, if in form $1-s/w$ then $90^\circ$
- Zero: $90^\circ$ if in form $1+s/w$, if in form $1-s/w$ then $-90^\circ$

From this diagram you can find $w_{gc}$ every time the plot passes through 0 and $w_{fc}$ every time it passes at $\pm180^\circ$.

### 10.6.2) Nyquist
Use $w_{gc}, w_{fc}$ to get clues of where the plot goes through
With bode find the values of the magnitude (linear) at $w\rightarrow 0^+,w\rightarrow\infty$
If the phase plot decreases clockwise, if it increases counterclockwise (exactly like right hand rule!)
Find $W(jw)=\Re+j\Im$ and gather some info from here!

We will use it mainly for [[#^108753]]. If it circles $-1+j0$ p times and doesn't pass through it it will be stable with p all the unstable poles. 