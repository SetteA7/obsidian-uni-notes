# 1) Intro And Recap
This is the [book](https://vabbebeddiamo.ddns.net/admin/media/files/Drive/Principles%20of%20Communications%20Networks%20and%20Systems%20by%20Nevio%20Benvenuto%2C%20Michele%20Zorzi.pdf)
>[!todo]

Here is some useful knowledge:
$$\begin{align}
1[byte]=8[bit] \\
\end{align}$$
Moreover:
$$\begin{align}
&\int_0^TA\cos(2\pi f_0t)dt=A\frac{\sin(2\pi f_0T)}{2\pi f_0}=A\cdot\text{sinc}(2 f_0T) \\
&\int_0^TA^2\cos^2(2\pi f_0t)dt=\frac12A^2\int_0^T1+\cos(4\pi f_0t)dt=\frac12A^2[1+\text{sinc}(4 f_0T)]
\end{align}$$
## 1.1) Notable Constants
Here is a list of useful numbers
$$\begin{align}
&\text{Boltzmann Constant: } k=1,3805\cdot10^{-23}[J/K]
\end{align}$$

## 1.2) Sums
Here is a list of useful known sums
$$\begin{align}
&\sum_{i=0}^Ni=\frac{n(n+1)}{2} \\
&\sum_{i=0}^Ni^2=\frac{N(N+1)(2N+1)}{6} \\
&\sum_{i=0}^Ni^3=\left(\sum_0^ni\right)^2=\left(\frac{n(n+1)}{2}\right)^2 \\
&\sum_{n=0}^\infty p^n=\frac{1}{1-p} \\
&\sum_{n=0}^\infty n\cdot p^n=\frac{p}{(1-p)^2}
\end{align}$$

## 1.3) Powers
We already know some powers $[-\infty,\infty]$ of many functions:

$$P[\cos^k(t)]=\lim_{x\rightarrow\infty}\frac{1}{2x}\int_{-x}^x\cos^{2k}(t)dt=\frac{(2k)!}{2^{2k}(k!)^2}$$
Moreover the following holds:
$$\lim_{x\rightarrow\infty}\frac{1}{2x}\int_{-x}^x\cos^k(t)dt=
\begin{cases}
0, \ \text{if }k\text{ odd} \\
P[\cos^{\frac k2}(t)], \ \text{if }k\text{ even}
\end{cases}$$

$$\lim_{x\rightarrow\infty}\frac{1}{2x}\int_{-x}^x\cos^a(\alpha t)\cos^b(\beta t)dt=0, \ \text{if one between }a,b\text{ is odd} $$


$$\begin{align}
&k &&\rightarrow k \\
&\cos(\alpha t) &&\rightarrow 0 \\
&A\cos^2(\alpha t) &&\rightarrow \frac{A^2}{2} \\
&A[\cos(\alpha t)\cos(\beta t)] &&\rightarrow 0, \ &\forall \alpha\not=\beta \\
&A[\cos^2(\alpha t)\cos^2(\beta t)] &&\rightarrow \frac{A^2}4, \ &\forall \alpha\not=\beta \\
&A[\cos^m(\alpha t)\cos^n(\beta t)] &&\rightarrow 0, \ &\forall \alpha\not=\beta &\text{ and at least one odd between } m,n
\end{align}$$
In a period $[0,T]$ we have:
$$\begin{align}
\cos(\alpha t)&\rightarrow 0 &&\text{ if } \alpha >>1/T \\
A\cos^2(\alpha t)&\rightarrow \frac12A^2T &&\text{ if } \alpha >>1/T
\end{align}$$
## 1.4) Vector Spaces
In particular we will need the implications in a vector space of $L^2(\mathbb R)$ signals
>[!thm] Scalar product in $L^2(\mathbb R)$
>The scalar product is defined as:
>$$<x(t),y(t)>=\int_{-\infty}^\infty x(t)\overline y(t)dt$$
>Then, the **energy of $x(t)$** as $\mathcal E_x = <x(t),x(t)>=\int x(t)\overline x(t)dt=\int |x(t)|^2dt$
>And the **norm**: $||x(t)||=\sqrt{\mathcal E_x}$ 

^6b1599

>[!thm] Gram-Schmidt Orthonormalisation
>Given a span of signals we can find an orthonormal basis $\{\varphi_i\}$ by following these steps:
>1) Normalise first signal: $\varphi_1=s_1/\sqrt{\mathcal E_1}$
>2) To find the second base we must first find $\varphi_2'=s_2(t)-c_{2,1}\varphi_1(t)$ that is $s_2$ without the dependent part on $s_1$. With $c_{2,1}=<s_2,\varphi_1>$
>3) Find the energy of $\varphi'_2$. Then $\varphi_2=\varphi_2'/\sqrt{\mathcal E_2}$
>4) Continue with: $\varphi_n'=s_n-\sum{i=1}^{n-1}c_{n,i}\varphi_i$.   With $c_{n,i}=<s'_n,\varphi_i>$
>	Then $\varphi_n=\varphi_n'/\sqrt{\mathcal E_n}$

^67d73a
>[!rmk|*]
>For every signal $s_i$ the components of the base can be found by calculating $<s_i,\varphi_j>\ \forall j$.
>Moreover if $s_i$ was used to find a basis the coefficients are already known $[c_{i,1},c_{i,2},...,c_{i,i-1},\sqrt{\mathcal{E}_i}]$
## 1.5) Probability
Here are some useful operations with $Q$ function and a a normal gaussian rv $a\sim \mathcal N(0,1)$:
$$\begin{align}
&P(a>x)=Q(x) \\
&P(a<x)=1-Q(x)=Q(-x) \\
&P(|a|>x)= 2Q(x) \\
&P(|a|<x)= 1-2Q(x)\\
\end{align}$$
Suppose I have $a\sim\mathcal N(\mu,\sigma^2)$ then I can rewrite a probability with $Q(\frac{x-\mu}{\sigma})$.

>[!theorem|*] Fundamental Theorem for Expectation
>Given the description of a r.v. $x$, we can calculate the expectation of any r.v. $y=g(x)$ as:
>$$E[g(x)]=
>\begin{cases}
>\displaystyle\sum_{e\in \mathcal A_x} g(a)p_x(a), && \text{ discrete case} \\
>\displaystyle\int_{-\infty}^{\infty}g(a)p_x(a)\ da, && \text{ continuous case}
>\end{cases}$$

^ec4160

>[!theorem|*] Jensen's Inequality
>Let $z$ be a not absolutely surely constant r.v. taking values in an interval $\mathcal I$, then, if $z$ is **strictly concave** in $\mathcal I$
>$$E[h(z)]<h(E[z])$$
>and > if $z$ is **strictly convex**
## 1.6) Distributions
$$ $$
>[!def] Erlang
>Let $\{x_i\}$ be $n$ iid exponential rvs with parameter $\beta$, then $y=\sum_1^n x_i$ has the following distribution:
>$$p_y(a)=
\begin{cases}
\displaystyle\frac{\beta^na^{n-a}}{(n-1)!}e^{-\beta a}, \ &a\geq0 \\
0, \ &a<0
\end{cases}$$
>With mean $m_y=n/\beta$

## 1.7) Random Process
This chapter adds new knowledge to the previous chapter. This will be done mostly trough definitions and small theorems.


>[!def|*] Random Process
>A random process is a function $x(t,\omega)$ of two variables
>$$x:\mathbb{A}\times\Omega\rightarrow\mathbb{R}$$
>Where $\Omega$ is the sample space of a probability space, while $\mathbb{A}$ is either $\mathbb{Z},\ \mathbb{R},\ \mathbb{C}$ and it determines if it is discrete/continuous and complex/real.
>
>The first-order statistical description is given by the Probability Distribution Function (PDF)
>$$p_x(a;t)=p_{x(t)}(a),\ t,a\in \mathbb{R}$$
>
>From here we describe the mean and the power
>$$\begin{align}
>&&m_x:\ &&\mathbb{R}\rightarrow\mathbb{C},\ &&m_x(t)=E[x(t)] \\
>&&M_x:\ &&\mathbb{R}\rightarrow\mathbb{R},\ &&M_x(t)=E[x(t)^2]
>\end{align}$$
>
>the autocorrelation is described given the time $t$ and a delay (lag) $\tau$
>$$r_x(t,\tau)=E[x(t)\overline{x(t-\tau)}]$$

>[!col]
>>[!def|*] Point Process
A special type of continuous rp are point processes that are a sequence of dirac impulses
$$x'(t)=\sum\delta(t-t_n)$$
and is used to describe a distribution of finite events in time
>$$ $$
>>From here we define:
>>- **arrival times** $t_n$ and they are **ordered** if $t_n\leq t_{n=1}$
>>- **interarrival times** are defined as: $\tau_n=t_n-t_{n-1}$
>
>>[!def|*] Counting Process
>>The integral of a point process is the counting process
>>$$x(t)=\int_{u_0^+}^{t^+} x'(u)du$$
>>And is strictly nondecreasing
>$$ $$
>![[Pasted image 20241007142250.png|Pointing Process(top) and Counting Process(down)|250]]

>[!def|*] Arrival Rate
>By derivating the mean of a counting process we get the **arrival rate**
>$$\lambda(t)=\frac{d}{dt}m_x(t)=\lim_{\Delta t\rightarrow 0}\frac{E[N_x(t,t+\Delta t]}{\Delta t}$$
>>[!theorem|*]
>>This is also the mean of a point process
>>`\begin{proof}`
>>$$E[x'(t)]=\frac{d}{dt}E[x(t)]=\frac{d}{dt}m_x(t)=\lambda(t)$$
>>`\end{proof}`
>
>If $\lambda(t)=\lambda$ then the point and counting process are **homogeneous**

### 1.7.1) Poisson Point Process
$$ $$
>[!def] Poisson Point Process
>An important case of rp's is the **poisson process**. A rp is poisson if it holds the following conditions:
>- The number of arrivals in n disjointed intervals are independent rv's
>- The number of intervals in $(u_1,\ u_2]$ has a Poisson distribution
>$$P[N_x(u_1, u_2)=k]=e^{-\Lambda}\frac{\Lambda^k}{k!}\text{ with } \Lambda = \int_{u_1}^{u_2}\lambda(u)du$$
>

>[!theorem] Superposition Property
>If $x(t), y(t)$ are independent poisson processes with $\lambda_x(t),\lambda_y(t)$ their sum is a poisson process with arrival rate $\lambda(t)=\lambda_x(t)+\lambda_y(t)$

^04fe28

>[!theorem] Interarrival Times
>The **interarrival times** of an *homogeneous* poisson process $x(t)$ **are iid rvs** with exponential distribution function
>$$p_\tau(a)=\lambda e^{-\lambda a}u(t)$$
>Thus they are also **memoryless** and have $E[\tau_n]=1/\lambda$

^4cf2cb

### 1.7.2) Stationary and Ergodic
$$ $$
>[!def] Stationary
>A rp is stationary with respect to a statistical description if that description is time invariant
>
>If a rp is static in mean and autocorrelation it is called **Wide Sense Stationary (WSS)** 

>[!def] Mean Ergodic
>A mean stationary rp is ergodic in it's mean if the time average converges to it's mean
>>[!todo]
## 1.8) Signal And Systems
$$ $$
>[!def|*] Sampling Rate and Nominal Bitrate
>A signal can be sampled with period $T_s$, which we call **sampling rate**.
>By selecting a number of bits $b$ that encodes the data we can define the **nominal bitrate** as $\frac{b}{T_s}=bF_s$, with $F_s=\frac{1}{T_s}$ called **symbol rate**

>[!theorem|*] Uncertainty Principle
>A continuous time signal can not have limited support and a limited band


>[!theorem|*] Sampling Theorem
>Suppose a system with a real valued continuous signal $x(t)$ als input, then if:
>- $x(t)$ has limited bandwidth $\mathbb{B}_x\subset[0,B]$
>- the sampling rate is $F_s \geq 2B$
>- the interpolate filter has frequency response
>$$G(f) =
>\begin{cases}
>T_s &|f|<B \\
>\text{arbitrary} &B\leq|f|\leq F_s-B \\
>0 & |f|>F_s-B
>\end{cases}$$
>the signal is perfectly reconstructed at the output
>![[Pasted image 20241004145115.png|Sampler-interpolator system|300]]

^74f625

# 2) Information Theory

Information theory was introduced and formalized by Shannon. It aims to give a measure that indicates how much an event in a given probability space is informative through a quantity $i(A), \ A\in\mathcal{F}$. This means to define a function $i:\mathcal{F}\rightarrow\mathbb{R}, \ i(a)=g(P[A])$ with a map $g:[0,1]\rightarrow\mathbb R$

This table represents the axioms defined by Shannon and their influence to define $g$

| AXIOM                                                              | CONSEQUENCE                                     |
| ------------------------------------------------------------------ | ----------------------------------------------- |
| $i(A)\geq0,\ \forall A$                                            | $g(\alpha)\geq 0, \ \forall\alpha\in[0,1]$      |
| $i(\Omega)=0$                                                      | $g(1)=0$                                        |
| $P[A]\leq P[B] \iff i(A)\geq i(B)$                                 | $g$ is monotonically non increasing             |
| $A\perp B \implies P[A\cup B]=P[A]+P[B]\iff i(A\cap B )=i(A)+i(B)$ | A log is capable of transforming sum in product |
By choosing the base as 2 so that a bit $[0,1]$ can be represented
$$i(A)=\log_2(\frac{1}{P[A]})$$
Given a discrete r.v. with alphabet $\mathcal{A}_x=\{a_1,...,a_M\}$ it is possible to describe a **information function** 
$$i_x:\mathcal{A}_x\rightarrow\mathbb{R}, \ i_x(a)=i(x=a)=\log_2\frac{1}{p_x(a)}$$

>[!def] Entropy
>The Entropy is defined as 
>$$H(x)=E[i_x(x)]$$
>It represents how much an information function is unpredictable
>By [[#^ec4160]] we have:
>$$H(x)=\sum p_x(a)i_x(a)=\sum p_x(a)log_2(\frac{1}{p_x(a)})$$

Here are some properties of the entropy:

>[!thm] Discrete Entropy Properties
>-  $H(x)\geq0$ where the equality holds if x is a constant rv
>- $H(x)\leq\log_2M$ where the equality holds if the symbols are equiprobable

>[!thm] Joint Entropy Properties
>- $H(x,y)\geq H(x)$ where the equality holds if y completely determines x
>- $H(x,y)\leq H(x)+H(y)$ where the equality holds if x $\perp$ y

>[!thm] Conditional Entropy Properties
>- $i_{x|y}(a|b)=i_{xy}(a,b)-i_y(b)$
>- $H(x|y)=H(x,y)-H(y)$

We can therefore know that: $0\leq H(x)\leq \log_2M$ and $H(x)\leq H(x,y)\leq H(x)+H(y)$ and finally $0\leq H(x|y)\leq H(x)$

By defining the **per symbol avg entropy** $H_s(v)=H(v)/N$ we have $\frac{H(v_j)}{N}\leq H_s(v)\stackrel{\perp}\leq H(v_j)\stackrel{\text{equip.}}\leq\log_2M$.

>[!def] Information Rate
>The **information rate** is defined as $$R_o=H_s(x)F_s$$

>[!def] Source Efficiency
>Let $x$ be a rv with finite alphabet of size $M$, we call $\log_2 M$ the **nominal information**, then we can define the efficiency as:
>$$\eta_x=\frac{H(x)}{\log_2M}\leq1$$
>Notice that if we talk about bits $M=2\implies\log_2M=1$

**Recall that this formula is valid only to analyse the source efficiency, not the coding efficiency**
## 2.1) Source Coding
We will only study **lossless** coding (invertible). This will be done through a set of codewords of **variable length**, which is given by a study on entropy. Since $M_y$ will end up smaller on average the coding will be more efficient. In order to do so we will deploy **prefix coding** so that no codeword is the same as the start of another word.

>[!thm] Kraft-McMillman Theorem
>Set $l(b)$ as the length of the codeword $b$, then if the following inequality holds:
>$$\sum_{b\in \mathcal C}\frac1{M^{l(b)}}\leq 1\leftrightarrow\sum_1^N\frac1{M^l_j}\leq1$$
>The code made of these $n$ symbols is decodable

^30daa2

Recall that it can also be rewritten in the following way:
$$E[\frac1{M^{l(b)}}\frac1{p_y(b)}]$$
Once you find the length of each symbol, the average length is: 
$$\boxed{\tilde L_y=\sum p(x)l_x}$$
#### Shannon Code
We start with the theorem:
>[!thm] Shannon Theorem on Source Coding
>If [[#^30daa2]] holds then:
>- The medium codeword length is $L_y\geq\frac{H(x)}{\log_2M}$
>- It is possible to find a prefix code such that: $L_y<\frac{H(x)}{\log_2M}+1$

The Shannon code itself only satisfies the first part and therefore it isn't the most efficient. How do we find it?
Build the following table

| Symbol = x | length = $\lceil i(p_x)\rceil$ | Cumulative = $Q_i$ |  Decimal Codeword | Codeword |
| ---------- | ------------------------------ | ------------------ | ----------------- | -------- |
|            |                                |                    |                   |          |
The symbols column should be ordered in **decreasing** order.

The tricky part is finding $Q_i$. Set $Q_0=0$, then we can have
$$Q_i=\sum_{k=0}^{i-1}2^{-l_k}=2^{-l_{i-1}}+Q_{i-1}$$
To find the decimal codeword you take $Q_i$ and multiply numerator and denominator such that the denominator is equal to $2^{l_i}$. Then the numerator is the decimal value of the codeword.

>[!example|*]
>Suppose to have:
>$$\begin{flalign}
&p_x(0)=\frac{1}{3},\ i(0)=\log_2{\frac{1}{p_x(0)}}=1,58& \\
&p_x(1)=\frac{1}{6}, \ i(1)=2,58 \\
&p_x(2)=\frac{1}{12}, i(2)=3,58 \\
&p_x(3)=\frac{5}{12}, i(3)=1,26 \\
\end{flalign}$$
>Then the table will be: 
>
>| Symbol = x | length = $\lceil i(p_x)\rceil$ | Cumulative = $Q_i$ |  Decimal Codeword        | Codeword |
| ---------- | ------------------------------ | ------------------ | ------------------------ | -------- |
| 3          | 2                              | 0                  | 0                        | 00       |
| 0          | 2                              | $2^{-2}=1/4$       | $1/4\rightarrow1$        | 01       |
| 1          | 3                              | $2^{-2}+1/4=1/2$   | $1/2=4/8\rightarrow4$    | 100      |
| 2          | 4                              | $2^{-3}+1/2=5/8$   | $5/8=10/16\rightarrow10$ | 1010     |

^db0102

#### Shannon-Fano Code
>[!todo]

This code is slightly more efficient and is obtained by building a tree.
1) Find the probability of all symbols and arrange them in decreasing order.
2) Starting to the left divide the sequence in two parts such that the sum of the probability of their elements are as equal as possible. The two sequences will be the left and right child of a binary tree
3) repeat step 2 with the divided sequences in the 2 new nodes
4) Once you have only nodes containing start from the beginning and every left branch is a 0 and every right one is a 1
>[!example|*]
>Just look at this image:
>![[Pasted image 20241211123418.png|Shannon-Fano Code Tree Example|350]]

#### Huffman Code
1) Find the probability of all symbols and arrange them in decreasing order.
2) Connect the two rarest symbols in a new node and calculate the sum of their probabilities
3) Repeat step 2 until you end up with one single node
4) every branch going to the left is a 0, every branch to the right is a 1. Follow the path from the starting node until a symbol to find it's code

>[!example|*]
>The same code as the [[#^db0102]] for Shannon code will generate the following tree
>![[Pasted image 20241211101040.png|Example Tree|450]]
>therefore the codes will be:
>
>| Symbol = x | Codeword |
| ---------- | -------- |
| 3          | 0        |
| 0          | 10       |
| 1          | 110      |
| 2          | 111      |

# 3) Quantization
A quantizer takes a value (usually a voltage) and discretizes it as a sequence of bits.
The values entering are usually modeled with a pdf. This chapter will discuss how to build a quantizer that given a pdf of incoming signals can give the best results.
![[Pasted image 20241004143649.png|ADC|450]]
>[!lemma] Samples and Rates
>We generate $F_S=1/T_s$ samples per second called **symbol time**.
>Then $R_b=bF_s$ is the **nominal bitrate**.

### 3.1.1) Quantizer Structure
Let's start with some notation:
>[!lemma] I/O
>- The **input sample** is $a(nT_S)\in\mathbb R$. The term $nT_s$ is important since as seen in the figure above we take a sample every $T_s$ time
>- The **quantized sample** is $a_q(nT_s)\in\mathcal A_q$. This belongs to a set that contains $L=2^b$ elements called **quantizer levels**.
>- The **codeword** $c(nT_s)$ of $b$ bits representing the mapped value of $a_q(nT_s)$

![[Pasted image 20241004145453.png|Two equivalent representations of a quantiser|350]]
Recall that $F_s=1/T_s=1/bT_b\geq2B$ due to Shannon's sampling theorem.

>[!lemma] Quantizer Build Parameters
>- The **saturation value** $v_{sat}$ is the last (and $-v_{sat}$ the first) threshold of the quantizer
>- The **Quantization step size** $\Delta=v_i-v_{i-1}$ is the length of a quantization region.
>- Outside of the thresholds is the **saturation region** where the quantization step can't be defined. Inside the quantizer there is the **granular region**

>[!col]
>We will study **uniform quantizers** with **mid-riser representation** (that is that 0 as a value isn't exactly mapped, but is rounded to a higher value) as seen in the image.
>$$ $$
>To be uniform, the **levels will be equally spaced**.
>$$ $$
>Since it is mid riser, **it has exactly $L/2$ regions for positive and negative values**
>Remeber this: $$\begin{align}
\Delta=\frac{2v_{sat}}{L} =\frac{v_{sat}}{2^{b-1}}
\end{align}$$
>
>![[Pasted image 20241209164337.png|Uniform Quantizer with L=8|]]
## 3.2) Quantization Error
By looking at the second representation it is clear that the error is given as $e_q(nT_s) = a_q(nT_s) - a(nT_s)$, let' see how it behaves:
>[!lemma] Error
>In the granular region the error is called **granular error**:$\boxed{|e_q|\leq\Delta/2}$
>Outside it is called **saturation/overload error** and it doesn't have a bound

Usually $v_{sat}$ is a design decision that must be set to satisfy some requirements. 
Usually we have a SNR we have to meet:
>[!def] SNR
>We define the **SNR** as: 
>$$\Lambda_q=\frac{M_a}{M_{e_q}}=\frac{E[a^2(nT_s)]}{E[e_q^2(nT_s)]}$$
>Since it is a fraction of powers we can express it in dB:
>$$\text{SNR}\ [dB]=10\log_{10}\Lambda_q \ [dB]$$

And this theorem relates SNR to the load factor under a specific condition
>[!thm] Quantizer SNR
If $P_{sat}=P[|a(nT_s)|>v_{sat}]=P[\text{sample in saturation region}]<<1$ we have that:
>- $e_q$ is uniformly distributed: $p_{eq}=\frac1\Delta\text{rect}\frac x\Delta\implies M_{eq}=\frac{\Delta^2}{12}$
>- $\boxed{\text{SNR}=4.77+6,02b-20\log_{10}\frac{v_\text{sat}}{\sigma_a} \ [dB]}$
>
>>[!lemma] Load Factor
>>From here we can define the **load factor** $k_f=v_{sat}/{\sigma_a}$.

>[!todo]
If $P_{sat}\not<\not<1$ we have that $M_{e_q}=(1-P_{sat})M_{e_{gr}}+P_{sat}M_{e_{sat}}$
>Fortunately $M_{e_{gr}}=\Delta^2/12$ remains the same
>$$\begin{align} M_{e_{sat}}&=\int_{-\infty}^{-v_{sat}}[Q_0-u]^2p_a(u)du+\int_{v_{sat}}^{\infty}[Q_{L-1}-u]^2p_a(u)du\\
\text{usually: }&2\int_{v_{sat}}^\infty (2^{b-1}\Delta-\frac{\Delta}{2}-u)^2p_a(u)du\end{align}$$

Recall that $2^{b-1}\Delta=v_{sat}\implies2^{b-1}\Delta-\frac{\Delta}{2}=v_{sat}-\Delta/2=v_{sat}(1-1/2^{b-1})$
## 3.3) Final Remarks
It is important to notice that **adding one bit reduces the noise of 1/4**.
Add 1 to b $\implies$ L doubles $\implies$ $\Lambda_q$ quadruples $\implies$ 4x is roughly +6 dB

**Preprocessing:**
Usually we don't have signals with 0 mean, we must first preprocess them. Let $E[a]=k$ then we can study the quantizer with the signal $b(nT_s)=a(nT_s)-k$ with **no loss of generality**.
An additional step could be to normalize the signal, that is: $b(nT_s)=\frac{a(nT_s)}{\max a(nT_s)}-k$.

**Particular Cases: (p.150)**
- If the signal is **uniformly distributed** in $[-v_{sat},v_{sat}]$ then $k_f=\sqrt3\implies\Lambda=6.02b$
- if the signal is **sinusoidal $A\cos(2\pi f_0T_sk+\varphi)$** if $v_{sat}=A$ we have $k_f=\sqrt2\implies\Lambda=6.02b+1.76$
- If the signal is a **gaussian** with 0 mean: $P_{sat}=2Q(k_f)$

# 4) Characterization Of Transmission Media And Devices

## 4.1) Power and Mean
Up until now we discussed the power as a form of **statistical mean**. This has no real life correlation. Now we will study the physical layer of a telecommunications service and we will introduce **electrical power**. 
>[!col]
>>[!def] Statistical Power
>Let $x(t)$ be a **zero mean signal**, then we define the **statistical power** as:
>$$M_x=E[x^2(t)]$$
>
>>[!def] Electric Power
>We call the **instantaneous electric power** $v(t)i(t)$, and thus the **average electric power** $$P=\lim_{u\rightarrow\infty}\frac1{2u}\int_{-u}^uv(t)i(t)dt$$
>if $i,v$ are wss and ergodic rps it is equivalent to $P=E[v(t)i(t)]$
>

Some powers are hard to calculate, refer to [this table][#1.3) Powers] for a quick reference.
>[!col]
>$v(t)$ is measured in volts $[V]$ and thus the statistical power $M_V$ is measured in $[V^2]$ while the electric power $P$ is expressed in $[W]$.
>$$ $$
>Where the table shows a quick recap, notice that the left arrow is true only for real valued signals
>
>| Name, Symbol [Unit]             | $\stackrel{\mathcal F}\rightarrow$, "$\stackrel{\int}\leftarrow$" | Name, Symbol [Unit]                                   |
| ------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------- |
| Statistical Power, $M_v\ [V^2]$ | $\rightarrow$                                                     | Power Spectral Density, $\mathcal P_v(f) \ [V^2/Hz]$ |
| Electric Power, $P\ [W]$        | $\rightarrow$                                                     | Electric Power Density, $\text p(f)\ [W/Hz]$          |

But these two powers aren't completely independent. In general we have: $$\displaystyle{P=\int_{-\infty}^\infty\mathcal P_v(f)\frac{R(f)}{|Z(f)|^2}df}\ \text{ with } \  p(f) =\mathcal P_v(f)\frac{R(f)}{|Z(f)|^2}$$
>[!rmk|*] Frequency Invariant Case
>In a circuit where $Z(f)$ is constant within the band of $v$ we have that
>$$P=\int\mathcal P_v(f)\frac{R}{|Z|^2}df=\frac{R}{|Z|^2}M_v$$
>Moreover, if $Z=R$ we have ${P=M_v/R\iff R=M_v/P}$

Often we find the case where $v$ gives contribution to the power only in its band $B$ and thus the integral can be calculated between $[-B,B]$ instead of $[-\infty,\infty]$. 

**If a signal is real valued, it's transform is Hermitian**, then we can write:
$$P=\int_{-B}^{B}\text p_v(f)df=2\int_0^B\text p_v(f)df$$
## 4.2) Two Terminal Device
>[!col]
>Ohm's law works also in frequency domain. By applying it to a 2 terminal device we find that the voltage at the load is given as $$V_L(f)=G(f)V_i(f)=\frac{Z_L(f)}{Z_L(f)+Z_S(f)}V_i(f)$$
>
>![[Pasted image 20241030095259.png|Two Terminal Network|250]]



We can find that: ${\mathcal P_{L}(f)=\mathcal P_{vi}(f)|G(f)|^2}$, this explains how a PSD is transferred from source to load, the it clearly follows:
$$P_L=\int_{-\infty}^\infty\mathcal P_{vL}\frac{R_L}{|Z_L|^2}df=\int_{-\infty}^\infty\mathcal P_i\frac{|Z_L|^2}{|Z_L+Z_S|^2}\frac{R_L}{|Z_L|^2}df=\int_{-\infty}^\infty\mathcal P_i\frac{R_L}{|Z_L+Z_S|^2}df$$
then it is clear that: $$\boxed{\begin{align}
\text p_L(f)=&\mathcal P_{i}(f)\frac{R_L(f)}{|Z_S(f)+Z_L(f)|^2}\\
\text p_L(f)=&\mathcal P_L\frac{R_L(f)}{|Z_L(f)|^2} \\
P_{L}=&\int_{-\infty}^\infty \text p_L(f)df
\end{align}}$$

#### Load Matching and Available Power
In a system with given $\mathcal P_{v_i}, Z_S$ what is the right $Z_L$ to choose in order to minimize power loss?

>[!thm] Load Matching
>The maximum transfer of electrical power is given under the condition
>$$Z_L(f)=\overline{Z_S(f)}$$

Notice that in a **purely resistive case, under load matching** we have $P_L=\int\mathcal P_i\frac{R_L}{(R_L+R_S)^2}df=\int\mathcal P_i\frac14\frac{R_S}{R_S^2}df=\frac14P_i$ 

But we don't care about power loss, **we care about signal quality** and a very simple way to check the conditions to keep a signal the same "shape" is: $v_i\rightarrow v_L=A_0v_i(t-t_0)$ which in frequency becomes $V_L=A_0V_Ie^{-j2\pi f t_0}$ and thus $H_p=\frac{V_L}{V_I}=A_0e^{-j2\pi f t_0}$. By imposing $t_0=0$ and $Z_I,Z_L$ purely resistive $R_L(1-A_0)=R_SA_0\implies A_0=\frac12, \ R_S=R_L$ and again $v_L=v_i/2, \ P_L=P_i/4$.

$\boxed{\text{From now on we will consider }P_{Tx}=P_{vi}/4}$

## 4.3) Two-Port Network

>[!col]
>In a real world scenario the circuit used before isn't ideal anymore and thus we must consider a Two-Port Network, where the double bipole represents what happens in between the input and output terminals, in which most importantly **has different power going in the network and coming out from it.**
>
>
>![[Pasted image 20241030105016.png|Two-Port Model|350]]

![[Pasted image 20241118165950.png|Equivalent Two-Port Network Model|350]]
$$\begin{align}
&G_1=\frac{V_1}{V_i}=\frac{Z_1}{Z_S+Z_1} \
&G_2=\frac{V_2}{V_1} \
&&G_L=\frac{V_L}{V_2}=\frac{Z_L}{Z_2+Z_L} \
&&G_{ch}=\frac{V_L}{V_1}=G_2\cdot G_L
\end{align}$$

Why do we consider $G_{ch}$ as something special? This is the channel that was added due to a double bipole, which is the convolution of $g_2*g_{ch}$.

We will also use the notation for $v_1,v_2$ that are called $v_{in},v_{out}$ respectively. The following equations hold:
$$g_{ch}(t)\stackrel{\mathcal{F}}\rightarrow G_{ch}(f), \
\mathcal P_{vL}(f)=\mathcal P_{v1}(f)|G_{ch}(f)|^2$$
$$\begin{align}
\text p_{v1}=\mathcal P_{v1}\frac{R_1}{|Z_1|^2}=\mathcal P_{vi}\frac{R_1}{|Z_1+Z_S|^2} \\
\text p_{vL}=\mathcal P_{vi}\frac{R_1}{|Z_1+Z_S|^2}|G_{ch}|^2
\end{align}$$

Now we can define a new parameter:

>[!def] Network Power Gain
>With powers densities it is possible to evaluate average powers, thus we define a real valued, non-negative function that relates the densities at the input and output of the network:
>$$g(f)=\frac{p_{v,out}(f)}{p_{v,in}(f)}$$
>It is usually expressed in [dB]
>Moreover if $g(f)<1$ we speak of attenuation $a(f)=1/g(f)\iff [a(f)]_{dB}=-[g(f)]_{dB}$

Now we can better define other power parameters:
$$\begin{align}
&p_{v,in}(f)=\mathcal P_{v1}\frac{R_1}{|Z_1|^2}\\
&p_{v,out}(f)=\mathcal P_{vL}\frac{R_L}{|Z_L|^2}\\
&\mathcal P_{vL}=\mathcal P_{v1}|G_{Ch}|^2
\end{align}$$

and thus: $\boxed{\displaystyle g(f)=|G_{Ch}|^2\frac{|Z_1|^2}{R_1}\frac{R_L}{|Z_L|^2}}$, if we are in a **matched 2-port network** $g(f)=|G_{Ch}|^2$, since $Z_1=Z_2=\overline Z_S=\overline Z_L$

From now on we will consider our systems in **narrowband:**

>[!def] Narrowband
>A signal is said to be **narrowband** if it has a band $B$ centered around $f_c$ with $f_c<<B$. In this condition we have that all values dependent on $f$ are constant
## 4.4) Noise
>[!col]
>In any conductor the **electrons move due to thermal agitation**. This movement is usually negligible, but with an accurate enough voltmeter **it is possible to measure some currents**. This is called **thermal noise** and **adds additively** to the regular currents due to superimposition. 
>The noise can be seen as a rv with zero mean but we usually consider a small value of the current/voltage over time and in this timeframe the mean isn't guaranteed to be 0.
>
>![[Pasted image 20241124171725.png|Noise Representation in 2 Terminal Network|350]]

Since it is additive we can substitute $v(t)$ with $v(t)+w(t)$. Since they are uncorrelated, the statistical power will be $M=E[(v+w)^2]=E[v^2]+E[w^2]+2E[v\cdot w]=M_v+M_w$.


The **power spectral density** of the noise in a resistor is modeled as a WSS rp with PSD:
$$\mathcal P_{w}(f)=2kTR\gamma(f)$$
So at room temperature $T=T_0=290[K]$ and with $f<<10^{11}$ we have that $\gamma(f)=1$, if it is also under **load matching** the power density is
$$\boxed{\begin{align}
&\mathcal P_{w_i}(f)=2kTR, &&\mathcal P_{w_L}(f)=\frac12kTR\\
&M_{w_i}=2\int_0^B\mathcal P_{w_i}df=4kTRB, &&M_{w_L}=kTRB \\
&p_{w_i}(f)=2kT, &&p_{w_L}(f)=\frac12kT \\
&P_{wi}=2\int_0^B\text p_{wi}(f)df=4kTB &&P_{wL}=kTB
\end{align}}$$
Quick "proof": $\text p_w(f)=\mathcal P_{w_i}(f)\frac{R_L(f)}{|Z_S(f)^2+Z_L(f)|^2}$ under load matching $\text p_w(f)=\mathcal P_{w_i}(f)\frac1{R}$$\implies$$p_w(f)=2kTR\cdot\frac1R=\frac12kT\boxed{}$

Which is  a **constant** PSD! This means it is a **white noise**

>[!rmk|*]
>It is possible to find written that: $\mathcal P_{wL}=\frac12kTR=N_0/2$, or also $M_{wL}=N_0B$ that is $N_0=kTR$ 

>[!def] Source Noise Temperature
>In a noisy circuit with $w_i$ the noise voltage and power density $p_w(f)$ at the load due to $w_i$, we define the **noise temperature** of the device as
>$$T_S(f)=\frac{p_{wL}(f)}{k/2}$$
>This depends on $f$, but if we are narrowband then $T(f)=T_0$.


>[!rmk|*]
>A passive network, that is a network composed only of passive elements, at room temperature $T_0$ we have:
>$$F(f)=1/g(f)=a(f), \ T_A(f)=T_0(a(f)-1)$$


>[!rmk|*]
A **noiseless** 2-Port Network working under load matching and narrowband has $$SNR_{in}=SNR_{out}=\frac{P_v}{P_w}$$
>With the ratio of any 2 powers of the same kind (statistical, density, PSD, electrical)

## 4.5) Noisy 2-Port Networks
>[!col]
>In the image, the first part of the circuit is a 2 terminal network and, **due to the noise temperature** $T_S$ we have $\text p_{w,in}^S=\frac12 k T_S(f)$, the noise exits the network with a gain $\text p_{w,out}^S=\frac12 k T_S(f)g_A(f)$.
>This power is the power resulting from just the noise at the source
>
>![[Pasted image 20241124110410.png|Sources of noise in a 2-port network|350]]

Thus we and up with the **total power** (noise and amplified signal) $\text p_{w,out}=p_{w,out}^S+p_{w,out}^A$ as 2 additive components since they are **uncorrelated**. The second term is the noise generated in the bipole

>[!def] Noise Temperature in a Matched 2 Port Network
>This parameter shows the noise temperature that $Z_S$ should have in order to produce the noise power density $p_{w,out}^A$
>$$T_A(f)=\frac{\text{p}_{w,out}^A(f)}{\frac12k\cdot g_A(f)}$$

^0e6dfe

Now we can also define another parameter
>[!def] Effective Input Noise Temperature
>This parameter denotes the equivalent temperature that the source should have in order to produce the total power density $p_{w,out}$ at the load.
>$$T_{eff,in}(f)=T_S(f)+T_A(f)$$

Keeping this in mind, it is clear that $\boxed{T_{eff,out}=T_{eff,in}g(f)}$.

The final parameter is:
>[!def] Noise Figure
>Suppose we have a 2 port network with temperature of $Z_S$ at $T_0=290K$, then we define the **noise figure** as:
>$$F(f)=\frac{p_{w,in}^{tot}}{p_{w,in}^S}=1+\frac{p_{w,in}^A}{p_{w,in}^S}=\frac{p_{w,out}^{tot}}{\frac12kT_0g_A}>1$$
>This is the ratio of the total power density and the available one measured at the load

Keeping in mind [[#^0e6dfe]] we end up with a useful equation:
$$\boxed{\begin{gather}
F_A(f)=1+\frac{T_A(f)}{T_0} \\
T_A(f)=T_0[F_A(f)-1]
\end{gather}}$$

Notice that these formulas *don't* work with $F(f),g(f)$ **expressed in [dB]**
By definition, we can write: $SNR_{out}=SNR_{in}/F_A$ or in dB scale: $SNR_{out}=SNR_{in}-F_A$

#### Cascade of Two-Port Network
>[!col]
>In a cascade of N two-port networks (in figure N=2) we can easily find the values of an equivalent single two-port network with the following formulas.
>
>![[Pasted image 20241030112126.png|Cascade of 2 Two-Port Network|350]]

$$\begin{align}
&g(f)=\prod_{i=1}^N g_i(f) \\
&T_A(f)=T_1(f)+\sum_{i=2}^N\frac{T_i(f)}{\prod_{j=1}^{N-1}g_j(f)}=T_1(f)+...+\frac{T_N(f)}{g_1(f)\cdot...\cdot g_{N-1}(f)} \\
&F(f)=F_1(f)+\sum_{i=2}^N\frac{F_i(f)-1}{\prod_{j=1}^{N-1}g_j(f)}=F_1(f)+...+\frac{F_N(f)-1}{g_1(f)\cdot...\cdot g_{N-1}(f)}
\end{align}$$

As a recap we can put this table:

|                             $T_S$                             |                        $T_A$                        |                                                $T_{eff}$                                                |
| :-----------------------------------------------------------: | :-------------------------------------------------: | :-----------------------------------------------------------------------------------------------------: |
| Noise introduced by the input to the system itself (i.e. sky) | Intrinsic of the device, or of the equivalent model | Total noise temperature seen at system input with contributions from sources and devices scaled by gain |


## 4.6) Transmission System Model

>[!col]
>If you have a concatenation it is useful to divide everything in 2 blocks: channel and receiver.
>$$ $$
>For the **channel we only consider the gain** (actually attenuation) and for the **receiver only the noise figure**
>$$ $$
>The noise in the channel is not ignored, but it is added at the end
>
>![[Pasted image 20241031162506.png|Channel Receiver Model|350]]

#### Additive White Gaussian Noise (AWGN) Model
The thermal noise is white and gaussian, thus we have: $P_w=2\int_B\frac12kT_0F_{rc}df$ where $T_{eff}=T_0F_{rc}$, then we can write the SNR as:
$$SNR_P=\frac{P_{s_{rc}}}{P_w}=\frac{P_{s_{Tx}}/a_{ch}}{kT_{eff}B}$$
We can notice that the SNR as power mean or statistical mean are equivalent, and we can write
$$SNR_M=\frac{M_s}{a_{ch}\frac12kT_{eff}\Re{(Z_0)}2B}=\frac{M_{s}}{a_{ch}N_0B}$$
We can then find a useful formula called **link budget** that directly calculates the SNR in dB.
$$\boxed{\Lambda[dB]=114+P_{Tx}[dBm]-a_{ch}[dB]-F_{RC}[dB]-10\log_{10}B[MHz]}$$

## 4.7) Transmission Media

A transmission medium is known once we find the **frequency response $G_{ch}(f)$** or the **power gain $g_{ch}(f)$**. Moreover we also need to consider a propagation delay $\tau_p=d/v$

#### Lines and Cables
>[!col]
>One important medium are cables. They can be generalised starting by their **characteristic impedance:**
>$$Z_0=\sqrt\frac{r+j2\pi fl}{g+j2\pi fc}$$
>
>![[Pasted image 20241031171205.png|Infinitesimal Cable Circuit|350]]

From here we find the frequency response and power gain:
$$G_{ch}=e^{-(\alpha(f)+j\beta(f))}, \ g_{ch}=|G_{ch}|^2e^{-2\alpha(f)d}$$
Notice that the attenuation can be written as $a_{ch}=\tilde a_{ch}d[dB/km]$
Thus an important parameter is $\tilde a_{ch}$ called **specific attenuation**.
The speed changes proportional to the speed of light:
- Fiber optics: $v=c/n$
- Coaxial cables: $v=c/\varepsilon_r$

#### Radio Links
The signal travels as an electromagnetic wave

We will use the **free space model** which works in space with reflections neglected
Consider an isotropic antenna transmitting $P_{tx}$ along a sphere. We must study the flow intersected by a second antenna: $\Phi_0(d)=\frac{P_{tx}}{4\pi d^2}$ but in reality we can direct the flow source and thus $\Phi(d)=\Phi_0(d)g_{Ant}$

# 5) Digital Modulation Systems

Digital modulation consists in translating an analog signal into a concatenation of **waveforms**. It can be easily done in 2 steps:
1) Anything we want to transmit can be transformed into a series of symbols: $a_0,...,a_m\rightarrow a_j\in A=\{1,...,M\}$
2) This can be further translated into a family of $M$ signals called **waveforms** $s_j(t)$ to represent every symbol of $A$

We will have $s_j(t)$ signals $\in L^2(\mathbb R)$ $\rightarrow$ limited energy

>[!rmk|*]
>$M$ is chosen based on efficiency, not the source. Even if the source is a flow of binary symbols, we might wan to create an alphabet of groups of length $L$, then $M=2^L$

#### Various Types of Times
>[!lemma]
>$T$ is the **symbol time**, i.e. the length of a waveform. $1/T$ is the **symbol rate**.
>$R_b$ is the **nominal bitrate** that exits the source. The **bit time** is $T_b=1/R_b=T/\log_2M$

>[!def|*] Sampling Rate and Nominal Bitrate
>A signal can be sampled with period $T_s$, which we call **sampling rate**.
>By selecting a number of bits $b$ that encodes the data we can define the **nominal bitrate** as $\frac{b}{T_s}=bF_s$, with $F_s=\frac{1}{T_s}$ called **symbol rate

## 5.2) Vector Spaces

![[Pasted image 20241127100744.png|Digital Modulation AWGN Channel|550]]

To better understand this chapter a knowledge of [[#1.1) Vector Spaces]] is needed. It is important to recall the relationship between norm, scalar product and energy for a vector space of signals in $L^2$

From [[#^6b1599]] we have that 
$$\boxed{\begin{align}
E_x=<x(t),x(t)>=\int |x(t)|^2dt \\
\text{length}(x(t))=||x(t)||=\sqrt E_x
\end{align}}$$

We have an isomorphism between $L^2(\mathbb R)$ and $\mathbb R^I$ and thus we can find a orthonormal basis for our m signals since generally $I\leq M$. This can be done through [[#^67d73a]].

This is very useful since we can take a signal $s_n(t)$ and turn it into $s_n=[s_{n,1},...,s_{n,M}]$ and vice versa, so the AWGN model can be rewritten $r(t)=s_{RC}(t)+w(t)\iff\vec r=\vec s+\vec w$ 
**Synthesis and analysis** are like this:
$$\begin{align}
&s_n=\sum_1^Is_{n,i}\varphi_i(t) \\
&s_{n,i}=<s_n(t),\phi_i(t)>
\end{align}$$


A problem arises once we consider **noise** since it is not guaranteed to be in the span of our signals. This is easily resolved by dividing the noise into the projection into the span, and it's perpendicular components: $w(t)=w_\varphi(t)+w_\perp(t)$
- $w_\varphi(t) = \sum_1^Iw_i\varphi_i$ with $w_i=<w(t),\varphi_i>$ is the noise given only by the signals in the span
- $w_\perp(t)$ is the noise perpendicular to the span, but we can safely neglect it
Then $\vec r=\vec s+\vec w_\varphi$  

We can neglect $w_\perp$ due to:

>[!thm] Theorem of Irrelevance
>Let a signal be described by 2 parts $w=[w_\phi,w_\perp]$, then if the conditional probability density function $p_{w_\perp|w_\phi,a_0}(p_\perp|p_\phi, n)$ doesn't depend on the value of $n$ assumed by $a_0$, that is if $p_{w_\perp|w_\phi,a_0}(p_\perp|p_\phi, n)=p_{w_\perp|w_\phi}(p_\perp|p_\phi)$, then we can disregard $w_\perp$.

The proof is left to the reader :)

#### Properties of $w_\phi$
Since we have AWGN, we know $w(t)$:
- Zero mean
- Gaussian
- $\mathcal P_w=N_0/2$
- $E[w_i,\overline{w_j}]=\frac{N_0}2\delta_{i-j}$
From here we find that the components are **uncorrelated** $\sigma_I^2=\frac{N_0}2$

>[!rmk|*]
>An important remark is the **Nyquist Criterion**, that is a condition that expresses the **general condition for narrowband channels** to avoid **intersymbol interference (ISI)** 
>$$<\phi_i(t),\phi_l(t-kT)> =
\begin{cases}
1, \ i=l, \ k=0 \\
0, \text{ otherwise}
\end{cases}$$
>this guarantees that the two signals are orthogonal for $k=0$ and they are also absent of ISI for $k\not=0$.

## 5.3) Decision Theory
Due to noise, given a signal $a_0$ we don't know the real transmitted value, we can only observe $\vec r$ and we can therefore estimate $\hat a_0$. In this chapter we will discuss the best way to estimate such signal.

We define a probability for each symbol $p_j=P[a_0=j]$ and these probabilities are maintained and hold independently for each $a_i$ (by source coding).

We assume that the noise is small and therefore $\vec r$ must correspond to the closest waveform $\vec s$. Then we define the **decision regions $R_1,...R_M$** such that:
$$\bigcup_0^M R_j=\mathbb R^I, R_i\cap R_j=\varnothing \text{ and therefore } \hat a_0=j\iff\vec r \in R_j$$

This arises the problem: **how do we find the best regions?**
#### Optimum Decision Regions
The best hypothesis to choose from is the one that maximises $P[C]=P[a_0=\hat a_0]=P[a_0=j,\hat a_0=j]$, that is that the received signal and the hypothesis we took is correct.
$$\begin{align}
&\text{By Bayes: } &&\sum P[a_0=j, \hat a_0 = j]=\sum P[\hat a_0=j|a_0 = j]p_j \\
&\text{Since }\hat a_0=j\iff\vec r \in R_j: &&\sum_1^M\int_{{R_i}}P_{\vec r|a_0}[\vec\rho|j]d\vec\rho\cdot p_j
\end{align}$$
where $P_{\vec r|a_0}$ is the pdf of $\vec r$
>[!col]
>![[Pasted image 20241115175552.png|Bad Regions|350]]
>
>![[Pasted image 20241115175521.png|Best Regions (Area is Maximised)|350]]
### 5.3.2) Criterions:
#### Maximum A Posteriori (MAP) Criterion
This is the best criterion where we **maximise $P_{a_0|r}(n|\rho)\implies p_{r|a_0}(\rho|n)\cdot p_n$**, that means we maximise the probability that $a_0$ was transmitted based on an a posteriori observation of $\rho$.

I have sent $\rho$. Knowing how probabile it is to send $s_n$ knowing I received $\rho$ I see what is the most probable $s_n$ to arrive, that is, ML calibrated with $p_n$.  
#### Maximum Likelihood (ML) Criterion
Here we **maximize $P_{r|a_0}(\rho|n)$**, that means that we maximize the probability that we can observe $r=\rho$ when we transmit $a_0=n$. This is used if we don't know the pdf of MAP. Moreover if the symbols are equiprobable it is equal to MAP.

I have received $\rho$. I search the probability I end up with $\rho$ knowing (supposing) I sent $s_n$ and find the highest value
#### Minimum Distance (MD) Criterion
This is the weakest criterion where we find the **minimum distance between $\rho,s_n$**. This is clearly the weakest criterion. Moreover if the noise is AWGN we have that it is equivalent to MAP. If we have AWGN + equiprobable symbols we have MAP=ML=MD

##### MD Receiver
Given an orthonormal basis of size $I$ we build $I$ filters of type $\psi_j=\overline\phi_j(t_0-t)$ ($t_0$ s.t. it is causal). Usually we can't have finite length signals (set $t_0=T$)
The output of the filter is: $(r*\psi_j)(t_0)=\int r(\tau)\psi_j(t_0-\tau)=\int r(\tau)\overline\phi_j(\tau)=<r(t),\phi_j(t)>=r_j$.
So the signal is filtered in all it's coordinates that are sent to a processor for argmin:
$\text{argmin}(d(\vec r,\vec s_j))=\text{argmin}||\vec r-\vec s_j||^2$ with:
$$\begin{align}
||\vec r-\vec s_j||^2&=\sum_1^I ((r_i-s_{j_i}))\overline{(r_i-s_{j_i})} \\
&=\sum(|r_i|^2+|s_{j_i}|^2-\overline r_is_{j_i}-r_i\overline s_{j_i}) \\
&=||\vec r||^2+||\vec s_j||^2-\sum2\Re[r_i\overline s_{j_i}]
\end{align}$$

## 5.4) Binary Modulation
A binary modulation, as the name suggests consists of a set of only 2 waveforms $\vec s_1,\vec s_2$, but these aren't necessarily orthonormal, so we must use Gram-Schmidt to find $\phi_1,\phi_2$.
This is very easy as $\phi_1(t)=\frac{s_1(t)}{\sqrt E_1}$ and $\phi_2 = \frac{s_2(t)-c\phi_1(t)}{\sqrt E_2}$
**Keep in mind that** $E_1$ is the energy of $\phi_1$ but also the coordinate on the $\phi_1$ axis of $s_1$. For $E_2$ it doesn't hold exactly the same since it is the length of $s_2$.
$$\boxed{\vec s_1=[s_{11},s_{12}]=[\sqrt E_1,0]; \ \vec s_2=[s_{21},s_{22}]=[c,\sqrt{E_2-|c|^2}]}$$
>[!def] Correlation Coefficient
>We can define a correlation coefficient as:
>$$\rho=\frac{<s_1(t),s_2(t)>}{\sqrt{E_1E_2}}$$
>Notice that $|\rho|\leq 1$
>Moreover, if the signals are real: $\rho=\frac{c}{\sqrt E_2}$
>And the following properties also hold: $\rho=\cos\sigma$, $d_{12}=\sqrt{E_1+E_2-2\sqrt{E_1E_2}\rho}$

Often it is useful to suppose that $E_1=E_2=E_s$. But $E_s$ can also be defined as the avg energy $\sum p_jE_j$ 
>[!todo]
>These energies are all statistical means, but there is a simple way to find also electrical power: $E_{elett}=E_{stat}/\Re[Z_0]$ [link utile](https://www.youtube.com/watch?v=JD_mMCee-ic&list=PLUr66GDpOOphYkZav4N0iKT4topmI2mcI&index=60&ab_channel=UniPerTutti) minuto 18
#### Orthogonal and Antipodal Binary Modulation
Here we will consider the signal having both equal energy $E_s$. (This works the same for different energy and $E_s=\sum p_jE_j$)

**Orthogonal Binary Modulation**
Suppose that $\sigma=\frac\pi2$ then clearly the two signals are already orthogonal and we just need to normalize them: $\phi_i=s_i(t)/\sqrt E_i$ and also $d_{12}=\sqrt{2 E_s}, \ \rho=0$.

**Antipodal Binary Modulation**
Here we have $\sigma=\pi$, then $d_{12}=2\sqrt E_s, \ \rho=-1$. We can say that $I=1$ and therefore there is only one basis.

**Which is better?**
We can better calculate $P[C]=p_1P[r\in R_1|a_0=1]+p_2P[r\in R_2|a_0=2]$, this can be done by looking at the first term:
$$\begin{align}
P[r\in R_1|a_0=1]= &P[d(r,s_1)<d(r,s_2)|a_0=1] \\
&P[d(s_1+w,s_1)<d(s_1+w,s_2)]\\
&P[d^2(w,0)<d^2(w,s_2-s_1)]\\
&P[||w||^2<||w||^2+||s_2-s_1||^2-2<w,s_2-s_1>] \\
&P[<w,s_2-s_1> \ < \textstyle\frac12||s_2-s_1||^2]
\end{align}$$
Notice that $||s_2-s_1||^2=d_{12}$ and when it increases $P[C]$ increases
Moreover $<w,s_2-s_1>=w_0=w_1(s_{21}-s_{11})+w_2(s_{22}-s_{12})$ which is a linear combination of gaussian variables, then: $E[w_0]=0$
The variance however is: $$\begin{align}
E[w_0^2]=&E[w_1^2(s_{21}-s_{11})^2+w_2^2(s_{22}-s_{12})^2+2w_1w_2(...)(...)]=\\
=&\sigma^2(s_{21}-s_{11})^2+\sigma^2(s_{22}-s_{12})^2=\sigma^2d_{12}^2
\end{align}$$
The second term has identical result and therefore
Therefore $\boxed{P[C]=P[w_0<\frac12d_{12}^2]=1-Q(\frac{d_{12}}{2\sigma})}$  and also $\boxed{P[E]=1-P[C]=Q(\frac{d_{12}}{2\sigma})}$


With real, physical, signals we also have $\boxed{P[E]=Q(\sqrt\frac{E_s(1-p)}{N_0})}$ , with:
- $1-p=2$ if antipodal
- $1-p=1$ if orthogonal

![[Pasted image 20241116142021.png|Difference in Error for Orthogonal and Antipodal Signals|450]]
What is $E_s/N_0$?
By recalling that $E_s=M_{s_{RC}}\cdot T, \ N_0=M_w/B\implies\frac{E_s}{N_0}=\frac{M_{RC}}{M_w}\cdot TB=SNR\cdot TB$ which shows how the error is anti-proportional to the SNR. Usually we will have that $B=1/T$.

>[!rmk|*]
>In a single filter reciever, that is an antipodal modulation, we have $\psi=\overline\phi(t_0-t)$ and then it is just a threshold detector to check if positive or negative

## 5.5) M-Ary Modulation
A M-ary modulation has $M$ different symbols that contains $L=log_2M$ symbols.

>[!rmk|*]
>It is important to notice that in this case $P[E]\not =P_{bit}$ since:
>- $P[E]$ is the probability to receive a different symbol (one or more bits wrong)
>- $P_{bit}$ is the probability to have **only** one of the n bits wrong

How do we solve the $P[C]$ maximisation problem?
Define an event $\mathcal E_{jk}$ that means "probability that if I transmit $s_k$ it is closer to $s_j$ that to $s_k$ (it doesn't end up in k region)". 
These events are **not disjoint**, but with this event we actually and up in a binary case $\implies$$P[\mathcal E_{jk}]=Q(\frac{d_{jk}}{2\sigma})$. 
With some algebra, and more notably, the union bound, we can derive an upper bound for $P[E]\leq\sum_{k=1}^M\sum_{j\not=k}Q(\frac{{d_{jk}}}{2\sigma})$.
Now, by **supposing equiprobable symbols and $d_min=\min{d_{jk}}$** we have $P[E]\leq(M-1)Q(\frac{d_{min}}{2\sigma})$

**Orthogonal M-ary Modulation:**
Suppose $<s_j(t),s(t)_k>=0\forall j\not=k$ and with power $E_s$ we have $\phi_j=s_j(t)/\sqrt E_j$ and $d_{min}=\sqrt{2E_s}$, then by the previous results:
$$Q\left(\sqrt{\frac{E_s}{N_0}}\right)\leq P[E]\leq (M-1)Q\left(\sqrt{\frac{E_s}{N_0}}\right)$$

**Biorthogonal M-ary Modulation:**
Here we have M/2 orthogonal waveforms all paired with an antipodal signal, in this case $d_{min}$ remains the same, but with high enough SNR we have:
$$Q\left(\sqrt{\frac{E_s}{N_0}}\right)\leq P[E]\leq (M-2)Q\left(\sqrt{\frac{E_s}{N_0}}\right)$$

### 5.5.1) Numerical Channel
We prefer an M-ary modulation since it has a higher bitrate. Unfortunately it has also a higher $P[E]$, but not all errors are equal! Thus we must find $P_{bit}$ to see how often we actually change only one bit. This is equivalent to searching $P[E]$ in $n$ memoryless binary symmetric channel (BSC).  That is $P[E]=1-P[C]=1-(1-P_{bit})^n$, and for a small $P_{bit}$, $P[E]\approx nP_{bit}$ due to taylor expansion.

>[!def] Hamming Distance
>Given 2 n-tuples of bits $\vec b,\vec c$ (2 groups of n bits), we define the hamming distance as:
>$$d_H(\vec b,\vec c)= \text{ \# of different bits between }\vec b,\vec c=\sum b_j\oplus c_j$$

^fba530

Then we have $\displaystyle P_{bit}=P[E]\frac{d_H(\vec c_j,\vec c_k)}{\log_2M}$, with $\vec c_k,\vec c_j$ the bitmaps of $\vec s_k,\vec s_j$
## 5.6) Practical Modulation Schemes
### 5.6.1) Pulse Amplitude Modulation (PAM)

^79b281

We utilize $M$ waveforms of type $\boxed{s_n(t)=\alpha_nh(t)}$. Where $h(t)\in L^2$ is our **base impulse** with energy $E_h$. The coefficients should follow $\boxed{\alpha_n=2n-1-M}$. In this way, since $M=2^L$ is even we have $\alpha_n$ that guarantees that **the constellation they will bee made of equally spaced odd multiples of $\sqrt{E_h}$**. Moreover $s_n(t)$ are **all linearly dependent $\implies \phi=h(t)/\sqrt{E_h}\implies I=1$**.
![[Pasted image 20241127124702.png|8 PAM Constellation|600]]
From here it is clear that the $d_{min}=2\sqrt{E_h}$. Recall that $\boxed{T_b=T/\log_2M}$

PAM can be both baseband or passband and depends on what type of $h(t)$ is chosen

Just for now, suppose $h(t)=\text{rect}(\frac{t-T/2}{T/2})$ to avoid ISI (later on we will see how this isn't an optimal solution)

The average energy (assuming equiprobable symbols) is then given by:
$$E_s=\frac{M^2-1}{3}E_h$$
And thus we must check the **MD criterion in 2 cases:**
- $s=s_1, s_M$.
$$\begin{align}P[C]&=P[r_1\in R_1|s=s_1]=P[s_1+w\in R_1]=P[w+(-M-1)\sqrt{E_h}<(-M-2)\sqrt{E_h}]=\\
&=P[w<-\sqrt{E_h}]=\boxed{1-Q\left(\sqrt\frac{2E_h}{N_0}\right)}
\end{align}$$
	and holds by symmetry at $s_M$
- $s=s_2,...,s_{M-1}$
$$\begin{align}
P[C]&=P[(2n-M-2)\sqrt{E_h}<(2n-M-1)\sqrt{E_h}+w<(2n-M)\sqrt{E_h}] \\
&=P[\sqrt{E_h}<w<\sqrt{E_h}]=P[|w|<\sqrt{E_h}]=\boxed{1-2Q\left(\sqrt\frac{2E_h}{N_0}\right)}
\end{align}$$
The first case happens $2/M$ times, the second case happens $M-2/M$ times, then we can find the **total probability**:
$$\begin{align}
P[C]&=\sum_1^MP_i[C]p_i=\frac2M(1-Q(\sqrt\frac{2E_h}{N_0}))+\frac{M-2}M(1-2Q(\sqrt\frac{2E_h}{N_0}))\\
&=1-2\frac{M-1}M\left(1-Q(\sqrt\frac{2E_h}{N_0})\right) \\
P[C]&\implies P[E]=1-P[C]=2\left(1-\frac1M\right)Q\left(\sqrt\frac{2E_h}{N_0}\right)
\end{align}$$
And finally we have:
$$\boxed{P[E]=2\left(1-\frac1M\right)Q\left(\sqrt{\frac{6}{M^2-1}\frac{E_s}{N_0}}\right)}$$
From here we can find the **bit error probability** by using the [[#^fba530]] $\displaystyle P_{bit}=P[E]\frac{d_H(\vec c_j,\vec c_k)}{\log_2M}=\boxed{P[E]\frac1{\log_2M}}$ and by setting that distance =1 using a gray code (only one bit changes)

>[!rmk]
>We have neglected the case in which the noise jumps for more than one area (by gray code it means more than 1 wrong bit) since it is asymptotically improbable:
>$P[s_i\rightarrow s_i+1]=Q(\sqrt\frac{2E_h}{N_0})$
>$P[s_i\rightarrow s_i+2]=Q(3\sqrt\frac{2E_h}{N_0})<<Q(\sqrt\frac{2E_h}{N_0})$
### 5.6.2) Quadrature Amplitude Modulation (QAM)

Here we have the waveforms of type: $\boxed{s_n(t)=\alpha_{n,I}h(t)\cos(2\pi f_0t)-\alpha_{n,Q}h(t)\sin(2\pi f_0t)}$ with $\alpha_n=\alpha_{n,I}+j\cdot\alpha_{n,Q}$ and we also have that 
$$s_n(t)=\Re[\alpha_nh(t)e^{j2\pi f_0t}]=|\alpha_nh(t)\cos(2\pi f_0t+\angle\alpha_n)|$$
**Orthonormal Basis:**


>[!col]
>We can prove that with $f_0>>B_h$ (usually T) the basis is given by
$$\begin{align}\phi_1=\sqrt{\frac2{E_h}}h(t)\cos(2\pi f_0t),\\ \phi_2=-\sqrt{\frac2{E_h}}h(t)\sin(2\pi f_0t)\end{align}$$
since $<\cos,\sin>=0$ under the initial assumption.
>By imposing through $\alpha_n$ a square grid it is clear that $d_{min}=\sqrt{2E_h}$.
>From here the avg. energy is: $E_s=\frac{M-1}3E_h$.
>
>![[Pasted image 20241202154240.png|128-QAM Constellation|350]]

For our distance we only care for the adjacent pieces, not the diagonally adjacent ones since they are more distant, and thus more unlikely

There fore we have 3 possible scenarios. Change the notation to $Q(\sqrt{\frac{E_h}2})=Q$.
**4 Error Directions:** $(L-2)^2$ cases
$$P[C]=P\left[|w_1|<\sqrt{\frac{E_h}2},|w_2|<\sqrt{\frac{E_h}2}\right]=P\left[|w_1|<\sqrt{\frac{E_h}2}\right]\cdot P\left[|w_2<|\sqrt{\frac{E_h}2}\right]=(1-2Q)^2$$
**3 Error Directions:** $4(L-2)$ cases
$P[C]=P\left[|w_1|<\sqrt{\frac{E_h}2}\right]\cdot P\left[w_2<\sqrt{\frac{E_h}2}\right]=(1-Q)(1-2Q)$
**2 Error Direction:** $4$ cases
$$P[C]=P\left[w_1<\sqrt{\frac{E_h}2}\right]\cdot P\left[w_2<\sqrt{\frac{E_h}2}\right]=(1-Q)^2$$
Then, finally we have:
$$P[C]=(1-2\frac{L-1}LQ)^2\rightarrow \boxed{P[E]=4\left(1-\frac{1}{\sqrt M}\right)Q\left(\frac{3 E_s}{(M-1)N_0}\right)}$$
With respect to [[#5.4.1) Pulse Amplitude Modulation (PAM)]] the performance of a QAM is clearly better for bigger M since it isn't quadratic
### 5.6.3) Phase Shift Keying (PSK) Modulation
Here instead of amplitude coefficients $\alpha_n$ we have angle coefficients $\sigma_n=\frac{2n-1}M\pi$ and with the waveforms of type: $s_n=h(t)\cos(2\pi f_0 t+ \sigma_n)$. This modulation is clearly **passband** with energy $E_s=E_h/2$.

**Orthonormal basis:**
As before, for $f_0>>B_h$ we have that the signals form a QAM orthonormal basis and the vectors can be written as $s_n=\sqrt\frac{E_h}2[\cos(\sigma),\sin(\sigma)]$.
The distance is a cord of a circumference $d_{min}=\sqrt{2E_h}\sin(\pi/M)$.
Due to how the constellation populates itself, we have that for $M>>1$ the error is: $P[E]=2Q(\sqrt\frac{E_h}{N_0}\sin(\frac\pi M))$.
![[Pasted image 20241202201252.png|8-PSK Constellation|350]]
But for $M=2$ we have that $P[E]=P_{bit}=Q(\sqrt\frac{2E_s}{N_0})$
And for $M=4$ we have $P[E]=2Q(\sqrt\frac{E_s}{N_0})$

Here is a specific case with M=2:
>[!example] Binary Phase Shift Keying (BPSK)
>We define the signals:
>$$s_1(t)=\begin{cases}
>A\cos(2\pi ft+q), &0\leq t\leq T\\
>0
>\end{cases}
,\ s_2(t)\begin{cases}
A\cos(2\pi ft+q+\pi), &0\leq t\leq T\\
0
\end{cases} =-s_1$$
>Then we can also define them as:
>$$\begin{align}
&s_1(t)=h(t)\cos(2\pi ft+q), \ h(t)=Arect(t/T) \\
&s_2(t)=-s_1(t)
>\end{align}$$
>Due to the sinusoidal function, we have that the bandwidth gets modulated to a pass band.
>What is the energy?
>$$E_s=\int_0^TA^2\cos^2(..)dt=\frac12A^2T$$
>Then, by noticing it is antipodal, we have $$\boxed{P[bit]=Q\left(\sqrt{\frac{A^2T}{N_0}}(1+\text{sinc}(4 f_0T))\right)}\stackrel{f_0>>1/T}\rightarrow Q(\sqrt{\frac{A^2T}{N_0}})$$


## 5.7) Comparisons
![[Pasted image 20241203143445.png|Recap Table|550]]

Moreover we define the spectral efficiency:
$$v=\frac{R_b}{2B_{min}}=\frac{\log_2M}{2TB_{min}}$$

## 5.8) Digital Transmission of an Analog Signal
This chapter re-introduces quantizers since they are used to sample $a(t)\in\mathbb R$. Therefore we will get 2 types of noise: Quantizer noise + Modulator (channel) noise.

$$SNR=\frac{M_s}{M_{eq}+M_{ch}}$$
Where $M_{eq}$ is the same as computed earlier. But $M_{ch}$ is quite harder to find.


# 6) Channel Coding and Capacity
In the previous chapters we analyzed how it is possible to transmit data in the most efficient way possible, both in energy terms and in information (quantity). In this chapter we will lear how it is actually possible to have a better transmission by adding some **redundancy**.

There are many ways to correct transmission errors, we will analyze a method that takes a sequence $b$ of bits and translates it into a new sequence $c$ of greater length and we send this through the channel.

A **fundamental assumption** is that if we receive $c\in C$ that we received it correctly. We will use **systematic code**, that is, that the codeword is the concatenation of the sequence + other n-k bits: $c[1\div n]=b[1\div k]+\text{other bits}[k+1\div n-k]$.

We will have an **original bitrate** $R_b=1/T_b$ and a **coded bitrate** $R_c=1/T_c$. The relationship between the bitrates are: $\boxed{R_c=R_b\cdot\frac nk}$

We define :
- **Automatic Repeat reQuest (ARQ):** error detection+retransmission.
- **Forward Error Correction (FEC):** adds redundancy in advance, it is one-directional

Since the codewords are discrete and the mapping between a sequence to a codeword is injective, we can define the same decision criterions as in chapter 5. It is important to notice that due to the injectivity only a subspace of $C$ actually has any meaning in our map

**MD Criterion:**
Here we use the hamming distance as a distance measurement to define the regions
>[!thm] Detection Power
>By defining the **minimum distance of a code** as $d_{min}=\min d_H[c_i,c_j]$. We can state the following:
>Using a block code with $d_{min}$ for error detection **guarantees** to detect every situation with at most $d_{min}-1$ wrong bits (#errors<$d_{min}$).

>[!thm] TODO Correction Power

>[!rmk|*]
>With a code that has $d_{min}$ we can do just one of the following:
>- Detect up to $d_{min}-1$ errors: $t<d_{min}$
>- Correct $t<d_{min}/2$ errors


Probability to receive $\tilde c$ s.t. $d_H[\tilde c, c]=d$: $P[c\rightarrow \tilde c]=P_{bit}^d(1-P_{bit})^{n-d}$
Probability to know the number of errors, but not the word: $P[d\text{ errors}]=\binom ndP_{bit}^d(1-P_{bit})^{n-d}$

**ML Criterion:**
>[!thm] Sufficient condition for ML=MD
>In order to have the equivalence, it is sufficient that it is a memoryless BSC (binary symmetric channel) with $P_{bit}<1/2$
>

Actually if $P_{bit}=1$ it is seen as an inverting channel, so the criterion holds also for $P_{bit}>1/2$ if we invert the bits. If $P_{bit}=1/2$ it is a **useless channel** since the output bits are independent and equiprobable

>[!thm] Hamming Bound
>If a block code has a correction power of up to $t$, then
>$$\frac kn <1-\frac1n\log_2\left(\sum_0^t\binom nr\right)$$

## 6.1) Linear Block Code
We create a new field with the set $\mathcal A^n=\mathbb Z_2^n=\{0,1\}$ where $b\in\mathcal A^b$ and $c\in\mathcal A^c$.
This is a vector space (no scalar product) and by boolean algebra we can define **the distance with the hamming distance, xor as $+$, and as $\cdot$**
We also define a **norm called hamming weight** that is the distance from the 0 **null word**: $||\cdot||_H=d_H(\cdot,\vec 0)$ which is $||c||_H=\sum_1^n c_i$ and also $d_h(c_1,c_2)=||c_1-c_2||_H$

We also have that $\mathcal C=\mu_c(\mathbb Z_2^K)$ is a linear subspace of $\mathbb Z_2^n$ and thus $c_1\pm c_2\in \mathcal C$ and most importantly $\vec0\in\mathcal C$.

>[!rmk]
>To check if a code is not linear is by finding a sum/difference that doesn't end up in the code. 
>A linear code must have $\vec 0$.

>[!thm] Minimum Distance Of Linear Coding
>The $d_{min}$ coincides with the minimum hamming weight of non null codewords:
>$$d_{min}=\min d_H(c_j,c_i)=\min||c_i||_H$$

Thus in a linear code, $c(c_1,...c_k)=\mu_c(b)$ that is equivalent to a linear combination of type $c_i=c_{i1}b_1+...+c{ik}b_k$ and this can be rewritten in matrix notation $c=Gb$. It must be invertible, **therefore rank G=k**.

>[!thm]
>A linear code admits generating matrix $G$ of form
>$$G=[\frac{I_k}A]$$
>where $I_k$ is the identity $k\times k$ matrix and $A$ is the parity matrix of size $(n-k)\times k$.
>

>[!thm] Deductions from Matrix TODO
>In a matrix I can deduce the following:
>- k symbols (the k columns) +1 ($\vec0$)
>- $d_{min}\leq n-k+1$
>- $d_{min}\not=1\iff$  no column is made of only one canonical base and systematic part made of only 0
>- $d_{min}\not=2\iff$  there are no two columns of A that have are identical

Any $G$ obtained by doing elementary operations on columns (summing 2 columns, switching 2 columns) changes the map $\mu_c$ but is still a valid matrix.

Instead, if  I do the operations on the rows I end up with a different code BUT they are permutations and their hamming weight, $d_{min}$, and correction/detection power. This is an **equivalent code**.

>[!thm]
>Every $G$ with rank = k can be rewritten in the system form. That is into a Jordan form. 

>[!thm] Singleton Bound
>$\forall$ linear code it holds that $d_{min}\leq n-k+1$

>[!def] Parity Check Matrix
>A **parity check** **matrix** is a ($l\times n$) matrix that has $\mathcal C$ as a null space:
>$$H\vec c=0\iff \vec c\in\mathcal C$$
>with $l\geq n-k$ but usually with the equality.

>[!thm] Properties
>- $HG=O$ with $O$ a completely null matrix
>- $\text{rank} H = n-k$
>- For systematic code $H=[-A|I_{n-k}]$ (moreover $A=-A$ since we are in $\mathbb Z_2$)

**Syndrome Decoding:**
I can use the parity check matrix to find errors! If I receive $c$ and do the product $Hc=\sigma$ if $\sigma\not=0$ then I have detected an error! We call $\sigma$ **syndrome**. There are exactly $2^k$ elements of $c$ with the same syndrome

>[!thm]
>Two words $c_1,c_2$ have the same syndrome if and only if their difference $y=c_1-c_2$ is a codeword:
>$$Hy=Hc_1-Hc_2=\sigma-\sigma=0$$

>[!thm] **Syndrome Decoding**
>If we receive a vector $\tilde c$ with syndrome $\sigma$, then his MD decoding is given by:
>$$c=\tilde c-\varepsilon(\sigma)$$
>where $\varepsilon(\sigma)=\text{argmin}||c||_H$ where c is any element in $\mathbb Z_2^n$ with same syndrome. This is called **coset leader**

## 6.2) Performance of Linear Codes
It is useful to know the avg energy of an information bit $E_b$ that is different of the avg energy per bit $E_s$ per modulated symbol (before redundancy).
$$E_b=\frac nk\frac{E_s}{\log_2M}$$

The coding efficiency is defined as:
$$\eta=\frac{H(S)}{\tilde L_{avg}}$$

Moreover we can do up to $t_c$ errors that can be corrected, so,  the probability to choose the wrong codeword is given by: 
$$\boxed{P[c\not=\tilde c]=\binom{n}{t_c+1}P_{bit}\ ^{t_c+1}(1-P_{bit})^{n-t_c-1}}$$
By supposing we do exactly $d_{min}$ errors:
$$\boxed{P[b\not=\tilde b]=\frac{d_{min}}n\binom{n}{t_c+1}P_{bit}\ ^{t_c+1}(1-P_{bit})^{n-t_c-1}}$$

# 7) NO Markov Chains Theory
# 8) Queueing Theory
>[!col]
 >Every time a service is claimed by many customers a queue is formed. A service might not be able to satisfy all customers at once and **queueing theory** aims to analyse via mathematical models these behaviours
>
>![[Pasted image 20241007134250.png|A generic Queueing System (QS)|350]]

Here is a quick recap of the used parameters:
![[Pasted image 20241012144719.png|Parameters|650]]
These will be better introduced at the start of each chapter

## 8.1) Processes
#### 4.1.1.1) Arrival Process
This section studies the arrival of customers via a random process.
>[!def] Customer, Arrival Time and Interarrival Time
>The **customers** that reach the QS are denoted by $\{C_n\}$ with $n\geq1$ the order of arrival
>
>The **arrival time** is denoted by $t_n$, an is the instant where $C_n$ enters the QS
>
>The **interarrival time between two customers** is defined as $\tau_n=t_n-t_{n-1}$

The interarrival times are considered as **iid rvs**:
$$\begin{align}
&P_\tau(a)=P[\tau_n\leq a], \ &&a\geq0 \\
&p_\tau(a)=\frac{dP_\tau(a)}{da}, &&\ a\geq0
\end{align}$$
That can be associated to a counting process $\{A(t), \ a \geq 0\}$
$$A(t)=\int_0^t\sum_{n=1}^{\infty}\delta(u-t_n)du$$
>[!def] Arrival rate
>Consider the case where $\{\tau_n\}$ are iid and with finite mean $E[\tau]=m_\tau$ then by [[#^4cf2cb]] the **arrival rate** is $\lambda=1/m_\tau$

We limit our attention to **homogeneous poisson processes** in this case the interarrival times will have the following pdf and cdf:
$$\boxed{p_\tau(a)=\lambda e^{-\lambda a}, \ P_\tau(a)=1-e^{-\lambda a}}$$

There are also a few more notable cases, the **deterministic** process, which has a constant $\tau$, and the **erlang process**, where $\tau$ is a sum of exponentials

#### 4.1.1.2) Service Process
This process encapsulates the servers stat provide the (statistically undistinguishable) services

>[!def] Departure Time, Queueing Time, System Time and Interdeparture time
>The **departure time** is the time at which a client entering at $t_n$ exits the system and is defined as:
>$$d_n = t_n+w_n+y_n=w+s$$
>Due to the **homogeneity** $n$ can be omitted:
>The **queueing time** $w_n$ can be written as $w$ and depend son the policy
>The **system time** $s=w+y$ is the total time spent in the system
>
>Similarly to the interarrival time, the **interdeparture time** is defined as $r_n=d_n-d_{n-1}$
>The **mean interdeparture time** is $m_r=E[r_n]$

^3069f1

>[!def] Service Time, Service Rate
>The **service time** is the time $y_i$  that $C_i$ spent in the server
>By assumption $\{y_n\}$ are iid and independent from the arrival process
>
>The **service rate** is the avg. number of customers that can be serves per time unit: $\mu=1/m_y$
>

These are the most common service times:
- **Exponential**: $y_i=1/\mu$
$$\begin{align}
&p_y(a)= \delta(a-1/\mu)\\
&P_y(a)= u(a-1/\mu)
\end{align}$$
- **Exponential**:
$$\begin{align}
&p_y(a)= \mu e^{-\mu a}\\
&P_y(a)=1-e^{-\mu a}
\end{align}$$
- **Erlang** index $r$ and parameter $r\mu$
$$\begin{align}
&p_y(a)= \frac{(r\mu)^ra^{r-1}}{(r-1)!}e^{-r\mu a}\\
&P_y(a)=1-\sum\frac{(r\mu a)^n}{n!}e^{-r\mu a}
\end{align}$$
## 8.2) Kendall Notation
A convenient way to specify a QS is with a **string of 6 characters** called Kendall Notation:
$$\text{A/B/C/K/N-S}$$
where:
- $A$: specifies the statistical model of the interarrival time
- $B$: specifies the statistical model of the service process
- $C$: # of servers = $m$
- $K$: system storage capacity (default:$\infty$)
- $N$: size of customer population (default:$\infty$)
- $S$: service discipline (default: FCFS)

Moreover $A,B$  can assume the following values:
- $M$: Memoryless/Markovian, is exponentially distributed
- $D$: Deterministic, constant value
- $E_r$: Erlang distribution with index r
- $G$: Generic distribution

## 8.3) Stability
Before talking of stability we must introduce some **occupancy metrics:**
>[!def] Occupancy metrics
>$$\begin{gather}
x(t)= z(t)+q(t) \\
\text{with: }
\end{gather}$$
>$$\begin{align}
&x(t) = \text{\# of clients in system} \\
&z(t) = \text{\# of clients in service} \\
&q(t) = \text{\# of clients in queue}
\end{align}$$
>Keep in mind that $q(t)=0 \iff z(t)=m$ and $q(t)=0 \iff z(t) < m$

>[!def] Stability of a QS
>A QS is stabile if:
>$$\lim_{t\rightarrow\infty}P[x(t)=k]=\pi_k\not=0$$
>and:
>- $\pi_k$ doesn't depend on $x(0)$
>- $\sum \pi_k = 1$

This means that a stable system **can serve all the clients** it receives and doesn't "explode"

Given m identical and independent servers with service rate $\mu$ we can define the **global service rate** as $m\mu$. Moreover if the service is **memoryless** we can say that every server offers **exponentially distributed service time**

- **Blocking System**: They are alway stable because the number of customers is upper bounded by K
- **Nonblocking systems**: They have a simple stability condition:
$$\boxed{\lambda<m\mu}$$
	that is: it is stable if the customers come, on average, at a lower number than what can be served
	
>[!rmk|*]
>If $\lambda=m\mu$ we have a widely unpredictable system

Given such a system, it is only natural to search a way to measure efficiency and throughput, here are the useful parameters we define:

>[!def] Offered Traffic, Departure Rate, Load Factor
>The **offered traffic** is the mean number of arrivals in the mean service time, i.e. $G$ is the arrival rate normalized to the service rate:
>$$G=\lambda m_y=\frac{\lambda}{\mu}$$
>
>The **departure rate/troughput** is defined as the mean number of customers leaving:
>$$\eta=\frac{1}{m_r}$$
>with $m_r$ the *[mean interdeparture time](#^3069f1)*
>
>The **useful traffic** is the mean number of departures in the mean service time, i.e. it is $\eta$ normalized to $\mu$
>$$S=\frac\eta\mu=\eta m_y$$
>
>The **load factor** is the utilization factor:
>$$\rho=\frac{\lambda m_y}{m}=\frac{\lambda}{m\mu}=\frac{G}{m}$$
>for single server systems it can also be rewritten as:
>$$\rho = \frac{m_y}{m_\tau}$$
>**A QS is nonblocking if:** $\rho<1$



That said, we can easily find some values of the throughput if we know the stability of the system:
$$\eta =
\begin{cases}
\lambda \ &\text{if QS is stable} \\
m\mu \ &\text{if QS is unstable}
\end{cases}
\ \iff \ 
S =
\begin{cases}
G \ &\text{if QS is stable} \\
m \ &\text{if QS is unstable}
\end{cases}$$
therefore the symbol  $\eta$  is not necessary


>[!rmk|*]
A very useful practical rule is: if QS is stable $\implies$ whatever gets inside must get out sooner or later, that is:
$$\mid S\mid<\infty\implies\text{QS is stable}$$

## 8.4) Little's Law
>[!theorem] Little's Law
>Let the means of the number of clients, arrival rate and staying time be finite, then
>$$\overline X=\overline\Lambda\cdot\overline S$$
>Independently of all the assumptions on the statistical model

`\begin{proof}`
We have that the number of clients is defined by $x(t)=A(t)-D(t)$, then we can define the averages as:
>[!col]
>$$\begin{gather}
>\\
\Lambda(t)=\frac{A(t)}{t} \\
X(t)=\frac{\int_0^tx(\tau)d\tau}{t} \\
S(t)=\frac{\int_0^tx(\tau)d\tau}{A(t)}
\end{gather}$$
>
>![[Pasted image 20241014155659.png|Illustration|350]]

These hold since they can be read as possible cases/all cases
By looking at $t\rightarrow\infty$ and by doing some algebraic manipulation we can prove little's law
$$\overline{X(t)}=\frac{\int_0^tx(\tau)d\tau}{t}\cdot\frac{A(t)}{A(t)}=\frac{\int_0^tx(\tau)d\tau}{A(t)}\cdot\frac{A(t)}{t}=\overline{S(t)}\cdot\overline{\Lambda(t)}$$`\end{proof}`

>[!rmk|*]
>If the process is ergodic we have that: $E[X(t)]=E[\Lambda(t)]\cdot E[S(t)]$


>[!rmk|*]
>This law can take different meanings based on the structure we consider:
>- **Entire system**: $m_x =\lambda m_S$
>- **Only waiting queue**: $m_q=\lambda m_w$
>- **Only server facility**: $m_z=\lambda m_y$

A particular case is a G/G/1 stable system. In that case $m_z=\lambda m_y=\lambda/\mu=\rho$ and allows for the interpretation of $\rho$ as the **probability of the server being busy**, since $m=1$ and z can take only two values ($z=0,z=1$) (not busy/busy)
$m_z=E[z]=P[z=0]\cdot0+P[z=1]\cdot1=P[\text{busy}]$

We also have that $\rho=\frac{m_z}m$

## 8.5) Markov Systems (M/M/...)
![[Pasted image 20241117133918.png|Recap of M/M/... Systems|550]]


Markovian systems are a particular type of QS since they exhibit the following properties:
>[!theorem] Markovian QS properties
>- The state of the QS can be summarized entirely by x(t)
>- x(t) is a birth-death process, i.e. it may increase/decrease by a sigle unit, there are **no simultaneous arrivals**

`\begin{proof}`
To prove the second part of the theorem we must find a way to describe the number of arrivals in an infinitesimal amount of time $[t,t+h]$ with $h\rightarrow0$. Being memoryless, it is equivalent to search in $[0,h]$.
The arrivals in $[0,h]$ can be expressed as:$$A(t)=\int_0^ha(t)dt$$
Now let's study the probability of an arrival in such a time frame:
$$P[\text{at least one arrival in }[0,h]]=P[A(h)\geq1]=P[\tau\leq h]=1-P[A(h)=0]$$
Since it is Markovian and by recalling the taylor expansion:
$$P[A(h)\geq1]=1-e^{-\lambda h}\cdot\frac{(\lambda h)^0}{0!}=1-e^{-\lambda h}=1-1+\lambda h+o(h)=\lambda h + o(h)$$
And clearly:
$$P[A(h)=0]=1-P[A(h)\geq1]=1-\lambda h + o(h)$$

We must compare the probability of $P[A(t)=1]$ and $P[A(t)\geq2]$ in order to find which one is more common
Since we can write  $P[A(h)=1]=P[A(h)\geq 1]-P[A(h)\geq2]$
it is reasonable to search for $P[A(h)\geq2]$ $$\begin{align}
P[A(h)\geq2] &= P[\tau_1+\tau_2\leq h] \\
&\leq P[\tau_1\leq h,\tau_2\leq h] \\
&\stackrel{\perp}{=}P[\tau_1\leq h]P[\tau_2\leq h] \\
&\stackrel{iid}{=}P[\tau\leq h]^2 =(\lambda h+o(h))^2=o(h)
\end{align}$$

So we have: $$P[A(h)=1]=\lambda h+o(h)-o(h)=\lambda h + o(h)$$
This table is a recap of the obtained results:

| Event       | $A(h)=0$           | $A(h)=1$         | $A(h)=2$ |
| ----------- | ------------------ | ---------------- | -------- |
| Probability | $1-\lambda h+o(h)$ | $\lambda h+o(h)$ | $o(h)$   |
Since  $o(h)<<\lambda h$ it is more probable to have $A(h)=0, A(h)=1$ than $A(h)\geq2$
`\end{proof}`

>[!corollary]
>If a QS has simultaneous arrivals $\implies$ it is not a markovian QS

#### M/M/1 System
An M/M/1 system allows us to consider noticeably less events for any small interval $[0,h]$ 

>[!thm] Interval Generalisation
>Since the arrival and departure processes are stationary the events in $[0,h]$ are iid for any event in $[t,t+h]$
>Thus the evolution of the system only depends on $x(t)$, it is a **sufficient statistics**

The events to consider are 3 if $x(0)>0$
1. 1 arrival with probability $\lambda h + o(h)$
2. 1 departure with probability $\mu h+o(h)$
3. No arrival/departure with probability $1-\lambda h - \mu h +o(h)$

While if $x(0)=0$ there are only 2 possible events, since departures can't happen:
1. 1 arrival with probability $\lambda h + o(h)$
2. 0 arrivals with probability $1-\lambda h + o(h)$

This can be represented by a **markov chain**:
![[Pasted image 20241028111336.png|Markov Chain|600]]
It is a **birth and death process**, that means that in any given time frame each circle represents the system state and the QS can only remain the same or change by $\pm 1$. The arrows with $\lambda$ and $\mu$ show that it takes the probability $\lambda h$ or $\mu h$ to change state. 

To evaluate $P[x(t+h)=k]$, that is the probability to go tho state k, we use the total probability law ($P[A]=\sum_{\text{all }B}P[A,B]\sum P[B]P[A|B]$)

By considering $P[A]$ the probability to arrive at a set state, $P[B]$ the probability of being in a said state (the probability exists only at distance $\{-1,0,1\}$) from the desired one and $P[A|B]$ the probability of arriving at the desired state knowing the QS is already in a set state.

If $k>0$ we have that
$$\begin{align}
P[A]=P[x(t+h)=k]&=P[x(t)=k-1]P[A|x(t)=k-1] \\
&+P[x(t)=k]P[A|x(t)=k] \\
&+P[x(t)=k+1]P[A|x(t)=k+1] \\
\\
P[A]&=P[x(t)=k-1]\lambda h \\
&+P[x(t)=k](1-\lambda h-\mu h) \\
&+P[x(t)=k+1]\mu h \\
\end{align}$$
moreover if $k=0$
$$P[A]=P[x(t)=0](1-\lambda h)+P[x(t)=1]\mu h$$

With the following result we can study what happens at **stability:**
We know that at the stability condition $\lim_{t\rightarrow\infty}P[x(t)=k]=\lim_{t\rightarrow\infty}P[x(t+h)=k]=\pi_k$, then:
$k\geq1$ $$\pi_k=\lambda h\pi_{k-1}+(1-\lambda h-\mu h)\pi_{k}+\mu h\pi_{k+1}\implies \lambda(\pi_{k-1}-\pi_k)=\mu(\pi_k-\pi_{k+1})$$
$k=0$$$\pi_0=\mu h\pi_1+(1-\lambda h)\pi_0\implies \pi_1=\frac{\lambda}{\mu}=\rho\pi_0$$
$k=1$$$\pi_2=\rho\pi_1$$By induction we see that:
$$\pi_{k+1}=\rho\pi_k\implies\pi_k=\rho^k\pi_0$$
We also know that $\sum\pi_k=1$, that implies $\pi_k<1$ and thus $\pi_0=1-\rho$
$$\pi_k=(1-\rho)\rho^k$$

![[Pasted image 20241028115806.png]]
>[!rmk|*]
>The moments of the occupancy metric depend only on $\rho$
>This is not true for time metrics 

A client enters and finds $k$ clients in queue: $s_{k+1}=y_1'+\sum_2^ky_i+y_{k+1}$
where $y_1'$ is the remaining service time and $y_2,...y_{k+1}$ are exponential with parameter $\mu$ and thus $s$ is sum of $k+1$ exponentials $\implies$ $s$ is erlang
$$p_{s|k}(a)=\frac{\mu(\mu a )^k}{k!}e^{-\mu a}u(a)$$

## 8.6) M/M/m Queueing System
# 9) Data Link Layer
## 9.1) Logical Link Control (LLC)

## 9.2) Media Access Control (MAC)

# 10) NO Network Layers

>[!todo]
>- Ch 5: MD Receiver (10;30), single filter receiver (11,16)