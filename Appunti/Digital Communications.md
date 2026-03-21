Trace ($\tr()$)
- The trace of a scalar is the scalar itself: $a=\tr (a)$
- Let $ABC$ be a matrix moltiplication that results in a scalar, then $ABC=\tr(ABC)$
- **Cyclic property:** $\tr(ABC)=\tr(BCA)=\tr(CAB)$
- **Linearity:** $\tr(A+B)=\tr(A)+\tr(B)$
- Trace and expected value are interchangeable $\mathbb E[ABC]=\mathbb E[\tr(ABC)]=\tr(\mathbb E[ABC])$

Complex Gaussian Distribution ($\complexgauss$)
- $\displaystyle x\sim\complexgauss(\mu,\sigma^2)\longrightarrow f_x(x)=\frac1{\pi\sigma^2}\exp{\frac{-|x-\mu|^2}{\sigma^2}}$ for scalars $h(x)=\log_2(\pi e \sigma^2)$
- $\displaystyle x\sim\complexgauss(\mu,R)\longrightarrow\frac1{\det(\pi R)}\exp{-(x-\mu)^*R^{-1}(x-\mu)}$ for vectors $h(x)=\log_2(\pi e R)$
# 1) A primer on information theory and MMSE estimation
## 1.1) Information Content
Information is defined as
$$i(A)=\log_2\par{\frac{1}{P[A]}}[bit]$$
Given a discrete r.v. with alphabet $\mathcal{A}_x=\{a_1,...,a_M\}$ it is possible to describe a **information function** 
$$i_x:\mathcal{A}_x\rightarrow\mathbb{R}, \ i_x(a)=i(x=a)=\log_2\frac{1}{p_x(a)}$$
#### Entropy
From here we can first define the entropy:
>[!def] Entropy
>Let $x$ be a discrete RV with PMF $p_x(\cdot)$. It's entropy is defined as
>$$H(x)=-\sum_xp_x(x)\log_2 p_x(x)=-\mathbb E[\log_2p_x(x)]$$
>Since we will be dealing with MIMO we can represent a vector of PMF as $\mathbf x$ and the **joint entropy** is
>$$H(\mathbf x)=-\mathbb E[\log_2p_\mathbf x(\mathbf x)]$$
>where $p_\mathbf x$ is the joint PMF of $x_i$ RVs.

This value quantifies the uncertainty associated with $x$, that is, the larger the entropy, the more unpredictable.

>[!thm] Entropy Properties
>- $H\geq 0$ is non negative. It is zero when $x$ is deterministic
>- The PMF that maximizes $H$ is the uniform distribution
>- A shifted rv has the same entropy: $H(x+c)=H(x)$ with $c\in \mathbb C$
>- $H(x|y)\leq H(x)$
>- Let $x$ have cardinality $M$, then $H(x)\leq \log_2 M$
>- Let $x_i$ be independent, then $H(\mathbf x)=\sum_i H(x_i)$

Moreover we can also define the **conditional entropy**
$$H(x|y)=-\sum_x\sum_yp_{xy}(x,y)\log_2p_{x|y}(x|y)$$
if $x$ is deterministic of $y$ this yields 0.
This is related to the joint entropy as 
$$H(x,y)=H(x)+H(y|x)$$
and in the general sense (**chain rule**)
$$H(x_0,...,x_{N-1})=H(\mathbf x)=\sum_{n=0}^{N-1}H(x_n|x_0,..,x_{n-1})=\sum_{n=0}^{N-1}H(x_n|\mathbf x)$$
Another quantity can be defined. This is **devoid of operational meaning**.
>[!def] Differential Entropy
>Let $f_x(\cdot)$ be the PDF of $x$, its differential entropy is
>$$h(x)=-\int_{\text{support of x}} f_x(x)\log_2 f(x)dx=-\mathbb E[\log_2 f_x(x)]$$

>[!rmk|*] Differential Entropy Can Be Negative
>The differential entropy can be negative.
>Proof (example 1.4):
>Let $x\sim U[0,b]$, then
>$$h(x)=-\int_0^b\frac1b\log_2\frac1bdx=(\frac1b\log_2\frac1b)|_0^b=\log_2b$$
>which is clearly negative if $b<1$

TODO Entropy Rate

>[!def] Relative Entropy
>Consider two PMFs $p(\cdot).q(\cdot)$.If $q(\cdot)\not=0\in\text{support of }p(\cdot)$, the their relative entropy is
>$$D(p||q)=\sum_xp(x)\log_2\frac{p(x)}{q(x)}=\mathbb E\sq{\log_2\frac{p(x)}{q(x)}}$$
>Note that his is not symmetric $D(q||p)\not = D(p||q)$. This is interpreted as a similarity measure between q and p, and it is 0 iff $p=q\ \forall x$.
>Moreover for PDFs:
>$$D(f||g)=\int f(x)\log_2\frac{f(x)}{g(x)}dx$$

##### Examples
First an example on entropy:
>[!example|1.2/1.3] Entropy of bernoulli and M equiprobable points 
Here are some examples:
> 1) Let $x$ be bernoulli, that is:
$$x=\begin{cases} 0 &\text{ with probability }p\\1 &\text{ with probability }1-p\end{cases}$$
>The entropy is therefore
$$H(x)=-p\log_2 p-(1-p)\log_2 (1-p)$$
And clearly it this is maximized when $p=1/2$.
>
> 2) M equiprobable points, that is $x\sim U[1/M]$
The entropy is $$H(x)=-\sum_{m=0}^{M-1}\frac 1M\log_2\frac1M=-\log_2\frac 1M=\log_2 M$$

Now a fundamental result for differential entropy:
>[!example|1.5/1.6] Differential Entropy of complex Gaussian vector/scalar
>Let $x\sim\complexgauss (\mathbf\mu, \mathbf R)$, then
>$$\begin{align}
h(x)&=-\mathbb E[\log_2 f_x(x)]=-\mathbb E\sq{\log_2\frac1{\det(\pi R)}\exp{-(x-\mu)^*R^{-1}(x-\mu)}}\\
&=\underbrace{\log_2\det(\pi R)}_a+\mathbb E[(x-\mu)^*R^{-1}(x-\mu)]\log_2e\\
&=a+\tr(\mathbb E[R^{-1}(x-\mu)(x-\mu)^*])\log_2e\\
&=a+\tr(R^{-1}\mathbb E[(x-\mu)(x-\mu)^*])\log_2e\\
&=a+\tr(I)\log_2e\\
&\boxed{h(x)=\log_2\det(\pi e R)}
\end{align}$$
>This is a bit cumbersome, so let's go step by step:
>- The first two lines just state the problem, and use known identities and properties
>- The third line uses three tricks: the trace of a scalar ($\mathbb E$) is equal to it's trace. I recalled that $\log_2 e^x=x\log_2e$. Moreover notice that $(x-\mu)^*R^{-1}(x-\mu)$ is a scalar, so by using the properties of trace (cyclic and $E[\tr(A)]=\tr(E[A])$)
>- In the fourth line I just moved $R^{-1}$ outside of $\mathbb E$
>- In the fifth lune I have that $\mathbb E[\cdot]=R$ and thus $R^{-1}R=I$
>- Finally recall that $\exp{\tr(A)}=\det(\exp A)$ and that $\tr(I)=n$, then: $\tr(I)\log_2e=n\log_2 e=log_2 e^n=\log_2 e^{tr(I)}=\log_2\det(\tr(e^I))$ and then recall $e^I=eI$ so finally $a+\log_2\det(eI)=\log_2\det(\pi ReI)=\log_2\det(\pi e R)$
>
>Now for the gaussian scalar:
>Let $x\sim \complexgauss(\mu,\sigma^2)$ we have
>$$\begin{align}
h(x)=\mathbb E\sq{\frac{|x-\mu|^2}{\sigma^2}\log_2e+\log_2(\pi\sigma^2)}=\log_2\pi e \sigma^2
\end{align}$$
>This is more straight-forward as:
>$\mathbb E\sq{|x-\mu|^2}=\sigma^2$ and thus the first term equals to $\log_2e$ and the second just $\log_2\pi \sigma^2$ and thus it is easily proven.

Finally, a more mathematical concept that relates (or actually shows no relation) between entropy and discrete entropy:
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

^98221d
#### Mutual Information
$$ $$
>[!def] Mutual Information
>The mutual information between two RVs is the reduction in uncertainty about s once y is known and vice versa.
>$$\begin{align}I(s;y)&=H(s)-H(s|y)\\
&=H(y)-H(y|x)
\end{align}$$
>Or also the relative entropy of joint PMF and the marginals
>$$\begin{align}I(s;y)&=D(p_{sy}||p_sp_y)\\
&=\sum_x\sum_yp_{sy}(s,y)\log_2\frac{p_{sy}(s,y)}{p_s(s)p_y(y)}\\
&=\sum_x\sum_yp_{sy}(s,y)\log_2\frac{p_{y|s}(y|s)}{p_y(y)}
\end{align}$$
>In the continuous case the same holds
>$$\begin{align}I(s;y)&=h(s)-h(s|y)\\
&=h(y)-h(y|x)\\
&=D(f_{sy}||f_sf_y)
\end{align}$$
And it also expands to vectors (just replace $s,y$ with $\mathbf{s},\mathbf{y}$)

In contrast with differential entropies, $I(s,y)$ can be obtained by the limit of discretized version of $s,y$, albeit the differential entropies diverge, their difference is still well behaved.

Moreover the mutual information satisfies the **chain rule:**
$$I(x_0,...,x_{N-1};y)=\sum_{n=0}^{N-1}I(x_n;y|x_0,...,x_{N-1})$$
#### Examples
From the definition, we can show all equivalencies
>[!exercise|*] Some equivalencies proved
>Show that $H(s)-H(s|y)=H(y)-H(y|x)$.
>Recall that $H(s|y)=H(s,y)-H(y)$ and $H(s,y)=H(y,s)$. Rewrite
>$$H(s)-H(s|y)=H(s)+H(y)-H(s,y)=H(y)-H(y|s)$$
>$\endproof$
>Now show $H(s)-H(s|y)=D(p_{sy}||p_sp_y)$
>Recall that $H(s|y)=-\sum_s\sum_y p(s,y)\log_2\frac{p(s,y)}{p(s)p(y)}$ by definition and that
Recall that the sum of the joint PMF over one is the marginal of the other: $\sum_y p(s,y)=p(s)$ and we can rewrite
$$H(s)=-\sum_sp(s)\log_2p(s)=-\sum_s\par{\sum_yp(s,y)}\log_2(p(s)=-\sum_s\sum_yp(s,y)\log_2p(s)$$
>Now rewrite 
>$$H(s)-H(s|y)=\sum_s\sum_yp(s,y)\sq{\log_2p(s|y)-\log_2p(s)}=-\sum_{s,y}p(s,y)\log_2\frac{p(s,y)}{p(s)p(y)}$$
>Where in the last step we noticed $p(s|y)=p(s,y)/p(y)$
>$\endproof$

Now, let's continue with the discretization example:
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

Finally, another key result is the gaussian mutual information

>[!example|1.7] Gaussian Mutual Information for a Complex Scalar
>Let $y=\sqrt\rho s+z$ with $s,z\sim\complexgauss(0,1)$ independent. Notice $y\sim\complexgauss(0,1+\rho)$ and $y|s\sim\complexgauss (\sqrt\rho s,1)$ we have
>$$\begin{align}
I(\rho)&=I(s;\sqrt\rho s+z)=h(\sqrt\rho s+z)-h(\sqrt\rho s+z|s)\\
&=\log_2(\pi e(1+\rho))-h(z)=\log_2(\pi e(1+\rho))-\log_2(\pi e)\\
&=\log_2(1+\rho)
\end{align}$$
> Why can we say this about $y$ and $y|s$
> - for $y$ it is a sum of two independent gaussians so $y\sim\complexgauss(0+0,(\sqrt\rho)^2+1)$
> - for $y|s$, since s is known, it is just a shift of $\sqrt\rho s$
> This can be read as: If z is the noise, then $\rho$ is the SNR and $I(\rho)$ is the mutual information of an AWGN signal

>[!example|1.13] Gaussian Mutual Information for a Complex Vector
>TODO
## 1.2) Reliable Communication
Let's start by explaining the communication link:
![[Pasted image 20251104120328.png|Basic Communication Link|400]]
- The encoder parses $N_b$ bits into messages. These bits are IID and bernoulli.
- Each message is a collection of $N_b$ bits and therefore there exist $2^{N_b}$ messages.
- Each message is mapped into $N$ unit power complex symbols $s[0],...,s[N-1]$
- Each symbol is then amplified $x[0],...,x[N-1]$
- The channel randomly modifies the signal. The **channel is known** if the conditional probability $f_{y|x}$ ($f_{y[0],...y[N-1]|x[0,...,x[N-1]]}$) is known. Since the power amplification is known, this directly allows to find $f_{y|s}$.
- The decoder maps the observed values to the correct (ideally) codeword

>[!rmk|*]
>Notice how $N_b\not=N$. $N_b$ is the number of bits to transmit, while $N$ the number of codewords (symbols). 

Although we are in discrete time, and signals are continuous in time, this approximation is valid due to shannon's sampling theorem. Moreover the bits to transmit are IID and therefore already underwent necessary redundency reductions.

For notation we introduce bold overlined symbols to denote **time-domain sequences**
$$\mathbf{\overline s}=\begin{bmatrix}
s[0]\\
...\\
s[N-1]\end{bmatrix}$$
(For obsidian notes I introduce the command \tds{})
$\ \newcommand{\tds}[1]{\mathbf{\overline{#1}}}$
$$\tds{input}$$
Therefore, with $N_b$ IID bits, $2^{N_b}$equiprobable codewords, the mutual information between input and output is:
$$\begin{align}
I(\tds s;\tds y)&=\mathbb E\sq{\log_2\frac{f_{\tds y|\tds s}(\tds y|\tds s)}{f_\tds y(\tds y)}}\\
&\stackrel{\text{bayes}}=\mathbf E\sq{\log_2\frac{f_{\tds y|\tds s}(\tds y|\tds s)}{\displaystyle\frac1{2^{N_b}}\sum_{m=0}^{2^{N_b}-1}f_{\tds y|\tds s}(\tds y|\overline s_m)}}
\end{align}$$
>[!def] Memoryless
>We call a channel memoryless, that is, if the output of symbol $n$ depends only of the input at symbol $n$, if the channel law factors as
>$$f_{\tds y|\tds s}(\cdot)=\prod_{n=0}^{N-1}I(s[n];y[n])$$
>Then, it is possible to have statistically independent codewords and entries and the mutual information becomes
>$$I(\tds s;\tds y)=\sum_{n=0}^{N-1}I(s[n];y[n])$$
>with
>$$I(s[n];y[n])=\mathbb E\sq{\log_2\frac{f_{y[n]|s[n]}(y[n]|s[n])}{f_{y[n]}(y[n])}}$$

If we add also stationary (time-invariant), then we can drop index $n$ and write
$$I(s;y)=\mathbb E\sq{\log_2\frac{f_{y|s}(y|s)}{f_y(y)}}=\mathbb E\sq{\log_2\frac{f_{y|s}(y|s)}{\sum_{m=0}^{M-1}f_{y|s}(y|s_m)p_m}}$$
Where it applies to an M-point constellation.

>[!example|1.16] Memoryless channel with AWGN
>We can write AWGN as 
>$$y[n]=\sqrt\rho s[n]+z[n]$$
>With $z[n_i]$ IID gaussian $z\sim \complexgauss(0,1)$.
>By conditioning on $y|s$ we can see $\sqrt\rho s[n]$ as a constant and thus $y|s\sim \complexgauss{\sqrt\rho s, 1}$
>By recalling that for a complex gaussian the PDF is
>$$f_z(z)=\frac{1}{\pi\sigma^2}e^{-|z-\mu|^2/\sigma^2}$$
>Then, the channel law is:
>$$f_{y|s}(y|s)=\frac 1\pi e^{-|y-\sqrt\rho s|^2}$$

## 1.3) Capacity
Capacity is the **maximum rate** at which information can be transmitted over a channel with **arbitrarily small error probability** if there exists an adeguate code, that is $p_e\rightarrow 0 \iff N\rightarrow\infty$. If this limit is exceeded, the error probability rises rapidly.

Therefore, since infinitely long signals aren't physically realizable we have that
$$\frac RB\leq C$$
where $R/B$ is the spectral efficiency $\par{\frac{bit/s}{Hz}}$.

>[!def] Capacity
>Shannon studied **stationary, ergodic and memoryless** channels, that is:
>$$C_{\text{stationary, ergodic, memoryless}}=\max I(s;y)$$
>By relaxing the memoryless condition
>$$C_{\text{ergodic, stationary}}=\max \lim_{N\rightarrow \infty}\frac1NI(\tds s; \tds y)$$
>This if the channel is information stable. And the symbols $s[n]$ are zero mean.

In an arbitrary channel we have the following probability to make an error:
$$p_e=\sum_{m=0}^{2^{N-b}-1}P[\hat w\not = m|w=m]P[w=m]\stackrel{\text{equiprobable}}=\frac1{2^{N_b}}\sum_{m=0}^{2^{N-b}-1}P[\hat w\not = m|w=m]$$
>[!def] Information Stable and Information Density
>The information density is the quantity whose expected value is the mutual information
>$$i(\tds s;\tds y)=\log_2\frac{f_{\tds s,\tds y}(\tds s, \tds y)}{f_{\tds s}(\tds s)f_{\tds y}(\tds y)}\rightarrow I(\tds s; \tds y)=\mathbb E[i(\tds s ;\tds y)]$$
>The channel is **information stable** if
>$$\begin{align}
\lim_{N\rightarrow\infty}\frac1Ni(\tds s; \tds y)&=\lim_{N\rightarrow\infty}\frac1N\mathbb E[i(\tds s;\tds y)]\\
&=\lim_{N\rightarrow\infty}\frac1N I(\tds s;\tds y)
\end{align}$$

This also shows that the information density doesn't deviate asymptotically from the mutual information.

## 1.4) Coding and Decoding
TODO

## 1.5) MMSE Estimation
Estimation refers to the study on how and with what accuracy one can infer the value sent by the one obtained.
We always referr to the AWGN model:
$$y=\sqrt \rho s+z$$
We have the following information available at the receiver side:
- Obtained $y$
- Posteriori probability $f_{s|y}(\cdot)$
- Likelihood function $f_{y|s}(\cdot)$
- Prior probability (sometimes) $f_s(\cdot)$
- Fidelity Criterion

The criterion of this chapter is the Minimum Mean Square Error (MMSE), which is the solution that minimizes $\mathbb E[|s-\hat s(y)|^2]$. 

>[!def] MMSE Estimator
>The MMSE estimator is 
>$$\hat s(y)=\mathbb E[s|y]$$
>So the **coditional mean estimator** is
>$$MMSE(\rho)=\mathbb E\sq{(s-|\mathbb E[s|y]|)^2}$$ 

The MMSE is unbiased (over all randomness) since $\mathbb E[\hat s(y)]=\mathbb E[\mathbb E[s|y]]=\mathbb E[s]$. A quick proof is provided
$$\mathbb E[\mathbb E [s|y]]=\int\par{\int s\cdot p(s|y)ds}p(y)dy=\int s\par{\int p(s|y)p(y)dy}ds=\int s\cdot p(s)ds=\mathbb E[s]$$
But it is biased (for individual realizations $|s$) as it might be that $E[\hat s(\sqrt\rho s+z)|s]\not = s$.

The MMSE can also be generalized to vectors, in fact:
>[!def] MMSE Estimator for Vectors
>Let 
>$$\mathbf y=\sqrt\rho\mathbf A\mathbf s+\mathbf z$$
>Where A is fixed, s and z are independent and $z\sim\complexgauss(0,\mathbf R)$, then **the conditional mean estimator is**
>$$\mathbf{\hat s(y)}=\mathbb E[\mathbf s|\mathbf y]$$
>and the MMSE is
>$$\mathbf E=\mathbb E\sq{(s-\hat s(y))(s-\hat s(y))^*}$$
>which is the covariance matrix and the $j$-th diagonal gives the error associated with estimator $j$-th entry of s.

#### Examples
The following two examples will show the bias of MMSE in individual realizations
>[!example|1.27] MMSE of Complex Gaussian Scalar
> Let $y=\sqrt\rho s +z$ and $s\sim\complexgauss(0,1)$, then by definition:
> $$f_s(s)=\frac1\pi e^{-|s|^2}$$
> Moreover recall that $y|s\sim\complexgauss(\sqrt\rho s,1)$ and thus 
> $$f_{y|s}(y|s)=\frac1\pi e^{-|y-\sqrt\rho s|^2}$$
> Now find the MMSE estimator $\hat s$:
> $$\begin{align}
\hat s(y)=\mathbb E[s|y]&=\int sf_{s|y}(s|y)ds=\int \frac{sf_{y|s}(y|s)f_s(s)}{f_y(y)}ds=\frac{\int s f_{y|s}(y|s)f_s(s)ds}{f_y(y)}\\
&=\frac{\int sf_{y|s}(y|s)f_s(s)ds}{\int f_{y|s}(s) f_s(s) ds}=\boxed{\frac{\int se^{-|y-\sqrt\rho s|^2}f_s(s)ds}{\int e^{-|y-\sqrt\rho s|^2}f_s(s)ds}}\\
&=\frac{\int se^{-|y-\sqrt\rho s|^2}e^{-|s|^2}ds}{\int e^{-|y-\sqrt\rho s|^2}e^{-|s|^2}ds}\\
\end{align}$$
>This is a bit cumbersome, let's see:
>- In the first line we applied the definition, then Bayes, and then we recognized that $f_y(y)$ does not depend on $s$.
>- The second line used the marginal definition for $f_y(y)$ and then used the know equation fo $f_{y|s}(y|s)$
>- The third was obtained by using $f_s(s)$ of this specific problem.
>
>Now look at the exponent (ignore -1 multiplier):
$$|y-\sqrt\rho s|^2-|s|^2=|y|^2+(1-\rho)|s|^2-\sqrt\rho(y^*s+ys^*)$$
This can be rewritten as
$$\frac{|y|^2}{1+\rho}+\left|\sqrt{1+\rho}s-\sqrt\frac{\rho}{1+\rho}y\right|^2$$
Since the first term ($\exp{|y|^2/1+\rho}$) is not dependent on s it can be moved out of both integrals and simplified, moreover the square can collect $\sqrt{1+\rho}$ and become
$$(1+\rho)\left|s-\frac{\sqrt\rho}{1+\rho}y\right|^2=\left|s-\frac{\sqrt\rho}{1+\rho}y\right|^2\frac1{\frac1{1+\rho}}$$
Now multiply both sides by $1/\pi(1/(1+\rho$)) and therefore the exponents become
$$\frac1{\pi\par{\frac1{1+\rho}}}e^{\displaystyle\frac{-|s-\frac{\sqrt\rho}{1+\rho}y|^2}{1/1+\rho}}$$
which is the PDF of $s|y\sim\displaystyle\complexgauss(\frac{\sqrt\rho}{1+\rho}y, \frac1{1+\rho})$.
>Therefore
>$$\frac{\int se^{-|y-\sqrt\rho s|^2}e^{-|s|^2}ds}{\int e^{-|y-\sqrt\rho s|^2}e^{-|s|^2}ds}=\frac{\int sf_{s|y}(s|y)ds}{\int f_{s|y}(s|y)ds}$$
>The denominator is clearly 1 while the numerator is the expected value of $s|y$ and thus we have
>$$\hat s(y)=\frac{\sqrt\rho}{1+\rho}y$$
> Now 
> $$MMSE(\rho)=\mathbb E \sq{\left|s-\frac{\sqrt\rho}{1+\rho}y\right|^2}$$
> Compute the square
>  $$|s|^2+\frac{\rho}{(1+\rho)^2}|y|^2-(\frac{\sqrt\rho}{1+\rho})(s^*y+sy^*)=|s|^2+\frac{\rho}{(1+\rho)^2}|y|^2-2\frac{\sqrt\rho}{1+\rho}\Re[s^*y]$$
 >Where the constants can be taken out of the expectancy and 
 >- $\mathbb E [|s|^2]=1$
 >- $\mathbb E [|y|^2]=1+\rho$ since y is sum of two gaussian
 >- $\mathbb E[s^*y]=\sqrt \rho$ since $s^*y=s^*(\sqrt\rho s+z)=\sqrt\rho s^*s+s^*z$
>And now the expression simplifies to
$$MMSE(\rho)=1+\frac{\rho}{1+\rho}-2\frac{\rho}{1+\rho}=\frac1{1+\rho}$$

>[!example|1.28] Verify Bias of 1.27
>To see the bias, select a specific value of the distribution:
>$$\mathbb E[\hat s(y)|s=s]=\mathbb E\sq{\frac{\sqrt\rho}{1+\rho}(\sqrt\rho s+z)|s=s}$$
>So s becomes a constant and therefore
>$$\mathbb E\sq{\frac{\rho}{1+\rho}s+\frac{\sqrt\rho}{1+\rho}z}=\frac{\rho}{1+\rho}s=s-\frac1{1+\rho}s\not=s$$
>the bias is therefore $-\frac s{1+\rho}$

This example shows the MMSe for a complex gaussian vector:
>[!example|1.31] MMSE estimation of Complex Gaussian Vector TODO
>Let $s\sim\complexgauss(0,R)$ and $z\sim\complexgauss(0,I)$, with $Y=\sqrt\rho As+z$, then
>$$\hat s(y)=\sqrt\rho RA^*(I+\rho ARA^*)^{-1}y$$
>And it is possible to compute
>$$\mathbf E=(R^{-1}+\rho A^*A)^{-1}$$

#### I-MMSE Relationship
Consider again $y=\sqrt\rho s+z$ with s independent from $z\sim\complexgauss(0,1)$.
Recall $I(\rho)=I(s;\sqrt\rho s+z)$, then it's derivative has significance as
$$\frac1{\log_2e}\frac{d}{d\rho}I(\rho)=MMSE(\rho)$$
And also the integral form:
$$\frac1{\log_2 e}I(\rho)=\int_0^\rho MMSE(\xi)d\xi$$

This can be generalized to vectors
Let $\mathbf y=\sqrt\rho \mathbf{As}+\mathbf z$ with s independent from $\mathbf z\sim\complexgauss(0,I)$
$$\frac1{\log_2e}\nabla_AI(s;\sqrt\rho As+z)=\rho\mathbf{AE}$$

##### Examples
In fact consider this example
>[!example|1.32] I-MMSE for Complex Gaussian Scalar
>This is straight forward by recalling that for a complex gaussian scalar
>$$I(\rho)=\log_2(1+\rho)=\frac{\ln(1+\rho)}{\ln 2}\stackrel{d/d\rho}=\frac1{\ln 2}\frac1{1+\rho}$$
>By recalling that $\ln 2\cdot\log_2 e=1$ the I-MMSE holds.

And the following for vectors
>[!example|1.35] I-MMSE for Complex Gaussian Vector
>TODO

#### LMMSE Estimation
TODO

# 2) A Signal Processing Perspective

## 2.1) Passband Signals and Complex Baseband Equivalents
Let $x_p(t)$ be a passband signal centered at frequency $f_c$. Under **narrowband $B\ll f_c$** we have that
$$x_p(t)=A(t)\cos(2\pi f_c t+\phi(t))=\underbrace{A(t)\cos(\phi(t))}_{\sqrt2x_i(t)}\cos(2\pi f_ct)-\underbrace{A(t)\sin(\phi(t))}_{\sqrt 2 x_q(t)}\sin(2\pi f_ct)$$
![[Pasted image 20251129170734.png|Upconversion from Baseband to Passband|350]]
The complex baseband equivalent of $x_p$ is defined as $x(t)=x_i(t)+jx_q(t)$ where the $\sqrt 2$ factors are to ensure that $x(t)$ and $x_p(t)$ have the same power.
While the signal might be complex, the passband signal going to the antenna is real. The two have the following relation:
$$x_p(t)=\sqrt 2 \ \Re\curly{x(t)e^{j2\pi f_ct}}=\sqrt 2 \ (x_i(t)\cos(2\pi f_ct)-x_q(t)\sin(2\pi f_c t))$$
In frequency we have that
$$x_p(f)=\frac1{\sqrt 2}(x(f-f_c)+x^*(f+f_c))$$

This process is called **upconversion** and can be applied directly to a signal as seen in the image.

The **downconversion** is more cumbersome.
1) First the signal is changed due to the channel. $y_p(t)=(h*x)(t)+v(t)$ (AWGN)
2) The received channel is still passband, however a LP filter is applied to remove additional wrong bands. 
3) Being passband the output also allows for a complex baseband response
Downsampling is achieved by multiplying by either $\sqrt 2 \cos (2\pi f_c t)$ or $-\sqrt 2 \sin(2\pi f_c t)$ and a low pass filter  to recover $y_i$ and $y_q$ respectively.

Proof for $y_i$
$$\begin{gather}
y_p(t)=\sqrt 2(y_i(t)\cos(2\pi f_ct)-y_q\sin(2\pi f_c t))\\
y_p(t)\sqrt 2\cos(2\pi f_c t)=y_i(t)+y_i(t)\cos(4\pi f_c t)-y_q(t)\sin(4\pi f_c t)
\end{gather}$$
where an appropriate low pass can recover the signal as $B<f_c$.

![[Pasted image 20251129172956.png|Downconversion From Passband to Baseband|350]]

## 2.2) Channel Response & Time Discretization
First we assume that the channel is LTI. Let $c_p(\tau)$ be the channel response not bandlimited then
$$y_p(t)=(c_p*x_p)(t)=\int c_p(\tau)x_p(t-\tau)d\tau$$
While, to relate the baseband signals, $c_b(\tau)$ is used. 
How do we relate these two responses

To get $y_p$ we only consider the positive spectral content and we need to low pass it and center it at zero frequency to make it baseband

Define 
$$g_{B/2}(f)=rect(f/B)\qquad g_{B/2}(t)=Bsinc(B t)=B\frac{\sin(\pi Bt)}{\pi Bt}$$
then 
$$c_b(\tau)=g_{B/2}(\tau)*[c_p(\tau)e^{-2\pi f_c\tau}]=g_{B/2}(\tau)*c(\tau)$$
where $c(\tau)$ is the **complex pseudo-baseband** representation as it is downshifted but not band limited.

Now, let's find the discrete time equivalent response:
$$y[nT]=\sum_{l=-\infty}^\infty c[l]x[n-l]$$
Which was obtained by discretizing the linear convolution with a step size $T\leq 1/B$.
$$\begin{align}
y[nT]&=\int c_b(\tau)x(nT-\tau)d\tau\\
&\approx \sum_lc_b[lT]x[nT-lT]T\\
&=\sum_lTc_b[lT]x[n-l]
\end{align}$$
And it follows that $c[l]\approx Tc_b(lT)$
#### Examples
Here is an example showing how $c_b$ can be found:
>[!example|2.1, 2.2] Tapped Delay Line
>Consider a signal that propagates from a TX to a RX incurring a delay $\tau_0$ and experiencing a complex amplitude gain $A_0$. Determine $c_p(\tau)$ and $c_b(\tau)$.
>
>The channel impulse response $c_p$ is easily obtained:
>$$c_p(\tau)=A_0\delta(\tau-\tau_0)$$
>Now we apply directly the formula
>$$\begin{align}
c_b(\tau)&=g_{B/2}(\tau)*(A_0\delta(\tau-\tau_0)e^{-j2\pi f_c\tau})=g_{B/2}(\tau-\tau_0)A_0e^{-j2\pi f_c\tau_0}\\
&=A_0Bsinc(B(\tau-\tau_0))e^{-j2\pi f_c\tau_0}
\end{align}$$
>
>Suppose that now multiple paths are present with delays $\tau_i$ and gain $A_i$, then we have by linearity
>$$c_b(\tau)=\sum_iA_iBsinc(B(\tau-\tau_i))e^{-j2\pi f_c\tau_i}$$
>From this example we can find the general formula of the **tapped delay line**. 
$$c_p(\tau)=\sum_{q=0}^{Q-1}A_q\delta(\tau-\tau_q)$$
>Which becomes
$$c_p(\tau)=g_{B/2}(t)*\sum_{q=0}^{Q-1}A_q\delta(\tau-\tau_q)e^{-j2\pi f_c\tau_q}=\sum_{q=0}^{Q-1}A_qg_{B/2}(\tau-\tau_q)e^{-j2\pi f_c\tau_q}$$
>The received baseband signal is:
>$$\begin{align}
y(t)&=\int_{-\infty}^\infty\par{g_{B/2}*\sum_{q=0}^{Q-1}A_q\delta(\tau-\tau_q)e^{-j2\pi f_c\tau_q}}x(t-\tau)d\tau\\
&=\int_{-\infty}^\infty\par{\sum_{q=0}^{Q-1}A_q\delta(\tau-\tau_q)e^{-j2\pi f_c\tau_q}}x(t-\tau)d\tau\\
&=(c*x)(t)
\end{align}$$
>Where the term $g_{B/2}$ was removed since $x(t)$ is already band limited

>[!example|2.3, 2.4]
>Determine the discrete time complex baseband response for example 2.1 with $T=1/B$.
>$$c[l]=Tc_b[lT]=A_0BT\text{sinc}\par{BT l+B\tau_0}e^{-j2\pi f_c\tau_0}=A_0\text{sinc}\par{l+\frac{\tau_0}T}e^{-j2\pi f_c\tau_0}$$
>If the sampling time is synced to the delay, that is $\tau=lT+\tau_0$ we have
>$$c[l]=A_0\text{sinc}(l)e^{-j2\pi f_c\tau_0}=A_0\delta(l)e^{-j2\pi f_c\tau_0}$$
>Cleary, with multiple taps the signals would all have to be perfectly delayed with the same delay to avoid ISI. With isi the channel becomes frequency selective.
>$$c[l]=\sum_iA_i\sinc(l-\tau_i/T)e^{-j2\pi f_c\tau_i}=\sum_iA_i\sinc(l-(\tau_0-\tau_i)/T)e^{-j2\pi f_c\tau_i}$$

## 2.3) Pulse Shaping
In theory it is sufficient to construct the baseband transmit signal as
$$x(t)=\sum_nx[n]\sinc(\frac{t-nT}T)$$
where the sequence of symbols $\curly{x[n]}$ is linearly modulated into a shape of form $\sinc(t/T)$ transmitted at $1/T$ symbols/s. But sinc is not ideal and therefore we use
$$x(t)=\sum_nx[n]g_{tx}(t-nT)$$
and instead of $g_{B/2}$ we use $g_{rx}$ where finally we can define $g(\tau)=(g_{rx}*g_{tx})(\tau)$, where **most importantly** $g(lT)=\begin{cases}1 & l=0\\ 0 & l\not=0\end{cases}$ to avoid ISI.

## 2.4) Additive Noise & Energy And Power
TODO

The avg transmit power is
$$P_t=\frac1N\lim_{N\rightarrow\infty}\sum_{n=0}^{N-1}\mathbb E[|x[n]|^2] \ [W]$$
But the limit can be ignored.

The average transmit energy per symbol is $E_s=P_tT \ [J]$. In one period the noise has energy $N_0$ and if both sequences $x,v$ are scaled by $\sqrt T$ we have that
$$E_s=\frac1N\sum_{n=0}^{N-1}\mathbb E[|x[n]|^2]$$
By making $s[n]$ a unit variance (power) symbol, we have that 
$$x[n]=\sqrt{E_sP[n]}s[n]$$
 with $\frac 1N\sum P[n]=1$ to register variations.
## 2.5) Channel Normalization
Instead of using the baseband and pseudo-baseband representation we use:
$$\begin{align}
c(\tau)=\sqrt Gh(\tau)\\
c_b(\tau)=\sqrt Gh_b(\tau)\\
c[l]=\sqrt Gh[l]
\end{align}$$
where $G$ is the large scale gain.
Most importantly we have that $h[l]$ must satisfy $$\sum_l\mathbb E[|h[l]|^2]=1$$
then we have that
$$\begin{align}
P_r=GP_t=G\frac{E_s}T\\
SNR=\frac{P_r}{N_0/T}=\frac{GE_s}{N_0}
\end{align}$$
For a raised cosine the *only* the spectral efficiency ($R/B$) is penalized by a factor of $1/1+b$

## 2.6) Vector Representation
Recall the AWGN model obtained with the above results:
$$y[n]=\sqrt G\sum_{l=-\infty}^\infty h[l]x[n-l]+v[n]$$
where $x[n]=\sqrt{E_sP[n]}s[n]$
The **impulse response is approximated to a FIR** of length $L+1$, then we have
$$y[n]=\sqrt G\sum_{l=0}^L h[l]x[n-l]+v[n]$$
- If the channel has $L=0$ then $|h|=1$ and is multiplicative and therefore also frequency flat
- If the channel has $L>0$ then it is frequency selective and has ISI

In the case of $L>0$ instead of looking at one signal, we look at a block of L consecutive signals. In this case we can define the impulse response of the channel to be a **toeplitz matrix** of dimensions $N\times (N+L)$. 
$$\overline{\mathbf H}_{N.N+L}=\begin{bmatrix}
h[L] & ... & h[0] & 0 & 0& ... & 0\\
0 & h[L] & ... & h[0]& 0 & ... & 0\\
\vdots&&&\ddots&&&\vdots\\
0 &... & ... &0& h[L] & ... & h[0]
\end{bmatrix}$$
In order to do a linear convolution we need to collect $N$ values and $L$ past values of $x[n]$ into a vector
$$\overline{\mathbf x}_{N+L}=\begin{bmatrix}
x[-L]\\
\vdots\\
x[-1]\\
x[0]\\
\vdots\\
x[N-1]
\end{bmatrix}$$
In fact their product equals to the convolution (maybe do proof).
$$\overline{\mathbf y}_{N}=\sqrt G\ \overline{\mathbf H}_{N.N+L}\overline{\mathbf x}_{N+L}+\overline{\mathbf v}_{N}$$
The n-th row is equivalent to $y[n]$.

>[!rmk|*]
>Vectorized result makes an **equivalence between frequency-selective SISO channels and frequency-flat MIMO channel,** and may be useful for deriving estimators or equalizers
## 2.7) Extension to MIMO
This is how a generic MIMO system is made:
![[Pasted image 20251202182420.png|MIMO|450]]
There are $N_t$ TX antennas and $N_r$ RX antennas, each TX antenna sends to all RX antennas. We use $i$ to say what receiver and $j$ what transmitter. There is a different channel impulse response for each $(i,j)$ pair.

As a result of linearity we have that
$$y^{(i)}(t)=\sqrt G\sum_{j=0}^{N_t-1}\int_\R h^{(i,j)}(\tau)x^{(j)}(t-\tau)d\tau+v_b^{(i)}(t)$$
Which can be read as the sum of all TX antennas doing the convolution with the channel relative to the i-th receiver.

It is possible to rewrite all the $j$ TX signals, $i$ RX signals and noises and the $i\cdot j$ responses into matrix forms:
$$\begin{gather}
\vec x(t)=\begin{bmatrix}
x^{(0)}(t)\\
...\\
x^{(N_t-1)}(t)
\end{bmatrix}\\ \\
\vec y(t)=\begin{bmatrix}
y^{(0)}(t)\\ 
...\\
y^{(N_r-1)}(t)
\end{bmatrix}
\qquad
\vec v(t)=\begin{bmatrix}
v^{(0)}(t)\\
...\\
v^{(N_tr-1)}(t)
\end{bmatrix}\\ \\
\vec H(\tau)=\begin{bmatrix}
h^{(0,0)}(\tau) & h^{(0,1)}(\tau) & ... & h^{(0,N_t-1)}(\tau) \\
h^{(1,0)}(\tau) & h^{(1,1)}(\tau) & ... & h^{(1,N_t-1)}(\tau) \\
\vdots&\vdots&\ddots&\vdots\\
h^{(N_t-1,0)}(\tau) & h^{(N_t-1,1)}(\tau) & ... & h^{(N_t-1,N_t-1)}(\tau)
\end{bmatrix}
\end{gather}$$
Now the input-output relation becmes:
$$\vec y(t)=\sqrt G\int_\R\vec H(\tau)\vec x(t-\tau)d\tau+\vec v(t)$$
And in discrete time for a FIR filter and a frequency flat ($L=0$) we have respectively:
$$\vec y(t)=\sqrt G\sum_{l=0}^L\vec H[l]\vec x[n-l]+\vec v[n]\qquad \vec y(t)=\sqrt G \vec H\vec x[n-l]+\vec v[n]$$
#### MIMO Channel Normalization
The MIMO channel are normalized jointly over all entries, that is
$$\sum_{l=0}^L\sum_{i=0}^{N_r-1}\sum_{j=0}^{N_t-1}\mathbb E\big[|H[l]_{i,j}|^2\big]=N_rN_t$$
Where the two summations over $i$ and $j$ can be compactly formulated with the **Frobenius** norm:
$$\sum_{l=0}^L\mathbb E\big[ \|H[l]\|_F^2\big]=\sum_{l=0}^L\mathbb E[\tr(HH^*)]$$
#### Stacked Vector Representation
TODO

## 2.8) Precoding
Recall that a signal can be written as $x[n]=\sqrt{E_sP[n]}s[n]$ as long as $\frac1N \sum P[n]=1$. In a MIMO system this $P[n]$ is a matrix that:
- Reallocates power
- Add more data streams if the matrix is $N_t\times N_s$ 

Although it is called precoding, it is **placed before the modulator, after the channel coding.** 

We Denote the transformation matrix $F$ as a $N_t\times N_s$ matrix with normalization by $N_t$, that is:
$$\frac1N\sum_{n=0}^{N-1}\|F[n]\|_F^2=N_t$$
and therefore the signal can be rewritten as:
$$x[n]=\sqrt\frac{E_s}{N_t}F[n]s[n]$$
Then, the covariance becomes:
$$R_x[n]=\mathbb E[x[n]x^*[n]]=\frac{E_s}{N_t}F[n]F^*[n]$$
Proof:
$$R_x[n]=\mathbb E[x[n]x^*[n]]=\frac{E_s}{N_t}\mathbb E[F[n]s[n]s^*[n]F^*[n]]=\frac{E_s}{N_t}F[n]\mathbb E[s[n]s^*[n]]F^*[n]$$
Where $F[n]$ is not a RV and can be extracted from the expectation while $s[n]$ are IID and thus $s[n]s^*[n]=I$.

Moreover notice that **the avg tx power** is 
$$\mathbb E[|x[n]|^2]=\mathbb E [\tr(x[n]x^*[n])]=\tr(\mathbb E[R_x])=E_s$$
Using the **singular value decomposition** it is possible to rewrite this matrix as:
$$F[n]=U_F[n]\Sigma_F[n]V^*_F[n]$$
Where
- $U_F$ is unitary $N_t\times N_t$ and is called Beam Steering Matrix
- $\Sigma_F$ is the Power Allocator Matrix of size $N_t\times N_s$ matrix. and is of form $\begin{bmatrix} P^{1/2}\\0\end{bmatrix}$ Where $P^1/2$ is the square root of  the $N_s\times N_s$ matrix $P=\text{diag}(P_0,..,P_{N_s-1})$ satisfying $N_t$ normalization 
- $V_F$ the Mixing Matrix that allows for $V[n]s[n]$ to modify the distribution of $s[n]$ ut while keeping unit power the entries.

>[!example|2.10]
>Let $N_t=N_s=2$ and suppose a QPSK distribution, then:
>- $P=\text{diag}(P_0,P_1)$ and thus $\Sigma_F=[P^{1/2}]=\text{diag}(\sqrt{P_0},\sqrt{P_1})$
>- $U_F=\begin{bmatrix}U_{00} & U_{01}\\ U_{10} & U_{11}\end{bmatrix}$
>- $V_F=\begin{bmatrix}V_{00} & V_{01}\\ V_{10} & V_{11}\end{bmatrix}$
>
>Now notice that $V^*_F=\begin{bmatrix}V^*_{00} & V^*_{10}\\ V^*_{01} & V^*_{11}\end{bmatrix}$ and then, mixed to the signal vector $s$ we have
>$$V^*_Fs=\begin{bmatrix}V^*_{00} & V^*_{10}\\ V^*_{01} & V^*_{11}\end{bmatrix}\begin{bmatrix}s_0\\s_1\end{bmatrix}=\begin{bmatrix}V^*_{00}s_0+V^*_{10}s_1\\ V^*_{01}s_0+V^*_{11}s_1\end{bmatrix}$$
>Now allocate the power matrix and it becomes
>$$P^{\frac12}V^*_Fs=\begin{bmatrix}\sqrt{P_0}(V^*_{00}s_0+V^*_{10}s_1)\\ \sqrt{P_1}(V^*_{01}s_0+V^*_{11}s_1)\end{bmatrix}=\begin{bmatrix}\alpha \\ \beta \end{bmatrix}$$
>Now also the beam matrix:
>$$F\cdot s=U_FP^{1/2}V^*_Fs=\begin{bmatrix}
U_{00}\alpha+U_{01}\beta \\ U_{10}\alpha+U_{11}\beta
\end{bmatrix}$$
>And finally 
>$$x=\sqrt{\frac{E_s}{N_t}}F\cdot s$$
>The first signal $\alpha$ is TXed by both antennas, weighed by $U_{00}$ and $U_{10}$.
>Now calculate $F$:
>$$F = \begin{bmatrix}
\sqrt{P_0}U_{00}V^*_{00} + \sqrt{P_1}U_{01}V^*_{01} & \sqrt{P_0}U_{00}V^*_{10} + \sqrt{P_1}U_{01}V^*_{11} \\
\sqrt{P_0}U_{10}V^*_{00} + \sqrt{P_1}U_{11}V^*_{01} & \sqrt{P_0}U_{10}V^*_{10} + \sqrt{P_1}U_{11}V^*_{11}
\end{bmatrix}$$
>
> It is clear that if $F=I$ it is clear that each signal is radiated from only one antenna
> 

## 2.9) Signal Constraints
Clearly, if the channel has to be normalized, also some other constraints are bound to happen on the precoding.

#### Power Constraints
A **Per Block** power constarint arises from the avg power, in fact
$$\frac1N\sum_{n=0}^{N-1}\mathbb E[\|x[n]\|^2]=\frac1N\sum_{n=0}^{N-1}\tr(R_x[n])=E_s$$
And from here: $$\frac1N\sum_{n=0}^{N-1}\tr(F[n]F^*[n])=N_t$$
However, due to the unitary nature of $U_F$ and $V_F$ we have that this constraint only arises to $P[n]$, that is:
$$\frac1N\sum_{n=0}^{N-1}\tr(P[n])=N_t$$
Proof: $$\tr(FF^*)=\tr(U\Sigma V^*V\Sigma^* U^*)=\tr(U^*U\Sigma V^*V\Sigma^*)=\tr(I\Sigma I\Sigma^*)=\tr(\Sigma\Sigma^*)$$
Now notice how $\Sigma^*=\begin{bmatrix}P^{1/2^*}& 0\end{bmatrix}$. and thus $\Sigma\Sigma^*=\begin{bmatrix}P^{1/2}\\ 0\end{bmatrix}\begin{bmatrix}P^{1/2^*}& 0\end{bmatrix}=\begin{bmatrix}P & 0 \\ 0 & 0\end{bmatrix}$
Then the trace is clearly $\tr(FF^*)=\tr(\Sigma\Sigma^*)=\tr(P)+\tr(0)=\tr(P)$.

A **Per Symbol** constraint that is the same per block, but without the $\frac1N\sum$ part.
A **Per Antenna** constraint that reduces to $$R_x[n]_{j,j}=E_s/N_t$$
This states that the power radiated by the $j$-th antenna (the $j$-th element of the diagonal of the covariance matrix) is fixed to a specific value. Now recalling $R_x[n]=\frac{E_s}{N_t}F[n]F^*[n]$it becomes that
$$[F[n]F^*[n]]_{j,j}=1$$
## 2.10) Zero Forcing (ZF) Equalization Theory


## 2.11) Orthogonal Frequency Division Multiplexing (OFDM)
OFDM is a modulation with the core feature of **parallalization**. In fact it allows to transmit concurrently over different subcarriers (tones). This implies that the coding takes place in frequency, not in time. 

This modulation exploits the circular convolution and multiplication of the DFT in order to simplify the equalization.

![[Pasted image 20251202120108.png|OFDM RX and TX|350]]
A quick recap on what id does:
- Block of K input samples in time domain in which the cyclic prefix is inserted are TXed. 
- The DFT of the received received signal is equalized through the DFT of the zero padded channel response to obtain $\hat x[n]$

The **Transmitter** takes the symbols in frequency domain $x_f[k]$ and does the IDFT to obtain the time domain, which after inserting the cyclic prefix becomes:
$$\overline x[n]=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K nk}\quad n=-L,...,K-1$$
This means that a signal of length $K$ becomes a TXed signal of length $K+L$. The rate becomes $T\frac{K+L}K$. This means that:
- If we fix the input rate we have a higher output
- If we fix the output rate we have a lower input
 !EXAM: usually it is given a Bandwidth constraint (finite output rate), so we have to slow down input rate to decrease input rate we sample the input signal at a lower frequency, so we stretch the K-long block to the same duration of a K + L-long block.

At the **Receiver** we first discard the cyclic prefix and then
$$y[n]=\sqrt G\sum_{l=0}^Lh[l]\overline x[((n-l))_K]\fourier y_f[k]=\sqrt G h_f[k]x_f[k]+v_f[k]$$
Where $v_f\sim\complexgauss(0,N_0)$ iid.

![[Pasted image 20251202124507.png|Alternative Derivation starting from input frequency input|450]]
Finally the estimated signal becomes
$$\hat x_f[k]=\frac{y_f[k]}{\sqrt G h_f[k]}$$
There is no ISI as each tone is frequency flat. Each subcarrier has noise
$$\sim\complexgauss(0,\frac{N_0}G\frac1{|h[k]|^2})$$
The parallelism might not be immediately visible. 


**REMEMBER FOR EXAM MOORE PENROSE PSEUDO INVERSE FOUND IN EXERCISES IN PARTICULAR THE THEOREMS (NO PROOF)**
