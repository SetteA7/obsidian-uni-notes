# 1) Appendix
## 1.1) Moore Penrose Pseudo Inverse (!exam)
$$ $$
>[!def] Moore Penrose Pseudo Inverse
>The pseudo inverse of a $N \times M$ matrix $A$ is the unique matrix $A^\dagger$ satisfying:
>$$\begin{align}
AA^\dagger A&=A\\
A^\dagger AA^\dagger&=A^\dagger
\end{align}$$
>such that $AA^\dagger, A^\dagger A$ are both hermitian. ($(AA^\dagger)^*=AA^\dagger,(A^\dagger A)^*=A^\dagger A$)

- **Tall Matrix ($N>M$):** If $A^*A$ is invertible then $$A^\dagger =(A^*A)^{-1}A^*$$ is the left inverse of $A$ ($A^\dagger A=A$)
- **Fat Matrix ($N< M$):** If $AA^*$ is invertible then (right inverse) $$A^\dagger =A^*(AA^*)^{-1}$$ is the right inverse of $A$ ($AA^\dagger=A$)
- **Square Matrix:** If the matrix is square (and invertible) the pseudo inverse is the regular inverse.

>[!theorem] Characterization of Least-Squares Solutions
>$\forall x\in\mathbb K^n$ we have $\|Ax-b\|\geq \|Az-b\|$ where $z=A^\dagger b$.
>Moore Penrose Pseudo Inverse solves the least squares problem. 
>The disequality holds as an equality iff $x=A^\dagger b+(I-A^\dagger A)\vec w,  \forall \vec w$ and provides infinite solutions unless $A$ has full column rank (in this case $I-A^\dagger A=0$ ). The solution with minimum euclidean norm is z.

>[!theorem] Minimum Norm Solution
>If $Ax=b$ is satisfiable, the vector $z=A^\dagger b$ is a solution and satisfies $\|z\|\leq \|x\|$ for all solutions

# 2) Chapter 1: A Primer on Information Theory and MMSE
## 2.1) Information Content
#### **Entropy:**
$$ $$
$$\boxed{\mathcal H(x)=-\sum_xp_x(x)\log_2 p_x(x)=-\E[\log_2 p_x(x)]}$$
Properties:
- non negative
- maximized by $\sim u[a,b]$
- $\mathcal H(x)\leq \mathcal H(x|y)$
- $\mathcal H(x+c)=\mathcal H(x)$

#### **Differential Entropy:**
$$ $$
$$\boxed{\mathcal h(x)=-\int_x f_x(x)\log_2 f(x)dx=-\E[\log_2 f_x(x)]}$$
Properties:
- Can be negative
- maximized by $\sim\complexgauss(\mu,\sigma^2)$
- Cannot be approached by discretizing $f(x)$ ($h(x)=H(x^\Delta)+\log_2\Delta$)

Proof $\mathcal h(x)$ can be negative:
Let $x\sim u[0,b]$, then $\displaystyle\mathcal h(x)=\int_{0}^b\frac1 b\log_2 b \ dx=\log_2b<0 \ \forall b\in(0,1)$
$$\endproof$$
#### **Mutual Information:**
$$ $$
>[!col]
>$${\begin{align}I(s;y)&=\mathcal H(s)-\mathcal H(s|y)\\
&=\mathcal H(y)-\mathcal H(y|x)\\
&= D(p_{sy}||p_sp_y)
\end{align}}$$
>
>$${\begin{align}I(s;y)&=\mathcal h(s)-\mathcal h(s|y)\\
&=\mathcal h(y)-\mathcal h(y|x)\\
&= D(f_{sy}||f_sf_y)
\end{align}}$$

Mutual information can be obtained by discretizing x, y and calculating their entropy.
## 2.2) Reliable Communication
#### **Channel Law** (vectors)
$$ $$
$$\boxed{f_{y|s}(y|s)}$$
Then the mutual information becomes:
$$I(y;s)\stackrel{\text{memoryless}}=\E\sq{\log_2\frac{f_{y|s}(y|s)}{f_y(y)}}\stackrel{\text{memoryless+stationary}}=\E\sq{\log_2\frac{f_{y|s}(y|s)}{\displaystyle\frac1{2^{N_b}}\sum_{i=0}^{2^{N_b}-1}f_{y|s}(y|s_i)}}$$
#### **Capacity:**
Capacity is the maximum rate at which information can be transmitted over a channel with arbitrarily small error probability given an appropriate coding scheme. That is: $\exists$ coding scheme such that $p_e\rightarrow 0\iff N\rightarrow\infty$. When this limit is reached, the error probability quickly grows.

$$C\stackrel{\text{ergodic, static, memoryless}}=\max I(s;y)\stackrel{\text{ergodic, static}}=\max \lim_{N\rightarrow \infty}\frac1NI(s;y)$$
#### **Information Stable:**
A channel is said to be information stable if the information density does not deviate asymptotically from the mutual information, that is: $\lim_{N\rightarrow\infty}\frac1NI(s;y)=\lim_{N\rightarrow\infty}\frac1Ni(s;y)$

Where information density is the value whose expectation is the mutual information.
$$i(s;y)=\log_2\frac{f_{y|s}(y|s)}{f_y(y)f_s(s)}\rightarrow I(s;y)=\E[i(s;y)]$$
#### **Coding:**
With finite length codewords the spectral efficiency $\sq{\frac{\text{bit}/\text s}{\text{Hz}}}$ deviates form the capacity.
$$\frac RB-\sqrt\frac{V}{N}Q^{-1}(p_e)+O\par{\frac{\log N}N}\leq C$$
Where V is the variance of the information density.

## 2.3) MMSE Estimation, I-MMSE and LMMSE
The MMSE estimator choses $\hat s(t)$ that Minimizes the Mean Square Error. 
$$\hat s(y)=\E[s|y]\qquad MMSE(\hat s(y))=\E[|s(y)-\hat s(y)|^2]=\text{var}(\hat s(y))$$
#### **Properties:**
1. Unbiased in the mean: $\E[\hat s]=\E[\E[s|y]]=\E[s]$
2. Biased for specific implementation: $\E[\hat s|s]=\E[\E[s|y]|s]\not = s$
3. Satisfies Orthogonality Principle: $\E[g(y)(s(y)-\hat s(y))]=0$, that is error is uncorrelated to function of observation
4. In AWGN it is a monotonically decreasing function of $\rho$ (SNR)

Proof of 3:
Let the classic AWGN channel, then
$$\E[\hat s(y)|s]=\E[\frac{\sqrt\rho}{1+\rho}y|s]=\frac{\sqrt\rho}{1+\rho}\E[y|s]=\frac{\sqrt\rho}{1+\rho}s=s-\frac1{1+\rho}\not = s$$
$$\endproof$$
Proof of 2:
$$\E[g(s-\hat s)]=\E[\E[g(s-\hat s)|y]]=\E[g\E[s|y]-g\E[\hat s|y]]\stackrel{\text{From 1.}}=\E[g\E[s]-g\E[s]]=0$$
$$\endproof$$
Proof that estimator is true given 3:
Compute MSE:
$$\begin{align}|s-\hat s|^2&=|(s-\E[s|y])+(\E[s|y]-\hat s)|^2\\
&=|s-\E|^2+|\E-\hat s|^2+2\Re[(s-\E)(\E+\hat s^*)]\\
&=|s-\E|^2+|\E-\hat s|^2+2\Re[g(y)(s-\E)]\end{align}$$
where $g(y)=(\E[s|y]-\hat s(y))$. Now apply the expectation and the last term is the orthogonality principle:
$$\E[|s-\hat s|^2]=\E[|s-\E|^2]+\E[|\E-\hat s|^2]+0$$
and is minimized when $\hat s(y)=\E[s|y]$.
$$\endproof$$
#### **With Know Channel:**
$$ $$
$$ $$
$$f_{s|y}=\frac{f_{y|s}f_s}{f_y}=\frac{f_{y|s}f_s}{\int f_{y|s}f_sds}\rightarrow \hat s(y)=\E[s|y]=\int sf_{s|y}ds=\frac{\int sf_{y|s}f_sds}{\int f_{y|s}f_sds}$$
#### **I-MMSE**
Relates MMSE of gaussian to I.
Scalar case:
$$MMSE(\rho)=\frac{1}{\log_2e}\frac{d}{d\rho}I(s;y)=\frac{1}{\log_2e}\frac{d}{d\rho}\log_2(1+\rho)=\frac1{1+\rho}$$
$$I(s;y)=\log_2e\int_0^\rho MMSE(\rho)d\rho=\log_2e\log(1+\rho)=\log_2(1+\rho)$$
Vector case:
$$\rho AE=\frac1{\log_2e}\nabla_AI(s;y)$$
#### **L-MMSE**
Linear estimate for MMSE, In guasian noise LMMSE=MMSE, otherwise good approximation to simplify model.
$$\hat s(y)=W_{MMSE}^*y+b$$
$$\begin{align}
&W_{MMSE}=R_y^{-1}R_{ys}\\
&E=R_s-R_{ys}^*R_y^{-1}R_{ys}
\end{align}$$
## 2.4) Gaussian And AWGN
####  **Gaussian Distribution**
$$ $$

| Complex                    | Scalar                                                                                                                                                                                                                  | Vector                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Distribution               | $$x\sim\complexgauss(\mu,\sigma^2)$$                                                                                                                                                                                    | $$x\sim\complexgauss(\mu,R)$$                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| Distribution Function      | $$f_x(x)=\frac1{\pi\sigma^2}\exp{-\frac{\|x-\mu\|^2}{\sigma^2}}$$                                                                                                                                                       | $$f_x(x)=\frac1{\det{\pi R}}\exp{-(x-\mu)^*R^{-1}(x-\mu)}$$                                                                                                                                                                                                                                                                                                                                                                                                       |
| Differential Entropy       | $$\mathcal h(x)=\log_2(\pi e\sigma^2)$$                                                                                                                                                                                 | $$\mathcal h(x)=\log_2\det(\pi eR)$$                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Differential Entropy Proof | $$\begin{align} \mathcal h(x)&=-E[\log_2 f_x(x)]\\&=-\E[-\log_2\pi \sigma^2-a\log_2e]\\&=\log_2\pi \sigma^2+\log_2e\E[\frac{\|x-\mu\|^2}{\sigma^2}]\\&=\log_2\pi\sigma^2+\log_2e\cdot 1\\\end{align}$$<br>$$\endproof$$ | $$\begin{align}\mathcal h(x)&=-E[\log_2 f_x(x)]\\&=-\E[-\log_2\det(\pi R)-a\log_2e]\\&=\log_2\det(\pi R)+\log_2e\E[(x-\mu)^*R^{-1}(x-\mu)]\\&=\log_2\det(\pi R)+\log_2e\cdot \tr(I)\\&=\log_2\det(\pi e R)\end{align}$$<br> where $$\begin{align}\E[a^*R^{-1}a]&=\E[\tr(R^{-1}aa^*)]\\&=\tr(R^{-1}\E[aa^*])\\&=\tr(R^{-1}R)\\&=\tr(I)\end{align}$$<br> and $$\begin{align}\log_2e\cdot\tr (I)&=\log_2e^{\tr (I)}\\&=\log_2\det(eI)\end{align}$$<br> $$\endproof$$ |


#### **AWGN**
$$ $$

| Complex                  | Scalar                                                                                                                                                                                                                     | Vector                                                                                                                                                                                                                                                                               |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Base Form                | $$y=\sqrt \rho x+z$$                                                                                                                                                                                                       | $$y=\sqrt\rho As+z$$                                                                                                                                                                                                                                                                 |
| Distributions            | $$\begin{align}&x\sim\complexgauss(0,1)\\&z\sim\complexgauss(0,1)\\&y\sim\complexgauss(0,1+\rho)\\&y\|s\sim\complexgauss(\sqrt\rho s,1)\\&s\|y\sim\complexgauss\par{\frac{\sqrt\rho}{1+\rho}y,\frac1{1+\rho}}\end{align}$$ | $$\begin{align}&x\sim\complexgauss(0,R_s)\\&z\sim\complexgauss(0,R_z=I)\\&y\sim\complexgauss(0,\rho AR_sA^*+R_z)\\&y\|s\sim\complexgauss(\sqrt\rho As,R_z)\\&s\|y\sim\complexgauss\big(\sqrt \rho R_sA^*(\rho AR_SA^*+R_z)^{-1}y,(R_s^{-1}+\rho A^*R_z^{-1}A)^{-1}\big)\end{align}$$ |
| Mutual Information       | $$I(s;y)=\log_2(1+\rho)$$                                                                                                                                                                                                  | $$I(s;y)=\log_2\det(I+\rho AR_SA^*R_z^{-1})$$                                                                                                                                                                                                                                        |
| Mutual Information Proof | $$\begin{align}I(y;s)&=h(y)-h(y\|s)\\&=\log_2(\pi e (1+\rho))-\log_2(\pi e)\\&=\log_2(1+\rho)\end{align}$$<br>$$\endproof$$                                                                                                | $$\begin{align}I(y;s)&=h(y)-h(y\|s)\\&=\log_2\det(\pi e(\rho AR_SA^*+R_z))-\log_2\det(\pi e(R_z))\\&=\log_2\det(I+\rho AR_sA^*R_z^{-1})\end{align}$$<br>$$\endproof$$                                                                                                                |
| MMSE Estimator           | $$\hat s(y)=\frac{\sqrt \rho}{1+\rho}y$$                                                                                                                                                                                   | $$\hat s(y)=\sqrt \rho R_sA^*(\rho AR_sA^*+R_z)^{-1}y$$                                                                                                                                                                                                                              |
| MMSE                     | $$MMSE(\rho)=\frac1{1+\rho}$$                                                                                                                                                                                              | $$E=(R_s^{-1}+\rho A^*R_z^{-1}A)^{-1}$$                                                                                                                                                                                                                                              |

Proof of MMSE Estimator and MMSE for scalar case:
Recall $\displaystyle \hat s(y)=\frac{\int sf_{y|s}f_sds}{\int f_{y|s}f_sds}$ and by noticing the exponents
$$f_{y|s}f_s=\frac1{\pi^2}e^{-|y-\sqrt\rho s|^2-|s|^2}=\frac K{\pi\frac1{1+\rho}}\exp{-\frac{|s-\frac{\sqrt\rho}{1+\rho}y|^2}{\frac1{1+\rho}}}\sim K\complexgauss(\frac{\sqrt\rho}{1+\rho}y,\frac1{1+\rho})\propto f_{\hat s|y}$$

And therefore
$$\hat s(y)=\frac{\E[f_s]}{1}=\frac{\sqrt\rho}{1+\rho}y$$
and the MMSE is the variance of $\hat s(y)\propto f_{\hat s|y}$
$$\endproof$$
## 2.5) Additional Exercises
$$ $$
>[!example|1.2] Entropy Of Bernoulli RV
>Express entropy of bernoulli rv:
>$$x=\begin{cases} 0 \text{ with probability } p \\ 1 \text{ with probability } 1-p
\end{cases}$$
> Solution:
> Recall entropy: $H(x)=-\sum_x p(x)\log_2 p(x)$, then
> $$H(x)=-p\log_2 p-(1-p)\log_2(1-p)$$
> Solve additional min/max problem:
> $$\begin{align}\frac d{dp} H(x)&=-log_2(p)-\frac1{\ln p}+\log_2(1-p)+\frac1{\ln(p)}=\log_2\frac{1-p}{p}
\end{align}$$
> where $p=0.5$ provides the max entropy $H_\max=1$ and the min entropy is $p=0\implies H_\min=0$ by changing the og entropy formula 

Some derivatives:
$$\begin{align}
&\frac d{dx}\log_2 x=\frac1x\frac1{\ln 2}\\
&\frac d{dx}\log_k f(x) = \frac{f'(x)}{f(x)}\frac1{\ln k}\\
&\frac d{dx}f(x)\log_k f(x) = f'(x)\par{\log_kf(x)+\frac1{\ln k}}
\end{align}$$

>[!exercise|*] capacity of BSC
>The binary channel in which the input symbols are complemented with probability p is the simplest model of a channel with errors, yet it captures most of the complexity of the general problem. Calculate the capacity
>
>Solution:
>let $p_s(s)=\begin{cases}0 &\text{with probability} p_s \\ 1 &\text{with probability} 1-p_s\end{cases}$, then the channel law is: $p_{y|s}(y|s)$ and can be found in this way:
>$$p_{y|s}(y|s)\begin{cases}p(0|s)=\begin{cases}p(0|0)=1-p\\p(1|0)=p\end{cases}\\
p(1|s)=\begin{cases}p(1|0)=p\\p(1|1)=1-p\end{cases}\end{cases}$$
>and then the capacity is the maximum of the mutual information $I(s;y)=H(y)-H(y|s)$ where $H(y)=1$ is maximized when $p_s=0.5$. Now we must only calculate $H(y|s)=p_s(0)H(y|0)+p_s(1)H(y|1)$ by symmetry the two entropies are the same, so I just calculate one of them:
>$$-H(y|0)=p(0|0)\log_2 p(0|0)+p(1|0)\log_2 p(1|0)=(1-p)\log_2 (1-p)+p\log_2(p)$$
>$$H(s;y)=1-0.5[2(H(y|s))]=1+p\log_2p+(1-p)\log_2(1-p)$$
>And thus
>$$C=\max I(s;y)\rightarrow1$$


#### Extra
$$ $$
>[!example|*] $H(x)$ cannot be approached by discretizing $f_x$
>The entropy of a b-bit uantization is approximately $h(x)+b$, however this diverges as $b\rightarrow\infty$.
>From the mean value thm we have that
>$$\exists x_i\in[i\Delta, (i+1)\Delta]:f(x_i)\cdot\Delta=\int_{i\Delta}^{(i+1)\Delta}f(x)dx$$
>![[Pasted image 20251103194956.png|Bad Graphical representation|150]]
>Now consider $x^\Delta=x_i\in[i\Delta,(i+1)\Delta)$ by the mean value thm we have the discretized PMF $P[x_i]=\int f(x)dx=f(x_i)\Delta=p_i$. What happened is that by the mean val thm and by a small $\Delta$ we approximated $f\approx p$. This is exactly how integrals are computed, so this should work, right?
>
>The entropy of this quantized rv is found by
>$$\begin{align}
H(x^\Delta)&=-\sum_i p_i\log_2p_i\\
&=-\sum \Delta f(x_i)\log_2(\Delta f(x_i))\\
&=\sum\Delta f(x_i)\par{\log_2\Delta+\log_2f(x_i)}\\
&\text{notice how } \sum_i\Delta f(x_i)\log_2\Delta= \log_2\Delta\\
&=\underbracket{-\sum\Delta f(x_i)\log_2f(x_i)}_{h(x)}-\log_2\Delta\\
H(x^\Delta)&=h(x)-\log_2\Delta\rightarrow h(x)=H(x^\Delta)+\log_2\Delta
\end{align}$$
>Where $\sum \Delta f(x_i)=1$ by definiton of CDF.
>This holds for a uniform rv $x\sim U(0,1)$ as $\Delta =2^{-n}$ and thus $H(x^\Delta)=n$ but this doesn't hold for a gaussian rv as it needs more than n bits: $x\sim N(0,\sigma^2), \ \Delta =2^{-n}$ $H(x^\Delta)=\log(\pi e \sigma^2)+n$, so information is lost and the approximation is not valid.
>$\endproof$

>[!exercise|*] Discretization of X and Y can lend to mutual information calculation
>By recalling the result of [[#^98221d]] we can also find $H(X^\Delta|Y^\Delta)$.
>In fact, by applying the mean val thm in 2D we have that
>$$P_{x,y}=\iint f_{xy}(x,y)\ dxdy=\Delta_x\Delta_yf_{x,y}=p_{x,y}$$
>And thus
>$$p_{x|y}=\frac{p_{x,y}}{p_y}=\frac{\Delta_x\Delta_yf_{x,y}}{\Delta_yf_y}=\Delta_x\frac{f_{x,y}}{f_y}=\Delta_xf_{x|y}$$
>And as before
>$$\begin{align}
H(X^\Delta|Y^\Delta)&=-\sum_x\sum_y p(x,y)\log_2p(x|y)\\
&=-\sum_x\sum_y\Delta_x\Delta_yf(x,y)\par{\log_2\Delta_x-\log_2f(x|y)}\\
&=-\log_2\Delta_x+\sum_x\sum_y\Delta_x\Delta_y(x,y)\log_2f(x|y)\\
&=h(x|y)-\log_2\Delta_x
\end{align}$$
>Then just compare:
>$$I(x;y)=H(X^\Delta)-H(X^\Delta|Y^\Delta)=h(x)-\log_2\Delta_x-(h(x|y)-\log_2\Delta_x)=h(x)-h(x|y)$$
>$\endproof$
# 3) Chapter 2: A Signal Processing Perspective
## 3.1) Signal Representation
#### **Baseband TXSignal:**
$$ $$
$$x(t)=x_i(t)+jx_q(t)$$
#### **Upconversion to Passband Signal:**
$$ $$
$$\begin{align}
x_p(t)&=\sqrt 2\Re(x(t)e^{j2\pi f_ct})\\
&=\sqrt 2\Re((x_i+jx_q)(\cos+j\sin))\\
&=\sqrt2(x_i(t)\cos(2\pi f_ct)-x_q(t)\sin(2\pi f_ct))\\
&=A(t)\cos(\phi(t))\cos(2\pi f_c t)+A(t)\sin(\phi(t))\sin(2\pi f_ct)\\
&=A(t)\cos(2\pi f_ct+\phi(t))
\end{align}$$
#### **Passband RX Signal:**
$$ $$
$$y_p(t)=\sqrt2(y_i(t)\cos(2\pi f_ct)-y_q(t)\sin(2\pi f_ct))$$
#### **Downconversion to Baseband Signal:**
Find $y_i(t)$ by multiplying and then low pass filter $$y_p(t)\sqrt2\cos(2\pi f_c t)=y_i(t)+y_i(t)\cos(4\pi f_c t)-y_q\sin(2\pi f_c t)$$
Same for $y_q(t)$

## 3.2) Channel Models, Normalization Pulse Shaping and Noise Properties
#### **Channel Model** 
$$ $$
$$y_p(t)=(c_p*x_p)(t)=\int c_p(\tau)x_p(t-\tau)d\tau$$
$c_p$ doesn’t need to be band limited since $x_p$ already is $\rightarrow$ also $y_p$ is band limited
$$\downarrow\text{ Downshift}$$
$$c(\tau)=c_p(\tau)e^{-j2\pi f_c\tau}\ \rightarrow\text{ used for one tap (frequency flat) channels}$$
$$\downarrow\text{ Band Limit}$$
$$g_{B/2}=B\sinc(B\tau)\rightarrow c_b(\tau)=(g_{B/2}*c(\tau))=B\sinc(B\tau)*(c_p(\tau)e^{-j2\pi f_c \tau})$$
$$\downarrow\text{ Discretize in Time}$$
$$c[l]=Tc_b(\tau)\big |_{\tau =LT+\phi}\qquad T\leq 1/B$$
#### **Tapped Delay Line**
$$ $$
$$\begin{align}
c_p(\tau)&=\sum_qA_q\delta(\tau-\tau_q)\\
c(\tau)&=\sum_qA_q\delta(\tau-\tau_q)e^{-j2\pi f_c \tau_q}\\
c_b(\tau)&=\sum_{q=0}^{Q-1}BA_q\sinc(B(\tau-\tau_q))e^{-j2\pi f_c \tau_q}\\
c[l]&=\sum_{q=0}^{Q-1}TBA_q\sinc(B(lT+\phi-\tau_q))e^{-j2\pi f_c \tau_q}\\
&\quad\text{ Let } \phi=\tau_0\\
&=A_0\sinc(l)e^{-j2\pi f_c \tau_0}+\sum_{q=1}^{Q-1}A_q\sinc\par{l-\frac{\tau_0-\tau_q}T}e^{-j2\pi f_c \tau_q}\\
\end{align}$$
and is frequency flat only iff $\tau_q=n\tau_0,\quad n\in\mathbb N$.

#### **Channel Normalization**
SISO: $c[l]=\sqrt G h[l]$
$$\sum_{n=0}^{N-1}h[n]=1$$
MIMO: 
$$\sum_{l=0}^L\sum_{i=0}^{N_r-1}\sum_{j=0}^{N_t-1}\E[|H[l]_{(i,j)}|]=N_tN_r$$
$$\sum_{l=0}^L \E[|H[l]|_F]=\sum_{l=0}^L\E[\tr(H[l]H^*[l])]=N_rN_t\stackrel{\text{flat}}\longrightarrow \sum_{l=0}^L \E[|H[l]|_F]=\E[\tr(H[l]H^*[l])]=N_rN_t$$

#### **Pulse Shaping:**
$$ $$
$$x(t)=\sum_n x[n]\sinc\par{\frac{t-nT}T}$$
Although sinc not really used. Raised cosine has penalty if $\frac1{1+b}$

#### **Noise Properties:**
- White since autocovariance is $R_v=\E[v[t]v^*[t-\tau]]=N_0\delta(t)$  and thus it is static and ergodic
- Gaussian since $v\sim\complexgauss(0,N_0=kT_{eff})$ and by Law of Large Numbers sum of iid is gaussian
- Power Spectrum is $S_v(f)=N_0$ and thus in B it has power $P_v=\int_B N_0=BN_0$

## 3.3) Vector Representations
#### **SISO**
$$ $$
$$y[n]=\sqrt G\sum_l h[l]x[n-l]+v[n]\stackrel{\text{Stacked Vector}}\longrightarrow y_N =\sqrt G H_{N,N+L}x_{N+L} +v_N$$
where:
- $(\cdot)_N=[(\cdot)[0],...,(\cdot)[N-1]]^T$
- $x_{N+L}=[\underbracket{x[-L],...,x[-1]}_{\text{past values}}, x_N]^T$
- The Toeplitz matrix$${\mathbf H}_{N.N+L}=\begin{bmatrix}
h[L] & ... & h[0] & 0 & 0& ... & 0\\
0 & h[L] & ... & h[0]& 0 & ... & 0\\
\vdots&&&\ddots&&&\vdots\\
0 &... & ... &0& h[L] & ... & h[0]
\end{bmatrix}$$
#### **MIMO**
*i-th antenna with conv & TX-sum:*
$$y^{(i)}[n]=\sqrt G\sum_{j=0}^{N_t-1}\sum_lh^{(i,j)}[l]x^{(j)}[n-l]+v^{i}[n]$$
*MIMO base relation: all antennas with convolution:*
$$y[n]=\sqrt G\sum_l H[l]x[n-l]+v[n]$$
where:
- $(\cdot) [n]=[(\cdot)^{(0)}[n],...,(\cdot)^{(N_r-1)}[n]]^T$
- $x[n]=[x^{(0)}[n],...,x^{N_t-1}[n]]^T$
- $$H[l]=\begin{bmatrix}
h^{(0,0)}[l]&...&h^{(0,N_t-1)}[l]\\
\vdots &\ddots&\vdots\\
h^{(N_r-1,0)}[l]&...&h^{(N_r-1,N_t-1)}[l]
\end{bmatrix}$$
*i-th antenna with TX-sum stacked vectors:*
$$y^{(i)}_N=\sqrt G\sum_{j=0}^{N_t-1}H^{(i,j)}_{N,N+L}[l]x^{(j)}_{N+L}[n-l]+v^{(i)}_N[n]$$
using stacked vectors, that is:
- $(\cdot)_N^{(i)}=[(\cdot)^{(i)}[0],...,(\cdot)^{(i)}[N-1]]^T$
- $x_{N+L}^{(j)}=[\underbracket{x^{(j)}[-L],...,x^{(j)}[-1]}_{\text{past values}}, x^{(j)}_N]^T$
*Final MIMO relation: all antennas and no convolution*
$$y_{N_rN}=\sqrt GH_{N_rN,N_t(N+L)}x_{N_t(N+L)}+v_{N_rN}$$
where:
- $(\cdot)_{N_r,N}=[(\cdot)_N^{0},...,(\cdot)_N^{N_r-1}]^T$
- $x_{N+L}=[x_N^{0},...,x_N^{N_t-1}]^T$
- $$H_{N_rN,N_t(N+L)}=\begin{bmatrix}
H_{N.N+L}^{(0,0)} & ... & H_{N.N+L}^{(N_r,0)}\\
\vdots&\ddots&\vdots\\
H_{N.N+L}^{(0,N_t-1)} & ... & H_{N.N+L}^{(N_r,N_t-1)}
\end{bmatrix}$$

## 3.4) Power And Precoding
#### **Power & SNR Relations**
$$ $$
$$P_r=GP_t=GE_s/T \qquad SNR=\frac{P_r}{N_0B}=\frac{GP_t}{N_0/T}=\frac{GE_s}{N_0}$$
$$C(SNR)=\log_2(1+SNR)$$
$$E_b=\frac{GP_t}{R}=\frac{GE_s}{R/B}=N_0\frac{SNR}{R/B}=N_0\frac{SNR}{C(SNR)}=N_0\frac{SNR}{\log_2(1+SNR)}$$
#### **SISO Precoder**
$$ $$
$$x[n]=\sqrt{E_sP[n]}s[n]\qquad \frac1N\sum_nP[n]=1$$
#### **MIMO Precoder**
$$ $$
$$x[n]=\sqrt\frac{E_s}{N_t}F[n]s[n]\qquad N_s\leq N_t$$
moreover:
$$\begin{align}
&s[n] \text{ i.i.d.} \rightarrow \E[s[n]s^*[n]]=I\\
&\frac1N\sum_n\E[|F[n]|_F]=\frac 1N\sum_n \E[\tr(F[n]F^*[n])]=N_t\\
&R_x=\E[xx^*]=\frac{E_s}{N_t}\E[Fss^*F^*]=\frac{E_s}{N_t} F[n]F^*[n]
\end{align}$$
the singular value decomposition can be used to rewrite $F$:
$$F[n]=
\underset{\substack{\uparrow\\\text{Beam}\\\text{Steering}\\\text{Matrix}}}{U_F[n]}
\underset{\substack{\uparrow\\\text{Power}\\\text{Allocation}\\\text{Matrix}}}{\Sigma_F[n]}
\underset{\substack{\uparrow\\\text{Mixing}\\\text{Matrix}}}{V_F^*[n]}
$$
With:
- $U_F$, $V_F$ unitary and respectively $N_t\times N_t$, $N_s\times N_s$
- $\Sigma_F=\begin{bmatrix}P^{1/2}\\0\end{bmatrix}$ $N_t\times N_s$ matrix where $P^{1/2}$ is a square diagonal $N_s\times N_s$ matrix with the values $P_0, ...,P_{N_s-1}$
## 3.5) Zero Forcing
#### **Basic Case**
$$ $$
$$w^*(z)\sqrt G h(z)=z^{-\Delta}$$
ideal equalizer:
$$w^*(z)=\frac{z^{-\Delta}}{\sqrt Gh(z)}\longrightarrow (h*w^*)[n]=\delta(n-\Delta)\zeta h(z)w^*(z)=z^{-\Delta}$$
#### **MIMO Case:**
$W_{ZF}^*$ is the **left inverse of H that satisfies**
$$W^*(z)\sqrt GH(z)=D(z)$$
>[!thm] Theorem on FIR left inverses
>**A MIMO transfer function H(z) has a FIR left inverse iff H(z) has full column rank $\forall z\not=0$**
>It also turns out that:
>(!exam) 
>It turns out that an exact FIR ZF MIMO inverse exists for $N_r>N_t$ As long as the entries of H do not share a common root (coprime), then a FIR inverse exists

Rewrite:
$$W^*(z)\sqrt GH(z)=D(z)\zeta^{-1}\sqrt G\sum_{l=0}^{L_{eq}}W^*[l]H[n-l]=\text{diag}(\delta(n-\Delta_0),...,\delta(n-\Delta_{N_t-1}))$$
where:
- $D=\text{diag}(z^{-\Delta_0},...,z^{-\Delta_{N_t-1}})$
$$\text{Look at single entry: }\sqrt G\sum_{l=0}^{L_{eq}}w_j^*[l]H[n-l]=d_j^*[n]$$
where:
- $d_j^*[n]=$ 0 everywhere except j-th entry. Size = $N_r\times 1$
- $w_j^*[n]=W_{:,j}$ the j-th column of $W$. Size $N_t\times 1$

$$\text{stacked vectors to remove conv: }\sqrt Gw_j^*T=d_j^*$$
where:
- $d_j^*=[d_j^*[0],....,d_j^*[L_{eq}]]^T$ of size $(L_{eq}+1)N_r\times 1$
- $w_j^*=[w_j^*[0],...,w_j^*[L_{eq}+L]]^T$ of size $(L_{eq}+L+1)N_t\times 1$
- $T$ the classic toeplitz matrix but inverted of size $N_r(L_{eq}+1)\times N_t(L+L_{eq}+1)$ $$T=\begin{bmatrix}
H[0] & ... & H[L] & 0 & 0& ... & 0\\
0 & H[0] & ... & H[L]& 0 & ... & 0\\
\vdots&&&\ddots&&&\vdots\\
0 &... & ... &0& H[0] & ... & H[L]
\end{bmatrix}$$
This system is solved using the Moore Penrose Pseudoinverse (MPP):
$$w_j=\frac1{\sqrt G}(T^*)^\dagger d_j$$
- **T is tall** then system underdetermined an $\infty$ solutions. Use MPP and see $T^*$ is fat so $(T^*)^\dagger=T(T^*T)^{-1}$ and the solution is the minimum norm solution.
$$w_j=\frac1{\sqrt G}T(T^*T)^{-1}d_j$$
- **T is square** then there exists exactly one soluton
$$w_j=\frac1{\sqrt G}(T^*)^{-1}d_j$$
- **T is fat** then the system is overdetermined and has no solutions. MPP finds the least squares solution with minimum norm. Since $T^*$ is tall we have $(T^*)^\dagger=(TT^*)^{-1}T$ and the solution is
$$w_j=\frac1{\sqrt G}(TT^*)^{-1}Td_j$$
Same can be obtained with
$$W_{ZF}=\frac1{\sqrt G}(T^*)^\dagger D$$
#### **Linear ZF eq in Frequency Flat Channel**
Set $L_{eq}=L=0$ then $T=H$ and $H$ is tall. By MPP
$$W_{ZF}=\frac1{\sqrt G}H(H^*H)^{-1}D\rightarrow W_{ZF}^*=\frac1{\sqrt G}(H^*H)^{-1}H^*$$
and thus the equalizer has no error:
$$W_{ZF}^*\sqrt GH=\frac1{\sqrt G}(H^*H)^{-1}H^*\sqrt GH=(H^*H)^{-1}H^*H=I$$
#### **LMMSE IID**
$$\begin{align}
W^{MMSE}=\frac1{\sqrt G}\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD\\
E=\frac{E_s}{N_t}I-\frac{E_s}{N_t}D^*T^*\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD
\end{align}$$
(!exam) if there is no noise (SNR$\rightarrow\infty$) then the error goes to 0:
$$E\stackrel{SNR\rightarrow\infty}\longrightarrow \frac{E_s}{N_t}I-\frac{E_s}{N_t}D^*T^*(TT^*+0)TD=\frac{E_s}{N_t}I-\frac{E_s}{N_t}\underbracket{D^*T^*\underbrace{(TT^*)}_{I}TD}_{I}=\frac{E_s}{N_t}I-\frac{E_s}{N_t}I=0$$
## 3.6) OFDM

#### **Transmitter**
Coding happens in frequency domain, transmitter sends block of $K$ with $L$ prefix symbols.
$$x_f[0],...,x_f[K-1]\rightarrow \overline x_t[-L],...,\overline x_t[K-1]\text{ where }\overline x_t[n]=\begin{cases}x_t[n+K]&n=-L,...,-1\\ x_t[n]& n=0,...,K-1\end{cases}$$

Verify (!exam):
$$\begin{align}
\overline x_t[n]&=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}Knk}\\
&=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}Knk}\underbrace{e^{j\frac{2\pi}KKk}}_{=1}\\
&=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K(K+n)k}= x_t[K+n]
\end{align}$$
This is just the **periodicity property of the DFT**.
$$\endproof$$
#### **Channel:**
IDFT of cyclic prefix needs previous block of symbols to be computed, so **cyclic prefix removal** is done.
$$y_t[n] = \begin{cases}
\displaystyle
\sqrt{G} \sum_{l=0}^{L} h_t[l] \overline x_t[n-l] &n=0,...,K-1 \\
\displaystyle
\sqrt{G} \sum_{l=0}^{L+n} h_t[l] \overline x_t[n-l] + \sqrt G\sum_{l=L+n+1}^{L} h_t[l] \underbrace{\overline x_t[n-l]}_{\text{Out of Block}} &n=-L,...,-1
\end{cases}$$
Proof out of block:
Rewrite sum with $m=l-(L+n+1)$ so the summation becomes
$$\begin{align}
\sum_{l=L+n+1}^{L} h_t[l] {\overline x_t[n-l]}&=\sum_{m=0}^{-n-1}h_t[L+n+1+m]\overline x_t[n-(L+n+1+m)]\\
&=\sum_{m=0}^{-n-1}h_t[L+n+1+m]\overline x_t[-L-1-m]\\
&=\sum_{m=0}^{-n-1}h_t[L+n+1+m]\overline x_{t-1}[K-L-1-m]\\
&=\sum_{l=L+n+1}^{L} h_t[l] {\overline x_{t-1}[n-l+K]}
\end{align}$$
where $x_{t-1}$ is the previous block.
$$\endproof$$

#### **Receiver:**
The receiver computes the DFT using the cyclic prefix, which is a circular convolution
$$y_t[n]=\sqrt G\sum_{l=0}^{L-1}\overline h_t[n]\overline x_t[n-l]=\sqrt G\sum_{l=0}^{L-1}\overline h_t[n]x_t[(n-l)_K]\fourier x_f[k]=\sqrt G h_f[k]x_f[k]$$

Proof of circular convolution is product in frequency (!exam):
$$\begin{align}
\tilde y_f[n]&=\sum_{p=0}^{K-1}y_t[p]e^{-j\frac{2\pi}Knp}\\
&=\sum_{p=0}^{K-1}\sqrt G\sum_{l=0}^{L} h_t[l] \overline x_t[p-l]e^{-j\frac{2\pi}Knp}\\
&=\sum_{p=0}^{K-1}\sqrt G\sum_{l=0}^{L} h_t[l]\frac 1K \sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K(p-l)k}e^{-j\frac{2\pi}Knp}\\
&=\sqrt G\sum_{k=0}^{K-1}\sq{\par{\sum_{l=0}^{K-1}h_t[l]e^{-j\frac{2\pi}Klk}}x_f[k]\par{\frac1K\sum_{p=0}^{K-1}e^{j\frac{2\pi}Kp(k-n)}}}\\
&=\sqrt G\sum_{k=0}^{K-1}h_f[k]x_f[k]\delta(k-n)\\
&=\sqrt Gh_f[n]x_f[n]
\end{align}$$
$$\endproof$$
#### **OFDM Estimation:**
With absence of noise a simple eq is used:
$$\hat x_f[k]=\frac{\tilde y_f[k]}{\sqrt G h_f[k]}$$
With noise notice that $v_t[n]\approx v_f[k]$ (TODO Appendix C1.6) with the same ZF eq the variance of the output noise becomes $$\frac{N_0}{G}\frac1{|h_f[k]|^2}$$

## 3.7) Channel Estimation
For channel estimation some well known signals, called pilot signals $p[0],...,p[N_p-1]$ where $p[]$ is a $N_t\times 1$ vector. These signals are sent through a $L$ tap channel $\sqrt G H[l]$ and from the received signals a estimation on the channel can be made.
$$ P=\begin{bmatrix}
p[L]&p[L+1]&....&p[N_p-1]\\
p[L-1]&p[L+2]&...&p[N_p-2]\\
\vdots&\vdots&\vdots\\
p[0]&p[1]&...&p[N_p-L-1]
\end{bmatrix}$$
$$ Y=\sqrt G\  H \  P+ V\rightarrow\text{vec } Y=\sqrt GP_\otimes\text{vec } H+\text{vec }V$$
Proof:
$$\begin{align}
\text{vec }Y&=\sqrt G\text{vec }(HP)+\text{vec }V\\
&=\sqrt G \text{vec }(HIP)+\text{vec }V\\
&=\sqrt G\underbrace{(P^T\otimes I)}_{P_\otimes}\text{vec } H+\text{vec }V
\end{align}$$
$$\endproof$$
#### **ML and Least Squares Estimation & LMMSE**
In AWGN noise ML and LS estimators are equivalent

Proof:
$$\text{vec} [\hat H](y)=\arg\max_hf_{y|h}(y|h)=\arg\max_h\frac1{\det(\pi R)}e^{-\frac{|y-\mu|^2}R}\rightarrow\arg\min_h|y-\mu|^2$$
since constants can be removed form $\max$ and the exponent is monotonically decreasing
$$\endproof$$
Notice that $y|h\sim\complexgauss(\sqrt G P_{\otimes}h, N_0)$

|           | ML/Least Squares                                                                                                                                                                 | LMMSE                                                                                                                                                                                                                          |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Estimator | $$\begin{align}\text{vec}[\hat H](y)&=\frac1{\sqrt G}(P_\otimes^*P_\otimes)^{-1}P_\otimes^*y\\ \hat H&=\frac1{\sqrt G}YP_{\otimes}^*(P_{\otimes}P_{\otimes}^*)^{-1}\end{align}$$ | $$\text{vec}\hat H=\par{(\sqrt GP_\otimes(N_0R_{\text{vec}\hat H}^{-1}+GP_\otimes^*P_\otimes)^{-1}}^*y$$                                                                                                                       |
| MMSE      | $${E=\frac{N_0}G(P_\otimes^*P_\otimes)^{-1}}$$                                                                                                                                   | $$E=R_{\text{vec}\hat H}-GR_{\text{vec}\hat H}^*P_\otimes^*(GP_\otimes R_{\text{vec}\hat H}P_\otimes^*+N_0I)^{-1}P_\otimes R_{\text{vec}\hat H}$$<br>if IID<br>$$E=I-GP_\otimes^*(GP_\otimes P_\otimes^*+N_0I)^{-1}P_\otimes$$ |


**Frequency Flat SISO Channel:**
ML:
$$MMSE=\frac1{N_pSNR}$$
LMMSE:
$$MMSE=\frac1{1+N_pSNR}$$
**IID MIMO Channel:**
$$MMSE=\frac1{1+\frac{SNR}{N_t}}$$


(!exam)
Additionally measure $h_f[k]$ by estimating in frequency witm LS or LMMMSE, then do IDFT and the first $L$ samples are the $L$ taps, the remaining can be used to estimate noise. When you truncate $\hat h_t[n]$ at $L$ and do DFT of $h_t[n]$ and get a better estimate of h in frequency.
## 3.8) Additional Exercises
$$ $$
>[!example|2.15, 2.16] Two Tap Channel ZF Equalizer 
>For a two tap channel where $\sqrt Gh[0]=1, \sqrt Gh[1]=-a$ find an IIR equalizer with $\Delta=1$.
>
>First find transform of $h[n]=\delta(n)-a\delta(n-1)\zeta 1-az^{-1}$
>therefore we have:
>$$w(z)=\frac1{\sqrt G}\frac{z^-1}{1-az^{-1}}\zeta^{-1}w[l]=\frac1{\sqrt G}a^{l-1}u[l-1]$$
>Where an appropriate FIR equalizer can be found by truncating.

>[!example| 2.22, 2.23] Simple OFDM Exercises
>Let $T_{OFDM}=3.2\mu s$ with $K=256=2^8$  subcarriers and a cyclic prefix of length $L=64=2^6$. Find the chip period $T$, the passband bandwidth, the subcarrier spacing, and the guard interval of the cyclic prefix.
>
>Recall $T_{OFDM}=(K+L)T\rightarrow T=10ns\rightarrow B=1/T=100Mhz$
>The spacing is $1/KT=390.6 KHz$ and the guard interval is $LT=0.64\mu s$. **Impulse response of this duration or less can be handled.**
>
>Now let the subcarrier spacing be $15 kHz$ and every 5 MHZ of bandwidth accomodates $K=300$ subcarriers. What is the spectral efficiency penalty?
>$$P_{min}=\frac{B_{final}}{B_{tot}}=\frac{K\cdot15\cdot10^3}{5\cdot10^6}=0.9$$
>The real penalty also includes the guard interval so 
>$$P=P_{min}\frac{K}{K+L}$$


>[!example|2.24] Least Squares Estimatior For a Frequency Flat SISO Channel
>For a SISO system with frequency flat ($L=0$) channel estimate the channel and the MMSE with a single pilot $p=e^{j\phi}$.
>
>The single pilot, SISO and frequency flat case transforms the problem into a simple 1D case. In fact $P=p$ and $H=h$ from here also $P_\otimes=p$
>Recall the solution of the least squares problem:
>$$\text{vec}[\hat H]=\frac1{\sqrt G}(P_\otimes^*P_\otimes)^{-1}P_\otimes^* y$$
>First calculate $P_\otimes^*P_\otimes=E_s$, then the full matrix multiplications become $\frac{\sqrt{E_s}}{E_s}e^{-j\phi}=\frac{e^{-j\phi}}{\sqrt E_s}$.
>Then
>$$\hat h=\frac{e^{-j\phi}}{\sqrt{ G E_s}}y$$
>Same for the MMSE:
>$$E=\frac{N_0}G (P_\otimes^*P_\otimes)^{-1}\rightarrow MMSE=\frac{N_0}{GE_s}=\frac1{SNR}$$
>**Also in the case $N_p>1$ the MMSE becomes** $$\boxed{MMSE=\frac1{N_p SNR}}$$

>[!example|2.29] LMMSE Estimator For a Frequency Flat SISO Channel
>As before $L=0$, SISO and with one pilot, then recall
>$$W_{MMSE}=\sqrt GP_\otimes(N_0R_{\text{vec}\hat H}^{-1}+GP_\otimes^*P_\otimes)^{-1}$$
>Which in the 1d case becomes:
>$$W_{MMSE}=\frac{\sqrt {GE_S}}{N_0+GE_s}e^{j\phi}=\frac{\sqrt {GE_S}/N_0}{1+GE_s/N_0}\frac{\sqrt {GE_S}}{\sqrt {GE_S}}e^{j\phi}=\frac{SNR}{1+SNR}\frac{e^{j\phi}}{\sqrt{GE_S}}$$
>then $\text{vec} \hat H=W_{MMSE}^*y$ means that
>$$\hat h=\frac{SNR}{1+SNR}\frac{e^{j\phi}}{\sqrt{GE_S}}y$$
>The MMSE then becomes, $E=R_{\text{vec}\hat H}-GR_{\text{vec}\hat H}^*P_\otimes^*(GP_\otimes R_{\text{vec}\hat H}P_\otimes^*+N_0I)^{-1}P_\otimes R_{\text{vec}\hat H}$ and in 1d (works for $N_p\geq 1$)
>$$\boxed{MMSE=1-GE_S(GE_s+N_0)^{-1}=\frac1{1+N_pSNR}}$$
>Which is **alwasy smaller than the least squares case**
>

**LMMSE ESTIMATION COINCIDES WITH LEAST SQUARES IN IID MIMO**

if $P_\otimes$ Is unitary, then $P_\otimes P_\otimes^*=\frac{E_s}{N_t}I$ and thus
$$\begin{align}
E&=I-GP_\otimes^*(GP_\otimes P_\otimes^*)^{-1}P_\otimes=I-GP_\otimes^*\par{\frac{GE_S}{N_t}+N_0}^{-1}IP_\otimes\\
&=I-GP_\otimes^*P_\otimes\par{\frac{GE_S}{N_t}\par{1+\frac{N_t}{SNR}}}^{-1}\\
&=I-\frac{GE_S}{N_t}\frac1{\frac{GE_S}{N_t}\par{1+\frac{N_t}{SNR}}}I\\
&=\frac1{1+\frac{SNR}{N_t}}I
\end{align}$$
# 4) Chapter 3: Channel Modeling
#### **Large Scale:**
**Link Budget**
$$\begin{align}
\text{Log Scale: }&P_r[dB]=P_t[dB]+\underbrace{G_t[dB]+G_r[dB]-\par{L_p[dB]+\chi[dB]}}_{\text{large scale gain } G}\\
\text{Linear Scale: }&P_r=P_t\cdot \frac{G_tG_r}{L_p\chi}
\end{align}$$
**Path Loss**
$$L_P(D)=K_{ref}\par{\frac{D}{D_{ref}}}^\eta\rightarrow L_p(D)[dB]=K_{ref}[dB]+10\eta\logt\par{\frac{D}{D_{ref}}}$$
**Free Space Path Loss**
$$L_P(D)[dB]=20\logt\par{\frac{4\pi D}{\lambda_c}}$$
**Fading $\chi$**
$$f_\chi(\xi)=\frac{1}{\sqrt{2\pi}\sigma\xi}\exp{-\frac{(\log_e\xi)^2}{2\sigma^2}}\stackrel{dB}\rightarrow f_\chi(\xi)=\frac{1}{\sqrt{2\pi}\sigma_{dB}}\exp{-\frac{\xi^2}{2\sigma^2_{dB}}}$$
#### **Small Scale:**
With sinusoid signals:
$$c(\tau)=\sum_q A_qe^{-j2\pi f_c\tau_q}\delta (\tau)$$
Proof:
If $\max_q \tau_q\gg 1/B$ the delays act as a phase shift:
$$x(t)=e^{j2\pi f_c t}\stackrel{channel}\longrightarrow y(t)=\sum_qA_qe^{j2\pi f_c(t-\tau_q)}=\sum_qA_qe^{-j2\pi f_c\tau_q}x(t)$$$$\endproof$$
Model the small-scale channel response as a locally stationary complex rv $h=|h|e^{j\angle h}\sim\complexgauss(0,1)$, then the channel has these 3 properties:
- Uniform Phase: $\phi=\angle h\sim U(0,2\pi)$
- Rayleigh Magnitude: $f_{|h|}(\xi)=\xi\displaystyle e^{-\frac12\xi^2}$
- Exponential magnitude squared: $f_{|h|^2}(\xi)=e^{-\xi}$

If the multi path components dominate over the LoS, then rice fading can be used:
$$f_{|h|}(\xi)=2(K+1)\xi e^{-(K+1)\xi^2-K}I_0\par{2\sqrt{K(K+1)}\xi}$$
where 
- $K=0:$ rice equals Rayleigh
- $K\rightarrow\infty:$ rice is deterministic

#### **Space Selectivity (Power Angle Spectrum):**
The PAS works with the **azimuth** angle and describes the Rx power as a function of the angle. 

By integrating the PAS in the angle the total received power is obtained.
#### **Space Correlation**
Again, supposing $x$ a complex exponential being received at a given location
$$\begin{align}
y(t)&=\sqrt G\int_{2\pi}\sqrt {\mathcal P(\theta)G_r(\theta)}x(t-D(\theta)/C)d\theta\\
\\
y&=\sqrt G\int_{2\pi}\sqrt {\mathcal P(\theta)G_r(\theta)}xe^{-j\phi(\theta)}d\theta
\end{align}$$
Where $\phi(\theta)=2\pi D(\theta)/\lambda_c$
At a second location distanced $\Delta_d$ from the first one we have that $\phi'(\theta)=\phi(\theta)+2\pi\Delta_d\cos(\theta)/\lambda_c$
#### **Time Correlation**
Let the **maximum doppler shift be**
$$\nu_M=\frac vcf_c$$
and the **doppler shift**
$$\nu=\nu_M\cos(\theta)$$
The previous result can be seen as a signal sent while moving, so by integrating over the max doppler shift we end up with the fourier transform


|                                                         | General                                                                                                                                                     | Clarke-Jakes                                                                          |
| ------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| Space Selectivity: PAS                                  | $$\mathcal P(\theta)$$                                                                                                                                      | $$\mathcal P(\theta)=\frac1{2\pi}$$                                                   |
| Space Correlation: phase $\phi(\theta)\sim U[-\pi,\pi]$ | $$R_h(\Delta_d)=\E[h_0h_1^*]=\int_{-\pi}^{\pi}\mathcal{P}Ge^{j2\pi\Delta_d\cos(\theta)\lambda_c}d\theta$$                                                   | $$R_h(\Delta_d)=J_0(2\pi\Delta_d/\lambda_c)$$<br>$$D_c=0.38\lambda_c$$                |
| Time Correlation: Time and Frequency                    | $$R_h(\Delta_t=\Delta_d/v)$$$$S_h(\nu)=\frac{\mathcal P(-\arccos(\nu/\nu_M))+\mathcal P\arccos(\nu/\nu_M))}{\sqrt{\nu_M^2-\nu_M}}, \ \nu\in[-\nu_m,\nu_m]$$ | $$R_h(\Delta_t)=J_0(2\pi\nu_M\Delta_t)$$$$ S_h(\nu)=\frac1{\pi\sqrt{\nu_M^2-\nu_M}}$$ |

#### **Discrete Time Model**
In this case
$$R_h(lT)\qquad \frac1TS_h(\frac\nu T)$$


In the block fading model the number of single carrier symbols per block is
$$N_c=\frac{T_c}T=BT_c\stackrel{\text{IID Blocks}}\longrightarrow \frac1{2\nu_m T}$$
Moreover in OFDM we have that
$$N_c=\frac K{K+L}T_cB_c\approx T_cB_c$$
#### **Coherence Time**
The coherence time is the measure of the time duration over which the wireless channel is considered "static" or constant.
$$T_c\gg T_s\quad T_c=\frac1{2\nu_M}\propto\frac1{\nu_M}, \quad\nu_m\ll B$$

#### **Frequency Selective**
$$ $$
$$\max_{i,j}|\tau_i(t)-\tau_j(t)|=\tau_m\def\text{Delay Spread}$$
$$\begin{align}\boxed{\text{Frequency Flat iff: }\tau_m\ll T_s\iff T_d\ll T_s\iff B_c\gg B}\\\implies\tau_i(t)\approx\tau_j(t)\approx\hat\tau \ \forall i,j\rightarrow h(\tau)=h\delta(\tau)\end{align}$$
Here **gain is constant across frequency and the estimation of g(t) suffices to compensate for phase and amplitude displacements**

The **received power as a function of delay (normalized)** is called **Power Delay profile (PDP)** and can be interpreted as a PDF.
$$S_h(\tau)=\E[|h(\tau)|^2]$$
It has the following mean and variance:
$$\begin{align}
&\mu_\tau=\int\tau S_h(\tau)d\tau&\longrightarrow&\sum_{q=0}^{Q-1}\tau_qP_q&\\
&\sigma^2_\tau=T_d=\sqrt{\int(\tau-\mu_\tau)^2s_h(\tau)d\tau}&\longrightarrow&\sqrt{\sum_{q=0}^{Q-1}(\tau_q-\mu_q)^2P_q}
\end{align}$$
**If the symbols are uncorrelated, then the fourier transform of the PDP is he frequency domain correlation $R_h(\Delta_f)$ (depends only on $\Delta_f$, wide sense stationary)**
$$R_h(\Delta_f)=\int S_h(\tau)e^{j2\pi \Delta_f\tau}d\tau$$
if $\E[h(\tau_0)h(\tau_1)]=0$ uncorrelated scattering
And from here we have that 
$$B_c\propto\frac1{T_d}$$
Moreover wireless fading is **underspread:**
$$T_d\ll T_c, \ \nu_M\ll B_c\rightarrow B_cT_c\gg1$$

## 4.2) Additional Exercises
$$ $$

>[!example|3.13] Clarke-Jakes PAS Coherence Time and Distance
>Let $f_c=2$ GHz and and a velocity $v=5$ km/h, we have:
>$$\lambda_c=\frac c{f_c}=15\text{ cm}\rightarrow D_c=5.7 \text{ cm}$$
>And the coherence time is (recall m/s =$3.6\cdot$km/h)
>$$T_c=\frac1{2\nu_m}=\frac1{2\frac{v}{c}f_c}=41 \text{ ms}=\frac{D_c}{0.76\cdot v}\approx\frac{D_c}{v}$$

>[!example|3.23] Continuous PDP distribution Calculation
>Let the PDP be 
>$$S_h(\tau)=K_e\exp{-4\cdot10^{5}\tau}, \tau\in[0,10]\mu s$$
>First set $K_e$ so to normalize the PDP:
>$$1=\int_0^{10\cdot 10^{-6}} S_h(\tau)d\tau\approx 2.45\cdot10^{-6}K_e\rightarrow K_e=4.08\cdot 10^5$$
>The mean is:
>$$\begin{align}\mu_\tau=&\int_0^{10}\tau K_e\exp{-4\cdot10^{5}\tau}d\tau=K_e\sq{-\frac{e^{-4\cdot10^{5}\tau}}{4\cdot10^{5}}(\tau+\frac1{4\cdot10^{5}})}|_0^{10}\\ &\approx 5.68\cdot10^{-12} K_e=2.31\mu s
\end{align}$$
>And the RMS delay spread can be calculated in closed form but just the result is shown:
>$$T_d\approx2.08\mu s$$
>This means that a symbol time $T\gg$ 2.08 $\mu s$ is required for a frequency flat approximation.
>$$B_c\approx \frac1{T_d}=480 kHz$$
>and therefore supposing we want at least 1000 symbols as the underspread at 2 $GHz$, it is possible to go as fast as
>$$B_cT_c=\frac{B_c}{2\nu_M}=1000\rightarrow \nu_m=\frac{f_c v}{c}=\frac{B_c}{2000}\rightarrow v=\frac{cB_c}{2000 f_c}=36 \ m/s=130 \ km/h$$

