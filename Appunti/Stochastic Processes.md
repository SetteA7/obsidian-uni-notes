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

## 1.1) Distributions

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
to find the avg time spent in a specific state $j$ the formula is similar:
$$v_i=g(i)+\sum_{j=0}^{r-1}P_{ij}v_j\qquad g(i)=\begin{cases} 1 & i=j\\0\end{cases}$$


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

## 3.2) Random Walks
A random walk is a set of states where the transition can only occur between adjacent states (or in the same state), that is:
$$P=\begin{bmatrix}
r_0 & p_0 & 0& 0&...&0&...\\
q_1 & r_1& p_1 & 0&...&0&...\\
0 & q_2 & r_2 & p_2&...&0&...\\
\vdots & \vdots & \ddots & \ddots&\ddots\\
0 & & & q_i&r_i&p_i \\
\vdots&&&&&\ddots&...
\end{bmatrix}$$
$$P_{i,i+1}=p_i\quad P_{i,i-1}=q_i\quad P_{ii}=r_i$$
# 4) Proofs to know

## 4.1) Proof 1: Long-run Arrival Rate
For a renewal process, state precisely (also providing a formal proof) what is the value of:
$$\lim_{t\rightarrow\infty}\frac{N(t)}t$$

---

Answer:
$$\lim_{t\rightarrow\infty}\frac{N(t)}t=\frac1\mu\text{ with probability }1$$
Proof:
Let $\curly{X_n}_{n=1}^\infty$ be a sequence of iid rvs representing inter-arrival times between successive events with $\E[X_i]=\mu\in(0,\infty)$


Let the arrival time be $S_n=\sum_{i=0}^n X_i$ and the renewal counting process $N(t)$ count the number of renewals up to time t, then 
$$N(t)\geq n\iff S_n\leq t$$
Let the renewal $N(t)$ occur at or before $t$ by definition, then renewal $N(t)+1$ occurs strictly after $t$:
$$S_{N(t)}\leq t<S_{N(t)+1}$$
For $N(t)\geq 1$ we have
$$\frac{S_{N(t)}}{N(t)}\leq\frac{ t}{N(t)}<\frac{S_{N(t)+1}}{N(t)}$$
To evaluate these bounds, recall the strong law of large numbers:
$$\lim_{n\rightarrow\infty}\frac{S_n}n=\mu\text{ w.p. }1$$
Since $\lim_{t\rightarrow\infty}N(t)=\infty$ it is possible to asymptotically substitute $n=N(t)$ and get 
$$\lim_{t\rightarrow\infty}\frac{S_{N(t)}}{N(t)}=\mu$$
For the upper bound we have
$$\lim_{t\rightarrow\infty}\frac{S_{N(t)+1}}{N(t)}=\lim_{t\rightarrow\infty}\frac{S_{N(t)+1}}{N(t)+1}\cdot\frac{N(t)+1}{N(t)}=\mu\cdot 1=\mu$$
And thus by the squeeze theorem (two policemen) we have
$$\lim_{t\rightarrow\infty}\frac t{N(t)}=\mu\text{ w.p. }1\longrightarrow \lim_{t\rightarrow\infty}\frac{N(t)}t=\frac1\mu$$
$\endproof$
## 4.2) Proof 2: Recurrence is a Class Property
Prove that if states $i$ and $j$ of a Markov chain communicate and $i$ is recurrent, then $j$ is also recurrent.

---

Proof:
Since $i,j$ communicate ($i\rightarrow j, j\rightarrow i\implies i\leftrightarrow j$), we have by definition 
$$\exists m,n\geq 0 \ s.t. \ P_{ji}\iter n>0, \ P_{ij}\iter m>0$$
And by definition of recurrent state (the probability that the chain eventually returns to state $i$ in a finite number of steps is $1$) we have
$$\sum_{k=0}^\infty P_{ii}\iter k=\infty$$
To prove that $j$ is recurrent, we need to show that $\sum_{k=0}^\infty P_{jj}\iter k=\infty$.

Consider the following path: from $j$ to $i$ in $n$ steps, then goes to $i$ back to $i$ in $k$ steps and then goes back from $i$ to $j$ in $m$ steps
$$P_{jj}^{(n + k + m)} = \sum_{r, s} P_{jr}^{(n)} P_{rs}^{(k)} P_{sj}^{(m)} \ge P_{ji}^{(n)} P_{ii}^{(k)} P_{ij}^{(m)}$$

Now 
$$\sum_{k=0}^{\infty} P_{jj}^{(n + k + m)} \ge \sum_{k=0}^{\infty} P_{ji}^{(n)} P_{ii}^{(k)} P_{ij}^{(m)}$$
Since $P_{ji}\iter n,\ P_{ij}\iter m$ are independent of $k$ we can factor them out
$$\sum_{k=0}^{\infty} P_{jj}^{(n + k + m)} \ge \underbrace{P_{ji}^{(n)} P_{ij}^{(m)}}_{\text{communicating}} \cdot \underbrace{\sum_{k=0}^{\infty} P_{ii}^{(k)}}_{\text{recurrent}}=c\cdot \infty=\infty$$
and thus $j$ is recurrent
$$\sum_{t=0}^{\infty} P_{jj}^{(t)} \ge \sum_{k=0}^{\infty} P_{jj}^{(n + k + m)} = \infty$$
$\endproof$

## 4.3) Proof 3: Proof of i.i.d. Exponential Inter-Arrival Times for Poisson Processes
For a Poisson process of rate $\lambda$, prove that the inter-arrival times are iid exponential with mean $1/\lambda$.

---

Proof:
By definition of a Poisson process, we have
- $N(0)=0$
- Independent increments: for any $0\leq t_1<...<t_k$ the rvs $N(t_i)-N(t_{i-1})$ are independent
- Stationary Poisson increments: for any $s\geq 0$ and $t>0$, the increment $N(s + t) - N(s) \sim \text{Poisson}(\lambda t)$, meaning:
$$\mathbb{P}(N(s+t) - N(s) = k) =P(N(t)=k)= \frac{(\lambda t)^k e^{-\lambda t}}{k!}$$

First we need to show that the interarrival times are iid:

For the first arrival time $T_1$ we have
$$P[T_1>t]=P[0 \text{ arrivals in } [0,t]]=P[N(t)=0]=\frac{(\lambda t)^0e^{-\lambda t}}{0!}=e^{-\lambda t}\rightarrow T_1\sim \text{Exp}(\lambda)$$
In general, the joint distribution becomes:
$$\begin{align}
P[T_{n+1}>t|T_1=t_1,...,T_n=t_n]&=P[0 \text{ arrivals in }[s_n,s_n+t]|\text{ history up to }s_{n}]\\
&=P[N(s_n+t)-N(s_n)=0|T_i=t_i]\\
&=P[N(s_n+t)-N(s_n)=0]\\
&=P[N(t)=0]=e^{-\lambda t}\\ &\downarrow\\
T_{n+1}&\sim\text{Exp}(\lambda)
\end{align}$$
Where the history could be removed due to the independence nature of the increments and the last step is due to the stationarity.

This shows both the independence as it does not depend on $t_1,...,t_n$ (no history) and also the exponential distribution

The mean of an exponential distribution $T$ with rate $\lambda$ is given by
$$\E[T]=\int_0^\infty P[T>t]dt=\int_0^\infty e^{-\lambda t}dt =-\frac{e^{-\lambda t}}{\lambda}|_0^\infty=\frac 1\lambda$$
$\endproof$

## 4.4) Proof 4: Inference from Past to Future and Vice Versa
For a Poisson process $X(t)$ of rate $\lambda$, state and derive the expression of $P[X(u)=k|X(t)=n]$ for the two cases:
- $0<u<t,\ 0\leq k\leq n$
- $0<t<u,\ 0\leq n\leq k$

---

Answer:
- $X(u)|X(t)=n\sim\text{Binomial} (n,\frac ut)\rightarrow P[...]=\binom nk\par{\frac ut}^k\par{1-\frac ut}^{n-k}$
- $X(u)|X(t)=n\sim\text{Poisson}(\lambda(u-t))\rightarrow P[...]=\frac{(\lambda(u-t))^{k-n}e^{-\lambda(u-t)}}{(k-n)!}$

Proof:
From the conditional probability definition we have:
$$P[X(u)=k|X(t)=n]=\frac{P[X(u)=k\cap X(t)=n]}{P[X(t)=n]}=P[X(u)=k\cap X(t)=n]\cdot \frac{n!}{(\lambda t)^ne^{-\lambda t}}$$
since $t, n$ are known, only the joint probability needs to be computed.

Notice that the joint probability can be rewritten as two disjoint events, depending on the case, either $[0,u],\ [u,t]$ or $[0,t],\ [t,u]$.

Case 1: Infer past from future knowledge
We can rewrite the joint probability as two disjoint events $[0,u],\ [u,t]$:
$$P[X(u)=k\cap X(t)=n]=P[X(u)=k]\cdot P[X(t)-X(u)=n-k]$$
The first term is directly given by the Poisson distribution:
$$P[X(u)=k]=\frac{(\lambda u)^ke^{-\lambda u}}{k!}$$
While the second term is given from the stationary increments:
$$P[X(t)-X(u)=n-k]=P[X(t-u)=n-k] = \frac{(\lambda(t - u))^{n - k} e^{-\lambda (t - u)}}{(n - k)!}$$
Now 
$$\begin{align}
P[X(u)=k|X(t)=n]&=\frac{(\lambda u)^ke^{-\lambda u}}{k!}\frac{(\lambda(t - u))^{n - k} e^{-\lambda (t - u)}}{(n - k)!}\frac{n!}{(\lambda t)^ne^{-\lambda t}}\\
&=\frac{n!}{k!(n-k)!}\frac{\lambda^ku^k\lambda^{n-k}(t-u)^{n-k}}{\lambda^nt^n}\frac{e^{-\lambda(u+t-u)}}{e^{-\lambda t}}\\
&=\binom nk\frac{u^k(t-u)^{n-k}}{t^n}\\
&=\binom nk\frac{u^k}{t^k}\frac{(t-u)^{n-k}}{t^{n-k}}\\
&=\binom nk\par{\frac ut}^k\par{1-\frac ut}^{n-k}
\end{align}$$

Case 2: Predict future from past observations
We can rewrite the joint probability as two disjoint events $[0,t],\ [t,u]$:
$$P[X(u)=k\cap X(t)=n]=P[X(t)=n]\cdot P[X(u)-X(t)=k-n]$$
Notice that the first term is the denominator of the expression of the conditional probability, so these two cancel out
$$P[X(u)=k|X(t)=n]=P[X(u)-X(t)=k-n]$$
As before from the stationary increments we have that this is distributed as a Poisson random variable
$$X(u)-X(t)\sim\text{Poisson}(\lambda(u-t))\rightarrow P[X(u)=k|X(t)=n]=\frac{(\lambda(u-t))^{k-n}e^{-\lambda(u-t)}}{(k-n)!}$$
$\endproof$

## 4.5) Proof 5: Period is a Class Property

^0524e9

State precisely  and prove formally the result that establishes that in a Markov chain the period is a class property


For study purposes I include also the definition of period:
$$\delta(i)=\gcd\curly{n\geq 1:P_{ii}\iter n>0}$$
if it is $1$ it is aperiodic.

---

Proposition:
Let $\{X_k\}_{k \ge 0}$ be a discrete-time Markov chain on a countable state space $S$ with transition matrix $P$. For any state $i \in S$, the period $d(i)$ (or $\delta(i)$) is defined as:

$$d(i) = \gcd \{ n \ge 1 : P_{ii}^{(n)} > 0 \}$$

If two states $i, j \in S$ communicate ($i \leftrightarrow j$), then $d(i) = d(j)$.

Proof: 
Since $i \leftrightarrow j$ then $\exists m,n : P_{ij}\iter m>0, P_{ji}\iter n>0$ and therefore 
$$P_{jj}\iter {m+n}\geq P_{ji}\iter nP_{ij}\iter m>0$$
and clearly $\delta(j)$ must divide $m+n$:
$$\delta (j)|(m+n)$$

Let $s\in\curly{s\geq 1:P_{ii}\iter s>0}$, that is, any step length such that $P_{ii}\iter s>0$, then
$$P_{jj}\iter{m+s+n}\geq P_{ji}\iter nP_{ii}\iter sP_{ij}\iter m>0$$
now it is clear that $\delta(j)$ must also divide $m+s+n$:
$$\delta (j)|(m+s+n)$$


Now focus on $\delta (j)$. If it divides $m+n$ and also $m+s+n$ it must divide their difference, that is $\delta (j)$ also divides $s$. 
$$\delta (j)|\par{(m+s+n)-(m+n)}=s\rightarrow \delta(j)|s$$

Then, $\delta (j)$ is a common divisor of the set $\curly{s\geq 1 : P_{ii}\iter s>0}$ whose greatest common divisor is $\delta(i)$ it yields that 
$$\delta(j)\leq \delta(i)$$

By symmetry the roles of $i$ and $j$ can be reversed and the result becomes $\delta(i)\leq \delta(j)$

By combining both inequalities we get 
$$\begin{cases}
\delta(j)\leq \delta(i)\\
\delta(i)\leq \delta(j)
\end{cases}\implies \delta(j)= \delta(i)$$
$\endproof$

## 4.6) Proof 6: Derivation of $\mathbb{E}[S_{N(t)+1}]$ Using Renewal Theory

^9bd3b6

For renewal processes, give an expression for $\E[S_{N(t)+1}]$ also providing a formal proof

---

Answer:
$$\E[S_{N(t)+1}]=\E[X](M(t)+1)$$
where $M(t)$ is the renewal function.

Proof:
Using the renewal argument (first step analysis) we have
$$\E[S_{N(t)+1}|X_1=x]=\begin{cases}
x & \text{if } x>t \\
x+A(t-x) & \text{if } x\leq t
\end{cases}$$

and $\E[S_{N(t)+1}]=A(t)$

We can apply the law of total expectation:
$$\begin{align}
\E[S_{N(t)+1}]=A(t)&=\int_0^\infty\E[S_{N(t)+1}|X_1=x]dF(x)\\
&=\int_0^tx+A(t-x)dF(x)+\int_t^\infty xdF(x)\\
&=\int_0^\infty xdF(x)+\int_0^tA(t-x)dF(x)\\
&=\E[X]+\int_0^tA(t-x)dF(x)
\end{align}$$
This is a standard renewal integral equation of the form:

$$A(t) = a(t) + \int_0^t A(t - x) \, dF(x), \quad t \ge 0$$

where $a(t) = \mathbb{E}[X]$ is constant with respect to $t$.

By the general theorem for renewal equations, the unique bounded solution is given by:
$$A(t) = a(t) + \int_0^t a(t-x) \, dM(x)=\E[X_1]+\int_0^t\E[X_1]dM(x)=\E[X_1]+\E[X_1]M(t)$$
where $a(t-x)=\E[X_1]$ and since it is constant it is removed from the integral.
$\endproof$
## 4.7) Proof 7: Rehash of Proof 6

See [Proof 6](#^9bd3b6).
## 4.8) Proof 8: Elementary Renewal Theorem TODO
State and Prove the Elementary Renewal Theorem

Let $\{N(t), t \ge 0\}$ be a renewal process with independent and identically distributed inter-arrival times $\{X_n\}_{n \ge 1}$ having mean $\mu = \mathbb{E}[X_1]$.

Let $M(t) = \mathbb{E}[N(t)]$ be the renewal function. Then:

$$\lim_{t \to \infty} \frac{M(t)}{t} = \frac{1}{\mu}$$

_(where $1/\mu$ is interpreted as $0$ if $\mu = \infty$)._

## 4.9) Proof 9: Rehash of Proof 5
Prove that in a Markov Chain the period is a class property, see [Proof 5](#^0524e9).

## 4.10) Proof 10: Random Walk Analysis TODO IMPORTANT
Consider a random walk over non-negative integers with the following transition probabilities:
$$P_{01}=1,\ P_{i,i+1}=p, \ P_{i,i-1}=q,\quad i>0$$
with $p+q=1$
Study its behavior, in particular characterize its recurrence or transiency and derive the steady state distribution.

---

Let's start from the classification. 
The chain is **irreducible** since all states are communicating, so all states share the same classification.

Moreover the **period is 2** since it requires always an even number of steps to return to state $i$.

Now study recurrency/transiance:
Let $h_i$ denote the probability of eventually reaching state 0 from state $i$. Clearly $h_0=1$
$$h_i=ph_{i+1}+qh_{i-1}$$
Multiply lhs by $p+q=1$
$$\begin{align}
ph_i+qh_i&=ph_{i+1}+qh_{i-1}\\ 
p(h_i-h_{i+1})&=q(h_{i-1}-h_i)\\ \\
\Delta_{i+1}=h_i-h_{i+1}&=\frac qp(h_{i-1}-h_i)=\frac qp\Delta_i
\end{align}$$
Let's see how $\Delta_i$ behaves
$$\begin{align}
&\Delta_1=h_0-h_1=1-h_1\\
&\Delta_2=\frac qp\Delta_1\\
&\Delta_3=\frac qp\Delta_2=\par{\frac qp}^2\Delta_1\\
&...\\
&\Delta_i=\par{\frac qp}^{i-1}\Delta_1
\end{align}$$

and thus
$$h_0-h_n=(h_0-\underbrace{h_1)+(h_1}_{=0}-h_2)+...+(h_{n-1}-h_n)=\sum_{i=1}^n\Delta_i=\Delta_1\sum_{k=0}^{n-1}\par{\frac qp}^k$$
Since $h_0=1$ is known we have
$$h_n=1-\Delta_1\sum_{k=0}^{n-1}\par{\frac qp}^k$$

This has 2 cases:
- The series diverges for $p\leq q$, then $\lim_{n\rightarrow\infty} h_n=-\infty$ which violates $h_n\geq 0$. To fix this then $h_1$ must be equal to 1 so to have $\Delta_1=0$ and $h_n=1$ and the chain is recurrent
- The series converges for $p>q$ and thus $\lim_{n\rightarrow\infty} h_n=1-\Delta_1\frac p{p-q}$. Since every step is independent we also have $h_n=(h_1)^n\rightarrow\lim_{n\rightarrow\infty} h_n=0$. Now it is clear that $0=1-(1-h_1)\frac p{p-q}\rightarrow h_1=\frac qp$ and thus $h_n=\par{\frac qp}^n$ and the chain is transient

The steady state distribution must only be studied in the recurrent case, so for $p\leq q\rightarrow p<1/2$.
To find the stationary distribution $\pi = (\pi_0, \pi_1, \pi_2, \dots)$, we solve the system:
$$\pi = \pi P \quad \text{subject to} \quad \sum_{n=0}^{\infty} \pi_n = 1 \quad \text{and} \quad \pi_n \ge 0$$
Which is
$$\pi_j=\sum \pi_{i}P_{ij}$$
State 0:
$$\pi_0=\pi_1P_{10}=q\pi_1\rightarrow \pi_1=\frac1q\pi_0$$
State 1:
$$\pi_1=\pi_0P_{01}+\pi_2P_{21}=\pi_0+q\pi_2\rightarrow \pi_2=\frac{p}{q^2}\pi_0$$
Generic state $j$:
$$\pi_j=p\pi_{j-1}+q\pi_{j+1}\rightarrow \pi_n=\frac{\pi_0}{q}\par{\frac{p}{q}}^{n-1}$$
Now normalize:
$$\pi_0+\frac{\pi_0}q\sum_{i=0}^\infty \par{\frac pq}^i=1\rightarrow \pi_0 \left(\frac{q - p + 1}{q - p}\right) = 1\rightarrow\pi_0=\frac{q-p}{2q}$$
And finally 
$$\pi_n=\ ...$$

## 4.11) Proof 11: Finite MC existence conditions of states
Prove that a Markov chain with a finite number of states cannot have any null recurrent state

---

Proof:
A null recurrent state is a state where the expected return time is infinite:
$$\mu_j=\E[T_j|X_0=j]=\infty$$

**By contradiction** suppose that a null recurrent state is present:
- Recurrence is a class property, so we consider this class of states $C$
- Recurrent classes are closed, so $\sum_{i\in C}P_{ij}\iter n=1$
- Null recurrent classes have zero long run transition probabilities $\lim_{n \to \infty} P_{ij}^{(n)} =1/\mu_j= 0$
- Because the state space is **finite**, the communicating class $C$ is finite. Therefore, the limit and the finite sum can be swapped: $\lim_{n \to \infty} \sum_{j \in C} P_{ij}^{(n)} = \sum_{j \in C} \left( \lim_{n \to \infty} P_{ij}^{(n)} \right)$

These pose a contradiction. The last property results to 1 on the lhs and 0 on the rhs.

$\endproof$

### 4.11.1) Proof Bonus:
Prove that in a MC with a finite number of states, there must be at least one recurrent state

---

Proof:
We have already shown that in a finite MC there cannot be any null recurrent states.
By contradiction suppose the chain does NOT have a (positive) recurrent state, then the chain will be solely made of transient states.

A transient state has long run transition probability 0: $\lim_{n\rightarrow\infty}P_{ij}\iter n=0$
But the chain must be in some state so $\sum_{j \in S} P_{ij}^{(n)} = 1$
The limit again contradicts itself since
$$\lim_{n \to \infty} \sum_{j \in S} P_{ij}^{(n)} = \sum_{j \in S} \left( \lim_{n \to \infty} P_{ij}^{(n)} \right)\longleftrightarrow1=0$$

$\endproof$

## 4.12) Proof 12: Rehash of Proof  4, only infer past from future knowledge
Prove that for a Poisson process $X(t)$ the statistics of $X(s)$ conditioned on $X(t)$, $s<t$, is binomial and provide the expression of $P[X(s)=k|X(t)=n]$

---

Answer
By the total probability formula we have that:
$$P[X(s)=k|X(t)=n]=\frac{P[X(s)=k\cap X(t)=n]}{P[X(t)=n]}$$
Where $P[X(t)=n]=(\lambda t)^ne^{-\lambda t}/n!$ 

The joint probability can be rewritten as two disjoint events:
$$P[X(s)=k\cap X(t)=n]=P[X(s)=k]\cdot P[X(t)-X(s)=n-k]$$
The first is straightforward as $P[X(s)=k]=(\lambda s)^ke^{-\lambda s}/k!$
The second is distributed as $\text{Poisson}(\lambda(n-k))$ so $P[X(t)-X(s)=n-k]=(\lambda(n-k))^{t-s}e^{-\lambda(n-k)}/(t-s)!$

Finally put everything together, do some algebraic manipulations and you get
$$X(s)|X(t)=n\sim\text{Binomial}(n,\frac st)\qquad p=\binom nk\par{\frac st}^k\par{1-\frac st}^{n-k}$$
$\endproof$
## 4.13) Proof 13: N-Step Probability Expression
Prove that for a Markov chain the n-step transition probabilities $P_{ij}\iter n$ satisfy the relationship
$$P_{ij}\iter n=\sum_{m}P_{im}\iter kP_{mj}\iter{n-k}$$

---

Proof:
From the definition:
$$\begin{align}
P_{ij}\iter n&=P[X_n=j|X_0=i]\\
&=\sum_m P[X_n=j,X_k=m|X_0=i]\quad \text{ with }0<k\leq n\\
&=\sum_m P[X_k=m|X_0=i]P[X_n=j|X_k=m,X_0=i]\\
&=\sum_m P_{im}\iter kP_{mj}\iter {n-k}\quad \text{ recalll markov property: } P[X_n=j|X_k=m,X_0=i]=P[X_n=j|X_k=m]
\end{align}$$

$\endproof$

## 4.14) Proof 14: Define Recurrent States
Give the definition of a recurrent state and show that a state is recurrent if and only if
$$\sum_{n=1}^\infty P_{ii}\iter n=\infty$$

---

Definition:
A state $i$ is **recurrent** if the probability of eventually returning to state $i$, given that the chain starts in $i$, is equal to $1$:
$$f_{ii} = \mathbb{P}(T_i < \infty \mid X_0 = i) = 1$$
where $T_i = \min\{n \ge 1 : X_n = i\}$ is the first return time to state $i$.

Proof:
Let $M_i$ be the total number of visits to state $i$ over $n$ steps:
$$M_i=\sum_{n=1}^\infty u_{X_n=i}$$
where $u_{X_n=i}$ is a counter switch (1 if $X_n=i$)

The expectance of $M_i$ starting from $i$ is then
$$\E[M_i|X_0=i]=\E[\sum_{n=1}^\infty u_{X_n=i}|X_0=i]=\sum_{n=1}^\infty \E[u_{X_n=i}|X_0=i]=\sum_{n=1}^\infty P_{ii}\iter n$$
The last step is done with the following reasoning:
Notice that
$$\begin{gather}\E[u_{X_n=i}]=1\cdot P[X_n=i]+0\cdot P[x_n\not =i]=P[X_n=i]\\  \\
\E[u_{X_n=i}|X_0=i]=P[X_n=i|X_0=i]\longrightarrow P_{ii}\iter n
\end{gather}$$
so the term becomes the definition of $P_{ii}\iter n$


Using the tail sum formula ($\E[X]=\sum_{n=1}^\infty P(X\geq n)$) we also have
$$\E[M_i|X_0=i]=\sum_{k=1}^\infty P[M_i\geq k|X_0=i]=\sum_{k=1}^\infty (f_{ii})^k=\infty$$
Where the last step is done with the strong markov property:
For $k=1$
$$\mathbb{P}(M_i \ge 1 \mid X_0 = i) = \mathbb{P}(\text{chain returns to } i \text{ at least } 1 \text{ time} \mid X_0 = i) = f_{ii}$$
General case
$$\mathbb{P}(M_i \ge k \mid X_0 = i) = \mathbb{P}(M_i \ge k-1 \mid X_0 = i) \cdot f_{ii} = (f_{ii})^{k-1} \cdot f_{ii} = (f_{ii})^k$$

These expressions are equal, so we have
$$\sum_{n=1}^\infty P_{ii}\iter n=\sum_{k=1}^\infty (f_{ii})^k=\infty$$

## 4.15) Proof 15: Define Transient States
Give the definition of a transient state and show that a state is recurrent if and only if
$$\sum_{n=1}^\infty P_{ii}\iter n<\infty$$

---

Answer:
A state $i$ is **transient** if the probability of ever returning to state $i$, given that the chain started in state $i$, is strictly less than $1$:

$$f_{ii} = \mathbb{P}(T_i < \infty \mid X_0 = i) < 1$$

where $T_i = \min\{n \ge 1 : X_n = i\}$ is the first return time to state $i$.

Equivalently, there is a strictly positive probability $(1 - f_{ii}) > 0$ that the chain leaves state $i$ and **never returns**.

Proof:
Same as before, but now since $f_{ii}<1$ we have
$$\sum_{n=1}^\infty P_{ii}\iter n=\sum_{k=1}^\infty (f_{ii})^k=\frac{f_{ii}}{1-f_{ii}}<\infty$$
# 5) Exercises

## 5.1) Poisson Process
A fundamental property of a Poisson process is that the number of events occurring in non-overlapping intervals are independent.
$$P[A|B]=P[A]\iff A\cap B=\emptyset$$
Moreover recall:
$$P[A|B]=\frac{P[A,B]}{P[B]}$$

This is used only when one of the two is deterministic, that it, only one possible thing happened on both events, that is
- One PP conditioned on one past or future event = One PP with max 2 sampled points

Total distribution is used
- One PP with at least 3 sampled points

This total probability formula is useful:
$$P(E \mid C) = \sum_{k \in \mathcal{K}} P(E \mid B_k \cap C) \cdot P(B_k \mid C)$$
Practical example:
$$\begin{gather}P[X_1(3) = 2 \mid X_1(2) + X_2(2) = 1] =\\= \sum_{k=0}^{1} P[X_1(3) = 2 \mid X_1(2) = k, \, X_1(2) + X_2(2) = 1] \cdot P[X_1(2) = k \mid X_1(2) + X_2(2) = 1]\end{gather}$$


## 5.2) MC
**Analysis of MC:**
- Diagram
- Classes
- Recurrence/transience
- Periodicity

---

**Probability absorption:** P(go to class)/P(leave)

---

**Compute Steady State Probabilities:**
For each irreducible**positive** recurrent class solve:
$$\begin{cases}\pi_CP_C=\pi_C \\ \displaystyle\sum_{\pi_i\in\pi_C}\pi_i=1\end{cases}$$
For each irreducible transient or negative recurrent class it is 0.

---

**Compute Avg Recurrence Times:**
For each irreducible **positive** recurrent class solve:
$$m_i=\frac1{\pi_i}$$
For each irreducible transient or negative recurrent class it is $\infty$. 

---

**Avg Number of Visits to State $j$**
$j$ is recurrent (and reachable) 
$$
W_{ij}\iter n = \sum_{k=0}^{n-1}[P^k]_{ij}\stackrel{n\rightarrow\infty}\approx n\pi_j$$


For transient state $j$ (suppose start in $0$) the limit becomes:
$$\begin{cases}
W_{0j}=\mathbb{I}\{0 = j\}+\displaystyle\sum_{k}P_{0k}W_{kj}\\
\vdots\\
\\
\displaystyle W_{ij} =  \mathbb{I}\{i = j\} +\sum_{\text{ } k} P_{ik} W_{kj}
\end{cases}$$

---

**Compute Mean and Variance of the first passage time to state $a$ to state $b$**
if $a=b$ then $\mu_i=1/\pi_i$

Define first passage time:
$$T_{ib} = \min\{n \ge 1 : X_n = b \mid X_0 = i\}$$
Define mean first passage time ($j=b$ is the abs condition):
$$\E[T_{ib}]=\mu_i=1+\sum_{j\not =b}P_{ij}\mu_j$$
Define second moment of first passage time:
$$\E[T_{ib}^2]=\alpha_i=1+\sum_{j\not = b}P_{ij}(2\mu_j+\alpha_j)$$
Solve the systems for $\mu_i,\ \alpha_i$
$\mu_a$ is the mean
$\alpha_a-\mu_a^2$ the variance

---

**Computing $\lim_{n\rightarrow\infty}P^n$:**
- Doesn't exist for periodic classes "X"
- Is null for transitions (from transient) into transient states
- Doesn't exist for transitions (from transient) into periodic classes "X"

For Positi
In general for a submatrix $P_{C_i}$ where $C_i$ is a pos. recurrent aperiodic class this must be solved:
$$\begin{cases}
\pi_{C_i}P_{C_i}=\pi_{C_i}\\
\displaystyle{\sum_{\pi_n\in\pi_{C_i}}} \pi_n=1
\end{cases}$$

For transitions from transient class $C_t$ to recurrent aperiodic class $C_i$:
First find the absorption probability for all $C_t\rightarrow C_i$. Then multiply this with the steady state:
$$P(\text{absorbed in }C_i)\cdot\pi_n\qquad\text{ for all entries}$$

---

**Computing $\lim_{n\rightarrow\infty}\frac1n\sum_{k=1}^nP^k$:**
- Exists _always_
- If standard limit exists, it is equal to it

For aperiodic class same procedure as standard limit for pos recurrent aperiodic class
For transitions from transient class $C_t$ to recurrent periodic class $C_i$ same as transition into recurrent aperiodic

|**Transition Type (i→j)**|**Class of i**|**Class of j**|**Limit limn→∞​Pijn​**|
|---|---|---|---|
|**To Transient**|Any|Transient|**$0$**|
|**Across Recurrent**|Recurrent $C_1$|Recurrent $C_2$ ($C_1 \neq C_2$)|**$0$**|
|**Within Aperiodic Recurrent**|Recurrent $C_i$|Same $C_i$ (Aperiodic)|**$\pi_j$** (from $\pi_{C_i} P_{C_i} = \pi_{C_i}$, $\sum \pi = 1$)|
|**Within Periodic Recurrent**|Recurrent $C_i$|Same $C_i$ (Periodic)|**Does not exist (X)**|
|**Transient $\to$ Aperiodic Recurrent**|Transient|Recurrent $C_i$ (Aperiodic)|**$P(\text{absorbed in } C_i \mid X_0 = i) \cdot \pi_j$**|
|**Transient $\to$ Periodic Recurrent**|Transient|Recurrent $C_i$ (Periodic)|**$0$** if unreachable; **Does not exist (X)** if reachable and oscillating|

---

**Mean recurrence time (avg return times)**
For pos recurrent state $\mu_i=1/\pi_i$
For transient states $\mu_i=\infty$

|**State Type**|**Stationary Probability πi​**|**Mean Recurrence Time μi​**|
|---|---|---|
|**Positive Recurrent**|$\pi_i > 0$ (within its closed class)|**$\mu_i = \dfrac{1}{\pi_i}$**|
|**Transient**|$0$ (globally)|**$\mu_i = \infty$**|
|**Null Recurrent** _(infinite MCs only)_|$0$|**$\mu_i = \infty$**|
## 5.3) First Step Analysis
General formula:
$$W_{\textcolor{yellow}i\textcolor{red}j} = \mathbb{I}\{\textcolor{yellow}i = \textcolor{red}j\} + \sum_\textcolor{blue}k P_{\textcolor{yellow}i\textcolor{blue}k} W_{\textcolor{blue}k\textcolor{red}j}$$
This is used for
- avg visits
- passage times

## 5.4) GBN
Normal GBN with iid error $\epsilon$ on forward channel and $m$ slots to return
$$\eta=\frac{1-\epsilon}{1-\epsilon+m\epsilon}$$

A GBN on a two state MC works as follows. It has RTT of $m$ slots
Error Free feedback throughput:
$$\eta=\frac{P_{10}\iter m}{P_{10}\iter m+mP_{01}}=\frac{P_{BG}\iter m}{P_{BG}\iter m+mP_{GB}}$$
Feedback channel with iid error $\delta$:
$$\eta=\frac{(1-\delta)P_{10}\iter m}{(1+(m-1)\delta)P_{10}\iter m+m((1-\delta)P_{01}+\delta P_{01}\iter m)}$$

Suppose $\pi_B$ is known and the av duration of $G$ is known.
The other steady state is easily obtainable: $\pi_G=1-\pi_B$
Then the thorughput (no protocol) is $\eta=\pi_GP[success|G]+\pi_BP[success|B]$

Notice that $\E[L_{GB}]=1/P_{GB}$
## 5.5) Poisson Processes
In a PP, the number of active calls has rate
$$\lambda_p(t)=\lambda\int_0^t1-G(z)dz\stackrel{t\rightarrow\infty}\longrightarrow\lambda E[S]$$
So we can say that $X(t)\sim\text{Poi}(\lambda_p(t))$
But notice that
$$P[X(t)=k]=\frac{\lambda_p(t)^ke^{-\lambda_p(t)}}{k!}$$
