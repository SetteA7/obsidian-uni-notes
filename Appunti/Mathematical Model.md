# 1) Symmetric Links ($\tau=\tau_{tx}=\tau_{rx},\ p=p_{tx}=p_{rx}$)
#### Scenario
Symmetric communication link.

#### Expected Time to Crash Bound
$$ $$
>[!thm] Expected Time to Crash Bound
>Safe operation is guaranteed if the expected communication delay does not exceed half of the available reaction time:
>$$2\E[t]=\tau_{e2e}+T\frac{1+p}{1-p}\leq \Delta t$$
>Where
>$$\Delta t = 1000 \cdot \frac{\Delta d}{v_{max}}\qquad\E[t]=\tau+T\frac{1+p}{2(1-p)}$$

##### Proof
The robot must stop before $d_{max} = m + d_{brake}$. Given the threshold $S$, the distance available for travel at constant velocity $v_{max}$ is $\Delta d = S - d_{max}$. This yields a time budget:
$$\boxed{\Delta t = 1000 \cdot \frac{\Delta d}{v_{max}} \unit{ms}}$$
_(Note: 1000 is a scaling factor for milliseconds)._

We model the delivery of a packet as a sequence of Bernoulli trials. Denote the failure probability as $p$ (packet loss), and $(1-p)$ be the probability of success.

Let $n\sim\text{Geom}(1-p)$ be a discrete random variable representing the number of failed attempts before the first successful delivery. The probability that the first success occurs exactly at the $n$-th retry is:
$$P(n) = p^n(1 - p)$$
The time of arrival $t_n$ for a packet that succeeds after $n$ failures, accounting for a fixed propagation latency $\tau$ and a retransmission period $T$, is defined as:
$$t_n = \tau + nT$$
Using the LOTUS, the expected time of arrival $\mathbb{E}[t_{received}]$ is.
$$\begin{align}
\mathbb{E}[t_{received}] &= \sum_{n=0}^{\infty} t_n \cdot P(n)\\
&= \sum_{n=0}^{\infty} (\tau + nT) p^n(1 - p)\\
&= \tau (1 - p) \sum_{n=0}^{\infty} p^n + T(1 - p) \sum_{n=0}^{\infty} n p^n\\
&= \tau (1 - p) \left( \frac{1}{1-p} \right) + T(1 - p) \left( \frac{p}{(1-p)^2} \right)
\end{align}$$
Simplifying the terms:
$$\mathbb{E}[t_{received}] = \tau + \frac{pT}{1 - p}$$

In a real-time system with a fixed sampling period $T$, the crossing of the threshold distance $S$ and the controller reception of the signal are asynchronous with the transmission clock. Let $\phi \sim \mathcal{U}(0, T)$ be the random variable representing the phase offset between the event detection and the start of the next transmission slot.

The expected additional delay due to this misalignment is:

$$\mathbb{E}[t_{processing}] = \int_{0}^{T} \phi \cdot f(\phi) d\phi = \frac{1}{T} \left[ \frac{\phi^2}{2} \right]_0^T = \frac{T}{2}$$
Finally:
$$\boxed{\E[t]=\E[t_{received}]+\E[t_{processing}]=\tau+T\frac{1+p}{2(1-p)}}$$
$$\endproof$$
#### Expected Minimum Distance
$$ $$
>[!thm] Expected Minimum Distance
>The expected minimum distance reached from the bot to the obstacle is:
>$$\E[d_\min]=S-L-d_{brake}-\frac{2\E[t]v_\max}{1000}$$

##### Proof
Let $X, Y \sim \text{Geom}(1-p)$ be two independent geometric random variables representing the number of failed attempts for the sensor and brake packets, respectively and $\phi \sim \mathcal{U}(0, T)$ the asynchronous processing offset.
The total time to send and receive the signal correctly is:
$$t_{tot}=XT+\tau+YT+\tau+2\phi=(X+Y)T+\tau_{e2e}+2\phi$$
Where the expectation yields:
$$\begin{align}\E[t_{tot}]&=(\E[X]+\E[Y])T+\tau_{e2e}+2\E[\phi]\\
&=2\frac p{1-p}T+\tau_{e2e}+2\frac T2\\
&=\frac{1+p}{1-p}T+\tau_{e2e}\\
&=2\E[t]
\end{align}$$
Then the expected time to brake is:
$$\E[d_\min]=S-L-d_{brake}-\frac{2\E[t]v_\max}{1000}$$
$$\endproof$$
#### Variances
$$ $$
>[!thm] Variances
>The reaction time has variance:
>$$\text{Var}[t] =  T^2 \left( \frac{p}{(1-p)^2} + \frac{1}{12} \right)$$
>While the end to end variance is:
>$$\text{Var}(t_{e2e}) = T^2 \left( \frac{2p}{(1-p)^2} + \frac{1}{3} \right)$$
>Therefore the minimum distance has variance:
>$$\text{Var}(d_{min}) = \left( \frac{v_{max}}{1000} \right)^2 T^2 \left( \frac{2p}{(1-p)^2} + \frac{1}{3} \right)$$
##### Proof
Proof of reaction time:
The time of arrival is $t_n = \tau + nT$, where $n \sim \text{Geom}(1-p)$. In this formulation, $n$ is the number of failures (starting from 0).

The variance of a geometric distribution $n$ where $P(n) = p^n(1-p)$ is:
$$\text{Var}(n) = \frac{p}{(1-p)^2}$$
Since $\tau$ is a constant and $T$ is a scaling factor:
$$\text{Var}(t_{received}) = \text{Var}(\tau + nT) = T^2 \text{Var}(n)=\frac{pT^2}{(1-p)^2}$$
The phase offset $\phi$ follows a continuous uniform distribution $\mathcal{U}(0, T)$. The variance for any uniform distribution $\mathcal{U}(a, b)$ is $\frac{(b-a)^2}{12}$.
$$\text{Var}(t_{processing})=\text{Var}(\phi) = \frac{(T-0)^2}{12} = \frac{T^2}{12}$$
Assuming the network packet loss and the clock phase offset are independent:
$$\text{Var}[t] = \text{Var}(t_{received}) + \text{Var}(t_{processing})= T^2 \left( \frac{p}{(1-p)^2} + \frac{1}{12} \right)$$
---
Proof of variance of distance:
Since $d_{min} = S - L - d_{brake} - \frac{v_{max}}{1000} \cdot t_{tot}$ has $S, L, d_{brake},$ and $v_{max}$ who are constants, the variance depends entirely on the total time 
$$t_{tot} = (X+Y)T + \tau_{e2e} + 2\phi$$
notice the following:
$$\text{Var}(X+Y) = \text{Var}(X) + \text{Var}(Y) = \frac{2p}{(1-p)^2}$$
$$\text{Var}(2\phi) = 4 \cdot \text{Var}(\phi) = 4 \cdot \frac{T^2}{12} = \frac{T^2}{3}$$
then
$$\text{Var}(t_{tot}) = T^2 \text{Var}(X+Y) + \text{Var}(2\phi) = \frac{2pT^2}{(1-p)^2} + \frac{T^2}{3}$$
and finally:
$$\text{Var}(d_{min}) = \left( \frac{v_{max}}{1000} \right)^2 \cdot \text{Var}(t_{tot})= \left( \frac{v_{max}}{1000} \right)^2 T^2 \left( \frac{2p}{(1-p)^2} + \frac{1}{3} \right)$$

#### Crash Probability
$$ $$
>[!thm] Crash Probability
>Let $N_\tau$ be the transmission attempt budget:
>$$N_\tau=\floor{\frac{\Delta t-\tau_{e2e}}T}$$
>Then the probability of a crash ignoring quantization offset is:
>$$P_{crash}(p,N_\tau)=p^{N_\tau+1}[1+(N_\tau+1)(1-p)]$$
>By adding the quantization offset, the probability becomes:
>$$P'_{crash}(p,N_\tau)=p^{N_\tau}[1+N_\tau(1-p)]$$
>

##### Proof
Let $n$ be the number of attempts for the sensor packet ($X$) and $m$ be the number of attempts for the brake command ($Y$).
The time for a successful transmission is:
$$t_I=(i-1)T+\tau$$
The system avoids a crash if $t_x + t_y \leq \Delta t$. Substituting the expressions:
$$(x+y-2)T + 2\tau \leq \Delta t\rightarrow(x+y) \leq \frac{\Delta t - 2\tau}{T} + 2$$
We define the **total attempt budget** $N$ as:

$$N = \left\lfloor \frac{\Delta t - 2\tau}{T} \right\rfloor + 2$$

A crash occurs if the total required attempts $X + Y > N$

We model $X, Y$ as independent Geometric random variables starting at 1, with failure probability $p$:

$$P(X=k) = (1-p)p^{k-1}, \quad k \in \{1, 2, \dots\}$$

Even though $Y$ starts after $X$ succeeds, the _probability_ of $Y$ succeeding in its own attempts is independent of $X$. A crash occurs in two mutually exclusive scenarios:
- Data Fail ($P_{\text{data fail}}$)
- Brake Fail ($P_{\text{brake fail}}$)

Scenario A: Data Fail ($P_{\text{data fail}}$)
This occurs if the sensor data $X$ takes so long that there is no time left for even a single attempt of $Y$. Since $Y$ requires at least $m=1$ attempt, $X$ must succeed in $N-1$ attempts or fewer. If $X \geq N$, the system crashes.
$$P_{\text{data fail}} = P(X > N-1) = p^{N-1}$$
Scenario B: Brake Fail ($P_{\text{brake fail}}$)
This occurs if $X$ succeeds at attempt $n \in \{1, \dots, N-1\}$, but the brake command $Y$ fails to succeed within the remaining $N-n$ attempts.
$$\begin{align}
P_{\text{brake fail}} &= \sum_{n=1}^{N-1} P(X = n) \cdot P(Y > N-n)\\
&= \sum_{n=1}^{N-1} \left[ (1-p)p^{n-1} \right] \cdot \left[ p^{N-n} \right]\\
&= \sum_{n=1}^{N-1} (1-p)p^{N-1}\\
&= (N-1)(1-p)p^{N-1}
\end{align}$$
The total probability is the sum of both failure modes:
$$P_{\text{crash}}(p, N) = p^{N-1} \left[ 1 + (N-1)(1-p) \right]$$

---
Additionally one can include the mean asynchronous processing offset $\E[\phi]=T/2$ as an additive term to the total time on each link:
$$t'_I=(i-1)T+\tau+\frac T2$$
This allows to find:
$$t'_x+t'_y=(x+y-1)T+\tau\rightarrow N'=\floor{\frac{\Delta t-2\tau}{T}}+1$$
For the sake of notation we define
$$N_\tau=\floor{\frac{\Delta t-2\tau}T}\rightarrow\begin{cases}N=N_\tau+2\\N'=N_\tau+1\end{cases}$$

and the crash probability becomes
- Case no $\phi$:
$$P_{\text{crash}}(p, N_\tau) = p^{N_\tau+1} \left[ 1 + (N_\tau+1)(1-p) \right]$$
- Case $\phi$:
$$P'_{crash}(p,N_\tau)=p^{N_\tau}[1+N_\tau(1-p)]$$
$$\endproof$$
#### S.M.A.R.T. Algorithm
$$ $$
>[!corollary] S.M.A.R.T. Algorithm
>Let $P_{target}\ll 1$ denote the desired crash probability of a mobile robot under the SMART implementation, then its ideal threshold should be:
>$$S=\frac{v_\max}{1000}\par{T(N^*+1)+\tau_{e2e}}+L+m+d_{brake}$$
>Where $N^*$ is the first $N\in\mathbb N^+$ that satisfies $P(N)=p^N(1+(1-p)N)\leq P_{target}$

##### Proof
First notice that $P(N)$ is a monotonically decreasing function. By looking at the difference:
$$P(N)-P(N+1)=p^N(1-p)^2(N+1)>0$$
Moreover at the extremes we have
$$P(N=0)=1\qquad\lim_{N\rightarrow \infty}P(N)=0$$

Considering $N$ as a continuous variable $N \in \mathbb{R}^+$, since $P(N)$ is a continuous and strictly decreasing function ranging from $1$ to $0$, by the Intermediate Value Theorem, there exists a unique value $N^* \in \mathbb{R}^+$ such that:

$$P(N^*) = P_{target}$$

For the discrete case required by the algorithm ($N \in \mathbb{N}^+$), the optimal value will be the smallest integer $N$ such that:

$$P(N) \le P_{target}$$


# 2) Non Symmetric Links ($\tau_{tx}\not=\tau_{rx},p_{tx}\not =p_{rx}$)

#### Expected Time to Crash Bound
$$ $$
>[!thm] Expected Time to Crash Bound
>Safe operation is guaranteed if the expected communication delay does not exceed half of the available reaction time:
>$$\E[t_{e2e}]=\tau_{e2e}+\frac T2\par{\frac{1+p_{tx}}{1-p_{tx}}+\frac{1+p_{rx}}{1-p_{rx}}}=\tau_{e2e}+T\par{\frac{1-p_{tx}p_{rx}}{1-p_{e2e}}}\leq \Delta t$$
>Where
>$$\Delta t = 1000 \cdot \frac{\Delta d}{v_{max}}\qquad\E[t_i]=\tau_i+T\frac{1+p_i}{2(1-p_i)}\qquad \E[t_{e2e}]=\E[t_{tx}]+\E[t_{rx}]$$

##### Proof
Same as before just by noticing that $2\E[t]\not=\E[e2e]$ doesn't hold anymore as each link has different parameters.
$$\E[t_i]=\tau_i+T\frac{1+p_i}{2(1-p_i)}\rightarrow \E[t_{tx}]+\E[t_{rx}]\leq\Delta t$$
Moreover with $p_1=p_2=p$ we get the result of the symmetric link case. Most notably $\E[t_{e2e}]=2\E[t]$
$$\endproof$$
#### Expected Minimum Distance
$$ $$
>[!thm] Expected Minimum Distance
>The expected minimum distance reached from the bot to the obstacle is:
>$$\E[d_\min]=S-L-d_{brake}-\frac{\E[t_{e2e}]v_\max}{1000}$$

##### Proof
Direct conclusion from the previous theorem.
$$\endproof$$
#### Variances
$$ $$
>[!thm] Variances
>The reaction time on a link has variance:
>$$\text{Var}[t_i] = T^2 \left( \frac{p_i}{(1 - p_i)^2} + \frac{1}{12} \right)$$
>While the end to end variance is:
>$$\begin{align}
\text{Var}[t_{e2e}] 
&= T^2\left( \frac{p_{tx}}{(1 - p_{tx})^2} + \frac{p_{rx}}{(1 - p_{rx})^2} + \frac{1}{6} \right)
\end{align}$$
>Therefore the minimum distance has variance:
>$$\text{Var}(d_{min}) = \left( \frac{v_{max}}{1000} \right)^2 T^2 \left( \frac{p_{tx}}{(1 - p_{tx})^2} + \frac{p_{rx}}{(1 - p_{rx})^2} + \frac{1}{6} \right)$$
##### Proof
For each individual link, the variance is calculated based on its specific failure probability $p_i$ and latency $\tau_i$:
$$\text{Var}[t_i] = T^2 \left( \frac{p_i}{(1 - p_i)^2} + \frac{1}{12} \right)$$
The total time $t_{e2e}$ is the sum of the uplink delay, the downlink delay, and the processing offsets. Based on the updated model where $\mathbb{E}[t_{e2e}] = \mathbb{E}[t_{tx}] + \mathbb{E}[t_{rx}]$, we assume $t_{e2e} = t_{tx} + t_{rx}$.

$$\begin{align}
\text{Var}[t_{e2e}] &= \text{Var}[t_{tx}] + \text{Var}[t_{rx}]\\
&= T^2 \left( \frac{p_{tx}}{(1 - p_{tx})^2} + \frac{1}{12} + \frac{p_{rx}}{(1 - p_{rx})^2} + \frac{1}{12} \right)\\
&= T^2\left( \frac{p_{tx}}{(1 - p_{tx})^2} + \frac{p_{rx}}{(1 - p_{rx})^2} + \frac{1}{6} \right)
\end{align}$$
then
$$\text{Var}(d_{min}) = \left( \frac{v_{max}}{1000} \right)^2 T^2 \left( \frac{p_{tx}}{(1 - p_{tx})^2} + \frac{p_{rx}}{(1 - p_{rx})^2} + \frac{1}{6} \right)$$
#### Crash Probability
$$ $$
>[!thm] Crash Probability
>Let $N_\tau$ be the transmission attempt budget:
>$$N_\tau=\floor{\frac{\Delta t-\tau_{e2e}}T}$$
>Then the probability of a crash ignoring quantization offset is (assuming $p_{tx}\not =p_{rx}$):
>$$P_{crash}(p_{tx}, p_{rx}, N_\tau)=p_{tx}^{N_\tau+1} + (1-p_{tx}) p_{rx} \frac{p_{rx}^{N_\tau+1} - p_{tx}^{N_\tau+1}}{p_{rx} - p_{tx}}$$
>By adding the quantization offset, the probability becomes:
> $$P'_{crash}(p_{tx}, p_{rx}, N_\tau)=p_{tx}^{N_\tau} + (1-p_{tx}) p_{rx} \frac{p_{rx}^{N_\tau} - p_{tx}^{N_\tau}}{p_{rx} - p_{tx}}$$

Let $n$ be the number of attempts for the sensor packet ($X$) and $m$ be the number of attempts for the brake command ($Y$).
The time for a successful transmission is:
$$t_I=(i-1)T+\tau_i$$
The system avoids a crash if $t_x + t_y \leq \Delta t$. Substituting the expressions:
$$(x+y-2)T + \tau_{e2e} \leq \Delta t\rightarrow(x+y) \leq \frac{\Delta t - \tau_{e2e}}{T} + 2$$
For the sake of notation we define
$$N_\tau=\floor{\frac{\Delta t-\tau_{e2e}}T}\rightarrow\begin{cases}N=N_\tau+2\\N'=N_\tau+1\end{cases}$$
We model $X, Y$ as independent Geometric random variables starting at 1, with failure probability $p_i$:
$$P(A_i=k) = (1-p_i)p_i^{k-1}, \quad k \in \{1, 2, \dots\}$$
Even though $Y$ starts after $X$ succeeds, the _probability_ of $Y$ succeeding in its own attempts is independent of $X$. A crash occurs in two mutually exclusive scenarios:
- Data Fail ($P_{\text{data fail}}$)
- Brake Fail ($P_{\text{brake fail}}$)

Scenario A: Data Fail ($P_{\text{data fail}}$)
This occurs if the sensor data ($X$) uses up so much of the budget that there is no time left for even a single brake attempt ($Y=1$). Therefore, $X$ must succeed in $N-1$ attempts or fewer. If $X \geq N$, the system crashes immediately.
$$P_{\text{data fail}} = P(X \geq N) = p_{tx}^{N-1}$$
Scenario B: Brake Fail ($P_{\text{brake fail}}$)
This occurs if the sensor data succeeds at some attempt $n$ (where $n < N$), but the brake command fails to succeed within the remaining $N-n$ attempts.

$$\begin{align}P_{\text{brake fail}} &= \sum_{n=1}^{N-1} P(X = n) \cdot P(Y > N-n)\\
&=\sum_{n=1}^{N-1} \left[ (1-p_{tx})p_{tx}^{n-1} \right] \cdot \left[ p_{rx}^{N-n} \right]\\
&=(1-p_{tx}) p_{rx}^{N-1} \sum_{n=1}^{N-1} \frac{p_{tx}^{n-1}}{p_{rx}^{n-1}}\\
&=(1-p_{tx}) p_{rx}^{N-1} \sum_{n=1}^{N-1} \par{\frac{p_{tx}}{p_{rx}}}^{n-1}\\
&= (1-p_{tx}) p_{rx}^{N-1} \left[ \frac{1 - (p_{tx}/p_{rx})^{N-1}}{1 - p_{tx}/p_{rx}} \right]\\
&=(1-p_{tx}) p_{rx} \frac{p_{rx}^{N-1} - p_{tx}^{N-1}}{p_{rx} - p_{tx}}
\end{align}$$
finally:
$$P_{\text{crash}}(p_{tx}, p_{rx}, N) = p_{tx}^{N-1} + (1-p_{tx}) p_{rx} \frac{p_{rx}^{N-1} - p_{tx}^{N-1}}{p_{rx} - p_{tx}}$$
And therefore the two adjusted formulas are correct.

Moreover the symmetric link case holds when substituting at beginning of proof.
$$\endproof$$
#### S.M.A.R.T Algorithm IMPORTANT CHANGE $N^*+1$ to just $N^*$ in code!!!
$$ $$
>[!corollary] S.M.A.R.T. Algorithm
>Let $P_{target}\ll 1$ denote the desired crash probability of a mobile robot under the SMART implementation, then its ideal threshold should be:
>$$S=\frac{v_\max}{1000}\par{T(N^*+1)+\tau_{e2e}}+L+m+d_{brake}$$
>Where $N^*$ is the first $N\in\mathbb N^+$ that satisfies $P(N) = p_{tx}^{N} + (1 - p_{tx}) p_{rx} \frac{p_{rx}^{N} - p_{tx}^{N}}{p_{rx} - p_{tx}}$

##### Proof
To prove that $P(N)$ is strictly decreasing, we examine the ratio or the difference. A more elegant way to see the behavior is to rewrite $P(N)$ as:

$$P(N) = \alpha p_{tx}^N + \beta p_{rx}^N$$

where constants $\alpha$ and $\beta$ depend on the probabilities. Specifically:

$$P(N) = p_{tx}^N \left( 1 - \frac{(1-p_{tx})p_{rx}}{p_{rx}-p_{tx}} \right) + p_{rx}^N \left( \frac{(1-p_{tx})p_{rx}}{p_{rx}-p_{tx}} \right)$$

Assuming $0 < p_{tx}, p_{rx} < 1$, $P(N)$ is a linear combination of two decaying exponential functions. Since both $p_{tx}^N$ and $p_{rx}^N$ are strictly decreasing functions of $N$, their sum (given positive coefficients) is also strictly decreasing.

For the specific case where $p_{tx} \to p_{rx}$, this expression converges to the previous form $p^N(1 + (1-p)N)$, which we already proved is strictly decreasing.

Moreover at the extremes we have
$$P(N=0)=1\qquad\lim_{N\rightarrow \infty}P(N)=0$$

As before, the optimal value $N^*$ is the smallest integer $N$ such that:
$$P(N) \le P_{target}$$
$$\endproof$$



$$P(N) = \begin{cases}
p_{tx}^{N} + (1 - p_{tx}) p_{rx} \frac{p_{rx}^{N} - p_{tx}^{N}}{p_{rx} - p_{tx}}\\ \\
p^N(1+(1-p)N) & \text{if }p_{rx}\approx p_{tx}
\end{cases}\leq P_{target}$$


# 3) Ci riprovo: Symmetric case
## 3.1) Intro
This work aims to design a model that can predict the crash probability of a bot under unstable network conditions.

The setup is very simple: The bot moves towards an object while sending data to a controller. This controller analyzes the lidar data and when needed sends a stop signal to the bot, which will then brake.

## 3.2) Model and Assumptions
Starting in a simplified case we suppose a symmetric communication link:
- E2E Packet loss: $p_{e2e}=1-(1-p)^2$ so that $p=p_{tx}=p_{rx}$
- E2E Latency: $\tau_{e2e}=2\tau$ so that $\tau=\tau_{tx}=\tau_{rx}$

Instead of computing $S$, it is first fixed in order to study the crash probability.

Now we define some standard parameters:
- $S$: braking threshold.
- $L$: offset between the measured distance and the front of the robot.
- $m$: required safety margin (can be set to 0).
- $v_\max$: speed of robot while traveling
- $d_{brake}$: braking distance.
- $T$: transmission/sampling period.

_(distances are in meters, $v_{max}$ is in $m/s$, and times are in ${ms}$.)

Some other parameters can be calculated immediately:
- $d_\max=m+L+d_{brake}$: minimum measured distance before braking
- $\Delta d=S-d_\max$: space in which the brake must happen 
- $\Delta t=1000\cdot\frac{\Delta d}{v_\max}$: time budget for the brake

Finally suppose a synchronized clock.

We define TX as bot$\rightarrow$controller and RX as controller$\rightarrow$bot.
## 3.3) Communication Delay
Let $X,Y\sim\text{Geom.}(1-p)$ be the numbers of failed attempts on the sensor and brake links, and let $A=X+Y$.
Let $\phi \sim \mathcal{U}(0, T)$ be the wait from the threshold crossing to the next transmission window.
Let $\psi\sim\mathcal U(0,T)$ be wait given by the phase difference between the two send windows.

The communication delay on each link is:
$$t_{tx/rx}=\tau+Ti\quad \mathbb E[t_{tx/rx}]=\tau+\frac{pT}{1-p}\qquad i=\{X,Y\}$$
The end to end communication delay is:
$$t_{e2e}=t_{tx}+t_{rx}=\tau_{e2e}+AT\qquad \mathbb E[t_{e2e}]=\tau_{e2e}+\frac{2pT}{1-p}$$
However, one significant transmission is the crossing of the threshold, which has an added time $\phi$ in bot$\rightarrow$controller transmission and $\psi$ in controller$\rightarrow$bot transmission:
$$\begin{gather}
t_{tx,thresh}=\tau_{tx}+XT+\phi\qquad \mathbb E[t_{tx,thresh}]=\tau+T\frac{1+p}{2(1-p)}\\
t_{rx,thresh}=\tau_{rx}+YT+\psi\qquad \mathbb E[t_{rx,thresh}]=\tau+T\frac{1+p}{2(1-p)}\\
t_{e2e,thresh}=t_{e2e}+\phi+\psi\qquad \mathbb E[t_{e2e,thresh}]=\tau_{e2e}+T\frac{1+p}{1-p}\\
\end{gather}$$
for notation sake we will call these
$$\mathbb{E}[t]:=\mathbb{E}[t_{tx,thresh}]=\mathbb{E}[t_{rx,thresh}]\qquad \mathbb{E}[t_{e2e,thresh}]=2\mathbb{E}[t]$$
One quick feasibility check can be done on
$$2\mathbb E[t]\leq \Delta t$$
##### Proof
We first compute the expected number of failures on a link. Since $X$ counts the failed attempts before the first success, $P(X=n)=p^n(1-p)$ for $n\in\{0,1,2,\dots\}$. Using $\sum_{n=0}^\infty np^n=\frac{p}{(1-p)^2}$, for $|p|<1$:
$$\E[X]=\sum_{n=0}^\infty n\,p^n(1-p)=(1-p)\frac{p}{(1-p)^2}=\frac{p}{1-p}$$
The same result holds for $Y$.

Since $\tau$ and $T$ are constants, linearity of expectation gives the delay on each link:
$$\E[t_{tx}]=\tau+T\,\E[X]=\tau+\frac{pT}{1-p}\qquad\E[t_{rx}]=\tau+T\,\E[Y]=\tau+\frac{pT}{1-p}$$
Adding the two links, with $\tau_{e2e}=2\tau$:
$$\E[t_{e2e}]=\E[t_{tx}]+\E[t_{rx}]=\tau_{e2e}+\frac{2pT}{1-p}$$

Next, for $\phi\sim\mathcal U(0,T)$:
$$\E[\phi]=\int_0^T\frac{\phi}{T}\,d\phi=\frac1T\left[\frac{\phi^2}2\right]_0^T=\frac T2$$
The same result holds for $\psi$.

For the threshold transmission on each link, we add the corresponding wait:
$$\E[t_{tx,thresh}]=\tau+\frac{pT}{1-p}+\frac T2=\tau+T\,\frac{2p+(1-p)}{2(1-p)}=\tau+T\frac{1+p}{2(1-p)}$$
$$\E[t_{rx,thresh}]=\tau+\frac{pT}{1-p}+\frac T2=\tau+T\frac{1+p}{2(1-p)}$$
Both links have the same expected delay, so $\E[t]$ is well defined. Finally:
$$\E[t_{e2e,thresh}]=\E[t_{tx,thresh}]+\E[t_{rx,thresh}]=\tau_{e2e}+T\frac{1+p}{1-p}=2\E[t]$$
Only linearity of expectation is used, so this result does not require $X$, $Y$, $\phi$ and $\psi$ to be independent. For the feasibility check, the mean delay fits the time budget exactly when $2\E[t]\leq\Delta t$. This compares only the mean with the budget, so it is not a safety guarantee.
$$\endproof$$

## 3.4) Minimum Distance
The delay of the threshold transmission determines how far the bot travels before it starts braking, so it also determines how close the bot gets to the obstacle. This section quantifies that closest distance, in order to show the average safety of a given threshold $S$.

The bot moves at constant speed until the STOP is received. When the threshold is crossed, the measured distance is $S$, which means that the front of the bot is at a distance $S-L$ from the obstacle. From this point, the bot:
* travels at $v_\max$ for the time $t_{e2e,thresh}$ needed by the LiDAR data to reach the controller and by the STOP to reach the bot.
* covers the braking distance $d_{brake}$ once the STOP is received.

The distance that remains between the bot and the obstacle after it has stopped is the minimum distance $d_\min$. This is a signed quantity, where a negative value means that the bot would overlap with the obstacle:
$$d_\min=S-L-d_{brake}-\frac{v_\max}{1000}\,t_{e2e,thresh}\qquad\mathbb E[d_\min]=S-L-d_{brake}-\frac{2\mathbb E[t]\,v_\max}{1000}$$

Note that the margin m does not appear, since it is a requirement on $d_\min$ and not part of the motion of the bot. A value of $\mathbb E[d_\min]\geq m$ only means that the safety margin is respected on average, so it does not exclude that some stops will breach it.
##### Proof
When the threshold is crossed, the measured distance is $S$, so the front of the bot is at distance $S-L$ from the obstacle. The bot then travels at $v_\max$ until the STOP arrives, which takes $t_{e2e,thresh}$, and finally covers $d_{brake}$ while braking. Therefore:
$$d_\min=S-L-d_{brake}-\frac{v_\max}{1000}\,t_{e2e,thresh}$$
where
$$t_{e2e,thresh}=(X+Y)T+\tau_{e2e}+\phi+\psi$$
Since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, linearity of expectation gives:
$$\begin{align}
\E[t_{e2e,thresh}]&=(\E[X]+\E[Y])T+\tau_{e2e}+\E[\phi]+\E[\psi]\\
&=\frac{2p}{1-p}T+\tau_{e2e}+\frac T2+\frac T2\\
&=\tau_{e2e}+T\frac{1+p}{1-p}\\
&=2\E[t]
\end{align}$$
Substituting into $d_\min$ gives:
$$\E[d_\min]=S-L-d_{brake}-\frac{2\E[t]v_\max}{1000}$$
$$\endproof$$


## 3.5) Variances of CD and MD