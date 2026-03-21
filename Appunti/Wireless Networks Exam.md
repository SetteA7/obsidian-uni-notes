# 1) Useful Results:
$$ $$
$$\begin{align}
&\sum_{i=0}^{L}p^i=\frac{1-p^{L+1}}{1-p}\stackrel{L\rightarrow\infty}\longrightarrow\frac1{1-p}\\
&\sum_{i=0,1}^{L}ip^i=\frac{p-(L+1)p^{L+1}+Lp^{L+2}}{(1-p)^2}\stackrel{L\rightarrow\infty}\longrightarrow\frac p{(1-p)^2}
\end{align}$$

# 2) Physical Layer
Usually $P_{bit}(\gamma)$ is a monotonically decreasing function, so it is possible to do the following:
$$P[P_{bit}<P_{th}]=P[\gamma_{th}<\gamma]=P[P_{rx, th}<P_{rx}]$$
where the last form usually uses shadowing ($\psi\sim\mathcal N(\mu=0,\sigma^2)$) which is gaussian. Recall that
$$\begin{align}
P[a<\psi]= Q\par{\frac{a-\mu}{\sigma}}\\
P[\psi<a]= 1-Q\par{\frac{a-\mu}{\sigma}}
\end{align}$$
**Avg bit error:**
$$\begin{align}
&\E[P_{bit}(\gamma)]=\int_{0}^\infty p(\gamma)P_{bit}(\gamma)d\gamma\rightarrow\int_0^\infty be^{-a\gamma}d\gamma=\frac b a\\
\end{align}$$
recall
$$\int e^{-\alpha x}dx=-\frac{e^{-\alpha x}}{\alpha}$$

#### 2-State Markov Model
Threshold value (for equi probable):
$$\gamma_{th}=\gamma_0\ln(2)$$
Probability to be in each state (calculate if not equiprobable):
$$\begin{align}
&\pi_G=P[\gamma_0>\gamma_{th}]=\int_{\gamma_0}^\infty p(\gamma )d\gamma\\
&\pi_B=1-\pi_G
\end{align}$$
Bit Error Probability in each state:
$$\begin{align}
&P_{bit,G}=\frac12P[\gamma_{th}<\gamma<\infty]=\frac12\int_{\gamma_{th}}^\infty p(\gamma)P_{bit}(\gamma)d\gamma\\
&P_{bit,B}=\frac12P[0<\gamma<\gamma_{th}]=\frac12\int_{0}^{\gamma_{th}} p(\gamma)P_{bit}(\gamma)d\gamma
\end{align}$$
Then on average the arrived bits are:
$$\E[\text{arrived bits}]=\pi_G(1-P_{bit,G})PDU_p+\pi_B(1-P_{bit,B})PDU_p$$
#### MSE
Suppose to have a series of measurements of type ($d_i, M_i=P_{tx_i}/P_{rx_i}$) and a $P_L(d, \zeta)$ formula where $\zeta$ is a parameter to evaluate. The evaluation is done by minimizing the MSE, that is:
- Compute MSE:
$$MSE(\zeta)=\sum_i(P_L(d_i,\zeta)-M_i)^2$$
- Solve maximization problem:
$$\frac{d\ MSE(\zeta)}{d\zeta}=0$$

# 3) Link Layer
$$ $$
$$\begin{align}
&P_{PDU}=1-(1-P_{bit})^l\\
&P_{LL}=1-\sum_{i=0}^{L-1}P_{PDU}^i(1-P_{PDU})=P_{PDU}^L\\
&B_{LL}=\frac{\E[\text{bits succesfully delivered}]}{\E[\text{total time}]}\\
&\E[t]=Lt_FP_{PDU}^L+\sum_{i}^L it_FP_{PDU}^{i-1}(1-P_{PDU})=t_F\frac{1-P_{PDU}^L}{1-P_{PDU}}\\
&\E[x]=(1-P_{LL})l\\
&S=\frac{\E[\text{All ok RXed PDUS}]}{\E[\text{All TXed PDUs}]}
\end{align}$$
#### ARQ Stuff
$l$ = payload size
$h$ = header size
$R$ = rate

**Packet Error Probability:**
$$\boxed{P_{PDU}=1-(1-P_{bit})^{l+h}}$$
**Times:**
- S&W:
$$t_G=t_{tx}+2\tau_p+t_{ACK}$$
**LL Error rate:**
$$\boxed{P_{LL}=P_{PDU}^L\stackrel{L\rightarrow\infty}\longrightarrow0}$$
**Attempts/Time for 1 success ($L=$ # max allowed retx):**
$$\boxed{\E[\text{attempts}]=\frac{1-P_{PDU}^L}{1-P_{PDU}}\stackrel{L\rightarrow\infty}\longrightarrow\frac1{1-P_{PDU}}}$$
- S&W
$$\E[t]=t_G\cdot\E[\text{attempts}]=t_G\frac{1-P_{PDU}^L}{1-P_{PDU}}\stackrel{L\rightarrow\infty}\longrightarrow\frac{t_G}{1-P_{PDU}}$$
- SR
$$\E[t]=t_{tx}\cdot\E[\text{attempts}]=t_{tx}\frac{1-P_{PDU}^L}{1-P_{PDU}}\stackrel{L\rightarrow\infty}\longrightarrow\frac{t_{tx}}{1-P_{PDU}}$$

**Avg PDUs/bits rxed:**
$$\boxed{\E[\text{rxed bits}]=(l+h)\E[\text{rxed PDUs}]=(l+h)(1-P_{LL})\stackrel{L\rightarrow\infty}\longrightarrow l+h}$$
**Throughput/Normalized Throughput:**
$$\boxed{\rho=\frac{t_{tx}\E[\text{rxed PDUs}]}{\E[t]}\qquad S=\frac{\E[\text{rxed PDUs}]}{\E[\text{attempts}]}=(1-P_{LL})\frac{(1-P_{PDU})}{(1-P_{PDU}^L)}=(1-P_{PDU})}$$
- S&W
$$\rho=\frac{t_{tx}}{t_{G}}\frac{(1-P_{PDU})(1-P_{LL})}{(1-P_{PDU}^L)}=\frac{t_{tx}}{t_{G}} S\stackrel{L\rightarrow\infty}\longrightarrow \frac{t_{tx}}{t_G}(1-P_{PDU})$$
- SR
$$\rho=S=\frac{(1-P_{PDU})(1-P_{LL})}{(1-P_{PDU}^L)}\stackrel{L\rightarrow\infty}\longrightarrow (1-P_{PDU})$$

**Good put:**
$$\boxed{\eta(l)=R\frac{l}{l+h}\rho}$$
- S&W:
$$\eta(l)=R\frac{l}{l+h}\frac{t_{tx}}{t_G}(1-P_{PDU})\stackrel{L\rightarrow\infty}\longrightarrow R\frac{l}{l+h}\frac{t_{tx}}{t_G}(1-P_{PDU})$$
- SR
$$\eta(l)=R\frac{l}{l+h}(1-P_{PDU})\stackrel{L\rightarrow\infty}\longrightarrow R\frac{l}{l+h}(1-P_{PDU})$$
useful derivatives:
$$\sq{\frac{l}{l+h}}'=\frac{h}{(l+h)^2}\qquad \sq{(1-P_{bit})^{l+h}}'=(1-P_{bit})^{l+h}\ln(1-P_{bit})$$
usually $\max l$ is found by solving:
$$\boxed{\ln(1-P_{bit})l^2+\ln(1-P_{bit})hl+h=0}$$


#### Counting
if IID, then 
- $L\rightarrow\infty$ to count we use a gaussian rv such that:
$$\E[\text{count}]=\sum_{i=1}^L ai p^{i-1}(1-p)=a\frac{1-(L+1)p^L+Lp^{L+1}}{1-p}\stackrel{L\longrightarrow\infty}\rightarrow a\frac1{1-p}$$
- $L<\infty$ to count we use final attempt + truncated gaussian
$$\E[\text{count}]=Lap^L+\sum_{i=1}^L ai p^{i-1}(1-p)=a\frac{1-p^L}{1-p}\stackrel{L\longrightarrow\infty}\rightarrow a\frac1{1-p}$$
if not IID, then
Let:
- $P_s(i)$ be the success probability of the i-th event. usually it is $P_s(i)=P_i\prod_{k=1}^{i-1} (1-P_s(k))$
- The sum of all successes be $P_s=\sum_{i=1}^L P_s(i)\stackrel{L\rightarrow\infty}\longrightarrow1$
$$\E[\text{count}]=La(1-P_s)+\sum_{i=1}^LiaP_s(i)$$
In a nested environment, $a$ can be seen as the cost of the previous process. So for example we have 2 ARQ protocols with $\E[TX_1],\E[TX_2]$ computed individually. To find the total RETXs we must set $E[TX]=\E[TX_1]\E[TX_2]$

Count # of iid events happening with probability p:
$$\boxed{P[\text{k events}]=\binom{N}{k}p^k(1-p)^{N-k}}$$
this can be used for FEC, collision probabilities, etc.

Moreover if $P_{LL}(L)$ is known then
$$\E[N_{tx}]=\sum_j P[X\geq j]=\sum_j P_{LL}(j)$$
since $P_{LL}(j)=P[X\geq j]$.

#### Conditioned Collision Probability
Normal collision probability can be compute just as FEC, however the conditioned collision probability results to be interesting. This is the computation of
$$P[\text{collision}|\text{tx already happening}]=1-(1-p)^{n-1}$$

#### Error Correction
Given a FEC schema with $(N,U)$ block codes, then
$$\boxed{P[\text{k errors}]=\binom{N}{k}P_{PDU}^k(1-P_{PDU})^{N-k}}$$
and let $i$ be the last # of errors for correct decoding, then
$$P_{succ}=\sum_{k=0}^{i}P[\text{k errors}]\qquad P_{succ}=1-\sum_{k=i}^KP[\text{k errors}]$$
HARQ will have
$$S=\frac UNP_{succ}\qquad B=R\frac{l}{l+h}S$$

# 4) Transport Layer
In TCP some preliminary calculations are needed:
- From LL gather: $P_{PDU}, \E[\text{attempts}], \eta_{ARQ}(l)$
- If fragmentation is used, find: $SS, n_{PDU}^T=\ceil{\frac{SS}{l}}$
- Network Parameters:
$$\begin{align}
&P_{TCP}=1-\prod_i (1-P_{TCP_i})\\
&RTT=\sum_i RTT_i 
\end{align}$$
Usually the next required formulas are provided, most importantly recall
$$B_{app}=\frac{8 TCP_p}{SS}\cdot\min\curly{\eta_{ARQ}(l), B(RTT,P_{TCP})}$$
#### Fragmentation ($TCP_l\geq PDU_l$)
Start from $P_{PDU}$
- find: $$\begin{align}
&SS=IP_h+TCP_h+TCP_p\\
&n_{PDU}^T=\ceil{\frac{SS}{PDU_l}}
\end{align}$$
- then
$$\begin{cases}P_{TCP_i}=1-(1-P_{LL})^{n^T_{TCP}}\stackrel{L\rightarrow\infty}\longrightarrow0\\
RTT_i=RTT_\text{fixed}\cdot\E[\text{attempts}]
\end{cases}$$

#### Encapsulation ($TCP_l < PDU_l$)
Start from $P_{PDU}$
- find $P_{res}=P_{PDU}^L$ 
- find $P_{bit,res}=1-(1-P_{res})^\frac{1}{PDU_l}$
- final probability:
$$\begin{cases}
P_{TCP_i}=1-(1-P_{bit,res})^{TCP_l}\stackrel{L\rightarrow\infty}\longrightarrow0\\RTT_i=RTT_\text{fixed}\end{cases}$$
#### TX Probability:
Let $\tau$ be the TX probability of $n$ stations.
Probability at least one TX:
$$P_{tx}=P[\text{at least 1 tx}]=1-(1-\tau)^n$$
$$P_s=P[\text{1 tx succesfull}]=\frac{P[\text{exactly 1 tx}]}{P_{tx}}=\frac{\tau(1-\tau)^{n-1}}{P_{tx}}$$
The probability to have a collision is
$$P_c=P_{tx}-P_{tx}P_s=P_{tx}(1-P_s)$$
$$P_{fail}=P_c^L$$
# 5) WI-Fi
Heavily relies on tables. 

![[27636.png|Table I|550]]

![[54031.png|Table II|350]]
![[70258.png|Data Rates Table|850]]
**Throughput:**
$$\eta(q,l)=\frac{8l}{\displaystyle\zeta_1+\frac{\zeta_2q}{1-2q}+\frac{\zeta_3q}{1-q}}$$

with:
$$\begin{flalign}
&\zeta_1=T_\text{back}(1)+T_\text{difs}+T_\text{sifs}+T_\text{data}(m_d,l)+T_\text{ack}(m_a)\\ &\ \ \ \ =T_\text{back}(1)+T_\text{data}(m_d,l)+T_\text{wait}\\
&\zeta_2=W_\min T_\text{slot}\\
&\zeta_3=T_\text{wait}+T_\text{data}(m)-\frac{T_\text{slot}}2\\
\\
&T_\text{back}(1)=\frac{W_\min-1}2T_\text{slot}\\
&T_\text{wait}=T_\text{difs}+T_\text{sifs}+T_\text{ack}(m_a)
\end{flalign}$$
>[!rmk|*]
>As the theory suggests, the throughput is the ratio of rxed bits$\cdot$txtime/total tx time. And thus the denominator is a good approximation for $RTT$

If no RETX is allowed, then the goodput is
$$G_{\text{no retx}}=\frac{(1-q)8l}{\zeta_1}$$


Ho scoperto una cosa molto interessante nel counting ($p=P_{PDU}$)
Di solito abbiamo
$$\E[N_{tx}]=Lp^L+\sum_{i=1}^LP[X=i]=Lp^L+\sum_{i=1}^L i p^{i-1}(1-p)=\frac{1-p^L}{1-p}\stackrel{L\longrightarrow\infty}\rightarrow \frac1{1-p}$$
ma questo solo nel SR ARQ.

Se dovesse chiedere questo in una configurazione diversa allora questo teorema regge:
Data una LL Error Probability function $P_{LL}(x)$
$$\E[N_{tx}]=\sum_{i=0}^LP[X\geq j]=\sum_{i=0}^LP_{LL}(j)$$
infatti con $P_{LL}(x)=p^x$ abbiamo che converge a $1-p^L/1-p\stackrel{L\rightarrow\infty}\longrightarrow 1/1-p$
