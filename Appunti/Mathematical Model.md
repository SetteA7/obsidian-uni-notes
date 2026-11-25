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

![[smart_fig_5_6_pcrash_montecarlo.png]]
_Exact $P_{crash}$ (solid), $P_{low}$ and $P_{high}$ (dotted) and $B_{min}$ (diamonds) for two loss settings, against $400\,000$ simulated stops per setting (dots). The largest gap between formula and simulation is $0.0014$, the size of the simulation's own noise (Section 6.8)._

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

| Topic              | From $\rightarrow$ to        | Content                                                                                   | QoS         |
| ------------------ | ---------------------------- | ----------------------------------------------------------------------------------------- | ----------- |
| `/scan`            | bot $\rightarrow$ controller | one LiDAR scan every $T$                                                                  | best effort |
| `/cmd_vel`         | controller $\rightarrow$ bot | GO ($0.5\,m/s$) or STOP ($0$), every $T$                                                  | best effort |
| `network_downlink` | bot $\rightarrow$ controller | heartbeat every $0.1\,s$, carries the loss and latency the bot measured                   | best effort |
| `network_uplink`   | controller $\rightarrow$ bot | heartbeat every $0.1\,s$                                                                  | best effort |
| `/brake_distance`  | bot $\rightarrow$ controller | measured $d_{brake}$, once per stop, nto used during runs, only for parameter calibration | reliable    |

The model assumes that a lost scan or command is replaced by the next one, one period later, which is the best-effort behaviour. With reliable QoS, DDS would retransmit by itself and turn loss into extra latency. 

### 6.2.3) Measuring the Model Inputs
Every input of the model is estimated by the controller, and the threshold is recomputed at every scan. The code names the two directions from the controller's side (uplink = controller$\rightarrow$bot, downlink = bot$\rightarrow$controller), which swaps `tx` and `rx` with respect to the model.

| Paper                                    | How it is measured                                                                                                                                                                                                                                                                   | CSV column                     |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------ |
| $\tau_{rx}$ (controller$\rightarrow$bot) | one-way delay of the uplink heartbeats, median of the last 100 ($10\,s$), measured on the bot and sent back                                                                                                                                                                          | `tau_tx_ms`                    |
| $\tau_{tx}$ (bot$\rightarrow$controller) | Either:<br>- the link ping latency, which was used for the ideal sessions (`USEPING=True`)<br>- arrival $-$ stamp $-$ scan duration, median of the last 100 scans (`USEPING=False`).                                                                                                 | `tau_rx_scan_ms` (`tau_rx_ms`) |
| $p_{rx}$                                 | missing sequence numbers of the uplink heartbeats over 100 heartbeats, measured on the bot                                                                                                                                                                                           | `p_tx`                         |
| $p_{tx}$                                 | This is not the actual link packet loss, it is $1-(1-p)^n$ with $n$ the amount of fragments of the scan packet and $p$ the actual link packet loss.<br><br>It is calculated from missing whole scans, from gaps in the LiDAR stamps longer than one period, over the last 100 scans. | `p_scan`                       |
| $\psi$                                   | for every scan, the time from its arrival to the next control tick (monotonic clock). The model uses the 90th percentile of the last 50 samples ($T$ until 10 samples exist), so a wait that jitters around a tick counts as late                                                    | `psi_ms`                       |
| $v_\max$                                 | least-squares slope of the front distance over the cruise part of the approach                                                                                                                                                                                                       | `VMAX_cm_s`                    |
| $d_{brake}$                              | measured by the bot: distance at the moment the first STOP arrives (line fitted to the readings of the last $0.35\,s$) minus the distance at standstill                                                                                                                              | `D_BRAKE_cm`                   |
| reading vs $S$                           | closest valid ray among the 10 at each end of the scan array (straight ahead)                                                                                                                                                                                                        | `min_distance_cm`              |

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
- **Random start.** Each run starts at a random offset $\mathcal U\left(0,\frac{v_\max T}{1000}\right)\approx\mathcal U(0,4.4\,cm)$ behind a fixed start point. This is one LiDAR period of travel, so the threshold is crossed at a uniform phase of the LiDAR period and $\phi\sim\mathcal U(0,T)$, as the model assumes. Without this the spread of the data would be too narrow.
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

| Condition | FIXED                        | SMART 0.05                        | SMART 0.15                        | SMART 0.30                        |
| --------- | ---------------------------- | --------------------------------- | --------------------------------- | --------------------------------- |
| Ideal     | `auto_FIXED_20261112_112831` | `auto_SUPERSMART_20261112_110825` | `auto_SUPERSMART_20261112_112213` | `auto_SUPERSMART_20261112_113426` |
| Starlink  | `auto_FIXED_20261112_113311` | `auto_SUPERSMART_20261112_112645` | `auto_SUPERSMART_20261112_140018` | `auto_SUPERSMART_20261112_133556` |
| + iperf   | `auto_FIXED_20261112_144218` | `auto_SUPERSMART_20261112_145543` | `auto_SUPERSMART_20261112_150512` | `auto_SUPERSMART_20261112_151537` |
| + netem   | `auto_FIXED_20261113_155837` | `auto_SUPERSMART_20261113_161303` | `auto_SUPERSMART_20261113_160558` | `auto_SUPERSMART_20261113_164059` |
| mixed     | `auto_FIXED_20261113_165906` | `auto_SUPERSMART_20261113_173058` | `auto_SUPERSMART_20261113_173947` | `auto_SUPERSMART_20261113_174835` |

_(The target of each SMART session is the one the controller logged at the brake.)_

### 6.3.3) Evaluation
- **Crash.** A run is a crash (a margin breach) when the closest LiDAR reading after the detection, minus $L$, is below $m$. This is the event $d_\min<m$ of the model. This guarantees a crash test that does not damage the equipment.
- **Minimum distance check.** For every brake, $\mathbb E[d_\min]$ and its standard deviation are computed using the measured inputs of that run and the measured wait $\psi$ of the STOP itself. The errors (measured $-$ expected) of a session are tested for zero bias (z-test) and for the predicted spread ($\chi^2$ test), each at $\alpha/2=0.025$.
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

![[smart_fig_6_4_crashes.png]]
_Crashes per session: observed (circle, with its 95% interval), a priori with the 90th percentile of $\psi$ (square), a priori with all the $\psi$ samples (diamond, Section 6.9 finding 4), and a posteriori (triangle). Totals over the 380 brakes are in the legend._

## 6.5) How the Model Works
This section explains the model without the proofs. The aim is to show what each part of the model represents and why it takes the form it does.
#### From a distance to a time
To stop safely, the bot needs a known distance in front of it: $L$ to reach the bumper, the margin $m$, and the braking distance $d_{brake}$. Everything the threshold leaves above that, $S-(L+m+d_{brake})$, is distance the bot can afford to travel while the information "the wall is close" travels to the controller and the STOP travels back. At a constant speed this distance is a time, $\Delta t$.

So the model turns the safety question into a timing question: **does the STOP arrive within $\Delta t$ of the crossing?** If it arrives later, the bot stops inside the margin, and that is what the model counts as a crash.

#### Where the time goes
The time between the crossing and the STOP reaching the bot is made of four kinds of delay:

- **Network latency** ($\tau_{tx}$, $\tau_{rx}$): the time a scan needs to reach the controller and a command needs to reach the bot. It is measured and taken as constant during a stop, so it only shifts everything later.
- **The wait for the control tick** ($\psi$): the controller does not answer a scan immediately. It sends commands on its own timer, every $T$, so each scan waits for the next tick. The LiDAR and the timer have the same period, so the scans always arrive at the same point of the timer's cycle, and the wait is the same at every stop. It is not random: it is a phase, set when the nodes are launched, anywhere between $0$ and $T$. It changes from one launch to the next, which is why it is measured and not assumed.
- **The wait for the LiDAR** ($\phi$): the bot crosses $S$ somewhere between two LiDAR samples, and nobody knows about it until the next sample. Nothing links the position of the bot to the moment the LiDAR fires, so this wait is equally likely to be anything between $0$ and $T$, $T/2$ on average. It is the one wait that is truly random, and it changes at every stop.
- **Lost messages** ($A=X+Y$): if the scan that would reveal the crossing is lost, the next scan carries the same information one period later, with the bot even closer. If the STOP is lost, the next command, one tick later, is again a STOP. So **every lost message costs exactly one period $T$**. The number of losses in a row before a message gets through follows a geometric distribution: with loss probability $p$, $k$ losses in a row happen with probability $p^k(1-p)$. Losses on the two links simply add.

The first two delays are fixed, so they use up part of $\Delta t$ before anything random happens. What is left is the **budget** $B=\Delta t-\tau_{e2e}-\psi$, the time available to absorb the LiDAR wait and the lost messages.

#### From time back to distance
At cruise speed every millisecond of delay is $v_\max/1000$ centimetres travelled. So the prediction of the closest distance mirrors the prediction of the delay:

- **On average**, the bot stops short of $S-L-d_{brake}$ by the distance it travels during the average delay.
- **The spread** comes only from the random parts. Without losses, the LiDAR wait alone gives a standard deviation of $T/\sqrt{12}\approx29\,ms$, about $1.3\,cm$ at $44\,cm/s$. Each lost message adds a whole period, so losses widen the spread: in the netem and mixed sessions the measured spread was $2.2$ to $2.8\,cm$, as predicted.
- The latency and $\psi$ move the average but do not change the spread, because they are the same at every stop.

#### The crash probability
Write the budget as a number of whole periods plus a remainder: $B=N_\tau T+R$, with $R$ less than one period. Then three things can happen:

- **Fewer than $N_\tau$ losses**: there is at least one full period of budget left, more than any LiDAR wait can use. The STOP is always in time.
- **More than $N_\tau$ losses**: the losses alone use up more than the budget. The STOP is always late.
- **Exactly $N_\tau$ losses**: only the remainder $R$ is left for the LiDAR wait. The stop is late if $\phi>R$, which happens with probability $1-R/T$.

Adding these up: $$P_{crash}=\mathbb P(\text{more than }N_\tau\text{ losses})+\mathbb P(\text{exactly }N_\tau\text{ losses})\cdot\left(1-\frac RT\right)$$

Two cases make this concrete:

- **No loss.** Only the LiDAR wait is random, so a crash happens exactly when $\phi$ is longer than the budget. With $B=95\,ms$ and $T=100\,ms$ that is $5\%$ of the stops.
- **With loss.** Every extra period of budget covers one more lost message, and the probability of needing it falls quickly. With $10\%$ of scans and $5\%$ of commands lost, at least one loss happens in $14.5\%$ of the stops, at least two in $1.7\%$, and at least three in $0.18\%$.

As the budget grows, the crash probability falls along a straight line within each period, and the slope changes at every multiple of $T$. The two simpler versions of Section 5.6 bracket the exact value from both sides: ignoring the LiDAR wait gives an optimistic probability ($P_{low}$), and assuming the longest possible wait gives a pessimistic one ($P_{high}$).

#### S.M.A.R.T.: the model run backwards
A larger budget always gives a lower crash probability, and the probability changes smoothly with it. So for any target there is exactly one smallest budget that meets it, and turning that budget back into a distance gives the lowest safe threshold. The algorithm has two steps:

1. Find how many lost messages have to be covered: the smallest number of losses whose probability of being exceeded is below the target.
2. Find how much of the last period is needed so that the LiDAR wait is covered often enough to reach the target exactly.

The threshold then reads as a sum of three distances: $$S=\underbrace{L+m+d_{brake}}_{\text{to stop}}+\underbrace{\frac{v_\max}{1000}(\tau_{e2e}+\psi)}_{\text{during the fixed delays}}+\underbrace{\frac{v_\max}{1000}B_\min}_{\text{during the random part}}$$

The two kinds of network trouble move the threshold in different ways:

- **Latency** moves it smoothly: every millisecond adds $v_\max/1000\approx0.044\,cm$.
- **Loss** moves it in steps: whenever one more lost message has to be covered, almost a whole period ($\approx4.4\,cm$) is added.

For example, at a target of $5\%$:

- On a clean link the budget is $95\,ms$, enough for the LiDAR wait in $95\%$ of the stops.
- With $10\%$ and $5\%$ loss, one lost message must be covered almost entirely, so the budget grows to $174\,ms$ and the threshold rises by about $3.5\,cm$. This is the difference measured between the netem sessions ($46.9\,cm$) and the clean Starlink sessions ($42.5\,cm$).

Because the inputs are measured continuously, the threshold is recomputed at every scan and follows the network as it changes.

#### What the model assumes, and how the tests meet it
| Assumption | Why it matters | In the tests |
|---|---|---|
| A lost message is replaced one period later | each loss costs exactly $T$ | best-effort QoS on scans, commands and heartbeats |
| Losses are independent | the number of losses is geometric | true for netem's random loss; bursty loss would make long runs of losses more likely than predicted |
| Latency is constant during a stop | only the LiDAR wait and the losses are random | median latency over $10\,s$; jitter small compared with $T$ |
| $\psi$ is constant | it is a shift, not a random term | measured live, 90th percentile, so a wait that jitters around a tick counts as late |
| The crossing happens at a random point of the LiDAR period | $\phi$ is uniform | random start offset of one period of travel |
| The bot cruises at $v_\max$ and brakes as soon as the STOP arrives | distance is speed times delay, plus $d_{brake}$ | $v_\max$ and $d_{brake}$ calibrated in run 0 of each session |


## 6.6) Advanced Findings: Predictions Checked Against the Data
Section 6.4 checks the model on the quantities it was built for: the minimum distance and the crash rate. Several intermediate predictions of the model can also be checked directly in the logs. This section lists them, one by one, each with what the model predicts and what was measured. All numbers come from the 380 brakes of Section 6.3.2.

#### 1. The LiDAR wait $\phi$ is uniform over one period
**Prediction.** The random start makes the crossing fall at a random point of the LiDAR period, so $\phi\sim\mathcal U(0,T)$. Its mean should be $T/2=50\,ms$ and its standard deviation $T/\sqrt{12}=28.9\,ms$.

**Measured.** $\phi$ can be read off each brake: the first scan below $S$ reports a distance $S-v_\max\phi$, so $\phi=1000\,(S-\text{reading})/v_\max$. Over the 187 brakes with less than $2\%$ scan loss:

| | Model | Measured |
|---|---|---|
| mean of $\phi$ | $50.0\,ms$ | $49.1\,ms$ |
| standard deviation | $28.9\,ms$ | $28.9\,ms$ |
| Kolmogorov-Smirnov test against $\mathcal U(0,T)$ | | $D=0.067$, $p=0.36$ |

The random start does exactly what it was designed for, and the uniform model of $\phi$ holds.

![[smart_fig_6_6_1_phi.png]]
_Left: $\phi$ of all brakes, split by whether a scan was lost between the previous scan and the detecting one (from the LiDAR stamps). Every wait well above $T$ has a lost scan. Right: the empirical CDF of $\phi$ for the 344 brakes with no lost scan, against $\mathcal U(0,T)$._

#### 2. Lost scans show up as waits longer than one period
**Prediction.** A lost scan is replaced one period later, so the first scan below $S$ arrives $\phi+XT$ after the crossing. The measured "wait" should exceed $T$ in a fraction $p_{tx}$ of the stops, and its mean should grow to $\frac T2+T\frac{p_{tx}}{1-p_{tx}}$.

**Measured.**

| Condition | $p_{tx}$ (scans) | Mean wait, model | Mean wait, measured | Wait $>T$, model | Wait $>T$, measured |
|---|---|---|---|---|---|
| + netem | $10.1\%$ | $61.2\,ms$ | $64.3\,ms$ | $10.1\%$ | $13.8\%$ |
| mixed | $12.9\%$ | $64.8\,ms$ | $61.3\,ms$ | $12.9\%$ | $15.0\%$ |

The losses estimated online from the gaps in the scan stamps match the losses that actually delayed the brakes.

#### 3. $\psi$ is a constant of each launch, and the 90th percentile covers 90% of the stops
**Prediction.** $\psi$ is set by the phase between the LiDAR and the control timer, so it should barely change within a session but change between sessions. The controller uses the 90th percentile of the recent samples, so the wait of the actual STOP should be below the model's $\psi$ in about $90\%$ of the stops.

**Measured.**

- Within a session, the STOP's wait varies with a median standard deviation of $7\,ms$. Between sessions, the session means vary by $25\,ms$ (from $17$ to $93\,ms$).
- The STOP's wait was at or below the model's $\psi$ in $90.5\%$ of the 380 brakes.
- On average the model's $\psi$ is $8.8\,ms$ above the STOP's wait, about $0.4\,cm$ of extra threshold. This is the main reason why the a priori crash probabilities of Section 6.4 are slightly conservative (68.3 expected crashes against 56 observed).

The few sessions with a larger spread (Starlink, up to $35\,ms$) are those where the scans arrive close to a control tick: latency jitter makes the wait jump between almost $0$ and almost $T$. This is the case the high percentile was chosen for.

#### 4. On a clean link the budget is exactly $(1-P_{target})\,T$
**Prediction.** Without loss, the only random term is $\phi$, so $P_{crash}=1-B/T$. S.M.A.R.T. should therefore choose $B=(1-P_{target})\,T$: $95$, $85$ and $70\,ms$ for the three targets, leaving room for the LiDAR wait in $95\%$, $85\%$ and $70\%$ of the stops.

**Measured** (budget logged by the controller at the brake, session mean):

| Condition | $P_{target}=0.05$ | $0.15$ | $0.30$ |
|---|---|---|---|
| Model, no loss | $95.00\,ms$ | $85.00\,ms$ | $70.00\,ms$ |
| Ideal | $95.00\,ms$ | $85.00\,ms$ | $70.00\,ms$ |
| Starlink ($p_{tx}\approx0.5\%$) | $95.24\,ms$ | $85.30\,ms$ | $70.18\,ms$ |

The small extra budget on Starlink is the cost of its occasional lost scans.

#### 5. Loss raises the budget in steps of almost one period
**Prediction.** With losses, each extra period of budget covers one more lost message. With $10\%$ scan loss and $5\%$ STOP loss, at least one loss happens in $14.5\%$ of the stops. A $5\%$ target therefore has to cover one lost message almost entirely: the budget grows from $95$ to $174\,ms$, about $3.5\,cm$ more threshold.

**Measured.** With the losses it measured in that session ($9\%$ and $5\%$), the controller computed $B=170.5\,ms$ for the netem session at $P_{target}=0.05$. The model gives $170.6\,ms$ for those values. The part of $S$ that pays for the random delays (finding 6) was $7.5\,cm$, against $4.2\,cm$ on clean Starlink at the same target: $+3.3\,cm$. This is the difference between the measured thresholds of the two conditions ($46.9$ and $42.6\,cm$). At the looser targets, loss costs much less: $B=108\,ms$ at $0.15$ and $81\,ms$ at $0.30$ in the netem sessions, against $85$ and $70\,ms$ on a clean link, because a lost message no longer needs to be covered with high probability.

#### 6. What moves the threshold
Section 6.5 writes $S$ as three pieces: the distance needed to stop, the distance travelled during the fixed delays ($\tau_{e2e}+\psi$), and the room for the random part ($B$). Splitting every brake's threshold this way (session means, in cm):

| Condition | Policy | $S$ | To stop $L+m+d_{brake}$ | Fixed delays | Random part | $\tau_{e2e}$ (ms) | $\psi$ (ms) | $B$ (ms) |
|---|---|---|---|---|---|---|---|---|
| Ideal | SMART 0.05 | 42.66 | 34.80 | 3.67 | 4.19 | 1.4 | 81.7 | 95.0 |
| Ideal | SMART 0.30 | 39.76 | 35.13 | 1.56 | 3.08 | 1.2 | 34.2 | 70.0 |
| Starlink | SMART 0.05 | 42.56 | 34.79 | 3.58 | 4.19 | 51.0 | 30.5 | 95.2 |
| + iperf | SMART 0.05 | 42.52 | 34.66 | 3.17 | 4.70 | 46.1 | 25.5 | 106.0 |
| + netem | SMART 0.05 | 46.94 | 35.02 | 4.41 | 7.51 | 65.4 | 34.7 | 170.5 |
| + netem | SMART 0.15 | 47.02 | 35.04 | 7.22 | 4.76 | 69.0 | 95.1 | 108.0 |
| mixed | SMART 0.05 | 45.67 | 33.73 | 3.68 | 8.26 | 59.3 | 25.0 | 189.2 |

Three observations:

- **The stopping distance is fixed** at about $35\,cm$. Everything the network does moves only the other two pieces, which together range from $4.6$ to $12\,cm$.
- **Equal thresholds can have different causes.** The two netem sessions at $0.05$ and $0.15$ ended at the same $S\approx47\,cm$. In the first, the loss budget is large (random part $7.5\,cm$). In the second, the target is looser but $\psi$ happened to be $95\,ms$, almost a whole period, which costs $7.2\,cm$ of fixed delay.
- **$\psi$ can cancel the latency.** Ideal and Starlink at $0.05$ have the same fixed part ($3.6\,cm$), although $\tau_{e2e}$ is $1.4\,ms$ in one and $51\,ms$ in the other. The Ideal session happened to have $\psi=82\,ms$ against $31\,ms$. A threshold computed from the latency alone would have been $2.2\,cm$ too low on the local network.

![[smart_fig_6_6_6_threshold_split.png]]
_The part of each session's threshold that the network pays for, $S-(L+m+d_{brake})$, split into the fixed delays and the random part (a priori, with the bot's values). The loaded FIXED sessions used $m=10\,cm$, so their network part is $5\,cm$ smaller than their $S$ suggests._

#### 7. The spread of the stopping distance grows with loss as predicted
**Prediction**: the standard deviation of $d_\min$ is $\frac{v_\max T}{1000}\sqrt{\frac1{12}+\frac{p_{tx}}{(1-p_{tx})^2}+\frac{p_{rx}}{(1-p_{rx})^2}}$, about $1.3\,cm$ without loss.

**Measured** (standard deviation of measured $-$ expected $d_\min$ in each session; it also includes the LiDAR's own noise):

| Condition | Model | Measured (range over sessions) |
|---|---|---|
| Ideal | $1.27\,cm$ | $1.06$ to $1.49\,cm$ |
| Starlink | $1.32\,cm$ | $0.93$ to $1.68\,cm$ |
| + iperf | $1.57\,cm$ | $1.26$ to $1.61\,cm$ |
| + netem | $2.24\,cm$ | $2.15$ to $2.28\,cm$ |
| mixed | $2.49\,cm$ | $2.26$ to $2.84\,cm$ |

#### 8. Single brakes, not just averages
The previous findings compare averages. This one checks whether the model can also tell, brake by brake, which stops end in a crash.

**The rule.** Section 6.5 says a stop is late when the delay of the random part is longer than the budget $B$. For a single brake, $\phi$ can be measured (finding 1), and $B$ can be computed with that brake's own $v_\max$, $d_{brake}$ and STOP wait. If no STOP is lost, the model predicts: $$\text{crash}\iff\phi>B$$ A lost STOP cannot be seen in $\phi$, so it is the one thing this rule cannot predict.

**The result.** The rule was applied to all 380 brakes and compared with what actually happened:

| Brakes | Count |
|---|---|
| No crash, and $\phi\leq B$ as predicted | 323 |
| Crash, and $\phi>B$ as predicted | 39 |
| **Rule correct** | **362 of 380 ($95.3\%$)** |
| Crash, although $\phi\leq B$ | 17 |
| No crash, although $\phi>B$ | 1 |

**Where the 18 exceptions come from:**

| Condition | Brakes | Rule correct | Exceptions | Explanation |
|---|---|---|---|---|
| Ideal, Starlink | 160 | 155 | 5 crashes with $\phi\leq B$ | margin breached by only $0.15$ to $0.45\,cm$: at the level of the LiDAR's noise |
| + iperf | 80 | 76 | 4 crashes with $\phi\leq B$ | margin breached by only $0.05$ to $0.15\,cm$: same as above |
| + netem, mixed | 140 | 131 | 8 crashes with $\phi\leq B$ | margin breached by $0.75$ to $3.35\,cm$. A lost STOP adds one period, about $4.4\,cm$, and is invisible in $\phi$. With $\approx5\%$ STOP loss, about 7 lost STOPs are expected in these 140 brakes |
| | | | 1 no-crash with $\phi>B$ | brake during a burst of lost scans ($49\%$ loss at that moment), where the first reading below $S$ no longer measures $\phi$ |

So on the clean links every exception is a borderline case of a few millimetres. On the lossy links, the extra exceptions match the number of lost STOPs the model expects. The model explains not only how often the bot breaches the margin, but also which brakes do it.

#### 8a. Single brakes, recomputed: the lost STOPs are visible in the log
**Result.** Recomputed with the current analysis, the rule $\text{crash}\iff\phi>B$ holds for 364 of the 380 brakes ($95.8\%$). On the lossy links, every crash the rule misses is a lost STOP that can be measured in the log, not only inferred. That 8 of the 9 lost STOPs ended in a crash is what the model predicts ($81\%$), because the budget $B$ usually leaves less than one period $T=100\,ms$ of slack after $\phi$.

This finding redoes finding 8 with the same pipeline as Section 6.4, on the same 380 brakes, and adds a measurement of the lost STOPs that finding 8 assumed could not be seen.

**The table, recomputed.** The 56 crashes are the same, but the split differs from finding 8:

| Brakes | Finding 8 | Recomputed |
|---|---|---|
| No crash, and $\phi\leq B$ | 323 | 321 |
| Crash, and $\phi>B$ | 39 | 43 |
| Crash, although $\phi\leq B$ | 17 | 13 |
| No crash, although $\phi>B$ | 1 | 3 |
| **Rule correct** | **362** | **364** |

| Condition | Brakes | Rule correct | Crash, $\phi\leq B$ | No crash, $\phi>B$ |
|---|---|---|---|---|
| Ideal, Starlink | 160 | 157 | 2 | 1 |
| + iperf | 80 | 75 | 4 | 1 |
| + netem, mixed | 140 | 132 | 7 | 1 |

%% The finding 8 table probably comes from an older version of the analysis (before the psi fix or the D_BRAKE source change). Not traced. %%

**A lost STOP can be measured.** After the detecting scan, the model's delay is $\tau_{e2e}+\psi+YT$, with $Y$ the number of lost STOPs. The log gives this delay for every brake as "rest" (the measured delay minus $\phi$). So $$y=\text{rest}-\tau_{e2e}-\psi$$ should be about $0\,ms$ without loss and about $T=100\,ms$ with one lost STOP. $y$ is read from distances, so it carries the LiDAR's noise: $1\,cm$ of distance is about $23\,ms$.

| Condition | Brakes | $y$ without a lost STOP | $y$ with a lost STOP | Lost STOPs, expected ($\sum p_{rx}$) | Lost STOPs, observed |
|---|---|---|---|---|---|
| Ideal, Starlink, + iperf | 240 | $-11$ to $47\,ms$ | none | $0.04$ | 0 |
| + netem, mixed | 140 | up to $25\,ms$ | $78$ to $115\,ms$ | $6.8$ | 9 |

No brake has $y$ between $47$ and $78\,ms$, so the two groups separate cleanly at $y>50\,ms$. The 9 lost STOPs are consistent with the measured $p_{rx}$ (probability of 9 or more: $0.25$).

One more brake (mixed, SMART 0.15, run 7) also shows $y=108\,ms$, but only because its measured $d_{brake}$ is $6.1\,cm$, $5\,cm$ below every other brake. With the usual $d_{brake}\approx11\,cm$ its $y$ is about $-6\,ms$, so it is not counted as a lost STOP (Section 6.9, finding 7).

**Why a lost STOP usually ends in a crash.** With $\phi\leq B$, a single lost STOP adds $T$ and crashes exactly when $$\phi+T>B\iff\phi>B-T$$ So a lost STOP crashes for sure when $B<T$, and with probability $\frac{2T-B}{T}$ when $T\leq B<2T$. In the netem and mixed brakes:

| Policy | Brakes | Mean $B$ | Share with $\phi>B-T$ (model) | Lost STOPs | Crashed |
|---|---|---|---|---|---|
| FIXED | 40 | $85.8\,ms$ | $1.00$ | 4 | 4 |
| SMART 0.05 | 40 | $174.0\,ms$ | $0.45$ | 1 | 0 |
| SMART 0.15 | 40 | $130.8\,ms$ | $0.88$ | 3 | 3 |
| SMART 0.30 | 20 | $81.7\,ms$ | $1.00$ | 1 | 1 |
| **All** | 140 | | $\mathbf{0.81}$ | **9** | **8** |

The one lost STOP that did not crash had $B-\phi=141\,ms$, more than one period of slack. This is by design. At $P_{target}=0.15$ or $0.30$, S.M.A.R.T. does not pay for a loss that happens in about $5\%$ of the stops. Only $P_{target}=0.05$ buys enough budget to absorb a lost STOP in about half of the stops. FIXED's $B$ is below $T$, so on these links every lost STOP is a crash.

**The exceptions, one by one.**

- **netem, mixed (7 crashes with $\phi\leq B$).** All 7 have $y$ between $81$ and $115\,ms$: each one is a measured lost STOP. A brake with $\phi\leq B$ crashes from lost STOPs with probability $p_{rx}^{\floor{(B-\phi)/T}+1}$. Summed over the brakes, this gives $4.6$ expected against 7 observed (probability of 7 or more: $0.18$), which is consistent. In one of them (netem, SMART 0.30), the controller had logged $p_{rx}=0$ at the brake: the heartbeat estimate missed that loss.
- **Borderline brakes (4 crashes, 2 false alarms).** Ideal SMART 0.30, Starlink SMART 0.05 (two), iperf FIXED (two) and iperf SMART 0.30. Here $B-\phi$ is between $-3$ and $8\,ms$, and $y$ between $-7$ and $10\,ms$: $\phi$ fell within about $0.4\,cm$ of the budget. These are at the level of the LiDAR's noise, as finding 8 says.
- **iperf, 2 crashes that are not noise.** SMART 0.05 and SMART 0.15, with $B-\phi=46$ and $29\,ms$, and $y=47$ and $32\,ms$. The STOP arrived $30$ to $47\,ms$ later than $\tau_{e2e}+\psi$, which is $1.3$ to $2.1\,cm$, far above the LiDAR's noise. The likely cause is a latency spike on the loaded link. The breach is small ($0.05$ and $0.15\,cm$) only because $y$ happened to exceed $B-\phi$ by a few milliseconds.
- **mixed, 1 false alarm.** $\phi=406\,ms$ but $y=-273\,ms$: the bot was already braking $273\,ms$ before the detecting scan was taken, so this STOP was not caused by the reading below $S$. The likely cause is the stale-scan STOP ($>0.5\,s$ without scans during the burst of lost scans). By Section 6.2.4, such a run should be discarded rather than counted as an exception. %% TODO confirm the stale-scan STOP in that run's CSV %%

**Conclusion.** On the lossy links the exceptions are not an unexplained remainder: each is a lost STOP visible in the log, their number agrees with the model, and the high share of lost STOPs that crash is the model's own prediction. On the clean links, 4 of the 6 exceptions are borderline, and 2 are latency spikes under iperf that the median $\tau_{e2e}$ does not capture.

![[smart_fig_6_6_8_phi_vs_budget.png]]
_Left: every brake's $\phi$ against its budget $B$. Above the diagonal the rule predicts a crash. Circles mark the lost STOPs. Right: the delay after the detecting scan, $y$. It sits at $0\,ms$ except for the lost STOPs, about one period later._


## 6.7) Findings that Disagree with the Model or with Expectations
Section 6.6 lists the predictions that held. This section collects the ones that did not, or only partly: places where the data departs from an assumption of the model, or where the setup did not behave as intended. They are ordered by how much they matter for the model. None of them invalidates the crash prediction, which stays consistent with the observed crashes in every session (Section 6.4). They do show where the model is approximate and where it could be improved.

#### 1. On Starlink, $\psi$ is not constant within a session
**Expected.** $\psi$ is set by the phase between the LiDAR and the control timer, so it should stay the same for a whole session (Section 6.1, assumption "$\psi$ is constant").

**Observed.** This holds on the local network but not on Starlink. Standard deviation of the STOP's wait over the 20 brakes of a session:

| Condition | Within-session spread of $\psi$ |
|---|---|
| Ideal | $0.7$ to $1.4\,ms$ |
| Starlink | $17$ to $35\,ms$ |
| + iperf | $6$ to $20\,ms$ |

In the Starlink session at $P_{target}=0.30$, the model used $\psi=45\,ms$. In reality, 16 STOPs waited only $1$ to $14\,ms$, and 4 waited $88$ to $97\,ms$. The model's single value was too high for most stops and too low for the others.

**Cause.** The scan latency and the wait are not independent. A scan sampled at a fixed point of the LiDAR period arrives $\tau_{tx}$ later and then waits for the next tick. So $\tau_{tx}+\psi$ always ends on a tick, and it is constant modulo $T$. In the data, $(\tau_{tx}+\psi)\bmod T$ has a spread of only $\approx1\,ms$ in every session, Starlink included. On Starlink, $\tau_{tx}$ jitters by $7$ to $18\,ms$, and $\psi$ absorbs that jitter as long as the scan still arrives before the same tick. When the jitter pushes the scan past the tick, it waits almost a whole extra period.

**Consequence.** On a jittery link, the fixed part $\tau_{e2e}+\psi$ is not fixed. It takes two values one period apart, like a message that is "lost" with some probability. The model instead uses the median $\tau$ and a high percentile of $\psi$ as two separate constants. This is the main source of the gap between the a priori and a posteriori probabilities in Section 6.4 (for example, Starlink at $P_{target}=0.05$: $0.050$ a priori, $0.124$ a posteriori). A natural fix fits the existing model: treat a missed tick as one more period of delay, with the probability of a miss estimated from the $\psi$ samples, and add it to the number of lost messages $A$.

![[smart_fig_6_7_1_psi.png]]
_The wait $\psi$ of every STOP, per session, with the model's $\psi$ (90th percentile) as a bar. On the local network $\psi$ is one value. On Starlink some STOPs miss the tick and wait almost a whole period more. In the two netem sessions with $\psi\approx T$, some scans catch the earlier tick instead and wait almost nothing._

#### 2. The a priori model is conservative
**Expected.** If the controller's probabilities are right, the number of crashes should match the sum of the a priori probabilities.

**Observed.** There were fewer crashes than predicted, for both policies:

| Policy | Crashes | Expected a priori | Exact test, p-value |
|---|---|---|---|
| FIXED | 20 | 24.3 | 0.31 |
| SMART | 36 | 44.0 | 0.20 |
| All | 56 | 68.3 | 0.08 |

The difference is not significant at $5\%$, but it points the same way in every pooled group. The SMART crash rate is also below its target at all three levels (3, 12 and 21 crashes against 5, 15 and 24 expected).

**Cause.** The 90th percentile used for $\psi$ is $8.8\,ms$ above the STOP's actual wait on average (Section 6.6, finding 3), and finding 1 above makes it larger on Starlink. The a posteriori probabilities, which use the STOP's own wait, predict 57.0 crashes against the 56 observed.

**Consequence.** In practice S.M.A.R.T. delivers a crash rate somewhat below the target. That is the safe direction, but it costs a few millimetres of threshold.

#### 3. A scan is lost far more often than a packet, and the losses come in bursts
**Expected.** The model assumes independent losses with a fixed probability. The netem setting was expected to lose roughly the same fraction of scans as of heartbeats.

**Observed.** In the bot$\rightarrow$controller direction:

| Condition | Heartbeats lost | Scans lost | Packets per scan this would imply |
|---|---|---|---|
| + netem | $1.8\%$ | $10.1\%$ | $\approx6$ |
| mixed | $1.7\%$ | $13.0\%$ | $\approx8$ |
| + iperf | $0.1\%$ | $3.9\%$ | $\approx40$ |

- With netem, the ratio is what you would expect from a large message split into several packets, any one of which can be lost.
- Under iperf load, the scan loss is far too high for a message of the same size. Congestion hits large messages much harder than small ones.
- The loss is also not steady. At individual brakes the scan loss estimate reached $21\%$ (iperf) and $49\%$ (mixed), against averages of $3.9\%$ and $13\%$.

**Consequence.** The heartbeat loss would have underestimated the scan loss by a factor of 5 to 40, which is why the model takes $p_{tx}$ from the scans themselves (Section 6.2.3). The bursts break the independence assumption. The one false alarm of Section 6.6 (finding 8) happened during such a burst, and bursts are also a likely reason for finding 4 below.

![[smart_fig_6_7_3_loss_bursts.png]]
_How long runs of consecutive lost scans last, from the gaps in the LiDAR stamps of all runs, against independent losses with the same loss rate (dashed). With netem the losses are independent. Under iperf load, and in the mixed condition, runs of 3 to 7 lost scans happen far more often than independent losses allow (Section 6.9, finding 2)._

#### 4. Waits longer than one period are slightly more frequent than predicted
**Expected.** With scan loss $p_{tx}$, the wait before the first scan below $S$ should exceed $T$ in a fraction $p_{tx}$ of the stops.

**Observed.** $13.8\%$ against $10.1\%$ with netem, and $15.0\%$ against $12.9\%$ in the mixed condition: higher in both cases.

**Cause.** Either losses come in runs, which makes two or more lost scans in a row more likely than the geometric model predicts, or some scans are delayed by more than a period without being lost. The logs cannot tell these two cases apart.

#### 5. Loading the link with iperf did not increase the latency
**Expected.** The iperf condition was meant to load the link ($40\,Mbit/s$ controller$\rightarrow$bot and $4.5\,Mbit/s$ bot$\rightarrow$controller), with more queueing delay and more loss.

**Observed.** It increased the scan loss (from $0.5\%$ to $3.9\%$) but not the latency. The scan latency was $32.6\,ms$, against $36.8\,ms$ without load, and $\tau_{e2e}$ was $46.7\,ms$ against $48.6\,ms$. The differences are within the variation between sessions on the same day.

**Consequence.** The link was not saturated, so the iperf condition tests the model under moderate congestion loss, not under queueing delay. Testing the "constant latency" assumption under a growing queue would need a higher load or a rate limit (for example `netem rate`).

#### 6. Waits longer than one period on links with no loss
**Expected.** Without lost scans, $\phi$ is always below $T$.

**Observed.** 8 of the 158 brakes with no measured scan loss show $\phi$ between $100$ and $108\,ms$.

**Cause.** This is a measurement limit, not a model error. $\phi$ is read from a distance, $1000\,(S-\text{reading})/v_\max$, so $0.2$ to $0.3\,cm$ of LiDAR noise gives $5$ to $7\,ms$ of error at $44\,cm/s$. The same limit explains the 9 borderline exceptions of Section 6.6, finding 8, which breached the margin by less than half a centimetre.

#### 7. Two Starlink sessions are at the edge of the spread check
**Expected.** The spread of the minimum distance should match Section 5.5: $1.32\,cm$ on Starlink.

**Observed.** $0.93\,cm$ at $P_{target}=0.30$ and $1.68\,cm$ at $0.15$. These two sessions have the lowest p-values of the model check ($0.099$ and $0.066$), although both still pass.

**Cause.** No specific cause was found. With 20 brakes, a measured standard deviation has a relative uncertainty of about $\pm16\%$. Both values are within about two of these uncertainties, so random fluctuation is a plausible explanation. They are also the sessions where $\psi$ varied most (finding 1).

#### 8. The calibrated constants drift between sessions
**Expected.** $v_\max$ and $d_{brake}$ are properties of the robot and should barely change.

**Observed.** Across sessions, $v_\max$ ranged from $43.1$ to $44.6\,cm/s$ and $d_{brake}$ from $10.0$ to $11.6\,cm$. The $d_{brake}$ range alone moves the threshold by $1.6\,cm$, more than the whole effect of a $5\%$ target change on a clean link.

**Consequence.** The calibration run at the start of each session is necessary: fixed constants from one day would bias the thresholds of another. Since $v_\max$ and $d_{brake}$ are kept fixed within a session, any drift during a session (battery voltage, for example) is not followed by the model.

## 6.8) Recheck of Sections 5 and 6
**Result.** The maths of Section 5 is correct: every formula agrees with a Monte Carlo simulation to within the simulation's own noise. Recomputed from the logs, the numbers of Section 6 reproduce, except for a few sentences listed below. Four findings are on the wrong side of the agree/disagree split:
- 6.6.2 and 6.7.4 report the same measurement with opposite verdicts.
- 6.6.3 claims a constant $\psi$, which 6.7.1 disproves.
- 6.7.6 is a measurement limit, not a disagreement.
- 6.7.2 is not significant.

Everything here was recomputed by `recheck_section6.m` (MATLAB project `CSV Test`). It uses the same per-brake pipeline as Section 6.4 (`workaround_bulk_smart.m`), plus the raw run logs for the LiDAR stamps and the $\psi$ samples. It also makes the figures of Sections 5 and 6.

#### Section 5: the formulas
Each result was checked against $400\,000$ simulated stops, for five loss settings $(p_{tx},p_{rx})$: $(0.10,0.05)$, $(0.30,0.10)$, $(0.20,0.20)$, $(0,0.05)$ and $(0.05,0)$:

| Result | Checked against | Largest difference |
|---|---|---|
| $\mathbb E[t_{e2e,thresh}]$ (5.3) | simulated mean | $0.11\,ms$ |
| $\text{Var}(t_{e2e,thresh})$ (5.5) | simulated variance | $0.2\%$ |
| $F(k)$ (5.6) | simulated $\mathbb P(A\geq k)$, $k=0\dots6$ | $0.0009$ |
| $P_{crash}$ (5.6) | simulated $\mathbb P(AT+\phi>B)$, $B=0\dots400\,ms$ | $0.0014$ |
| $P_{low}\leq P_{crash}\leq P_{high}$, and $P'$ within $\frac{f(N_\tau)}2$ (5.6) | every $B$ | always true |
| $B_{min}$ (5.7) | $P_{crash}(B_{min})$, exact and simulated | exactly $P_{target}$; simulated within $0.001$ |

$F$ and $f$ are unchanged when $p_{tx}$ and $p_{rx}$ swap, and tend to the symmetric forms as $p_{rx}\to p_{tx}$. The numbers quoted in 6.5 ($14.5\%$, $1.7\%$, $0.18\%$, $174\,ms$) and in 6.6.5 ($170.6\,ms$) are correct.

Two text problems, neither of which changes a formula:

- **Two definitions of $\psi$.** Section 5.2 defines $\psi$ as the wait "from the arrival of the STOP to the relay tick that applies it", and puts a relay timer on the bot. The same picture appears in 5.3 ("the relay ticks with the same period") and at the end of 5.7 ("applied on the relay grid", "before the relay tick"). But 5.3, 6.1, 6.2.3 and 6.5 define $\psi$ as the wait from the scan's arrival at the controller to the next control tick, and 6.1 says the STOP is applied as soon as it reaches the bot. The tests measured the second. In the model both are a constant shift, so the results are the same, but 5.2, 5.3 and 5.7 should describe the controller's timer.
- **Cross-references.** 5.2 ("see Section 4.3") and the proof of 5.4 ("given in Section 4.3") point to the older version of the model. They mean 5.3.

#### Section 6: claim by claim
| Where | Claim | Recomputed | Verdict |
|---|---|---|---|
| 6.1 | FIXED: $\Delta t\approx165$ to $180\,ms$ | $165$ to $178\,ms$ | correct |
| 6.3.1 | link table | every value reproduces | correct |
| 6.3.2 | "except the mixed condition at $P_{target}=0.30$" | the matrix lists `auto_SUPERSMART_20261113_174835` for mixed 0.30, and that session has 20 measured brakes at a logged target of $0.30$ | **text and table disagree** (finding 8 of 6.9) |
| 6.4 | table, pooled table, findings 1 to 6 | every value reproduces (smallest p-values $0.066$ and $0.37$) | correct |
| 6.5 | netem vs clean Starlink at $0.05$: "rises by about $3.5\,cm$. This is the difference measured" | the measured difference is $46.94-42.56=4.4\,cm$: $3.3\,cm$ from the loss (random part), $0.8\,cm$ from the higher $\tau_{e2e}$ ($+14\,ms$) and $\psi$ ($+4\,ms$), $0.2\,cm$ from $d_{brake}$ | **partly wrong**: loss explains 3.3 of the 4.4 cm |
| 6.6.1 | 187 brakes, $49.1\pm28.9\,ms$, KS $p=0.36$ | 187 brakes, $49.3\pm29.1\,ms$, KS $p=0.49$ | correct |
| 6.6.2 | mean wait; wait $>T$ in $13.8\%$ (netem), $15.0\%$ (mixed) | mean wait $64.4$ and $61.8\,ms$; wait $>T$ in 13 of 80 ($16.2\%$) and 9 of 60 ($15.0\%$), against 8.1 and 7.8 expected; pooled 22 against 15.9 ($p=0.07$) | correct at $5\%$, but the same data is a "disagreement" in 6.7.4 |
| 6.6.3 | spread $7\,ms$; means $17$ to $93\,ms$; $90.5\%$ covered; $+8.8\,ms$ | $7.2\,ms$; $17$ to $93\,ms$; $90.0\%$; $+8.5\,ms$ | numbers correct; **title wrong**: $\psi$ is not constant (6.7.1), and the largest within-session spread is a netem session ($35.9\,ms$), not Starlink |
| 6.6.4 | $95/85/70$ and $95.24/85.30/70.18\,ms$ | the same | correct |
| 6.6.5 | $B=170.5\,ms$ (model $170.6$); $+3.3\,cm$ of random part; "this is the difference between the measured thresholds" | $170.5$, $170.6$, $+3.3\,cm$; the thresholds differ by $4.4\,cm$ | numbers correct; **last sentence wrong**, as in 6.5 |
| 6.6.6 | table; "from the latency alone ... $2.2\,cm$ too low" | table reproduces; ignoring $\psi$ costs $3.6\,cm$, $\psi=T/2$ costs $1.4\,cm$; $2.2\,cm$ is what Starlink's $\psi$ ($31\,ms$) instead of $82\,ms$ would cost | **the $2.2\,cm$ does not match its sentence** |
| 6.6.7 | model $1.27$ to $2.49\,cm$; measured ranges | model $1.26/1.32/1.61/2.25/2.55\,cm$; measured ranges identical | correct |
| 6.6.8 | 362 of 380 | 364 of 380 | superseded by 8a |
| 6.7.1 | Ideal $0.7$ to $1.4$, Starlink $17$ to $35$, iperf $6$ to $20\,ms$; $(\tau_{tx}+\psi)\bmod T$ spread $\approx1\,ms$ | the same; netem $6.9$ to $35.9\,ms$ and mixed $4.8$ to $8.0\,ms$ are missing; mod-$T$ spread $0.7$ to $1.9\,ms$ | correct, table incomplete |
| 6.7.2 | p-values $0.31$, $0.20$, $0.08$ | the same | correct, and not significant: "partly" rather than a disagreement |
| 6.7.3 | heartbeat and scan loss; "the losses come in bursts"; "bursts are also a likely reason for finding 4" | loss values reproduce. Bursts: yes under iperf and in mixed, no with netem (6.9 finding 2). Bursts cannot raise the share of waits $>T$: the crossing is independent of the losses, so the scan after it is lost with the average loss rate, bursts or not. They raise only waits $>2T$: 1 observed against 1.8 expected | **partly wrong** |
| 6.7.4 | "the logs cannot tell these two cases apart" | they can: in the LiDAR stamps, 20 of the 22 waits $>T$ have a lost scan before the detecting one, and the other 2 are LiDAR noise (6.7.6). The excess is not significant ($p=0.07$ pooled; netem $0.056$, mixed $0.37$) | **wrong**, and it agrees with the model: same finding as 6.6.2 |
| 6.7.5 | iperf did not raise the latency | the median, no; the spread, yes: the delay after the detecting scan varies twice as much ($8.4\,ms$ against $3.7$ to $4.1\,ms$), and two crashes came from $30$ to $47\,ms$ spikes (8a) | correct for the median only (6.9 finding 9) |
| 6.7.6 | 8 of 158 lossless brakes with $\phi$ in $(100,108]\,ms$; "explains the 9 borderline exceptions" | 5 of 158 in $(100,108]$, none with a lost scan; 8a has 6 borderline exceptions | conclusion correct; it is a limit of the measurement, not a disagreement with the model |
| 6.7.7 | $0.93$ and $1.68\,cm$, p-values $0.099$ and $0.066$; "also the sessions where $\psi$ varied most" | numbers the same. The largest $\psi$ spread is netem 0.15 ($35.9\,ms$), whose spread check passes easily ($p=0.75$), and Starlink 0.15 is only fifth | numbers correct, the link to $\psi$ is weak |
| 6.7.8 | $v_\max$ $43.1$ to $44.6\,cm/s$, $d_{brake}$ $10.0$ to $11.6\,cm$ | $43.11$ to $44.59$, $9.98$ to $11.59$ | correct; no drift within a session (6.9 finding 6) |

#### Which side each finding belongs on
- **6.6.2 and 6.7.4** are one measurement, and it agrees with the model at $5\%$. 6.7.4 should become part of 6.6.2, with the LiDAR-stamp check.
- **6.6.3** mixes two claims. "The 90th percentile covers $90\%$ of the stops" agrees with the model. "$\psi$ is a constant of each launch" holds only on the local network and is the subject of 6.7.1.
- **6.7.6** is a limit of the measurement of $\phi$, not of the model. It fits better next to 6.6.1 or 8a.
- **6.7.2** is not significant ($p=0.08$). It is a tendency, explained by 6.6.3, rather than a disagreement.


## 6.9) New Findings
Findings that came out of the recheck. Each one uses the same 380 brakes, unless it says otherwise.

#### 1. The fixed delays account for the whole delay after the detection
**Result.** Without a lost STOP, the time from the detecting scan to the start of braking is $\tau_{e2e}+\psi$ to within $1.4\,ms$ on average. The bot adds no hidden actuation delay.

**Prediction.** With $y=\text{rest}-\tau_{e2e}-\psi$ as in 8a, the model gives $y=YT$, so $y=0$ on the links without STOP loss.

**Measured** (240 brakes of Ideal, Starlink and iperf): $y=+1.4\,ms$ on average (standard error $0.4\,ms$), standard deviation $5.9\,ms$. By condition: Ideal $+1.6\,ms$, Starlink $+0.3\,ms$, iperf $+2.3\,ms$. The bias is $0.06\,cm$ of distance, and the spread, $0.26\,cm$, is the LiDAR's noise.

#### 2. Losses are independent with netem, but come in bursts under load
**Result.** With netem the lost scans follow the model's independent losses exactly. Under iperf load, and in the mixed condition, a lost scan makes the next one far more likely to be lost too.

**Measured** from the gaps in the LiDAR stamps of all runs (figure in 6.7.3):

| Condition | Scans lost | P(next scan lost, after a lost scan) | Runs of $\geq2$ lost: observed (independent) | Runs of $\geq3$: observed (independent) | Longest run | p-value (independence) |
|---|---|---|---|---|---|---|
| Starlink | $0.6\%$ | $0.04$ | 1 ($0.2$) | 0 ($0.00$) | 2 | $0.15$ |
| + iperf | $4.0\%$ | $0.15$ | 16 ($5.2$) | 3 ($0.21$) | 6 | $10^{-8}$ |
| + netem | $10.3\%$ | $0.09$ | 30 ($34.9$) | 4 ($3.6$) | 3 | $0.8$ |
| mixed | $13.0\%$ | $0.21$ | 50 ($35.7$) | 11 ($4.6$) | 7 | $4\cdot10^{-5}$ |

Under iperf, a scan right after a lost one is lost $3.8$ times more often than the average scan.

**Consequence.** The geometric model of Section 5 is exact for random loss like netem's. Under congestion it underestimates two or more losses in a row. This did not matter in these tests: a target of $0.05$ or above never has to cover two lost messages, and at the brakes only 1 wait was longer than $2T$, against 1.8 expected. A target small enough to cover two losses (below about $2\%$ with these loss rates) would be too optimistic on a congested link.

#### 3. A missed tick can make the STOP one period later, or one period earlier
**Result.** Whether latency jitter costs safety depends on where $\psi$ sits. When $\psi$ is small, a late scan misses the tick and the STOP leaves one period later. When $\psi$ is close to $T$, an early scan catches the previous tick and the STOP leaves one period earlier. The jitter is a risk only in the first case.

**Measured** (figure in 6.7.1):
- In the four Starlink sessions, $\psi$ was small (median $14\,ms$). 8 of the 80 STOPs waited about $95\,ms$ instead, one period too late. This $10\%$ matches the $11.5\%$ of the $\psi$ samples before the brakes, so the late STOPs are as frequent as the controller could have known.
- In the two netem sessions with $\psi\approx95\,ms$, 4 STOPs waited almost $0\,ms$: one period early, the safe direction.

**Consequence.** The $90^{th}$ percentile handles the second case well (it stays near $T$). In the first case it falls between the two values whenever the share of late STOPs is near $10\%$, as in the Starlink session at $0.30$ (6.7.1). A control tick placed so that $\psi\approx T/2$ would absorb jitter of up to $\pm T/2$ in both directions.

#### 4. Using all the $\psi$ samples instead of their 90th percentile
**Result.** Averaging the a priori crash probability over the $\psi$ samples the controller had before each brake removes the conservatism of 6.7.2 in total: $56.2$ expected crashes against 56 observed. Brake by brake, though, it is not better than the 90th percentile, and it underpredicts the Starlink sessions.

**Measured** (expected crashes; figure in 6.4):

| Condition | A priori, $\psi$ = 90th percentile | A priori, all $\psi$ samples | A posteriori | Observed |
|---|---|---|---|---|
| Ideal | $10.0$ | $9.5$ | $8.7$ | 8 |
| Starlink | $14.0$ | $9.0$ | $12.7$ | 14 |
| + iperf | $15.5$ | $13.0$ | $10.5$ | 10 |
| + netem | $16.3$ | $13.4$ | $14.1$ | 16 |
| mixed | $12.4$ | $11.2$ | $10.9$ | 8 |
| **All** | $68.3$ | $56.2$ | $57.0$ | 56 |

Log-likelihood of the observed crashes: $-140.0$ (90th percentile), $-142.0$ (all samples), $-136.5$ (a posteriori).

**Consequence.** This is the fix suggested at the end of 6.7.1, and it does not clearly help: it trades the overall conservatism for an underprediction on the jittery link (Starlink: $9.0$ expected against 14 observed, $p\approx0.07$). For a safety bound, the 90th percentile remains the better choice.

#### 5. The a posteriori probability is calibrated over its whole range
**Result.** Grouping the brakes by their a posteriori $P_{crash}$, the observed crashes follow the predicted ones in every group, not only in total.

| A posteriori $P_{crash}$ | Brakes | Expected crashes | Observed |
|---|---|---|---|
| $0$ to $0.02$ | 75 | $0.3$ | 1 |
| $0.02$ to $0.10$ | 93 | $5.4$ | 8 |
| $0.10$ to $0.20$ | 95 | $14.0$ | 15 |
| $0.20$ to $0.40$ | 97 | $26.6$ | 20 |
| $0.40$ to $0.70$ | 17 | $8.1$ | 9 |
| $0.70$ to $1$ | 3 | $2.6$ | 3 |

The largest gap ($20$ against $26.6$) is within about $1.3$ standard deviations.

#### 6. The robot does not drift within a session
**Result.** The cruise speed, the braking distance and the error of $d_\min$ show no trend over the 20 runs of a session. Keeping $v_\max$ and $d_{brake}$ fixed within a session (6.7.8) is justified: they change between sessions, not during them.

**Measured** (trend per run, after removing each session's mean): $v_\max$ $-0.002\,cm/s$ per run ($r=-0.03$), $d_{brake}$ $+0.002\,cm$ per run ($r=0.03$), error of $d_\min$ $+0.02\,cm$ per run ($r=0.07$). Across all brakes, $d_{brake}$ is not correlated with the speed either ($r=-0.03$): over $42$ to $44.5\,cm/s$, the dependence of the braking distance on speed is hidden by its brake-to-brake scatter.

#### 7. One braking distance was measured wrongly
**Result.** In one brake (mixed, SMART 0.15, run 7), the bot measured $d_{brake}=6.1\,cm$, against a median of $11.1\,cm$ (the next lowest are $8.3$ and $8.4\,cm$). With that value, its $y$ looks like a lost STOP ($108\,ms$). With the usual $11\,cm$, $y\approx-6\,ms$, a normal stop.

**Cause.** The bot was already braking about one period before the STOP its `BrakeMonitor` logged. The most likely explanation is that the monitor missed the first STOP and measured from the second one. It does not change the crash count, which uses only $d_\min$. It does shift that brake's expected $d_\min$ and a posteriori probability, and it is excluded from the lost STOPs of 8a. %% TODO check the bot's log of that run %%

#### 8. The mixed session at $P_{target}=0.30$ agrees with the model
**Result.** The session left out of Section 6.4 (`auto_SUPERSMART_20261113_174835`) behaves like the others: 4 crashes in 20 brakes, against $3.8$ expected a posteriori ($p=1.00$), and a $d_\min$ error of $+0.47\pm2.18\,cm$. Its mean threshold was $43.05\,cm$. Nothing in the data argues for leaving it out. With it, the tests cover 20 sessions, 400 brakes and 60 crashes.

#### 9. Load raises the jitter, not the latency
**Result.** Under iperf the median latency stayed the same (6.7.5), but its spread doubled, and the spikes caused crashes.

**Measured.** The standard deviation of $y$, the delay after the detecting scan, was $3.7\,ms$ (Ideal), $4.1\,ms$ (Starlink) and $8.4\,ms$ (iperf). Two of the iperf crashes came from single spikes of $30$ and $47\,ms$ (8a).

**Consequence.** The model takes $\tau_{e2e}$ as a constant median over $10\,s$, so a spike of a fraction of a period is not in it. On a loaded link, a high percentile of the latency would play the same role as the 90th percentile of $\psi$.


# 7) Ci riprovo ancora

## 7.1) Intro

This work aims to design a model that can predict the crash probability of a bot under unstable network conditions.

The setup is very simple: The bot moves towards an object while sending data to a controller. This controller analyzes the lidar data and when needed sends a stop signal to the bot, which will then brake.

## 7.2) Model and Assumptions

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
- $T_{bot}$: sampling period of the LiDAR on the bot.
- $T_{ctrl}$: send period of the controller timer.
- $g=\gcd(T_{bot},T_{ctrl})$: the largest time step of which both periods are integer multiples, and $M=T_{ctrl}/g$.
- $\psi$: measured wait from the arrival of the LiDAR data at the controller to the next control message (see Section 5.3).

_(distances are in meters, $v_{max}$ is in $m/s$, and times are in $ms$.)_

Some other parameters can be calculated immediately:

- $d_\max=m+L+d_{brake}$: last measured distance at which braking can start safely.
- $\Delta d=S-d_\max$: distance the bot can travel before braking must start.
- $\Delta t=1000\cdot\frac{\Delta d}{v_\max}$: time available for the LiDAR data and the STOP to complete their round trip.

The LiDAR samples on the bot every $T_{bot}$. The controller keeps the last decision, GO while the measured distance is above $S$ and STOP once the threshold crossing has been detected, and sends it on a timer with period $T_{ctrl}$. The bot applies a command as soon as it is received. The two timers are not aligned, and their phases are fixed while the nodes run.

A synchronized clock is needed for latency calculations.

- Packet losses are independent.
- Lost LiDAR data is replaced by the next scan, one $T_{bot}$ later, and a lost STOP by the next control message, one $T_{ctrl}$ later.
- $\tau_{tx}$ and $\tau_{rx}$ are constant, and their jitter is small compared to $T_{bot}$ and $T_{ctrl}$.
- The threshold crossing falls uniformly within the common cycle of the two timers, of length $\text{lcm}(T_{bot},T_{ctrl})$. This holds when the start time of each run is independent of the timer phases.
- The bot reaches $v_\max$ before crossing $S$, travels at $v_\max$ until the STOP is received, and then brakes immediately.

## 7.3) Communication Delay (CD)

Let $X\sim\text{Geom.}(1-p_{tx})$ and $Y\sim\text{Geom.}(1-p_{rx})$ be the numbers of failed attempts on the sensor and brake links, starting from 0.

Let $\phi \sim \mathcal{U}(0, T_{bot})$ be the wait from the threshold crossing to the next LiDAR sample. It changes with each stop and is independent of the network.

Let $\psi\in[0,T_{ctrl})$ be the wait from the LiDAR data arriving at the controller until the next control message is sent. With different periods, the scans arrive at a different point of the controller cycle each time, so $\psi$ is no longer a single value. It takes $M$ values, equally spaced by $g$: $$\Psi=\curly{\psi_0,\ \psi_0+g,\ \dots,\ \psi_0+(M-1)g}\qquad 0\leq\psi_0<g$$ Each value has probability $\frac1M$, and $\psi$ is independent of $\phi$, $X$ and $Y$. The offset $\psi_0$ is set by the phases of the two timers and by $\tau_{tx}$, so it is fixed while the nodes run. The mean is: $$\bar\psi=\mathbb E[\psi]=\psi_0+\frac{T_{ctrl}-g}2$$ Three cases follow:

- If $T_{bot}$ is a multiple of $T_{ctrl}$ (for example equal periods), $M=1$ and $\psi=\psi_0$ is constant while the nodes run.
- Otherwise $\psi$ changes with each stop. It also changes when a scan is lost, since the replacement arrives at another point of the controller cycle.
- If the periods have no common step, or drift, $g\to0$ and $\psi\sim\mathcal U(0,T_{ctrl})$.

$\psi$ is measured on the controller for every scan. Within any $M$ consecutive scans each value of $\Psi$ appears once, so the recent measurements give $\Psi$ directly.

The communication delay on each link is: $$t_{tx}=\tau_{tx}+XT_{bot}\qquad \mathbb E[t_{tx}]=\tau_{tx}+\frac{p_{tx}T_{bot}}{1-p_{tx}}$$ $$t_{rx}=\tau_{rx}+YT_{ctrl}\qquad \mathbb E[t_{rx}]=\tau_{rx}+\frac{p_{rx}T_{ctrl}}{1-p_{rx}}$$ The end to end communication delay is: $$t_{e2e}=t_{tx}+t_{rx}=\tau_{e2e}+XT_{bot}+YT_{ctrl}\qquad \mathbb E[t_{e2e}]=\tau_{e2e}+\frac{p_{tx}T_{bot}}{1-p_{tx}}+\frac{p_{rx}T_{ctrl}}{1-p_{rx}}$$ However, one significant transmission is the crossing of the threshold, which has an added wait $\phi$ in bot$\rightarrow$controller transmission and $\psi$ in controller$\rightarrow$bot transmission: $$\begin{gather} t_{tx,thresh}=\tau_{tx}+XT_{bot}+\phi\qquad \mathbb E[t_{tx,thresh}]=\tau_{tx}+T_{bot}\frac{1+p_{tx}}{2(1-p_{tx})}\ t_{rx,thresh}=\tau_{rx}+YT_{ctrl}+\psi\qquad \mathbb E[t_{rx,thresh}]=\tau_{rx}+\frac{p_{rx}T_{ctrl}}{1-p_{rx}}+\bar\psi\ t_{e2e,thresh}=t_{e2e}+\phi+\psi\qquad \mathbb E[t_{e2e,thresh}]=\tau_{e2e}+\bar\psi+T_{bot}\frac{1+p_{tx}}{2(1-p_{tx})}+\frac{p_{rx}T_{ctrl}}{1-p_{rx}} \end{gather}$$ The expectations are taken over $X$, $Y$, $\phi$ and $\psi$. One quick feasibility check can be done on $$\mathbb E[t_{e2e,thresh}]\leq \Delta t$$

##### Proof

We first compute the expected number of failures on a link. Since $X$ counts the failed attempts before the first success, $P(X=n)=p_{tx}^n(1-p_{tx})$ for $n\in{0,1,2,\dots}$. Using $\sum_{n=0}^\infty np^n=\frac{p}{(1-p)^2}$, for $|p|<1$: $$\E[X]=\sum_{n=0}^\infty n,p_{tx}^n(1-p_{tx})=(1-p_{tx})\frac{p_{tx}}{(1-p_{tx})^2}=\frac{p_{tx}}{1-p_{tx}}$$ In the same way, $\E[Y]=\frac{p_{rx}}{1-p_{rx}}$.

Since the latencies and the periods are constants, linearity of expectation gives the delay on each link: $$\E[t_{tx}]=\tau_{tx}+T_{bot},\E[X]=\tau_{tx}+\frac{p_{tx}T_{bot}}{1-p_{tx}}\qquad\E[t_{rx}]=\tau_{rx}+T_{ctrl},\E[Y]=\tau_{rx}+\frac{p_{rx}T_{ctrl}}{1-p_{rx}}$$ and their sum gives $\E[t_{e2e}]$.

---

Next, we derive the distribution of $\psi$. Let sample $k$ be taken at $kT_{bot}+\theta_{bot}$, and let the controller send at $jT_{ctrl}+\theta_{ctrl}$. Sample $k$ arrives at the controller at $kT_{bot}+\theta_{bot}+\tau_{tx}$, so its wait to the next control message is: $$\psi_k=\left(\theta_{ctrl}-\theta_{bot}-\tau_{tx}-kT_{bot}\right)\bmod T_{ctrl}$$ Write $T_{bot}=qg$ and $T_{ctrl}=Mg$, where $q$ and $M$ have no common factor. Then $kT_{bot}\bmod T_{ctrl}=g,(kq\bmod M)$. Since $q$ and $M$ are coprime, $kq\bmod M$ takes every value in ${0,\dots,M-1}$ exactly once as $k$ runs over any $M$ consecutive integers. Therefore $\psi_k\in\Psi$ with $\psi_0=(\theta_{ctrl}-\theta_{bot}-\tau_{tx})\bmod g$, and each value appears once every $M$ samples.

The STOP is triggered by sample $k_0+X$, where $k_0$ is the first sample after the crossing. Since the crossing is uniform over the common cycle, which contains $M$ sampling periods, $k_0\bmod M$ is uniform on ${0,\dots,M-1}$. The position of the crossing within its sampling period is $\phi$, and which of the $M$ periods it falls in is $k_0\bmod M$, so the two are independent. Both are also independent of the network, so of $X$ and $Y$. For any value $X=x$, shifting a uniform residue by $x$ keeps it uniform, so $(k_0+X)\bmod M$ is uniform and independent of $X$. Hence $\psi$ is uniform on $\Psi$ and independent of $\phi$, $X$ and $Y$, with mean: $$\E[\psi]=\psi_0+g,\frac{M-1}2=\psi_0+\frac{T_{ctrl}-g}2$$

---

For $\phi\sim\mathcal U(0,T_{bot})$: $$\E[\phi]=\int_0^{T_{bot}}\frac{\phi}{T_{bot}},d\phi=\frac{T_{bot}}2$$ For the threshold transmission on each link, we add the corresponding wait: $$\E[t_{tx,thresh}]=\tau_{tx}+\frac{p_{tx}T_{bot}}{1-p_{tx}}+\frac{T_{bot}}2=\tau_{tx}+T_{bot}\frac{1+p_{tx}}{2(1-p_{tx})}$$ $$\E[t_{rx,thresh}]=\tau_{rx}+\frac{p_{rx}T_{ctrl}}{1-p_{rx}}+\bar\psi$$ Adding the two gives $\E[t_{e2e,thresh}]$. Only linearity of expectation is used, so this result does not require independence. The feasibility check compares only the mean with the budget, so it is not a safety guarantee.

With $T_{bot}=T_{ctrl}=T$ we have $M=1$ and $\psi=\psi_0$, and the result becomes $\tau_{e2e}+\psi+T\frac{1+p_{tx}+p_{rx}-3p_{tx}p_{rx}}{2(1-p_{e2e})}$, the equal-period case. $$\endproof$$

## 7.4) Minimum Distance (MD)

The delay of the threshold transmission determines how far the bot travels before it starts braking, so it also determines how close the bot gets to the obstacle. This section quantifies that closest distance, in order to show the average safety of a given threshold $S$.

The bot moves at constant speed until the STOP is received. When the threshold is crossed, the measured distance is $S$, which means that the front of the bot is at a distance $S-L$ from the obstacle. From this point, the bot:

- travels at $v_\max$ for the time $t_{e2e,thresh}$ needed by the LiDAR data to reach the controller, by the controller to send the STOP, and by the STOP to reach the bot.
- covers the braking distance $d_{brake}$ once the STOP is received.

The distance that remains between the bot and the obstacle after it has stopped is the minimum distance $d_\min$. This is a signed quantity, where a negative value means that the bot would overlap with the obstacle: $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000},t_{e2e,thresh}\qquad\mathbb E[d_\min]=S-L-d_{brake}-\frac{\mathbb E[t_{e2e,thresh}],v_\max}{1000}$$

Note that the margin $m$ does not appear, since it is a requirement on $d_\min$ and not part of the motion of the bot. A value of $\mathbb E[d_\min]\geq m$ only means that the safety margin is respected on average, so it does not exclude that some stops will breach it.

##### Proof

When the threshold is crossed, the measured distance is $S$, so the front of the bot is at distance $S-L$ from the obstacle. The bot then travels at $v_\max$ until the STOP is received, which takes $t_{e2e,thresh}$, and finally covers $d_{brake}$ while braking. Therefore: $$d_\min=S-L-d_{brake}-\frac{v_\max}{1000},t_{e2e,thresh}$$ Since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, linearity of expectation gives: $$\E[d_\min]=S-L-d_{brake}-\frac{\E[t_{e2e,thresh}],v_\max}{1000}$$ where $\E[t_{e2e,thresh}]$ is given in Section 5.3. $$\endproof$$

## 7.5) Variances of CD and MD

The expected values describe only the average stop. Two stops can behave very differently, because the number of retransmissions and the waits $\phi$ and $\psi$ change the delay each time. This section measures that spread, which shows how far a single stop can fall from the expected minimum distance.

Using the independence of $X$, $Y$, $\phi$ and $\psi$ (Section 5.3), the threshold transmission on each link has variance: $$\text{Var}(t_{tx,thresh})=T_{bot}^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac1{12}\right)\qquad\text{Var}(t_{rx,thresh})=T_{ctrl}^2\frac{p_{rx}}{(1-p_{rx})^2}+\frac{T_{ctrl}^2-g^2}{12}$$ The two links have independent delays, so their variances add. The end to end variance is: $$\text{Var}(t_{e2e,thresh})=T_{bot}^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac1{12}\right)+T_{ctrl}^2\frac{p_{rx}}{(1-p_{rx})^2}+\frac{T_{ctrl}^2-g^2}{12}$$ Since $d_\min$ depends on the delay through the factor $\frac{v_\max}{1000}$, the minimum distance has variance: $$\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2\text{Var}(t_{e2e,thresh})$$ The latencies do not appear, since they are constants and only shift the delay. The last term is the spread of $\psi$. It vanishes when $M=1$, which gives back the equal-period result, and it tends to $\frac{T_{ctrl}^2}{12}$ when the periods have no common step. For example, with $T_{bot}=100,ms$ and $T_{ctrl}=30,ms$ ($g=10,ms$), the standard deviation of the delay without losses is $\sqrt{(100^2+30^2-10^2)/12}=30,ms$.

##### Proof

Since $X$ counts the failures before the first success, with $P(X=n)=p_{tx}^n(1-p_{tx})$, its variance is: $$\text{Var}(X)=\frac{p_{tx}}{(1-p_{tx})^2}$$ In the same way, $\text{Var}(Y)=\frac{p_{rx}}{(1-p_{rx})^2}$. For a uniform distribution $\mathcal U(a,b)$ the variance is $\frac{(b-a)^2}{12}$, therefore $\text{Var}(\phi)=\frac{T_{bot}^2}{12}$.

$\psi=\psi_0+gJ$ with $J$ uniform on ${0,\dots,M-1}$. Using $\sum_{j=0}^{M-1}j=\frac{M(M-1)}2$ and $\sum_{j=0}^{M-1}j^2=\frac{(M-1)M(2M-1)}6$: $$\text{Var}(J)=\frac{(M-1)(2M-1)}6-\frac{(M-1)^2}4=\frac{M^2-1}{12}\qquad\text{Var}(\psi)=g^2,\frac{M^2-1}{12}=\frac{T_{ctrl}^2-g^2}{12}$$ Since $\tau_{tx}$ is a constant and $T_{bot}$ is a scaling factor, and using the independence of $X$ and $\phi$: $$\text{Var}(t_{tx,thresh})=T_{bot}^2,\text{Var}(X)+\text{Var}(\phi)=T_{bot}^2\left(\frac{p_{tx}}{(1-p_{tx})^2}+\frac1{12}\right)$$ In the same way, using the independence of $Y$ and $\psi$: $$\text{Var}(t_{rx,thresh})=T_{ctrl}^2,\text{Var}(Y)+\text{Var}(\psi)=T_{ctrl}^2\frac{p_{rx}}{(1-p_{rx})^2}+\frac{T_{ctrl}^2-g^2}{12}$$

Since $t_{e2e,thresh}=t_{tx,thresh}+t_{rx,thresh}$, and the two terms are independent, their variances add. Finally, since $S$, $L$, $d_{brake}$ and $v_\max$ are constants, $\text{Var}(d_\min)=\left(\frac{v_\max}{1000}\right)^2\text{Var}(t_{e2e,thresh})$. $$\endproof$$

## 7.6) Crash Probability (CProb)

A positive expected minimum distance does not mean that every stop is safe, because a long delay can still breach the margin. This section computes the probability of that event, which is the main result of the model. A crash occurs when the threshold transmission takes longer than the time budget: $$t_{e2e,thresh}>\Delta t$$ The constant part of the delay is $\tau_{e2e}$, so the budget left for the retransmissions and the two waits is $B=\Delta t-\tau_{e2e}$, and a crash occurs when: $$\phi+XT_{bot}+\psi+YT_{ctrl}>B$$ With different periods, the sensor and brake failures cost different times, so they can no longer be counted together. Instead, we first fix $\psi$ and the number $y$ of lost STOPs.

For a given $\psi$, let $b=B-\psi$ be the remaining budget. The STOP losses use $yT_{ctrl}$ of it, and leave $u_y=b-yT_{ctrl}$ to the sensor side. For $b\geq0$ let: $$N_c=\floor{\frac b{T_{ctrl}}}\qquad k_y=\floor{\frac{b-yT_{ctrl}}{T_{bot}}}\qquad R_y=b-yT_{ctrl}-k_yT_{bot}\qquad y=0,\dots,N_c$$ $N_c$ is the number of STOP losses the budget can absorb, $k_y$ the number of scan losses that still fit after $y$ STOP losses, and $0\leq R_y<T_{bot}$ the time left over. The crash probability for a given $\psi$ is: $$P_{crash}(\psi)=p_{rx}^{N_c+1}+\sum_{y=0}^{N_c}(1-p_{rx}),p_{rx}^{y};p_{tx}^{k_y}\left(1-(1-p_{tx})\frac{R_y}{T_{bot}}\right)$$ and $P_{crash}(\psi)=1$ if $b<0$. The first term covers more STOP losses than the budget allows. In the sum, $y$ STOPs are lost, and the bot crashes if $k_y+1$ scans are lost, or if exactly $k_y$ are lost and $\phi>R_y$. The exact crash probability averages over the values of $\psi$: $$P_{crash}=\frac1M\sum_{\psi\in\Psi}P_{crash}(\psi)$$ In practice, the average is taken over the recent measured values of $\psi$, using a window of at least $M$ scans. This also covers latency jitter and periods with no common step.

With $T_{bot}=T_{ctrl}=T$, this reduces to the equal-period result $P_{crash}=F(N_\tau)-f(N_\tau)\frac RT$, where $F(k)=\mathbb P(X+Y\geq k)$, $f(k)=\mathbb P(X+Y=k)$, $N_\tau=\floor{b/T}$ and $R=b-N_\tau T$.

Three simpler expressions can also be used. They use the tail of the delay without waits: $$\mathcal L(b)=\mathbb P\left(XT_{bot}+YT_{ctrl}>b\right)=p_{rx}^{N_c+1}+\sum_{y=0}^{N_c}(1-p_{rx}),p_{rx}^{y},p_{tx}^{k_y+1}\qquad b\geq0$$ and $\mathcal L(b)=1$ for $b<0$. Let $\psi_\min$ and $\psi_\max$ be the smallest and largest values in $\Psi$. Ignoring $\phi$ and taking the smallest $\psi$ gives a lower bound on the crash probability: $$P_{low}=\mathcal L(B-\psi_\min)$$ Taking the largest possible waits gives an upper bound on the crash probability: $$P_{high}=\mathcal L(B-T_{bot}-\psi_\max)$$ Therefore: $$P_{low}\leq P_{crash}\leq P_{high}$$ Replacing both waits by their means gives an approximation, which is neither a lower nor an upper bound: $$P'=\mathcal L\left(B-\frac{T_{bot}}2-\bar\psi\right)$$ Unlike the equal-period case, $P_{crash}$ is not a single weighted average of $P_{low}$ and $P_{high}$, since the possible values of $XT_{bot}+YT_{ctrl}$ are unevenly spaced.

##### Proof

Fix $\psi$, so the crash condition is $\phi+XT_{bot}+YT_{ctrl}>b$. Conditioning on $Y=y$, which is independent of $X$ and $\phi$: $$P_{crash}(\psi)=\sum_{y=0}^\infty\mathbb P(Y=y);\mathbb P\left(\phi+XT_{bot}>b-yT_{ctrl}\right)$$ For $y\geq N_c+1$, the bound $b-yT_{ctrl}$ is negative, so the probability is $1$. These terms sum to $\mathbb P(Y\geq N_c+1)=p_{rx}^{N_c+1}$.

For $y\leq N_c$, write $u=b-yT_{ctrl}=k_yT_{bot}+R_y\geq0$. Since $0\leq\phi<T_{bot}$, each value of $X$ gives one of three cases:

- $X\geq k_y+1$: $XT_{bot}\geq(k_y+1)T_{bot}>u$, so a crash is certain. This has probability $p_{tx}^{k_y+1}$.
- $X=k_y$: a crash occurs when $\phi>R_y$, with probability $1-\frac{R_y}{T_{bot}}$. $X=k_y$ has probability $(1-p_{tx})p_{tx}^{k_y}$.
- $X\leq k_y-1$: $\phi+XT_{bot}<k_yT_{bot}\leq u$, so there is no crash.

Adding the cases: $$\mathbb P\left(\phi+XT_{bot}>u\right)=p_{tx}^{k_y+1}+(1-p_{tx})p_{tx}^{k_y}\left(1-\frac{R_y}{T_{bot}}\right)=p_{tx}^{k_y}\left(1-(1-p_{tx})\frac{R_y}{T_{bot}}\right)$$ Multiplying by $\mathbb P(Y=y)=(1-p_{rx})p_{rx}^y$ and summing gives $P_{crash}(\psi)$. If $b<0$, every bound is negative and a crash is certain. Since $\psi$ is uniform on $\Psi$ and independent of $\phi$, $X$ and $Y$, the law of total probability gives the average over $\Psi$.

---

Equal periods: with $T_{bot}=T_{ctrl}=T$ we have $M=1$, $k_y=N_\tau-y$ and $R_y=R$ for every $y$. Then: $$P_{crash}=\mathbb P(Y\geq N_\tau+1)+\sum_{y=0}^{N_\tau}\mathbb P(Y=y)\left[\mathbb P(X\geq N_\tau-y)-\mathbb P(X=N_\tau-y)\frac RT\right]=F(N_\tau)-f(N_\tau)\frac RT$$ since the first two parts add up to $\mathbb P(X+Y\geq N_\tau)$ and the last one to $\mathbb P(X+Y=N_\tau)$.

---

$\mathcal L(b)$ is computed in the same way as $P_{crash}(\psi)$ with $\phi=0$: given $Y=y\leq N_c$, the condition $XT_{bot}>k_yT_{bot}+R_y$ holds exactly when $X\geq k_y+1$, which has probability $p_{tx}^{k_y+1}$.

A crash occurs when $XT_{bot}+YT_{ctrl}>B-\phi-\psi$. If $XT_{bot}+YT_{ctrl}>B-\psi_\min$, this holds for any $\phi\geq0$ and $\psi\geq\psi_\min$, so $P_{low}\leq P_{crash}$. Conversely, since $\phi<T_{bot}$ and $\psi\leq\psi_\max$, every crash satisfies $XT_{bot}+YT_{ctrl}>B-T_{bot}-\psi_\max$, so $P_{crash}\leq P_{high}$.

Replacing the waits by their means gives the condition $XT_{bot}+YT_{ctrl}>B-\frac{T_{bot}}2-\bar\psi$, which is $P'$. As $\phi$ and $\psi$ are random, this is not the true probability, and it can fall on either side of $P_{crash}$. $$\endproof$$

## 7.7) S.M.A.R.T Algorithm

The previous section computes the crash probability for a fixed threshold $S$. The **S.M.A.R.T. (Safety Margin Automatic Readjust Tool)** algorithm solves the inverse problem: given the current network conditions and the measured values of $\psi$, it finds the threshold that meets a desired crash probability $P_{target}\in(0,1)$. A small threshold lets the bot travel further before braking, but it leaves less time for the STOP to arrive, so the aim is to choose $S$ as low as the target allows.

Every crash probability model depends on $S$ through the budget $B=\Delta t-\tau_{e2e}$. Inverting the definition of $\Delta t$, a budget $B$ corresponds to the threshold: $$S(B)=\frac{v_\max}{1000}\left(B+\tau_{e2e}\right)+L+m+d_{brake}$$ Let $b^_$ be the smallest value of the form $iT_{bot}+jT_{ctrl}$, with $i,j\in\mathbb N$, that satisfies: $$\mathcal L(b^_)\leq P_{target}$$ With equal periods, $b^_=T(N^_-1)$, where $N^*$ is the first $N$ with $F(N)\leq P_{target}$. Applying each model of the previous section gives one version of the algorithm:

|Version|Model|Budget $B$|Meets $P_{target}$?|
|---|---|---|---|
|$S_{low}$|$P_{low}$|$b^*+\psi_\min$|No, it ignores the waits|
|$S'$|$P'$|$b^*+\frac{T_{bot}}2+\bar\psi$|Not guaranteed|
|$S_{high}$|$P_{high}$|$b^*+T_{bot}+\psi_\max$|Yes, for any wait|
|$S_{smart}$|$P_{crash}$|$B_{min}$|Yes, and it is the lowest such threshold|

Explicitly: $$S_{low}=\frac{v_\max}{1000}\left(b^_+\psi_\min+\tau_{e2e}\right)+L+m+d_{brake}$$ $$S'=\frac{v_\max}{1000}\left(b^_+\tfrac{T_{bot}}2+\bar\psi+\tau_{e2e}\right)+L+m+d_{brake}$$ $$S_{high}=\frac{v_\max}{1000}\left(b^_+T_{bot}+\psi_\max+\tau_{e2e}\right)+L+m+d_{brake}$$ $$S_{smart}=\frac{v_\max}{1000}\left(B_{min}+\tau_{e2e}\right)+L+m+d_{brake}$$ $P_{crash}$ is continuous and linear in $B$ between consecutive breakpoints, which are the budgets of the form: $$B=\psi+yT_{ctrl}+kT_{bot}\qquad\psi\in\Psi,\ y,k\in\mathbb N$$ Let $B_0<B_1<\dots$ be $B_{low}=b^_+\psi_\min$ followed by the breakpoints in $[B_{low},B_{high}]$, and let $B_{i+1}$ be the first with $P_{crash}(B_{i+1})\leq P_{target}$. Then: $$B_{min}=B_i+\left(B_{i+1}-B_i\right)\frac{P_{crash}(B_i)-P_{target}}{P_{crash}(B_i)-P_{crash}(B_{i+1})}$$ If already $P_{crash}(B_0)\leq P_{target}$, then $B_{min}=B_0$. The thresholds always satisfy: $$S_{low}\leq S_{smart}\leq S_{high}\qquad S_{low}\leq S'\leq S_{high}$$ $S'$ can fall on either side of $S_{smart}$.

**Example.** With $T_{bot}=100,ms$, $p_{tx}=p_{rx}=0.1$ and $P_{target}=10^{-3}$, we get $b^*=300,ms$, and:

|$T_{ctrl}$|$\Psi$ (ms)|$B_{low}$|$B'$|$B_{min}$|$B_{high}$|
|---|---|---|---|---|---|
|$100,ms$|${21.7}$|$321.7$|$371.7$|$405.0$|$421.7$|
|$30,ms$|${7.3,\ 17.3,\ 27.3}$|$307.3$|$367.3$|$334.9$|$427.3$|

A faster controller makes each lost STOP cheaper, so $B_{min}$ drops by about $70,ms$. In the first row $S'<S_{smart}$, and in the second $S'>S_{smart}$.

The values of $\psi$ depend on the phases of the two timers and on $\tau_{tx}$. For this reason $\Psi$ must be measured live and not derived from $\tau_{e2e}$, and $S$ must be recomputed whenever $\Psi$ changes, for example after a restart of the LiDAR or controller node.

##### Proof

Existence of $b^_$: $\mathcal L(b)$ is the tail of $XT_{bot}+YT_{ctrl}$, which only takes values of the form $iT_{bot}+jT_{ctrl}$. So $\mathcal L$ is non-increasing, constant between consecutive such values, and right-continuous. Since $\mathcal L(b)\to0$ as $b\to\infty$, the set of $b$ with $\mathcal L(b)\leq P_{target}$ is non-empty, and its smallest element is one of these values, which is $b^_$. Moreover $\mathcal L(b)\leq P_{target}$ exactly when $b\geq b^*$.

---

Discrete versions: using the last property,

- $P_{low}=\mathcal L(B-\psi_\min)\leq P_{target}$ requires $B\geq b^*+\psi_\min$.
- $P_{high}=\mathcal L(B-T_{bot}-\psi_\max)\leq P_{target}$ requires $B\geq b^*+T_{bot}+\psi_\max$.
- $P'=\mathcal L(B-\frac{T_{bot}}2-\bar\psi)\leq P_{target}$ requires $B\geq b^*+\frac{T_{bot}}2+\bar\psi$.

Since $P_{crash}\leq P_{high}$, $S_{high}$ meets the target for any wait. As $P_{low}$ and $P'$ are not upper bounds on $P_{crash}$, the other two versions do not guarantee it.

---

Exact version: in $P_{crash}(\psi)$, as $B$ grows with $\psi$ and $y$ fixed, each term is linear in $B$ while $k_y$ does not change, which is until $B-\psi-yT_{ctrl}$ reaches a multiple of $T_{bot}$. At that point $R_y\to T_{bot}$, so the term tends to $p_{tx}^{k_y+1}$, which is its value with $k_y+1$ and $R_y=0$. A new term $y=N_c+1$ starts when $B-\psi$ reaches a multiple of $T_{ctrl}$. It starts at $(1-p_{rx})p_{rx}^{N_c+1}$, which is exactly what the first term loses when it becomes $p_{rx}^{N_c+2}$. Therefore $P_{crash}$ is continuous and linear between the breakpoints, so the linear interpolation between $B_i$ and $B_{i+1}$ is exact. Its slope is: $$\frac{dP_{crash}}{dB}=-\frac{1-p_{tx}}{M,T_{bot}}\sum_{\psi\in\Psi}\sum_{y=0}^{N_c}(1-p_{rx}),p_{rx}^{y},p_{tx}^{k_y}\leq0$$ so $P_{crash}$ is non-increasing, and strictly decreasing when $p_{tx}>0$. If $p_{tx}=0$ it can be flat on some intervals, and $B_{min}$ is the smallest budget that meets the target. Since $P_{crash}=1$ for $B\leq0$ and $P_{crash}\leq P_{high}\to0$, the Intermediate Value Theorem gives $B_{min}$, and $P_{crash}(B)\leq P_{target}$ exactly when $B\geq B_{min}$. So $S_{smart}=S(B_{min})$ is the lowest threshold that meets the target.

---

Ordering: for $B<B_{low}$, $P_{crash}\geq P_{low}=\mathcal L(B-\psi_\min)>P_{target}$, since $B-\psi_\min<b^_$. So $B_{min}\geq B_{low}$. At $B=B_{high}$, $P_{crash}\leq P_{high}=\mathcal L(b^_)\leq P_{target}$, so $B_{min}\leq B_{high}$. This gives $S_{low}\leq S_{smart}\leq S_{high}$. Since $\psi_\min\leq\bar\psi\leq\psi_\max$, the budget of $S'$ also lies between the other two. $$\endproof$$
