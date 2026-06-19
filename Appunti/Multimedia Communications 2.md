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
Since in predictive SQ the **prediction error=signal error**
$$q(n)=y(n)-\hat y(n)=x(n)-v(n)-(\hat x(n)-v(n))=x(n)-\hat x(n)=\overline q(n)$$
![[Pasted image 20260320160934.png|Quantizer process|350]]
it is possible to focus only on optimizing $\sigma_y^2$: