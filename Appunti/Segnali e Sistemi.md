# 1) Dirac Delta
The formal definition differs from the practical definition of $\delta(t)$, so I won't write them :)

Here are some useful theorems with $\delta(t)$
>[!theorem] Relationship with $u(t)$
>1) $$u(t-\alpha)'= \delta(t-\alpha)$$
>2) $$u(t) = \int_{-\infty}^{t}\delta(\tau)d\tau$$

>[!Theorem] Multiplication
>1) $$f(t)\delta(t)=f(0)\delta(t)$$
>2) $$f(t-\beta)\delta(t-\alpha) = f(\alpha-\beta)\delta(t-\alpha)$$

>[!theorem] Convolution
>1) $$\delta(t-\alpha)*\delta(t-\beta) = \delta(t-\alpha-\beta)$$
>2) $$f(t-\beta)*\delta(t-\alpha) = \int{f(\alpha-\beta)\delta(t-\alpha)}d\tau = f(t-\alpha-\beta)$$

^260f3b

>[!rmk] Time shifts are swappable in a convolution:
>$$x(t+\alpha)*y(t+\beta)=\int{x(\tau+\alpha)y(t+\beta - \tau)}d\tau=\int{x(\tau)y(t+\beta +\alpha- \tau)}d\tau$$

^6482aa

^d62f62
# 2) Convolution
To extend and generalise [[#^260f3b]] and keeping in mind [[#^6482aa]]
>[!theorem]
>Writing
>$$x(t+\alpha)*y(t+\beta)=x(t+\alpha+\beta)*y(t)x(t)*y(t+\alpha+\beta)$$
>is completely equivalent to
>$$\int{x(\tau+\alpha)y(t+\beta - \tau)}d\tau=\int{x(\tau+\alpha+\beta)y(t - \tau)}d\tau= \int{x(\tau)y(t+\alpha+\beta - \tau)}d\tau$$

# 3) Periodic Signals
>[!theorem] Convolutional representation of a periodic signal
>$$rep_{T}(x(t))= \displaystyle\sum_{-\infty}^{\infty}x(t-kT)=\displaystyle\sum_{-\infty}^{\infty}\delta(t-kT)x(t)$$

>[!theorem] Energy and Power of periodic signals
>Due to the nature of a periodic signal it's energy is always equal to 0 since it doesn't attenuate
>
>The power is equal to the mean energy over one period
>$$
>P(x(t))= \frac{\int_{[T]}\mid x(t)\mid^2}{T}
>$$

>[!remark] 
>This is valid also for any function given in a form of $x(t) = x_{p(t)}+x_{!p}(t)$  with $x_p(t)$ a periodic function and $x_{!p}(t)$ a limited Energy function, then the power will be
>$$
>P(x(t))= \frac{\int_{[T]}\mid x_p(t)\mid^2}{T}
>$$
>since $P(x_{!p}(t)) = 0$  

# 4) LTI Systems
>[!def] Impulse Response
>Given an LTI system, the impulse response of such system is
>$$h(t):=L(\delta(t))$$

# 5) Fourier Series

>[!theorem] Transformations of $a_k$ 
>Let $x(t) \in L^1$ admit Fourier series $a_k$
>
| Transformations |                                                | Remarks                                                                                     |
| --------------- | ---------------------------------------------- | ------------------------------------------------------------------------------------------- |
| Conjugate       | $\overline{x(t)}\rightarrow \overline{a_{-k}}$ | if $x(t) \in \mathbb{R} \implies$ $x(t) = \overline{x(t)} \implies a_k = \overline{a_{-k}}$ |
| Time inversion  | $x(-t) \rightarrow a_{-k}$                     | if $x(t)$ even $\implies$ $x(t) = x(-t) \implies a_k = a_{-k}$                              |
| Time scale      | $x(\alpha t) \rightarrow a_k$ $\alpha > 0$     | $T' = T/\alpha$, $w' = \alpha w$                                                            |
| Traslation      | $x(t+\beta) \rightarrow e^{jkw_0\beta}a_k$     |                                                                                             |
| Modulation      | $e^{jMw_0t} \rightarrow a_{k-M}$               |                                                                                             |
| Derivation      | $\frac{dx(t)}{dt} \rightarrow jkw_0a_k$        |                                                                                             |

>[!theorem] Coefficients for LTI systems
>Let $x(t)$ admit coefficients $a_k$ and let $h(t) \in L^1(\mathbb{R})$, then $y(t) = h*x(t)$ will have the following coefficients:
>$$b_k = H(jw_k)a_k$$
`\begin{proof}`
Simply $x(t) = \displaystyle\sum_{-\infty}^{\infty} a_ke^{jwkt}$ then $H(jw)x(t) = \displaystyle\sum_{-\infty}^{\infty} H(jw)a_ke^{jwkt}$
`\end{proof}`

>[!theorem] Coefficients of $x(t) =$ rep$_T($rect$(t/t_0))$
>Let $x(t) =$ rep$_T($rect$(t/t_0))$ with $t_0 \le T$, then the coefficients $a_k$ are:
>$$a_k = \frac{t_0}{T}sinc(\frac{wkt_o}{2\pi})$$
>`\begin{proof}`
>By definition
>$a_k = \displaystyle\frac{1}{T}\int_{-\frac{T}{2}}^{\frac{T}{2}}x(t)e^{-jwkt}dt$ 
>Let's compute only the integral for now, and since $t_0 \le T$
>$\displaystyle\int_{-\frac{t_0}{2}}^{\frac{t_0}{2}}e^{-jwkt}dt$ = $\frac{-1}{jwk}(e^{-jwkt})\displaystyle\mid_{-\frac{t_0}{2}}^{\frac{t_0}{2}}$ = $\frac{-1}{jwk}(e^{-jwk\frac{t_0}{2}}-e^{jwk\frac{t_0}{2}})$ = $\frac{1}{jwk}(-e^{-jwk\frac{t_0}{2}}+e^{jwk\frac{t_0}{2}})$
>by using Euler's equation
>$\frac{2}{wk}$sin$(wk\frac{t_0}{2})$=$\frac{2}{wk}$sin$(\pi \frac{wkt_0}{2\pi})$ = $\frac{2}{wk}$sin$(\pi \frac{wkt_0}{2\pi})$=$t_0$sinc$(\frac{wkt_0}{2\pi})$
>where the last step was possible by multiplying by $\frac{2t_0\pi}{2t_0\pi}$
>`\end{proof}`

>[!theorem] Parseval
>Let $x(t)$ = $\sum a_k e^{jkw_0t}$ $\implies$ $E(x(t))$ = $T\sum |a_k|^2$ 
>
>More in particular, if $y(t)$ = $\sum b_k e^{jkw_0t}$ has same period as $x(t)$, then
>$E(x(t), y(t))$ = $T\sum a_k \overline{b_k}$ 

# 6) Fourier Transform
## 6.1) Discrete (DFT)
Let's start with the discrete case
## 6.2) Continuous (FT)
>[!def] Fourier transform
>Let $x(t)$ be a signal with $t \in \mathbb R$, then the Fourier transform is defined as
>$$X(w) = \displaystyle\int_{-\infty}^{\infty} x(t)e^{-jwt}dt$$
>

>[!theorem] Existence of $X(w)$
>Let $x(t) \in L^1\mathbb(R)$ $\implies$ $\exists X(w)$ 

But clearly if $x(t)$ is periodic, then $x(t) \not\in L^1\mathbb(R)$.
For $x(t) = e^{jw_0t}$ $\implies$ $X(w)$ = $2\pi\delta(w-w_0)$ and by fourier series every periodic signal can be written as $x(t) = \displaystyle\sum_{-\infty}^{\infty} a_ke^{jw_kt}$ with $w_k = kw_0$, the clearly $X(w) = 2\pi\displaystyle\sum_{-\infty}^{\infty} a_k\delta(w-w_k)$
>[!theorem] $A(x(t))$ using Fourier Transform
>Let $\mathcal{F}(x(t))=X(w)$, then 
>$$A(x(t)) = X(w)\displaystyle\mid_{w=0}$$
>`\begin{proof}`
>By definition and by setting $w=0$, $A(x(t)) = \displaystyle\int_{-\infty}^{\infty}x(t)dt$ = $X(0)=\displaystyle\int_{-\infty}^{\infty}x(t)e^{-j0t}dt$
`\end{proof}`

With the same logic it is possible to extend the latter theorem to $E(x(t))$.

>[!theorem] Parseval Theorem
>Let $x(t) \in L^2$ and $\mathcal{F}(x(t))=X(w)$, then 
>$$E(x(t)) = \frac{1}{2\pi}\displaystyle\int_{-\infty}^{\infty}\mid X(w)\mid^2dw$$
>More in general, if $y(t) \in L^2$ and $\mathcal{F}(y(t))=Y(w)$, then
>$$E(x(t), y(t)) = \frac{1}{2\pi}\displaystyle\int_{-\infty}^{\infty} X(w)\overline{Y(w)}dw$$

# 7) Sampling
Sampling consists in the study of a sequence of data  $x(kT)_{k \in\mathbb{Z}}$ and the reconstruction of the original signal $x(t)$

>[!def] Bandwidth
>The bandwidth of a signal $x: \mathbb{R} \rightarrow \mathbb{R}$ is the length of the positive real part of it's fourier transform $B_{x} := \{w \geqslant 0 \mid X(jw) > 0\}$
>
>In particular if $B_{x} \subset [0, w_{M}]$ with $w_{M} :=$ sup$_{w}(B_{x})$ then it has limited bandwidth

^93c8a5

Example: $\mathcal{F}($sinc$(t))$ = rect$({\frac{w}{2\pi}})$ which has $w_{M} = \pi$ has limited bandwidth
Example:  $\mathcal{F}($rect$(t))$ = sinc$({\frac{w}{2\pi}})$ has $w_{M} = +\infty$ 

A simple way to write $x_{p}(t)$ is $x_{p}(t)$=$x(t)p(t)$=$x(t)\sum \delta(t-kT)$= $\sum x(kT)\delta(t-kT)$

>[!theorem] Shannon
>Let $x(t)$ be a limited bandwidth signal, then if it's sampling pulsation $w_{s} > 2w_{M}$, $x_{p}(t)$ determines $x(t)$
>
>`\begin{proof}`
>1) if $x(t) \in L^1\mathbb(R)$ its transform exists and is limited
>2) if $w_{s} \geq 2w_{M}$ then $X_{p}(w)$ = $\frac{1}{T}$rep$w_{s}(X(w))$ is made of infinite copies
>3) filter $x_{p}(t)$ with a low-pass filter $H_{lp} = T$rect$(\frac{w}{2w_{c}})$ with $w_{M} < w_{c} < w_{s}-w_{M}$
>4) the resulting signal is $X(w)$ 
>`\end{proof}`

>[!theorem] Shannon Interpolator
>By Shannon it is possible to reconstruct $x(t)$ with the following formula
>$$x(t) = \displaystyle\sum_{k = -\infty}^{\infty}x(kT)\textstyle{sinc}(\frac{t-kT}{T})$$
>the series converges in $L^2$

anche perchè $k \in \mathbb{N}$ quindi se $\alpha \in \mathbb{R}$ allora $\exists k = \alpha \notin \mathbb{N}$ ma se $w$ è comune a tutti gli esponenti allora $k = \displaystyle\frac{n\alpha}{w} \in \mathbb{N}$ dalle proprietà dei segnali periodici 

# 8) Laplace Transform
>[!theorem] Laplace transform of $\frac{d}{dt}x(t)$
>This theorem is valid only for unilateral Laplace Transforms.
>$$\displaystyle\mathcal{L}\left(\frac{d}{dt}x(t)\right)= sX(s)-x(0-)$$
>In general, the n-th derivative has the following transform
>$$\mathcal{L}\left(\frac{d^n}{dt^n}x(t)\right)= s^nX(s)-s^{n-1}x(0-)-s^{n-2}x'(0-)-...-x^{(n-1)}(0-)$$

>[!theorem] BIBO stability of $H(s)$
>Let a LTI system admit $H_+(s)$ that admits decomposition of form $\displaystyle\frac{b(s)}{a(s)}$ with $a,\ b$ polynomials of degree $m \leqslant n$, then the system is BIBO stable if the roots of $a(s)$ have all $Re(a) < 0$

