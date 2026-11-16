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
## 3.3) Communication Delay (CD)
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

## 3.4) Minimum Distance (MD)
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
The expected values describe only the average stop. Two stops can behave very differently, because the number of retransmissions and the waits change the delay each time. This section measures that spread, which shows how far a single stop can fall from the expected minimum distance.

We assume that $X$, $Y$, $\phi$ and $\psi$ are independent. The threshold transmission on each link then has variance:
$$\text{Var}(t_{tx,thresh})=\text{Var}(t_{rx,thresh})=T^2\left(\frac{p}{(1-p)^2}+\frac1{12}\right)$$
The two links have independent delays, so their variances add. The end to end variance is:
$$\text{Var}(t_{e2e,thresh})=T^2\left(\frac{2p}{(1-p)^2}+\frac16\right)$$
Since $d_\min$ depends on the delay through the factor $\frac{v_\max}{1000}$, the minimum distance has variance:
$$\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2T^2\left(\frac{2p}{(1-p)^2}+\frac16\right)$$
Note that $\text{Var}(t_{e2e,thresh})<4\,\text{Var}(t_{tx,thresh})$. The two link delays have the same distribution but are different random variables, so the end to end delay is not twice a single link delay.

##### Proof
Since $X$ counts the failures before the first success, with $P(X=n)=p^n(1-p)$, its variance is:
$$\text{Var}(X)=\frac{p}{(1-p)^2}$$
The same result holds for $Y$. For a uniform distribution $\mathcal U(a,b)$ the variance is $\frac{(b-a)^2}{12}$, therefore:
$$\text{Var}(\phi)=\text{Var}(\psi)=\frac{T^2}{12}$$
Since $\tau$ is a constant and $T$ is a scaling factor, and using the independence of $X$ and $\phi$:
$$\text{Var}(t_{tx,thresh})=\text{Var}(\tau+XT+\phi)=T^2\,\text{Var}(X)+\text{Var}(\phi)=T^2\left(\frac{p}{(1-p)^2}+\frac1{12}\right)$$
The same steps with $Y$ and $\psi$ give $\text{Var}(t_{rx,thresh})$.

Since $t_{e2e,thresh}=t_{tx,thresh}+t_{rx,thresh}$, and the two terms are independent:
$$\text{Var}(t_{e2e,thresh})=\text{Var}(t_{tx,thresh})+\text{Var}(t_{rx,thresh})=T^2\left(\frac{2p}{(1-p)^2}+\frac16\right)$$
Finally, recall that
$$d_\min=S-L-d_{brake}-\frac{v_\max}{1000}\,t_{e2e,thresh}$$
Since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, the variance depends entirely on $t_{e2e,thresh}$:
$$\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2\text{Var}(t_{e2e,thresh})=\left(\frac{v_\max}{1000}\right)^2T^2\left(\frac{2p}{(1-p)^2}+\frac16\right)$$
$$\endproof$$

## 3.6) Crash Probability (CProb)
A positive expected minimum distance does not mean that every stop is safe, because a long delay can still breach the margin. This section computes the probability of that event, which is the main result of the model. A crash occurs when the threshold transmission takes longer than the time budget:
$$t_{e2e,thresh}>\Delta t$$
Let $N_\tau$ be the attempt budget, and $R$ the time left over after $N_\tau$ full periods:
$$N_\tau=\floor{\frac{\Delta t-\tau_{e2e}}T}\qquad R=\Delta t-\tau_{e2e}-N_\tau T\qquad 0\leq R<T$$
For $k\geq 1$, let $F(k)=\mathbb P(A\geq k)$ and $f(k)=\mathbb P(A=k)$, with $F(k)=1$ for $k\leq 0$ and $f(k)=0$ for $k<0$:
$$F(k)=p^k\left[1+k(1-p)\right]\qquad f(k)=(k+1)p^k(1-p)^2$$
For $\Delta t\geq\tau_{e2e}$, the exact crash probability is:
$$P_{crash}=F(N_\tau+1)+f(N_\tau)\left(1-\frac{R^2}{2T^2}\right)+f(N_\tau-1)\frac{(T-R)^2}{2T^2}$$
Which can be rewritten as:
$$P_{crash}=\begin{cases}
p^{N_\tau-1}\left\{p\left[1+N_\tau(1-p)\right]+\frac{(1-p)^2}{2T^2}\left[N_\tau(T-R)^2-(N_\tau+1)pR^2\right]\right\} & N_\tau\geq1\\
1-\frac{(1-p)^2}{2T^2}R^2&N_\tau=0\\
1 &N_\tau<0
\end{cases}$$


If $\Delta t<\tau_{e2e}$, a crash is certain. 

Three simpler expressions can also be used. 
Ignoring both waits gives a lower bound on the crash probability:
$$P_{low}(p,N_\tau)=F(N_\tau+1)=p^{N_\tau+1}\left[1+(N_\tau+1)(1-p)\right]$$
Taking the largest possible value of both waits gives an upper bound on the crash probability:
$$P_{high}(p,N_\tau)=F(N_\tau-1)=p^{N_\tau-1}\left[1+(N_\tau-1)(1-p)\right]\qquad N_\tau\geq 1$$
For $N_\tau<1$, $P_{high}=1$. The exact probability therefore satisfies:
$$P_{low}\leq P_{crash}\leq P_{high}$$
Taking the largest possible wait sets $W=2T$, so a crash requires $(A+2)T>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau-1$, which gives $P_{high}$. Since $W\leq 2T$, every crash satisfies this condition, so $P_{crash}\leq P_{high}$.

Replacing each wait by its mean $T/2$ gives an approximation, which is neither a lower nor an upper bound:
$$P'(p,N_\tau)=F(N_\tau)=p^{N_\tau}\left[1+N_\tau(1-p)\right]$$

##### Proof
We first compute $F(k)$ for $k\geq 1$. The event $A\geq k$ occurs in two mutually exclusive scenarios:
- Data Fail: the sensor packet alone reaches $k$ failures, so $X\geq k$.
- Brake Fail: $X=n$ with $n\in\{0,\dots,k-1\}$, and the brake command fails at least $k-n$ times.

For the first scenario:
$$P_{\text{data fail}}=\mathbb P(X\geq k)=p^k$$
For the second scenario, using the independence of $X$ and $Y$:
$$\begin{align}
P_{\text{brake fail}}&=\sum_{n=0}^{k-1}\mathbb P(X=n)\,\mathbb P(Y\geq k-n)\\
&=\sum_{n=0}^{k-1}(1-p)p^n\cdot p^{k-n}\\
&=k(1-p)p^k
\end{align}$$
Adding the two gives $F(k)=p^k\left[1+k(1-p)\right]$. 
The difference $F(k)-F(k+1)$ then gives $f(k)=(k+1)p^k(1-p)^2$.

---
Now let $W=\phi+\psi$ be the total wait. Since $\phi$ and $\psi$ are independent $\mathcal U(0,T)$ variables, $W$ has a triangular distribution on $[0,2T]$, with tail:
$$\mathbb P(W>u)=\begin{cases}1-\dfrac{u^2}{2T^2}&0\leq u\leq T\\[2mm]\dfrac{(2T-u)^2}{2T^2}&T\leq u\leq 2T\end{cases}$$
Using $t_{e2e,thresh}=\tau_{e2e}+AT+W$ and $\Delta t-\tau_{e2e}=N_\tau T+R$, the crash condition becomes:
$$AT+W>N_\tau T+R$$
Conditioning on $A$, which is independent of $W$:
$$P_{crash}=\sum_{k=0}^\infty f(k)\,\mathbb P\left(W>(N_\tau-k)T+R\right)$$
Each value of $k$ gives one of four cases:
- $k\geq N_\tau+1$: the bound is negative, so the probability is $1$. These terms sum to $F(N_\tau+1)$.
- $k=N_\tau$: the bound is $R$, so the probability is $1-\frac{R^2}{2T^2}$.
- $k=N_\tau-1$: the bound is $T+R$, so the probability is $\frac{(T-R)^2}{2T^2}$.
- $k\leq N_\tau-2$: the bound is at least $2T$, so the probability is $0$.

Summing the terms gives $P_{crash}$.
$$P_{crash} = \underbrace{\sum_{k=0}^{N_\tau - 2} f(k) \cdot 0}_{= \, 0} \;+\; \underbrace{f(N_\tau - 1)\frac{(T-R)^2}{2T^2}}_{k = N_\tau - 1} \;+\; \underbrace{f(N_\tau)\left(1 - \frac{R^2}{2T^2}\right)}_{k = N_\tau} \;+\; \underbrace{\sum_{k=N_\tau + 1}^\infty f(k) \cdot 1}_{= \, F(N_\tau + 1)}$$

---
Ignoring both waits sets $W=0$, so a crash requires $AT>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau+1$, which gives $P_{low}$. A crash with $A\geq N_\tau+1$ occurs for any value of $W$, so $P_{low}\leq P_{crash}$.

Replacing each wait by its mean sets $W=T$, so a crash requires $(A+1)T>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau$, which gives $P'$. As $W$ is random, this is not the true probability, and it can fall on either side of $P_{crash}$.
$$\endproof$$
## 3.7) S.M.A.R.T Algorithm
The previous section computes the crash probability for a fixed threshold $S$. The **S.M.A.R.T. (Safety Margin Automatic Readjust Tool)** algorithm solves the inverse problem: given the current network conditions, it finds the threshold that meets a desired crash probability $P_{target}\in(0,1)$. A small threshold lets the bot travel further before braking, but it leaves less time for the STOP to arrive, so the aim is to choose $S$ as low as the target allows.

Every crash probability model depends on $S$ through the budget $B=\Delta t-\tau_{e2e}$. Inverting the definition of $\Delta t$, a budget $B$ corresponds to the threshold:
$$S(B)=\frac{v_\max}{1000}\left(B+\tau_{e2e}\right)+L+m+d_{brake}$$
Let $N^*$ be the first $N\in\mathbb N^+$ that satisfies:
$$F(N)=p^N\left[1+N(1-p)\right]\leq P_{target}$$
Applying each model of the previous section gives one version of the algorithm:

| Version     | Model       | Budget $B$ | Meets $P_{target}$?                      |
| ----------- | ----------- | ---------- | ---------------------------------------- |
| $S_{low}$   | $P_{low}$   | $T(N^*-1)$ | No, it ignores both waits                |
| $S'$        | $P'$        | $TN^*$     | Not guaranteed                           |
| $S_{high}$  | $P_{high}$  | $T(N^*+1)$ | Yes, for any waits                       |
| $S_{smart}$ | $P_{crash}$ | $B_{min}$  | Yes, and it is the lowest such threshold |

Explicitly:
$$S_{low}=\frac{v_\max}{1000}\left(T(N^*-1)+\tau_{e2e}\right)+L+m+d_{brake}$$
$$S'=\frac{v_\max}{1000}\left(TN^*+\tau_{e2e}\right)+L+m+d_{brake}$$
$$S_{high}=\frac{v_\max}{1000}\left(T(N^*+1)+\tau_{e2e}\right)+L+m+d_{brake}$$
$$S_{smart}=\frac{v_\max}{1000}\left(B_{min}+\tau_{e2e}\right)+L+m+d_{brake}$$
To compute $B_{min}$, let $P_n=F(n)+\frac{f(n-1)}2$ be the crash probability at the budget $B=nT$, and let $j\geq 1$ be the smallest integer with $P_j\leq P_{target}$. With $n=j-1$, $\gamma=f(n-1)-f(n)$ and $D=P_n-P_{target}$:
$$B_{min}=nT+\frac{2DT}{f(n-1)+\sqrt{f(n-1)^2-2\gamma D}}$$
The thresholds always satisfy:
$$S_{low}\leq S_{smart}\leq S_{high}\qquad S_{low}\leq S'\leq S_{high}$$
$S'$ can fall on either side of $S_{smart}$.

##### Proof
Existence of $N^*$: since $F(N)-F(N+1)=f(N)=(N+1)p^N(1-p)^2>0$, $F$ is strictly decreasing. Moreover $F(0)=1$ and $\lim_{N\to\infty}F(N)=0$, so a first $N^*\in\mathbb N^+$ with $F(N^*)\leq P_{target}$ exists.

---
Discrete versions: we look for the smallest attempt budget $N_\tau$ that meets the target. Since $F$ is decreasing, $F(k)\leq P_{target}$ exactly when $k\geq N^*$. Therefore:
- $P_{low}=F(N_\tau+1)\leq P_{target}$ requires $N_\tau\geq N^*-1$.
- $P'=F(N_\tau)\leq P_{target}$ requires $N_\tau\geq N^*$.
- $P_{high}=F(N_\tau-1)\leq P_{target}$ requires $N_\tau\geq N^*+1$.

The smallest budget with $N_\tau$ attempts is $B=TN_\tau$, which gives the three thresholds. Since $P_{crash}\leq P_{high}$, $S_{high}$ meets the target for any waits. As $P_{low}$ and $P'$ are not upper bounds on $P_{crash}$, the other two versions do not guarantee it.

---
Exact version: write $G(u)=\mathbb P(W>u)$, so that as a function of the budget:
$$P_{crash}(B)=\sum_{k=0}^\infty f(k)\,G(B-kT)$$
$G$ is continuous, and each term is at most $f(k)$ with $\sum_kf(k)=1$, so the series converges uniformly and $P_{crash}$ is continuous.

Take $0\leq B_1<B_2$. Each term is non-increasing in $B$. For $k_0=\floor{B_1/T}$ we have $B_1-k_0T\in[0,T)$, where $G$ is strictly decreasing, and $f(k_0)>0$. Therefore $P_{crash}$ is strictly decreasing in $B$. Since $P_{crash}(0)=1$ and $P_{crash}\leq P_{high}\to 0$, the Intermediate Value Theorem gives a unique $B_{min}$ with $P_{crash}(B_{min})=P_{target}$, and $P_{crash}(B)\leq P_{target}$ exactly when $B\geq B_{min}$. So $S_{smart}=S(B_{min})$ is the lowest threshold that meets the target.

Setting $R=0$ in $P_{crash}$ and using $F(n+1)+f(n)=F(n)$ gives $P_n=F(n)+f(n-1)/2$. By the choice of $j$, $P_n>P_{target}\geq P_{n+1}$, so $B_{min}=nT+R$ with $0<R\leq T$. Expanding $P_{crash}$ for $N_\tau=n$ gives:
$$P_{crash}=P_n-f(n-1)\frac RT+\gamma\frac{R^2}{2T^2}$$
With $x=R/T$, the target is met when $q(x)=\frac\gamma2x^2-f(n-1)x+D=0$, where $q(0)=D>0$ and $q(1)\leq 0$. The root in $(0,1]$ is unique:
- If $\gamma>0$, it is the smaller of two positive roots.
- If $\gamma<0$, the roots have opposite signs and it is the positive one.
- If $\gamma=0$, the equation is linear.

In each case, this root equals:
$$x=\frac{2D}{f(n-1)+\sqrt{f(n-1)^2-2\gamma D}}$$
Multiplying by $T$ gives $B_{min}$.

---
Ordering: for $N_\tau\leq N^*-2$, $P_{crash}\geq P_{low}=F(N_\tau+1)>P_{target}$, so $B_{min}\geq T(N^*-1)$. Moreover $S_{high}$ meets the target, so $B_{min}\leq T(N^*+1)$. This gives $S_{low}\leq S_{smart}\leq S_{high}$. The bound on $S'$ follows directly from the budgets.
$$\endproof$$


# 4) Ci riprovo: Asymmetric Case
## 4.1) Intro

This work aims to design a model that can predict the crash probability of a bot under unstable network conditions.

The setup is very simple: The bot moves towards an object while sending data to a controller. This controller analyzes the lidar data and when needed sends a stop signal to the bot, which will then brake.

## 4.2) Model and Assumptions

We define TX as bot$\rightarrow$controller and RX as controller$\rightarrow$bot. The two directions of the communication link can behave differently, so each one has its own packet loss and latency:

- E2E Packet loss: $p_{e2e}=1-(1-p_{tx})(1-p_{rx})$, with $0\leq p_{tx},p_{rx}<1$, not both zero.
- E2E Latency: $\tau_{e2e}=\tau_{tx}+\tau_{rx}$

Instead of computing $S$, it is first fixed in order to study the crash probability.

Now we define some standard parameters:

- $S$: braking threshold.
- $L$: offset between the measured distance and the front of the robot.
- $m$: required safety margin (can be set to 0).
- $v_\max$: speed of robot while traveling.
- $d_{brake}$: braking distance.
- $T$: transmission/sampling period, equal for both links.

_(distances are in meters, $v_{max}$ is in $m/s$, and times are in $ms$.)_

Some other parameters can be calculated immediately:

- $d_\max=m+L+d_{brake}$: last measured distance at which braking can start safely.
- $\Delta d=S-d_\max$: distance the bot can travel before braking must start.
- $\Delta t=1000\cdot\frac{\Delta d}{v_\max}$: time available for the LiDAR data and the STOP to complete their round trip.

Finally suppose a synchronized clock. The LiDAR and control streams are transmitted independently, and their windows are not aligned. While the measured distance is above $S$, the controller sends GO. Once the threshold crossing has been detected, every following control message is STOP. We assume that:

- Packet losses are independent.
- Lost LiDAR data is replaced by the next scan, and a lost STOP by the next control message.
- The bot travels at $v_\max$ until a STOP is received, and then brakes immediately.

## 4.3) Communication Delay (CD)

Let $X\sim\text{Geom.}(1-p_{tx})$ and $Y\sim\text{Geom.}(1-p_{rx})$ be the numbers of failed attempts on the sensor and brake links, starting from 0, and let $A=X+Y$.

Let $\phi \sim \mathcal{U}(0, T)$ be the wait from the threshold crossing to the next LiDAR transmission window. It changes with each stop. Let $\psi\sim\mathcal U(0,T)$ be the wait from the LiDAR data arriving at the controller to the next control transmission window. It is set by the phase difference between the two send windows, so it is constant during a run and varies across runs.

The communication delay on each link is: $$t_{tx}=\tau_{tx}+XT\qquad \mathbb E[t_{tx}]=\tau_{tx}+\frac{p_{tx}T}{1-p_{tx}}$$ $$t_{rx}=\tau_{rx}+YT\qquad \mathbb E[t_{rx}]=\tau_{rx}+\frac{p_{rx}T}{1-p_{rx}}$$ The end to end communication delay is: $$t_{e2e}=t_{tx}+t_{rx}=\tau_{e2e}+AT\qquad \mathbb E[t_{e2e}]=\tau_{e2e}+T\left(\frac{p_{tx}}{1-p_{tx}}+\frac{p_{rx}}{1-p_{rx}}\right)$$ However, one significant transmission is the crossing of the threshold, which has an added time $\phi$ in bot$\rightarrow$controller transmission and $\psi$ in controller$\rightarrow$bot transmission: $$\begin{gather} t_{tx,thresh}=\tau_{tx}+XT+\phi\qquad \mathbb E[t_{tx,thresh}]=\tau_{tx}+T\frac{1+p_{tx}}{2(1-p_{tx})}\\ t_{rx,thresh}=\tau_{rx}+YT+\psi\qquad \mathbb E[t_{rx,thresh}]=\tau_{rx}+T\frac{1+p_{rx}}{2(1-p_{rx})}\\ t_{e2e,thresh}=t_{e2e}+\phi+\psi\qquad \mathbb E[t_{e2e,thresh}]=\tau_{e2e}+T\frac{1-p_{tx}p_{rx}}{1-p_{e2e}} \end{gather}$$ One quick feasibility check can be done on $$\mathbb E[t_{e2e,thresh}]\leq \Delta t$$

##### Proof

We first compute the expected number of failures on a link. Since $X$ counts the failed attempts before the first success, $P(X=n)=p_{tx}^n(1-p_{tx})$ for $n\in{0,1,2,\dots}$. Using $\sum_{n=0}^\infty np^n=\frac{p}{(1-p)^2}$, for $|p|<1$: $$\E[X]=\sum_{n=0}^\infty n,p_{tx}^n(1-p_{tx})=(1-p_{tx})\frac{p_{tx}}{(1-p_{tx})^2}=\frac{p_{tx}}{1-p_{tx}}$$ In the same way, $\E[Y]=\frac{p_{rx}}{1-p_{rx}}$.

Since the latencies and $T$ are constants, linearity of expectation gives the delay on each link: $$\E[t_{tx}]=\tau_{tx}+T,\E[X]=\tau_{tx}+\frac{p_{tx}T}{1-p_{tx}}\qquad\E[t_{rx}]=\tau_{rx}+T,\E[Y]=\tau_{rx}+\frac{p_{rx}T}{1-p_{rx}}$$ Adding the two links, with $\tau_{e2e}=\tau_{tx}+\tau_{rx}$: $$\E[t_{e2e}]=\E[t_{tx}]+\E[t_{rx}]=\tau_{e2e}+T\left(\frac{p_{tx}}{1-p_{tx}}+\frac{p_{rx}}{1-p_{rx}}\right)$$

Next, for $\phi\sim\mathcal U(0,T)$: $$\E[\phi]=\int_0^T\frac{\phi}{T},d\phi=\frac1T\left[\frac{\phi^2}2\right]_0^T=\frac T2$$ The same result holds for $\psi$.

For the threshold transmission on each link, we add the corresponding wait: $$\E[t_{tx,thresh}]=\tau_{tx}+\frac{p_{tx}T}{1-p_{tx}}+\frac T2=\tau_{tx}+T,\frac{2p_{tx}+(1-p_{tx})}{2(1-p_{tx})}=\tau_{tx}+T\frac{1+p_{tx}}{2(1-p_{tx})}$$ $$\E[t_{rx,thresh}]=\tau_{rx}+\frac{p_{rx}T}{1-p_{rx}}+\frac T2=\tau_{rx}+T\frac{1+p_{rx}}{2(1-p_{rx})}$$ Finally, adding the two and using $1-p_{e2e}=(1-p_{tx})(1-p_{rx})$: $$\begin{align} \E[t_{e2e,thresh}]&=\E[t_{tx,thresh}]+\E[t_{rx,thresh}]\ &=\tau_{e2e}+\frac T2\left(\frac{1+p_{tx}}{1-p_{tx}}+\frac{1+p_{rx}}{1-p_{rx}}\right)\ &=\tau_{e2e}+\frac T2\cdot\frac{(1+p_{tx})(1-p_{rx})+(1+p_{rx})(1-p_{tx})}{(1-p_{tx})(1-p_{rx})}\ &=\tau_{e2e}+T,\frac{1-p_{tx}p_{rx}}{1-p_{e2e}} \end{align}$$ Only linearity of expectation is used, so this result does not require $X$, $Y$, $\phi$ and $\psi$ to be independent. For the feasibility check, the mean delay fits the time budget exactly when $\E[t_{e2e,thresh}]\leq\Delta t$. This compares only the mean with the budget, so it is not a safety guarantee.

With $p_{tx}=p_{rx}=p$ we get the result of the symmetric case, since $\frac{1-p^2}{(1-p)^2}=\frac{1+p}{1-p}$. $$\endproof$$

## 4.4) Minimum Distance (MD)

The delay of the threshold transmission determines how far the bot travels before it starts braking, so it also determines how close the bot gets to the obstacle. This section quantifies that closest distance, in order to show the average safety of a given threshold $S$.

The bot moves at constant speed until the STOP is received. When the threshold is crossed, the measured distance is $S$, which means that the front of the bot is at a distance $S-L$ from the obstacle. From this point, the bot:

- travels at $v_\max$ for the time $t_{e2e,thresh}$ needed by the LiDAR data to reach the controller and by the STOP to reach the bot.
- covers the braking distance $d_{brake}$ once the STOP is received.

The distance that remains between the bot and the obstacle after it has stopped is the minimum distance $d_\min$. This is a signed quantity, where a negative value means that the bot would overlap with the obstacle: $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000},t_{e2e,thresh}\qquad\mathbb E[d_\min]=S-L-d_{brake}-\frac{\mathbb E[t_{e2e,thresh}],v_\max}{1000}$$

Note that the margin $m$ does not appear, since it is a requirement on $d_\min$ and not part of the motion of the bot. A value of $\mathbb E[d_\min]\geq m$ only means that the safety margin is respected on average, so it does not exclude that some stops will breach it.

##### Proof

When the threshold is crossed, the measured distance is $S$, so the front of the bot is at distance $S-L$ from the obstacle. The bot then travels at $v_\max$ until the STOP arrives, which takes $t_{e2e,thresh}$, and finally covers $d_{brake}$ while braking. Therefore: $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000},t_{e2e,thresh}$$ Since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, linearity of expectation gives: $$\E[d_\min]=S-L-d_{brake}-\frac{\E[t_{e2e,thresh}],v_\max}{1000}$$ where $\E[t_{e2e,thresh}]$ is given in Section 4.3. $$\endproof$$

## 4.5) Variances of CD and MD

The expected values describe only the average stop. Two stops can behave very differently, because the number of retransmissions and the waits change the delay each time. This section measures that spread, which shows how far a single stop can fall from the expected minimum distance.

We assume that $X$, $Y$, $\phi$ and $\psi$ are independent. The threshold transmission on each link then has variance: $$\text{Var}(t_{tx,thresh})=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac1{12}\right)\qquad\text{Var}(t_{rx,thresh})=T^2\left(\frac{p_{rx}}{(1-p_{rx})^2}+\frac1{12}\right)$$ The two links have independent delays, so their variances add. The end to end variance is: $$\text{Var}(t_{e2e,thresh})=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac16\right)$$ Since $d_\min$ depends on the delay through the factor $\frac{v_\max}{1000}$, the minimum distance has variance: $$\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac16\right)$$ The latencies do not appear, since they are constants and only shift the delay.

##### Proof

Since $X$ counts the failures before the first success, with $P(X=n)=p_{tx}^n(1-p_{tx})$, its variance is: $$\text{Var}(X)=\frac{p_{tx}}{(1-p_{tx})^2}$$ In the same way, $\text{Var}(Y)=\frac{p_{rx}}{(1-p_{rx})^2}$. For a uniform distribution $\mathcal U(a,b)$ the variance is $\frac{(b-a)^2}{12}$, therefore: $$\text{Var}(\phi)=\text{Var}(\psi)=\frac{T^2}{12}$$ Since $\tau_{tx}$ is a constant and $T$ is a scaling factor, and using the independence of $X$ and $\phi$: $$\text{Var}(t_{tx,thresh})=\text{Var}(\tau_{tx}+XT+\phi)=T^2,\text{Var}(X)+\text{Var}(\phi)=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac1{12}\right)$$ The same steps with $Y$ and $\psi$ give $\text{Var}(t_{rx,thresh})$.

Since $t_{e2e,thresh}=t_{tx,thresh}+t_{rx,thresh}$, and the two terms are independent: $$\text{Var}(t_{e2e,thresh})=\text{Var}(t_{tx,thresh})+\text{Var}(t_{rx,thresh})=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac16\right)$$ Finally, recall that $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000},t_{e2e,thresh}$$ Since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, the variance depends entirely on $t_{e2e,thresh}$: $$\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2\text{Var}(t_{e2e,thresh})=\left(\frac{v_\max}{1000}\right)^2T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac16\right)$$ $$\endproof$$

## 4.6) Crash Probability (CProb)

A positive expected minimum distance does not mean that every stop is safe, because a long delay can still breach the margin. This section computes the probability of that event, which is the main result of the model. A crash occurs when the threshold transmission takes longer than the time budget: $$t_{e2e,thresh}>\Delta t$$ Let $N_\tau$ be the attempt budget, and $R$ the time left over after $N_\tau$ full periods: $$N_\tau=\floor{\frac{\Delta t-\tau_{e2e}}T}\qquad R=\Delta t-\tau_{e2e}-N_\tau T\qquad 0\leq R<T$$ Let $f(k)=\mathbb P(A=k)$ be the probability of exactly $k$ failures, and $F(k)=\mathbb P(A\geq k)$ the probability of at least $k$ failures. For $k\geq 0$ and $p_{tx}\not=p_{rx}$: $$f(k)=(1-p_{tx})(1-p_{rx})\frac{p_{rx}^{k+1}-p_{tx}^{k+1}}{p_{rx}-p_{tx}}\qquad F(k)=\frac{(1-p_{tx})p_{rx}^{k+1}-(1-p_{rx})p_{tx}^{k+1}}{p_{rx}-p_{tx}}$$ If $p_{tx}=p_{rx}=p$, these become as before: $$f(k)=(k+1)p^k(1-p)^2\qquad F(k)=p^k\left[1+k(1-p)\right]$$ For $k<0$, we set $f(k)=0$, since a negative number of failures is impossible, and $F(k)=1$, since $A\geq 0$ always holds. Both functions are unchanged when $p_{tx}$ and $p_{rx}$ swap, so the order of the links does not affect the crash probability.

For $\Delta t\geq\tau_{e2e}$, the exact crash probability is: $$P_{crash}=F(N_\tau+1)+f(N_\tau)\left(1-\frac{R^2}{2T^2}\right)+f(N_\tau-1)\frac{(T-R)^2}{2T^2}$$ Covering all cases, this can be written for $p_{tx}\not=p_{rx}$ as: $$P_{crash}=\begin{cases} F(N_\tau)+\dfrac{(1-p_{tx})(1-p_{rx})}{2T^2(p_{rx}-p_{tx})}\left[\left(p_{rx}^{N_\tau}-p_{tx}^{N_\tau}\right)(T-R)^2-\left(p_{rx}^{N_\tau+1}-p_{tx}^{N_\tau+1}\right)R^2\right]& N_\tau\geq1\\ 1-\dfrac{(1-p_{tx})(1-p_{rx})}{2T^2}R^2&N_\tau=0\\
1 &N_\tau<0 
\end{cases}$$ If $\Delta t<\tau_{e2e}$, a crash is certain.

Three simpler expressions can also be used. Ignoring both waits gives a lower bound on the crash probability: $$P_{low}(N_\tau)=F(N_\tau+1)$$ Taking the largest possible value of both waits gives an upper bound on the crash probability: $$P_{high}(N_\tau)=F(N_\tau-1)$$ The exact probability therefore satisfies: $$P_{low}\leq P_{crash}\leq P_{high}$$ Replacing each wait by its mean $T/2$ gives an approximation, which is neither a lower nor an upper bound: $$P'(N_\tau)=F(N_\tau)$$

##### Proof

We first compute $F(k)$ for $k\geq 1$ and $p_{tx}\not=p_{rx}$. The event $A\geq k$ occurs in two mutually exclusive scenarios:

- Data Fail: the sensor packet alone reaches $k$ failures, so $X\geq k$.
- Brake Fail: $X=n$ with $n\in{0,\dots,k-1}$, and the brake command fails at least $k-n$ times.

For the first scenario: $$P_{\text{data fail}}=\mathbb P(X\geq k)=p_{tx}^k$$ For the second scenario, using the independence of $X$ and $Y$: $$\begin{align} P_{\text{brake fail}}&=\sum_{n=0}^{k-1}\mathbb P(X=n),\mathbb P(Y\geq k-n)\ &=\sum_{n=0}^{k-1}(1-p_{tx})p_{tx}^n\cdot p_{rx}^{k-n}\ &=(1-p_{tx}),p_{rx}\sum_{n=0}^{k-1}p_{tx}^n,p_{rx}^{k-1-n}\ &=(1-p_{tx}),p_{rx},\frac{p_{rx}^k-p_{tx}^k}{p_{rx}-p_{tx}} \end{align}$$ Adding the two gives: $$\begin{align} F(k)&=p_{tx}^k+(1-p_{tx}),p_{rx},\frac{p_{rx}^k-p_{tx}^k}{p_{rx}-p_{tx}}\ &=\frac{(1-p_{tx})p_{rx}^{k+1}-(1-p_{rx})p_{tx}^{k+1}}{p_{rx}-p_{tx}} \end{align}$$ This formula also gives $F(0)=1$. The difference $F(k)-F(k+1)$ then gives $f(k)$. For $p_{tx}=p_{rx}=p$, each term of the sum for $P_{\text{brake fail}}$ equals $(1-p)p^k$, which gives $F(k)=p^k\left[1+k(1-p)\right]$ and $f(k)=(k+1)p^k(1-p)^2$.

---

Now let $W=\phi+\psi$ be the total wait. Since $\phi$ and $\psi$ are independent $\mathcal U(0,T)$ variables, $W$ has a triangular distribution on $[0,2T]$, with tail: $$\mathbb P(W>u)=\begin{cases}1-\dfrac{u^2}{2T^2}&0\leq u\leq T\\
\dfrac{(2T-u)^2}{2T^2}&T\leq u\leq 2T\end{cases}$$ Using $t_{e2e,thresh}=\tau_{e2e}+AT+W$ and $\Delta t-\tau_{e2e}=N_\tau T+R$, the crash condition becomes: $$AT+W>N_\tau T+R$$ Conditioning on $A$, which is independent of $W$: $$P_{crash}=\sum_{k=0}^\infty f(k),\mathbb P\left(W>(N_\tau-k)T+R\right)$$ Each value of $k$ gives one of four cases:

- $k\geq N_\tau+1$: the bound is negative, so the probability is $1$. These terms sum to $F(N_\tau+1)$.
- $k=N_\tau$: the bound is $R$, so the probability is $1-\frac{R^2}{2T^2}$.
- $k=N_\tau-1$: the bound is $T+R$, so the probability is $\frac{(T-R)^2}{2T^2}$.
- $k\leq N_\tau-2$: the bound is at least $2T$, so the probability is $0$.

Summing the terms gives $P_{crash}$. $$P_{crash} = \underbrace{\sum_{k=0}^{N_\tau - 2} f(k) \cdot 0}_{= , 0} ;+; \underbrace{f(N_\tau - 1)\frac{(T-R)^2}{2T^2}}_{k = N_\tau - 1} ;+; \underbrace{f(N_\tau)\left(1 - \frac{R^2}{2T^2}\right)}_{k = N_\tau} ;+; \underbrace{\sum_{k=N_\tau + 1}^\infty f(k) \cdot 1}_{= , F(N_\tau + 1)}$$ Using $F(N_\tau+1)+f(N_\tau)=F(N_\tau)$ and substituting $f$ gives the rewritten form. For $N_\tau=0$, $F(0)=1$ and $f(-1)=0$, which gives the second case.

---

Ignoring both waits sets $W=0$, so a crash requires $AT>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau+1$, which gives $P_{low}$. A crash with $A\geq N_\tau+1$ occurs for any value of $W$, so $P_{low}\leq P_{crash}$.

Taking the largest possible wait sets $W=2T$, so a crash requires $(A+2)T>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau-1$, which gives $P_{high}$. Since $W\leq 2T$, every crash satisfies this condition, so $P_{crash}\leq P_{high}$.

Replacing each wait by its mean sets $W=T$, so a crash requires $(A+1)T>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau$, which gives $P'$. As $W$ is random, this is not the true probability, and it can fall on either side of $P_{crash}$. $$\endproof$$

## 4.7) S.M.A.R.T Algorithm

The previous section computes the crash probability for a fixed threshold $S$. The **S.M.A.R.T. (Safety Margin Automatic Readjust Tool)** algorithm solves the inverse problem: given the current network conditions, it finds the threshold that meets a desired crash probability $P_{target}\in(0,1)$. A small threshold lets the bot travel further before braking, but it leaves less time for the STOP to arrive, so the aim is to choose $S$ as low as the target allows.

Every crash probability model depends on $S$ through the budget $B=\Delta t-\tau_{e2e}$. Inverting the definition of $\Delta t$, a budget $B$ corresponds to the threshold: $$S(B)=\frac{v_\max}{1000}\left(B+\tau_{e2e}\right)+L+m+d_{brake}$$ Let $N^*$ be the first $N\in\mathbb N^+$ that satisfies: $$F(N)=\frac{(1-p_{tx})p_{rx}^{N+1}-(1-p_{rx})p_{tx}^{N+1}}{p_{rx}-p_{tx}}\leq P_{target}$$ For $p_{tx}=p_{rx}=p$, this is $F(N)=p^N\left[1+N(1-p)\right]$. Applying each model of the previous section gives one version of the algorithm:

|Version|Model|Budget $B$|Meets $P_{target}$?|
|---|---|---|---|
|$S_{low}$|$P_{low}$|$T(N^*-1)$|No, it ignores both waits|
|$S'$|$P'$|$TN^*$|Not guaranteed|
|$S_{high}$|$P_{high}$|$T(N^*+1)$|Yes, for any waits|
|$S_{smart}$|$P_{crash}$|$B_{min}$|Yes, and it is the lowest such threshold|

Explicitly: $$S_{low}=\frac{v_\max}{1000}\left(T(N^*-1)+\tau_{e2e}\right)+L+m+d_{brake}$$ $$S'=\frac{v_\max}{1000}\left(TN^*+\tau_{e2e}\right)+L+m+d_{brake}$$ $$S_{high}=\frac{v_\max}{1000}\left(T(N^*+1)+\tau_{e2e}\right)+L+m+d_{brake}$$ $$S_{smart}=\frac{v_\max}{1000}\left(B_{min}+\tau_{e2e}\right)+L+m+d_{brake}$$ To compute $B_{min}$, let $P_n=F(n)+\frac{f(n-1)}2$ be the crash probability at the budget $B=nT$, and let $j\geq 1$ be the smallest integer with $P_j\leq P_{target}$. With $n=j-1$, $\gamma=f(n-1)-f(n)$ and $D=P_n-P_{target}$: $$B_{min}=nT+\frac{2DT}{f(n-1)+\sqrt{f(n-1)^2-2\gamma D}}$$ The thresholds always satisfy: $$S_{low}\leq S_{smart}\leq S_{high}\qquad S_{low}\leq S'\leq S_{high}$$ $S'$ can fall on either side of $S_{smart}$.

##### Proof

Existence of $N^*$: since $F(N)-F(N+1)=f(N)>0$, $F$ is strictly decreasing. Moreover $F(0)=1$ and $\lim_{N\to\infty}F(N)=0$, so a first $N^*\in\mathbb N^+$ with $F(N^*)\leq P_{target}$ exists.

---

Discrete versions: we look for the smallest attempt budget $N_\tau$ that meets the target. Since $F$ is decreasing, $F(k)\leq P_{target}$ exactly when $k\geq N^*$. Therefore:

- $P_{low}=F(N_\tau+1)\leq P_{target}$ requires $N_\tau\geq N^*-1$.
- $P'=F(N_\tau)\leq P_{target}$ requires $N_\tau\geq N^*$.
- $P_{high}=F(N_\tau-1)\leq P_{target}$ requires $N_\tau\geq N^*+1$.

The smallest budget with $N_\tau$ attempts is $B=TN_\tau$, which gives the three thresholds. Since $P_{crash}\leq P_{high}$, $S_{high}$ meets the target for any waits. As $P_{low}$ and $P'$ are not upper bounds on $P_{crash}$, the other two versions do not guarantee it.

---

Exact version: write $G(u)=\mathbb P(W>u)$, so that as a function of the budget: $$P_{crash}(B)=\sum_{k=0}^\infty f(k),G(B-kT)$$ $G$ is continuous, and each term is at most $f(k)$ with $\sum_kf(k)=1$, so the series converges uniformly and $P_{crash}$ is continuous.

Take $0\leq B_1<B_2$. Each term is non-increasing in $B$. For $k_0=\floor{B_1/T}$ we have $B_1-k_0T\in[0,T)$, where $G$ is strictly decreasing, and $f(k_0)>0$. Therefore $P_{crash}$ is strictly decreasing in $B$. Since $P_{crash}(0)=1$ and $P_{crash}\leq P_{high}\to 0$, the Intermediate Value Theorem gives a unique $B_{min}$ with $P_{crash}(B_{min})=P_{target}$, and $P_{crash}(B)\leq P_{target}$ exactly when $B\geq B_{min}$. So $S_{smart}=S(B_{min})$ is the lowest threshold that meets the target.

Setting $R=0$ in $P_{crash}$ and using $F(n+1)+f(n)=F(n)$ gives $P_n=F(n)+f(n-1)/2$. By the choice of $j$, $P_n>P_{target}\geq P_{n+1}$, so $B_{min}=nT+R$ with $0<R\leq T$. Expanding $P_{crash}$ for $N_\tau=n$ gives: $$P_{crash}=P_n-\frac{f(n-1)}T,R+\frac\gamma{2T^2},R^2$$ The target is met when $q(R)=\frac\gamma{2T^2}R^2-\frac{f(n-1)}TR+D=0$, where $q(0)=D>0$ and $q(T)\leq 0$. The root in $(0,T]$ is unique:

- If $\gamma>0$, it is the smaller of two positive roots.
- If $\gamma<0$, the roots have opposite signs and it is the positive one.
- If $\gamma=0$, the equation is linear.

In each case, this root equals: $$R=\frac{2DT}{f(n-1)+\sqrt{f(n-1)^2-2\gamma D}}$$ Adding $nT$ gives $B_{min}$.

---

Ordering: for $N_\tau\leq N^*-2$, $P_{crash}\geq P_{low}=F(N_\tau+1)>P_{target}$, so $B_{min}\geq T(N^*-1)$. Moreover $S_{high}$ meets the target, so $B_{min}\leq T(N^*+1)$. This gives $S_{low}\leq S_{smart}\leq S_{high}$. The bound on $S'$ follows directly from the budgets. $$\endproof$$


# 5) Ci riprovo ancora
## 5.1) Intro
This work aims to design a model that can predict the crash probability of a bot under unstable network conditions.

The setup is very simple: The bot moves towards an object while sending data to a controller. This controller analyzes the lidar data and when needed sends a stop signal to the bot, which will then brake.

## 5.2) Model and Assumptions
We define TX as bot$\rightarrow$controller and RX as controller$\rightarrow$bot. The two directions of the communication link can behave differently, so each one has its own packet loss and latency:
- E2E Packet loss: $p_{e2e}=1-(1-p_{tx})(1-p_{rx})$, with $0\leq p_{tx},p_{rx}<1$, not both zero.
- E2E Latency: $\tau_{e2e}=\tau_{tx}+\tau_{rx}$

$p_{tx}$ is the loss probability of a whole scan, and $p_{rx}$ the loss probability of a control message. $\tau_{tx}$ and $\tau_{rx}$ include every fixed delay on their side (scan age, processing, actuation), not only the network latency.

Instead of computing $S$, it is first fixed in order to study the crash probability.

Now we define some standard parameters:
- $S$: braking threshold.
- $L$: offset between the measured distance and the front of the robot.
- $m$: required safety margin (can be set to 0).
- $v_\max$: speed of robot while traveling.
- $d_{brake}$: braking distance.
- $T$: sampling period of the LiDAR, equal to the period of the relay timer on the bot.
- $\psi$: measured wait from the arrival of the STOP to the relay tick that applies it (see Section 4.3).

_(distances are in meters, $v_{max}$ is in $m/s$, and times are in $ms$.)_

Some other parameters can be calculated immediately:
- $d_\max=m+L+d_{brake}$: last measured distance at which braking can start safely.
- $\Delta d=S-d_\max$: distance the bot can travel before braking must start.
- $\Delta t=1000\cdot\frac{\Delta d}{v_\max}$: time available for the LiDAR data and the STOP to complete their round trip.

The LiDAR samples on the bot every $T$. The controller answers each scan with a control message: GO while the measured distance is above $S$, and STOP once the threshold crossing has been detected. On the bot, a relay timer with the same period $T$ applies the last received command. The LiDAR and relay windows are not aligned, but their phase difference is constant while the nodes run.

A synchronized clock is needed for latency calculations.

- Packet losses are independent.
- Lost LiDAR data is replaced by the next scan, and a lost STOP by the next control message, one period later.
- $\tau_{tx}$ and $\tau_{rx}$ are constant, and their jitter is small compared to $T$.
- The start position of each run is shifted by an independent offset $\mathcal U\left(0,\frac{v_\max T}{1000}\right)$.
- The bot reaches $v_\max$ before crossing $S$, travels at $v_\max$ until the STOP is applied at a relay tick, and then brakes immediately.

## 5.3) Communication Delay (CD)

Let $X\sim\text{Geom.}(1-p_{tx})$ and $Y\sim\text{Geom.}(1-p_{rx})$ be the numbers of failed attempts on the sensor and brake links, starting from 0, and let $A=X+Y$.

Let $\phi \sim \mathcal{U}(0, T)$ be the wait from the threshold crossing to the next LiDAR sample. The random start offset shifts the crossing uniformly over one sampling period, so $\phi$ is uniform, changes with each stop, and is independent of the network.

Let $\psi\in[0,T)$ be the wait from the LiDAR data arriving at the controller until the next control message is sent. It is set by the phase difference between the LiDAR and the control period, shifted by the downlink latency, so it is nearly constant while the nodes run. It is measured on the controller, and a high quantile of the recent measurements is used as a known constant. A lost LiDAR scan is replaced one period later, and the relay ticks with the same period, so retransmissions do not change $\psi$.


The communication delay on each link is: $$t_{tx}=\tau_{tx}+XT\qquad \mathbb E[t_{tx}]=\tau_{tx}+\frac{p_{tx}T}{1-p_{tx}}$$ $$t_{rx}=\tau_{rx}+YT\qquad \mathbb E[t_{rx}]=\tau_{rx}+\frac{p_{rx}T}{1-p_{rx}}$$ The end to end communication delay is: $$t_{e2e}=t_{tx}+t_{rx}=\tau_{e2e}+AT\qquad \mathbb E[t_{e2e}]=\tau_{e2e}+T\left(\frac{p_{tx}}{1-p_{tx}}+\frac{p_{rx}}{1-p_{rx}}\right)$$ However, one significant transmission is the crossing of the threshold, which has an added random time $\phi$ in bot$\rightarrow$controller transmission and the constant $\psi$ in controller$\rightarrow$bot transmission: $$\begin{gather} t_{tx,thresh}=\tau_{tx}+XT+\phi\qquad \mathbb E[t_{tx,thresh}]=\tau_{tx}+T\frac{1+p_{tx}}{2(1-p_{tx})}\\ t_{rx,thresh}=\tau_{rx}+YT+\psi\qquad \mathbb E[t_{rx,thresh}]=\tau_{rx}+\frac{p_{rx}T}{1-p_{rx}}+\psi\\ t_{e2e,thresh}=t_{e2e}+\phi+\psi\qquad \mathbb E[t_{e2e,thresh}]=\mathbb E[t_{e2e}]+\frac T2+\psi=\tau_{e2e}+\psi+T\frac{1+p_{tx}+p_{rx}-3p_{tx}p_{rx}}{2(1-p_{e2e})} \end{gather}$$ The expectations are taken over $X$, $Y$ and $\phi$, for the measured value of $\psi$. One quick feasibility check can be done on $$\mathbb E[t_{e2e,thresh}]\leq \Delta t$$

##### Proof

We first compute the expected number of failures on a link. Since $X$ counts the failed attempts before the first success, $P(X=n)=p_{tx}^n(1-p_{tx})$ for $n\in\{0,1,2,\dots\}$. Using $\sum_{n=0}^\infty np^n=\frac{p}{(1-p)^2}$, for $|p|<1$: $$\E[X]=\sum_{n=0}^\infty n\,p_{tx}^n(1-p_{tx})=(1-p_{tx})\frac{p_{tx}}{(1-p_{tx})^2}=\frac{p_{tx}}{1-p_{tx}}$$ In the same way, $\E[Y]=\frac{p_{rx}}{1-p_{rx}}$.

Since the latencies and $T$ are constants, linearity of expectation gives the delay on each link: $$\E[t_{tx}]=\tau_{tx}+T\,\E[X]=\tau_{tx}+\frac{p_{tx}T}{1-p_{tx}}\qquad\E[t_{rx}]=\tau_{rx}+T\,\E[Y]=\tau_{rx}+\frac{p_{rx}T}{1-p_{rx}}$$ Adding the two links, with $\tau_{e2e}=\tau_{tx}+\tau_{rx}$: $$\E[t_{e2e}]=\E[t_{tx}]+\E[t_{rx}]=\tau_{e2e}+T\left(\frac{p_{tx}}{1-p_{tx}}+\frac{p_{rx}}{1-p_{rx}}\right)$$

Next, for $\phi\sim\mathcal U(0,T)$: $$\E[\phi]=\int_0^T\frac{\phi}{T}\,d\phi=\frac1T\left[\frac{\phi^2}2\right]_0^T=\frac T2$$ $\psi$ is a constant, so $\E[\psi]=\psi$.

For the threshold transmission on each link, we add the corresponding wait: $$\E[t_{tx,thresh}]=\tau_{tx}+\frac{p_{tx}T}{1-p_{tx}}+\frac T2=\tau_{tx}+T\,\frac{2p_{tx}+(1-p_{tx})}{2(1-p_{tx})}=\tau_{tx}+T\frac{1+p_{tx}}{2(1-p_{tx})}$$ $$\E[t_{rx,thresh}]=\tau_{rx}+\frac{p_{rx}T}{1-p_{rx}}+\psi$$ Finally, adding the two and using $1-p_{e2e}=(1-p_{tx})(1-p_{rx})$: $$\begin{align} \E[t_{e2e,thresh}]&=\E[t_{tx,thresh}]+\E[t_{rx,thresh}]=\E[t_{e2e}]+\frac T2+\psi\\ &=\tau_{e2e}+\psi+\frac T2\left(\frac{1+p_{tx}}{1-p_{tx}}+\frac{2p_{rx}}{1-p_{rx}}\right)\\ &=\tau_{e2e}+\psi+\frac T2\cdot\frac{(1+p_{tx})(1-p_{rx})+2p_{rx}(1-p_{tx})}{(1-p_{tx})(1-p_{rx})}\\ &=\tau_{e2e}+\psi+T\,\frac{1+p_{tx}+p_{rx}-3p_{tx}p_{rx}}{2(1-p_{e2e})} \end{align}$$ Only linearity of expectation is used, so this result does not require $X$, $Y$ and $\phi$ to be independent. For the feasibility check, the mean delay fits the time budget exactly when $\E[t_{e2e,thresh}]\leq\Delta t$. This compares only the mean with the budget, so it is not a safety guarantee.

With $p_{tx}=p_{rx}=p$ we get the symmetric case, since $\frac{1+2p-3p^2}{2(1-p)^2}=\frac{1+3p}{2(1-p)}$. If $\psi$ is not measured and is replaced by its mean $T/2$, we get back $\tau_{e2e}+T\frac{1-p_{tx}p_{rx}}{1-p_{e2e}}$, the result for two uniform waits. $$\endproof$$

## 5.4) Minimum Distance (MD)

The delay of the threshold transmission determines how far the bot travels before it starts braking, so it also determines how close the bot gets to the obstacle. This section quantifies that closest distance, in order to show the average safety of a given threshold $S$.

The bot moves at constant speed until the STOP is applied. When the threshold is crossed, the measured distance is $S$, which means that the front of the bot is at a distance $S-L$ from the obstacle. From this point, the bot:

- travels at $v_\max$ for the time $t_{e2e,thresh}$ needed by the LiDAR data to reach the controller, by the STOP to reach the bot, and by the relay to apply it.
- covers the braking distance $d_{brake}$ once the STOP is applied.

The distance that remains between the bot and the obstacle after it has stopped is the minimum distance $d_\min$. This is a signed quantity, where a negative value means that the bot would overlap with the obstacle: $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000}\,t_{e2e,thresh}\qquad\mathbb E[d_\min]=S-L-d_{brake}-\frac{\mathbb E[t_{e2e,thresh}]\,v_\max}{1000}$$

Note that the margin $m$ does not appear, since it is a requirement on $d_\min$ and not part of the motion of the bot. A value of $\mathbb E[d_\min]\geq m$ only means that the safety margin is respected on average, so it does not exclude that some stops will breach it.

##### Proof

When the threshold is crossed, the measured distance is $S$, so the front of the bot is at distance $S-L$ from the obstacle. The bot then travels at $v_\max$ until the STOP is applied, which takes $t_{e2e,thresh}$, and finally covers $d_{brake}$ while braking. Therefore: $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000}\,t_{e2e,thresh}$$ Since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, linearity of expectation gives: $$\E[d_\min]=S-L-d_{brake}-\frac{\E[t_{e2e,thresh}]\,v_\max}{1000}$$ where $\E[t_{e2e,thresh}]$ is given in Section 4.3. $$\endproof$$

## 5.5) Variances of CD and MD

The expected values describe only the average stop. Two stops can behave very differently, because the number of retransmissions and the wait $\phi$ change the delay each time. This section measures that spread, which shows how far a single stop can fall from the expected minimum distance.

We assume that $X$, $Y$ and $\phi$ are independent. $\psi$ is a constant, so it only shifts the delay. The threshold transmission on each link then has variance: $$\text{Var}(t_{tx,thresh})=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac1{12}\right)\qquad\text{Var}(t_{rx,thresh})=T^2\frac{p_{rx}}{(1-p_{rx})^2}$$ The two links have independent delays, so their variances add. The end to end variance is: $$\text{Var}(t_{e2e,thresh})=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac1{12}\right)$$ Since $d_\min$ depends on the delay through the factor $\frac{v_\max}{1000}$, the minimum distance has variance: $$\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac1{12}\right)$$ The latencies and $\psi$ do not appear, since they are constants and only shift the delay. Without losses the standard deviation of the delay is $T/\sqrt{12}$, about $29\,ms$ for $T=100\,ms$.

##### Proof

Since $X$ counts the failures before the first success, with $P(X=n)=p_{tx}^n(1-p_{tx})$, its variance is: $$\text{Var}(X)=\frac{p_{tx}}{(1-p_{tx})^2}$$ In the same way, $\text{Var}(Y)=\frac{p_{rx}}{(1-p_{rx})^2}$. For a uniform distribution $\mathcal U(a,b)$ the variance is $\frac{(b-a)^2}{12}$, therefore: $$\text{Var}(\phi)=\frac{T^2}{12}\qquad\text{Var}(\psi)=0$$ Since $\tau_{tx}$ is a constant and $T$ is a scaling factor, and using the independence of $X$ and $\phi$: $$\text{Var}(t_{tx,thresh})=\text{Var}(\tau_{tx}+XT+\phi)=T^2\,\text{Var}(X)+\text{Var}(\phi)=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac1{12}\right)$$ Since $\tau_{rx}$ and $\psi$ are constants: $$\text{Var}(t_{rx,thresh})=\text{Var}(\tau_{rx}+YT+\psi)=T^2\,\text{Var}(Y)=T^2\frac{p_{rx}}{(1-p_{rx})^2}$$

Since $t_{e2e,thresh}=t_{tx,thresh}+t_{rx,thresh}$, and the two terms are independent: $$\text{Var}(t_{e2e,thresh})=\text{Var}(t_{tx,thresh})+\text{Var}(t_{rx,thresh})=T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac1{12}\right)$$ Finally, recall that $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000}\,t_{e2e,thresh}$$ Since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, the variance depends entirely on $t_{e2e,thresh}$: $$\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2\text{Var}(t_{e2e,thresh})=\left(\frac{v_\max}{1000}\right)^2T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac1{12}\right)$$ $$\endproof$$

## 5.6) Crash Probability (CProb)

A positive expected minimum distance does not mean that every stop is safe, because a long delay can still breach the margin. This section computes the probability of that event, which is the main result of the model. A crash occurs when the threshold transmission takes longer than the time budget: $$t_{e2e,thresh}>\Delta t$$ The constant part of the delay is $\tau_{e2e}+\psi$, so the budget left for the retransmissions and for $\phi$ is $B=\Delta t-\tau_{e2e}-\psi$. Let $N_\tau$ be the attempt budget, and $R$ the time left over after $N_\tau$ full periods: $$N_\tau=\floor{\frac{\Delta t-\tau_{e2e}-\psi}T}\qquad R=\Delta t-\tau_{e2e}-\psi-N_\tau T\qquad 0\leq R<T$$ Let $f(k)=\mathbb P(A=k)$ be the probability of exactly $k$ failures, and $F(k)=\mathbb P(A\geq k)$ the probability of at least $k$ failures. For $k\geq 0$ and $p_{tx}\not=p_{rx}$: $$f(k)=(1-p_{tx})(1-p_{rx})\frac{p_{rx}^{k+1}-p_{tx}^{k+1}}{p_{rx}-p_{tx}}\qquad F(k)=\frac{(1-p_{tx})p_{rx}^{k+1}-(1-p_{rx})p_{tx}^{k+1}}{p_{rx}-p_{tx}}$$ If $p_{tx}=p_{rx}=p$, these become as before: $$f(k)=(k+1)p^k(1-p)^2\qquad F(k)=p^k\left[1+k(1-p)\right]$$ For $k<0$, we set $f(k)=0$, since a negative number of failures is impossible, and $F(k)=1$, since $A\geq 0$ always holds. Both functions are unchanged when $p_{tx}$ and $p_{rx}$ swap, so the order of the links does not affect the crash probability.

For $\Delta t\geq\tau_{e2e}+\psi$, the exact crash probability is: $$P_{crash}=F(N_\tau+1)+f(N_\tau)\left(1-\frac RT\right)=F(N_\tau)-f(N_\tau)\frac RT$$ Covering all cases, this can be written for $p_{tx}\not=p_{rx}$ as: $$P_{crash}=\begin{cases} F(N_\tau)-\dfrac{(1-p_{tx})(1-p_{rx})}{T(p_{rx}-p_{tx})}\left(p_{rx}^{N_\tau+1}-p_{tx}^{N_\tau+1}\right)R& N_\tau\geq0\\
1 &N_\tau<0 
\end{cases}$$ If $\Delta t<\tau_{e2e}+\psi$, a crash is certain. For $p_{tx}=p_{rx}=p$ and $N_\tau\geq0$, this is $P_{crash}=F(N_\tau)-(N_\tau+1)p^{N_\tau}(1-p)^2\frac RT$.


Three simpler expressions can also be used. Ignoring the wait gives a lower bound on the crash probability: $$P_{low}(N_\tau)=F(N_\tau+1)$$ Taking the largest possible wait gives an upper bound on the crash probability: $$P_{high}(N_\tau)=F(N_\tau)$$ The exact probability is a weighted average of the two, so it satisfies: $$P_{crash}=\frac RT\,P_{low}+\left(1-\frac RT\right)P_{high}\qquad P_{low}\leq P_{crash}\leq P_{high}$$ Replacing the wait by its mean $T/2$ gives an approximation, which is neither a lower nor an upper bound: $$P'(N_\tau)=\begin{cases}F(N_\tau)&R<\frac T2\\ F(N_\tau+1)&R\geq\frac T2\end{cases}$$ $P'$ is the bound closer to $P_{crash}$, so it is off by at most $\frac{f(N_\tau)}2$.

If $\psi$ is not measured and is treated as $\mathcal U(0,T)$, averaging $P_{crash}$ over $\psi$ gives back the result for a triangular total wait $\phi+\psi$.

##### Proof

We first compute $F(k)$ for $k\geq 1$ and $p_{tx}\not=p_{rx}$. The event $A\geq k$ occurs in two mutually exclusive scenarios:

- Data Fail: the sensor packet alone reaches $k$ failures, so $X\geq k$.
- Brake Fail: $X=n$ with $n\in\{0,\dots,k-1\}$, and the brake command fails at least $k-n$ times.

For the first scenario: $$P_{\text{data fail}}=\mathbb P(X\geq k)=p_{tx}^k$$ For the second scenario, using the independence of $X$ and $Y$: $$\begin{align} P_{\text{brake fail}}&=\sum_{n=0}^{k-1}\mathbb P(X=n)\,\mathbb P(Y\geq k-n)\\ &=\sum_{n=0}^{k-1}(1-p_{tx})p_{tx}^n\cdot p_{rx}^{k-n}\\ &=(1-p_{tx})\,p_{rx}\sum_{n=0}^{k-1}p_{tx}^n\,p_{rx}^{k-1-n}\\ &=(1-p_{tx})\,p_{rx}\,\frac{p_{rx}^k-p_{tx}^k}{p_{rx}-p_{tx}} \end{align}$$ Adding the two gives: $$\begin{align} F(k)&=p_{tx}^k+(1-p_{tx})\,p_{rx}\,\frac{p_{rx}^k-p_{tx}^k}{p_{rx}-p_{tx}}\\ &=\frac{(1-p_{tx})p_{rx}^{k+1}-(1-p_{rx})p_{tx}^{k+1}}{p_{rx}-p_{tx}} \end{align}$$ This formula also gives $F(0)=1$. The difference $F(k)-F(k+1)$ then gives $f(k)$. For $p_{tx}=p_{rx}=p$, each term of the sum for $P_{\text{brake fail}}$ equals $(1-p)p^k$, which gives $F(k)=p^k\left[1+k(1-p)\right]$ and $f(k)=(k+1)p^k(1-p)^2$.

---

Since $\phi\sim\mathcal U(0,T)$, its tail is: $$\mathbb P(\phi>u)=\begin{cases}1&u<0\\ 1-\dfrac uT&0\leq u\leq T\\ 0&u\geq T\end{cases}$$ Using $t_{e2e,thresh}=\tau_{e2e}+\psi+AT+\phi$ and $\Delta t-\tau_{e2e}-\psi=N_\tau T+R$, the crash condition becomes: $$AT+\phi>N_\tau T+R$$ Conditioning on $A$, which is independent of $\phi$: $$P_{crash}=\sum_{k=0}^\infty f(k)\,\mathbb P\left(\phi>(N_\tau-k)T+R\right)$$ Each value of $k$ gives one of three cases:

- $k\geq N_\tau+1$: the bound is at most $R-T<0$, so the probability is $1$. These terms sum to $F(N_\tau+1)$.
- $k=N_\tau$: the bound is $R$, so the probability is $1-\frac RT$.
- $k\leq N_\tau-1$: the bound is at least $T+R\geq T$, so the probability is $0$.

Summing the terms gives $P_{crash}$. $$P_{crash} = \underbrace{\sum_{k=0}^{N_\tau - 1} f(k) \cdot 0}_{=\,0} \;+\; \underbrace{f(N_\tau)\left(1 - \frac{R}{T}\right)}_{k = N_\tau} \;+\; \underbrace{\sum_{k=N_\tau + 1}^\infty f(k) \cdot 1}_{=\,F(N_\tau + 1)}$$ Using $F(N_\tau+1)+f(N_\tau)=F(N_\tau)$ and substituting $f$ gives the rewritten form. For $N_\tau=0$, $F(0)=1$, so the same formula holds. For $N_\tau<0$, every bound is negative, so a crash is certain.

---

Ignoring the wait sets $\phi=0$, so a crash requires $AT>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau+1$, which gives $P_{low}$. A crash with $A\geq N_\tau+1$ occurs for any value of $\phi$, so $P_{low}\leq P_{crash}$.

Taking the largest possible wait sets $\phi=T$, so a crash requires $(A+1)T>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau$, which gives $P_{high}$. Since $\phi\leq T$, every crash satisfies this condition, so $P_{crash}\leq P_{high}$.

Writing $f(N_\tau)=F(N_\tau)-F(N_\tau+1)=P_{high}-P_{low}$ in $P_{crash}=F(N_\tau)-f(N_\tau)\frac RT$ gives the weighted average.

Replacing the wait by its mean sets $\phi=T/2$, so a crash requires $\left(A+\frac12\right)T>N_\tau T+R$. Since $A$ is an integer and $0\leq R<T$, this means $A\geq N_\tau$ when $R<\frac T2$, and $A\geq N_\tau+1$ when $R\geq\frac T2$, which gives $P'$. In the first case the weight of $P_{high}$ is $1-\frac RT>\frac12$, and in the second the weight of $P_{low}$ is $\frac RT\geq\frac12$, so $P'$ is the closer bound and $|P'-P_{crash}|\leq\frac{f(N_\tau)}2$. As $\phi$ is random, this is not the true probability, and it can fall on either side of $P_{crash}$.

Finally, $P_{crash}$ is the probability conditioned on the measured $\psi$. If $\psi\sim\mathcal U(0,T)$ independent of $A$ and $\phi$, the law of total probability gives $\mathbb P(AT+\phi+\psi>\Delta t-\tau_{e2e})$, which is the crash probability with the triangular wait $\phi+\psi$. $$\endproof$$

## 5.7) S.M.A.R.T Algorithm

The previous section computes the crash probability for a fixed threshold $S$. The **S.M.A.R.T. (Safety Margin Automatic Readjust Tool)** algorithm solves the inverse problem: given the current network conditions and the measured $\psi$, it finds the threshold that meets a desired crash probability $P_{target}\in(0,1)$. A small threshold lets the bot travel further before braking, but it leaves less time for the STOP to arrive, so the aim is to choose $S$ as low as the target allows.

Every crash probability model depends on $S$ through the budget $B=\Delta t-\tau_{e2e}-\psi$. Inverting the definition of $\Delta t$, a budget $B$ corresponds to the threshold: $$S(B)=\frac{v_\max}{1000}\left(B+\tau_{e2e}+\psi\right)+L+m+d_{brake}$$ Let $N^*$ be the first $N\in\mathbb N^+$ that satisfies: $$F(N)=\frac{(1-p_{tx})p_{rx}^{N+1}-(1-p_{rx})p_{tx}^{N+1}}{p_{rx}-p_{tx}}\leq P_{target}$$ For $p_{tx}=p_{rx}=p$, this is $F(N)=p^N\left[1+N(1-p)\right]$. Applying each model of the previous section gives one version of the algorithm:

|Version|Model|Budget $B$|Meets $P_{target}$?|
|---|---|---|---|
|$S_{low}$|$P_{low}$|$T(N^*-1)$|No, it ignores the wait|
|$S'$|$P'$|$T\left(N^*-\frac12\right)$|Not guaranteed|
|$S_{high}$|$P_{high}$|$TN^*$|Yes, for any wait|
|$S_{smart}$|$P_{crash}$|$B_{min}$|Yes, and it is the lowest such threshold|

Explicitly: $$S_{low}=\frac{v_\max}{1000}\left(T(N^*-1)+\tau_{e2e}+\psi\right)+L+m+d_{brake}$$ $$S'=\frac{v_\max}{1000}\left(T\left(N^*-\tfrac12\right)+\tau_{e2e}+\psi\right)+L+m+d_{brake}$$ $$S_{high}=\frac{v_\max}{1000}\left(TN^*+\tau_{e2e}+\psi\right)+L+m+d_{brake}$$ $$S_{smart}=\frac{v_\max}{1000}\left(B_{min}+\tau_{e2e}+\psi\right)+L+m+d_{brake}$$ The crash probability at the budget $B=nT$ is $F(n)$, and between two such budgets it is linear in $B$. Therefore, with $n=N^*-1$: $$B_{min}=nT+T\,\frac{F(n)-P_{target}}{f(n)}$$ The thresholds always satisfy: $$S_{low}\leq S_{smart}\leq S_{high}\qquad S_{low}\leq S'\leq S_{high}$$ $S'$ can fall on either side of $S_{smart}$.

Since the STOP is applied on the relay grid, a change of the latency before the relay tick is absorbed by $\psi$ until it wraps around a full period. For this reason $\psi$ must be measured live and not derived from $\tau_{e2e}$, and $S$ must be recomputed whenever $\psi$ changes, for example after a restart of the LiDAR or relay node.

##### Proof

Existence of $N^*$: since $F(N)-F(N+1)=f(N)>0$, $F$ is strictly decreasing. Moreover $F(0)=1$ and $\lim_{N\to\infty}F(N)=0$, so a first $N^*\in\mathbb N^+$ with $F(N^*)\leq P_{target}$ exists.

---

Discrete versions: we look for the smallest budget that meets the target. Since $F$ is decreasing, $F(k)\leq P_{target}$ exactly when $k\geq N^*$. Therefore:

- $P_{low}=F(N_\tau+1)\leq P_{target}$ requires $N_\tau\geq N^*-1$.
- $P_{high}=F(N_\tau)\leq P_{target}$ requires $N_\tau\geq N^*$.
- $P'\leq P_{target}$ requires $N_\tau\geq N^*$ when $R<\frac T2$, and $N_\tau\geq N^*-1$ when $R\geq\frac T2$. The smallest budget is $N_\tau=N^*-1$ with $R=\frac T2$.

The smallest budget with $N_\tau$ attempts is $B=TN_\tau$, which gives $S_{low}$ and $S_{high}$, and adding $R=\frac T2$ gives $S'$. Since $P_{crash}\leq P_{high}$, $S_{high}$ meets the target for any wait. As $P_{low}$ and $P'$ are not upper bounds on $P_{crash}$, the other two versions do not guarantee it.

---

Exact version: for $B\in[nT,(n+1)T)$ we have $N_\tau=n$ and $R=B-nT$, so: $$P_{crash}(B)=F(n)-\frac{f(n)}T\,(B-nT)$$ This is linear in $B$ with slope $-\frac{f(n)}T<0$. As $B\to(n+1)T$ it tends to $F(n)-f(n)=F(n+1)$, which is its value at $B=(n+1)T$, so $P_{crash}$ is continuous. Therefore $P_{crash}$ is continuous and strictly decreasing in $B$. Since $P_{crash}(0)=F(0)=1$ and $P_{crash}\leq P_{high}\to 0$, the Intermediate Value Theorem gives a unique $B_{min}$ with $P_{crash}(B_{min})=P_{target}$, and $P_{crash}(B)\leq P_{target}$ exactly when $B\geq B_{min}$. So $S_{smart}=S(B_{min})$ is the lowest threshold that meets the target.

At the budgets $B=nT$, $P_{crash}=F(n)$. By the choice of $N^*$, with $n=N^*-1$, $F(n)>P_{target}\geq F(n+1)$, so $B_{min}=nT+R$ with $0<R\leq T$. The target is met when: $$F(n)-\frac{f(n)}T\,R=P_{target}\qquad\Longrightarrow\qquad R=T\,\frac{F(n)-P_{target}}{f(n)}$$ Since $F(n)-P_{target}\leq F(n)-F(n+1)=f(n)$, this root lies in $(0,T]$. Adding $nT$ gives $B_{min}$.

---

Ordering: $B_{min}\in\left(T(N^*-1),TN^*\right]$, so $S_{low}\leq S_{smart}\leq S_{high}$. The bound on $S'$ follows directly from the budgets. $$\endproof$$



![[Pasted image 20261110222318.png]]![[Pasted image 20261110223846.png]]
# 6) Section 6

## 6.1) Recap of the Model
#### Scenario
The bot drives straight towards a wall at $v_\max$ while its LiDAR sends one scan every $T$ to a remote controller. The controller takes the closest front reading of each scan and compares it with the threshold $S$. A control timer with the same period $T$ sends GO while the reading is above $S$, and STOP once the crossing has been detected. The STOP is applied as soon as it reaches the bot, which then brakes over $d_{brake}$. 
#### Timeline of a stop
From the moment the bot crosses $S$ to the moment it starts braking, five things happen in sequence:

| Step                                         | Interval             | Model                                                                   |
| -------------------------------------------- | -------------------- | ----------------------------------------------------------------------- |
| 0. Bot crosses $S$                           |                      | $t=0$                                                                   |
| 1. Wait for the next LiDAR sample to be sent | $\phi$               | $\mathcal U(0,T)$, independent of the network                           |
| 2. Scan reaches the controller               | $\tau_{tx}+XT$       | $X\sim\text{Geom}(1-p_{tx})$ lost scans, each replaced one period later |
| 3. Wait for the control tick                 | $\psi$               | constant phase, measured live                                           |
| 4. STOP reaches the bot                      | $\tau_{rx}+YT$       | $Y\sim\text{Geom}(1-p_{rx})$ lost STOPs, each replaced one period later |
| 5. Braking                                   | $d_{brake}/v_{\max}$ | constant, measured                                                      |

So the delay of the threshold transmission is: $$t_{e2e,thresh}=\tau_{e2e}+\psi+AT+\phi\qquad A=X+Y$$
and the delay to completely halt is
$$t_{stop}=t_{e2e,thresh}+t_{action}\qquad t_{action}=\frac{d_{brake}}{v_\max}$$

#### Parameters
| Symbol                | Meaning                                                                  | **Type of value** | Value in the experiments                                                                               |
| --------------------- | ------------------------------------------------------------------------ | ----------------- | ------------------------------------------------------------------------------------------------------ |
| $T$                   | LiDAR period = control period                                            | design constant   | $100\,ms$                                                                                              |
| $v_\max$              | cruise speed                                                             | scenario constant | $43.1$ to $44.6\,cm/s$ (commanded $50\,cm/s$), calibrated per session, slight changes based on voltage |
| $d_{brake}$           | braking distance                                                         | scenario constant | $10.0$ to $11.6\,cm$, calibrated per session, changes realtive to $v_\max$                             |
| $L$                   | LiDAR to front bumper                                                    | design constant   | $18.75\,cm$                                                                                            |
| $m$                   | safety margin                                                            | design constant   | $5\,cm$                                                                                                |
| $\tau_{tx},\tau_{rx}$ | one-way latencies bot$\rightarrow$controller, controller$\rightarrow$bot | measured variable | measured live, range $\mathbb R^+$                                                                     |
| $p_{tx},p_{rx}$       | loss of a whole scan, loss of a control message                          | measured variable | measured live, range $[0,1]$                                                                           |
| $\psi$                | scan arrival $\rightarrow$ control tick                                  | measured constant | measured live, $25$ to $97\,ms$ depending on the session, range $[0,T)\ ms$                            |
| $\phi$                | crossing $\rightarrow$ next LiDAR sample                                 | random variable   | $\mathcal U(0,T)$, made uniform by the random start                                                    |


#### Main results
With $\Delta t=1000\,\frac{S-L-m-d_{brake}}{v_\max}$ and the budget $B=\Delta t-\tau_{e2e}-\psi$:

- **Expected delay**: $\mathbb E[t_{e2e,thresh}]=\tau_{e2e}+\psi+T\frac{1+p_{tx}+p_{rx}-3p_{tx}p_{rx}}{2(1-p_{e2e})}$
- **Minimum distance**: $d_\min=S-L-d_{brake}-\frac{v_\max}{1000}\,t_{e2e,thresh}$, with $\mathbb E[d_\min]$ from the expected delay.
- **Spread**: $\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2T^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}+\frac1{12}\right)$. Without losses the standard deviation is $\frac{v_\max T}{1000\sqrt{12}}\approx1.3\,cm$.
- **Crash probability**: with $N_\tau=\lfloor B/T\rfloor$ and $R=B-N_\tau T$, $$P_{crash}=F(N_\tau)-f(N_\tau)\frac RT\qquad F(k)=\mathbb P(A\geq k),\ f(k)=\mathbb P(A=k)$$ and $P_{crash}=1$ for $B<0$. It lies between $P_{low}=F(N_\tau+1)$ and $P_{high}=F(N_\tau)$.
- **S.M.A.R.T.** (5.7): $P_{crash}$ is continuous and strictly decreasing in $B$, so the lowest threshold that meets $P_{target}$ is $$S_{smart}=\frac{v_\max}{1000}\left(B_\min+\tau_{e2e}+\psi\right)+L+m+d_{brake}\qquad B_\min=nT+T\,\frac{F(n)-P_{target}}{f(n)},\ n=N^*-1$$

#### Threshold policies tested
Two policies were tested:

- **FIXED**: a constant $S=42.6\,cm$. With the calibrated $v_\max$ and $d_{brake}$ this gives $\Delta t\approx165$ to $180\,ms$, so its crash probability depends entirely on the network.
- **SMART**: $S=S_{smart}$ , recomputed at every scan from the live estimates of $\tau_{tx},\tau_{rx},p_{tx},p_{rx},\psi$, with $P_{target}\in\{0.05,\,0.15,\,0.30\}$. (In the code this is the mode `SUPERSMART`.)

_Note:_ an earlier version of the algorithm used $S=\frac{v_\max}{1000}\left(T(N^*+1)+\tau_{e2e}\right)+L+m+d_{brake}$, which is $S_{high}$ with $\psi$ replaced by its worst case $T$. It also meets the target, but it is not the best bound for this model: it ignores the measured $\psi$ and keeps the whole last period, so it places $S$ higher than needed. It was not used in the tests.

## 6.2) Experimental Setup
### 6.2.1) Hardware and Network
- **Robot**: Husarion ROSbot with an RPLIDAR (`sllidar_ros2` driver, one rotation every $\approx100\,ms$), ROS 2 Jazzy.
- **Controller**: a separate PC running the controller node.
- **Bridge**: the ROS 2 topics cross between the two machines through `zenoh-bridge-ros2dds` (the bot listens on port 7447, the controller connects to it), so DDS discovery stays local to each machine. UDP is used.
- **Ideal link**: robot and controller on the same local network ($192.168.77.0/24$). The latency is below $1\,ms$ and there is no loss.
- **Starlink link**: the robot is connected by Ethernet to a MikroTik RouterBOARD, whose uplink is a Starlink terminal. The MikroTik serves DHCP for the robot's network, because DHCP on the ROSbot interfered with the DDS communication of the motor nodes. The controller reaches the robot through a Tailscale VPN, so every message between the two crosses the Starlink link.
- **Clocks**: synchronized with chrony, with the bot as the controller's time source. One-way latencies depend on the clock offset, but $\tau_{e2e}=\tau_{tx}+\tau_{rx}$ does not, since the offset enters the two directions with opposite signs. $\psi$, $v_\max$ and $d_{brake}$ are each measured on a single clock.

### 6.2.2) Software
Two nodes from the package `monitor_pkg` run on the two machines:

- **`bot_monitor`** (robot): network heartbeats, the `BrakeMonitor` that measures $d_{brake}$ of every stop, and two iperf3 servers for the link load.
- **`controller_monitor`** (controller): computes $S$, decides GO/STOP, measures $\psi$, logs everything, and runs the automated test.

| Topic | From $\rightarrow$ to | Content | QoS |
|---|---|---|---|
| `/scan` | bot $\rightarrow$ controller | one LiDAR scan every $T$ | best effort |
| `/cmd_vel` | controller $\rightarrow$ bot | GO ($0.5\,m/s$) or STOP ($0$), every $T$ | see below |
| `network_downlink` | bot $\rightarrow$ controller | heartbeat every $0.1\,s$, carries the loss and latency the bot measured | best effort |
| `network_uplink` | controller $\rightarrow$ bot | heartbeat every $0.1\,s$ | best effort |
| `/brake_distance` | bot $\rightarrow$ controller | measured $d_{brake}$, once per stop | reliable |

The model assumes that a lost scan or command is replaced by the next one, one period later, which is the best-effort behaviour. With reliable QoS, DDS would retransmit by itself and turn loss into extra latency. %% /cmd_vel: the publisher is reliable, the bot's subscribers are best effort, check which one the connection uses %%

### 6.2.3) Measuring the Model Inputs
Every input of the model is estimated online by the controller, and the threshold is recomputed at every scan. The code names the two directions from the controller's side (uplink = controller$\rightarrow$bot, downlink = bot$\rightarrow$controller), which swaps `tx` and `rx` with respect to the paper.

| Paper | How it is measured | CSV column |
|---|---|---|
| $\tau_{rx}$ (controller$\rightarrow$bot) | one-way delay of the uplink heartbeats, median of the last 100 ($10\,s$), measured on the bot and sent back | `tau_tx_ms` |
| $\tau_{tx}$ (bot$\rightarrow$controller) | on the scans themselves: arrival $-$ stamp $-$ scan duration, median of the last 100 scans (`USEPING=False`). In the Ideal sessions the downlink heartbeat was used instead (`USEPING=True`), which is equivalent on a local network | `tau_rx_scan_ms` (`tau_rx_ms`) |
| $p_{rx}$ | missing sequence numbers of the uplink heartbeats over 100 heartbeats, measured on the bot | `p_tx` |
| $p_{tx}$ | missing whole scans, from gaps in the LiDAR stamps longer than one period, over the last 100 scans | `p_scan` |
| $\psi$ | for every scan, the time from its arrival to the next control tick (monotonic clock). The model uses the 90th percentile of the last 50 samples ($T$ until 10 samples exist), so a wait that jitters around a tick counts as late | `psi_ms` |
| $v_\max$ | least-squares slope of the front distance over the cruise part of the approach | `VMAX_cm_s` |
| $d_{brake}$ | measured by the bot: distance at the moment the first STOP arrives (line fitted to the readings of the last $0.35\,s$) minus the distance at standstill | `D_BRAKE_cm` |
| reading vs $S$ | closest valid ray among the 10 at each end of the scan array (straight ahead) | `min_distance_cm` |

The scans are measured directly, instead of relying only on the heartbeats, because on Starlink they behave differently. A scan is a large message (the LiDAR stream needs about $2.1\,Mbit/s$), so it takes longer to cross the link ($\tau_{tx}\approx33$ to $44\,ms$ from the scans, against $16$ to $25\,ms$ from the heartbeats). A scan is also lost if any of its packets is lost: with netem, $\approx10\%$ of the scans were lost, against $\approx2\%$ of the heartbeats in the same direction. The model needs the delay and loss of the scans, not of a small probe.

The LiDAR driver stores the rays newest first, so ray $k$ of a scan with $n$ rays was measured at `stamp + (n-1-k) * time_increment`, not `stamp + k * time_increment`. The `BrakeMonitor` uses this timing, otherwise $d_{brake}$ comes out about $v_\max\cdot\text{scan time}\approx4.3\,cm$ too small.

### 6.2.4) Test Procedure
Each test session runs the same braking manoeuvre many times (`controller_monitor <MODE> RUNS=20`). Every run has five phases:

1. **Align**: turn in place until the bot faces the wall ($|\text{yaw}|\leq0.5°$ for $0.6\,s$).
2. **Wait**: stand still for $2\,s$ (with link load: $10\,s$, so that the $10\,s$ estimation windows see the loaded link).
3. **Approach**: drive at $0.5\,m/s$ with the normal GO/STOP logic, until the first STOP caused by a reading below $S$.
4. **Stopping**: send STOP for $2\,s$, then wait for the bot's measured $d_{brake}$.
5. **Return**: reverse to the start position of the next run.

- **Calibration run 0.** Every session starts with a run that always uses the FIXED threshold. Its measured cruise speed and braking distance become $v_\max$ and $d_{brake}$ for the 20 measured runs, and are kept fixed. Run 0 is excluded from the analysis.
- **Random start.** Each run starts at a random offset $\mathcal U\left(0,\frac{v_\max T}{1000}\right)\approx\mathcal U(0,4.4\,cm)$ behind a fixed start point. This is one LiDAR period of travel, so the threshold is crossed at a uniform phase of the LiDAR period and $\phi\sim\mathcal U(0,T)$, as the model assumes.
- **Safety stops.** A session ends early on a collision (a reading $\leq L$), a failed calibration, an alignment or return timeout, or an obstacle behind the bot. All 19 sessions below completed their 20 runs. A stale scan ($>0.5\,s$ old) also triggers a STOP, as an equipment protection that is not part of the model; a run where it fires has to be discarded.
- **Link load.** iperf3 UDP streams at a fixed rate in each direction. Both clients run on the controller (one in reverse mode), so the load is switched on and off without sending a command over the loaded link. The load is on during the measured runs only, never in run 0.

## 6.3) Test Conditions and Evaluation
### 6.3.1) Network Conditions
Five network conditions were tested:

| Condition | Description |
|---|---|
| Ideal | local network, no Starlink |
| Starlink | Starlink link, no added load or impairment |
| Starlink + iperf | iperf3 UDP load of $40\,Mbit/s$ controller$\rightarrow$bot and $4.5\,Mbit/s$ bot$\rightarrow$controller |
| Starlink + netem | `tc netem` on both machines, setting "2/5/5/5" %% fill in the exact netem commands (loss and delay on eth0 and eno1) %% |
| Starlink mixed | iperf load and netem together |

The link as the controller measured it at the brake, averaged over the sessions of each condition:

| Condition | $\tau_{tx}$ (scans) | $\tau_{tx}$ (heartbeat) | $\tau_{rx}$ | $\tau_{e2e}$ used by the model | $p_{tx}$ (scans) | $p_{rx}$ | $\psi$ (per session) |
|---|---|---|---|---|---|---|---|
| Ideal | $1.9\,ms$ | $0.7\,ms$ | $0.6\,ms$ | $1.3\,ms$ | $0\%$ | $0\%$ | $34$ to $82\,ms$ |
| Starlink | $36.8\,ms$ | $17.8\,ms$ | $11.8\,ms$ | $48.6\,ms$ | $0.5\%$ | $0\%$ | $31$ to $45\,ms$ |
| + iperf | $32.6\,ms$ | $16.4\,ms$ | $14.2\,ms$ | $46.7\,ms$ | $3.9\%$ | $0.0\%$ | $25$ to $50\,ms$ |
| + netem | $44.3\,ms$ | $24.0\,ms$ | $22.6\,ms$ | $66.8\,ms$ | $10.1\%$ | $4.8\%$ | $28$ to $97\,ms$ |
| mixed | $41.0\,ms$ | $25.1\,ms$ | $20.3\,ms$ | $61.3\,ms$ | $13.0\%$ | $5.0\%$ | $25$ to $40\,ms$ |

$\psi$ changes from one session to the next because it is set by the phase between the LiDAR and the control timer, which is fixed at every launch of the nodes. Its range ($25$ to $97\,ms$) is comparable to the whole Starlink latency, which is why it is measured and not assumed.

### 6.3.2) Test Matrix
Every condition was tested with FIXED and with SMART at the three targets, except the mixed condition at $P_{target}=0.30$. That gives 19 sessions of 20 measured runs, so 380 brakes in total. In the loaded FIXED sessions (iperf, netem, mixed) the margin was $m=10\,cm$ with $S=47.6\,cm$. Only $S-m$ enters both the budget and the crash test, so these sessions are equivalent to $S=42.6\,cm$ with $m=5\,cm$.

| Condition | FIXED | SMART 0.05 | SMART 0.15 | SMART 0.30 |
|---|---|---|---|---|
| Ideal | `auto_FIXED_20261112_112831` | `auto_SUPERSMART_20261112_110825` | `auto_SUPERSMART_20261112_112213` | `auto_SUPERSMART_20261112_113426` |
| Starlink | `auto_FIXED_20261112_113311` | `auto_SUPERSMART_20261112_112645` | `auto_SUPERSMART_20261112_140018` | `auto_SUPERSMART_20261112_133556` |
| + iperf | `auto_FIXED_20261112_144218` | `auto_SUPERSMART_20261112_145543` | `auto_SUPERSMART_20261112_150512` | `auto_SUPERSMART_20261112_151537` |
| + netem | `auto_FIXED_20261113_155837` | `auto_SUPERSMART_20261113_161303` | `auto_SUPERSMART_20261113_160558` | `auto_SUPERSMART_20261113_164059` |
| mixed | `auto_FIXED_20261113_165906` | `auto_SUPERSMART_20261113_173058` | `auto_SUPERSMART_20261113_173947` | — |

_(The target of each SMART session is the one the controller logged at the brake.)_

### 6.3.3) Evaluation
- **Crash.** A run is a crash (a margin breach) when the closest LiDAR reading after the detection, minus $L$, is below $m$. This is the event $d_\min<m$ of the model. No run touched the wall: the closest reading never went below $L$.
- **Minimum distance check.** For every brake, $\mathbb E[d_\min]$ and its standard deviation are computed from Sections 5.4 and 5.5, using the measured inputs of that run and the measured wait $\psi$ of the STOP itself. The errors (measured $-$ expected) of a session are tested for zero bias (z-test) and for the predicted spread ($\chi^2$ test), each at $\alpha/2=0.025$.
- **A priori probability.** The $P_{crash}$ the controller computed at the brake, with the inputs it had then. For SMART this is $P_{target}$.
- **A posteriori probability.** $P_{crash}$ for the same $S$, recomputed with the values measured in that run ($v_\max$, $d_{brake}$, the STOP's own $\psi$) and the $\tau$ and $p$ logged at the brake.
- **Crash rate.** The observed fraction of crashes, with its 95% Clopper-Pearson interval. It is compared with the a posteriori probabilities by an exact two-sided test (Poisson-binomial: each brake crashes with its own probability).

## 6.4) Results
#### Per condition and policy
| Condition | Policy | mean $S$ (cm) | $P$ a priori | $P$ a posteriori | Crashes | 95% CI | $d_\min$ error (cm) |
|---|---|---|---|---|---|---|---|
| Ideal | FIXED | 42.60 | 0.000 | 0.000 | 0/20 | 0.00 to 0.17 | $+0.08\pm1.37$ |
| Ideal | SMART 0.05 | 42.66 | 0.050 | 0.032 | 0/20 | 0.00 to 0.17 | $+0.16\pm1.42$ |
| Ideal | SMART 0.15 | 41.95 | 0.150 | 0.188 | 2/20 | 0.01 to 0.32 | $+0.16\pm1.06$ |
| Ideal | SMART 0.30 | 39.76 | 0.300 | 0.216 | 6/20 | 0.12 to 0.54 | $-0.27\pm1.49$ |
| Starlink | FIXED | 42.60 | 0.201 | 0.116 | 3/20 | 0.03 to 0.38 | $+0.25\pm1.29$ |
| Starlink | SMART 0.05 | 42.56 | 0.050 | 0.124 | 2/20 | 0.01 to 0.32 | $+0.11\pm1.40$ |
| Starlink | SMART 0.15 | 42.50 | 0.150 | 0.115 | 4/20 | 0.06 to 0.44 | $-0.14\pm1.68$ |
| Starlink | SMART 0.30 | 41.74 | 0.300 | 0.282 | 5/20 | 0.09 to 0.49 | $+0.09\pm0.93$ |
| + iperf | FIXED | 47.60 (m = 10) | 0.276 | 0.197 | 4/20 | 0.06 to 0.44 | $+0.32\pm1.61$ |
| + iperf | SMART 0.05 | 42.53 | 0.050 | 0.045 | 1/20 | 0.00 to 0.25 | $+0.09\pm1.35$ |
| + iperf | SMART 0.15 | 42.93 | 0.150 | 0.059 | 1/20 | 0.00 to 0.25 | $-0.19\pm1.53$ |
| + iperf | SMART 0.30 | 41.66 | 0.300 | 0.225 | 4/20 | 0.06 to 0.44 | $+0.13\pm1.26$ |
| + netem | FIXED | 47.60 (m = 10) | 0.316 | 0.249 | 7/20 | 0.15 to 0.59 | $-0.34\pm2.15$ |
| + netem | SMART 0.05 | 46.94 | 0.050 | 0.045 | 0/20 | 0.00 to 0.17 | $-0.50\pm2.21$ |
| + netem | SMART 0.15 | 47.02 | 0.150 | 0.116 | 3/20 | 0.03 to 0.38 | $0.00\pm2.21$ |
| + netem | SMART 0.30 | 45.46 | 0.300 | 0.295 | 6/20 | 0.12 to 0.54 | $+0.04\pm2.28$ |
| mixed | FIXED | 47.60 (m = 10) | 0.420 | 0.340 | 6/20 | 0.12 to 0.54 | $-0.04\pm2.84$ |
| mixed | SMART 0.05 | 45.67 | 0.050 | 0.071 | 0/20 | 0.00 to 0.17 | $+0.03\pm2.26$ |
| mixed | SMART 0.15 | 43.44 | 0.150 | 0.134 | 2/20 | 0.01 to 0.32 | $+0.40\pm2.27$ |

_($d_\min$ error: mean $\pm$ standard deviation of measured $-$ expected over the 20 brakes.)_

#### Pooled over the conditions
| Policy | Crashes | Rate (95% CI) | Expected, a priori | Expected, a posteriori |
|---|---|---|---|---|
| FIXED | 20/100 | 0.20 (0.13 to 0.29) | 24.3 | 18.0 |
| SMART 0.05 | 3/100 | 0.03 (0.01 to 0.09) | 5.0 | 6.3 |
| SMART 0.15 | 12/100 | 0.12 (0.06 to 0.20) | 15.0 | 12.3 |
| SMART 0.30 | 21/80 | 0.26 (0.17 to 0.37) | 24.0 | 20.4 |
| All | 56/380 | 0.15 | 68.3 | 57.0 |

#### Findings
1. **The minimum distance is predicted correctly.** In every session the mean error of $d_\min$ is within $\pm0.5\,cm$, and its spread ($0.9$ to $2.8\,cm$) matches the spread predicted by Section 5.5, which grows with the losses. The bias and spread checks pass in all 19 sessions (smallest p-value $0.066$).
2. **The crash counts match the model.** In all 19 cells, the number of crashes is consistent with the a posteriori probabilities (smallest p-value $0.37$). Over all 380 brakes, 56 crashes were observed against 57.0 expected.
3. **A fixed threshold is safe only on a good link.** The same $S$ gives a crash probability of $0$ on the local network, $0.20$ on Starlink, and up to $0.42$ with load and impairments. The observed crashes go from 0/20 to 6 and 7/20.
4. **S.M.A.R.T. holds the target across conditions.** It moves the threshold with the network: at $P_{target}=0.05$, $S$ ranges from $42.5\,cm$ (Starlink, iperf) to $46.9\,cm$ (netem). Pooled over the conditions, the observed rate is at or below the target for every target, and the target lies inside the 95% interval in each case.
5. **$\psi$ matters as much as the network.** The Ideal and Starlink sessions at $P_{target}=0.05$ ended with almost the same threshold ($42.66$ and $42.56\,cm$), although $\tau_{e2e}$ was about $50\,ms$ higher on Starlink. The reason is $\psi$: $82\,ms$ in that Ideal session, against $31\,ms$ in the Starlink one. A threshold that ignored $\psi$, or derived it from $\tau_{e2e}$, would be wrong by a comparable amount.
6. **A priori and a posteriori differ in some cells**, for example Starlink at $P_{target}=0.05$ ($0.124$ a posteriori) or iperf at $0.15$ ($0.059$). This happens when the values at the brake ($\psi$ of the STOP, $d_{brake}$, $v_\max$ of that run) differ from the ones the controller planned with. The observed crashes follow the a posteriori values. The 90th percentile used for $\psi$ makes the a priori estimate conservative on average (68.3 expected against 56 observed).

Figures 1 to 5 and the table above are produced by `paper_figures.m` (MATLAB folder, `paper_figs/`).

## 6.5) Summary
- The model of Section 5 describes the delay of a stop as a fixed part ($\tau_{e2e}+\psi$), a random wait $\phi\sim\mathcal U(0,T)$ and a geometric number of lost scans and STOPs, each costing one period $T$. From this it gives the minimum distance, its spread, the exact crash probability for a threshold $S$, and the lowest $S$ that meets a target probability (S.M.A.R.T.).
- The experiments use a real robot whose scans and commands cross a Starlink link, with all model inputs measured online. 380 brakes were run in 19 sessions, over 5 network conditions, with a fixed threshold and with S.M.A.R.T. at 3 targets.
- The predicted minimum distance, its spread and the crash counts agree with the measurements in all sessions. A fixed threshold goes from safe to a $\approx40\%$ crash probability as the link degrades, while S.M.A.R.T. keeps the observed crash rate at the chosen target.
- Limits of the tests: 20 runs per cell give wide confidence intervals, so the agreement is shown mainly by the pooled results. The losses introduced by netem are independent, as the model assumes, so bursty loss was not tested. The latencies were steady during each run, which matches the assumption of constant $\tau$ but leaves fast latency changes untested.
