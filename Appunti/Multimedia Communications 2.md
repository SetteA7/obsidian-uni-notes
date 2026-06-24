# 1) Evaluation Criteria
Error image:
$$\mathcal E(f,\tilde f)=f-\tilde f$$
Mean Square Error (MSE):
$$\mathcal D(f,\tilde f)=\frac1{NM}\abs{\mathcal E}^2$$
Peaks Signal to Noise Ratio (PSNR)
$$PSNR(f,\tilde f)=10\logt\frac{255^2}{\mathcal D(f,\tilde f)}$$
# 2) Quantization
The quantization is the process of mapping a function $Q$ from $\mathbb R$ to a discrete set called *Dictionary.*
$$Q:x\in\mathbb R\rightarrow y\in C=\curly{\hat x_1,\hat x_2,...}\subset\mathbb R$$
with:
- $C$: dictionary (subset of R)
- $\hat x_i$: quantization level, codeword

![[Pasted image 20260618145043.png|Quantizer|250]]
Moreover we define:
- Thresholds $(t_1,t_n)$
- Levels: $L=n-1$
- Region $\Theta_i$: Two subsequent thresholds define a region $\Theta_i=(t_i,t_{i+1})=\curly{x:Q(x)=\hat x_i}$ these are a partition (non intersecting intervals)
- Quantization error: $e=x-Q(x)$. The smaller the regions, the better the error.

Quantization can be seen as an encoding/decoding process:
take signal $x(n)$: the encoding step assigns each sample of $x(n)$ to a quantization level $i(n)$. The decoder associates to each quantization level $i(n)$ the corresponding code word (value).
![[Pasted image 20260618145354.png|Encode/Decode|250]]
We will refer to these steps also as quantization and inverse quantization.

**Rate $R$:**
The rate is the avg amount of bits used to store the quantization indexes $i(n)$. This is saved via lossless coding:
$$R=\log_2L$$
- quantized data has uniform (pessimistic) distribution (since $H\leq R\iff$ signal uniform)
- binary data of $i(n)$ is the best (entropy coded)

**Distortion $D$:**
On a single sample we use
$$d[x,Q(x)]=\abs{e}^2=\abs{x-Q(x)}^2$$
For a signal of duration $N$ we use the MSE:
$$D=\frac1N\sum_{n=0}^{N-1}d[x(n),Q\big(x(n)\big)]$$
for a random signal this can be done via an expected value:
$$D=\E\sq{\abs{X(n)-Q(X(n))}^2}=\E\sq{\abs{E(n)}^2}=\sigma^2_{E}$$

**Mid treat quantizers** are quantizers where values near 0 are have quantization level $=0$. This reduces noise. **Mid rise** quantizers amplify noise!
## 2.1) Uniform Quantizer (UQ)
Input signal $\in(0,A)$ (unsigned) or $\in(-\frac A2,\frac A2)$ (signed) is divided into $L$ equal sized cells of size $\Delta=A/L$. Where the quantization levels $\hat x_i$ is the midpoint. clearly this is now **mid rise**
$$\begin{gather}
\forall i, \ \Delta^i=\Delta=A/L\\
t^i=t^{i-1}+\Delta\\
\hat x^i=\frac{t^i+t^{i-1}}2\\
\Theta^i=\par{\hat x^i-\frac\Delta2,\hat x^i+\frac\Delta2}
\end{gather}$$
### 2.1.1) Types of UQ
#### Unsigned Data
For unsigned data $\in(0,A)$ we have 
$$\begin{align}
&\text{Thresholds: }t_i=(i-1)\Delta\\

\\
&\text{Encoder: }i=\ceil{\frac x2}\\
&\text{Decoder: }\hat x^i=i\Delta-\frac \Delta 2\\
&\implies Q(x)=\Delta\ceil{\frac x2}-\frac\Delta2
\end{align}$$
#### Signed Data
Since values are unsigned a mid thread quantizer is necessary, therefore we need an **odd number of levels**. The threshold at $t^{N/2}$ will have $\hat x^{N/2}=0$.
$$\begin{align}
&\text{Encoder: }i=\text{round}\par{\frac x2}\\
&\text{Decoder: }\hat x^i=i\Delta\\
&\implies Q(x)=\Delta\text{round}\par{\frac x2}
\end{align}$$
From here we can define **deadzone quantization**:
The central cell is larger than the others, it is zero if $\abs x<\tau$
![[Pasted image 20260618151808.png|Deadzone UQ|250]]
$$i=\begin{cases}sign(x)\floor{\frac{\abs x+\frac{\tau\Delta}2}\Delta} & \abs x\geq\tau\\0&\abs x<\tau\end{cases}$$

#### High Resolution (HR) UQ
For HR we mean a quantizer with $L\rightarrow \infty$. Therefore we get $\Delta=A/L\rightarrow 0$ and therefore $\Theta_i$ as $\Theta_i=(\hat x_i-\Delta/2,\hat x_i+\Delta/2)\rightarrow (\hat x_i,\hat x_i)$. Now we can approximate $p_X$ as a constant in each $\Theta_i$. 

Therefore in a single region:
$$E|X\in\Theta_i=X-Q(X)=X-\hat x\sim\mathcal U(-\frac\Delta2,\frac\Delta2)$$
Due to total probability law we have:
$$E\sim\mathcal U\par{-\frac\Delta2,\frac\Delta2}$$


### 2.1.2) RD Curve

##### Probability Theory Recap
First recall the definition of uniform RV:
$$X\sim\mathcal U(a,b)\iff f_X(x)=\begin{cases}\frac1{b-a}&a\leq x\leq b\\ 0\end{cases}\qquad \begin{aligned}
&\E[X]=\frac{a+b}2\\
&\var(X)=\frac{(b-a)^2}{12}
\end{aligned}$$
and also the Law of the Unconscious Statistician (LOTUS):
$$E[g(x)]=\int g(x)f_X(x)dx$$
#### Uniform RV with UQ
Hypothesis: $X\sim\mathcal U(-\frac A2,\frac A2)$ quantized with UQ of $L$ levels.
Goal: Since the rate is known ($R=\log_2 L$) we must only find the distortion: $D=\sigma_Q^2=\E[\abs{E}^2]=\E\sq{\abs{X-\hat X}^2}$.
Result: $$\boxed{D(R)=\sigma_Q^2=\sigma_X^22^{-2R}}$$

Proof:
Notice that since $\E\sq{\abs{X-\hat X}^2}=\E[g(X)]$ we can use LOTUS:
$$\begin{align}
\sigma^2_Q=\E[g(X)]&=\int_{-\frac A2}^{\frac A2} g(u)\frac1Adu=\sum_{i=1}^L\int_{\Theta_i}\frac1A[u-Q(u)]^2du\\
&=\frac1A\sum_{i=1}^L\int_{\hat x_i-\Delta/2}^{\hat x_i+\Delta/2}[u-\hat x_i]^2du\\
&=\frac 1A\sum_{i=1}^L\int_{-\Delta/2}^{\Delta /2}t^2dt\\
&=\frac AL\frac{\Delta^3}{12}
\end{align}$$
finally recall that in UQ we have $\Delta=A/L$ , that $L=2^{R}$ and that $\var(X)=A^2/12$ then:
$$\sigma_Q^2=\frac AL\frac{\Delta^3}{12}=\frac{\Delta^2}{12}=\frac1{12}\par{\frac{A}{L}}^2=\frac{A^2}{12}\frac 1{L^2}=\sigma_X^22^{-2R}$$
and the SNR becomes:
$$SNR=10\logt\frac{\E[X^2]}D=10\logt\frac{\sigma_X^2}{\sigma_X^22^{-2R}}=10\logt2^{2R}\approx 6R$$
$$\endproof$$
#### HRUQ RD Curve
In this case we know $E\sim\mathcal U\par{-\frac\Delta2,\frac\Delta2}$ and thus
$$D=\E[\abs{E}^2]=\frac{\Delta^2}{12}=\frac1{12}\par{\frac{A}{L}}^2=\frac{A^2}{12}2^{-2R}$$
The SNR becomes:
$$SNR=10\logt\frac{\E(X^2)}{D}=10\logt\frac{\sigma_X^22^{-2R}}{A^2/12}\approx 6R-10\logt\frac{\gamma^2}2$$
where $\gamma^2$ is the **load factor**, that is, the ratio between peak power and avg power: 
$$\gamma^2=\frac{X^2_\max}{\sigma_X^2}=\frac{A^2/4}{\sigma_X^2}$$
### 2.1.3) Recap:
Here is a tabe:

|                        | Unsigned                                           | Signed                                           | Deadzone (Signed)        | High Resolution                                  |
| ---------------------- | -------------------------------------------------- | ------------------------------------------------ | ------------------------ | ------------------------------------------------ |
| Type                   | Mid-rise                                           | Mid-tread                                        | Mid-tread (large center) | Any ($L\rightarrow \infty$)                      |
| Implementation: $Q(x)$ | $$\Delta\cdot\floor{\frac x\Delta}+\frac \Delta2$$ | $$\Delta \cdot \text{round}\par{\frac x\Delta}$$ |                          | $$\Delta \cdot \text{round}\par{\frac x\Delta}$$ |
| $L$                    | Even                                               | Odd                                              | Odd                      | Any                                              |
| RD Curve               | -                                                  | if uniform input $\sigma_X^22^{-2R}$             |                          | $\frac{\gamma^2}3\sigma_X^22^{-2R}$              |
Given range and levels, UQ has the **smalles maximum error** (optimal minimax quantizer) of $e_\max=\frac{\Delta_i} 2=\frac A{2L}$

Only quantizer with analytical solution for RD curve with uniform input distrbution (see [[#Uniform RV with UQ]]):
$$D(R)=\sigma_X^22^{-2R}$$
in the general case (no knowledge on input distribution):
$$D(R)=\frac{A^2}{12}2^{-2R}$$
this is used for HRUQ also. Recall $\gamma^2$ is max power over avg power and $c_X=\frac{\gamma^2}3$.
## 2.2) Optimal Scalar Quantization (SQ)
Let the input density $p_X$ be known. We want to find the quantizer minimizing the distortion (for a given rate).
#### Optimal HR Quantizer
Recall the HR hypothesis:
$$L\rightarrow \infty\quad \max_i\Delta_i\rightarrow 0\quad \forall i,u\ \in\Theta^i, \ p_X(x)\approx P_i$$
It can be shown that the optimal quantizer is:
$$\sigma^2_Q=c_X\sigma^2_X2^{-2R}\qquad\text{ with }c_X=\frac1{12}\sq{\int p_U^{1/3}(t)dt}^3\text{ and }U=\frac X{\sigma_X}$$

The term $c_X$ is called **shape factor** since it only depends on the PDF shape and not variance ($U$ and $X$ have same shape)
some common shape factors are:
- Uniform: $c_X=1$
- Gaussian $c_X=\frac{\sqrt 3}2\pi\approx 2.72$

#### Non-HR Optimal Quantization (TODO)
There is **no analytical formula** for low rate optimal quantizers, but it is possible to find **necessary conditions** that allow to defining the **Lloyd-Max algorithm** to find local optimum points

## 2.3) Predictive SQ
Quantization is **not effective for non sparse data**. Predictive SQ **exploits correlation among samples**.

>[!def] Sparse Signal
>A signal is sparse if most of its components are zero or close to zero
>- The variance of a sparse signal is low
>- Zero (or close to zero) samples can be neglected (quantized to 0) without introducing distortion
>- Natural signal are not sparse but can easily be transformed into one

![[Pasted image 20260619093322.png|Example non sparse vs sparse representation of sinusoidal|250]]
#### Optimization Paradigm
Since prediction error = signal error, then performance increase depends only by predictor variance, that is **if and only if the pred error has smaller variance than og signal**

Proof prediction error=signal error:
$$q(n)=y(n)-\hat y(n)=x(n)-v(n)-(\hat x(n)-v(n))=x(n)-\hat x(n)=\overline q(n)$$
![[Pasted image 20260320160934.png|Quantizer process|350]]
Proof SNR quality depends on $\sigma_Y^2$
$$SNR=10\logt\frac{\sigma_X^2}D=10\logt\frac{\sigma_X^2}{\sigma_Y^2}+10\logt\frac{\sigma_Y^2}D=G_P+G_Q$$
#### Predictors
Linear predictors are used: simple and optimal for gaussian rvs.

A linear predictor is a linear combination of the $P$ previous values
$$v(n)=-\sum_{i=1}^Pa_ix_{n-i}\rightarrow y(n)=x(n)-v(n)=\sum_{\mathbf{i=0}}^Pa_ix_{n-i},\quad a_0=1$$
It turns out that the optimal variance is:
$$\sigma_Y^2=\sigma_X^2+r^Ta^*=\sigma_X^2-r^TR_X^{-1}r$$
where $a^*=-R_X^{-1}r$

The order of the filter yields good result for small values (up to order 4), but including distant pixels (less correlation) leads to more white noise inclusion and has higher complexity for negligible PSNR increases.

Clearly now $v_n$ must use $\hat x$ since otherwise the decoder wouldn't be able to use know $v$.
![[Pasted image 20260619121436.png|Block Sceme|450]]
The use of $\hat x$ instead of $x$ comes with some heavy performance penalty, it performs worse than direct quantization. This can be fixed via entropy coding.

Finally, a **local adaptation with block wise approach** can be used. Divide image into $M\times M$ blocks and find the optimal filter for each block. The rate augments by $\frac{NB}{M^2}$:
- Small block: good local statistichs, bad quantizer info overhead (high rate)
- Large block: bad local statistics (bad PSNR), good quantizer overhead

>[!example|*]
>Let $X(n)\sim\mathcal N(0,\sigma^2), \E[X(n)X(m)]=\sigma^2\rho^{|n-m|}$ and $V(n)=X(n-1)$. Find $\rho$ such that $G_p>0$.
>
>Since we need $G_p>0$ we actually need $\sigma_Y^2>\sigma^2$. 
>Find $Y$
>$$Y(n)=X(n)-V(n)=X(n)-X(n-1)$$
>since this is a sum of gaussians this remains a zero mean gaussian rv, find variance:
>$$\begin{align}
\sigma_Y^2 &=\E[(X(n)-X(n-1))^2]=\E[X(n)^2]+E[X(n-1)^2]-2\E[X(n)X(n-1)]\\ 
&=2\sigma^2-2\sigma^2\rho\\
&=2\sigma^2(1-\rho)
\\
\\
\sigma_Y^2&=2\sigma^2(1-\rho)>\sigma^2\iff \rho>\frac12\iff G_p>0
\end{align}$$

Proof of optimal filter:
Notice that the predicted output is
$$y(n)=(a*x)(n)\zetatrans Y(z)=A(z)X(z)$$
where the transfer function is
$$A(z)=\sum_{i=0}^Pa_iz^{-i}=1+a_1z^{-1}+...+a_{P}z^{-P}$$
It is clear that the minimization problem only acts on finding $a$ that minimizes the variance.

In general the variance can be written as:
$$\sigma_Y^2=\sigma_X^2+2r^Ta+a^TR_Xa$$
where:
- $r$ is the autocorrelation vector
- $R_X$ the autocorrelation matrix

The minimization can be computed:
$$\frac{\partial\sigma_Y^2}{\partial a}=2r+2R_Xa=0\rightarrow a^*=-R_X^{-1}r$$
Then the optimal variance becomes:
$$\sigma_Y^2=\sigma_X^2+r^Ta^*=\sigma_X^2-r^TR_X^{-1}r$$

$\newcommand{\log}{\text{log}}$ $\newcommand{\logt}{\text{log}_{10}}$ $\newcommand{\logn}[1]{\text{log}_{#1}}$ $\newcommand{\db}{{[\text{dB}]}}$ $\newcommand{\dbm}{{[\text{dBm}]}}$ $\renewcommand{\def}{{\ \stackrel\triangle= \ }}$ $\newcommand{\fourier}{\stackrel{\mathcal F}{\longrightarrow}}$

## 2.4) Chapter Recap
**Fundamentals:**
Quantizer: map $Q:x\in\mathbb R\rightarrow\hat x_i\in C=\curly{\hat x_1,\hat x_2,\dots}$. Defined by thresholds $t_i$, regions $\Theta_i=(t_i,t_{i+1})=\curly{x:Q(x)=\hat x_i}$, levels $\hat x_i$. $L=$ #levels. Error $e=x-Q(x)$.

Seen as encode ($x\to i$) / decode ($i\to\hat x_i$, = inverse quantization).

- **Rate:** $R=\log_2 L$. Assumes index distribution uniform (pessimistic, since $H\leq R$ with equality iff uniform) and binarization is entropy-coded.
- **Distortion (MSE):** $D=\E\sq{\abs{X-Q(X)}^2}=\sigma_E^2$.
- **Mid-tread** has a $0$ level $\Rightarrow$ suppresses near-zero noise; needs **odd $L$**. **Mid-rise** has no $0$ level $\Rightarrow$ amplifies noise; **even $L$**.

---
**Uniform Quantizer (UQ)**
$\Delta=A/L$ constant $\forall i$. Levels = cell midpoints, $\Theta_i=\par{\hat x_i-\tfrac\Delta2,\hat x_i+\tfrac\Delta2}$.

| Unsigned | Signed                                       | Deadzone (signed)                         | High Resolution                       |                                           |
| -------- | -------------------------------------------- | ----------------------------------------- | ------------------------------------- | ----------------------------------------- |
| Range    | $(0,A)$                                      | $(-\tfrac A2,\tfrac A2)$                  | $(-\tfrac A2,\tfrac A2)$              | any                                       |
| Type     | Mid-rise                                     | Mid-tread                                 | Mid-tread (large center)              | any, $L\to\infty$                         |
| $L$      | even                                         | odd                                       | odd                                   | $\to\infty$                               |
| $Q(x)$   | $\Delta\floor{\tfrac x\Delta}+\tfrac\Delta2$ | $\Delta,\text{round}\par{\tfrac x\Delta}$ | enc/dec with threshold $\tau$ (below) | $\Delta,\text{round}\par{\tfrac x\Delta}$ |
| $D(R)$   | —                                            | $\sigma_X^22^{-2R}$ (uniform input)       | —                                     | $\tfrac{\gamma^2}3\sigma_X^22^{-2R}$      |


**Deadzone (DZQ):** central cell wider, $\hat x=0$ for $\abs x<\tau$. Common in compression. $$i=\begin{cases}\text{sign}(x)\floor{\dfrac{\abs x+\frac{\tau\Delta}2}\Delta} & \abs x\geq\tau\[2pt]0&\abs x<\tau\end{cases}\qquad\hat x=\begin{cases}\text{sign}(i),\Delta\par{\abs i+\tfrac{1-\tau}2}&i\neq0\0&i=0\end{cases}$$

**Key results**
- **Minimax optimal:** given range and $L$, UQ has the smallest max error $e_\max=\tfrac{\Delta}2=\tfrac A{2L}$.
- Only quantizer with **analytical RD** under uniform input: $\boxed{D(R)=\sigma_X^22^{-2R}}$, with $\text{SNR}\approx6R$.
- General case (HR, no input knowledge): $\boxed{D(R)=\tfrac{A^2}{12}2^{-2R}=\tfrac{\gamma^2}3\sigma_X^22^{-2R}=K_X\sigma_X^22^{-2R}}$ $$\text{SNR}=10\logt\frac{\sigma_X^2}{A^2/12}2^{2R}\approx6R-10\logt\frac{\gamma^2}3,\qquad \gamma^2\def\frac{X_\max^2}{\sigma_X^2}=\frac{A^2/4}{\sigma_X^2}$$ where $\gamma^2$ = **load factor** (peak power / avg power) and $K_X=\gamma^2/3$.

> [!def] HR hypothesis $L\to\infty\ \Rightarrow\ \Delta\to0\ \Rightarrow\ p_X(x)\approx P_i$ const on each $\Theta_i$. Then $E\mid X\in\Theta_i\sim\mathcal U(-\tfrac\Delta2,\tfrac\Delta2)$, and by total probability $E\sim\mathcal U(-\tfrac\Delta2,\tfrac\Delta2)\Rightarrow D=\tfrac{\Delta^2}{12}$.

---
**Optimal Scalar Quantization**

Input density $p_X$ known $\Rightarrow$ minimize $D$ at fixed $R$.

**Optimal HR quantizer**
$$\sigma_Q^2=c_X,\sigma_X^2,2^{-2R},\qquad c_X=\frac1{12}\sq{\int p_U^{1/3}(t),dt}^3,\quad U=\tfrac X{\sigma_X}$$ $c_X$ = **shape factor**: depends only on the PDF _shape_, not variance ($U,X$ same shape).

- Uniform: $c_X=1$.
- Gaussian: $c_X=\tfrac{\sqrt3}2\pi\approx2.72$.

**Non-HR (low rate)**
No analytical formula. Necessary optimality conditions $\Rightarrow$ **Lloyd–Max** algorithm $\to$ local optimum.

---
**Predictive SQ**

Quantization is ineffective for non-sparse data. Predictive SQ exploits **inter-sample correlation**.

> [!def] Sparse Signal Most components zero or near zero.
> 
> - Low variance.
> - Near-zero samples quantized to $0$ with negligible distortion.
> - Natural signals aren't sparse, but can be sparsified (prediction, linear transform).

**Optimization paradigm**
Prediction error and signal error coincide $\Rightarrow$ performance gain depends only on predictor variance: prediction helps **iff $\sigma_Y^2<\sigma_X^2$**.

Proof (prediction error = signal error), valid in **closed loop** ($v$ built from $\hat x$ at both ends): $$q(n)=y(n)-\hat y(n)=\big(x(n)-v(n)\big)-\big(\hat x(n)-v(n)\big)=x(n)-\hat x(n)=\overline q(n)$$

SNR splits into prediction gain + quantizer gain: $$\text{SNR}=10\logt\frac{\sigma_X^2}D=\underbrace{10\logt\frac{\sigma_X^2}{\sigma_Y^2}}_{G_P}+\underbrace{10\logt\frac{\sigma_Y^2}D}_{G_Q}$$
 **Linear predictor**
Simple, optimal for Gaussian rv. Combination of $P$ past values: $$v(n)=-\sum_{i=1}^Pa_ix_{n-i}\ \Rightarrow\ y(n)=x(n)-v(n)=\sum_{i=0}^Pa_ix_{n-i},\quad a_0=1$$ As a filter: $y(n)=(a*x)(n)\ \zetatrans\ Y(z)=A(z)X(z)$, with $A(z)=\sum_{i=0}^Pa_iz^{-i}=1+a_1z^{-1}+\dots+a_Pz^{-P}$. Minimization acts only on $a$.

**Optimal filter (Yule–Walker):** the variance is a quadratic form $$\sigma_Y^2=\sigma_X^2+2r^Ta+a^TR_Xa,\qquad r=\text{autocorr. vector},\ R_X=\text{autocorr. matrix}$$ $$\frac{\partial\sigma_Y^2}{\partial a}=2r+2R_Xa=0\ \Rightarrow\ \boxed{a^*=-R_X^{-1}r}\ \Rightarrow\ \boxed{\sigma_{Y,\min}^2=\sigma_X^2+r^Ta^*=\sigma_X^2-r^TR_X^{-1}r}$$

**Practical points**
- **Order:** good up to $\approx4$. Distant pixels add little (screening effect: their correlation is already captured by closer neighbors) at higher complexity, negligible PSNR gain.
- **Closed loop mandatory:** predictor must use $\hat x$, else $v_{enc}\neq v_{dec}$, the cancellation $q=\overline q$ breaks, and error accumulates (**drift**).
- **Penalty:** predicting from $\hat x$ (not $x$) performs worse than direct quantization; recovered via **entropy coding**.
- **Local (block-wise) adaptation:** split image into $M\times M$ blocks, optimal filter per block. Rate overhead $+\tfrac{NB}{M^2}$ ($N$=order, $B$=bits/coeff).
    - Small block: good local stats, high overhead.
    - Large block: low overhead, poor local adaptation.

> [!example|*] Prediction gain for AR(1) $X(n)\sim\mathcal N(0,\sigma^2)$, $\E[X(n)X(m)]=\sigma^2\rho^{\abs{n-m}}$, fixed predictor $V(n)=X(n-1)$. Find $\rho$ s.t. $G_P>0$.
> 
> Need $G_P>0\db\iff\sigma_Y^2<\sigma_X^2=\sigma^2$. With $Y(n)=X(n)-X(n-1)$ (zero-mean Gaussian): $$\sigma_Y^2=\E[(X(n)-X(n-1))^2]=2\sigma^2-2\sigma^2\rho=2\sigma^2(1-\rho)$$ $$\sigma_Y^2<\sigma^2\iff2(1-\rho)<1\iff\boxed{\rho>\tfrac12}\iff G_P>0$$

# 3) Lossless Coding
Lossless coding means to decrease the number of bits needed to encode the data without losing any information: the process is reversible.

This is used in the quantization part: remap the indices $i(n)$ in order to optimize bitstream.

We must understand:
- **Theoretical Bound:** Source entropy
- **Practical Implementation:** algorithm efficiency and scalability
- **Possible without known statistics?** 

Lets start with some notation:
- **Alphabet:** $\mathcal X=\curly{x_1,...,x_M}$ set of symbols to encode
- **Code:** application between $\mathcal X$ and $\curly{0,1}$ (set of finite length bit strings)
#### Fixed Length Coding (FLC)
FLC assumes equiprobable alphabet: all codewords ave the same length, that is $M$ symbols $\rightarrow$ $L=\ceil{\log M}$ bits to encode each symbol (bpS) and a rate of $R=\log_2 L$

>[!example|*] FLC Text Compression
>An alphabet with 26 symbols is encoded with $\ceil{\log 26}=\ceil{4.7}=5$ bits per codeword. This has a compression ratio of 1.

#### Variable Length Code (VLC)
Exploit input distribution to assign less bits to more probable symbols. 
**Parsing problem:** create code where symbol is perfectly distinguishable in the bitstream

## 3.2) Principles of Information Theory
It is clear that there is a preferred code. VLC has a **prefix condition** where a instantaneous (prefix) code has no codeword is a prefix of another codeword. 

>[!thm] McMillan's Theorem
>Decodable codes do not improve performance with respect to instantaneous codes

Therefore, **we can focus only on instantaneous codes**

>[!thm] Kraft’s Inequality
>There exists a instantaneous code with lengths $\curly{l_1,...,l_M}$ iff
>$$\sum_i2^{-l_i}\leq 1$$

##### Kraft Proof:
Proof of Necessity ($\implies$): Codewords are already given, we must show the formula
Set $L_\max=\max_{i}\curly{l_i}$.
Then, by building a binary tree of the possible codes, the number of leaves (at level $L_\max$) is $2^{L_\max}$.
![[Pasted image 20260619125710.png|Binary Tree Example|250]]
Each code $c_i$ has $2^{L_\max-l_i}$ leaves and due to **prefix property** no codeword is a descendant of another: leaves are disjoint. The tree can be truncated at the position of each codeword
![[Pasted image 20260619130207.png|Example Tree Truncated at Codewords|250]]
Therefore we have that the number of leaves (codewords) are necessarily less than the maximum leaves:
$$\begin{align}
\sum_{i=1}^N2^{L_\max-l_i}&\leq 2^{L_\max}\\
\sum_{i=1}^N 2^{-l_i}&\leq 1
\end{align}$$
Proof of Sufficiency ($\impliedby$): We have the formula, we must build the code
The codes can be built as follows:
0. Create a complete binary tree of depth $L_\max$
1. Sort all lengths $l_1\leq....\leq l_N$
2. At each step $k=\curly{1,...,N}$ pick an available position at depth $l_k$ (increasing order)
3. Mark descendants of $l_k$ as forbidden. $2^{L_\max-l_i}$ leaves are blocked.

The code can be built if at step $k$ there is an available codeword of length $l_k$.
At each step the unavailable leaves (before adding $c_k$) are $\displaystyle\sum_{i=1}^{k-1}2^{L_\max-l_i}$. Therefore we have $\displaystyle2^{L_\max}-\sum_{i=1}^{k-1}2^{L_\max-l_i}$ available leaves. 
This can be normalized wrt the number of leaves $1-\sum_{i=1}^{k-1}2^{-l_i}$ available leaves.

By Kraft we have
$$\begin{align}
\sum_{i=1}^N2^{-l_i}=\sum_{i=1}^{k-1}2^{-l_i}&+\sum_{i=k}^N2^{-l_i}\leq 1\\
\sum_{i=1}^{k-1}2^{-l_i}&\leq 1-\sum_{i=k}^{N}2^{-l_i}\\
1-\sum_{i=1}^{k-1}2^{-l_i}&\geq \sum_{i=k}^{N}2^{-l_i}\geq2^{-l_k}>0\\
\end{align}$$

Since the remaining free capacity is at least $2^{-l_k}$, there must exist at least one free node at depth $l_k$ where the k-th codeword can be placed.
$$\endproof$$
#### Information and Entropy Recap
Suppose symbols $\curly{x_i}$ with probabilities $p_i$.
- The information of a symbol is 
$$I(x_i)=-\log_2 p_i=\log_2 \frac1{p_i}$$
- Properties:
$$\begin{gather}
I(x_i)>0\\
\text{if }p_i=1\rightarrow I=0\\
\text{if }x_i\text{ indep }x_j\rightarrow I(x_i,x_j)=I(x_i)+I(x_j)
\end{gather}$$


- The source entropy of $X=\curly{x_i}$ is
$$H(X)=-\sum_ip_i\log_2p_i=-\E[\log_2(p_X(x))]$$
this is the avg uncertainty of $X$.

- Joint Entropy:
$$H(X,Y)=-\sum_{i,j}p_{i,j}\log p_{i,j}$$
- Conditional Entropy
$$\begin{align}H(X|Y)=\sum_jp_jH(X|Y=y_j)\rightarrow H(X,Y)&=H(Y)+H(X|Y)\\ &=H(Y)+H(Y|X)\end{align}$$
- Properties:
$$\begin{align}
&H(X)>0\\
&H(X,Y)=H(X)+H(Y|X)=H(Y)+H(X|Y)\\
&H(X,Y)\leq H(X)+H(Y) \ (\text{= if }\perp)\\
&H(X|Y)\leq H(X)\ (\text{= if }\perp)\\
&H(X)\leq \log_2 M \ (\text{= if }X\sim u)
\end{align}$$
>[!thm] Fundamental: Conditioning Reduces Entropy
>$$H(X|Y)\leq H(X)$$
>That is: information never hurts, knowing Y we can better infer X

#### Lagrange's Method
Lagrange's method is a solution for minimax problems under a constraint $\phi(x)=0$

Consider a function $f:x\in \R^n\rightarrow\R$
In order to find the maximum or minimum of $f$ subject to the constraint $\phi(x)=0$, we look for the stationary points of 
$$J(x,\lambda)=f(x)+\lambda\phi(x),\quad \lambda \in \R$$
The stationary points are computed by setting to zero all the derivatives of $J$:
$$\frac{\partial J}{\partial x_i}=0,\quad \frac{\partial J}{\partial \lambda}=0$$
>[!example|*] Distribution with Maximum Entropy
>The distribution maximizing the entropy of a M-ary discrete r.v. is found applying the Lagrange’s method:
>$$p^*=\arg\max_p\sum_{i=1}^Mp_i\log\frac1{p_1},\qquad \sum_ip_i=1\rightarrow \phi(x)=\sum_ip_i-1=0$$
>Write $J$:
>$$J(p.\lambda)=-\sum_ip_i\log p_i+\lambda\par{\sum_ip_i-1}$$
>Calculate the derivative (specific $p_i$)
>$$\begin{align}\frac{\partial J}{\partial p_i}=-\par{\frac{\log e}{p_i}p_i+\log p_i}+\lambda=0\rightarrow p_i=\lambda-\log e\\
\frac{\partial J}{\partial\lambda}=\sum_{i=1}^Mp_i-1=0\rightarrow p_i=1/M
\end{align}$$
>The max uncertainty is obtained by setting all probabilities equal, that is $p_i=1/M$.

## 3.3) Optimal Code
The optimal code is the solution ot the following problem:

Given a set of $M$ symbols with probabilities $p_i$, the optimal code is the set of lengths such that:
- $\forall i=1,...,M,l_i\in \mathbb N$
- Kraft inequality is satisfied (prefix code)
- The averge length $\displaystyle{\mathcal L=\sum_{i=1}^Mp_il_i}$ is minimized among all possible sets of $l_i$'s

The optimal solution drops the first assumption ($l_i\in\mathbb R$) and obtains:
$$l_i^*=-\log_2p_i=I(x_i)\rightarrow \mathcal L^*=\sum_i-p_i\log_2p_i=H(X)$$
Since real codes cannot have fractional length, thsi bound is achieved only if the distribution is dyadic, that is every symbol's probability is a negative power of 2:
$$\forall i \in \{1,\dots,M\}, \;\exists k \in \mathbb{N} \;\;|\;\; p_i = 2^{-k}$$
therefore in the general case $\mathcal L^*\geq H(X)$ but by how much?

>[!thm] Shannon Source Coding Theorem
>For any random source $X$, the minimum average length $\mathcal L^*$ achievable by an instantaneous (prefix) code satisfies:
>$$\mathcal L^* \geq H(X)$$
>with equality if and only if the distribution of $X$ is **dyadic**.
##### Proof:
This is a constrained optimization problem:
$$l^*=\arg\min_l\sum p_il_i\qquad \sum_i 2^{-l_i}=1$$
$$\begin{align}J=\sum p_il_i+\lambda(\sum2^{-l_i}-1)\rightarrow \frac{\partial J}{\partial l_i}&=p_i-\lambda\cdot2^{-l_i}\ln2=0\rightarrow p_i=\lambda\ln2\cdot 2^{-l_i}
\end{align}$$
Sum all $p_i$:
$$\begin{gather}
\sum_ip_i=\lambda\ln 2\sum2^{-l_i}\\
1=\lambda\ln 2
\end{gather}$$
by placing this result in the initial derivative
$$\frac{\partial J}{\partial l_i}=p_i-\lambda\cdot2^{-l_i}\ln2=p_i-2^{-l_i}=0\rightarrow p_i=2^{-l_i}\rightarrow l_i^*=-\log_2p_i$$
And the avg length is then just the definition of entropy
$$\endproof$$
The equality for Kraft was used because we represent a **complete code**. One where no possible empty branch is left

#### Entropy Code
To keep the first assumption we have **Entropy Coding**
$$l_i=\ceil{-\log_2p_i}\rightarrow H(X)\leq \mathcal L^*<H(X)+1$$
Proof:
The choice of the ceil is set a priori, therefore we must first check if Kraft holds:
$$\begin{align}\begin{aligned}
l_i=-\log_2p_i+\delta_i&\qquad0\leq\delta<1\\
2^{-l_i}=p_i\cdot2^{-\delta_i}=\epsilon_i p_i&\qquad\frac12<\epsilon_i\leq1
\end{aligned}\\ \\
\sum_i2^{-l_i}=\sum_i\epsilon_ip_i\leq\sum_ip_i=1
\end{align}$$
Now the lower bound on the avg length comes directly from Shannon, while the upper bound is easily verifiable:
$$\begin{gather}
l_i=\ceil{-\log_2p_i}<-\log_2p_i+1\\
p_il_i<p_i-p_i\log_2pi\\
\mathcal L=\sum p_il_i<\sum p_i-p_i\log_2p_i=1+H(X)
\end{gather}$$
#### Huffman Code
Huffman discovered how to build the **optimal lossless coder for any source with known probabilities.**

Algorithm:
1. Create leaf nodes for each symbol, weighted by $p_i$
2. While there is more than one node:
	- Select two nodes with lowest weights
	- Create a new internal node as their parent
	- Set new node’s weight as sum of children’s weights
3. Assign ’0’ to left (upper) edges, ’1’ to right (lower) edges
4. Read code for each symbol from root to leaf

![[Pasted image 20260313110534.png|Example|250]]
This code has avg length $L^*=2.3$ and entropy $H(X)=2.246$

However now consider the following example:

>[!example|*]
>Let there be a BW text image. Clearly there are many more white pixels, therefore:
>$$P(X=B)=p\ll 1\quad P(X=W)=1-p$$
>The entropy now becomes
>$$H(X)\ll1$$
>However the avg length is exactly 1. 

Here the entropy is very small but the coding has high rate. This is due to a too small alphabet. It is possible to expand the alphabet by considering blocks of K symbols: 

#### Block Coding
Instead of mapping one symbol into one codeword, we can map many subsequent symbols into a single codeword. 
$$X^K=X_1X_2...X_K$$
The entropy is
$$H(X^K)\leq\sum_{i=1}^KH(X_i)$$
>[!thm] Entropic Rate
>We define the Entropy Rate as 
>$$\mathcal H(X)=\lim_{K\rightarrow\infty}\frac{H(X^K)}{K}$$
>For stationary processes it can be shown that
>$$\mathcal H(X)\leq H(X)$$

Then the avg length is 
$$\begin{gather}
H(X^K)\leq \mathcal L^*<H(X^K)+1\\
\frac{H(X^K)}K\leq \frac{\mathcal L^*}K<\frac{H(X^K)}K+\frac1K\\
\mathcal L^*_S\rightarrow \mathcal H(X)\leq H(X)
\end{gather}$$

This improves the **1bit penalty for non dyadic distributions**

However the complexity is exponential with $K$ and the joint entropy is very costly.

>[!example|*]
>This example will cover the different results (calculations not shown) for the following image:
>![[Pasted image 20260619163407.png|T|250]]
>Block size 1: $H(X)=0.586$, $\mathcal L^*=1$
>Block size 2: $H(X_1X_2)=1.022\rightarrow H/2=0.511$, $\mathcal L^*=1.3\rightarrow\mathcal L_S=0.65$ bpp
>Block size 4: $H(\prod X_i)=1.533\rightarrow H/4=0.383$, $L^*=1.733\rightarrow\mathcal L_S=0.433$ bpp


#### Arithmetic Coding
Arithmetic coding allows to perform block coding or context-based coding with linear complexity. This coder is suboptimal but asymptotically optimal. Since it has linear complexity, it can be easier scaled.
$$\mathcal L\leq H(X^K)+2\rightarrow \mathcal L_s=\frac {\mathcal L}K\stackrel{K\rightarrow\infty}\longrightarrow\mathcal H(X)$$
The code is built by determining an interval in $[0,1]$ according to its probability. Needs only 2 sums and 2 multiplications per interval (linear complexity!).

This is done achieved by **encoding a sequence as the center interval** with arbitrary precision $q\in[0,1]$ a fractional number. The arithmetic code can encode blocks of any size, even the entirety of the message.

![[Pasted image 20260323135724.png|Example|350]]
Proof of length:
From he above image the length of a message results:
$$L(n)=1-\ceil{\sum\log_2p_i}<2-\sum\log_2p_i$$
The average message length is
$$\overline L(n)<\frac{2-\sum\log_2p_i}n$$
and by taking the expected value the avg length can be found:
$$\mathcal L=\E[\overline L(n)]<\frac{2-\sum\E[\log_2p_i]}n=H(X)+\frac 2n\rightarrow \mathcal L< H(X)$$

#### Context Based Coding (TODO)
This approach consists in looking at  $N_s$ previous symbols to recognize the context (max $N_c=M^{N_s}$ with $M$ the alphabet) and changes the encoder based on the context. This conditioning reduces the entropy of the source.

**Engineering Challenge:** with the right context a shorter number of samples manages to better reach the entropy rate.

### 3.3.2) Recap
Here is a brief recap

| Scheme                    | Length rule                                     | Average-length bound                          | Complexity                         | Key idea / limitation                                                                    |
| ------------------------- | ----------------------------------------------- | --------------------------------------------- | ---------------------------------- | ---------------------------------------------------------------------------------------- |
| **Optimal (theoretical)** | $l_i^*=-\log_2p_i$ (real-valued)                | $\mathcal L^*=H(X)$                           | —                                  | Only achievable exactly if $p_i$ is dyadic                                               |
| **Entropy code**          | $l_i^*=-\ceil{\log_2p_i}$                       | $H(X)\leq\mathcal L\leq H(X)+1$               | low                                | Simple rounding; up to 1-bit/symbol penalty                                              |
| **Huffman**               | Greedy bottom-up tree merge                     | $H(X)\leq\mathcal L\leq H(X)+1$               | $O(M\log M)$                       | Provably optimal among integer-length codes; small-alphabet penalty (e.g. binary source) |
| **Block coding**          | Code $K$ symbols jointly                        | $L_S\to\mathcal H(X)\le H(X)$ as $K\to\infty$ | exponential in $K$ ($M^K$ symbols) | Removes 1-bit penalty asymptotically; explodes in cost                                   |
| **Arithmetic coding**     | Whole sequence $\rightarrow$ one interval/point | $\mathcal L_S< H(X)+\tfrac2n \to H(X)$        | linear, $O(n)$                     | Sub-optimal for finite $n$, asymptotically optimal; scales where block coding can't      |
| **Context-based coding**  | Condition on $N_s$​ previous symbols            | lowers effective entropy rate further         | depends on $N_c=M^{N_x}$​          | Exploits memory/correlation; right context model is the engineering challenge            |

---
## 3.4) Other Techniques (TODO)
### 3.4.1) Exp-Golomb Coding
Universal coding for integer numbers, size (bits) proportional to magnitude
#### Unisgned Integer
Given int $n\in\mathbb N$ the representation consists in
- write $n+1$ in binary
- use min number of bits: $b=\floor{\log_2(n+1)}+1$
- place $b-1$ leading zeroes

Example:
$$n=0\rightarrow \begin{cases}n+1=1_{10}\rightarrow 1_2\\
b=\floor{\log_21}+1=1\\
b-1=0\end{cases}\longrightarrow 1$$
$$n=6\rightarrow \begin{cases}n+1=7_{10}=111_{2}\rightarrow 1_2\\
b=\floor{\log_27}+1=3\\
b-1=2\end{cases}\longrightarrow 00111$$
#### Signed Integer
Given int $n\in\mathbb Z$ the representation consists in
- Map $\mathbb Z\rightarrow \mathbb N$ using $m(n)=\begin{cases}2n-1 &n>0\\-2n &n\leq0\end{cases}$
- Use Exp-Golomb for unsigned integer

Example:
$$n=-3\rightarrow m(n)=6\rightarrow 00111$$
$$n=-6\rightarrow m(n)=12\rightarrow \begin{cases}n+1=13_{10}=1101_{2}\rightarrow 1_2\\
b=\floor{\log_27}+1=4\\
b-1=3\end{cases}\longrightarrow 0001011$$
## 3.5) Standards (TODO)
#### JBIG

#### JPEG-LS

#### PNG

## 3.6) Neural Lossless Coding (TODO)

# 4) Transform Coding
Until now we have seen the following pipeline:
$$\text{Data}\stackrel{\text{lossy}}\longrightarrow\text{Quantized data at fixed rate}\stackrel{\text{lossless}}\longrightarrow\text{Entropy Coded Data}$$
The real pipeline inserts two stages before quantization:
- **Transform coding:** a reversible transform that sparsifies the block and gives each sample position a stationary meaning (e.g. DCT coefficient 0 = mean energy, the rest = increasing frequencies).
- **Block coding:** find the optimal rate per sample, that is, how sensible should be the quantizer for each sample.
- **Quantize:** apply those quantizers, this exploits unequal variances (high variance, many bits in quantizer, low variance only a few bits)
- **Entropy code:** pack the resulting bitstream exploiting the many resulting zeros to approach the entropy.

We start with **block coding**, because it defines _what we want from a transform and why_. But it must be clear from the start that block coding alone is useless on raw natural images (see [[#^370f58]]), for two distinct reasons:
- **No variable rate:** all pixels have (approximately) equal variance, so we revert to UQ
- **Too many quantizers:** even with unequal variances, one fixed quantizer can serve every block only if each position's variance is stationary across blocks (a constant per-sample meaning, as the transform provides, is one way to guarantee this).

The transform is precisely what supplies both: variance disparity (gain) and cross-block stationarity (one shared quantizer).

#### Digression: Arithmetic Mean (AM) vs Geometric Mean (GM)
First we must clarify the difference between AM and GM:
$$z_{AM}=\frac1M\sum_{k=1}^Mz_k\qquad z_{GM}=\sqrt[M]{\prod_{k=1}^M z_k}$$
We will see that in orthonormal transforms
- AM is unchanged ($\propto\mathcal L^2$ norm)
- GM can be reduced (energy concentration)

By **Jensen's inequality:**
$$z_{GM}\leq z_{AM}$$
Proof
Jensens inquality states that:
$$\sum_{k=1}^M\frac1Mf(z_k)\leq f\par{\sum_{k=1}^M\frac1Mz_k}=f(z_{AM})$$

with $f$ the log function:
$$\sum\frac1M\log z_k=\log\par{\prod z_k^\frac1M}=\log(z_{GM})\leq \log (z_{AM})$$
$$\endproof$$


## 4.2) Block Coding
Block coding aims to solve the **resource allocation problem**, that is, find the rate vector $R=[R_1,...,R_M]$ that minimizes global distortion on block $X=[X_1,...,X_M]$ under the constraint $\sum R_k=R_{tot}$. That is a different quantizer per sample

Recall that an optimal HR quantizer has a distortion for a sample of $D_k=c_k\sigma_k^22^{-2R_k}$. The **global distortion** is:
$$\begin{align}
\mathcal D&=\frac1M\E[\abs{X_Q(X)}^2]=\frac1M\E[(X-Q(X))^T(X-Q(X))]\\
&=\frac1M\E[\sum_k(X_k-QX_k)^2]
=\frac1M\sum_k\E[(X_k-Q(X_k))^2]=\frac1M\sum_kD_k\\
&=\frac1M\sum_{k=1}^Mc_k\sigma_k^22^{-2R_k}
\end{align}$$
The solution is the **Huang-Schulteiss formula:**
$$R_k^*=\frac{R_{tot}}{M}+\frac12\log_2\sq{\frac{c_k\sigma_k^2}{c_{GM}\sigma^2_{GM}}}$$
That is, the rate is a refinement of a uniform resource allocation $\overline R=R_{tot}/M$. 

The per sample distortion becomes:
$$D_k^*=c_k\sigma_k^22^{-2\overline R-\log_2(\cdot)}=c_k\sigma_k^22^{-2\overline R}\cdot \frac{c_{GM}\sigma^2_{GM}}{c_k\sigma_k^2}=c_{GM}\sigma^2_{GM}2^{-2\overline R}$$
And the global distortion only depends on the geometric mean:
$$\mathcal D^*=\frac1M\sum_k D^*_k=c_{GM}\sigma^2_{GM}2^{-2\overline R}$$
Here are two examples:
>[!example|*] Gaussian Optimal Rate
>Recall that for a gaussian rv the shape factor is constant and has this relation: $c_{GM}=x_k=c_\mathcal N$, then clearly:
>$$\mathcal D^*=c_{\mathcal N}\sigma_{GM}^22^{-2\overline R}$$

>[!example|*] ID RVs (PCM)
>When the k rvs are id we have that shape factor and vatiance are cnstant, therefore:
>$$c_k=c_X=c_{GM}\qquad \sigma^2_k=\sigma^2_X=\sigma^2_{GM}$$
>Then
>$$R_k^*=\overline R+\frac12\log\frac{c_k\sigma^2_k}{c_{GM}\sigma^2_{GM}}=\overline R\quad \mathcal D^*=c_X\sigma_X^22^{-2\overline R}$$
>the signal is not sparse at all, so block coding does not work
>
>If the ID signals are zero mean gaussian rvs, then we call it PCM, the coding distortion becomes
>$$\mathcal D_{X}=c_{\mathcal N}\sigma_{GM}^22^{-2\overline R}$$

^370f58

##### Proof (TODO)
The function to minimize and the constraint are:
$$\mathcal D=\frac1M\sum_{k=0}^{M-1}c_k\sigma_k^22^{-2R_k}\qquad \sum_{k=0}^{M-1}R_k\leq R_{tot}$$
By lagrange method we must minimize:
$$J(R,\lambda)=\frac1M\sum_{k=0}^{M-1}c_k\sigma_k^22^{-2R_k}+\lambda\par{\sum_{k=0}^{M-1}R_k- R_{tot}}$$
The derivatives become:
$$\frac{\partial J}{\partial R_k}=-\frac{2\ln 2}Mc_k\sigma_k^22^{-2R_k}+\lambda=0\qquad\frac{\partial J}{\partial \lambda}=\sum_{k=0}^{M-1}R_k- R_{tot}=0$$
from the first we get:
$$R_k=\frac12\log_2(c_k\sigma_k^2)+\underbrace{\frac12\log_2\frac{2\ln 2}{M\lambda}}_{\text{constant: }\lambda'}$$
Plugging it into the second we have:
$$\begin{align}
R_{tot}=M\lambda'+\sum\frac12\log_2(c_k\sigma_k^2)\rightarrow\lambda'&=\frac{R_{tot}}M-\frac1{2M}\sum\log_2(c_k\sigma_k^2)\\
&=\overline R-\frac12\log_2\prod(c_k\sigma_k^2)^{1/M}\\
&=\overline R-\frac12\log_2(c_{GM}\sigma_{GM}^2)
\end{align}$$
plug it again in the initial formula:
$$R_k^*=\frac12\log_2(c_k\sigma_k^2)+\lambda'=\overline R+\frac12\log_2\frac{c_{k}\sigma_{k}^2}{c_{GM}\sigma_{GM}^2}$$
$$\endproof$$

#### Practical Implementation of Huang-Schulteiss
HS has a series of limitations:
- Returns negative values
- Returns non-integer values

The **Modified HS algorithm** is very simple:
1. Use HS with all $M$ components
2. If there are negative values, set $R=0$ of the component and recalculate HS with $M-N$ components
3. When there are only positive values, floor the results
4. Calculate residual rate and allocate eventual residual bits to the results that got rounded the most

>[!example|*]
>Let there be a gaussian input with 4 components and $R_{tot}=10$:
>$$\sigma_1^2=1000, \ \sigma_2^2=100, \ \sigma_3^2=50,\ \sigma_4^2=1$$
>The GM is $\approx47.29$
>We get:
>$$R(1)\approx4.7,\ R(2)\approx3.04,\ R(3)\approx2.54, \ R(4)\approx -0.28\stackrel{\text{negative}}\longrightarrow 0$$
>Recompute HS with 1,2,3:
>GM $\approx 171$
>We get (also floor):
>$$R(1)\approx4.61\rightarrow4,\ R(2)\approx2.95\rightarrow2,\ R(3)\approx2.45\rightarrow2, \ R(4)=0\rightarrow0$$
>Since $4+2+2+0\not=10$ we can allocate 2 residual bits to components 1 and 2
>$$R(1)=5,\ R(2)=3,\ R(3)=2, \ R(4)=0$$
> The total distortion is:
> $$D=\sum D_i=\sum\sigma_k^22^{-2R_k}=0.98+1.56+3.13+1=6.67$$
> With equal rate it was:
> $$D=\sum\sigma_k^22^{-2\cdot 2.5}=35.97$$

The **greedy algorithm** returns the same allocation but is faster:
- Initialization. $R_k=0\ \forall k\in\curly{0,...,M-1}\qquad D_k=\sigma_k^2\forall k\in\curly{0,...,M-1}$
- While $\sum R_k\leq R_{tot}$
	- $l=\arg\max_k D_k$
	- $R_l\leftarrow R_l+1$
	- $D_l\leftarrow D_l/4$ (since ($D(R+1)=\sigma_k^22^{-2(R+1)}=\frac14\sigma_k^22^{-2R}=D(R)/4$))
This takes $R_{tot}$ iterations

>[!example|*]
>Consider the same data as before:
>![[Pasted image 20260330184338.png|Iterations 1-5|350]]
>![[Pasted image 20260330184430.png|Iterations 6-10|350]]
## 4.3) Transform Coding
A non-sparse signal codes badly. This chapter looks for a **transform that sparsifies** the signal (few large coefficients, many small ones).

We want a transform with the following properties:
- **Invertible:** $Y=T(X)\iff X=T^{-1}(Y)$
- **Input in $\R^M$** (e.g. an image lives in $\R^2$)
- **Non-sparse input → sparse output, at the same quantization error**

We restrict to a **linear** transform $Y=\mathcal T X$, with $\mathcal T$ an invertible matrix:
- inverse exists by definition;
- it acts as a **change of basis** (the columns of $\mathcal T^{-1}$ are the signals we reconstruct with);
- if $\mathcal T$ is **orthonormal**, quantization error is preserved (energy is conserved);
- we then seek the $\mathcal T$ that **minimizes the GM** of $Y$ (maximal energy concentration).

**Paradigm:**
$$x \;\to\; y=\mathcal T x \;\to\; \hat y = Q(y) \;\to\; \hat x = \mathcal T^{-1}\hat y$$
A coding quality is determined by the coding gain:
$$G_{\mathcal T}=\frac{\sigma^2_{AM,Y}}{\sigma_{GM,Y}^2}$$
#### Orthogonal Transform
For OT we have:
- Inverse is immediate: $\mathcal T^{-1}=\mathcal T^T$
- They are isometries (keep $\mathcal L^2$ norm): $\abs{Y}^2=\abs{\mathcal TX}^2=\abs{X}^2$

Since it is an isometry, the distortion is the same:
$$MD_Y=\E[\abs{Y-\hat Y}^2]=\E[\abs{\mathcal TX-\mathcal T\hat X}^2]=\E[\abs{\mathcal T(X-\hat X)}^2]=\E[\abs{X-\hat X}^2]=MD_X$$
And also the AM (avg of variances):
$$\sigma^2_{AM,Y}=\frac1M\sum\E[Y_k^2]=\frac1M\E[\sum Y_k^2]=\frac1M\E[\abs Y^2]=\frac1M\E[\abs X^2]=\sigma^2_{AM,X}$$
Where logically, the quantizers used are the ones that block code optimized for $Y$, so we can call this distortion the **transform distortion** $D_{\mathcal T}$ ($D_{\mathcal T}=D_X=D_Y$), while the **uniform rate (PCM)** distortion is $D_{PCM}$.

We define the **coding gain** as the ratio:
$$G_{\mathcal T}=\frac{D_{PCM}}{D_{\mathcal T}}=\frac{c\,\sigma_{AM}^2\,2^{-2\overline R}}{c\,\sigma_{GM,Y}^2\,2^{-2\overline R}}=\frac{\sigma_{AM,Y}^2}{\sigma_{GM,Y}^2}\geq 1$$

**PCM distortion** (input is id $\rightarrow$ equal variances $\rightarrow$ $\sigma_{GM}^2=\sigma_{AM}^2$ $\rightarrow$ trivial allocation, same rate $\overline R$):
$$D_{PCM}=c_{X}\sigma_{X}^2=c\,\sigma_{AM}^2\,2^{-2\overline R}$$
**Transform distortion** (isometry fixes $\sigma_{AM}^2$; equal shape factors on avg):
$$D_{\mathcal T}=c\,\sigma_{GM,Y}^2\,2^{-2\overline R}$$

#### Optimal Transform (KLT)
An optimal transform is the the transform that, given a random vector $X$ with known statistical properties, has a mathematically optimal guarantee to decorellate the components and maximizes energy compaction.

The answer is the **Karhunen-Loève Transform (KLT)**
The rows of this matrix are the eigenvectors of the correlation matrix $R_X=\E[XX^T]$. This allows the transform to be oriented along the maximum variance direction

Intuition: In the $Y$ domain, knowing the value of $Y_1$ provides zero linear information about $Y_2$. The redundancy present in the "diagonal" alignment is removed

Properties:
- Orthogonality: $T_{KLT}^{-1}=T_{KLT}^T$
- Decorrelating transform: $\E[Y_iY_j]=\lambda_i\delta_{ij}$
- Best energy concentration (sparsity): $\sum\E[Y_i^2]\geq\sum\E[(TX)^2]$ where $T$ is any other transform
- Optimal for gaussian RV: $\sigma_{GM,Y}^2\leq\sigma_{GM,TX}^2$

![[Pasted image 20260621173122.png|Example|300]]
Most coefficients will have near zero variance, so these can be discarded or coarsely quantized since the don't impact the MSE much.

It maximizes the coding gain as gaussians will be id:
$$G_{\mathcal T}=\frac{\sigma^2_{AM,Y}}{\sigma_{GM,Y}^2}=\frac{\frac1M\sum\sigma_i^2}{\par{\prod\sigma_i^2}^{1/M}}$$
However:
- Requires $O(n^3)$ to find eigenvectors, $O(n^2)$ for the multiplication
- Since data dependent, it must be sent to the decoder as metadata
- Model is often not stationary!

#### Frequency Transforms (DFT, DCT)
For a markov process with correlation $\rho\rightarrow 1$ frequency transforms offer near optimal performance (with fixed basis functions ad FFT algorithms $O(n\log n)$).

##### Discrete Fourier Transform (DFT)
The 1D case is the following:
$$y[k]=\frac1{\sqrt M}\sum_{n=1}^Mx[n]e^{-j\frac{2\pi}Mkn}$$
Or in matrix form:
$$\mathcal T_{DFT}=\frac1{\sqrt M}\begin{bmatrix}
1&1&1&...&1\\
1&W_M&W_M^2&...&W_M^{M-1}\\
1&W_M^2&W_M^4&...&W_M^{2(M-1)}\\
\vdots & \vdots&\vdots&\ddots&\vdots\\
1&W_M^{M-1}&W_M^{2(M-1)}&...&W_M^{(M-1)(M-1)}
\end{bmatrix}$$
Where $W_M=e^{-j2\pi/M}$ is the M-th primitive root of unity
Each row is therefore the conjugate of a basis vector.
the total energy is preserved: $\|y\|^2=\|x\|^2$

In 2D, the DFT is a separable transform:
$$Y=\mathcal T X\mathcal T^T$$
this computes the rows and then the columns (horizontal and vertical frequency analysis)
This transform decomposes the image into a weighted sum of $N^2$ orthogonal basis patterns:
$$B_{k,l}(n,m)=\frac1Ne^{j\frac{2\pi}N(kn+lm)}$$
each coefficient $Y[k,l]$ represents the frequency component of horizontal and vertical frequency combination
Most energy is concentrated in the low frequencies.

This is still not ideal since the DFT suposes a periodic signal. We compress finite signals and therefore on the image edges we have spectral leakage (low frequencies leak into high ones) making the signal less sparse

##### Discrete Cosine Transform (DCT)
A general approach is used **Discrete Cosine Transform (DCT)**
- Create mirrored-periodic version of the signal
- Compute DFT of signal+mirror
- Apply frequency domain modulation to obtain symmetrical and real valued oceffieicnts
- Keep only $M$ coefficients (og signal length)

Which can be rewritten in a signle transform where each entry follows the form:
$$(\mathcal T_{DCT})_{k,n}=\begin{cases}
\frac1{\sqrt N} & k=0\\
\sqrt{\frac{2}{N}}\cos(\frac{(2n+1)k\pi}{2N}) &k>0
\end{cases}$$
DFT is not used since DFT has high frequency components near the signal edges. The DCT is a way to mirror the signal before the periodicity. It has only positive frequencies

Applying the DCT to a signal ( a sequence of $M$ real numbers) produces $M$ real coefficients and has a better sparsification property than DFT thanks to the symmetric periodization.

![[Pasted image 20260330185522.png|Example With Mirroring|450]]
The DCT is also separable:
$$Y=\mathcal T_{DCT}X\mathcal T_{DCT}^T$$
A large-size, non-stationary image is more conveniently represented by dividing it into small blocks. 

Example: 8 × 8 block-based DCT. Each 8 × 8 block of pixels from the image is projected onto the 64 basis vectors: The corresponding scalar product is the DCT coefficient telling how much the block is similar to the basis vector
![[Pasted image 20260331110618.png|Block DCT|450]]
![[Pasted image 20260331110634.png|8x8 Basis|250]]
The sparsification allows to give higher bits to many small valued coefficients and lower bits to less frequent bigger values. How are the quantization coefficients computed?
- HS formula (practical implementation)
- Fixed steps (JPEG)

Large blocks: stationarity
Small blocks: correlation
## 4.4) JPEG standard
JPEG is an image compression standard defined in 1991 that defines **only the decoder** for interoperability and implementation competition

![[Pasted image 20260331111153.png|JPEG Scheme|450]]

This is the encoder:
**Step 0; Preprocessing:** includes $8\times8$ block creation and centering ($-128$ on each sample). 
**Step 1; DCT:** 2D DCT is applied on $8\times8$ blocks of centered samples (find $y_{ij}$)
**Step 2; Quantization:** uses a **mid tread** quantizer. The quantization table $q_{ij}$ is not defined by the standard, therefore it must be encoded. Notice that $q$ is the step size. A bigger $q$ means fewer bits and therefore less quality (as an idea think of it like this $q=255/2^R$)
$$\hat c_{ij}=\text{round}(\frac{y_{ij}}{q_{ij}})$$
**Step 2.5; Quality Factor:** The **quality factor** $Q\in[1,100]$ that controls the scaling factor (used during quanization):
$$S_F=\begin{cases}
\frac{5000}Q&1\leq Q\leq 50\\
200-2Q&50<Q\leq 99\\
1 &Q=100
\end{cases} \ \rightarrow q\leftarrow\frac{S_F}{100}q$$

**Step 3; Zig-Zag Scan + Entropy coding:** see later

Now the decoder:
**Step 0; Entropy Decode:** from zigzag + entropy decode it to find quantized blocks.
**Step 1; De-Quantization:** multiply quantized coefficients by q.
$$\hat y_{ij}=\hat c_{ij}\cdot q_{ij}$$
**Step 2; Inverse DCT:** apply the IDCT on each dequantized block and reconstruct the signal by uncentering ($+128$ on each sample)


#### Zig Zag Scan:
A zig-zag scan is performed on the quantized values in order to encode them in a single string, where
- the first value is the Difference of the DC component of this block and the previous block
- the next values are a pair of numbers representing (# of zeroes in scan, value of first non zero)
- final EOB special symbol is added to end the string  it is $(0,0)$


| $DC_n-DC_{n-1}$ | $(\text{\# of zeroes},\text{non zero coeff value})$ | ... | EOB $(0,0)$ |
| --------------- | --------------------------------------------------- | --- | ----------- |

![[Pasted image 20260401191026.png|Zig-Zag scan|100]]

![[Pasted image 20260621193012.png|Example|350]]

##### Entropy Coding of DC Coefficients

>[!col]
JPEG encodes the DC difference with a pseudo-huffman code.
There are $k\in\curly{0,...,11}$ categories, each of them holding $2^k$ values using 2's complement. Each category is assigned a codeword (see table).
> $$ $$
>Call $DC_p$ the DC difference, the category is chosen $k=\ceil{\log_2(|DC_P|+1)}$
>To the category the binary value of $DC_P$ is added as a suffix. If it is negative each value is complemented. 
>
>![[Pasted image 20260401193857.png|Category Code|250]]

For example suppose $DC_P=-5_{10}=101_2$ that must be complemented to $010$. The category is $k=3\rightarrow100$ and thus the codeword is $100\ 010$.

DC values have a range  $\in[-1024,1060]$ a difference of two DC signals is $\in[-2040,2040]$ and thus with cardinality $4081$. Since there are 11 categories we have $\sum_{k=0}^{11}2^k=2^{12}=1096>4081$ values.

##### Entropy Coding of AC Coefficients
Recall that these coefficients are previously encoded as $(a,b)$. These values are used to find the pseudo huffman entropy encoded codeword which is prefix+:
$$[(a,k)\text{ in RC table prefix\ }|\ b \text{ DC pseudo huffman}]$$
That is: 
- First compute $k=\ceil{\log_2(|b|+1)}$ and $b$ in binary
- Then find the prefix code corresponding to $(a,k)$ (table)
- Put prefix + $b$ together

Example: Encode (3,16):
- $k=\ceil{\log_217}=5$ and $b=10000_2$
- In tabe see that $(3,5)=1111111110010000$
The codeword is: $1111111110010000\ 10000$


Two custom codewords are described:
- End Of Block (EOB) $= (0,0) \rightarrow 1010$
- Zero Run (ZR) $=(15,0)\rightarrow 11111111001$

#### Frame Building
The standard frame follows this logic:
![[Pasted image 20260401200043.png|Frame|350]]
- Frame header contains static info (size, color space, digitalization format)
- Image is stored in a frame as various scans

- Scan header contains quantization table (luminance and chrominance)
- A single scan contains various segments, each segment is a concatenation of blocks
- Segment header contains huffman tables

JFIF (JPEG File Interchange Format) is the standard format for metadata in JPEG files 

## 4.5) Chapter Recap
**Block coding (resource allocation problem)**
Minimize $\mathcal D=\frac1M\sum_k c_k\sigma_k^2 2^{-2R_k}$ subject to $\sum_k R_k=R_{tot}$.
- Optimal rate (Huang–Schultheiss):
$$R_k^*=\overline R+\frac12\log_2\frac{c_k\sigma_k^2}{c_{GM}\sigma^2_{GM}},\qquad \overline R=\frac{R_{tot}}{M}$$
- Optimum **equalizes** per-sample distortion, so the global distortion depends only on the GM:
$$\mathcal D^*=c_{GM}\,\sigma^2_{GM}\,2^{-2\overline R}$$

**AM vs GM.** $\;z_{GM}\le z_{AM}$ (Jensen, $\log$ concave), equality $\iff$ all $z_k$ equal.

**Coding gain.** Orthonormal transform conserves energy ($\sigma^2_{AM}$ fixed by isometry, $D_X=D_Y$) but lowers $\sigma^2_{GM}$ (energy concentration):
$$G_{\mathcal T}=\frac{D_{PCM}}{D_{\mathcal T}}=\frac{\sigma^2_{AM,Y}}{\sigma^2_{GM,Y}}\ge 1,\qquad =1 \iff \text{all }\sigma_k^2\text{ equal}$$
$$D_{PCM}=c\,\sigma^2_{AM}\,2^{-2\overline R},\qquad D_{\mathcal T}=c\,\sigma^2_{GM,Y}\,2^{-2\overline R}$$
⇒ block coding helps **only with variance disparity**; the transform exists to create it.

**KLT.** Rows = eigenvectors of $R_X=\E[XX^T]$. Decorrelates ($\E[Y_iY_j]=\lambda_i\delta_{ij}$); optimal energy compaction (top-$p$ partial energy maximal $\forall p$); minimizes $\sigma^2_{GM,Y}$ ⇒ maximizes $G_{\mathcal T}$. For Gaussian $X$: decorrelation ⇒ **independence** ⇒ rate–distortion optimal. Cost: $O(n^3)$, data-dependent (basis must be transmitted), assumes stationarity.

**DCT.** Fixed basis, $O(n\log n)$, no basis to transmit; near-optimal for Markov sources with $\rho\to1$. Symmetric periodization avoids DFT edge leakage → real, sparser coefficients.

**Modified Huang–Schultheiss** (fixes negative / non-integer rates)
1. Run HS on all $M$ components.
2. Any $R_k<0$ → set $R_k=0$, drop that component, re-run HS on the rest.
3. Repeat until all rates $\ge 0$; then **floor** them.
4. Distribute leftover bits ($R_{tot}-\sum\lfloor R_k\rfloor$) to the components rounded down the most.

**Greedy bit allocation** (same result, $O(R_{tot})$)
- Init: $R_k=0$, $D_k=\sigma_k^2\ \forall k$.
- Repeat $R_{tot}$ times:
  - $l=\arg\max_k D_k$
  - $R_l \mathrel{+}= 1$, then $D_l \mathrel{/}= 4$ (since one extra bit quarters distortion).

**KLT construction**
1. Estimate $R_X=\E[XX^T]$.
2. Eigendecompose: $R_X=U\Lambda U^T$.
3. Transform $Y=U^T X$ (rows of $\mathcal T_{KLT}=U^T$ are the eigenvectors).
4. Coefficient $Y_i$ has variance $\lambda_i$; keep / finely quantize large $\lambda_i$, discard small ones.

**JPEG encoder**
0. **Preprocess:** 8×8 blocks, level-shift $-128$.
1. **DCT:** 2-D DCT per block → $y_{ij}$.
2. **Quantize:** build table (base × quality $Q$, clamp $\max(1,\cdot)$); mid-tread round $\ell_{ij}=\text{round}(y_{ij}/q_{ij})$ → small coeffs become 0.
3. **Zig-zag + RLE:** DC differential ($DC_n-DC_{n-1}$); AC as (run-of-zeros, value); EOB $(0,0)$, ZRL $(15,0)$.
4. **Entropy code:** pseudo-Huffman (category $k=\lceil\log_2(|v|+1)\rceil$ + magnitude bits) → bitstream. Quant + Huffman tables go in the header.

**JPEG decoder** (reverse)
0. **Entropy decode** bitstream → levels $\ell_{ij}$.
1. **De-quantize:** $\hat y_{ij}=\ell_{ij}\,q_{ij}$.
2. **IDCT** per block.
3. **Uncenter** $+128$, clamp to $[0,255]$.

Block coding defines *what a good transform must do* (maximize $\sigma^2_{AM}/\sigma^2_{GM}$) → KLT does it **optimally** → DCT does it **cheaply** → JPEG **packages** it. Transform creates redundancy as variance disparity, allocation spends bits on it, entropy coding harvests the resulting zeros.

# 5) Wavelet Transform
Recall the principle of a spectrum analyzer (short time fourier transform) ([[DSP 2]]). Frequency and time resolutions are inversely proportional to each other
$$\text{Heisenberg-like Uncertainty principle: }\Delta t\cdot \Delta f\geq \frac1{4\pi}$$
Wavelet is the tool that allows the block of the JPEG to scale dynamically based on frequency (high frequency, smaller blocks. Low frequency, large blocks). In fact an image is made of two parts:
- **Anomalies:** High frequency content (edges, contours). This needs a good time resolution to see where they are located
- **Trends:** low frequency content (smooth areas, textures). This needs good frequency resolution to better capture subtle shifts in the image

To achieve this we use a **mother wavelet** $\psi(t)$ and generate the basis through scaling and translation:
$$\psi_{a,b}(t)=\frac1{\sqrt a}\psi\par{\frac{t-b}{a}}$$
This works with the

>[!thm] Universal Principle
>The linear transforms used in signal processing and compression are defined by projection of the input signal onto an appropriate set of basis functions.
>
>Given an orthonormal basis $\curly{\phi_k(t)}$ any signal can be perfectly represented as 
>$$x(t)=\sum_kc_k\phi_k(t)$$
>and the coefficient is obtained by
>$$c_k=<x(t),\phi_k(t)>=\int x(t)\phi_k^*(t)dt$$

## 5.1) Discrete Wavelet Transform
Discrete Wavelet Transform starts with the filter bank, collections of filter that divide the signal in different subbands:

#### Filter Bank
The idea is to divide the signal in two parts: high and low frequency. These will have their bandwidth halved and so they get decimated and interpolated with a factor of 2. These get recombined to get a delayed copy of the original signal.
![[Pasted image 20260402131450.png|Filter Bank Scheme|350]]

$$x[n] \;\xrightarrow{H_i}\; \tilde c_i[n] \;\xrightarrow{\downarrow 2}\; c_i[k] \;\xrightarrow{\uparrow 2}\; \hat{c}_i[n] \;\xrightarrow{F_i}\; v_i[n] \;\xrightarrow{\sum}\; \tilde{x}[n]$$
where these steps are followed:
$$\begin{align}
H_i\text{ is the bandpass filter: }&\tilde c_i[n]=(h_i*x)[n] &&\tilde C_i(z)=H_i(z)X(z)\\
\text{Downsampling is done as: }&c_i[n]=\tilde c_i[2n] &&C_i(z)=\frac12[\tilde C_i(z^{1/2})+\tilde C_i(-z^{1/2})]\\
\text{Upsampling isdone as: } &\hat c_i[n]=\begin{cases}c_i[n/2]&n\text{ even}\\0&n\text{ odd}\end{cases} &&\hat C_i(z)=C_i(z^2)\\
F_i\text{ is the synthesiys filter: }&v_i[n]=(f_i*\hat c_i)[n]&&V_i(z)=F_i(Z)\hat C_i(z)\\
\text{Final output: }&\tilde x[n]=\sum v_i[n]&&\tilde X(z)=\sum V_i
\end{align}$$

Filter banks have these properties:
- **Perect Reconstruction (PR):** see later
- **Invertible Modulation Matrix:** see later
- **Finite Impulse Response**
- **Orthogonality**
- **Vanishing Moments**
- **Symmetric**

Only 2 filters have these properties:
- **Quadrature Mirror Filters (QMF):** 
$$H_0(z)=H_1(-z) \text{ and } F_0(z)=H_0(z), \ F_1(z)=-H_1(z)$$
- **Conjugate Quadrature Filters (CQF):** 
$$H_0(z)=H_1(-z) \text{ and } F_0(z)=H_0(z^{-1}), \ F_1(z)=-H_1(z^{-1})$$
Both are Orthogonal and energy conserving. A special case is the **Haar filter**, which is both A QMF and CQF at the same time (see later).

##### Perfect Reconstruction
Let $x[k]$ be the original signal and $\tilde x[k]$ the signal after passing through the filter bank. **Perfect reconstruction** is achieved if $\tilde x[k]$ is a delayed copy of $x[k]$, that is:
$$\tilde x_k=x_{k+l}\iff\tilde X(z)=z^{-l}X(z)$$
**Perfect reconstruction analysis** of a 2-channel filter bank is:

$$\tilde{X}(z) = \frac{1}{2}\underbrace{\bigl[F_0 H_0(z) + F_1 H_1(z)\bigr]}_{T(z)}\,X(z) \;+\; \frac{1}{2}\underbrace{\bigl[F_0 H_0(-z) + F_1 H_1(-z)\bigr]}_{A(z)}X(-z)$$

By recalling the definition of perfect reconstruction we can build a system by defining:
- Non distortion (ND) conditions: $T(z)=2z^{-l}$
- Aliasing Cancellation (AC): $A(z)=0$

$$\begin{gather}

\tilde X(z)=\frac12\underbrace{\begin{bmatrix}
H_0(z)&H_1(z)\\
H_0(-z)&H_1(-z)
\end{bmatrix}}_{\text{modulation matrix}}\cdot
\begin{bmatrix}
F_0(z)\\ F_1(z)
\end{bmatrix}X(z)
=\frac12\begin{bmatrix}
2z^{-l}\\0
\end{bmatrix}X(z)=z^{-l}X(z)
\end{gather}$$

Proof of reconstruction:
$$\begin{align}\tilde X&=v_0+v_1\\
&=F_0\hat C_0+F_1\hat C_1\\
&=F_0C_0(z^2)+F_1C_1(z^2)\\
&=\frac12F_0[\tilde C_0(z^{1/2})+\tilde C_0(-z^{1/2})]+\frac12F_1[\tilde C_1(z^{1/2})+\tilde C_1(-z^{1/2})]\\
&=\frac12F_0(H_0(z)X(z)+H_0(-z)X(-z))+\frac12F_1(H_1(z)X(z)+H_1(-z)X(-z))\\
&= \frac{1}{2}{\bigl[F_0 H_0(z) + F_1 H_1(z)\bigr]}\,X(z) \;+\; \frac{1}{2}{\bigl[F_0 H_0(-z) + F_1 H_1(-z)\bigr]}X(-z)
\end{align}$$

---
##### Modulation Matrix Invertibility
The modulation matrix needs to be invertible:
$$\tilde X(z)=\frac12\underbrace{\begin{bmatrix}
H_0(z)&H_1(z)\\
H_0(-z)&H_1(-z)
\end{bmatrix}}_{\text{modulation matrix}}\cdot
\begin{bmatrix}
F_0(z)\\ F_1(z)
\end{bmatrix}X(z)$$
$$\forall z\in\mathbb C: |z|=1, \ \Delta(z)=H_0(z)H_1(-z)-H_1(z)H_0(-z)\not =0$$
##### Orthogonality
QMF and CQF are orthonogal to **ensure energy conservation:**
$$\sum (x_k)^2=\sum(c_k)^2+\sum(d_k)^2$$
##### Vanishing Moments
VM represents the ability of a filter to reproduce polynomials: 
A filter with VM of $p$:
- Can represnet polynomial of degree up to $p$
- Has $2p$ taps 

The HP filter looses infomation as it has a finite tap, but it's information remains in 

#### Border problems
What we have seen works for 1D infinite signal, but images are 2D (no problem since filters are separable) and with **finite support.** We have 3 approaches:

- **Standard approach:** zero padding and DTFT. This produces **coefficient expansion,** the output signal has $N+M-1$ coefficients (N input size and M filter size). 
- **Circular Convolution:** This is obtained via periodicization of the signal. This however introduces boundary artifacts (aliasing in frequency) because of the implicit periodicization of the circular convolution (DFT)
![[Pasted image 20260402141513.png|Example Of Boundary Artifacts|350]]
- **Symmetrization:** We create a new signal by adding a mirror image of the original signal to the period. Let $x$ have period $N$ then $x_s$ has period $2N$. The circular convolution (with periodic filter) will return a periodic and symmetrical signal and thus only the first $N$ samples have to be computed. This does not create artifacts.
![[Pasted image 20260402141526.png|Example of Symmetric signal (in black the N not calculated coefficients)|350]]
However this doubles the filter coefficients unless the filter is symmetric!

#### Haar and Biorthogonal Filters
The only symmetric FIR orthogonal filter is the Haar filter
$$\begin{align}
h_0[k]=[1,1]&\quad f_0[k]=[1,1]\\
h_1[k]=[1,-1]&\quad f_1[k]=[-1,1]
\end{align}$$
Unfortunately this is a filter with Vanishing moment (VM) of $p=1$. The high pass filter will not respond to polynomials with degree $<p$. We need at least $2p$ taps. 

Haar has $p=1$ and can only represent piecewise linear functions.
We consider the **Cohen-Daubechies-Fauveau (CDF)** biorthogonal filter:
- Symmetric
- Maximize VM
- close to orthogonal ($\omega_i\approx 1$)

Here is a 3 level wavelet decomposition
![[Pasted image 20260403162823.png|Three wavelet decomposition|350]]
and then reconstructing the signal in order.

#### 2D Wavelet Decomposition
For 2D signals it is possible to use this schema:
![[Pasted image 20260403163646.png|2D|350]]
and for multi level decomposition just the output $c_i$ is used.
The 4 outpust are:
- $c$ (A): approximation coefficients (low res version of og image by LP filter in both directions)
- $d^H$ (H): horizontal HP (HP on rows, LP on cols)
- $d^V$ (V): vertical HP (HP on cols, LP on rows)
- $d^D$: diagonal details

Here you can see the various outputs after one level of decomposition
![[Pasted image 20260624103446.png|Example|200]]

Applying this sparsifies the signal:
![[Pasted image 20260403164118.png|One Level|350]]
![[Pasted image 20260403164140.png|5 Levels|350]]
the optimal levels are between 4-6.


## 5.2) Image Compression with Wavelets

We will study two approaches:
- Inter Scale Dependency (EZW): Tree based representation, low complexity with inter scale dependency, not resolution scalable
- Inter Scale Dependency (JPEG 200): Explicit bit rate allocation + entropy coding. Reslution scalable and allows for random access, no intra scale dependency.

#### Embedded Zerotrees of Wavelet Coefficients (EZW)
Here are the properties:
- Quality scalable: progressive representation
- Lossles to lossy
- Small complexity
- RD better than JPEG

Exploits **auto similarity:** when a coeff is small, also its descendants are, then we can save with just 1 symbol

##### Construction of Auto Similarity Principle:
Each new bit should convey max information: send first big coefficients, but has **localization overhead**: subband scan+ zero tree

One (partial solution) is the **subband scan:** scan in order C,H,V,D from smallest to highest subband

We also need a way to find biggest coeff first without sending localization info. Exploit inter-band correlation to predict position of non significant coeff.
One pixel in the subband has 4 times as more coeff in the next band. **If a coeff is small, also its descendants are**. A (sub-)tree of below-the-threshold coefficients is called a zero-tree. it is encoded with only one symbol.

##### EZW Algorithm
This allows to encode the bitplane $\log_2 T_k$ at the $k$-th pass where each new bitplae refines the coeff quantization. Significant symbols are losslessly encoded

Heuristic:
Walk the tree coarse-to-fine. If you find a big coefficient, announce it (SP/SN) and move it to SS S. If you find a small coefficient whose whole subtree is also small, prune it (ZR). If you find a small coefficient with a significant descendant somewhere below, mark it IZ and keep scanning. Then halve the threshold and do it again, but first refine everything already in SS S by one more bit.

It is done in these steps:
1. Set $k=0$, $n=\floor{\log_2|c_\max|}$, $T_k=2^n$
2. Let $\mathcal L$ be the list of coeff in SB scan.Let $S=0$ be the list of significant coeff 
3. while (rate<available rate)
	1. Dominant pass
	2. Refining pass
	3. $T_{k+1}\leftarrow T_k/2$
	4. $k\leftarrow k+1$
4. end

**Dominant pass:**
1. Until $\mathcal L$ is not empty:
	1. Let $c$ be the first coeff in the list
	2. If $c>T_k$ encode $c$ as Significant Positive (SP) and put in $S$
	3. elif $c<-T_k$ ancode as Significant Negative (SN) and put in $S$
	4. elif no desc bigger than $T_k$ (in abs), then
		1. Encode $c$ as ZR (zero tree root)
		2. remove desc from $\mathcal L$
	5. Else encode $c$ as isolated zero (IZ)
2. Remove $c$ from $\mathcal L$

**Refining Pass:**
1. Let $b=\log:2T_k$ the currwnt bit plane index
2. For all $c$ in $S$ encothe the $b$-th bit of binary representation

##### Example (SEE BETTER)
Consider this image:
![[Pasted image 20260624105813.png|Example|250]]

- **Bitplane 1:**
Notice $T=2^4$
**Dominant pass**
Since $26\geq 16$ it is SP
Then $6\leq 16$ and also its descendants ($-12,10,6,4$) so ZR
Same for $-7,3$
At the end of dominant pass at bitlplane 1 we have:
$$\text{SP,ZR,ZR,ZR}$$
**Refinement Pass**
One SP, find it's $\log_2T=4$ bit: $26_{10}=11010_2\rightarrow$ select $1$
$$\text{SP,ZR,ZR,ZR,1}$$
- **Bitplane 2:**
Notice $T=2^3$
**Dominant Pass:**
Since $6<8$ but has descendant $|-13|>8$ it is IZ
Next  $-7,3$ are ZR
- Now scan subband 2:
$|-13|\geq8$ set SN
$10\geq 8$ SP
Next two $6,4$ are ZR
Dominant pass sets
$$\text{IZ,ZR,ZR,SN,SP,ZR,ZR}$$
**Refinement Pass**
We have 3 significant coeff $n=3$: $26=11010\rightarrow 0\ 13=1101\rightarrow1\ 10=1010\rightarrow 0$
$$\text{IZ,ZR,ZR,SN,SP,ZR,ZR,}0,1,0$$
- **Bitplane 3**
Notice $T=2^2$
**Dominant pass:**
$6\geq 4$ SP
$-7\leq -4$ SN
$3<4$ ZR
- Level 2 scan
$6\geq 4$ SP
$4\geq 4$ SP
$4\geq 4$ SP
The remaining 3 $-3,2,-2$ are ZR
Dominant pass sets
$$\text{SP,SN,ZR,SP,SP,SP,ZR,ZR,ZR}$$
**Refinement Pass:**
We have 8 significant coeff ($26,13,10,6,7,6,4,4$)
$$\text{SP,SN,ZR,SP,SP,SP,ZR,ZR,ZR},1,0,1,1,1,1,0,0$$
Final bitstream:
$$\text{SP,ZR,ZR,ZR,}1,|\text{IZ,ZR,ZR,SN,SP,ZR,ZR,}0,1,0,|\text{SP,SN,ZR,SP,SP,SP,ZR,ZR,ZR},1,0,1,1,1,1,0,0$$
**Decoding:**
Initial state all coeff unknown
Receive SP at $[1,1]$, we know $1xxxx$ so we choose midway $11000=24$
Then all ZR so see ref pass: get bit 1, choose $11xxx\rightarrow11100=28$

Receive SN at $[1,3]$ we know $-01xxx$ choose $-01100=-12$
The SP at $[1,4]$ we know $01xxx\rightarrow 01100=12$
Then all ZR so see ref pass: get 0,1,0 so we know: 
$$110\rightarrow 11010=26,\ -011xx\rightarrow -01110=-14,\ 010xx\rightarrow 01010=10$$

For SP,SN,ZR at level 1 we have $\pm 001xx\rightarrow \pm 00110=\pm6$ and ZR is 0
For the level 2 SP we have $6$ again
Then only ZR so see ref pass:
$$1101x\rightarrow27,\ -0110x\rightarrow -13,\ 0101x\rightarrow11$$
Now the SP,SN at level 1:
$$0011x\rightarrow 7,1 -0011x\rightarrow -7$$
At level 2:
$$0011x\rightarrow 7,\ 0010x\rightarrow 5,\ 0010x\rightarrow 5$$
so we have
$$27,7,-7,0|-13,11,7,5|5,0,0,0|0,0,0,0$$
![[Pasted image 20260624113756.png|Final result|350]]

#### JPEG 2000
Here are the properties:
- ROI coding
- Quality and resolution scalable
- Tiling
- Exact coding rate
- Lossless to lossy

##### Algorithm
Made of 2 tiers:
1. DWT + quantization and lossless coding of codeblocks
2. EmBedded Block Coding with optimized Truncation (EBCOT) and Scalability + ROI 

DWT is encoded with fine quantization steps
For lossless coding, DWT are ints and are not quantized
No loss in DWT, we have loss in tier 2

##### EBCOT
Each subband split in equally sized blocks (codeblocks) losslessly and independently coded via arithmetic: we get as many bitstreams as blocks

![[Pasted image 20260624114247.png|Example|300]]
These get truncated:
$$\min \sum D_i\qquad \sum R_i\leq R_{tot}$$
Solution:
Optimal truncation when slope of $D_i(R_i)$ are equal

## 5.3) Error Robustness
One single bit error can introduce to many wrong decoding steps
- Correction code: increase rate used only on small sensitive data
- Markers: increased rate insert into bitstream to stop propagation errors

JPEG200 has implicit markers (codeblock independently coded)

$\newcommand{\log}{\text{log}}$ $\newcommand{\logt}{\text{log}_{10}}$ $\newcommand{\logn}[1]{\text{log}_{#1}}$ $\newcommand{\db}{{[\text{dB}]}}$ $\newcommand{\dbm}{{[\text{dBm}]}}$ $\renewcommand{\def}{{\ \stackrel\triangle= \ }}$ $\newcommand{\fourier}{\stackrel{\mathcal F}{\longrightarrow}}$

## 5.4) Recap
Recall the STFT / spectrum analyzer ([[DSP 2]]): time and frequency resolution are inversely proportional. $$\text{Heisenberg-like: }\quad \Delta t\cdot\Delta f\geq \frac1{4\pi}$$ Wavelets make the analysis window **scale with frequency**, so the JPEG-style block adapts:
- **Anomalies** = HF (edges, contours): want fine **time** resolution → short window.
- **Trends** = LF (smooth areas, textures): want fine **frequency** resolution → long window.
Mother wavelet, generated by scaling + translation: $$\psi_{a,b}(t)=\frac1{\sqrt a},\psi\par{\frac{t-b}{a}}$$
> [!thm] Universal Principle Linear transforms in signal processing/compression = projection of the signal onto a chosen basis. For an orthonormal basis $\curly{\phi_k(t)}$: $$x(t)=\sum_k c_k,\phi_k(t),\qquad c_k=\langle x,\phi_k\rangle=\int x(t),\phi_k^*(t),dt$$

#### 5.5) Discrete Wavelet Transform

DWT = recursive **filter bank**: split into HF/LF subbands, each band has half the bandwidth ⇒ decimate ↓2, then ↑2 + synth, recombine into a delayed copy. Recurse on the **LP branch only**.

#### **Filter-bank pipeline:**

$$x[n] \xrightarrow{H_i} \tilde c_i[n] \xrightarrow{\downarrow 2} c_i[k] \xrightarrow{\uparrow 2} \hat c_i[n] \xrightarrow{F_i} v_i[n] \xrightarrow{\sum} \tilde x[n]$$

| Step                     | $n$-domain                                                                   | $z$-domain                                                          |
| ------------------------ | ---------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| Analysis filter $H_i$    | $\tilde c_i[n]=(h_i*x)[n]$                                                   | $\tilde C_i(z)=H_i(z)X(z)$                                          |
| Downsample $\downarrow2$ | $c_i[k]=\tilde c_i[2k]$                                                      | $C_i(z)=\tfrac12\big[\tilde C_i(z^{1/2})+\tilde C_i(-z^{1/2})\big]$ |
| Upsample $\uparrow2$     | $\hat c_i[n]=\begin{cases}c_i[n/2]&n\text{ even}\ 0&n\text{ odd}\end{cases}$ | $\hat C_i(z)=C_i(z^2)$                                              |
| Synthesis filter $F_i$   | $v_i[n]=(f_i*\hat c_i)[n]$                                                   | $V_i(z)=F_i(z)\hat C_i(z)$                                          |
| Output                   | $\tilde x[n]=\sum_i v_i[n]$                                                  | $\tilde X(z)=\sum_i V_i(z)$                                         |

The $X(-z)$ term born at $\downarrow2$ is **aliasing**; it survives $\uparrow2$ and must be cancelled by the synthesis bank.

#### Perfect Reconstruction

> [!def] Perfect Reconstruction $\tilde x[k]$ is a pure delayed copy of $x[k]$: $$\tilde X(z)=z^{-l}X(z)\iff \tilde x[k]=x[k-l]$$

2-channel analysis (collect the $X(z)$ and $X(-z)$ terms): $$\tilde X(z)=\underbrace{\tfrac12\big[F_0H_0(z)+F_1H_1(z)\big]}_{T(z)}X(z);+;\underbrace{\tfrac12\big[F_0H_0(-z)+F_1H_1(-z)\big]}_{A(z)}X(-z)$$

Two conditions:

- **Non-distortion (ND):** $T(z)=z^{-l}\iff F_0H_0(z)+F_1H_1(z)=2z^{-l}$
- **Aliasing cancellation (AC):** $A(z)=0\iff F_0H_0(-z)+F_1H_1(-z)=0$

Matrix form, **modulation matrix**: $$\tilde X(z)=\tfrac12\underbrace{\begin{bmatrix}H_0(z)&H_1(z)H_0(-z)&H_1(-z)\end{bmatrix}}_{\text{modulation matrix}}\begin{bmatrix}F_0(z)F_1(z)\end{bmatrix}X(z)=\tfrac12\begin{bmatrix}2z^{-l}0\end{bmatrix}X(z)=z^{-l}X(z)$$

**Invertibility:** solvable for $(F_0,F_1)$ iff the determinant is non-zero on the unit circle: $$\forall z,\ |z|=1:\quad \Delta(z)=H_0(z)H_1(-z)-H_1(z)H_0(-z)\neq 0$$

Proof (chain-substitute the steps): $$\begin{aligned}\tilde X&=F_0\hat C_0+F_1\hat C_1=F_0C_0(z^2)+F_1C_1(z^2)\&=\tfrac12F_0\big[H_0(z)X(z)+H_0(-z)X(-z)\big]+\tfrac12F_1\big[H_1(z)X(z)+H_1(-z)X(-z)\big]\&=\tfrac12\big[F_0H_0(z)+F_1H_1(z)\big]X(z)+\tfrac12\big[F_0H_0(-z)+F_1H_1(-z)\big]X(-z)\end{aligned}$$ Key move: substitute $C_i(z)$ from the $\downarrow2$ step, then evaluate at $z^2$ (so $z^{1/2}\to z$). Do **not** re-apply the $\downarrow2$ formula to $C_i(z^2)$.

#### QMF vs CQF

The two FIR designs that hit the PR conditions:

|Analysis relation|Synthesis|Property|
|---|---|---|---|
|**QMF**|$H_1(z)=H_0(-z)$ (modulation only)|$F_0=H_0(z),\ F_1=-H_1(z)=-H_0(-z)$|cancels aliasing, **but no PR** for FIR (len $>2$): residual amplitude distortion $T(z)=\tfrac12[H_0^2(z)-H_0^2(-z)]$|
|**CQF**|$H_1(z)=z^{-(N-1)}H_0(-z^{-1})$ (mod + time-reversal)|$F_0(z)=z^{-(N-1)}H_0(z^{-1}),\ F_1(z)=z^{-(N-1)}H_1(z^{-1})$|**orthogonal, energy-conserving, full PR** (Daubechies family)|

That is: CQF = QMF **plus** the conjugate/time-reversal $h_1[n]=(-1)^n h_0[N-1-n]$, which buys the extra DOF for exact PR. **Haar** is the special case that is simultaneously QMF and CQF (the unique symmetric FIR orthogonal filter).

#### **Orthogonality ⇒ energy conservation:**

$$\sum_k x_k^2=\sum_k c_k^2+\sum_k d_k^2 \qquad(\text{Parseval split into LP }c\text{ + HP }d)$$

#### **Vanishing moments (VM):**

A filter with $p$ VM:

- HP filter **annihilates polynomials of degree $<p$** (reproduces up to degree $p-1$).
- Needs $\geq 2p$ taps (orthogonal Daubechies: exactly $2p$).
- More VM ⇒ smoother wavelet ⇒ HP coeffs $\approx 0$ on smooth regions ⇒ sparser representation.

#### Border problems

Theory is for 1D infinite signals; images are 2D (fine — filters are **separable**) and **finite-support**:

|Approach|Idea|Issue|
|---|---|---|
|**Standard**|zero-pad + DTFT|**coefficient expansion**: output has $N+M-1$ coeffs ($N$ input, $M$ filter)|
|**Circular conv**|periodicize (via DFT)|no expansion, but **boundary artifacts** (periodization discontinuity = freq aliasing)|
|**Symmetrization**|mirror-extend, period $2N$|output periodic & symmetric ⇒ compute only first $N$; **no artifacts**, but **doubles taps unless the filter is symmetric**|

⇒ symmetrization wants **symmetric (linear-phase)** filters ⇒ motivates **biorthogonal**.

#### Haar & Biorthogonal (CDF)

#### **Haar** (unique symmetric FIR orthogonal filter):

$$h_0[k]=[1,1]\quad f_0[k]=[1,1]\qquad h_1[k]=[1,-1]\quad f_1[k]=[-1,1]$$

- Usually normalized by $1/\sqrt2$ for unit-gain exact PR (unnormalized $\Rightarrow \tilde X=2z^{-1}X$).
- $p=1$: HP kills only **constants** ⇒ **piecewise-constant** approximation. Poor for smooth content.

#### **Cohen–Daubechies–Fauveau (CDF) biorthogonal:**

- Symmetric (linear phase) ⇒ symmetrization with no tap doubling.
- Maximizes VM.
- Near-orthogonal ($\omega_i\approx1$). Used by JPEG 2000.

#### 2D Wavelet Decomposition

Separable: filter rows, then columns. One level ⇒ **4 subbands**:

|Subband|Filtering|Content|
|---|---|---|
|$c$ (A, LL)|LP rows, LP cols|approximation (low-res image)|
|$d^H$ (H)|HP rows, LP cols|horizontal detail|
|$d^V$ (V)|HP cols, LP rows|vertical detail|
|$d^D$ (D)|HP rows, HP cols|diagonal detail|

Multilevel: recurse on $c$ (the LL band) only. Sparsifies the signal; **optimal 4–6 levels**.

---

#### 5.5) Image Compression with Wavelets

Both paradigms run the DWT first; they differ in **how the coefficients are coded**:

|EZW / SPIHT|JPEG 2000 (EBCOT)|
|---|---|---|
|Exploits|**inter-scale** (zerotrees across scales)|**intra-scale** (codeblocks within a subband)|
|Coding|tree symbols|explicit bit-rate allocation + arithmetic|
|Pros|good inter-scale exploitation, low complexity|resolution + quality scalable, random access, ROI|
|Cons|**no resolution scalability**|**no inter-scale exploitation**|

#### Embedded Zerotrees of Wavelet coefficients (EZW)

Properties: **quality-scalable** (progressive/embedded bitstream), lossless→lossy, low complexity, RD better than JPEG.

**Auto-similarity principle:** if a coeff is insignificant, its descendants likely are too ⇒ encode the whole subtree with **one symbol** (zerotree). Reduce localization overhead with:

- **Subband scan:** order $C,H,V,D$, coarse→fine, so big coeffs go first.
- **Inter-band prediction:** one coeff has 4 children in the next finer band; predict insignificant positions via the tree.

#### **Four symbols:**

- **SP / SN** — significant positive/negative ($|c|\ge T_k$); move to significance list $S$.
- **ZR** (zerotree root) — insignificant **and** all descendants insignificant ⇒ prune the subtree.
- **IZ** (isolated zero) — insignificant **but** $\ge1$ descendant is significant ⇒ cannot prune.

> [!def] IZ vs ZR Both have $|c|<T_k$. The difference is the subtree: all-small ⇒ **ZR** (prune); at least one descendant $\ge T_k$ ⇒ **IZ** (keep scanning children).

#### **Algorithm:**

$$\textbf{Init: } k=0,\quad n=\floor{\log_2|c|_{\max}},\quad T_0=2^n$$ $\mathcal L$ = coeffs in subband-scan order; $S=\varnothing$.

```
while (rate < budget):
    1. Dominant pass        # significance map at T_k
    2. Refinement pass      # 1 extra bit for coeffs already in S
    3. T_{k+1} = T_k / 2
    4. k = k + 1
```

**Dominant pass** — for each $c$ in $\mathcal L$:

1. $|c|\ge T_k,\ c>0$ → **SP**, move to $S$
2. $|c|\ge T_k,\ c<0$ → **SN**, move to $S$
3. $|c|<T_k$, no descendant $\ge T_k$ → **ZTR**, remove descendants from $\mathcal L$
4. $|c|<T_k$, some descendant $\ge T_k$ → **IZ**

(Newly significant coeffs leave $\mathcal L$; ZTR descendants are skipped this pass.)

**Refinement pass** — bit-plane $b=\log_2 T_k$: for every coeff already in $S$ (from _previous_ passes), output its $b$-th bit ⇒ one more bit of precision.

**Embedded** ⇒ decoder can stop anywhere. Reconstruction is **midpoint**: SP/SN at threshold $T$ ⇒ place at $\pm1.5T$, then each refinement bit narrows the interval.

#### JPEG 2000

Properties: **ROI** coding, quality **and** resolution scalable, tiling, **exact target rate**, lossless→lossy.

#### **Two tiers:**

1. **DWT + lossless coefficient coding.** Reversible integer DWT (lossless) or float DWT + fine quantization (lossy); per-codeblock lossless arithmetic coding. **No loss in the DWT itself.**
2. **EBCOT** (Embedded Block Coding with Optimized Truncation) + scalability/ROI. **Loss happens here**, by truncating block bitstreams.

#### **EBCOT:**

Each subband → equal-size **codeblocks**, each **independently** arithmetic-coded ⇒ one embedded bitstream per block. Allocate rate by RD-optimal truncation: $$\min \sum_i D_i \qquad\text{s.t.}\qquad \sum_i R_i\leq R_{\text{tot}}$$ **Optimal truncation:** cut each block where the RD-curve slopes are equal, $$\left|\frac{dD_i}{dR_i}\right|=\text{const}\quad\forall i\qquad(\text{Lagrangian / constant-slope condition})$$ Independent codeblocks ⇒ random access + implicit resync (error containment).

---

#### Error Robustness

A single bit error in a variable-length / embedded stream can corrupt **many** subsequent decoding steps. Mitigations:

- **Error-correcting codes:** extra rate, applied **selectively** to small sensitive data (headers).
- **Resync markers:** extra rate inserted into the bitstream to **stop error propagation**.
- **JPEG 2000:** independently-coded codeblocks act as **implicit markers** — an error is contained to its block.
# 6) Learned Image Coding (TODO)

# 7) Motion Estimation
Videos are different from images as they implement temporal information. This information is mostly found in the movement. The study of **optical flow** consists in defining the movement of a pixel between two subsequent images into a **vector field**. 

Optical flow consists in finding a 2D vector field $V(x,y)$:
$$V:(x,y)\in \mathscr I\subset\R^2\rightarrow (u,v)$$
where:
- $x,y$ are the points on the image
- $u(x,y),v(x,y)$ is the velocity of the point $x,y$

The output is either dense or sparse, depends on implementation.

>[!hypothesis] Constant Illumination
>The Constant Illumination Hypothesis (CIH) states that the luminance does not change along the motion trajectory:
>$$f(x,y,t+T)=f(x-c,y-d,t)\longrightarrow \frac{df}{dt}=0$$
>But in practice due to sampling, aliasing and noise this is not true.

The velocity field (optical flow) can be described as

>[!def] Velocity Field
>We can define the vector field as:
>$$V(x,y)=\lim_{T\rightarrow 0}\frac{D(x,y)}T=\begin{bmatrix}u(x,y)\\ v(x,y)\end{bmatrix}$$
>Which becomes (first degree approx)
>$$uf_x+vf_y+f_t=0$$
>with $u,v$ components of the velocity field, $f_x,f_y$ the space derivatives and $f_t$ the time derivative.
>This formula states that, the intensity change I see in a point depends only on the movement of the pixels.

However the OF equation has 2 unknowns. We need an additional constraint to solve the problem. Also CIH isn't true in practice.

Proof:
Apply Taylor:
$$f(p,t+T)=f(p,t)-c(p)f_x(p,t)-d(p)f_y(p,t)+o(\abs{D(p)})=f(p,t)-D\nabla f+o(\abs{D(p)})$$
And now find the partial time derivative:
$$f_t\stackrel{T\rightarrow 0}=\frac{f(p,t+T)-f(p,t)}{T}=\frac{-D\cdot \nabla f}T+\frac{o(\abs {D(p)})}T=-V\nabla f+\frac{o(\abs {D(p)})}T$$
From here the OF equation becomes:
$$f_t=-V\nabla f\rightarrow V\nabla f+f_t=0\rightarrow uf_x+vf_y+f_t=0$$
$$\endproof$$

## 7.1) Variational Method (Horn Shunk)
Variational methods apply the CIH directly.
The typical formulation is minimization of the coherence $D$ optical flow $(u,v)$ wrt to two images $f_1,f_2$ with a regularization term $R$ (a priori knowledge)
$$\argmin[u,v]D(f_1,f_2,(u,v))+R(u,v)$$
Consider a point of an object moving from pixel $p-D$ to $p$ in time $T$. The trajectory of the pixel becomes:
$$\begin{aligned}
x(t_0)=p-D\\
x(t_0+T)=p
\end{aligned}
\longrightarrow D(p,t_0,T)=x(t_0+T)-x(t_0)=\begin{bmatrix}c(x,y)\\d(x,y)\end{bmatrix}$$
where $c,d$ depend on $p,t_0,T$ but the time parameters are ignored and $p=(x,y)$.

We can identify a general solution:

<div style="text-align: center;">
  Solution: Minimize the energy of OF equation under suitable constraints.
</div>

**Horn and Schunk** introduced a constrain on the total variation of $V$ over a region $\mathscr R$:
$$\begin{cases}
\int\int_\mathscr R(uf_x+vf_y+f_t)^2dxdy=\min\\
\int\int_\mathscr R\abs{\nabla u}^2+\abs{\nabla v}^2dxdy\leq\tau
\end{cases}\rightarrow \begin{cases}
u=\overline u-f_x\frac{\overline u f_x+\overline v f_y+f_t}{\lambda \abs{\nabla f}^2}\\
v=\overline v-f_y\frac{\overline u f_x+\overline v f_y+f_t}{\lambda \abs{\nabla f}^2}
\end{cases}$$
where $\overline z$ is the average of local values

This gives a **dense output** with smooth coherent results.
However, it is sensitive to noise (CIH limitation) and it is not robust with large displacement (regularization term). This is ususallyy used for object tracking.

---
The result is obtained via Lagrange multiplier with minimization on $u$ and $v$;
$$J=\int\int_\mathscr R(uf_x+vf_y+f_t)^2+\lambda (\abs{\nabla u}^2+\abs{\nabla v}^2)dxdy$$
this is done by recalling that
$$\int\int_\mathcal R\Theta(x,y,w,w_x,w_y)dxdy$$
is optimized by imposing
$$\part[\Theta]{w}-\part[^2\Theta]{x\partial w_x}-\part[^2\Theta]{y\partial w_y}=0$$
with $w=u$ and $w=y$ respectively we get
$$\begin{align}
\lambda\nabla_2u=(uf_x+uf_y+f_t)f_x\\
\lambda\nabla_2v=(uf_x+uf_y+f_t)f_v
\end{align}$$
$\nabla_2z$ can be approximated as $\overline z-z$  where $\overline z$ is the average of local values
![[Pasted image 20260624124936.png|Final results|450]]
Horn shunk proposed the iterative algorithm.
$$\endproof$$
## 7.2) Block Matching Method
This method allows to use discrete signals.It uses a support of a rectangular block of pixels. One motion vector is generated per block. The output is a displacement field, **motion vector field**
- Affine methods: 6 parameters per block, also represents zoom and not only translation

This technique is very popular as it gives good results at a low computational cost.

Consider a $P\times Q$ block of pixels inside a $N\times M$ image. The block starts at indexes $p,q$:
$$B_{p,q}=\curly{p,p+1,...,p+P-1}\times\curly{q,q+1,...,q+Q-1}$$
And the luminance vector at time $k$:
$$f_k(B_{p,q})=[f(p,q,k),...,f(p+P-1,q+Q-1)]^T$$
The block matching method consists in computing the **dissimilarity between blocks and selecting those with minimum dissimilarity**. That is
$$(\hat i,\hat j)=\arg\min_{i,j}d[f_k(B_{p,q}),f_h(B_{p-i,j-q})]$$
In general we have a **forward motion**, that is $h=k-1$ with $h$ the current frame and $k$ the reference frame. Therefore the OF field at frame $h$ will show the direction in which the blocks will be at frame $k$.
$$\forall(n, m) \in B_{p,q}, (u_{h\rightarrow k}, v_{h\rightarrow k}) = \arg \min_{(i,j) \in \mathcal{W}} d [f_k(B_{p,q}), f_h(B_{p-i, q-j})]=\argmin[(i,j)\in\mathcal W]\ J(i,j)$$
where $d$ or $J$ is the minimization criterion and $\mathcal W$ is the set of candidate pixels.

#### Measures
One valid **quality** measure is the **energy of the prediction error** (to PSNR), that is the MSE of the predicted block and the real block. That is:
$$e(n,m)=f_k(n,m)-\tilde f_k(n,m)\rightarrow \mathscr E=\frac1{NM}\sum_{n,m}e^2(n,m)\rightarrow PSNR=10\logt\frac{255^2}{\mathscr E}$$
where $\tilde f_k(n,m)=f_h(n+u_{h\rightarrow k},m+v_{h\rightarrow k})$ is the predicted image from the motion vector field

A **cost** measure is the **coding cost**, that is, the number of bits to losslessly encode the motion vector field, since it depends on the implementation, the general empirical entropy is used.

Finally the **performance** measure is the **computational complexity**. The following choices impact the performance:
- Block size: determines the number of blocks: 
- Number of candidate vectors ($i,j\in\mathcal W$)
- Cost function $d$
##### Cost Function
The **cost function** of $d()$ is based on $\mathcal L_1$ norm (SAD) or $\mathcal L_2$ norm (SSD). With SSD the one with smallest MSE but more computing cost

But a regularization term is also added, so the minimization is on $J$:
$$J(\text v)=d(\text v)+\lambda_{ME}r(\text v)$$
where $\lambda_{ME}$ affects the importance of the regularization term.
Possible regularization terms are:
- Cost function: choose not best MSE, but best coding option.
- Distance: prioritize vectors with length same as mean of adjacent blocks


| Cost Function      | Pro                                                         | Con                                       |
| ------------------ | ----------------------------------------------------------- | ----------------------------------------- |
| SSD                | Optimizes PSNR by minimizing energy in error                | Larger rate (outliers), harder to compute |
| SAD                | Better rate (implicit regularization), stronger to outliers | Worse PSNR                                |
| SAD+regularization | Best option $J_{reg}=\mathcal L_p+\lambda R$                |                                           |
##### Candidates
The **number of candidates** can also be reduced by using some research strategies:
- Naive: test every vector $i,j$
- Less naive: test every vector in a $2A+1\times 2B+1$ window center in $i,j$ 
- Three Steps Search (3SS): Assumption that error function is unimodal (single global minimum and no local minimum) Test 4-8 points and choose minimum error, now divide window and search 4-8 with window centered in previous minimum repeat
![[Pasted image 20260425165247.png|Example|350]]
- Diamond Search: search in 9 point diamond pattern, then extend pattern in direction of minima
- Hexagon Search: same as diamond but with hexagon (more modern)
- TZSearch: new technique that adaptively changes. Start with big block, if error is too big split it, repeat.

It is also possible to test sub-pixel positions by interpolation:
$$f(n+a,m+b)=(1-a)(1-b)x+a(1-b)y+(1-a)bz+abw$$
![[Pasted image 20260425165822.png|Example|150]]



| Fixed Search              | Unbound Search                |
| ------------------------- | ----------------------------- |
| Fixed number of steps     | Iterative, faster             |
| Guarantees global minimum | Can get stuck in local minima |

---
##### Block Size
A **large block size** reduces complexity (less blocks), less coding cost, increased MSE. The ideal block size is $16\times16$.



| Small Blocks     | Big Blocks        | Variable Size              |
| ---------------- | ----------------- | -------------------------- |
| Better Precision | Worse Precision   | Better precision           |
| Worse complexity | Better complexity | More complex (if required) |
| More coding cost | Less coding cost  | More costly (if required)  |


---
## 7.3) Parametric Methods
A parametric model shows the motion field as a closed form function of the pixel position. The dof are the parameters of the function. It can be global or region based (local).
Block Matching is a special case of parametric methods with 2 parameters per bock (u,v translations), that is the **translational**:
$$v(p)=\begin{bmatrix}v_x\\ v_y\end{bmatrix}=\begin{bmatrix}b_1\\ b_2\end{bmatrix}$$
The affine model is
$$v(p)=b+Bp=\begin{bmatrix}b_1\\ b_2\end{bmatrix}+\begin{bmatrix}b_3 & b_4\\ b_5 & b_6\end{bmatrix}p$$
This has only 6 dof but can represent many complex fields: rotation, zoom, translation

How are the parameters of the model estimated?

**Indirect Estimation**
First dense field, then find global motion by least squares. 
$$\pi^*=\argmin[\pi]\sum_{n,m\in\mathcal R}[u(n,m)-u_\pi(n,m)]^2+[v(n,m)-v_\pi(n,m)]^2$$
where $\pi=[b_1\ ... \ b_6]$ is the parameter set and $\cdot_\pi$ the dense field and $\cdot$ the field

**Direct Estimation**
Use the parameters directly in the estimation:
$$\pi^*=\argmin[\pi]\sum[u_\pi f_x+v_\pi f_u+f_t]^2$$

Or minimize the SAD or SSD 
$$\pi^*=\argmin[\pi]\sum[e]^2\qquad e(n,m)=f(n-u_\pi(n,m),m-v_\pi(n,m),t-1)-f(n,m,t)$$
SAD is a specific parametric affine estimation with $B=0$

## 7.4) Deep Learning Methods (TODO)
**Paradigm shift:** classical (variational / block-based) use hand-crafted models; DL treats ME as a **supervised or unsupervised** learning problem, usually via **CNNs**. Needs specialized architectures for pixel-level correspondence, large datasets, and GPUs.

**Ground-truth challenge:** dense OF labels are hard to get for real video ⇒

- **synthetic datasets** (FlyingChairs, Sintel) for perfect labels,
- **data augmentation** (geometric + photometric),
- **unsupervised** training: minimize the **photometric error** between current frame and warped reference.

|Architecture|Year|Key idea|Note|
|---|---|---|---|
|**FlowNet**|2015|first end-to-end CNN for OF (FlowNetS simple, FlowNetC correlation layer)|weak on small displacements / repetitive texture; ~10–100 FPS|
|**FlowNet 2.0**|—|stacked FlowNets + warping|big accuracy gain, higher complexity|
|**PWC-Net**|2018|**P**yramid + **W**arping + **C**ost-volume|efficient, hardware-friendly|
|**RAFT**|2020|**recurrent GRU** updates on a high-res flow field; all-pairs **correlation pyramid**|SOTA; strong zero-shot generalization; iterations tunable (speed vs. quality)|

DL **dominates analysis** (optical flow); integration into **real-time video coding** still trades accuracy against practical constraints. Strengths: robustness to occlusions and large displacements, high precision. Open issue: **generalization** drops on data far from the training distribution.
## 7.5) Wrap-up

- ME extracts motion from video; it targets **optical flow**, not physical motion (other sensors handle the latter).
- **Variational / H&S:** dense, smooth, physical; noise-sensitive, weak on large displacements.
- **Block matching:** conceptually simple, the workhorse of **video compression**; criterion (SSD/SAD/reg.) × search strategy (FS/3SS/diamond/hexagon/TZ) × block size.
- **Parametric:** compact (translational 2 / affine 6 params); BM = translational special case ($B=0$).
- **Deep learning:** emerging, very effective for analysis tasks (FlowNet → RAFT).

# 8) Video Coding Principles
Video compression uses the spatial redundancy (seen in jpeg) but also time redundancy via motion fields

![[Pasted image 20260515171702.png|General Scheme|350]]
The temporal compression works by dividing the image in blocks $B_k\iter p$ and finding the most similar block $B_h\iter{p+v}$ in the ref image. The resulting displacements form the motion field.

The resulting vector fields are similar to the geometry of the scene, so the signal is NOT sparse. Therefore Exp-Golomb should **not** be used (not centered in 0).

We can still use predictors:
To reduce the bitrate we exploit the correlation between adjacent vectors. We define a Motion Vector Predictor (MVP) and encode only the Difference (MVD)
$$MVD=MV-MVP$$
One useful predictor is the median amongst 3 adjacent blocks:
![[Pasted image 20260515172404.png|Median Blocks|250]]
This reduces substantially the number of bits needed.

By also doing prediction (median) before entropy encoding we can further increase the compression. 

#### Motion Compensation
We can predict the entire new image by copying the blocks in the new position:
$$\hat I_k(p)=I_h(p+v^*(p))$$

![[Pasted image 20260515172715.png|Example|400]]
But not all blocks should be replaced so they are signaled as intra (use og block) or inter frame blocks (use predictor). 

For each $B_k\iter p$ do:
- Perform Motion Estimation (ME) with ref image $h$:
$$J(v)=d(B_k\iter p,B_h\iter{p+v})+\lambda_{ME}r(v)\rightarrow v^*=\arg\min_v J(v)$$
- **Mode select**: decide if inter or intra (see [[#7.3) Mode Selection]])
	- If intra use jpeg
	- If inter encode $v^*$ and $E(p)=B_k\iter p-B_h\iter{p+v}$

A variable block size is more effective although it is more complex to implement.

Recap of the design parameters:
- **Block Size/Shape:** Small block: high PSNR, higher rate and time. Variable most effective
- **Cost function $d$:** SSD optimizes PSNR but higher rate (outliers), SAD better rate (implicit regularizaton)., SAD+regularization best option
- **Search:** full best vector but very high complexity, fast close to optimal but much less complex
- **Motion:** translational 2 parameters, affine 6 parametes, more complex some times better RD

## 8.2) Group of Pictures (GOP)
Each frame can be one of the following three:
- I Frame: Intra coded, no prediction
- P Frame: Predictive coded, Inter frame
- B Frame: Bi directional prediction

The frames are organized into a periodical structure called Group of Pictures (GOP). This structure shows **how frames can be predicted from other frames**. In older standards I,P frames are called Anchor Frames (AF).

![[Pasted image 20260624152737.png|Example|350]]

#### MPEG-1, MPEG-2
- First frame of GOP is **always** I frame
- Between two AF there are some B frames (possibly also zero)
GOP structure defined by I frames (GOP period) and number of B frames

I Frames are JPEG like coded:
- Low complexity and rate
- Can be decoded independently from other frames
- I frames are used for fast forward
- Stop error propagation
- Must have high quality as GOP depends on this frame

P Frames are predicted from previous AF. They have therefore a higher complexity but a higher compression rate per same block

B Frames have very high complexity (double ME) but also very high compression ratio.

## 8.3) Mode Selection
The mode selection problem is to decide how to encode each block or frame. Until H.264 the blocks were called macroblocks (MB), now they are coding units (CU).

4 Types of coding modes for each CU (mode selection problem)
- **Intra:** No temporal prediction, available for all frames
- **Inter:** ME/MC prediction. Not on I frames
- **Direct:** Motion vector from last frame, no additional coding. Not on I frames
- **Lossless:** available for all frames

Moreover since CUs can be of varying sizes we also have a **block partition problem.**

The solution is very much a brute force one:
Suppose fixed block size. The aim is to find the coding mode $i_k$ that minimizes $D$ while having rate $R$. Quantization step is given
$$D=\sum_{k=1}^KD_k(i_k,Q)\qquad R=\sum_{k=1}^KR_k(i_k,Q)$$
Therefore we must minimize
$$J(i,Q,\lambda)=\sum_{k=1}^KD_k(i_k,Q)+\lambda\sum_{k=1}^KR_k(i_k,Q)=D+\lambda R$$
Too complex, therefore we just minimize each block independently
$$J_k(i_k,Q,\lambda)=D_k(i_k,Q)+\lambda R_k(i_k,Q)$$
The parameter $\lambda$ is determined empirically for each coded and also $\lambda_{ME}=\sqrt\lambda$
The $J_k$ equation can be seen as a line in the R-D plane and the solution is the first point that is touched by the line. 
- High $\lambda$: Lower bit budget, will choose points with less rate and more distortion (direct)
- Low $\lambda$: Higher bit budget, will choose points with less distortion and more rate (lossless)
![[Pasted image 20260516121055.png|Example|300]]
For a quantization step $Q$ an optimal $\lambda$ exists, it is measured empirircally:
- MPEG-2: $\lambda = aQ^2+b$
- H.264: $\lambda = c2^{dQ+e}$

Also the **lock partition problem**, that is selecting the best variable block size.
We start with largest block, we divide into sub blocks if $J_{split}=\sum J_{subblock,i}<J_B$. When we achieve a better performance we block the search so to reduce complexity (suboptimal but reasonable results)
## 8.4) Hybrid Video Codec
The video coder implements mode selection only in encoder:
- **Null predictor:** compress entire frame (DCT+Q)
- **Temporal Prediction:** via MC/ME
- **Space or Intra:** predict entirely from encoded blocks in the same frame

This is the full video encoder:
![[Pasted image 20260516141302.png|Video Encoder|450]]
The block $B_k$ is encoded as follows:
- 🔵 The residual error $e_k=B_k-\hat B_k$ is found and encoded in a jpeg like format. Also the mode is encoded.
- 💚 Local decoder: find $\tilde B_k=\tilde e_k + \hat B_k$. This is how the block will be decoded and it is saved in frame buffer (if inter).
- 🧡 Predictors: ME/MC predictors (based on $B_k$+buffer) or Intra predictors. This predicts
- ⚪ Control: Final generated bits are saved in channel buffer. If the rate is too high, the control block expands the quantization step. The buffer is written at speed $R_C$ and read at speed $R_T$.
	- If $R_C>R_T$: the buffer grows, if it surpasses a threshold the controller increases the quantization step $\longrightarrow R_C\nearrow$ 
	- If $R_C<R_T$: the buffer empties, if it decreases below a threshold the controller reduces the quantization step $\longrightarrow R_C\searrow$ 

The decoder is a subset of the encoder!
![[Pasted image 20260516145213.png|Decoder Is Subset After Lossless Decoding|350]]
The decoder is a simplified version without ME, mode decision, partition, control.
Each block is decoded based on the mode, however the modes are not standardized, just their syntax. The encoder could take a suboptimal approach, the decoder doesn't care.

# 9) Modern Video Compression Standards
The decoder is the only part defined in the standard:
Standards exclusively define the bitstream syntax and the decoding process. Encoder architecture and optimization strategies remain open problems for industrial competition.

The improvements come from how many ways the encoder can encode the images. This is mainly related to how the image can be partitioned in blocks.

**H.264/AVC** has $16\times16$ MB or $8\times8$ and $4\times4$ MB which are inefficient for 1080p or 4K videos.

**H.265/HEVC** has a Coding Tree Unit (CTU) where a MB of $64\times 64$ can be divided into other squares until $4\times 4$

HEVC uses Coding Tree Unit (CTU) with quad tree split. Each CTU gets recursively split into CUs (divide by 4) and each CU can be divided into Predictions Units (PU) or Transform Units (TU). These (PU,TU) are independently created from eachother since a block that works great fro PU might not work for TU

![[Pasted image 20260624165257.png|Example|250]]
![[Pasted image 20260624165317.png|Example|250]]

H.266/VVC has blocks of up to $128\times128$. New splits are defined (binary 1:1 or ternary 1:2:1  splits)

![[Pasted image 20260624165339.png|Example|300]]

AV1 can create up to 10 different splits. 

![[Pasted image 20260624165355.png|Example|350]]


| H264 | H265 | H266 |
| ---- | ---- | ---- |
|      |      |      |



Trying every combination is computationally unfeasable:
**Depth First Search (DFS)** is used to explore efficiently block geometry:
- Top Down Exploration: try as a whole, then split
- Causal Dependency: Z scan order for subblocks, blocks cannot be predicted until top and left are reconstructed
- Inner Loop (prediction): for each block test inter/intra modes to find local minimum
- Bottom up: compare costs $\sum J_{children}<J_{parent}$

fats algorithms and ML based ones can prune the tree faster
- Texture analysys: if a texture has low variance (smooth surface) then small blocks are bypassed
- Temporal correlation: search space by exploiting the partition depth of the co-located CU in the reference frame.
- ML Classifiers: lightweight predict splits from pixel features

