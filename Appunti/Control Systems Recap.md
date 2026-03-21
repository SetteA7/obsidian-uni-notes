# 1) Control Systems Recap
In this chapter I will recap the most important aspects to remember. The terminology is the following:
$$\begin{align}
&G(s)=\frac{p(s)}{q(s)}=C(s)P(s)=\frac{\tilde G(s)}{s^k}, \ \text{ where k is the mode of the system} \\
&W(s)=\frac{G(s)}{1+G(s)}= \frac{p(s)}{q(s)+p(s)}, \ \text{closed loop transfer function}\\
\end{align}$$
## 1.1) Stability and Errors
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

## 1.2) Routh Table
We want to check if a polynomial satisfies [[#^326f11]]. Here is an example of how to build such a table with the following polynomial: $a_4s^4+a_3s^3+a_2s^2+a_1s+a_0$

![[6487.png|Example of table 1|350]] 
![[77491.png||]]
Notice how the 0 was put since there wasn't any coefficient to add.
If in the first column the table has a 0 it is incomplete. We substitute that 0 with $\varepsilon\rightarrow0^+$ and compute the routh table

Once you complete the table you can inspect the coefficients in the first column. They must all have the same sign in order for the polynomial to be hurwitz. Any sign change is an instability point. Moreover you can build the table using parameters. If by any chance a coefficient

## 1.3) Root Locus
The root locus shows how the poles of $G(s)$ evolve in $W(s)$. There are a bunch of quick rules to follow. In the instructions I only refer to G(s). Call $n$ the degree of the denominator (# of poles) and $m$ the degree of the numerator (# of zeroes). **Every multiplicity is included**:
1) All poles go to one and only one zero. If there is a different numbers of poles and zeroes some find their match asymptotically.
2) The asymptotes are all lines starting from $C=\frac{\sum p_i-\sum z_i}{n-m}$ with equally spaced angles $\frac\pi{n-m}$
3) The real axis that belongs to the root locus is the one that has an odd number of poles and zeroes to it's right. All lines leave/enter with a $\pm90\textdegree$ angle.
4) Extra: If possible compute $q(s)\frac{dp(s)}{ds}=p(s)\frac{dq(s)}{ds}$. To find the points in which poles meet. With said $s$ it is possible to compute the values of $K$ for which they meet by substituting in $q(s)+p(s)=0$.

## 1.4) Approximations
Here is a series of useful approximations:
- Settling Time: $T_s=5\tau$ with $\tau=\frac{-1}{p}$ with $p<0$ the slowest (aka biggest pole)
- The damping factor $\delta$ is connected with the overshoot $M=e^{\frac{-\delta\pi}{\sqrt{1-\delta^2}}}\in[0,1]$ and also to the second degree equation $\frac{s}{w_n}^2+\frac{2\delta}{w_n}s+1$ and the phase margin associated to the open loop transfer function
- $w_B=w_{gc}$

## 1.5) Laplace
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
## 1.6) Bode and Nyquist
### 1.6.1) Bode
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

### 1.6.2) Nyquist
Use $w_{gc}, w_{fc}$ to get clues of where the plot goes through
With bode find the values of the magnitude (linear) at $w\rightarrow 0^+,w\rightarrow\infty$
If the phase plot decreases clockwise, if it increases counterclockwise (exactly like right hand rule!)
Find $W(jw)=\Re+j\Im$ and gather some info from here!

We will use it mainly for [[#^108753]]. If it circles $-1+j0$ p times and doesn't pass through it it will be stable with p all the unstable poles. 