# 1) Appendix
## 1.1) Matrix Algebra
#### **Hermitian Matrix**
A complex matrix $A$ is said to be hermitian if $A^*=A$. 

Note that $A^*=(\overline A)^T$, that is if $A = \begin{pmatrix} a_{11} & a_{12} \\ a_{21} & a_{22} \end{pmatrix}$ then $A^* = \begin{pmatrix} \overline{a_{11}} & \overline{a_{21}} \\ \overline{a_{12}} & \overline{a_{22}} \end{pmatrix} , \quad a_{ij} \in \mathbb{C}.$
####  **Unitary Matrix**
A complex matrix $U$ is said to be unitary if $UU^*=U^*U=I$, moreover 
- $U$ is non singular and $U^*=U^{-1}$
- $U$ has orthonormal rows and columns
- $U$ is a rotation matrix in $y=Ux$ and thus $|y|=|x|$

####  **Fourier Matrix**
A fourier matrix is a $N\times N$ unitary matrix where the $(i,j)$ th entry equals $e^{j2\pi ij/N}$, moreover it is scaled by a $1/\sqrt N$ factor. This matrix can be used to calculate the DFT or IDFT:
$$\text{DFT: x} = \sqrt N U^* x\quad \text{IDFT: }x=\frac1{\sqrt N}U\text x$$
####  **Toeplitz and Circulant Matrix**
A Toeplitz matrix has constant values along its diagonals, while a circulant matrix is described by only one row.

####  **Singular Value Decomposition**
Any $N\times M$ matrix can be factored as $A=U\Sigma V^*$ where  ^2c6539
- $U,V$ are unitary $N\times N, M\times M$ matrices
- $\Sigma$ is a $N\times M$ matrix with real values on its main diagonal and 0 elsewhere

this is used for [precoding](#^807fea).

####  **Matrix Inversion Lemma**
Used for MMSE estimation of a complex Gaussian vector.
$$(A+BCD)^{-1}=A^{-1}-A^{-1}B(C^{-1}+DA^{-1}B)^{-1}DA^{-1}$$
this is used for [vector complex gaussian MMSE estimation](#^0db957)
 ^842220
## 1.2) **Important Basic Formulas:**
$$\begin{align}
&(AB)^{-1}=B^{-1}A^{-1}\\ \\
&\text{rank}(A+B)\leq \text{rank}A+\text{rank}B\\
&\|A\|_F=\sqrt{\tr(AA^*)}=\sqrt{\sum_i\sum_j |[A]_{i,j}^2|}
\end{align}$$
Determinant:
$$\begin{align}
&\det(AB)=\det(BA)=\det A\det B\\
&\det(I+AB)=\det(I+BA)\\ 
&\det(A^{-1})=1/\det A\\
&\det (e^A)=e^{\tr A}\\
&\det A=0\implies A^{-1}\text{ doesn't exist}\\
\end{align}$$
Trace:
$$\begin{align}
&\tr(ABC)=\tr(CAB)=\tr(BCA)\\
&tr(aA+bB)=a\tr A+ b\tr B\\
&AB=a\implies\tr(AB)=a\\
&\mathbb E[ABC]=\tr(\mathbb E[ABC])=\mathbb E[\tr(ABC)]\\ \\
\end{align}$$


## 1.3) (Exam Candidate!) Moore Penrose Pseudo Inverse
$$ $$
>[!def] Moore Penrose Pseudo Inverse
>The pseudo inverse of a $N \times M$ matrix $A$ is the unique matrix $A^\dagger$ satisfying:
>$$\begin{align}
AA^\dagger A&=A\\
A^\dagger AA^\dagger&=A^\dagger
\end{align}$$
>such that $AA^\dagger, A^\dagger A$ are both hermitian. ($(AA^\dagger)^*=AA^\dagger,(A^\dagger A)^*=A^\dagger A$)

^3a6391

- **Tall Matrix:** If $A^*A$ is invertible then (left inverse) $$A^\dagger =(A^*A)^{-1}A^*$$ this might be the case for $N\geq M$ ($A^\dagger A=A$)
- **Fat Matrix:** If $AA^*$ is invertible then (right inverse) $$A^\dagger =A^*(AA^*)^{-1}$$ this might be the case for $N\leq M$ ($AA^\dagger=A$)
- **Square Matrix:** If the matrix is square (and invertible) the pseudo inverse is the regular inverse.

>[!theorem] Characterization of Least-Squares Solutions
>$\forall x\in\mathbb K^n$ we have $\|Ax-b\|_2\geq \|Az-b\|_2$ where $z=A^\dagger b$ and $\|\cdot\|_2$ the euclidean norm.
>
>The equality holds iff $x=A^\dagger b+(I-A^\dagger A)\vec w,  \forall \vec w$ and provides infinite solutions unless $A$ has full column rank (in this case $I-A^\dagger A=0$ ). The solution with minimum euclidean norm is z.
>
>For linear systems $Ax=b$ with non unique solutions, the pseudo inverse might be used to construct the solution of minimum euclidean norm among all solutions.

This is the l**east squares problem**: $z=A^\dagger b=\min_{x}\|Ax-b\|_2$. 

>[!theorem] Minimum Norm Solution
>If $Ax=b$ is satisfiable, the vector $z=A^\dagger b$ is a solution and satisfies $\|z\|_2\leq \|x\|_2$ for all solutions

| $\mathbf{Ax=b}$            | Non-Satisfiable (Overdetermined) | Satisfiable (Underdetermined or 1 Solution) |
| -------------------------- | -------------------------------- | ------------------------------------------- |
| **Solutions**              | $Az-b=a$                         | $Az-b=0$                                    |
| **Comment on $\mathbf z$** | $z$ solves least squares         | z is the solution with minimum norm         |


Proof:
- $A^*A$:   $AA^\dagger A=A\ \underbracket{(A^*A)^{-1}}_{X^{-1}}\underbracket{A^*A}_{X}=AI=A$
- $AA^*:$   $AA^\dagger A=\underbracket{AA^*}_{X}\underbracket{(AA^*)^{-1}}_{X^{-1}}A=IA=A$
- $A^\dagger = A^{-1}:$   $AA^\dagger A=AA^{-1}A=AI=A$

used for [ZF equalization](#^96193a), [channel estimation](#^e5a5dc)

## 1.4) Random Variables and Processes
#### **Median PDF**
The median of a pdf is simply $m: P(X<m)=\int_{-\infty}^M=0.5$

- **Useful Formulas**
Bayes Formula:
$$\begin{align}
f_{y|x}(y|x)=\frac{f_{xy}(xy)}{f_x(x)} \\
f_{x|y}(y|x)=\frac{f_{xy}(xy)}{f_y(y)}
\end{align}
\implies f_{x|y}(x|y)=\frac{f_{y|x}(y|x)f_x(x)}{f_y(y)}$$
####  **Properness:**
A complex random scalar $x$ is said to be proper if
$$\begin{align}
&\E[x^2]=\E[x]^2 \\
&\E[xx^T]=\E[x]\E[x^T]
\end{align}$$

that is $\Im, \Re$ are uncorrelated and with same variance 

Any subvector of a proper vector is proper:
$$x=[x_1,x_2]^T\text{ proper }\implies \begin{align}x_1 \text{ proper } \\ x_2 \text{ proper }\end{align}$$
however the opposite doesn't hold
$$\begin{align}x_1 \text{ proper } \\ x_2 \text{ proper }\end{align}\nRightarrow x=[x_1,x_2]^T\text{ proper }$$
#### **Circular Symmetry**
The distribution of $(x-\E[x])e^{j\phi}$ remains unchanged $\forall \phi$.
- **Linear Transformations**
$$\begin{align}
y=ax\rightarrow f_y(y)=\frac1{|a|^2}f_x(\frac ya)\\
y = Ax\rightarrow f_y(y)=\frac{f_x(A^{-1}y)}{|\det A|^2}
\end{align}$$
#### **Jensen Inequality**
if $f(x)$ is convex, then
$$f(\E[x])\leq \E[f(x)]$$

>[!todo]
>Convergences, Central Limit, LLN
# 2) Gaussian Distributions
Here are some relevant properties:
- $\perp\iff R=0$
- If proper complex and gaussian then also circular, that is for complex gaussian Proper$\equiv$Circular
- Gaussianity is preserved through linear transformations

| Type                 | Real Scalar                                                              |
| -------------------- | ------------------------------------------------------------------------ |
| Distribution         | $$f_x(x)=\frac1{\sqrt{2\pi\sigma^2}}\exp{-\frac{(x-\mu)^2}{2\sigma^2}}$$ |
| Differential Entropy | $$h(x)=\frac12\log_2\pi e \sigma^2$$                                     |

| Type                                   | Complex Scalar                                                                                                                                         | Complex Vector                                                                                                                                       |
| -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Distribution                           | $$f_x(x)=\frac1{\pi\sigma^2}\exp{-\frac{\|x-\mu\|^2}{\sigma^2}}$$                                                                                      | $$f_x(x)=\frac1{\det(\pi R)}\exp{-(x-\mu)^*R^{-1}(x-\mu)}$$                                                                                          |
| Differential Entropy                   | $$h(x)=\log_2\pi e \sigma^2$$                                                                                                                          | $$h(x)=\log_2\det(\pi e R)$$                                                                                                                         |
| Mutual Information ($\rho$ is SNR)     | $$I(\rho)=\log_2(1+\rho)$$<br>Small $\rho$:<br>$$I(\rho)=(\rho-\frac12\rho^2)\log_2e+o(\rho^2)$$<br>Large $\rho$:<br>$$I(\rho)=\log_2\rho +O(1/\rho)$$ | $$I(\rho)=\log_2\det(I+\rho AR_xA^*R_z^{-1})$$<br>                                                                                                   |
| Sum $z=x+y$                            | $$z\sim\complexgauss(\mu_x+\mu_y,\sigma^2_x+\sigma^2_y+2\Re\text{Cov}(x,y))$$                                                                          | if independent<br>$$z\sim\complexgauss(\mu_x+\mu_y,R_x+R_y)$$                                                                                        |
| **AWGN**                               | **Complex Scalar**                                                                                                                                     | **Complex Vector**                                                                                                                                   |
| Default form                           | $$y=\sqrt\rho s+z$$<br>$$s\sim\complexgauss(0,1)\perp z\sim\complexgauss(0,1)$$                                                                        | $$\mathbf y=\sqrt\rho\mathbf A\mathbf s+\mathbf z$$<br>$$\mathbf s\sim\complexgauss(0,R_x)\perp \mathbf z\sim\complexgauss(0,R_z)$$                  |
| Final $y$ distribution:                | $$y\sim\complexgauss(0,1+\rho)$$                                                                                                                       | $$y\sim\complexgauss(0,\rho AR_sA^*+R_z)$$                                                                                                           |
| Final Likelihood $y{\|}s$ distribution | $$y\|s\sim\complexgauss(\sqrt\rho s, 1)$$<br>$$f_{y\|s}(y\|s)=\frac1{\pi}\exp{-\|y-\sqrt\rho s\|^2}$$                                                  | $$y\|s\sim\complexgauss(\sqrt\rho As,R_z)$$<br>$$f_{y\|s}(y\|s)=\frac1{\pi^{N_y}\det(R_z)}\exp{-(y-\sqrt\rho As)^*R_z^{-1}(y-\sqrt\rho As)}$$        |
| Final posteriori $s\|y$ distribution   | $$f_{s\|y}\propto f_{y\|s}\cdot f_{s}\sim\complexgauss(\frac{\sqrt\rho}{1+\rho}y,\frac1{1+\rho})$$                                                     | Mean: $$\mu_{s\|y} = \sqrt\rho R_s A^* (\rho A R_s A^* + R_z)^{-1} \mathbf{y}$$<br>Variance:<br>$$R_{s\|y} = (R_s^{-1} + \rho A^* R_z^{-1} A)^{-1}$$ |

# 3) A Primer on Information Theory and MMSE
## 3.1) Information Content
####  **Information**
Information is defined as
$$i(A)=\log_2\par{\frac{1}{P[A]}}[bit]$$
Given a discrete r.v. with alphabet $\mathcal{A}_x=\{a_1,...,a_M\}$ it is possible to describe a information function 
$$i_x:\mathcal{A}_x\rightarrow\mathbb{R}, \ i_x(a)=i(x=a)=\log_2\frac{1}{p_x(a)}$$

####  **Entropy**
$$\boxed{\mathcal H(x)=-\sum_xp_x(x)\log_2 p_x(x)=-\E[\log_2 p_x(x)]}$$
Properties:
- non negative
- PMF that maximizes H is uniform distribution
- Shift: $\mathcal H(x+c)=\mathcal H(x)$
- Additional Info reduces Entropy: $\mathcal H(x|y)\leq \mathcal H(x)$
- Let $x$ have cardinality $M$, then $H(x)\leq \log_2 M$
- Let $x_i$ be independent, then $H(\mathbf x)=\sum_i H(x_i)$

####  **Joint and Conditional entropy**
$$\begin{align}
&\text{Joint:} &&\mathcal H(x_0, x_1)=\mathcal H(x_1)+\mathcal H(x_0|X_1)\\
& &&\mathcal H(x_0,...,x_{N-1})=\sum_{i=0}^{N-1}\mathcal H(x_i|x_0,...,x_{i-1})\\
&\text{Conditional:} &&\mathcal H(x|y)=-\sum_x\sum_yp_{xy}(xy)\log_2p_{x|y}(x|y)
\end{align}$$
####  **Differential Entropy**
$$\boxed{\mathcal h(x)=-\int_x f_x(x)\log_2 f(x)dx=-\E[\log_2 f_x(x)]}$$
Properties:
- Doesn't have physical meaning. IT CAN BE NEGATIVE
- Gaussian distribution maximizes it
- Used for mutual inf calculations
- Cannot be approached by discretizing $f(x)$ ($h(x)=H(x^\Delta)+\log_2\Delta$)

####  **Relative Entropy**

Consider two PMFs $p(\cdot).q(\cdot)$.If $q(\cdot)\not=0\in\text{support of }p(\cdot)$, the their relative entropy is
$$D(p||q)=\sum_xp(x)\log_2\frac{p(x)}{q(x)}=\mathbb E\sq{\log_2\frac{p(x)}{q(x)}}$$
Note that his is not symmetric $D(q||p)\not = D(p||q)$. This is interpreted as a similarity measure between q and p, and it is 0 iff $p=q\ \forall x$.
Moreover for PDFs:
$$D(f||g)=\int f(x)\log_2\frac{f(x)}{g(x)}dx$$

####  **Mutual Information**
$$\boxed{\begin{align}I(s;y)&=H(s)-H(s|y)\\
&=H(y)-H(y|x)\\
&= D(p_{sy}||p_sp_y)
\end{align}}$$
In contrast with differential entropies, $I(s,y)$ can be obtained by the limit of discretized version of $s,y$, albeit the differential entropies diverge, their difference is still well behaved.
Moreover the mutual information satisfies the **chain rule:**
$$I(x_0,...,x_{N-1};y)=\sum_{n=0}^{N-1}I(x_n;y|x_0,...,x_{N-1})$$
## 3.2) Reliable Communications
####  **Channel Law**
Let's start by explaining the communication link:
![[Pasted image 20251104120328.png|Basic Communication Link|400]]
- The encoder parses $N_b$ bits into messages. These bits are IID and bernoulli.
- Each message is a collection of $N_b$ bits and therefore there exist $2^{N_b}$ messages.
- Each message is mapped into $N$ unit power complex symbols $s[0],...,s[N-1]$
- Each symbol is then amplified $x[0],...,x[N-1]$
- The channel randomly modifies the signal. The **channel is known** if the conditional probability $f_{y|x}$ ($f_{y[0],...y[N-1]|x[0,...,x[N-1]]}$) or $\boxed{f_{y|x}(y|x)}$is known. Since the power amplification is known, this directly allows to find $f_{y|s}$.
- The decoder maps the observed values to the correct (ideally) codeword


Knowing the channel law, mutual information becomes:
$$\boxed{I(\tds s,\tds y)\stackrel{\text{memoryless}}=\E\sq{\log_2 \frac{f(\tds y|\tds s)}{f(\tds y)}}\stackrel{\text{stationary}}=\E\sq{\log_2\frac{f(\tds y |\tds s)}{\frac1{N_{bits}}\sum_0^{N_{bits}-1}f(\tds y|\tds s)}}}$$

####  **Capacity**
Capacity is the **maximum rate** at which information can be transmitted over a channel with **arbitrarily small error probability**. That is, there exists a code such that, $p_e\rightarrow 0, N\rightarrow\infty$.

Therefore, since infinitely long signals aren't physically realizable we have that
$$\frac RB\leq C$$
$R/B$ is the **spectral efficiency** measured in $\sq{\frac{bit/s}{Hz}}$.
$$C_{\text{stationary, ergodic, memoryless}}=\max I(s;y)$$
$$C_{\text{ergodic, stationary}}=\max \lim_{N\rightarrow \infty}\frac1NI(\tds s; \tds y)$$
This if the channel is information stable. And the symbols $s[n]$ are zero mean.

In an arbitrary channel we have the following probability to make an error:
$$p_e=\sum_{m=0}^{2^{N-b}-1}P[\hat w\not = m|w=m]P[w=m]\stackrel{\text{equiprobable}}=\frac1{2^{N_b}}\sum_{m=0}^{2^{N-b}-1}P[\hat w\not = m|w=m]$$
####  **Information Stable**
If a channel is information stable, then C is the maximum mutual information.

$$i(\tds s;\tds y)=\log_2\frac{f(\tds s,\tds y)}{f(\tds s)f(\tds y)}$$
**A channel is information stabile if information density does not deviate asymptotically from mutual information.**
$$\lim_{n\rightarrow \infty}\frac1Ni(\tds s,\tds y)=\lim_{n\rightarrow \infty}\frac1NI(\tds s,\tds y)$$
and this applies to ergodic and stationary channels.

####  **Coding Decoding**
>[!todo]

(! IMPORTANT) Since capacity is only reached for infinite length codewords which are not achievable, there is a performance penality on the capacity:
$$\frac RB = C-\underbrace{\sqrt\frac VNQ^{-1}(p_e)}_{\text{penality!}}+O(\frac{\log N}N)$$
where $V$ is the variance of information density.
## 3.3) MMSE 
####  **Old Estimators**
MAP: $\hat s=\arg\max_s f_{s|y}(s|y)$ 
ML: $\hat s=\arg\max_sf_{y|s}(y|s)$ == ML id IID

The MSE $|s-\hat s|^2$ is a measure of the estimators.

####  **Min Mean Square Error (MMSE)**
The MMSE Estimator is the estimation of $s$ given $y$ that minimizes the MSE:
$MMSE(s(\cdot))=\arg\min_{\hat s(\cdot)}\E\sq{|s-\hat s(\cdot)|^2}$. And the estimator has the following solution
$$\boxed{\hat s(\cdot)=\E[s|\cdot]}$$
Thus
$$\boxed{MMSE(s(\cdot))=\E\sq{|s-E[s|y]|^2}}=\E[\text{var}(s|y)]$$
>[!thm] Properties of estimator
> - **Unbiased for the mean:** 
$$\E[\hat s(y)]=\E[\E[s|y]]=\E[s]$$
> - **Biased for specific realization**
$$\E[\hat s|s]=\E[(s|y)|s]\not= s$$
> - **Orthogonality Principle:** error is orthogonal (uncorrelated) to any function $g(\cdot)$ of observation $y$
$$\E[g(y^*)(s-\hat s)]=0$$
> - **Decreasing function:** given $f_s$ a signal format and $f_z$ a noise distribution, then MMSE is a decreasing function of SNR $\rho$

Proof:
$$\mathbb E[\mathbb E [s|y]]=\int\par{\int s\cdot p(s|y)ds}p(y)dy=\int s\par{\int p(s|y)p(y)dy}ds=\int s\cdot p(s)ds=\mathbb E[s]$$
$$\begin{align}E[g(y)(s-\hat s)]&=\E\sq{\E\sq{g(y)(s-\hat s)|y}}=\E[\E[g(y)s-g(y)\hat s|s]]\\
&=\E[\E[g(y)s|y]-\E[g(y)\hat s|y]] =\E[g(y)(\E[s|y]-\E[\hat s|y])]\\
&=\E[g(y)(\E[s|y]-\E[s|y])=\E[g(y)\cdot 0]=\E[0]\\
&=0
\end{align}$$
Since: $\E[\hat s|y]=\E[\E[s|y]|y]=\E[s|y]$ 

In general recall law of total expectation: $\E[f(y)]=\E[\E[f(y)|y]]$, $\E[f(y)|y]=\E[\E[f(y)|y]|y]$

####  **MMSE With Known Channel**
If the channel is known we have $f_{y|s}$ known, then 
$$f_{s|y}(s|y)=\frac{f_{y|s}(y|s)f_s(s)}{f_y(y)}=\frac{f_{y|s}(y|s)f_s(s)}{\int f_{y|s}(y|s)f_s(s)ds}$$
and therefore the estimator is
$$\begin{align}\hat s(y)&=\E[s|y]=\int sf_{s|y}(s|y)ds=\int\frac{sf_{y|s}(y|s)f_s(s)}{\int f_{y|s}(y|s)f_s(s)ds}ds\\
&\boxed{=\frac{\int sf_{y|s}(y|s)f_s(s)ds}{\int f_{y|s}(y|s)f_s(s)ds}}
\end{align}$$
####  **MMSE in AWGN**
Complex scalar:
Recall $y=\sqrt\rho s +z$ with $s,z\sim\complexgauss(0,1)$, then $f_s=\frac1\pi\exp{-|s|^2}$ and $f_{y|s}=\frac1\pi\exp{-|y-\sqrt\rho s|^2}$.
$$\boxed{
\hat s(y)=\frac{\sqrt{\rho}}{1+\rho}y}$$
where it was found that 
$$f_{s|y}\propto f_{y|s}\cdot f_{s}\sim\complexgauss(\frac{\sqrt\rho}{1+\rho},\frac1{1+\rho})$$
and the MMSE is
$$\boxed{MMSE(\rho)=\frac1{1+\rho}}$$
In fact, $\rho\rightarrow\infty\implies MMSE\rightarrow 0$.

And has a bias of
$$-\frac1{1+\rho}s$$

####  **Vector MMSE**
$$\begin{align}
\hat s(y)&=\E[s|y]\\
E&=\E[(s-\hat s(y))(s-\hat s(y))^*]
\end{align}$$
Where the j-th diagnal in $E$ represents the  MMSE for the j.th entry of $s$

####  **Vector Gaussian MMSE**
Very Easily: ^0db957

$$\hat s(y)=\sqrt\rho R_sA^*(I+\rho AR_sA^*)^{-1}y$$ 
$$
E=R_s-\rho R_sA^*(I+\rho AR_sA^*)^{-1}AR_s
$$

By applying the [matrix inversion lemma](#^842220) we obtain:
$$E=(R_s^{-1}+\rho A^*A)^{-1}$$

####  **I-MMSE in gaussian noise** 
Scalar:
$$MMSE(\rho)=\frac1{\log_2 e}\frac d{d\rho}I(s;\sqrt\rho s+z)\qquad \frac1{\log_2 e}I(\rho)=\int_0^\rho MMSE(\xi)d\xi$$
Vector:
$$\frac1{\log_2 e}\nabla_AI(s;\sqrt\rho As+z)=\rho AE$$
####  **L-MMSE**
works for gaussian vectors in gaussian noise
$$\boxed{\hat s ={W^{MMSE}}^*y+b^{MMSE}}$$
where b is the bias term for non zero mean signals. It is therefore usually ignored.
$$\boxed{W^{MMSE}=R_y^{-1}R_{ys}}$$
from here the MMSE estimate is:
$$E=\E[(s-\hat s)(s-\hat s)^*]=R_s-R_{\hat ss}-R_{\hat s}^*+R_\hat s=R_S-R_{ys}^*R_y^{-1}R_{ys}$$
in AWGN we have
$$\begin{align}
W^{MMSE}=\sqrt\rho\underbrace{(R_z+\rho AR_sA^*)}_{R_y^{-1}}\cdot\underbrace{AR_s}_{R_{ys}}\\
E=(R_s^{-1}+\rho A^*R_z^{-1}A)^{-1}
\end{align}$$
if both are scalars we turn to the MSE definition
####  **Random Processes**
TODO

## 3.4) Exercises (Textbook & Professor)
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
>[!Example|1.4] Negative Differential Entropy
>A uniform distribution is a textbook example of a possible negative differential entropy:
>Let $x\sim u(0,b)$, then:
>$$h(x)=-\int_0^b\frac1b\log_2\frac1bdx=\log_2b<0, \forall b\in(0,1)$$

>[!example|1.5] Differential Entropy of complex Gaussian Scalar
>Let $x\sim\complexgauss(\mu, \sigma^2)$
>$$\begin{align}h(x)&=-\E[\log_2(\frac1{\pi\sigma^2}e^{-|x-\mu|^2/\sigma^2})]=\E[\log_2\pi\sigma^2]+\E\sq{\frac{|x-\mu|^2}{\sigma^2}}\log_2e=\log_2(\pi e \sigma^2)
\end{align}$$

>[!example|1.6] Differential Entropy of complex Gaussian Vector
>Let $x\sim\complexgauss (\mathbf\mu, \mathbf R)$, then
>Recall $f_x(x)=\frac1{\det(\pi R_x)} e^{-(x-\mu_x)^*R_x^{-1}(x-\mu_x)}=\frac1{\det(\pi R)}e^{-k}$
>Now from the definition of the differential entropy:
>$$\begin{align}h(x)&=-\E[\log_2f_x(x)]=-\E\sq{\log_2(\frac1{\det(\pi R)}e^{-k})}=-\E\sq{-\log_2\det(\pi R)-k\cdot\log_2e}\\
&=\log_2(\det\pi R)+\E[k]\log_2e=\log_2(\det\pi R)+\E[(x-\mu_x)^*R_x^{-1}(x-\mu_x)]\log_2e
\end{align}$$
>Analyze just $\E[k]$:
>$$\begin{align}
\E[k]&=\E[\tr(k)]=\E[\tr((x-\mu)^*R^{-1}(x-\mu))]\\
&=\E[\tr(R^{-1}(x-\mu)(x-\mu)^*)]=\tr(\E[R^{-1}(x-\mu)(x-\mu)^*])\\
&=\tr(\E[R^{-1}R])=\tr(I)
\end{align}$$
> Now since $\det cI_n=c^n$ we have:
> $$E[k]\log_2e=tr(I)\log_2e=n\log_2 e=\log_2e^n=\log_2\det eI$$
> Finally:
> $$h(x)=\log_2(\det\pi R)+\log_2\det eI=\log_2\det(\pi R e I)=\log_2\det(\pi e R)$$

>[!example|1.5] Gaussian Mutual Information for complex gaussian scalar
>Suppose a standard AWGN channel $y = \sqrt\rho s+z$, and:
>- $s\sim\complexgauss(0,1)$
>- $z\sim\complexgauss(0,1)$
>then
>- $y\sim\complexgauss(0,1+\rho)$
>- $y|s\sim\complexgauss(\sqrt\rho s, 1)$
>therefore
>$$\begin{align}
I(\rho)&=I(s;\sqrt\rho s+z)=h(\sqrt\rho s +z)-h(\sqrt\rho s +z|s)\\
&=h(y)-h(z)=\log_2(\pi e(1+\sqrt\rho))-\log_2(\pi e)=\log_21+\rho
\end{align}$$

>[!example|1.6] Gaussian Mutual Information for complex gaussian vector
>Exactly identical as 1.5, check the table on gaussian distributions for infos

>[!example|1.16] Channel Law in AWGN Channel
>Let $y[n]=\sqrt\rho s[n]+z[n]$ with $z\sim\complexgauss(0,1)$
>Recall that $y|s\sim\complexgauss(\sqrt\rho s, 1)$ and thus
>$$f_{y|s}(y|s)=\frac1{\pi}\exp{-|y-\sqrt\rho s|^2}$$

>[!todo]
>Example 1.35

>[!todo]
>Derivation of LMMSE

---

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

>[!exercise|1.34] Orthogonality Proof + MMSE Proof
>Consider the AWGN transformation: $y=\sqrt(N_0)+\rho s+z$:
>- Prove the orthogonality principle: $\E[g(y)(s-\E[s|y])]=0$
>- Prove that the MMSE is $\hat s(y)=\E[s|y]$
>
>For the first solution watch the proof provided in the above chapter
>Th etrick for the second part is to rewrite the square as:
>$$\begin{align}|s-\hat s|^2&=|(s-\E[s|y])+(\E[s|y]-\hat s)|^2\\
&=|s-\E|^2+|\E-\hat s|^2+2\Re[(s-\E)(\E+\hat s^*)]\\
&=|s-\E|^2+|\E-\hat s|^2+2\Re[g(y)(s-\E)]\end{align}$$
> where $g(y)=(\E[s|y]-\hat s(y))$. Now apply the expectation and the last term is the orthogonality principle:
> $$\E[|s-\hat s|^2]=\E[|s-\E|^2]+\E[|\E-\hat s|^2]+0$$
> and is minimized when $\hat s(y)=\E[s|y]$.

# 4) A Signal Processing Perspective
## 4.1) Signal. Channel and Noise Representations
####  **Ideal Passband Signal**
$$\begin{align}x_p(t)&=A(t)\cos(2\pi f_c t+\phi(t))\\
&=\underbrace{A(t)\cos(\phi(t))}_{\sqrt2x_i(t)}\cos(2\pi f_ct)-\underbrace{A(t)\sin(\phi(t))}_{\sqrt 2 x_q(t)}\sin(2\pi f_ct)\\
&=\sqrt 2 x_i(t)\cos(2\pi f_c t)-\sqrt2x_q(t)\sin(2\pi f_c t)\end{align}$$
where $\sqrt 2$ is used for power conservation between passband and baseband:
$$x_p(t)=\sqrt 2\Re\curly{x(t)e^{^{j2\pi f_ct}}}$$
in frequency:
$$x_p(f)=\frac1{\sqrt 2}\sq{(x(f-f_c)x^*(f-f_c)}$$
####  **Complex Baseband Equivalent**
$$x(t)=x_i(t)+jx_q(t)$$
proof of the power conservation:
$$\begin{align}
x_p(t)&=\sqrt 2\Re\curly{(x_i+jx_q)(\cos(2\pi f_c t)+j\sin(2\pi f_c t))}\\
&=\sqrt2\Re\curly{x_i\cos-x_q\sin+j(x_i\sin+x_q\cos)}\\
&=\sqrt2\sq{x_i(t)\cos(s\pi f_c t)-x_q(t)\sin(2\pi f_c t)}
\end{align}$$
####  **Downconversion**
$$y_p=\sqrt 2\par{y_i(t)\cos(2\pi f_c t)-y_q(t)\sin(2\pi f_c t)}$$
and the complex baseband equivalent is found by multiplying and then setting a low pass filter:
- $\sqrt 2\cos(2\pi f_ct)\rightarrow y_p(\sqrt 2 \cos(2\pi f_c t))=\underline{y_i(t)}+y_i(t)\cos(4\pi f_c t)-y_q(t)\sin(2\pi f_c t)$
- $-\sqrt2\sin(2\pi f_c t)$ analogously finds $y_q(t)$
recombine into $y(t)=y_i(t)+y_q(t)$

#### **Complex Baseband Channel**
Let $c_p(t)$ be the complex passband channel, then the input and output relation becomes:
$$y_p(t)=(c_p*x_p)(t)=\int_{-\infty}^\infty c_p(\tau)x_p(t-\tau)d\tau$$
Note that $x_p$ doesn't need to be band limited since $x_p$ already is. For the same reason, also the output is band limited.

The baseband channel is given by
$$g_{B/2}(\tau)=B\sinc(B\tau)\rightarrow \boxed{c_b(\tau)=g_{B/2}(\tau)*\sq{c_p(\tau)e^{-j2\pi f_c \tau}}}$$
#### **Complex Pseudo-Baseband Channel**
This is the downshifted but not band limited version of the baseband channel. This equals to just $$\boxed{c(\tau)=c_p(\tau)e^{-j2\pi f_c \tau}}$$
This is useful for single tap discrete channels.

Since this is not band limited it cannot be sampled and care must be exercised when time discretizing.

####  **Tapped Delay Line**

^0ffb10

$$c_p(\tau)=\sum_iA_i\delta(\tau-\tau_i)$$
This is a sum of deltas and therefore it is not band limited
$$c_b(\tau)=g_{B/2}*\underbrace{\sum A_i\delta(\tau-\tau_i)e^{-j2\pi f_c\tau_i}}_{c(\tau)}$$
####  **Time Discretization**
The critical sampling period is the equality:
$$T\leq\frac 1B$$
and therefore
$$\boxed{c[l]=Tc_b(\tau)|_{\tau=lT+\phi}=Tc_b(lT+\phi)}$$
where $\phi =0$ usually but can be set to any constant to **offset** the sampling. This is also non band limited.

It is not necessary to find $c_b$ to obtain $c[l]$ since it is already obtainable from the pseudo baseband downshifted not band limited) $c(\tau)$.
- **Pulse Shaping**
a continuous time signal can be represented as (in general $g_{tx}(t-nT)$, not sinc)
$$x(t)=\sum_nx[n]\sinc\par{\frac{t-nT}T}$$
then $g_{B/2}$ is the convolution of he two tx and rx pulse shapes.
**Raised Cosine Pulse:** band penalty of $1/1+b$.

####  **AWGN Noise**
- White since autocovariance $R_{v_p}=\E[v_p(t)v_p^*(t+\tau)]=N_0\delta(t)$ and therefor it is stationary and ergdic and has power spectral density $S_{v_p}(f)=N_0$
- Gaussian since $v_p\sim\complexgauss(0,N_0)$ at each time $t$, then by the central limit theorem a sum of iid is also gaussian.
Moreover $N_0=kT_{eff}$.

Since bandlimited the noise has power $P=\int_B N_0df=N_0B$

####  **Energy And Power**
TODO

The avg transmit power is
$$P_t=\frac1N\lim_{N\rightarrow\infty}\sum_{n=0}^{N-1}\mathbb E[|x[n]|^2] \ [W]$$
But the limit can be ignored.

The average transmit energy per symbol is $E_s=P_tT \ [J]$. In one period the noise has energy $N_0$ and if both sequences $x,v$ are scaled by $\sqrt T$ we have that
$$E_s=\frac1N\sum_{n=0}^{N-1}\mathbb E[|x[n]|^2]$$
By making $s[n]$ a unit variance (power) symbol, we have that 
$$x[n]=\sqrt{E_sP[n]}s[n]$$
 with $\frac 1N\sum P[n]=1$ to register variations.

####  **Channel Normalization**
$$\begin{align}
c(\tau)=\sqrt Gh(\tau)\\
c_b(\tau)=\sqrt Gh_b(\tau)\\
c[l]=\sqrt Gh[l]
\end{align}$$
where $\sum h[l]=1$ 

$$\boxed{SNR=\frac{P_r}{N_0/T}=\frac{GE_s}{N_0}}$$
and so the AWGN relation becomes:
$$y[n]=\sqrt G\sum_{l=0}^Lh[l]x[n-l]+v[n]$$
where the sum is a FIR filter, otherwise it would sum $-\infty,\infty$. If the channel is single tap (frequency selective), then it moltiplicative.

#### **Vector Representation**
This convolution can be expressed as a matrix multiplication.
we can define the impulse response of the channel to be a **toeplitz matrix** of dimensions $N\times (N+L)$. 
$$\overline{\mathbf H}_{N.N+L}=\begin{bmatrix}
h[L] & ... & h[0] & 0 & 0& ... & 0\\
0 & h[L] & ... & h[0]& 0 & ... & 0\\
\vdots&&&\ddots&&&\vdots\\
0 &... & ... &0& h[L] & ... & h[0]
\end{bmatrix}$$
And also create a vector of symbols with memory of $L$ past symbols.
$$\overline{\mathbf x}_{N+L}=\begin{bmatrix}
x[-L]\\
\vdots\\
x[-1]\\
x[0]\\
\vdots\\
x[N-1]
\end{bmatrix}$$

Then
$$\overline{\mathbf y}=\sqrt G \overline{\mathbf H}_{N.N+L}\overline{\mathbf x}_{N+L}+\overline{\mathbf v}_{N}$$
this represents all the N symbols received.
$$\tds y_N=[y[0],...,y[N-1]]^T\quad \tds v_N=[v[0],...,v[N-1]]^T$$
## 4.2) MIMO
This is just the previous model extended to $N_t$ tx antennas (j) and $N_r$ rx antennas (i).
$$y^{(i)}(t)=\sqrt G\sum_{j=0}^{N_t-1}\int_\R h^{(i,j)}(\tau)x^{(j)}(t-\tau)d\tau+v_b^{(i)}(t)$$
vectorized
$$\mathbf y(t)=\sqrt G\int_{-\infty}^\infty \mathbf H(\tau)\mathbf x(t-\tau)d\tau+\mathbf v(t)$$


where:
- y is the vector of all i rx signals $y(t)=[y^{(0)}(t),...,y^{(N_r-1)}(t)]^T$
- x is the vector of all j tx signals $x(t)=[x^{(0)}(t),...,x^{(N_t-1)}(t)]^T$
- v the noise on all i rx antennas $v(t)=[v^{(0)}(t),...,v^{(N_r-1)}(t)]^T$
- H the matrix of all normalized channel responses.
$$\mathbf H(\tau)=\begin{bmatrix}
h^{(0,0)}(\tau) & h^{(0,1)}(\tau) & ... & h^{(0,N_t-1)}(\tau) \\
h^{(1,0)}(\tau) & h^{(1,1)}(\tau) & ... & h^{(1,N_t-1)}(\tau) \\
\vdots&\vdots&\ddots&\vdots\\
h^{(N_t-1,0)}(\tau) & h^{(N_t-1,1)}(\tau) & ... & h^{(N_t-1,N_t-1)}(\tau)
\end{bmatrix}$$
and time discretized:
$$\mathbf y[n]=\sqrt G\sum_{l=0}^L \mathbf H[l]\mathbf x[n-l]+\mathbf v[n]$$
where

####  **Stacked Vector Representation**
again, the the full block of N tx signals received by $N_r$ rx antennas can be written as a matrix multiplication by removing the convolution. 

First for the single receiver:
$$\tds y_N^{(i)}=\sqrt G\sum_{j=0}^{N_t-1}\tds H_{N,N+L}^{(i,j)}\tds x_{N+L}^{(j)}+\tds v_{N}^{(i)}$$
where $\tds y_n^{(i)}=[y_n^{(i)}(0),...,y_n^{(i)}(N-1)]\quad \tds v_N^{(i)}=[v_n^{(i)}(0),...,v_n^{(i)}(N-1)]$
and most importantly:
$$\begin{align}
\tds x^{(j)}&=\big[x^{(j)}[-L],...,x^{(j)}[-1],x^{(j)}[0],x^{(j)}[1],...,x^{(j)}[N-1]\big]^T\\ \\

H^{(i,j)}&=\begin{bmatrix}
h^{(i,j)}[L] & ... & h^{(i,j)}[0] & 0 & 0& ... & 0\\
0 & h^{(i,j)}[L] & ... & h^{(i,j)}[0]& 0 & ... & 0\\
\vdots&&&\ddots&&&\vdots\\
0 &... & ... &0& h^{(i,j)}[L] & ... & h^{(i,j)}[0]
\end{bmatrix}
\end{align}$$
From here the stacking of these matrices can be used to also give the full received signals vector.

In partcular
- x: matrix of $(N+L)$ tx matrices (made of $N_t$ antennas) $\rightarrow$ tot size $N_t(N+L)$
- y: matrix of $N$ rx matrices (made of $N_t$ antennas) $\rightarrow$ tot size $N_rN$
- v: same as y but for noise
- H: matrix made of all toeplitz matrices of all i-j channels $\rightarrow$ tot size $N_rN\times N_t(N+L)$
$$\mathbf{\overline x}_{(N+L)N_t}=\begin{bmatrix}
\mathbf{\overline x}_{N+L}^{(0)}\\
\vdots\\
\mathbf{\overline x}_{N+L}^{(N_t-1)}
\end{bmatrix},
\qquad\overline{\mathbf H}_{NN_r,(N+L)N_t}=\begin{bmatrix}
\overline{\mathbf H}_{N.N+L}^{(0,0)} & ... & \overline{\mathbf H}_{N.N+L}^{(N_r,0)}\\
\vdots&\ddots&\vdots\\
\overline{\mathbf H}_{N.N+L}^{(0,N_t-1)} & ... & \overline{\mathbf H}_{N.N+L}^{(N_r,N_t-1)}
\end{bmatrix}$$
finally:
$$\overline{\mathbf y}_{N_rN}=\sqrt G\overline{\mathbf H}_{N_rN,(N+L)N_t}\overline{\mathbf x}_{N_t+L}+\overline{\mathbf v}_{N_rN}$$

| **Form**     | **Inputs**    | **Outputs** | **What Happens**                                                                                                         | **Formula**                                                                                                                         |
| ------------ | ------------- | ----------- | ------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------- |
| SISO conv    | $$1$$         | $$1$$       | One signal through L taps FIR channel.                                                                                   | $$y[n]=\sqrt G\sum_{l=0}^Lh[l]x[n-l]+v[n]$$                                                                                         |
| SISO matrix  | $$N+L$$       | $$N$$       | Entire block  of N signals through L taps FIR channel.                                                                   | $$\overline{\mathbf y}=\sqrt G \overline{\mathbf H}_{N.N+L}\overline{\mathbf x}_{N+L}+\overline{\mathbf v}_{N}$$                    |
| MIMO scalar  | $$N_t$$       | $$1$$       | I-th RX antenna receiving 1 signal from all TX antennas in continuous time channel.                                      | $$y^{(i)}(t)=\sqrt G\sum_{j=0}^{N_t-1}\int_\R h^{(i,j)}(\tau)x^{(j)}(t-\tau)d\tau+v_b^{(i)}(t)$$                                    |
| MIMO conv    | $$N_t$$       | $$N_r$$     | All rx antennas from all tx antennas one signal.<br><br>If frequency flat equivalent to frequency selective siso matrix. | $$\mathbf y[n]=\sqrt G\sum_{l=0}^L \mathbf H[l]\mathbf x[n-l]+\mathbf v[n]$$                                                        |
| MIMO stacked | $$(N+L) N_t$$ | $$N_r N$$   | Entire N signal transmit block across all antennas.<br><br>Matrix size same as SISO matrix multiplied by $N_t, N_r.$     | $$\overline{\mathbf y}_{N_rN}=\sqrt G\overline{\mathbf H}_{N_rN,(N+L)N_t}\overline{\mathbf x}_{N_t+L}+\overline{\mathbf v}_{N_rN}$$ |



####  **MIMO Channel Normalization**
Same as SISO case:
The MIMO channel are normalized jointly over all entries, that is
$$\boxed{\sum_{l=0}^L\sum_{i=0}^{N_r-1}\sum_{j=0}^{N_t-1}\mathbb E\big[|H[l]_{i,j}|^2\big]=N_rN_t}$$
Where the two summations over $i$ and $j$ can be compactly formulated with the **Frobenius** norm:
$$\sum_{l=0}^L\mathbb E\big[ \|H[l]\|_F^2\big]=\sum_{l=0}^L\mathbb E[\tr(HH^*)]=N_rN_t$$
####  **Precoding**
$$ $$
Recall the power decomposition of the SISO case
$$x[n]=\sqrt{E_s P[n]}\cdot s[n]\stackrel{\text{MIMO}}\longrightarrow \mathbf x[n]=\sqrt{\frac{E_s}{N_t}}\mathbf F[n]\mathbf s[n]$$
with $N_s\leq N_t$, $N_s$ the size of the $\mathbf s$ vector and thus the concurrent data streams. (if more signals than antennas information is lost, duh) ^807fea

The codwords are IID:
$$\E[\mathbf s[n]\mathbf s^*[n]]=I$$
and $F[n]$ must be normalized
$$\frac1 N\sum_{n=0}^{N-1}\|\mathbf F[n]\|_F^2=\frac1 N\sum_{n=0}^{N-1}\tr(\mathbf F[n]\mathbf F^*[n])=N_t$$
In this way the covariance is:
$$R_x=\E[xx^*]=\frac{E_s}{N_t}\E[Fss^*F^*]=\frac{E_s}{N_t}\E[FIF^*]=\frac{E_s}{N_t}F[n]F^*[n]$$
where the i-th diagonal holds the avg power of the i-th antenna and the off diagonals show the correlation between antenna $R_{x_{i,j}}$ i and j.

| Case                       | SISO       | MIMO                                                 |
| -------------------------- | ---------- | ---------------------------------------------------- |
| $s[n]$ power               | unit power | All symbols: $N_s$<br>Single symbol: unit power      |
| $x[n]$ instantaneous power | $E_sP[n]$  | Diagonal of $\displaystyle\frac{E_s}{N_t}F[n]F^*[n]$ |
| average $x[n]$ power       | $E_s$      | Over all antennas:<br>$E_s$                          |

the [singular value decomposition](#^2c6539)  can be used to rewrite $F$:
$$F[n]=
\underset{\substack{\uparrow\\\text{Beam}\\\text{Steering}\\\text{Matrix}}}{U_F[n]}
\underset{\substack{\uparrow\\\text{Power}\\\text{Allocation}\\\text{Matrix}}}{\Sigma_F[n]}
\underset{\substack{\uparrow\\\text{Mixing}\\\text{Matrix}}}{V_F^*[n]}
$$
With:
- $U_F$, $V_F$ unitary and respectively $N_t\times N_t$, $N_s\times N_s$
- $\Sigma_F=\begin{bmatrix}P^{1/2}\\0\end{bmatrix}$ $N_t\times N_s$ matrix where $P^{1/2}$ is a square diagonal $N_s\times N_s$ matrix with the values $P_0, ...,P_{N_s-1}$

####  **Signal constraints**
Power constraints:

|                        | SISO                                                         | MIMO                                                                                    |
| ---------------------- | ------------------------------------------------------------ | --------------------------------------------------------------------------------------- |
| Per block              | $$\frac{1}{N}\sum_{n=0}^{N-1} \mathbb{E}[\|x[n]\|^2] = E_s$$ | $$\frac1N\sum_{n=0}^{N-1}\E[\|x[n]\|^2]=E_s\iff \frac1N\sum_{n=0}^{N-1}\tr(R_x)=E_s$$   |
| Per block in precoder  | $$\frac1N\sum_{n=0}^{N-1}P[n]=1$$                            | $$\frac1N\sum_{n=0}^{N-1}\tr(F[n]F^*[n])=N_t\iff \frac1N\sum_{n=0}^{N-1}\tr(P[n])=N_t$$ |
| Per symbol             | $$\E[\|x[n]\|^2]=E_s$$                                       | $$\E[\|x[n]\|^2]=E_s\iff\tr(R_x)=E_s$$                                                  |
| Per symbol in precoder | $$P[n]=1$$                                                   | $$\tr(F[n]F^*[n])=N_t\iff\tr(P[n])=N_t$$                                                |
| Per antenna            | $$[R_x] = E_s$$                                              | $$[R_{x}]_{j,j}=\frac{E_s}{N_t}$$                                                       |

Magnitude:
TODO (?)

## 4.3) Linear Channel Equalization
####  **Basic Formulation**
Start with a scalar channel
$$w^*(z)\sqrt Gh(z)=z^{-\Delta}$$
where $\Delta$ is the delay (in taps) as a design parameter. 
The ideal equalizer is:
$$w^*(z)=\frac1{\sqrt G}\frac1{h(z)}$$
so that $(h*w^*)(z) =\delta(n-\Delta)$ ^96193a

This is applied to a FIR channel of length $L$ and a FIR equalizer ($L_{eq}$) must be found.

#### **MIMO Case**
In the MIMO case the **left inverse of H that satisfies**
$$W^*(z)\sqrt GH(z)=D(z)$$
where is a diagonal matrix with the allowed delays $D(z)=\text{diag}(e^{-\Delta_0},...,e^{-\Delta_{N_t-1}})$.
Special care must be put on $H(z)$. 
Let $H(z)=\displaystyle\sum_{l=0}^L H[l]z^{-l}$ be the matrix containing the z transform of the i,j-th entry ($H[z]_{i,j}=h^{i,j}(0),...,h^{i,j}[L]$).

>[!thm] Theorem on FIR left inverses
>**A MIMO transfer function H(z) has a FIR left inverse iff H(z) has full column rank $\forall z\not=0$**
>It also turns out that:
>(!exam candidate) 
>**It turns out that an exact FIR ZF MIMO inverse exists for $N_r>N_t$ As long as the entries of H do not share a common root (coprime), then a FIR inverse exists**

In the time domain the ZF eq is
$$\sqrt G\sum_{l=0}^{L_{eq}}W^*[l]H[n-l]=\text{diag}(\delta[n-\Delta_0],...,\delta[n-\Delta_{N_t-1}])$$
only the j-th row of $W$ contributes to the eq of the j-th antenna. This implies that the analog expression for each row must hold on its own. 
$$\sqrt G\sum_{l=0}^{L_{eq}}w_j^*[l]H[n-l]=d_j^*[n]$$
Written in the stacked vector representation  we have that:
![[Pasted image 20260111144139.png|Formula|300]]
From before we have that **T must be full rank for perfect recoverability** and thus solutions exist only for $N_r\geq N_t$. Moreover $\text{size }T=N_r(L_{eq}+1)\times N_t(L_{eq}+L+1)$ and thus we have:
- **T is fat:** overdetermined $\rightarrow$ no solution, usually choose so to minimize squared error
- **T is square:** underdetermined $\rightarrow$ one exact solution $w_j^{ZF}=\frac1{\sqrt G}( T^*)^\dagger d_j$
- **T is tall:** under determined, infinite solutions: choose minimum norm: $w_j^{ZF}=\frac1{\sqrt G}T(T^*T)^{-1}d_j$

In general recalling [[#^3a6391]] unifies all these cases.
$$\boxed{W^{ZF}=\frac1{\sqrt G}(T^\dagger)D^*}$$

- $N_t>N_r\rightarrow$ Fat $\rightarrow$ no perfect solution $\rightarrow$ Least Squares
- $N_t=N_r\rightarrow$ Square $\rightarrow$ $L=0$ frequency flat channel $\rightarrow$ a single tap $L_{eq}=0$ sufficient for perfect ZF
- $N_r>N_t\rightarrow$ Tall $\rightarrow$ many perfect solutions $\rightarrow$ Minimum Norm

If no perfect ZF solution exists, then the error is given by
$${\hat x[n]=x[n-\Delta]-\sum_{L=0}^{L_{eq}}W^*[l]y[n-l]}$$
where the summation can be rewritten by stacking as usual (y from $n$ to $n-L_{eq}$)
####  **LMMSE Eq**
We obtain the following:
![[Pasted image 20260111164314.png|LMMSE Eq|350]]
if IID we have
$$\begin{align}
W^{MMSE}&=\frac1{\sqrt G}\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD\\
E&=\frac{E_s}{N_t}I-\frac{E_s}{N_t}D^*T^*\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD
\end{align}$$
(!possible exam) if there is no noise (SNR$\rightarrow\infty$) then the error goes to 0:
$$E\stackrel{SNR\rightarrow\infty}\longrightarrow \frac{E_s}{N_t}I-\frac{E_s}{N_t}D^*T^*(TT^*+0)TD=\frac{E_s}{N_t}I-\frac{E_s}{N_t}\underbracket{D^*T^*\underbrace{(TT^*)}_{I}TD}_{I}=\frac{E_s}{N_t}I-\frac{E_s}{N_t}I=0$$

|                                      | Equalizer                                                      | Error                                                                          |
| ------------------------------------ | -------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| Linear ZF Scalar                     | $$w^*(z)=\frac1{\sqrt G}\frac1{h(z)}$$                         |                                                                                |
| Linear ZF MIMO                       | $${W^{ZF}=\frac1{\sqrt G}(T^\dagger)D^*}$$                     | $${\hat x[n]=x[n-\Delta]-\sum_{L=0}^{L_{eq}}W^*[l]y[n-l]}$$                    |
| LMMSE<br>(IID and/or frequency flat) | $$W^{MMSE}=\frac1{\sqrt G}\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD$$ | $$E=\frac{E_s}{N_t}I-\frac{E_s}{N_t}D^*T^*\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD$$ |
| Linear ZF Frequency Flat             | $$W^{ZF}=\frac1{\sqrt G}H^\dagger$$                            | $$0$$                                                                          |

####  **Single-Carrier Frequency Domain Eq**
Suppose a channel of $L$ taps and a DFT of length $K$, $K>L$, then the convolution becomes a circular convolution, that is, x has modulo $K$ inside and $h$ is zero padded. ^e5a5dc
$$\begin{align}
y[n]&=\sqrt G\sum_{l=0}^{K-1}h[l]x[(n-l)_K]\\
&=\begin{cases}
\sqrt G\par{\displaystyle\sum_{l=0}^nh[l]x[n-l]+\sum_{l=n+1}^Lh[l]x[n+K-l]}&n=0,...,L-1\\
\sqrt G\displaystyle\sum_{l=0}^Lh[l]x[n-l] & n=L,...,K-1
\end{cases}
\end{align}$$
to avoid this mismatch we use a cyclic prefix ($L_c\geq L$):
$$x[n]\not=0 \forall n\in\curly{0,..,K-1}\rightarrow \overline x[n]=\begin{cases}
x[n+K]&n=L_c,...,-1\\
x[n] & n=0,...,K-1\end{cases}\not=0, \forall n\in\curly{0,..,L}$$
so that $x[(n-l)_K]=\overline x[n-l], \forall l\in\curly{0,...,L}$

The output also contains a cyclic prefix but can be discarded as it is redundant information.

Estimation happens by doing the IDFT 
$$\mathbf{\hat x}=\mathbf U^*\text{diag}\par{\frac1{\sqrt Gh[0]},...,\frac1{\sqrt Gh[K-1]}}\mathbf U\mathbf y$$
with U a Fourier matrix and $h$ the DFT of the channel.

####  **MIMO Case**
Vectorize as usual, now the eq is the following:
$$\mathbf{\hat x}=\frac1{\sqrt G}IDFT\curly{H^\dagger[k]\mathbf y[k]}$$



## 4.4) (!exam candidate) Orthogonal Frequency Division Multiplexing (OFDM)
#### **Base OFDM**
OFDM transmits K signals over some subcarriers in parallel. The subcarriers are orthogonal in frequency. 
Coding takes place in frequency, the IDFT is TXed and L samples in the cyclic prefix are added.
The receiver computes the DFT, removes the cyclic prefix, and can then estimate the signal by ZF.


|                              | Standard                     | OFDM                                                    |
| ---------------------------- | ---------------------------- | ------------------------------------------------------- |
| ISI                          | Yes (if frequency selective) | No (if $L\geq L_h$), all subcarriers are frequency flat |
| Tx Time of block of size $T$ | $T$                          | $(K+L)T$, band guard interval $LT$ penalty              |
| Carrier                      | $B$                          | $K$ orthogonal subcarriers of size $B/K$                |
| Spectral Efficiency          | $100\%$                      | $\frac K{K+L}$                                          |


Let's do it step by step:
Block of $K$ symbols which is also DFT length,  $L$ cyclic prefix, length of channel $L_h\leq L$
Subcarriers $e^{j\frac{2\pi}K nk}$ at frequency $k/K$.

- **Transmitter:**
The block of the signals in frequency is: $x_f[0],...,x_f[K-1]$
The IDFT is computed as $x_t[n]=\displaystyle\frac1K\sum_{k=0}^{K-1}x_f[k]\underbrace{e^{j\frac{2\pi}Knk}}_{\text{subcarrier}} \forall n\in\curly{0,...K-1}$
The cyclic prefix of length L is added $\mathbf{\overline x}_t=[x_t(-L),...,x_t(-1),x_t[n]]$ where $x_t(-a)=x_t(K-a)$ or also $\overline x_t[n]=\begin{cases}x_t[n+K]&n=-L,...,-1\\ x_t[n]& n=0,...,K-1\end{cases}$
Notice that the IDFT of $x_f[k]$ can also be extended to $n\in\curly{-L,...K-1}$ and results in the cyclic prefix output.

Verify (!exam candidate):
$$\begin{align}
\overline x_t[n\in\curly{-L,...,-1}]&=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}Knk}\\
&=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}Knk}\underbrace{e^{j\frac{2\pi}KKk}}_{=1}\\
&=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K(K+n)k}= x_t[K+n]
\end{align}$$
This means that
$$\overline x_t[n]=\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}Knk}=
\begin{cases}\displaystyle
\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}Knk}&=x_t[n]&n=0,...,K-1\\
\displaystyle
\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K(K+n)k}&=x_t[n+K] &n=-L,...,-1
\end{cases}$$

so for example if we need $\overline x_t[-1]=\displaystyle\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K(K-1)k}=x_t[n-1]$.

- **Channel:**

Since for $n\in\curly{-L,...,-1}$ we need taps of the previous block, we don't calculate them and only keep values for $n\in\curly{0,...,K-1}$ and therefore $y_t[n]$ doesn't have the cyclic prefix.

Notice that
$$y_t[-1]=\sqrt G\sum_{l=0}^{L-1}h_t[l]\overline x_t[n-l]+\sqrt Gh_t[L]\overline x_t[-1-L]$$
in general
$$y_t[n] = \begin{cases}
\displaystyle
\sqrt{G} \sum_{l=0}^{L} h_t[l] \overline x_t[n-l] &n=0,...,K-1 \\
\displaystyle
\sqrt{G} \sum_{l=0}^{L+n} h_t[l] \overline x_t[n-l] + \sqrt G\sum_{l=L+n+1}^{L} h_t[l] \overline x_t[n-l + K] &n=-L,...,-1
\end{cases}$$
so by doing the **cyclic prefix removal** we just keep the first part.

This already shows that the channel is a convolution in time so a product in frequency

- **Receiver:**
First we do **cyclic prefix removal** on the received signal $y[n]$ (in time) so to then do the DFT and have all $\tilde y[k]$ of the block in frequency.
$$\tilde y_f[k]=\sum_{p=0}^{K-1}y_f[p]e^{-j\frac{2\pi}Knp}$$
Now the full relation starting from $x_f[n]$ is found (I used n instead of k for simplicity in notation):
$$\begin{align}
\tilde y_f[n]&=\sum_{p=0}^{K-1}y_t[p]e^{-j\frac{2\pi}Knp}\\
&=\sum_{p=0}^{K-1}\sqrt G\sum_{l=0}^{L} h_t[l] \overline x_t[p-l]e^{-j\frac{2\pi}Knp}\\
&=\sum_{p=0}^{K-1}\sqrt G\sum_{l=0}^{L} h_t[l]\frac 1K \sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K(p-l)k}e^{-j\frac{2\pi}Knp}\\
&=\frac{\sqrt G}{K}\sum_{k=0}^{K-1}\par{\sum_{l=0}^{K-1}h_t[l]e^{-j\frac{2\pi}Klk}}x_f[k]\sum_{p=0}^{K-1}e^{j\frac{2\pi}Kp(k-n)}\\
&=\sqrt G\sum_{k=0}^{K-1}h_f[k]x_f[k]\delta(k-n)\\
&=\sqrt Gh_f[n]x_f[n]
\end{align}$$
Lets go step by step:
- First $y[p]$ was rewritten using the DFT formula.
- Then $\overline x[n]$ was rewritten using the IDFT formula.
- Then: (i) the constants were extracted (ii) the exponents were rewritten so that 
$$\begin{align}\exp{j\frac{2\pi}K(p-l)k}\exp{-j\frac{2\pi}Knp}&=\exp{j\frac{2\pi}K\par{pk-lk-np}}\\
&=\exp{-j\frac{2\pi}Klk}\exp{j\frac{2\pi}{K}p(k-l)}\end{align}$$
and then (iii) the sums were rearranged.
- Then notice that (i) $\sum_{l=0}^{K-1}h[l]e^{-j\frac{2\pi}Klk}=h[k]$ is the DFT and (ii) $\sum_{p=0}^{K-1}e^{j\frac{2\pi}Kp(k-n)}$ is K times the IDFT of $\delta(k-n)$.
- The final expression is done by simplifying the Kronecker delta and noticing that is is zero for all $k\not=n$.

The suffixes are used to indicate if time or frequency.

The whole OFDM stack goes in these steps:
$$x_f\stackrel{\text{IDFT+Cyclic Prefix}}\longrightarrow\overline x_t\stackrel{\text{Channel+Removed Prefix}}\longrightarrow y_t\stackrel{DFT}\longrightarrow \tilde y_f$$
The last formula can simplify in just $x_f\rightarrow \tilde y_f$.

The book offers a slightly different version of the proof, starting from $x_f[k]$ and finding $y_t[n]$:
$$\begin{align}
y_t[n]&=\sqrt G\sum_{l=0}^{L}h_t[l]\overline x_t[n-l]\\
&=\sqrt G\sum_{l=0}^{L}h_t[l]\frac1K\sum_{k=0}^{K-1}x_f[k]e^{j\frac{2\pi}K(n-l)k}\\
&=\frac{\sqrt G}{K}\sum_{k=0}^{K-1}\par{\sum_{l=0}^{L}h_t[l]e^{j\frac{2\pi}Klk}}x_f[k]e^{-j\frac{2\pi}Knk}\\
&=\sqrt G\cdot \frac1K\sum_{k=0}^{K-1}h_f[k]x_f[k]
\end{align}$$
which is the IDFT of $\tilde y_f[k]$: $y_t[n]=IDFT\par{\hat y_f[k]}=IDFT\par{\sqrt Gh_f[k]x_f[k]}$. Or equivalently the DFT of $y_t[n]$ is $\tilde y_f[k]$:  $\tilde y_f[k]=DFT\par{y_t[n]}=DFT\par{\sqrt G\cdot \frac1K\sum_{k=0}^{K-1}h_f[k]x_f[k]}=\sqrt G h_f[k]x_f[k]$

(!exam candidate)
This result ($y_f[k]=\sqrt G h_f[k]x_f[k]$) shows that for each subcarrier there is the received signal $\tilde y[k]$ that depends only on the channel and signal of that subcarrier.

####  **Estimation:**
With absence of noise a simple eq is used:
$$\hat x_f[k]=\frac{\tilde y_f[k]}{\sqrt G h_f[k]}$$
With noise notice that $v_t[n]\approx v_f[k]$ (TODO Appendix C1.6) with the same ZF eq the variance of the output noise becomes $$\frac{N_0}{G}\frac1{|h_f[k]|^2}$$
#### **MIMO OFMD**
MIMO-OFDM gives a frequency flat equivalent model, justifying its extensive treatment
With OFDM, the equalizer complexity becomes independent of the channel length, but with a spectral efficiency penalty
$$\mathbf y[k]=\sqrt G\mathbf H[k]\mathbf x[k]+\mathbf v[k]$$
## 4.5) Channel Estimation
#### **Intro**
For channel estimation some well known signals, called pilot signals $p[0],...,p[N_p-1]$ where $p[]$ is a $N_t\times 1$ vector. These signals are sent through a $L$ tap channel $\sqrt G H[l]$ and from the received signals a estimation on the channel can be made.

To implicitly do the convolutions, build the $N_r\times N_t(L+1)$ channel matrix 
$$\overline H=[H[0], ..., H[L]]$$
And the $N_t(L+1)\times N_p-L$ pilot matrix
$$\overline P=\begin{bmatrix}
p[L]&p[L+1]&....&p[N_p-1]\\
p[L-1]&p[L+2]&...&p[N_p-2]\\
\vdots&\vdots&\vdots\\
p[0]&p[1]&...&p[N_p-L-1]
\end{bmatrix}$$
so to have
$$\overline Y=\sqrt G\ \overline H \ \overline P+\overline V$$
alternatively using stacked vectors and Kroenecker product (TODO)

#### **ML and Least-Squares Estimation**
Since everything expect the noise is known, we can estimate $H$ by finding the ML estimation, which equals to the least squares.
Notice that $y|h\sim\complexgauss(\sqrt G P_{\otimes}h, N_0)$
Moreover the max estimation of the ML has constants that can be ignored so the problem can be reduced as follows:
$$\text{vec} [\hat H](y)=\arg\max_hf_{y|h}(y|h)=\arg\max_h\frac1{\det(\pi R)}e^{\frac{|y-\mu|^2}R}\rightarrow\arg\min_h|y-\mu|^2$$
By applying the least squares with a linear estimator estimator we have
$$\boxed{\text{vec}[\hat H](y)=\frac1{\sqrt G}(P_\otimes^*P_\otimes)^{-1}P_\otimes^*y\rightarrow \hat H=\frac1{\sqrt G}YP_{\otimes}^*(P_{\otimes}P_{\otimes}^*)^{-1}}$$
where [moore penrose](#^3a6391) again choses the solution.
- overdetermined: Tall, minimum distance (least squares)
- underdetermined: fat, minimum norm

And the MSE matrix is
$$\boxed{E=\frac{N_0}G(P_\otimes^*P_\otimes)^{-1}}$$
TODO simplify LSE

#### **LMMSE Estimator**
Just these formulas and the exercises
$$W_{MMSE}=\sqrt GP_\otimes(N_0R_{\text{vec}\hat H}^{-1}+GP_\otimes^*P_\otimes)^{-1}$$
$$\text{vec}\hat H=W_{MMSE}^*y$$
and the MMSE
$$E=R_{\text{vec}\hat H}-GR_{\text{vec}\hat H}^*P_\otimes^*(GP_\otimes R_{\text{vec}\hat H}P_\otimes^*+N_0I)^{-1}P_\otimes R_{\text{vec}\hat H}$$


|           | ML/Least Squares                                                                                                                                                                 | LMMSE                                                                                                                                             |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| Estimator | $$\begin{align}\text{vec}[\hat H](y)&=\frac1{\sqrt G}(P_\otimes^*P_\otimes)^{-1}P_\otimes^*y\\ \hat H&=\frac1{\sqrt G}YP_{\otimes}^*(P_{\otimes}P_{\otimes}^*)^{-1}\end{align}$$ | $$\text{vec}\hat H=\par{(\sqrt GP_\otimes(N_0R_{\text{vec}\hat H}^{-1}+GP_\otimes^*P_\otimes)^{-1}}^*y$$                                          |
| MMSE      | $${E=\frac{N_0}G(P_\otimes^*P_\otimes)^{-1}}$$                                                                                                                                   | $$E=R_{\text{vec}\hat H}-GR_{\text{vec}\hat H}^*P_\otimes^*(GP_\otimes R_{\text{vec}\hat H}P_\otimes^*+N_0I)^{-1}P_\otimes R_{\text{vec}\hat H}$$ |

## 4.6) Exercises (Textbook & Professor)
$$ $$
>[!example|2.1, 2.2] Tapped Delay Line
>Consider a signal that propagates from transmitter to receiver incurring a delay $\tau_0$ and
experiencing a complex amplitude gain $A_0$. Determine $c_p, c_b$.
> We can find the passband version:
> $$c_p(\tau)=A_0\delta(\tau-\tau_0)$$
> Now the baseband version:
> $$\begin{align}c_b(\tau)&=g_{B/2}(\tau)*(c_p(\tau)e^{-j2\pi f_c\tau})\\
&=A_0B\sinc(B(\tau-\tau_0)e^{-j2\pi f_c \tau_0}
 \end{align}$$
 > Now consider another ray with a different delay $\tau_1$ and amplitude $A_1$:
 > $$c_p(\tau)=\sum_{i=0}^{1}A_i\delta(\tau-\tau_i)$$
 > and therefore $c_b$ is:
 > $$c_b(\tau)=\sum_{i=0}^{1}A_iB\sinc(B(\tau-\tau_i))e^{-j2\pi f_c \tau_i}$$
 
 >[!example| 2.3, 2.4] Time Discretized Tapped Delay Line
 >Determine the discrete time complex baseband response of 2.1:
 >Set $T=1/B$ and the sampling $lT$, then
>$$\begin{align}c[l]&=TAB\sinc(B(\tau-\tau_0))e^{-j2\pi f_c\tau_0}|_{\tau=lT}\\
 &=A\sinc (l-\frac {\tau_0} T )e^{-j2\pi f_c \tau}\end{align}$$
 > by setting the sampling at $lT+\tau_0$ we have
 > $$c[l]=A\sinc(l)e^{-j2\pi f_c\tau_0}=A\delta(l)e^{-j2\pi f_c \tau_0}$$
 > In the tapped delay line we have:
>$$\begin{align}c[l]&=\sum_{i=0}^{N-1} A_i\sinc(B(lT+\phi-\tau_i))e^{-j2\pi f_ct}\\ 
&\stackrel{\phi=\tau_0}=A_0\delta(l)e^{-j2\pi f_c\tau_0}+\sum_{i=1}^{N-1}A_i\sinc(l-\frac{\tau_i-\tau_0}T)e^{-j\pi f_c \tau_i}
\end{align}$$
> Which inevitably introduces ISI if at least one $\tau_i$ is not a integer multiple of $\tau_0$.

Recall the properties of the sinc function: $\sinc(a)=a, \forall a\in \mathbb N/\curly 0$

>[!col]
>![[Pasted image 20260110122634.png|Frequency Flat Channel|250]]
>
>![[Pasted image 20260110122723.png|Frequency Selective Channel|250]]

In fact the first channel can be obtained from $c(\tau)$ by recalling that $\delta[Tl]=\frac1T\delta[l]$. While the second channel cannot be correctly obtained as it is not single tap:
$$c(\tau)\stackrel{lT+\tau_0}\rightarrow c[l]=A_0\delta(l)e^{-j2\pi f_c\tau_0}\sum_{i=1}^{N-1}A_i\delta(l-\frac{\tau_i-\tau_0}{T})e^{-j2\pi f_c\tau_i}$$
Moreover, to follow the prof exercise 2.8 we have that if $\phi=\tau_1$, then a different channel arises:
$$c[l]=A_1\delta(l)e^{-j2\pi f_c \tau_1}+\sum_i A_i\sinc(l-\frac{\tau_i-\tau_1}{T})e^{-j2\pi f_c\tau_i}, \ i \in \curly{1,2,...,N-1}/\curly 1$$

>[!example|2.10] Showing Of precoding Workings
>Let $N_t=N_s=2$ and suppose that the two signals in $s[n]$ are QPSK distributed. Examine $x[n]$ with a time invariant precoder:
>
>Recall:
>$$x[n]=\sqrt\frac{E_s}{N_t}Fs=\sqrt\frac{E_s}{N_t}U\Sigma V^*s$$
>First calculate $V^*s=\begin{bmatrix}V_{00}^*s_0+V_{10}^*s_1\\ V_{01}^*s_0+V_{11}^*s_1\end{bmatrix}=[a,b]^T$. This is the mixing signal matrix, in fact it creates two new signals $a,b$ that are a mix of the original signals.
>
>Then $\Sigma V^*s=[P_0a,P_1b]^T$. This is the power allocation matrix (in this case $\Sigma=P^{1/2}$) and allocates different powers to the different signals.
>Finally $U\Sigma V^*s=\begin{bmatrix}U_{00}a+U_{01}b\\ U_{10}a+U_{11}b\end{bmatrix}=[\alpha,\beta]^T$. This is the beam matrix and in fact it mixes the two new signals with allocated powers to create the final output signal for each antenna (row).
>Then we have:
>$$x[n]=\sqrt\frac{E_s}{N_t}\begin{bmatrix}\alpha\\\beta\end{bmatrix}=
\sqrt\frac{E_s}{N_t}\begin{bmatrix}U_{00}P_0(V_{00}^*s_0+V_{10}^*s_1)+U_{01}P_1(V_{01}^*s_0+V_{11}^*s_1)\\ U_{10}P_0(V_{00}^*s_0+V_{10}^*s_1)+U_{11}P_1(V_{01}^*s_0+V_{11}^*s_1)\end{bmatrix}$$
>This normalizes the average power.

>[!example|2.15, 2.16] Two Tap Channel ZF Equalizer 
>For a two tap channel where $\sqrt Gh[0]=1, \sqrt Gh[1]=-a$ find an IIR equalizer with $\Delta=1$.
>
>First find transform of $h[n]=\delta(n)-a\delta(n-1)\zeta 1-az^{-1}$
>therefore we have:
>$$w(z)=\frac1{\sqrt G}\frac{z^-1}{1-az^{-1}}\zeta^{-1}w[l]=\frac1{\sqrt G}a^{l-1}u[l-1]$$
>Where an appropriate FIR equalizer can be found by truncating.

>[!example| 2.18, 2.19] Linear ZF Equalizer For Frequency Flat Channels
>Compute the Zf equalizer for frequency flat channels with $N_r\geq N_t$ (perfect recoverability, tall) and prove the error is null.
>Frequency flat (L=0), then $T=H$ and $L_{eq}=0$ and no delay $D=I$, then 
>$${W^{ZF}}^*=\frac1{\sqrt G}H^\dagger$$
>The error is found by recalling that $H$ is tall (underdetermined), by moore penrose $H^\dagger=(H^*H)^{-1}H^*$ and thus
>$$\sqrt G \frac1{\sqrt G}{W^{ZF}}^*H=(H^*H)^{-1}H^*H=I$$

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



---

>[!exercise|2.9] Different Channel Representations
>Let $N_t=1$ and $N_r=2$ with
>$$\begin{align}
c^{(0,0)}(\tau)&=A_0\delta(\tau-\tau_0)\\
c^{(1,0)}(\tau)&=A_1\delta(\tau-\tau_1)+A_2\delta(\tau-\tau_2)
\end{align}$$
> - Determine the pseudo baseband channel:
>$$\begin{align}
c_{pb}^{(0,0)}(\tau)&=A_0\delta(\tau-\tau_0)e^{-j2\pi f_c \tau_0}\\
c_{pb}^{(1,0)}(\tau)&=A_1\delta(\tau-\tau_1)e^{-j2\pi f_c \tau_1}+A_2\delta(\tau-\tau_2)e^{-j2\pi f_c \tau_2}
\end{align}$$
> - Determine the baseband channel:
> $$\begin{align}
c_{b}^{(0,0)}(\tau)&=BA_0\sinc(B(\tau-\tau_0))e^{-j2\pi f_c \tau_0}\\
c_{b}^{(1,0)}(\tau)&=BA_1\sinc(B(\tau-\tau_1))e^{-j2\pi f_c \tau_1}+BA_2\sinc(B(\tau-\tau_2))e^{-j2\pi f_c \tau_2}
\end{align}$$
> - Determine the complex baseband channel in frequency domain:
> $$\begin{align}
c_{b}^{(0,0)}(\tau)&=A_0\rect(\frac\tau B)e^{-j2\pi (f_c +f)\tau_0}\\
c_{b}^{(1,0)}(\tau)&=A_1\sinc(\frac\tau B)e^{-j2\pi (f_c +f)\tau_1}+A_2\sinc(\frac\tau B)e^{-j2\pi (f_c +f)\tau_2}
\end{align}$$
> By recalling that $\sinc(Bx)\fourier\frac1B\sinc(\frac fB)$ and $x(t-t_0)\fourier x(f)e^{-j2\pi f t_0}$
> - Determine time discrete baseband channel:
> $$\begin{align}
c_{b}^{(0,0)}(l)&=A_0\sinc(l-B\tau_0))e^{-j2\pi f_c \tau_0}\\
c_{b}^{(1,0)}(l)&=A_1\sinc(l-B\tau_1)e^{-j2\pi f_c \tau_1}+A_2\sinc(l-B\tau_2)e^{-j2\pi f_c \tau_2}
\end{align}$$

>[!todo]
>all exercises on ZF

# 5) Channel modeling
#### **Basics**
Many non-LoS paths exist (diffraction, reflection, refraction, scattering).
Two approaches are used to model the channel:
1) Deterministic: develop and use a site-specific description of the environment
2) Stochastic: channel models are random processes inspired by measurements

#### **Large Scale Phenomena**
The link budget formula in dB gives useful insights:
$$P_r[dB]=P_t[dB]+\underbrace{G_t[dB]+G_r[dB]-\par{L_p[dB]+\chi[dB]}}_{\text{large scale gain } G}$$
Where the large scale gain $G\ [dB]$ is the gain used until now, in linear scale it becomes:
$$G=\frac{G_tG_r}{L_p\chi}$$
Moreover $\chi$ is a zero mean gaussian rv representing shadowing. 
While the path loss is:
$$L_P(D)=K_{ref}\par{\frac{D}{D_{ref}}}^\eta\rightarrow L_p(D)[dB]=K_{ref}[dB]+10\eta\logt\par{\frac{D}{D_{ref}}}$$
It is possible that many functions with different parameters are used to model a channel with piecewise linear behavior.

The **path loss in free space is:**
$$L_P(D)[dB]=20\logt\par{\frac{4\pi D}{\lambda_c}}$$
#### **Small-Scale Fading**
Recall the [tapped delay line model](#^0ffb10):
Suppose $x(t)$ is a passband sinusoid, then with a narrowband signal with $\max_q \tau_q\gg 1/B$ the delays act as a phase shift:
$$x(t)=e^{j2\pi f_c t}\stackrel{channel}\longrightarrow y(t)=\sum_qA_qe^{j2\pi f_c(t-\tau_q)}=\sum_qA_qe^{-j2\pi f_c\tau_q}x(t)$$
clearly the channel can be simplified as
$$c(\tau)=\sum_q A_qe^{-j2\pi f_c\tau_q}\delta (\tau)$$
which can be rewritten as a **large scale component** $\sqrt G$ and a **small scale component** $h$ then $c=\sqrt G h$.

Model the small-scale channel response as a locally stationary complex rv $h=|h|e^{j\angle h}\sim\complexgauss(0,1)$, then (TODO Appendix C 1.9) the channel has these 3 properties:
- Uniform Phase: $\phi=\angle h\sim U(0,2\pi)$
- Rayleigh Magnitude: $f_{|h|}(\xi)=\xi\displaystyle e^{-\frac12\xi^2}$
- Exponential magnitude squared: $f_{|h|^2}(\xi)=e^{-\xi}$

If the multi path components dominate over the LoS, then rice fading can be used:
$$f_{|h|}(\xi)=2(K+1)\xi e^{-(K+1)\xi^2-K}I_0\par{2\sqrt{K(K+1)}\xi}$$
where 
- $K=0:$ rice equals Rayleigh
- $K\rightarrow\infty:$ rice is deterministic

#### **Power Angle Spectrum**
The PAS works with the **azimuth** angle and describes the Rx power as a function of the angle. 

By integrating the PAS in the angle the total received power is obtained.

>[!example|3.4] Clarke-Jake Uniform PAS
>The uniform PAS is
>$$\mathcal P(\theta)=\frac1{2\pi},\ \theta\in[-\pi,\pi)$$
>and therefore the total RX power is
>$$P=\int_{-\pi}^\pi \mathcal P(\theta)d\theta=1$$

>[!example| 3.7] Truncated Laplacian PAS
>The truncated Laplacian PAS is
>$$\mathcal P(\theta)=\frac{K_L}{\sqrt 2\sigma}\exp{-\left|\frac{\sqrt 2 (\theta-\mu)}{\sigma}\right|}, \ \theta\in[\mu-\pi,\mu+\pi)$$
>Where $$K_L=\frac1{1-\exp{-\sqrt 2 \pi/\sigma}}$$
>And in fact the integral, after many manipulations, is normalized to 1
>$$P=K_L\par{1-\exp{-\sqrt 2 \pi/\sigma}}=1$$

#### **Space Correlation**
Again, supposing $x$ a complex exponential being received at a given location
$$\begin{align}
y(t)&=\sqrt G\int_{2\pi}\sqrt {\mathcal P(\theta)G_r(\theta)}x(t-D(\theta)/C)d\theta\\
\\
y&=\sqrt G\int_{2\pi}\sqrt {\mathcal P(\theta)G_r(\theta)}xe^{-j\phi(\theta)}d\theta
\end{align}$$
Where $\phi(\theta)=2\pi D(\theta)/\lambda_c$
At a second location distanced $\Delta_d$ from the first one we have that $\phi'(\theta)=\phi(\theta)+2\pi\Delta_d\cos(\theta)/\lambda_c$

Their correlation in the case of **phase uniformly distributed in $-\pi,\pi$ is**
$$R_h(\Delta_d)=\E[h_0h_1^*]=\int_{-\pi}^{\pi}\mathcal P(\theta)G_r(\theta)e^{j2\pi\Delta_d\cos(\theta)\lambda_c}d\theta$$
This should be put to 0 for optimal reception.

For the Clarke-Jake PAS this equals to 
$$D_C=0.38\lambda_c\approx0.5\lambda_c$$
Also
$$T_c=\frac{D_c}{0.76 v}\approx D_c/v$$

#### **Time Correlation**
Let the **maximum doppler shift be**
$$\nu_M=\frac vcf_c$$
and the **doppler shift**
$$\nu=\nu_M\cos(\theta)$$
The previous result can be adopted as a signal sent while moving, so by integrating over the max doppler shift we have
$$R_h(\Delta_t=\Delta_d/v)\fourier S_h(\nu)=\frac{\mathcal P(-\arccos(\nu/\nu_M))+\mathcal P\arccos(\nu/\nu_M))}{\sqrt{\nu_M^2-\nu_M}}, \ \nu\in[-\nu_m,\nu_m]$$

And for the Clarke Jake PAS this equals to the **horned doppler spectrum**
$$R_h(\Delta_t)=J_0(2\pi\nu_M\Delta_t)\fourier S_h(\nu)=\frac1{\pi\sqrt{\nu_M^2-\nu_M}}, \ \nu\in[-\nu_m,\nu_m]$$


|                                                         | General                                                                                                                                                     | Clarke-Jakes                                                                          |
| ------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| Space Selectivity: PAS                                  | $$\mathcal P(\theta)$$                                                                                                                                      | $$\mathcal P(\theta)=\frac1{2\pi}$$                                                   |
| Space Correlation: phase $\phi(\theta)\sim U[-\pi,\pi$] | $$R_h(\Delta_d)=\E[h_0h_1^*]=\int_{-\pi}^{\pi}\mathcal{P}Ge^{j2\pi\Delta_d\cos(\theta)\lambda_c}d\theta$$                                                   | $$R_h(\Delta_d)=J_0(2\pi\Delta_d/\lambda_c)$$<br>$$D_c=0.38\lambda_c$$                |
| Time Correlation: Time and Frequency                    | $$R_h(\Delta_t=\Delta_d/v)$$$$S_h(\nu)=\frac{\mathcal P(-\arccos(\nu/\nu_M))+\mathcal P\arccos(\nu/\nu_M))}{\sqrt{\nu_M^2-\nu_M}}, \ \nu\in[-\nu_m,\nu_m]$$ | $$R_h(\Delta_t)=J_0(2\pi\nu_M\Delta_t)$$$$ S_h(\nu)=\frac1{\pi\sqrt{\nu_M^2-\nu_M}}$$ |



#### **Coherence Time**
The coherence time is the measure of the time duration over which the wireless channel is considered "static" or constant.
$$T_c\gg T_s\quad T_c=\frac1{2\nu_M}\propto\frac1{\nu_M}, \quad\nu_m\ll B$$

#### **Discrete Time Model**
In this case
$$R_h(lT)\qquad \frac1TS_h(\frac\nu T)$$


In the block fading model the number of single carrier symbols per block is
$$N_c=\frac{T_c}T=BT_c\stackrel{\text{IID Blocks}}\longrightarrow \frac1{2\nu_m T}$$
Moreover in OFDM we have that
$$N_c=\frac K{K+L}T_cB_c\approx T_cB_c$$
#### **Frequency selective Channels, Power Delay Spread**
If the channel has large enough bandwidth then it is not possible to model a block in which the channel is constant. In this case the channel is called frequency selective and it is not moltiplicative anymore, but convolutional:

>[!def] Delay Spread
>The maximum delay between the multi path signal is called delay spread:
>$$\max_{i,j}|\tau_i(t)-\tau_j(t)|=\tau_m\def\text{Delay Spread}$$

If the Delay spread is much smaller than the symbol time, the channel is frequency flat
$$\tau_m\ll B_u^{-1}\approx T_s\implies\tau_i(t)\approx\tau_j(t)\approx\hat\tau \ \forall i,j\rightarrow h(\tau)=h\delta(\tau)$$
Here **gain is constant across frequency and the estimation of g(t) suffices to compensate for phase and amplitude displacements**

However if the delay spread is not much smaller than the symbol time, the channel receives signals from different blocks.

The **received power as a function of delay (normalized)** is called **Power Delay profile (PDP)** and can be interpreted as a PDF.
$$S_h(\tau)=\E[|h(\tau)|^2]$$
It has the following mean and variance:
$$\begin{align}
&\mu_\tau=\int\tau S_h(\tau)d\tau&\longrightarrow&\sum_{q=0}^{Q-1}\tau_qP_q&\\
&\sigma^2_\tau=T_d=\sqrt{\int(\tau-\mu_\tau)^2s_h(\tau)d\tau}&\longrightarrow&\sqrt{\sum_{q=0}^{Q-1}(\tau_q-\mu_q)^2P_q}
\end{align}$$
and then the frequency flat condition can be rewritten as $$B_c\gg B\text{ or }T_d\ll T$$
Recap of all equivalent frequency flat conditions:
$$\boxed{\text{Frequency Flat iff: }\tau_m\ll T_s\iff T_d\ll T_s\iff B_c\gg B}$$
**If the symbols are uncorrelated, then the fourier transform of the PDP is he frequency domain correlation $R_h(\Delta_f)$ (depends only on $\Delta_f$, wide sense stationary)**
$$R_h(\Delta_f)=\int S_h(\tau)e^{j2\pi \Delta_f\tau}d\tau$$
if $\E[h(\tau_0)h(\tau_1)]=0$ uncorrelated scattering
And from here we have that 
$$B_c\propto\frac1{T_d}$$
Moreover wireless fading is **underspread:**
$$T_d\ll T_c, \ \nu_M\ll B_c\rightarrow B_cT_c\gg1$$

## 5.2) Exercises (Textbook & Professor)#

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

