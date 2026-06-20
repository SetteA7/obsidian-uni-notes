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

We start with **block coding**, because it defines _what we want from a transform and why_. But it must be clear from the start that block coding alone is useless on raw natural images, for two distinct reasons:
- **No variable rate:** all pixels have (approximately) equal variance, so we revert to UQ
- **Too many quantizers:** even with unequal variances, one fixed quantizer can serve every block only if each position's variance is stationary across blocks (a constant per-sample meaning, as the transform provides, is one way to guarantee this).

The transform is precisely what supplies both: variance disparity (gain) and cross-block stationarity (one shared quantizer).

## 4.1) Block Coding
Block coding aims to solve the **resource allocation problem**, that is, find the rate vector $R=[R_1,...,R_M]$ that minimizes global distortion on block $X=[X_1,...,X_M]$. That is a different quantizer per sample

Recall that an optimal HR quantizer has a distortion for a sample of $D_k=c_k\sigma_k^22^{-2R_k}$. The global distortion is
$$\begin{align}
\mathcal D&=\frac1M\E[\abs{X_Q(X)}^2]=\frac1M\E[(X-Q(X))^T(X-Q(X))]=\frac1M\E[\sum_k(X_k-QX_k)^2]\\
&=\frac1M\sum_k\E[(X_k-Q(X_k))^2]=\frac1M\su
\end{align}$$