# 1) Recap on P.T.
Events $\subseteq$ Outcome $\subseteq$ $\Omega$ (PT space)
$$P[\emptyset]\leq P[A]\leq P[\Omega]=1$$
**Probability Union**
$$P[A\cup B]=P[A]+P[B]-P[A\cap B]$$
**Disjoint:**
$$A_i\cap A_j=\emptyset \ \forall i\not=j:\bigcup_i A_i=\Omega$$
**Law of total probability:**
$$P[B]=\sum_i P[A_i\cap B]$$
**Independence:**
$$P[A\cap B]=P[A]P[B]\implies A,B\text{ independent}$$
**Cumulative Distribution Function (CDF):**
$$F(x)= P[X\leq x]=\int_{-\infty}^xp_X(x)dx$$
- $F(x)\in [0,1]$
- Non decreasing
- *Right* continuous

**Expectation:**
$$\E[g(X)]=\sum_i g(x_i)P[x_i]$$
spooky scary stuff (this notation means sum in discrete case and int in continuous)
$$\E[g(x)]=\int_{-\infty}^\infty g(x)dF(x)$$

**Moments:**
$$\E[X^m]=\sum_ix_i^mP[x_i]$$
- $m=1$ is the mean
- $m=2$ is the power
Central moment is adjusted for mean, with $m=2$ it is the variance
$$\E[(X-\mu)^2]=\text{var}(X)$$
**Joint distribution and marginals:**
$$F(x;y)=P[X\leq x;Y\leq y]$$
$$f_X(x)=\int f(x,y)dy\qquad f_Y(y)=\int f(x,y)dx$$
if
$$F(x;y)=F[x]F[y]\implies iid$$
if
$$\E[XY]=\E[X]\E[Y]\implies\text{uncorrelated}$$
equivalence between iid and uncorrelated holds for gaussian rvs
$$\E[X+Y]=\E[X]+\E[Y]$$
**Conditional Probability:**
$$P[A|B]=\frac{P[A\cap B]}{P[B]} \text{ for } P[B]\not = 0$$
$$P[A\cap B]=P[A|B]P[B]$$
$$P[A]=\sum_i P[A\cap B_i]=\sum_iP[A|B_i]P[B_i]$$
$$\E[Y]=\sum\E[Y|x_i]P[x_i]$$
**Fourier Tx Characteristic Function:**
$$\phi(t)=\int e^{it\lambda}dF(\lambda)=\E[e^{itx}]$$
$$\begin{align}
\frac{d\phi}{dt}=\E[ixe^{itx}]\stackrel{t=0}=it[x]\\
\frac{d^2\phi}{dt^2}=\E[(ix)^2e^{itx}]\stackrel{t=0}=i^2t[x^2]
\end{align}$$
**Generating functions:**
$$\begin{align}g(s)=\sum_{k=0}^\infty p_ks^k=\E[s^x]\stackrel{s=e^{it}}=\E[(e^{it})^x]\\
g'(s)=\E[xs^{x-1}]\stackrel{s=1}=\E[x]\\
g''(s)=\E[x(x-1)s^{x-2}]\stackrel{s=1}=\E[x^2]-\E[x]
\end{align}$$
then 
$$\E[x^2]=g''(1)-g'(1)$$
**Bernoulli:**
$$x\in\curly{0,1}$$
$$p=P[x=1]=1-P[x=0]$$
$$\E[x]=p\quad \E[x^2]=p\quad \var(x)=p(p-1)$$
**Binomial:**
sum of N iid Bernoulli rv
$$y=\sum_{i=1}^nx_i\quad x_i\sim bern(p)$$
$$\E[y]=n\E[x]=np\quad var(y)=n\var(x)=np(1-p)$$
with $n\rightarrow\infty$ binomial becomes poisson with $\lambda = np$
**Poisson:**
$$\begin{gather}
P[x=k]=e^{-\lambda}\frac{\lambda^k}{k!}, \ k\geq 0\\
\E[x]=\sum_{k=0}^\infty ke^{-\lambda}\frac{\lambda^k}{k!}=\lambda e^{-\lambda}\sum_{k=1}^\infty \frac{\lambda^{k-1}}{(k-1)!}=\lambda e^{-\lambda}e^{\lambda}=\lambda\\
\var(x)=\lambda
\end{gather}$$
**Geometric RV:**
how many failures before the first success (0,0,0,1 will be 3 not 4) $Z$
second definition: how many attempts until first success (definition of before +1) $Z+1$
$$P[Z=k]=(1-p)^kp$$
$$\E[Z]=\sum_{k=0}^{\infty}kP[Z=k]=\sum_{k=0}^\infty P[k>Z]=\frac{1-p}p\quad \var(Z)=\frac{1-p}{p^2}$$
**Exponential:**
$$f_T(t)=\begin{cases}\lambda e^{-\lambda t}& t\geq 0\\ 0\end{cases}$$
$$\E[T]=\frac1\lambda\qquad \var(T)=\frac1{\lambda^2}$$
Memoryless property: 
$$P[T-t>x|T>t]=\frac{P[T-t>x,T>t]}{P[T>t]}=\frac{P[T-t>x]}{P[T>t]}=\frac{e^{-\lambda(t+x)}}{e^{-\lambda t}}=e^{-\lambda x}$$
since $T-t>x$ implies $T>t+x$ and thus $T>t$

**Gamma Distribution:**
$$\Gamma(\alpha)=(\alpha-1)!$$
$$f(x)=\frac{\lambda}{\Gamma(\alpha)}(\lambda x)^{\alpha-1}e^{-\lambda x}$$
# 2) Important Stuff
For discrete time rvs we have
$$\E[X]=\sum_{n=1}^\infty nP[X=n]=\sum_{n=0}^\infty P[X>n]$$

# 3) Markov Chains
A Markov process is a stochastic process with the **markovian property,** that is, 
$$P_{i,j}^{n,n+1}=P[x_{n+1}=j|x_0=i_0,...,x_n=i_n]=P[x_{n+1}=j|x_n=i_n]$$
where $i,j$ is the direction (from state $i$ to state $j$) at iteration $n$ to $n+1$. 
Unless explicitly stated, $P_{ij}^{n,n+1}=P_{ij}$
We can also define the **transition probability matrix**
$$P=\begin{bmatrix}
P_{00}& P_{01}&...\\
P_{10}& P_{11}&...\\
\vdots& \vdots& \ddots
\end{bmatrix}$$
If P is finite, then these properties hold:
- $P_{ij}\in[0,1]$
- $\displaystyle\sum _{j}P_{ij}=1\quad \forall i$  (rows)

A markov process is defined where $P$ is completely known and also $X_0$.

If a specific series of events is required, it can be rewritten as:
$$P[x_0=i_0, x_1=i_1,...,x_n=i_n]=p_{i_0}P_{i_0,i_1} P_{i_1,i_2}\cdot ...\cdot P_{i_{n-1},i_n}=p_{i_0}\prod_{k=1}^nP_{i_{k-1},i_k}$$

The probability of doing a transition in exactly $n$ steps is:
$$P_{ij}\iter n=P[x_n=i_n|x_0=i_0]=\sum_{k}P_{ik}P_{kj}\iter {n-1}$$
In matrix form: 
$$P\iter n=P\times P\times ...\times P=P^n$$


Proof of series of transitions:
By def of conditional probability and then markov process:
$$\begin{align}
P[x_0=i_0,...,x_n=i_n]&=P[x_0=i_0,...,x_{n-1}=i_{n-1}]\cdot P[x_n=i_n|x_0=i_0,...,x_{n-1}=i_{n-1}]\\
&=P[x_0=i_0,...,x_{n-1}=i_{n-1}]\cdot P[x_n=i_n|x_{n-1}=i_{n-1}]\\
&=P[x_0=i_0,...,x_{n-1}=i_{n-1}]\cdot P_{i_{n-1},i_n}\\
\text{repeat }n-1\text{ times}\\
&=p_{i_0}\prod_{k=1}^nP_{i_{k-1},i_k}
\end{align}$$
$\endproof$

## 3.1) First Step Analysis
First step analysis is a method to solve the markov process:
- Find possible results at the first step
- Invoke markov property and law of total probability

Let the states be $0,...,N$, then:
- Let the firs $r$ states ($0,...,r-1$) be transient: $P_{ij}\rightarrow 0$ for $i,j\in[0,r]$
- The other states $r,...,N$ are absorbing: $P_{ii}=1$ for $i\in[r,N]$

We can write the transition matrix as follows:
$$P=\begin{bmatrix}
Q&R\\0&I
\end{bmatrix}$$
We want to find the following:
The first step analysis consists in finding the possible transitions from any state $i$ to a set state $k$, that is:
$$u_i=P[X_T=k|X_0=i] \quad \forall i$$
these can be found with the following formula:
$$u_i=P_{ik}+\sum_{j=0}^{r-1}P_{ij}u_j$$
It is also possible to find the avg time spent before being absorbed:
$$T=\min\curly{n\geq 0;X_n\geq r}$$
the avg time that is spent starting in state $i$ before being absorbed in state $k$ can be found with the following formula:
$$w_i=g(i)+\sum_{j=0}^{r-1}P_{ij}w_j\qquad g(i)=\begin{cases} 1 & \text{if transient}\\0\end{cases}$$

**Example:**

$$P = \left[ \begin{array}{c|cc} \beta & \alpha & \gamma \\ \hline 0 & 1 & 0 \\ 0 & 0 & 1 \end{array} \right]$$
Invoke the first step analysis and find probabilities to being absorbed to state $k=1$:
$$u_i=P[X_T=1|X_0=i]\rightarrow \begin{cases}
u_0=\alpha+\beta u_0\\ u_1=1+0u_0\\ u_2=0+0u_0
\end{cases}\rightarrow \begin{cases}
u_0=\frac\alpha{1-\beta}\\ u_1=1\\ u_2=0
\end{cases}$$
if the starting probabilities are known, then the total probability of being absorbed to state $1$ is
$$P[\text{absorbed in }1]=\sum_{k=0}^2p_ku_k$$
Now the times become:
$$\begin{cases}
w_0=1+\beta w_0\\ 
w_1=0w_0\\ 
w_2=0w_0
\end{cases}
\rightarrow 
\begin{cases}
w_0=\frac1{1-\beta}\\ w_1=0\\ w_2=0
\end{cases}$$



>[!example|*] 3 state MC without general formula
>Consider the following markov process:
>$$P=\begin{bmatrix}
1&0&0\\
\alpha&\beta&\gamma\\
0&0&1
\end{bmatrix}$$
>where $\alpha+\beta+\gamma=1$ and $\alpha,\beta,\gamma\geq 1$
>this can be visualized as an absorbing MC:
>![[Pasted image 20260412144507.png|Representation|300]]
>
>
>Two questions arise:
> 1. Starting from $1$, what is the probability of being absorbed in 0?
> 2. How much time (on average) does it take to get there?
>
>Invoke first step analysis we first need to see the various transition probabilities:
>$$P[X_T=0|X_1=0]=1\quad P[X_T=0|X_1=1]=u\quad P[X_T=0|X_1=2]=0$$
>Now we can find $u$:
>$$\begin{align}
u=&P[X_T=0|X_0=1]=\sum_{k=0}^2P[X_T=0|X_0=1,X_1=k]P[X_1=k|X_0=1]\\
&=\sum_{k=0}^2P[X_T=0|X_1=k]P[X_1=k|X_0=1]=\sum_{k=0}^2P[X_T=0|X_1=k]P_{1k}\\
&=1\cdot\alpha+u\cdot \beta+0\cdot\gamma\\ \\
\rightarrow u&=\frac\alpha{1-\beta}=\frac\alpha{\alpha+\gamma}
\end{align}$$
>
>To find $v$ we first calculate:
$$\E[T|X_1=0]=0\quad \E[T|X_1=1]=v\quad \E[T|X_1=2]=0$$
>we notice that $T\geq 1$ and it stops once one of the absorbing states is reached:
>$$\begin{align}
v&=\E[T|X_0=1]=1+\sum_{k=0}^2P_{1k}\E[T|X_1=k]\\
&=1+\alpha\cdot \beta\cdot v+\gamma\cdot 0\\
&=1+\beta v\\ \\
\rightarrow v&=\frac1{1-\beta}=\frac1{\alpha+\gamma}
\end{align}$$
>Alternatively a direct calculation can be done:
>Notice that the probability is a geometric rv and thus:
$$\E[T|X_0=1]=\sum_{k=0}^\infty P[T>k|X_0=1]=\sum_k \beta^k=\frac1{1-\beta}$$


>[!example|*] 4 state MC
>Similar as before, but now with 4 states where 2 of them are absorbing.
>$$P=\begin{bmatrix}
P_{00}&P_{01}&P_{02}&P_{03}\\
P_{10}&P_{11}&P_{12}&P_{13}\\
0&0&1&0\\
0&0&0&1
\end{bmatrix}$$
> Now find using the general formula for $k=2$:
> $$u_i=P[X_T=2|X_0=i]\rightarrow \begin{cases}
u_0=P_{02}+P_{00}u_0+P_{01}u_1\\
u_1=P_{12}+P_{10}u_0+P_{11}u_1\\
u_2=1\\
u_3=0
\end{cases}$$
> Now the times become:
>$$\begin{cases}
w_0=1+P_{00} w_0+P_{01}w_1\\ 
w_1=1+P_{10}w_0+P_{11}w_1\\ 
w_2=0\\
w_3=0
\end{cases}$$

