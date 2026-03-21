# 1) Intro and Recap
I will base these notes on both the lecture notes and the book DSP first.  [this](https://vabbebeddiamo.ddns.net/admin/media/files/Drive/Uni/Books/MacClellan%2C%20James%20H._%20Schafer%2C%20Ronald%20W._%20Yoder%2C%20Mark%20A%20-%20DSP%20First%20(2017%2C%20Pearson)%20-%20libgen.li.pdf)
## 1.1) Complex Numbers
Here is a really quick recap of useful formulas
$$\begin{align}
&\text{Magnitude: } &|z|&=\sqrt{a^2+b^2} \\
&\text{Phase: } &\arg z&=\arctan\frac ba \\
&\text{Complex Conjugate: } &z^*&=a-jb \\
&\text{Euler's Identity: } &e^{jw}&=\cos(w)+j\sin(w)\\
&\text{Polar Representation: } &\cos(w)&=\frac{e^{jw}+e^{-jw}}{2} \\
& &\sin(w)&=\frac{e^{jw}-e^{-jw}}{2j} \\
\end{align}$$
Moreover, let $z_i=a_i+jb_i$, then 
$$\begin{align}
z_1+z_2 &= (a_1+a_2)+j(b_1+b_2) \\
z_1z_2 &= (a_1a_2-b_1b_2)+j(a_1b_2+a_2b_1) \\
|z_1z_2|&=|z_1||z_2|\\
\arg(z_1z_2)&=\arg(z_1)\arg(z_2)
\end{align}$$

What about **Complex Exponentials**?
A complex exponential is a function of type $x(t)=Ae^{z t}$ with $A=|z|$ and $z=\sigma+j\omega$
We can rewrite it as $x(t)=|z|e^{\sigma t}\cos(\omega t+\sigma)+j|z|e^{\sigma t}\sin(\omega t+\sigma)$
And thus we also have: $Ae^{j\omega t}=A\cos(\omega t)+jA\sin(\omega t)$
## 1.2) Signals
**Signals** are essentially functions on which we define some properties in order to classify them and add better and more in depth analysis tools.

>[!def|*] Signal Classification
>- Number of independent variables
>- Continuous or discrete variables

We can even identify some symmetries:

| Even         | Odd           | Hermitian      |
| ------------ | ------------- | -------------- |
| $x(t)=-x(t)$ | $x(t)=-x(-t)$ | $f(x)^*=f(-x)$ |
any signal can be decomposed into an even and an odd part:
$$x(t)=x_e(t)+x_o(t)=\frac{x(t)+x(-t)}2+\frac{x(t)-x(-t)}2$$

We can define the following properties:
>[!def|*] Signal Energy and Power
>We define the energy of a signal as $$E=\int|x(t)|^2dt$$
>And the average power as $$P=\lim_{T\rightarrow\infty}\frac{1}{T}\int_{-\frac T2}^{\frac T2}|x(t)|^2dt$$

Recall these important results:
>[!thm|*] Notable Powers
>$$P[\cos^k(t)]=\lim_{x\rightarrow\infty}\frac{1}{2x}\int_{-x}^x\cos^{2k}(t)dt=\frac{(2k)!}{2^{2k}(k!)^2}$$
>Moreover the following holds:
>$$\lim_{x\rightarrow\infty}\frac{1}{2x}\int_{-x}^x\cos^k(t)dt=
\begin{cases}
0, \ \text{if }k\text{ odd} \\
P[\cos^{\frac k2}(t)], \ \text{if }k\text{ even}
\end{cases}$$
>$$\lim_{x\rightarrow\infty}\frac{1}{2x}\int_{-x}^x\cos^a(\alpha t)\cos^b(\beta t)dt=0, \ \text{if one between }a,b\text{ is odd} $$
>$$\begin{align}
&k &&\rightarrow k \\
&\cos(\alpha t) &&\rightarrow 0 \\
&A\cos^2(\alpha t) &&\rightarrow \frac{A^2}{2} \\
&A[\cos(\alpha t)\cos(\beta t)] &&\rightarrow 0, \ &\forall \alpha\not=\beta \\
&A[\cos^2(\alpha t)\cos^2(\beta t)] &&\rightarrow \frac{A^2}4, \ &\forall \alpha\not=\beta \\
&A[\cos^m(\alpha t)\cos^n(\beta t)] &&\rightarrow 0, \ &\forall \alpha\not=\beta &\text{ and at least one odd between } m,n
\end{align}$$
>For powers in a finite interval of one period $T$:
>$$\begin{align}
\cos(\alpha t)&\rightarrow 0 &&\text{ if } \alpha >>1/T \\
A\cos^2(\alpha t)&\rightarrow \frac12A^2T &&\text{ if } \alpha >>1/T
\end{align}$$

The very important signals are:

>[!def|*] Unit Sample
>This is the fundamental signal, defined by:
>$$\delta(nT)=
>\begin{cases}
>\frac{1}{T} &n=0 \\
>0 &n=0
>\end{cases}$$
>usually we have that $T=1$

>[!def|*] Unit Step
>$$u[t]=\begin{cases}1,\ n\geq0\\0, \ n<0\end{cases}$$

Moreover $\delta[n]=u[n]-u[n-1]$.

Recall than any discrete sequence can be represented with the unit step:
>[!theorem|*] Discrete sequence with dirac
>$x[n]=\delta[n]*x[n]=\sum_k x[n]\delta[n-k]=\sum_k x[n-k]\delta[n]$

^a9343c

## 1.3) Systems
A **system** is essentially an operator which can be either a known one or, what we'll actually study, more complex ones.

Some elementary systems are the ones that create a time shift/scaling and also amplitude shift/scaling.

>[!def|*] System Classification
>- Number of input signals
>- Number of output signals
>- Types of processed signals

The output to a system is given by the convolution between the system and the signal

TODO Convolution
 For two real valued discrete functions defined, one in $[a,b]$ and the other in $[c,d]$, the convoilution will benon zero in $[a+c,b+d]$. The length will therefore be $N+M-1$ with N,M the klength of the two convolutions

One quick way to calculate the cinvolutio. Is by calculating all the values in this interval individually. To do so we use this rule:
- the sum of each sample product in the convolution sum is equal to the index sample being generated. To calculate the n-th sample we start from $x[0]$ and go up to $x[n]$ and and set the correct coefficient in $h[]$

>[!todo] Frequency + Sampling
# 2) FIR Filters
In this course will mainly study two categories of filters. FIR and IIR. Let's start with the first

FIR filters have finite impulse response to a finite length signal.

This filter can be seen as a sliding window along $x[n]$

Real time applicationbs can use non-causal filters, however we will focus on causal filters $\rightarrow$ only use past and current samples, not future ones. 

There are two equivalent forms of expressing the FIR filter. The general form uses the general difference equation:
$$y[n]=\sum_{k=0}^Mb_kx[n-k]$$
Or by substitution we obtain:
$$y[n]=\sum_{l=n-M}^nb_kx[l]$$
We call M the **filter order** and the **filter length** (the samples it uses) is $L=M+1$.

Moreover, **since $b_k$ fully determines the FIR filter** we can call it $h[k]$

When the input to such a filter is the unit step, the result is just the coefficient of the EDO of $y[n]$ times the unit sample at that point(see [[#^a9343c]]). A filter of $N^{th}$ order has a response of $N+1$ samples.

If the coefficients are all the same we have a running average filter, if they are different we have a weighted average filter

Suppose to have a signal with $N$ sampels andf a filter with order $M$ (recall M+1 is the length) then at the output we have that
- **output interval support** in the interval $0\leq n\leq N+M-1$
- **output length** of $N+M$ (since 0 is also counted)
- It is shifted by $\lfloor M/2\rfloor$ samples

An easy way to fix the delay given by the filter is to concatenate it with a advancing system. This system will be $\delta[n+k]$ and thus the resulting system will be:
$$y[n]=x[n]*h[n]*\delta[n+k]=x[n]*h[n+k]$$

>[!theorem]
>A system defined by an FIR filter is LTI

#### FIR Building Blocks
To implement any FIR filter we need some multipliers, adders and delayer. We can represent these using building blocks:
![[Pasted image 20241004182036.png|The most common FIR Building Blocks|350]]
With these it is possible to represent any FIR filter
![[Pasted image 20241004182234.png|Example|350]]
With these it is also possible to give different definitions of the system properties defined in signal and systems

>[!def] Linearity Diagram
>![[Pasted image 20241004182501.png|Definition|350]]

>[!def] Time-Invariance Diagram
>![[Pasted image 20241004182544.png|Definition|350]]

## 2.2) LTI Systems and Convolutions

LTI stands for Linear Time Invariant. Recall that any FIR filter is LTI but not all LTI systems are FIR filters. If the input to a system is the dirac delta then the output is the filters impulse response $h[n]$: $\delta[n-l]\rightarrow h[n-l]$, moreover $x[l]\delta[n-l]\rightarrow x[l]h[n-l]$ and finally $x[n]=\sum x[l]\delta[n-l]\rightarrow y[n]=\sum x[l]h[n-l]$. This means that LTI systems can be expressed by a convolution sum: $$y[n]=x[n]*h[n]$$
>[!thm] LTI system properties
>- **Convolution with impulse:** $x[n]*\delta[n-n_0]=x[n-n_0]$
>- **Commutativity:** $x[n]*h[n]=h[n]*x[n]$
>- **Associativity:** $(x_1[n]*x_2[n])*x_3[n]=x_1[n]*(x_2[n]*x_3[n])$
>These are the same properties of a convolution

The response ofa system to a sinusoidal input can be simplified by using euler’s identity.
Suppose to have a continuous time signal of type
$$x(t)=Ae^{j\phi}e^{j\omega t}$$
Then we can obtain the discrete signal by sampling it
$$x[n]=Ae^{j\phi}e^{j\hat\omega n}$$
where $\hat w=\omega T_s$ with $T_s$ the sampling period.

The output will present the frequency response $\mathcal H(w)=\sum b_ke^{-jwn}$ since
$$\begin{align}
y[n]&=\sum_{k=0}^Mh[k]x[n-k]\\
&=\sum_{k=0}^M h[k]e^{-j\hat\omega k}Ae^{j\phi}e^{j\hat \omega n}\\
&=\mathcal H(\hat w)Ae^{j\phi}e^{j\hat \omega n}
\end{align}$$
Since the frequency response is complex valued we can write it as $\mathcal H(\hat\omega)=|\mathcal H(\hat \omega)|e^{j\angle\mathcal H(\hat\omega)}$

>[!example|*]
>Let $x[n]=Ae^{j\phi}e^{j\hat\omega n}$, then as seen above we have $$\begin{align}
y[n]&=|\mathcal H(\hat\omega)|e^{j\angle\mathcal H(\hat\omega)}\cdot Ae^{j\phi}e^{j\hat\omega n}\\
&=A|\mathcal H(\hat\omega)|e^{j(\phi+\angle{\mathcal H(\hat\omega)})}e^{j\hat\omega n}
\end{align}$$

This shows that we have an additional phase shift and gain.

The **superposition holds**, therefore a signal of type $$x[n]=A+B\cos(\omega n+\phi)=Ae^{j\cdot 0n}+\frac B2e^{j\phi}e^{j\omega n}+\frac B2e^{-j\phi}e^{-j\omega n}$$
Has an immediate response of type
$$\begin{align}y[n]&=\mathcal H(0)A+\mathcal H(\hat\omega)\frac B2e^{j\phi}e^{j\omega n}+\mathcal H(-\hat\omega)\frac B2e^{-j\phi}e^{-j\omega n}\\
&=\mathcal H(0)A+|\mathcal H(\hat\omega)|\frac B2e^{j(\phi+\angle\mathcal H(\hat\omega)}e^{j\omega n}+|\mathcal H(\hat\omega)|\frac B2e^{-j(\phi+\angle\mathcal H(\hat \omega)}e^{-j\omega n}\\
&=\mathcal H(0)A+|\mathcal H(\hat \omega)|B\cos(\omega n+\phi+\angle \mathcal H(\hat\omega))
\end{align}$$
Where the last term was manipulated using the properties of the real valued impulse response:
- $|H(w)|$ is even: $|H(-w)|=|H(w)|$
- $\angle H(w)$ is odd: $\angle H(-w)=-\angle H(w)$

As a recap:
$$\boxed{
\begin{align}
A\cos(wn+\phi)\rightarrow A|H(\hat w)|\cos(wn+\phi+\angle H(\hat w))\\
A\sin(wn+\phi)\rightarrow A|H(\hat w)|\sin(wn+\phi+\angle H(\hat w))
\end{align}
}$$




## 2.3) Frequency Response

Recall the definitions of the responses in time and frequency domain
$$\begin{align}
h[n]&=\sum_{k=0}^Mh[k]\delta[n-k] \\
H(w)&=\sum_{k=0}^Mh[k]e^{-jwk}
\end{align}$$
>[!thm] Frequency Response Properties
>- Periodicity: $H(w+2\pi)=H(w)$
>- Conjugate Symmetry: if $b_k=b_k^*$, then $H(-w)=H^*(w)$. This implies that $|H(-w)|=|H(w)|, \angle H(-w)=\angle H(w)$ and $\Re H(-w)=\Re H(w), \Im H(-w)=-\Im H(w)$ and thus the representation of $w\in[\pi,2\pi]$ can be found by symmetry of $w\in[0,\pi]$

### 2.3.1) Immediate Responses
- **Delay System**
$$y[n]=x[n-n_0]\rightarrow H(w)\rightarrow e^{-jwn_0}$$
Here the magnitude is 1
- **First Difference System**
$$y[n]=x[n]-x[n-1]\rightarrow H(w)\rightarrow 1-e^{-jw}=1-\cos(w)+j\sin(w)$$
Here the magnitude is $|H(w)|=2|\sin(w/2)|$ and the phase $\angle H(w)=\arctan(\frac{\sin(w)}{1-\cos(w)})$
![[34913.png|First Difference System Graphs|350]]
- **L-Point Avg Filter**
Here the computations are a bit harder, moreover we have
$$y[n]=\frac{1}{L}\sum_0^{L-1} x[n-k]\rightarrow H(w)=\frac1L\sum_0^{L-1}e^{-jwk}$$
But the sum can be rewritten as a geometric series, and thus it can be written as a **dirichlet form**$$H(w)=D_L(w)e^{\frac{jw(L-1)}{2}}=\frac{\sin(wL/2)}{L\sin(w/2)}e^{\frac{jw(L-1)}{2}}$$
This filter has zeroes in $w=2\pi k/L$  ^d39641

This analysis can be done on any type of signal


## 2.4) Linear Phase Filters

^969a30

As the name suggests a linear phase filter is an LTI filter where the frequency response has linear phase.

The no distortion condition is given by $$y[n]=Ax[n-n_0]$$
From here we get that the phase is in fact linear ([proof](#^237b02)). And here starts our study of linear phase filters.

>[!thm] Fundamental Theorem of Linear-Phase Filters
>Since we are looking at **discrete, LTI, real and causal FIR filters** we know that the **impulse response must be symmetric** and thus $${h[n]=\pm h[N-n]}$$
>Where $N$ is the order of the FIR filter. Only one between $\pm$ is necessary.
>
>A lp filter satisfies the no distortion condition if $N$ is even
>
>[Proof:](#^b565e7) $\boxed{}$

>[!rmk|*]
>A causal IIR system cannot satisfy these constraints (infinite and one sided thus can't be symmetric)

#### Types of FIR LP filters
##### Type I:
$$h[n]=h[N-n], \text{ N even}$$
Here we end up with $$\begin{align} 
\overline H(\theta)
=&h[\frac N2]+2\sum_1^\frac N2h[\frac N2-n]\cos(\theta n)\\
=&\sum_0^\frac N2p_n\cos(n\theta) \text{ with } p_0=h[\frac N2] \text{ and } p_n=2h[\frac N2-n]
\end{align}$$
This is a trigonometric polynomial **symmetric** with period $2\pi$ and **symmetric** with respect to frequency $\theta=\pi$
Then $H(e^{j\theta})=e^{-j\frac N 2\theta}\overline H(\theta)$ with phase $\angle H(e^{j\theta})=-\frac N2+\{0,\pi\}$
This satisfies the no distortion condition.
##### Type II
$$h[n]=h[N-n], \text{ N odd}$$

Here we end up with: $$\begin{align} 
\overline H(\theta)
=&2\sum_1^\frac {N+1}2h[\frac {N+1}2-n]\cos((n-\frac12)\theta)\\
=&\sum_1^\frac N2p_n\cos((n-\frac12)\theta) \text{ with } p_n=2h[\frac {N+1}2-n]
\end{align}$$
This is a **symmetric** trigonometric polynomial with period $4\pi$ and **antisymmetric** with respect to frequency $\theta=2\pi$
##### Type III
$$h[n]=-h[N-n], \text{ N even}$$
Same as type I but with no term at 0 and sin instead of cos. It is **antisymmetric** and has period $2\pi$ and is **antisymmetric** to frequency $\theta=\pi$
This satisfies the no distortion condition.

##### Type IV
$$h[n]=-h[N-n], \text{ N odd}$$
As type II but with sin instead of cos. It is **antisymmetric** and has period $4\pi$ and is **symmetric** to frequency $\theta=\pi$

### 2.4.2) Location of zeros for FIR LP systems
##### Type I and II
For type I and II we have that they are symmetric $H(z)=z^{-N}H(\frac1z)$ and thus the polynomial in $z^{-1}$ is equal to its mirror image and therefore if $z_i$ is a zero, then also $1/z_i$ is a zero.

If the zero is complex, it also includes it's complex conjugate. Notice that if the zero is on the unit circle then $1/z_i=z_i^*$ and therefore there are only 2 zeroes. If it is $\pm1$ it is alone

The zero at -1 is important since $H(-1)=(-1)^NH(-1)$ that is with N odd we must have a zero in -1. **Therefore Type II filters can't be used as high or band-pass filters**.

##### Type III and IV

Here the symmetry is $H(z)=-z^{-N}H(\frac1z)$ and thus $z=1$ must be a zero. Moreover if N is even there must be a zero in $-1$

### 2.4.3) Recap

| Type | Symmetries with respect to origin, $\theta=\pi$ |  N   | No Distortion |                 Zeroes                 |           Notes            |
| :--: | :---------------------------------------------: | :--: | :-----------: | :------------------------------------: | :------------------------: |
|  I   |              symmetric, symmetric               | Even |      Yes      |           $z_i\implies1/z_i$           |                            |
|  II  |            symmetric, antisymmetric             | Odd  |      No       |  $z_i\implies1/z_i$, $z=-1$ is a zero  | Can't be high or band pass |
| III  |            antisymmetric, symmetric             | Even |      Yes      | $z_i\implies1/z_i$, $z=\pm1$ is a zero |        No low pass         |
|  IV  |          antisymmetric, antisymmetric           | Odd  |      No       |  $z_i\implies1/z_i$, $z=1$ is a zero   |        No low pass         |
Every needed zero is a degree of freedom less from the order $N$ of the filter. Moreover we can write the amplitude response as $\overline H(\theta)=Q(\theta)P(\theta)$ with $r+1$ degrees of freedom. The values of Q and r can be found from the following table:
![[26237.png|P and r values|550]]
While $\displaystyle P(\theta)=\sum_0^rp_n\cos(n\theta)$

These filters are used in many fields, here are some examples:
- Audio Processing: equalizers, moise reduction
- Image Processing: edge detection, blurring, sharpening
- Communications: digital signal processing (DSP!) for modulation and demodulation
- Control Systems: digital systems for smoothing

Here are some final considerations:
- Pros
	- Always stable
	- Linear phase: no phase distortion since constant phase delay
- Cons
	- Much CPU intensive, IIR require less coefficients




# 3) Z-Transform

The Z-transform is very similar to the laplace transform, in the way that it can represent discrete time signals $x[n]$ as a complex valued function $X(n)$. There are many similarities between these 2 transforms.

>[!def] Z-Transform
>Let $x[n]$ be a discrete signal, then:
>$$x[n]\stackrel{\mathcal Z}{\rightarrow}X(z)=\sum_{-\infty}^{\infty}x[n]z^{-n}, z\in R_x\subset \mathbb C$$

We can also use the unilateral z-transform where the sum starts from 0 and has a different region of convergence (ROC) $R_{x^+}$. **if the signal is causal $x[n]=0\forall n<0$ then the two transforms coincide**

>[!thm] ROC
>The ROC is always a ring:
>$$R_x=\{z\in\mathbb C: R_-<|z|<R_+\}$$
>Where $R_-$ can be $0$ and $R_+$ can be $\infty$. Moreover $z=0$ and $z\rightarrow\infty$ can also be part of the ROC. If there is no ROC then the signal doesn't have a z-transform.
>
>- **Finite duration signal:** ROC is the entire complex plane, it excludes the origin if the last support is $>0$. It excludes points at infinity if the first support is $<0$.
>- **Causal signal:** if the summation converges at $z_0=r_0e^{j\phi}$ then the ROC converges $\forall |z|>r_0=R_-$. Notice that this ROC also holds for derivatives of the z-transform
>- **Anticausal Signal:** Opposite of causal ROC. it converges $\forall |z|<r_0=R_+$
>- **Bilateral Signal:** this can be rewritten as sum of Causal and Anticausal signals. The ROC is the intersections of their 2 ROC.

>[!thm] D'Alembert determination of ROC for Causal Signals
>Consider the following inequality:
>$$\frac1{|z|}\lim_{n\rightarrow\infty}|\frac{x[n+1]}{x[n]}|<1$$
>Then it follows that the ROC has
>$$R_-=\lim_{n\rightarrow\infty}|\frac{x[n+1]}{x[n]}|<|z|$$
>The same steps can be used to compute $R_+$ for an anticausal signal
>

The z-transform can be written as a ratio of 2 polynomials. These can identify zeroes and poles.

>[!thm] Z-Transform and Fourier Transform
>If the ROC includes the unit circle we can write the z-transform on the unit circle as
>$$X(e^{j\phi})=T\sum x[nT]e^{-jn\phi}$$
>If we set $\phi=2\pi fT=2\pi f/F_s$ we get the Fourier Transform.

Now it is possible to understand the full connection between z and laplace transforms: Both transforms get to a form of a ratio of polynomials where zeroes and poles can be identified. Moreover the transforms can be evaluated in specific points (unit circle for z-transform and imaginary axis for laplace transform) to get to the fourier transform. The key difference is the ROC and the fact that the fourier-transform of a discrete signal has periodicity $2\pi$ which is why we consider a finite interval (unit circle) instead of an infinite interval (imaginary axis).

**Properties**
$$\begin{align}
&\text{Linearity:} &&y[n]=\alpha x[n]+\beta y[n]\stackrel{\mathcal Z}{\rightarrow} Y(z)=\alpha X(z)+\beta Y(z), &&R_x\cap R_y \subseteq R_w\\

&\text{Time Expansion} &&\text{is really complicated and thus will be omitted}\\

&\text{Time Delay: }n_0>0 &&y[n]=x[n-n_0]\stackrel{\mathcal Z}{\rightarrow}Y(z)=z^{-n_0}X(z), &&R_y=R_x \\

&\text{Bi Time Advance: }n_0>0 &&y[n]=x[n+n_0]\stackrel{\mathcal Z}{\rightarrow}Y(x)=z^{n_0}X(z), &&R_y=R_x \\

&\text{Uni Time Advance: }n_0>0 &&y[n]=x[n+n_0]\stackrel{\mathcal Z}{\rightarrow}Y_+(x)=z^{n_0}X_+(z)-\sum_{n=0}^{n_0-1}x[n]z^{-n_0}, &&R_y=R_x \\

&\text{Convolution:} &&y[n]=x[n]*h[n]\stackrel{\mathcal Z}{\rightarrow}Y(z)=X(z)H(z), &&R_x\cap R_h \subseteq R_y \\

&\text{Complex Conjugate:} &&y[n]=\overline{x[n]}\stackrel{\mathcal Z}{\rightarrow}Y(z)=\overline{X(\overline z )}, &&R_y=R_x \\

&\text{Time Reversal:} &&y[n]=x[-n]\stackrel{\mathcal Z}{\rightarrow}Y(z)=X(z^{-1}), &&R_y=\{\frac{1}{R_+}<\mathopen\mid z\mathopen\mid<\frac{1}{R_-}\} \\

&\text{Z Reversal:} &&y[n]=(-1)^nx[n]\stackrel{\mathcal Z}{\rightarrow}Y(z)=X(-z), &&R_X=R_y \\

&\text{Derivative:} &&\frac{dX(z)}{dz}=-z^{-1}\sum nx[n]z^{-n}, \\

&\text{Exponential:} &&y[n]=a^{n}x[n]\stackrel{\mathcal Z}{\rightarrow}Y(z)=X(\frac{z}{a}), &&R_y=\{\mathopen\mid a\mathopen\mid R_-<\mathopen\mid z\mathopen\mid<\mathopen\mid a\mathopen\mid R_+\} \\

&\text{Inverse Transform:}

\end{align}$$

>[!theorem] BIBO stability
>The z-transform is bibo stable if:  
>$$\sum \mathopen\mid h[n]\mathopen\mid<\infty, \{z\in\mathbb C:\mathopen\mid z\mathopen\mid=1\}\subset R_h$$
>that is: $h[n]$ is abs summable and has the unit circle in the roc.

>[!theorem] Initial Value Theorem
>On the one sided z-transform we have that:
>$$x[0]=\lim_{z\rightarrow+\infty}X_+(z)$$
>`\begin{proof}`
>We know that $X_+(z)=x[0]+x[1]z^{-1}+...\stackrel{z\rightarrow\infty}{\rightarrow}x[0]+x[1]\cdot0...=x[0]$
`\end{proof}`

>[!theorem] Final Value Theorem
>$$\lim_{x\rightarrow\infty}x[n]=\lim_{z\rightarrow1}(1-z^{-1}X_+(z))$$
>`\begin{proof}`
> Consider $y[n]=x[n]-x[n-1]\stackrel{\mathcal Z_+}{\rightarrow}Y_+(z)=X_+(z)-x[-1]-z^{-1}X_+(z)$
> We alos have: 
> $Y_+(z)=\lim_{n\rightarrow\infty}\sum y[n]z^{-n}\lim\sum (x[n]-x[n-1])z^{-n}=\lim_{z\rightarrow1}X_+(z)(1-z^{-1})-x[-1]$
> >[!todo]
>`\end{proof}`

>[!todo] Inverse Z
>>[!theorem] Inverse Z-transform
>Recalling the definition of Z-Transform


# 4) Discrete Fourier Transform (DFT)

The DFT is the Fourier transform relative to finite length discrete time-limited/periodic signals.
The periodic signal with period $T_p=NT$ is completely specified in N samples. It's Fourier transform is $X(kF)$ with $F=1/T_P$ and periodicity $F_S=1/T=NF$
$$X(kF)=\sum_{n=n_0}^{n_0+N-1}Tx[nT]e^{-j2\pi kFnT}$$
usually we assume $n_0=0$.

This transform is discrete and periodic with period $N$

>[!todo]
>properties

## 4.1) Relationship With Z-Transform and DTFT

Suppose to have a signal $x[nT]$ with support $M$. It will have the following z-transform: $$X(z)=\sum_0^{M-1}x[n]z^{-n}$$
Now suppose to create $\tilde x[n]$ a periodic version of this signal with $N$ samples. It's DFT is: $$\tilde X(k)=\sum_0^{N-1}\tilde x[n]e^{\frac{-j2\pi k}{N}n}$$
Here two cases can happen.
- $N\geq M$
Clearly then then the periodic signal will include all of $x[n]$ and therefore the DFT will be equal to N samples of $X(z)$ on the unit circle at equal spacing.
$$\tilde X(k)=\sum_0^{M-1}x[n]z_k^n\text{ with } z_k=e^{-j\frac{2\pi}{N}k}$$
These correspond to the values of the DTFT of $x[n]$ sampled at those angular frequencies. The bigger N, the more the samples 

- $N<M$
Here we find temporal aliasing

## 4.2) Fast Fourier Transform FFT
The FFT algorithm uses the divide and conquer paradigm to reduce the computing time of the DFT to $O(N\log_2N)$. 

The direct computation will need $N$ complex multiplications, $N-1$ complex additions, $N+1$ memory accesses to read the values $x[n]$ and $N$ accesses to read $W_n$ (we denote $W$ one root on the unit circle) for each coefficient, that easily equates to $O(N^2)$

With the divide and conquer we can divide the problem $\log_2N$ times each iteration takes $O(n)$.

How to do that?
First divide the samples of $x[n]$ into odd and even samples. Then by keeping in mind that $W_N^2=W_\frac N2$ we end up with two sample subsets of size $N/2$
$$X(k)=\sum_0^{\frac N2-1}x[2r]W_N^{2rk}+\sum_0^\frac N2x[2r+1]W_N^{(2r+1)k}
=\sum_0^{\frac N2-1}x[2r]W_\frac N2^{rk}+W_N^k\sum_0^\frac N2x[2r+1]W_\frac N2^{rk}=G(k)+W_N^kH(k)$$
Since we are taking one sample every two for the sequences the periodicity is conserved.
The recombination step is proportional to $N$.

## 4.3) Convolution in Time Vs Frequency
In a convolution on a filter with support $M$ each sample of $y[n]$ takes steps proportional to $M$. Under what circumstances is this less efficient than doing the FFT, the product and then the IFFT.

Suppose to have the signals $x[n], \ h[n]$ and the signals given by their periodic repetition (notice that the support $N=2^v\geq D_y$). The linear convolution will have support $D_y=D_x+M-1$.
The frequency approach takes 2 FFT and N multiplication per sample, that is $O(\log_2N)$ 

Suppose to have the times be $T_F=3K_F\log_2N$ and $T_D=K_DM$, then their ratio will show us if and when the frequency approach is better.

- Case $D_x\approx M$
In this case $N\approx2M$ and the ratio shows that $T_F$ is faster after $M=2^4$
- Case $D_x>>M$
Here the ratio shows that $D_x<2^\frac M3$ to have the frequency approach be faster

But we can also use the **block convolution** which differs from the linear convolution since we divide the input signal in blocks. In this way we can always go back to the case where $D_x\approx M$.
### 4.3.1) Overlap-Add Method
Divide the signal into non overlapping blocks of length $L>M$. Assuming $x[n]$ causal and $x_k[n]$ the k-th block. we have that $$y[n]=x[n]*h[n]=(\sum x_k[n])*h[n]=\sum y_k[n]$$
Here the support goes from $kL$ to $(k+1)L+M-2$ with a total length of $L+M-1$ and therefore there is an overlap of $M-1$ samples. And therefore we might end up in situations where the sample is given as a sum of 2 samples. To avoid time aliasing we must have $N\geq L+M-1$.
![[83329.png|Sample Addition Distribution|450]]
The most optimal values are $M\approx 10^2$ and $N\approx 10^3$.

The overlap-save method is similar but there is an overlap in $x_k[n]$.

## 4.4) Windowing
We usually cannot compute the DTFT since we can only observe a finite length section of $x[n]$.
Windowing consists in studying how the DFT of the observed signal $y[n]=x[n]w_R[n]$ is different from the DTFT of the signal.

Notice that if $x[n]$ is a complex exponential, then the DTFT is $X(e^{j\theta})=\sum A\delta(\theta-\theta_0+2k\pi)$ and thus we have that $$Y(e^{j\theta})=AW_R(e^{j(\theta-\theta)})$$
In the case that $w[n]$ is a rect, its Fourier transform is the sinc function and thus the windowed DTFT will be a sinc centered at the frequency of the complex exponential.

![[50974.png|Magnitude of X (left) Compared To The Magnitude of Y (right)|650]]

If there are more complex exponentials present in the input we will end up with 2 peaks due to superimposition. We call **leakage** the phenomenon that changes the peak of one exponential due to the contribution of the secondary peaks of the other exponentials.

![[48523.png|Example of Leakage|650]]
>[!rmk]
>If the exponentials are close in frequency they might be undistinguishable in the windowed DTFT

![[7237.png|Example of Limited DFT Resolution|650]]
But as we recalled correctly the DFT is a collection of N uniformly spaced samples of the DTFT. Since the windowing shifts the we must find the integer value $k_0$ for which $\theta-K=\frac{2\pi}N k_0$ matches the peaks of the DTFT.

![[66599.png|Wrong Vs Correct Spectral Sampling|650]]
As it is shown in the image, a correct spectral sampling can not only approximate the DTFT of the windowed signal, but even the DTFT of the non windowed signal. The accuracy can be increased by adding samples (through zero padding). Moreover it is possible to change window type in exchange for resolution to decrease leakage

>[!rmk|*] Fourier Analysis of Sinusoidal Signal
>A sinusoidal signal can be expressed as a sum of complex exponentials, but we actually only need to estimate one of the two since the second one is obtained by symmetry. 

## 4.5) Spectrogram
Signals that are really long ($\rightarrow\infty$) are hard to compute. The **spectrogram** is a tool that highlights the frequency difference in subsequent short sections of the signal. Therefore we need to introduce the **Short Time Discrete Fourier Transform** (STDFT) 
$$X[k,n_s]=\sum_{m=0}^{L-1}w[m]x[n_S+m]e^{-j(\frac{2\pi k}{N})m}$$
This encapsulates both windowing and short-length DFT. $n_s$ is moved in jumps of $1\leq R<L$ samples. k represents frequency and $n_s$ represents time.

Take for example the following DFT:
![[73176.png|DFT|450]]
![[63171.png|Spectrogram Representations With Different Windows|450]]
The spectrogram tells us what frequencies are present at what time. Moreover the shorter the window, the clearer it is where the frequencies change in time.

Not all signals have only one frequency at any point in time. In that case resolution is also important, since close frequencies can mix into one another.
![[14408.png|Resolution Difference|450]]

| Window Size | Time Resolution | Frequency Resolution |
| ----------- | --------------- | -------------------- |
| Big         | Worse           | Better               |
| Small       | Better          | Worse                |
## 4.6) Design Of A Low Pass Filter
A real filter won't be perfect and thus there will be some specifications on the error given. 
![[9689.png|Errors|550]]
The image represents both band errors $\delta$ and frequency limits $\theta$.
The bands are given in dB according to the Pass Band Ripple ($PBR_{dB}$) and the Stop Band Attenuation ($A_{dB}$).
$$\begin{gather}
PBR_{dB}=20\log_{10}\frac{1+\delta_p}{1-\delta_p} \\
A_{dB}=-20\log_{10}\delta_s
\end{gather}$$
Recall that we need a linear phase filter of type I or II, that is $h[n]=\pm h[N-n]$ and the frequency response $H(\theta)=e^{j\beta}e^{-j\frac N2\theta}Q(\theta)P(\theta)$ where $\beta\in\{0,\pi/2\}$.

Let's choose type I since it has the maximum generality (no zero already set, can build any filter), and thus we can set some parameters $\beta=0, \ Q=1, \ N\text{ even}, \ r=\frac N2, \ p_0=h[\frac N2], \ p_n=2h[\frac N2-n]$. We strive to build this desired filter:
$$H_d(\theta)=e^{-j\frac N2\theta} D(\theta)$$
There are three main ways to design the filter.
### 4.6.1) Windowing

### 4.6.2) Frequency Sampling
This approach consists in filtering $H_d$ on a set of uniformly spaced points that constitute the points of the DFT. Finally we can compute $h[n]=\text{IDFT}(H)$
![[32947.png|Example|650]]
### 4.6.3) MinMaxing 
We want to find the values of $h[n]$ that minimizes the maximum of the weighted error magnitude
$$E(\theta)=W(\theta)(D(\theta)-\overline H(\theta))$$
This is exactly as finding:
$$\min_h|E(\theta)|=\min_h\max_{\theta\in[0,\pi]}|W(\theta)(D(\theta)-\overline H(\theta))|$$
If $\overline H$ is a linear combination of $r+1$ sinusoids, then $E$ presents $r+2$ points such that 
$$\begin{gather} E(\theta_i)-E(\theta_i) \\
|E(\theta_i)|=\max_{\theta\in[0,\pi]}|E(\theta)| \end{gather}$$
And these points, called **alterations**, satisfy the following equation
$$W(\theta_i)\left(D(\theta_i)-\sum_0^rp_n\cos(n\theta_i)\right)=(-1)^i\delta$$
These are essentially the $r+2$ points that show the maximum bounds of the filter
![[65968.png|Example|650]]
In any case the **filter order** is approximately:
$$N\approx\frac{-10\log_{10}(\delta_p\delta_s)-13}{14.6\frac{\theta_s-\theta_p}{2\pi}}$$
It is **directly proportional to $\delta$ but doesn't depend on the cutoff frequency** and it depends on a product, thus by modifying accordingly the two values it can remain constant



# 5) Multirate Signal Processing TODO
Multirate systems deal with signals that have different sampling frequencies. They are usually used to convert from one sampling frequency to another. A working assumption in this case is that the sampled signal are sampled under Nyquist conditions.
## 5.1) Interpolation Systems
In these systems  the output sampling frequency is $L\in\mathbb N^+$ times bigger than the input
$$F_s'=LF_s,\ T'=\frac1LT$$
>[!col]
>The easiest case consists of just adding $L-1$ zero samples between 2 og samples and multiplying them by $1/L$. This System perfectly preserves all information. Moreover:$$\begin{align}
w[kT']&=\begin{cases}Lx[nT], \text{ if } k= nL \\ 0\end{cases} \\
W(z)&=X(z^L) \\
W(f)&=X(f)
\end{align}$$ [Proof](#^14e9cf)
>
>![[51709.png|Example With L=3|350]]

>[!col]
>![[13700.png]]
>
>But this is kinda useless. Let's concatenate this with a filter to give a useful value to the new samples.

$$y[nT]=T\sum x[kT]h[nT'-nT]$$
Where we end up having $Y(z)=H(z)X(z^L)$,  $Y(f)=H(f)X(f)$.
 - **Ideal Low Pass Filter**
In this case $h[nT']=F_ssinc(\frac nL)\rightarrow y[nT']=\sum x[kT]sinc(\frac{n-kL}L)$
This can ideally perfectly interpolate the signal, but is not physically realizable. We can approximate the filter with the windowing technique so to keep the interpolation intact.

- **Linear Interpolation**
Here the interpolation consists of tracing a line between the 2 non zero samples and projecting the zero samples onto that line.
![[63547.png|Example With L=3|350]]
This is a LTI system. The impulse response will have the form of a triangle and thus it provides satisfactory interpolation only if it has low frequencies wrt it's bandwidth, that is $F_s/2$. 

## 5.2) Decimation Systems
Here the output sampling frequency is $M\in\mathbb N^+$ times smaller
$$F'_s=\frac1MF_s, \ T'=MT$$
>[!col]
>The easiest case consists of just keeping one every $M$ samples. This clearly doesn't keep all information. Moreover:$$\begin{align}
u[nT]&=\begin{cases}x[nT], \text{ if } n= kM \\ 0\end{cases} \\
U(z)&=\frac1MY(z^M) \\
Y(z)&=MU(z^\frac1M)
\end{align}$$ [Proof](#^14e9cf)
>
>![[94829.png|Example With M=3|450]]

## 5.3) Generic Rate Conversion Systems
This system is a mix of the previous two, so we can scale with rational factors
$$F'_s=\frac LM F_s, \ T'=\frac ML T$$
![[74154.png|Block Diagram|550]]
The systems is the following: $y[nT']=T\sum x[kT]h[nT'-kT]$ and is not time invariant
# 6) IIR Filters

Infinite Impulse Response (IIR) filters are a class of LTI systems with infinite duration impulse responses. They also include previously computed values of the output signal
$$y[n]=\sum_{l=1}^Na_ly[n-l]+\sum_{k=0}^Mb_kx[n-k]$$
The order is given by $N$, the feedback terms. It is charcterised by an impulse sequence

We also need **initial rest conditions:**
- the input is zero prior to a starting time
- the output is zero prior to a starting time
The system is initially at rest if the output is zero prior to the application of an input



# 7) Examples of Filters

## 7.1) Unit Delay
$$ $$
>[!theorem] Unit Delay Filter
>This filter shifts the signal by an amount $n_0$
>$$y[n]=x[n-n_0]$$
>A delay of $k$ will have the first $k$ coefficients equal to 0 and the last equal to 1


## 7.2) L-Point Running Average
$$ $$
>[!def] Running Average Filter
>An n-point running average filter is a filter that returns the mean of n values of the input, it can be:
>- forwards: $$y[n]=\frac{1}{l}\sum_{i=0}^lx[n+i]$$
>- backwards: $$y[n]=\frac{1}{l}\sum_{i=0}^lx[n+i]$$
>- centralized: $$y[n]=\frac{1}{l}\sum_{i=-l/2}^{l/2}x[n+i]$$

Now I will use some specific filters to highlight their properties:

Case $L=51$:
This FIR filter is of form: $y[n]=\frac 1{51}\sum_0^{50}x[n-k]$
This creates a shift of 25 samples as seen in the first image. We can correct this by using a non causal filter of form: $\tilde y[n]=\frac 1{51}\sum_{-25}^{25}x[n-k]$
>[!col]
>![[57804.png|Causal FIR Filter|350]]
>
 >![[26640.png|Non Causal Filter|350]]

Case $L=11$:
>[!col]
>Applying this filter on an image blurs the image in the direction it is applied. This is especially useful if the image has a cosine distortion on one axis tis filter is able to remove it.
>$$ $$
>This is clearly possible if the cosine has frequency $w=2\pi/11$ since $H(2\pi/11)=0$ (see [L-Point Avg filter][#^d39641])
>
>![[14388.png|Distortion Removal|350]]

## 7.3) Edge Detection
This filter highlights edges by associating them with a high value in output magnitude. 

The case of a 1D edge detection is very simple:
$$y[n]=x[n]-x[n-1]$$
here it is clear that similar values tend to cancel each other out and an increase inn values comes with a positive increase


2D filters are of type $y[m,n]=\sum_{k=-M}^M\sum_{l=-M}^Nb_{l,k}x[m-k,n-l]$

Edge-finding filters are high pass filters since edges essentially highlight high frequency changes in the image. These filters can be represented by a matrix of the $b_k$ values. This matrix has at the center the current sample $[m,n]$ and the other values are the corresponding surrounding samples $[m-i,n-j]$. A common matrix for edge detection is:
$$\begin{bmatrix}
&1/4 &-1 &1/4\\
&-1 &3 &-1\\
&1/4 &-1 &1/4
\end{bmatrix}$$
In both cases the average value of $b_k$ is 0 since the sdame values tend to cancel out.

![[Pasted image 20250212110458.png|Example|550]]




# 8) Proofs
## 8.1) [Linear Phase Filters](#^969a30)

### 8.1.1) No Distortion Condition

^237b02

By doing the z-transform we can find the transfer function and study phase and magnitude:
$$Y(z)=Az^{-n_0}X(z)\rightarrow H(z)=Az^{-n_0}$$
Then the phase is clearly linear $\angle H(e^{j\theta})=-n_0\theta+ \{0,\pi\}$ and thus the **group delay** is constant: $\tau_H=\frac{d\angle H(e^{j\theta})}{d\theta}=-n_0$
And also the magnitude is constant $|H(e^{j\theta}|=|A|$

### 8.1.2) Fundamental Property of linear phase filters

^b565e7

Since the phase must be linear we have that $\angle H(e^{jw})=\alpha\theta+\beta$ we can rewrite the frequency response using the **amplitude response** $H(e^{j\sigma})=e^{j(\alpha\theta+\beta)}\overline H(\theta)$. 

Since the system is real we also have that $H(e^{j\theta})=H^*(e^{-j\theta})$. From here we see that the magnitude is even and that it is the same as $\overline H(\theta)$. This implies that the amplitude response is either even or odd real function. It can be expressed as $e^{j(\alpha\theta+\beta)}\overline H(\theta)=e^{-j(\alpha(-\theta)+\beta)}\overline H(-\theta)$.

- Even:
In this case $\overline H(\sigma)=\overline H(-\sigma)$ and thus we end up with $e^{j\beta}=e^{-j\beta}$. Clearly $\beta=0\text{ or }\pi$. The same results are obtained for both values of $\beta$, so we will use $\beta=0$ for the proof:
$\overline H(\theta)=\sum_0^N h[n]e^{-j\theta(\alpha+n)}$ but also $\overline H(-\theta)=\sum_0^N h[N-n]e^{-j\theta(\alpha+N+n)}$ and they are equal. This is possible with $\alpha=-N/2$.
The phase function is $\phi_H(\theta)=-\frac N2\sigma+\{0,\pi\}$

- Odd:
Here the constraints are $e^{j\beta}=-e^{-j\beta}$ then $\beta=\pm\pi/2$. With the same steps as above we have that $\alpha=-N/2$.
The phase function is $\phi_H(\theta)=-\frac N2\sigma++\frac\pi2+\{0,\pi\}$

In both cases the derivative, called **group delay** is $\alpha=-\frac N2$.
If $N$ is even then $h[n]$ has odd symmetry with center of symmetry at one of its points. Moreover the group delay is integer and this is the delay $n_0$ in the no distortion condition $y[n]=Ax[n-n_0]$.
If N is odd then we don't have a salf symmetric sample and the phase delay is not satisfied. The output is not only delayed but also interpolated

## 8.2) MSP
### 8.2.1) Interpolation I/O Equations

^14e9cf

- Z-Transform:
$$W(z)=T'\sum w[nT']z^{-k}=T'\sum Lx[nT]z^{-nL}\stackrel{T=LT'}=T\sum x[nT](z^L)^{-n}=X(z^L)$$
Here the ROC of $W(z)$ is $R_W=\{z\in\mathbb C:R^{\frac1L}_-<|z|<R^{\frac1L}_+\}$

- Fourier Transform:
$$W(f)=T'\sum w(kT')e^{-j2\pi fkT'}=T'\sum Lx(nT)e^{-j2\pi fnLT'}=T\sum x(nT)e^{-j2\pi fnT}=X(f)$$
$X(f)$ has period $F_s=\frac1T$ while $W(f)$ has period $F'=\frac1{T'}=LF_s$
