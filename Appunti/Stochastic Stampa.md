# 1) Poisson Process
For a single Poisson process $X(t) \sim \text{Poi}(\lambda t)$:
$$P(X(t) = k) = \frac{(\lambda t)^k e^{-\lambda t}}{k!}, \quad \mathbb{E}[X(t)] = \lambda t, \quad \text{Var}(X(t)) = \lambda t$$
For non-overlapping intervals $(s_1, t_1]$ and $(s_2, t_2]$:
$$X(t_1) - X(s_1) \perp X(t_2) - X(s_2)$$
$$X(t) - X(s) \sim \text{Poi}(\lambda(t - s)), \quad \forall t > s$$
$$P[A|B]=P[A]\iff A\perp B$$
If $X_1(t) \sim \text{Poi}(\lambda_1 t)$ and $X_2(t) \sim \text{Poi}(\lambda_2 t)$ are independent, their sum is:
$$S(t) = X_1(t) + X_2(t) \sim \text{Poi}((\lambda_1 + \lambda_2)t)$$
If arrivals from $X(t) \sim \text{Poi}(\lambda t)$ are kept with probability $p$ and discarded with probability $1 - p$:
$$X_{\text{kept}}(t) \sim \text{Poi}(\lambda p t), \quad X_{\text{discarded}}(t) \sim \text{Poi}(\lambda (1 - p) t) \quad (X_{\text{kept}} \perp X_{\text{discarded}})$$

See end of document for ALL possible cases.

This total probability formula is useful:
$$P(E \mid C) = \sum_{k \in \mathcal{K}} P(E \mid B_k \cap C) \cdot P(B_k \mid C)$$
Practical example:
$$\begin{gather}
\begin{aligned}P[X_1(3) = 2 \mid X_1(2) + X_2(2) = 1] &=
\sum_{k=0}^1P[X_1(3)=2, X_1(2)=k|X_1(2)+X_2(2)=1]\\
&=\sum_k \frac{P[X_1(3)=2, X_1(2)=k,X_1(2)+X_2(2)=1]}{P[X_1(2)+X_2(2)=1]}
\end{aligned}\\
= \sum_{k=0}^{1} P[X_1(3) = 2 | X_1(2) = k,  X_1(2) + X_2(2) = 1] P[X_1(2) = k | X_1(2) + X_2(2) = 1]
\end{gather}
$$
The first part becomes:
$$\begin{gather}P[X_1(3)-X_1(2)=2-k|X_1(2)-X_1(2)+X_2(2)=1-k]\\=P[X_1(1)=2-k|X_2(2)=1-k]=P[X_1(1)=2-k]\end{gather}$$
The second becomes (its sum over all $k$ must be 1)
$$\frac{P[X_1(2)=k,X_1(2)+X_2(2)=1]}{P[X_1(2)+X_2(2)=1]}=\frac{P[X_1(2)=k]P[X_2(2)=1-k]}{P[X_1(2)+X_2(2)=1]}$$

# 2) Poisson Process Queues
In a queue we have the arrival distribution $A$ and service time $S$.
Usually we have $A(t)\sim\text{Poi}(\lambda t)$ and $S$ either uniform, constant or exponentially distributed.

$A(t)$ is the cumulative arrivals up to $t$
$N(t)$ are the users in service at time t

From here we define the number of customers in the system at time $t$ as $N(t)$. 
If there are infinite queues/capacity, then $N(t)\sim\text{Poi}(\lambda_p(t))$ with rate
$$\lambda_p(t)=\lambda\int_0^t1-G(z)dz\stackrel{t\rightarrow\infty}\longrightarrow\lambda E[S]$$
Where $G(z)$ is the CDF of the Service time. Notice that $t\rightarrow\infty$ doesn't need to be the limit, just $t>$ then when the service time CDF converges to $1$.
But notice that
$$P[N(t)=k]=\frac{[\lambda_p(t)]^ke^{-\lambda_p(t)}}{k!}$$

It is possible to find the probability of having $n$ customers in service at $t$ with $k$ arrivals before using this:
- Constant service time $\beta$:
$$\begin{align}P[N(t)=n|A(t)=k]&=\frac{P[N(t)=n,A(t)=k]}{P[A(t)=k]}=\frac{P[A(t-\beta)=k-n]P[A(\beta)=n]}{P[A(t)=k]}\\
&=\binom{k}{n} \left(\frac{\beta}{t}\right)^n \left(\frac{t - \beta}{t}\right)^{k - n}\\
&\sim\text{Binomial}\par{k,\frac \beta t}
\end{align}$$
- Random service time:
$$\begin{align}P[N(t) &= n \mid A(t) = k] = \binom{k}{n} \sq{\frac{\lambda_p(t)}{\lambda t}}^n \sq{1 - \frac{\lambda_p(t)}{\lambda t}}^{k - n}, \quad 0 \le n \le k\\
&\sim\text{Binomial}\par{k,\frac{\lambda_p(t)}{\lambda t}}
\end{align}$$
Most importantly, the constant service time case is a special case of the random service time.

Given $A(t) = k$, the arrival epochs are distributed as **order statistics of $k$ i.i.d. Uniform$(0, t)$ random variables**. The probability that an arrival at time $U \sim \text{Unif}(0, t)$ is still in service at $t$ is:
$$p_t = \frac{1}{t} \int_0^t (1 - G(t - u)) \, du = \frac{\lambda_p(t)}{\lambda t}$$
# 3) MC
## 3.1) **Analysis of MC:**
Diagram, Classes, Recurrence/transience, Periodicity

---

## 3.2) **Probability absorption into class $a$:** 
If the transient state is only one ($|C_t|=1$): $P[\text{go to class }$a$]/P[\text{leave trans state}]$
If the transient state is a class with $|C_t|>1$ then first step analysis is required:
$$\begin{gather}
\text{Define: }\mu_i=P[\text{go to }a\text{ starting from }i]\\
\mu_i=\sum_j P_{ij}\mu_j\\
\text{Boundary condition: }\mu_a=1\quad \mu_b=0, \quad b\in\curly{\text{all other abs states}}
\end{gather}$$
where the boundary condition is a direct result of the summation.

---

## 3.3) **Compute Steady State Probabilities:**
For each irreducible**positive** recurrent class solve:
$$\begin{cases}\pi_CP_C=\pi_C \\ \displaystyle\sum_{\pi_i\in\pi_C}\pi_i=1\end{cases}$$
For each irreducible transient or negative recurrent class it is 0.

---

## 3.4) **Compute Avg Recurrence Times:**
For each irreducible **positive** recurrent class solve:
$$m_i=\frac1{\pi_i}$$
For each irreducible transient or negative recurrent class it is $\infty$. 

---

## 3.5) **Avg Number of Visits starting from $a$**
Starting from $a$ inside a pos rec chain:
$$
W_{a\bullet}\iter n = \sum_{k=0}^{n-1}[P^k]_{a\bullet}\stackrel{n\rightarrow\infty}\approx n\pi_\bullet$$
Notice that this can be easily computed as:
Set $$X_0  = (0, \dots, 0, \underbrace{1}_{a\text{-th pos}}, 0, \dots, 0)$$
Find $X_k=X_{k-1}P,\ k=1,...,n-1$ (where $X_1$ is the $a$-th row of $P$ and $X_0$ is a null row where only $a$-th entry is 1). 
$$X_k = X_{k-1} P = X_0 P^k = [P^k]_{a\bullet}$$

Then the $W_{a\bullet}^{(n)}$ matrix is just the sum, to find $j$ just select the $j$-th entry 
$$W_{a\bullet}^{(n)}=\sum_{k=0}^{n-1}X_k\stackrel{n\rightarrow\infty}\longrightarrow n\pi_\bullet$$

Starting from $a$ inside transient state $\mathcal T$:
Same as before for finite $n$
The limit is a bit different:
- If the target state is transient
$$W_{\color{blue}i\color{red} j}^{(\infty)} = \delta_{ij} + \sum_{k \in \mathcal{T}} P_{\color{blue}i\color{yellow}k} W_{\color{yellow}k\color{red}j}^{(\infty)} \quad \text{for every } i \in \mathcal{T}$$
where $\delta_{ij} = 1$ if $i = j$ and $0$ otherwise.
- If the target is in recurrent state then as before


Finally notice that
$$k_i = \sum_{j \in \mathcal{T}} W_{ij}$$

---

## 3.6) **Compute Mean and Variance of the first passage time to state $a$**
Let $k^a_i=\text{mean time to reach } a \text{ from }i$
Do one system of this form for each required $a$
Clearly $k_a^a=0$ however, for the final result consider $k^a_a=1/\pi_a$ 
$$k_i^a=1+\sum_{j\not=a}P_{ij}k^a_j$$
If $i \not\to a$, or if $i \to a$ but the chain can be trapped in another closed class disjoint from $a$, then $k_i^a = \infty$

Let $\alpha^a_i=\text{secon moment of time to reach } a\text{ from }i$ 
Once the means $k^a_i$ are known just build the following system
$$\alpha_i=1+\sum_{j\not=a}P_{ij}(2k_j+\alpha_j)$$
Finally the variance is
$$\alpha_i-k_i^2$$

---

## 3.7) **Computing $\lim_{n\rightarrow\infty}P^n$:**
- Doesn't exist for periodic classes "X"
- Is null for transitions (from transient) into transient states
- Doesn't exist for transitions (from transient) into periodic classes "X"

For Positive Recurrent Aperiodic Class it is just the steady state probability:
For a submatrix $P_{C_i}$ where $C_i$ is a pos. recurrent aperiodic class the rows will be
$$\text{row i: }(\pi_1\quad \pi_2\quad ...\quad \pi_n)$$

For transitions (from transient) to pos recurrent aperiodic it is the abs probability times steady state of the state it transitions into
$$P(\text{absorbed in }C_i)\cdot\pi_n\qquad\text{ for all entries}$$

---

## 3.8) **Computing $\lim_{n\rightarrow\infty}\frac1n\sum_{k=1}^nP^k$:**
- Exists _always_
- If standard limit exists, it is equal to it

For Positive Recurrent Periodic Class it is just the steady state probability (same as before for aperiodic)

For For transitions (from transient) to pos recurrent periodic it is the abs probability times steady state of the state it transitions into (same as before fro transient $\rightarrow$ aperiodic)


|**Transition Type (i→j)**|**Class of i**|**Class of j**|**Limit limn→∞​Pijn​**|
|---|---|---|---|
|**To Transient**|Any|Transient|**$0$**|
|**Across Recurrent**|Recurrent $C_1$|Recurrent $C_2$ ($C_1 \neq C_2$)|**$0$**|
|**Within Aperiodic Recurrent**|Recurrent $C_i$|Same $C_i$ (Aperiodic)|**$\pi_j$** (from $\pi_{C_i} P_{C_i} = \pi_{C_i}$, $\sum \pi = 1$)|
|**Within Periodic Recurrent**|Recurrent $C_i$|Same $C_i$ (Periodic)|**Does not exist (X)**|
|**Transient $\to$ Aperiodic Recurrent**|Transient|Recurrent $C_i$ (Aperiodic)|**$P(\text{absorbed in } C_i \mid X_0 = i) \cdot \pi_j$**|
|**Transient $\to$ Periodic Recurrent**|Transient|Recurrent $C_i$ (Periodic)|**$0$** if unreachable; **Does not exist (X)** if reachable and oscillating|

---

## 3.9) **Mean recurrence time (avg return times)**
For pos recurrent state $\mu_i=1/\pi_i$
For transient or neg rec states $\mu_i=\infty$

# 4) GBN
If $P$ is known, then also $\pi_G,\pi_B$ are known by solving $\pi=\pi P$ with $\pi_G+\pi_B=1$.
If $\pi_G,\pi_B$ is known $P$ cannot be calculated. If also $\E[\text{consecutive good/bad slots}]$ is known (one of the two) then 
$$p_{GB}=\frac1{\E[\text{consec good}]}\qquad p_{BG}=\frac1{\E[\text{consec bad}]}$$
From here a parametric $P$ can be defined and by solving $\pi=\pi P$ with $a+b=1$ as an additional condition the whole $P$ is found.
If both are known it is directly found by recalling that each row $=1$.

If the throughput of no protocol is asked:
$$\eta=\pi_GP[success|G]+\pi_BP[success|B]$$

A GBN on a two state MC works as follows. It has RTT of $m$ slots
- Normal GBN with iid error $\epsilon$ on forward channel and $m$ slots to return
$$\eta=\frac{1-\epsilon}{1-\epsilon+m\epsilon}$$
_(where $P_{BG}\iter 2=P_{BG}=1-\epsilon$ since iid and $P_{GB}=\epsilon$)_

- Error Free feedback throughput:
$$\eta=\frac{P_{10}\iter m}{P_{10}\iter m+mP_{01}}=\frac{P_{BG}\iter m}{P_{BG}\iter m+mP_{GB}}$$
- Feedback channel with iid error $\delta$:
$$\eta=\frac{(1-\delta)P_{BG}\iter m}{(1+(m-1)\delta)P_{BG}\iter m+m((1-\delta)P_{GB}+\delta P_{GB}\iter m)}$$
If iid errors on both feedback and forward then use the last provided formula by recalling $P_{BG}\iter 2=P_{BG}=1-\epsilon$ since iid and $P_{GB}=\epsilon$

# 5) Min/Max of two distributions
Let $A,B$ be two non negative independent rvs, then define $W=\min(A,B)$
$$W=\min(A,B)>t\iff A>t\ \cap\ B>t\longrightarrow
P[W>t]= P[A>t] P[B>t]$$

Sometimes this is enough to know what the distribution is. 
Calculate $\E[W]$:
$$\E[W] = \int_0^\infty P(W > t) \, dt$$
Recall also:
$$\begin{align}
F_W(t)=1-(1-F_A(t))(1-F_B(t))
\end{align}$$




Specific cases: 
- $A\sim\text{Exp}(\lambda_A)\ B\sim\text{Exp}(\lambda_B)$:
$$\begin{gather} W\sim\text{Exp}(\lambda_A+\lambda_B)\\
\E[W]=\frac1{\lambda_A+\lambda_B}
\end{gather}$$
- $A\sim\text{Exp}(\lambda)\ B\sim\text{Constant}(T)$
$$\begin{gather} W\sim\text{Truncated Exp}(\lambda)\text{ at }T\\
\E[W]=\frac{1-e^{-\lambda T}}{\lambda}
\end{gather}
$$
In general a uniform rv truncates the other rv.

Now notice:
$$\max(A,B)+\min(A,B)=A+B\rightarrow\max(A,B)=A+B-\min(A,B)$$
Therefore the expectation of the max is very easily obtained:
$$\E[\max(A,B)]=\E[A]+\E[B]-\E[W]$$

So the distribution of max can be found by finding the distribution of min:
$$\begin{align}
P[\max(A,B)>t]&=P[A>t]+P[B>t]-P[\min(A,B)>t]\\
&=P[A>t]+P[B>t]-P[A>t]P[B>t]\end{align}$$

# 6) Renewal Reward
Important stuff:
**"Per visit" / "Sojourn time" / "Holding time":** Conditioned on entering the state $\implies \mu_R = \gamma T$.
**"Per cycle":** Unconditioned over the full loop, weighting the probability of entering the state $\implies E[T_R] = \alpha \gamma T$.

$$E[T_{\text{between two events } i}] = \frac{E[\text{short cycle}]}{P_i}$$
## 6.1) Two ON/OFF Phases
Let a system cycle between two phases of expected duration $T_1,T_2$ that produce $r_i$
Probability to be in state $i$
$$p_i=\frac{\E[T_i]}{\E[T_1]+\E[T_2]}$$
Rate:
$$\eta=r_1p_1+r_2p_2$$
If there are multiple independent processes with ON/OFF phases then
Find $p_i,\eta_i$ for every process
then 
$$\eta = \sum_{k=0}^n P(k \text{ are working}) \cdot r(k)$$
## 6.2) Semi Markov Process
$\geq 3$ states, the _order_ of visits is random (governed by probabilities, not a fixed cycle), and/or a state has **competing exit clocks**.

First find embedded matrix, then find $\pi_i$
Then the mean times:
- Single exit clock: 
$$\mu_i=E[T_i]=\sum_j P_{ij} \tau_{ij}$$
where $\tau_{ij} = \mathbb{E}[\text{time in state } i \mid \text{next state is } j]$.
- Competing exponential clocks:
$$P[T_1<T_2]=\frac{\lambda_1}{\lambda_1+\lambda_2}\qquad\min\sim\text{Exp}[\lambda_1+\lambda_2]$$

- Exponential vs deterministic:
$$P[\text{Exp}(\lambda)<c]=1-e^{-\lambda c},\qquad\E[\min(\text{Exp}(\lambda),c)]=\frac{1-e^{-\lambda c}}\lambda​$$

Finally un normalize
$$p_i=\frac{\pi_i\mu_i}{\sum_k \pi_k\mu_k}$$

## 6.3) Regenerative Analysis
you need throughput, a blocking/rejection fraction, or an average delay in a system that isn't a clean birth-death CTMC (thresholds, timeouts, synchronized departures).

Find the start of cycle
Then decompose the cycle:
Then compute
Throughput: 
$$E[\text{data sent per cycle}]/E[C]$$
Rejection fraction: 
$$E[\#\text{rejected per cycle}]/E[\#\text{offered per cycle}] $$ both share the same $\E[C]$, so it cancels; you only need the two expected counts. Note that for a Poisson arrival process with rate $\lambda$, $\mathbb{E}[\# \text{ offered per cycle}] = \lambda \mathbb{E}[C]$.

Fraction of time empty: 
$$E[\text{idle sub-phase}]/E[C]$$

**Average Delay ($\mathbb{E}[T]$):**

$$L = \frac{\mathbb{E}\left[\int_0^C N(t) \, dt\right]}{\mathbb{E}[C]}$$

$$\lambda_{\text{eff}} = \frac{\mathbb{E}[\text{admitted packets per cycle}]}{\mathbb{E}[C]}$$

$$\mathbb{E}[T] = \frac{L}{\lambda_{\text{eff}}} = \frac{\mathbb{E}\left[\int_0^C N(t) \, dt\right]}{\mathbb{E}[\text{admitted packets per cycle}]}$$

# 7) Other stuff
## 7.1) Independent and Identically Distributed (i.i.d.)
If every process has the same success probability $p_i = p$, the total number of operational processes follows a standard **Binomial distribution**, $K \sim \text{Binomial}(n, p)$:
**Probability that exactly $k$ processes are working:**
$$P(K = k) = \binom{n}{k} p^k (1 - p)^{n - k}, \quad k \in \{0, 1, \dots, n\}$$
**All $n$ are working ($k = n$):**   $$P(K = n) = p^n$$**All $n$ are off ($k = 0$):**
$$P(K = 0) = (1 - p)^n$$
**Exactly one is working ($k = 1$):**   
$$P(K = 1) = n p (1 - p)^{n - 1}$$
**At least one is working:**
$$P(K \ge 1) = 1 - P(K = 0) = 1 - (1 - p)^n$$

## 7.2) CSMA/Slotted Aloha
If each successful transmission brings gain $G$ and each blocked/failed attempt costs $C$:
- Packet duration ($T_x$):

$$T_x = \frac{\text{Packet length}}{\text{Capacity}}$$
- Total attempts rate = $\lambda_{\text{total}}$.
- Success rate = $\lambda_{\text{succ}} = \lambda_{\text{new}}$ (if all packets eventually succeed).
$$\lambda_{\text{succ}} = \frac{1}{\frac{1}{\lambda_{\text{total}}} + T_x} = \frac{\lambda_{\text{total}}}{1 + \lambda_{\text{total}} T_x}$$
- Failure rate = $\lambda_{\text{total}} - \lambda_{\text{succ}}$.
- Net utility rate:
$$\text{Gain Rate} = G \cdot \lambda_{\text{succ}} - C \cdot (\lambda_{\text{total}} - \lambda_{\text{succ}})$$
$$\mathbb{E}[\text{Access Delay}] = \left(\frac{\lambda_{\text{total}}}{\lambda_{\text{succ}}} - 1\right) \cdot \mathbb{E}[T_{\text{backoff}}]$$
## 7.3) Example of Avg visits
$$P = \begin{pmatrix} P_{00} & P_{01} & P_{02} \\ P_{10} & P_{11} & P_{12} \\ 0 & 0 & 1 \end{pmatrix}$$
$$W_{ij}^{(\infty)} = \delta_{ij} + \sum_{k \in \mathcal{T}} P_{ik} W_{kj}^{(\infty)}$$
$$j=0:\begin{cases} W_{00}^{(\infty)} = 1 + P_{00} W_{00}^{(\infty)} + P_{01} W_{10}^{(\infty)} \\ W_{10}^{(\infty)} = 0 + P_{10} W_{00}^{(\infty)} + P_{11} W_{10}^{(\infty)} \end{cases}\quad j=1:\begin{cases} W_{01}^{(\infty)} = 0 + P_{00} W_{01}^{(\infty)} + P_{01} W_{11}^{(\infty)} \\ W_{11}^{(\infty)} = 1 + P_{10} W_{01}^{(\infty)} + P_{11} W_{11}^{(\infty)} \end{cases}$$

## 7.4) PP
**Single Process — Conditioning on the Future ($s < t$)**
Conditioning on total arrivals $X(t) = n$ forces the arrival epochs to distribute independently and uniformly over $[0, t]$:
$$X(s) \mid \{X(t) = n\} \sim \text{Binomial}\left(n, \, \frac{s}{t}\right), \quad 0 \le k \le n$$
$$P(X(s) = k \mid X(t) = n) = \binom{n}{k} \left(\frac{s}{t}\right)^k \left(1 - \frac{s}{t}\right)^{n - k}$$
_Proof setup via definition:_
$$\frac{P(X(s) = k, \, X(t) - X(s) = n - k)}{P(X(t) = n)} = \frac{\frac{(\lambda s)^k e^{-\lambda s}}{k!} \cdot \frac{(\lambda (t - s))^{n - k} e^{-\lambda (t - s)}}{(n - k)!}}{\frac{(\lambda t)^n e^{-\lambda t}}{n!}}$$

---
**Single Process — Conditioning on the Past ($s < t$)**
Conditioning on the past uses the independent increments property directly:
$$P(X(t) = n \mid X(s) = k) = P(X(t) - X(s) = n - k) \quad (n \ge k)$$
$$X(t) \mid \{X(s) = k\} \stackrel{d}{=} k + \text{Poi}(\lambda(t - s))=Y$$
$$P(X(t) = n \mid X(s) = k) = P[Y=n-k]=\frac{(\lambda (t - s))^{n - k} e^{-\lambda (t - s)}}{(n - k)!}, \quad n \ge k$$
_(If $n < k$, the probability is identically $0$ since Poisson counts are non-decreasing)._

---
**Two Independent Processes at the Same Time Point ($t$)**
Given the aggregate traffic $X_1(t) + X_2(t) = n$, each arrival independently belongs to process 1 with probability $p = \frac{\lambda_1}{\lambda_1 + \lambda_2}$:
$$X_1(t) \mid \{X_1(t) + X_2(t) = n\} \sim \text{Binomial}\left(n, \, \frac{\lambda_1}{\lambda_1 + \lambda_2}\right)$$
$$P(X_1(t) = k \mid X_1(t) + X_2(t) = n) = \binom{n}{k} \left(\frac{\lambda_1}{\lambda_1 + \lambda_2}\right)^k \left(\frac{\lambda_2}{\lambda_1 + \lambda_2}\right)^{n - k}$$
_Inverse conditioning (Past conditioning):_
$$P(X_1(t) + X_2(t) = n \mid X_1(t) = k) = P(X_2(t) = n - k) = \frac{(\lambda_2 t)^{n - k} e^{-\lambda_2 t}}{(n - k)!} \quad (n \ge k)$$_(Because $X_2(t)$ is independent of $X_1(t)$)._

---
**The General Convolution Case ($X_1(t_2)$ given $X_1(t_1) + X_2(t_1)$ with $t_1 < t_2$)**
To solve $P\big(X_1(t_2) = m \;\big\vert{}\; X_1(t_1) + X_2(t_1) = n\big)$ (usually easier, use total prob):
- **Structural Decomposition:**
The random variable decomposes into two independent sources of arrivals:    
$$X_1(t_2) \mid \{X_1(t_1) + X_2(t_1) = n\} \stackrel{d}{=} K + Y$$   
   - $K \sim \text{Binomial}\left(n, \, \frac{\lambda_1}{\lambda_1 + \lambda_2}\right)$ (arrivals of $X_1$ during $[0, t_1]$)    
   - $Y \sim \text{Poi}(\lambda_1(t_2 - t_1))$ (new arrivals of $X_1$ during $(t_1, t_2]$)
   - $K \perp Y$ (due to non-overlapping time windows)    
- **Analytical Formula (Sum over $k$):**
$$P\big(X_1(t_2) = m \;\big\vert{}\; X_1(t_1) + X_2(t_1) = n\big) = \sum_{k=0}^{\min(m, n)} \binom{n}{k} \left(\frac{\lambda_1}{\lambda_1 + \lambda_2}\right)^k \left(\frac{\lambda_2}{\lambda_1 + \lambda_2}\right)^{n - k} \cdot \frac{(\lambda_1(t_2 - t_1))^{m - k} e^{-\lambda_1(t_2 - t_1)}}{(m - k)!}$$

## 7.5) MC
**Conditioning on the Present (Split Past & Future)**
When conditioning on the present state $X_2 = b$, the past $X_1$ and future $X_3$ become conditionally independent:
$$P(X_1 = a, X_3 = c \mid X_2 = b)  = \frac{P(X_1 = a) P_{ab} P_{bc}}{P(X_2 = b)}$$
**Smoothing (Conditioned on Past & Future)**
To find the probability of being in an intermediate state $X_2 = b$ given known endpoints $X_1 = a$ and $X_3 = c$:
$$P(X_2 = b \mid X_1 = a, X_3 = c) = \frac{P_{ab} P_{bc}}{[P^2]_{ac}}$$
 _(the denominator has $[P^2]_{ac} = \sum_k P_{ak} P_{kc}$ which is the entry $a,c$ of $P^2$)_

## 7.6) Two Servers
- **Single-Server Probability:**
$$p_{\text{off}} = \frac{T}{\frac{1}{\lambda_{\text{eff}}} + T}, \quad p_{\text{on}} = 1 - p_{\text{off}} \quad (\lambda_{\text{eff}} = \lambda \cdot p_{\text{effective}})$$    
- **System DOWN (Both Off):**
$$P(\text{DOWN}) = p_{\text{off}}^2$$
$$\mathbb{E}[T_{\text{DOWN}}] = \mathbb{E}[\min(\text{Exp}(1/T), \text{Exp}(1/T))] = \frac{T}{2}$$
- **System UP (At Least One Working):**
$$\mathbb{E}[T_{\text{UP}}] = \mathbb{E}[T_{\text{DOWN}}] \cdot \frac{1 - P(\text{DOWN})}{P(\text{DOWN})} = \frac{T}{2} \left(\frac{1 - p_{\text{off}}^2}{p_{\text{off}}^2}\right)$$
- **Average Streaming Rate:**
$$\mathbb{E}[\text{Rate}] = 2(1 - p_{\text{off}}) R$$


