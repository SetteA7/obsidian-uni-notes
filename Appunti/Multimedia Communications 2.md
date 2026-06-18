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

### 2.1.2) Analytical RD curve


#### Recap:
Here is a tabe:

|                        | Signed                                             | Unsigned                                         | Deadzone  |
| ---------------------- | -------------------------------------------------- | ------------------------------------------------ | --------- |
| Type                   | Mid-rise                                           | Mid-tread                                        | Mid-tread |
| Implementation: $Q(x)$ | $$\Delta\cdot\floor{\frac x\Delta}+\frac \Delta2$$ | $$\Delta \cdot \text{round}\par{\frac x\Delta}$$ |           |
Given range and levels, UQ has the **smalles maximum error** (optimal minimax quantizer) of $e_\max=\frac{\Delta_i} 2=\frac A{2L}$
