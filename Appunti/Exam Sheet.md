---
cssclasses: []
---



| Fourier Series |                                                                                | Symmetries                                           |                                                                                                                              |
| -------------- | ------------------------------------------------------------------------------ | ---------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Conjugate      | $\overline{x(t)}\rightarrow \overline{a_{-k}}$                                 | $x(t)$ Real $\iff$ $a_k$ Hermitian                   | $x(t)=\overline{x(-t)}\rightarrow a_k = \overline{a_k}$<br>$x(t) = \overline{x(t)} \rightarrow a_k = \overline{a_{-k}}$      |
| Time inversion | $x(-t) \rightarrow a_{-k}$                                                     | $x(t)$ Imag $\iff$ $a_k$ anti-Herm                   | $x(t)=-\overline{x(-t)}\rightarrow a_k = -\overline{a_k}$<br> $x(t) = -\overline{x(t)} \rightarrow a_k = -\overline{a_{-k}}$ |
| Time scale     | $x(\alpha t) \rightarrow a_k$ $\alpha > 0$<br>$T' = T/\alpha$, $w' = \alpha w$ | $x(t)$ Even $\iff$ $a_k$ Even<br>Real/imag preserved | $x(t)={x(-t)}\rightarrow a_k ={a_{-k}}$                                                                                      |
| Traslation     | $x(t+\beta) \rightarrow e^{jkw_0\beta}a_k$                                     | $x(t)$ Odd $\iff$ $a_k$ Odd<br>Real/imag switched    | $x(t)={-x(-t)}\rightarrow a_k = -{a_{-k}}$                                                                                   |
| Modulation     | $e^{jMw_0t} \rightarrow a_{k-M}$                                               |                                                      |                                                                                                                              |
| Derivation     | $\frac{dx(t)}{dt} \rightarrow jkw_0a_k$                                        |                                                      |                                                                                                                              |

| Fourier Transform   |                                                                                       |                                                            |                                                                         |
| ------------------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------- | ----------------------------------------------------------------------- |
| Rect Sinc           | $rect(t) \rightarrow sinc(w/2\pi)$                                                    | $rect(t) \rightarrow sinc(w/2\pi)$                         |                                                                         |
| Exponentials        | $e^{-\sigma t}u(t) \rightarrow \frac{1}{\sigma + j\omega}$                            | $e^{\sigma t}u(-t) \rightarrow \frac{1}{\sigma - j\omega}$ | $e^{-\sigma \mid t\mid}\rightarrow \frac{2\sigma}{\sigma^2 + \omega^2}$ |
| Fractions           | $1/t\rightarrow -j\pi sign(w)$                                                        | $\frac{1}{1+t^2} \rightarrow\pi e^{-\mid \omega \mid}$     |                                                                         |
| 1 dirac unit        | $1 \rightarrow 2\pi \delta(w)$                                                        | $\delta(t) \rightarrow 1$                                  | $u(t) \rightarrow \frac{1}{jw}+\pi\delta(w)$                            |
| Fourier Series      | $e^{jw_0t} \rightarrow 2\pi\delta(w-w_0)$                                             | $\sum a_ke^{jw_0t} \rightarrow 2\pi\sum a_k\delta(w-kw_0)$ |                                                                         |
| Sin Cos             | $sin(w_0t) \rightarrow j\pi(\delta(w+w_0)-\delta(w-w_0))$                             | $cos(w_0t) \rightarrow \pi(\delta(w+w_0)+\delta(w-w_0))$   |                                                                         |
|                     |                                                                                       |                                                            |                                                                         |
| Time Shift          | $x(t+a) \rightarrow e^{jwa}X(w)$                                                      | $e^{jw_0t}x(t) \rightarrow X(w-w_0)$                       |                                                                         |
| Modulation          | $x(at) \rightarrow \frac{1}{\mid a\mid}X(w/a)$                                        |                                                            |                                                                         |
| Product Convolution | $x*y(t) \rightarrow X(w) \times Y(w)$                                                 | $x(t) \times y(t)\rightarrow \frac{1}{2\pi} X(w)*Y(w)$     |                                                                         |
| Derivate            | $x'(t) \rightarrow jwX(w)$                                                            | $x^{(n)}(t) \rightarrow (jw)^nX(w)$                        |                                                                         |
| Derivative in t     | $tx(t)\rightarrow j\frac{d}{dw}X(w)$                                                  | $t^nx(t)\rightarrow j\frac{d^n}{dw^n}X(w)$                 |                                                                         |
| Integral            | $\displaystyle\int_{-\infty}^{t}x(t)dt \rightarrow \frac{X(w)}{jw}+\pi X(0)\delta(w)$ |                                                            |                                                                         |
| Duality             | $\displaystyle X(w)\mid_{w=t} \rightarrow 2\pi x(-w)$                                 |                                                            |                                                                         |


| Laplace                                            |                                                                  | DTFT                                                             |                   |
| -------------------------------------------------- | ---------------------------------------------------------------- | ---------------------------------------------------------------- | ----------------- |
| $\delta(t) \rightarrow 1$                          |                                                                  | $a^nu(n) \rightarrow \frac{e^{jw}}{e^{jw}-a}$                    | $\mid a \mid < 1$ |
| $u(t) \rightarrow \frac{1}{s}$                     |                                                                  | $-a^nu(-n-1) \rightarrow \frac{1}{1-ae^{-jw}}$                   | $\mid a \mid > 1$ |
| $tu(t) \rightarrow \frac{2}{s^3}$                  | $t^nu(t) \rightarrow \frac{n!}{s^{k+1}}$                         | $a^{\mid n \mid}\rightarrow \frac{1-a^2}{1+a^2-2acos(w)}$        | $\mid a \mid < 1$ |
| $e^{\sigma t}u(t) \rightarrow \frac{1}{s- \sigma}$ | $te^{\sigma t}u(t) \rightarrow \frac{1}{(s-\sigma)^2}$           | discrete rect $\rightarrow \frac{sin(N+\frac{1}{2})w}{sin(w/2)}$ |                   |
| $cos(wt)u(t) \rightarrow \frac{s}{s^2+w^2}$        | $e^{\sigma t}cos(wt)u(t) \rightarrow \frac{s-\sigma}{s^2 + w^2}$ |                                                                  |                   |
| $sin(wt)u(t) \rightarrow \frac{w}{s^2+w^2}$        | $e^{\sigma t}sin(wt)u(t) \rightarrow \frac{w}{(s-\sigma)^2+w^2}$ |                                                                  |                   |

| TDF Symmetries                             | DTFT Symmetries                                |
| ------------------------------------------ | ---------------------------------------------- |
| $x(t)\ real \iff X(w)\ real$               | $x(t)\ real \iff X(e^{jw})\ Hermitian$         |
| $x(t)\ even \iff X(w)\ even$               | $x(t)\ even \iff X(e^{jw})\ even$              |
| $x(t)\ odd \iff X(w)\ odd$                 | $x(t)\ odd \iff X(e^{jw})\ odd$                |
| $x(t)\ real \ even \iff X(w)\ real \ even$ | $x(t)\ real \ even\iff X(e^{jw})\ real \ even$ |
| $x(t)\ real \ odd \iff X(w)\ real \ odd$   | $x(t)\ real \ odd\iff X(e^{jw})\ real \ odd$   |

| ideal low pass                | ideal high pass                  | ideal passa banda                                    |
| ----------------------------- | -------------------------------- | ---------------------------------------------------- |
| $H(w) = rect(\frac{w}{2w_c})$ | $H(w) = 1- rect(\frac{w}{2w_L})$ | $H(w) = rect(\frac{w}{2w_H}) + rect(\frac{w}{2w_L})$ |
- Laplace Derivative
$\displaystyle\mathcal{L}\left(\frac{d}{dt}x(t)\right)= sX(s)-x(0-)$ 
$\displaystyle\mathcal{L}\left(\frac{d^n}{dt^n}x(t)\right)= s^nX(s)-s^{n-1}x(0-)-s^{n-2}x'(0-)-...-x^{(n-1)}(0-)$

- By Shannon it is possible to reconstruct $x(t)$ with the following formula $x(t) = \displaystyle\sum_{k = -\infty}^{\infty}x(kT)\textstyle{sinc}(\frac{t-kT}{T})$
  if $w_{s} > 2w_{M}$

- Rect Triangle Convolution: $tri(\frac{t}{T}) = \frac{1}{T}rect(\frac{t}{T})*rect(\frac{t}{T})$
- By same logic: $\mathcal{F}(sinc(\frac{t}{T})^2) = Ttri(\frac{wT}{2\pi})$
- $T=\frac{2\pi}{w}$, $f = \frac{1}{T} = \frac{w}{2\pi}$
- $sin(x) = -sin(-x)$, $cos(x) = cos(-x)$

- If an LTI system is discrete time $\implies$ $H(w)$ is periodic
- LTI is causal if $h(t) = 0\ \forall t < 0$

- DTFT if $X(w) = rep_{2\pi}(f(w))$ then I can use ant DTFT to find $x(t)$
- Convolutional representation of a periodic signal $rep_{T}(x(t))= \displaystyle\sum_{-\infty}^{\infty}x(t-kT)=\displaystyle\sum_{-\infty}^{\infty}\delta(t-kT)x(t)$
- Delta and Conv
$x(t+\alpha)*y(t+\beta)=x(t+\alpha+\beta)*y(t)x(t)*y(t+\alpha+\beta)$
$f(t-\beta)\delta(t-\alpha) = f(\alpha-\beta)\delta(t-\alpha)$
$\displaystyle f(t-\beta)*\delta(t-\alpha) = \int{f(\alpha-\beta)\delta(t-\alpha)}d\tau = f(t-\alpha-\beta)$

- SDF
$x(t) = \displaystyle\sum_{-\infty}^{\infty} a_ke^{jwkt}$
$b_k = H(wk)a_k$, that means it can only contain frequencies already present in $x(t)$
??? $x(t) =$ rep$_T($rect$(t/t_0))$, $a_k = \frac{t_0}{T}sinc(\frac{wkt_o}{2\pi})$
??? $trap = rect(t)*rect(\frac{t}{T})$ is trap of length T?
