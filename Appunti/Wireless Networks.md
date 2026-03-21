[Book](https://www.amazon.it/Wireless-Communication-GOLDSMITH-ANDREA/dp/0521704162/ref=sr_1_1?__mk_it_IT=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=1W53BXYJ9BDMY&dib=eyJ2IjoiMSJ9.WKLUx_wTpEiaNBuyXZBMO-HlbD8Ka_hG60hCAKJGr3U.AQ2-o3u7xHBgVXYYVaW9vqdSV-Ebxvt0mNzqLfztXWM&dib_tag=se&keywords=andrea+goldsmith+%E2%80%A2+wireless+communication&qid=1759146473&sprefix=andrea+goldsmith+wireless+communications%2Caps%2C243&sr=8-1)
# 1) Physical Layer: Wireless Channel Modes
Before we just studied the standard path loss channel attenuation model, however new phenomena will change this value. The new effects will cause an oscillation around the main PL avg power:
## 1.1) Recap
#### Decibel
$$P[dBW]=10\logt(\frac{P[W]}{1[W]})$$
$$P[dBm]=10\logt(\frac{P[W]}{1[mW]})=P[dBW]+30$$

#### Channel Equivalent Low Pass Model
$$ $$
![[Pasted image 20251008105834.png|Channel Mode|350]]
This shows that the lowpass output is represented by the TX signal as:
$$s(t)=\Re\curly{u(t)e^{j2\pi f_c t}}$$
where $u(t)=x(t)+j(t)$ is a complex baseband signal and therefore the tx signal becomes
$$\begin{align}
s(t)&=\Re\curly{(x+jy)(\cos+j\sin)}=\Re\curly{x\cos-y\sin+j(x\sin+y\cos)}\\
&=x(t)\cos(2\pi f_c t)-y(t)\sin(2\pi f_c t)
\end{align}$$
The received signal is represented as
$$r(t)=\Re\curly{v(t)e^{j2\pi f_c t}}$$

Supposing to know $h(t)$ to be a linear filter $h(t)=ae^{j\Delta}\delta(t-\tau)$, then:
$$v(t)=\int_{-\infty}^tu(t-\xi)h(\xi)d\xi$$

is the convolution with $u(t)$ that has support in $[0,\infty)$.
$$v(t)=\int_{-\infty}^\infty u(t-\xi)h(\xi)d\xi=ae^{j\Delta}u(t-\tau)$$
the scaling, phase and time shifts can all be reversed$\implies$**distortion free channel!**
$$h(t)=ae^{j\Delta}\delta(t-\tau)\fourier H(f)=ae^{j\Delta}e^{-j2\pi f\tau}$$
and thus $$|H(f)|=a\quad \angle H(f)=\Delta - 2\pi f\tau$$
We want constant modulus and linear phase in the whole band of the signal (not possible in real systems).

#### Doppler Effect
**Doppler Effect:**
![[Pasted image 20251001125300.png|Doppler|250]]
Due to the movement, the path will be different
$$\Delta d = v\Delta t\cos(\theta)$$
And the doppler phase/frequency are
$$\frac{\Delta \phi}{2\pi}=\frac{\Delta d}{\lambda}\rightarrow
\begin{align}
&\Delta\phi=2\pi v\Delta t\cos(\theta)/\lambda\\
&f_D=\frac{v\cos(\theta)}\lambda
\end{align}$$
The **doppler frequency** ($f_D$) will be added to the carrier frequency and impacts the performance.

#### Path Loss
Transmit $s(t)$ with power $P_t$ and $r(t)$ the received signal with the avg power of $P_r$
$$P_L=P_t/P_r\rightarrow 10\logt(P_L) \ [dB]$$
In free space 
$$\frac1{P_L}=\frac{P_r}{P_t}=\left(\frac{\sqrt{G_l}\lambda}{4\pi d}\right)^2\rightarrow P_L [dB]=-10\logt\par{\frac{G_l\lambda^2}{(4\pi d)^2}}$$
Thus the power falls off proportional to $1/d^2$.

In dBm the received power can be written as
$$P_r[dBm]=P_t[dBm]+10\logt(G_l)+20\logt(\lambda)-20\logt(4\pi)-20\logt(d)$$
>[!example|*]
>![[Pasted image 20251009130514.png|Text|550]]
>First recall that directional antennas have $G_l=1$
>By inverting the formula we obtain
>$$P_t=P_r\left[\frac{4\pi d}{\lambda}\right]^2=P_r\left[\frac{4\pi d f}{c}\right]^2=
\begin{cases}
1.45 \ W\rightarrow 1.61\ dBW &f=900 \ Hz\\
43.9 \ kW\rightarrow16.42 \ dBW & f=5 \ GHz
\end{cases}$$

## 1.2) Preliminaries

#### Empirical Path Loss Models
- **Okamure Model**
This model adjusts PL with empirical data
- **Piecewise Linear (Multi Slope) Model**
This model gathers empirical data and then uses a number $N$ of different slopes to better approximate the curve, form here we have $N-1$ breakpoints at distances $d_j, \ j\in \{1,...,N-1\}$

![[Pasted image 20251008110837.png|Example (y axis is Pr dB)|350]]
In this case $$P_r \db=\begin{cases}
P_t+K-10\gamma_1\logt(d/d_0) &d_0\leq d\leq d_c\\
P_t+K-10\gamma_1\logt(d_c/d_0)-10\gamma_2\logt(d/d_c) & d>d_c
\end{cases}$$
Where K and $d_c$ are obtained via regression to fit empirical data.

A single model is difficult to obtain, therefore we use a **simplified path loss model**:
- Set K as the free space gain:
$$\boxed{K\db=20\logt\par{\frac{\lambda}{4\pi d_0}}}$$
- $$\boxed{P_r=P_tK(d_0/d)^\lambda\rightarrow P_r\dbm=P_t\dbm+K\db-10\gamma\logt(d/d_0)}$$
- And $d_0$ is usually given as an empirical approximation

>[!example|*]
>![[Pasted image 20251009132703.png|Text|500]]
>![[Pasted image 20251009132716.png|Table|250]]
>Recall from the model that
>$$K=20\logt\frac{c}{4\pi f d_0}=-31.54 \db$$
>and the model has the fomula:
>$$M_{model}(d_i)=K-10\logt d_i \db$$
>The MSE is obtained by
>$$MSE=\frac15\sum_{i=1}^5\par{M_{meas}(d_i)-M_{model}(d_i)}^2=\frac15 (1571.47\gamma^2-11659.9\gamma+a)$$
>The minimization is solved by analyzing the function:
>$$MSE'=\frac15(3142.94\gamma-11654.9)=0\rightarrow\gamma^*=3.71$$
>This is a minimum since $MSE''=\frac15 3142.94>0$. Moreover the term $\frac15$ can be neglected.
>Finally, put the data in the formula
>$$P_r=0-31.54-10\cdot 3.71\logt(150)=-112.27\dbm$$

#### Shadowing
The shadowing can be modeled as a Gaussian Process with zero mean since the free space path loss accounts for the mean and the shadowing varies around that.

$$g(t)[dB]=\sigma_{SH}\cdot g_{SH}(t)[dB]+g_{PL}[dB]$$

The shadowing is a log-normal distribution, that is
$$\psi=\frac{P_t}{P_r}\def\alpha(t)^2$$
where $\alpha(t)^2$ is **the attenuation on the power** and it's sqrt the signal amplitude
It can be shown that it is gaussian distributed:
$$p(\psi_\db)=\frac1{\sqrt{2\pi\sigma^2_{\psi_\db}}}\exp{-\frac{(\psi_\db-\mu_{\psi_\db})^2}{2\sigma^2_{\psi_\db}}}$$
where $\mu_{\psi_\db}$ and  $\sigma_{\psi_\db}$ are the mean and std of $\psi_\db=10\logt\psi$ (in dB) respectively

Proof:
define as log-normal distributed
$$p(\psi)=\frac{10/\ln 10}{\psi\sqrt{2\pi\sigma^2_{\psi_{dB}}}}\exp{-\frac{(10\logt\psi-\mu_{\psi_{dB}})^2}{2\sigma^2_{\psi_{dB}}}}$$
Now transform it in dB by 
$$\psi_\db=10\logt\psi\rightarrow|J|=\frac{\partial\psi}{\partial\psi_\db}=\frac{\psi\ln10}{10}$$
By replacing and multiplying by the Jacobian we obtain the PDF in log domain
$\begin{flalign} &&\square \end{flalign}$

>[!exercise|*]
>$$\text{From the previous exercise now also find } \sigma_{\psi_\db}^2$$
>This is straight forward as it is sufficient to find the MSE:
>$$MSE=\frac15\sum_{i=1}^5(M_{meas}(d_i)-M_{model}(d_i))^2=13.29\db$$

In the **combined path loss+shadowing** we suppose that the shadowing produces variance around the path loss. Therefore we can set it as  **a gaussian distribution with 0 mean and variance** $\mathbf{\sigma^2_{\psi_\db}}$
And thus
$$P_r\db=P_t\db+10\logt K-10\logt(d/d_0)+\psi_\db$$
usually we have: $\mu = 0, \ K=-31.54\db, \ \gamma=3.71, \ \sigma=13.29\db$

From here we can compute the outage:
>[!def] Outage
>The outage is the probability for which the received power is lower than a threshold $P_\min$ 
>$$P_{outage}=p_{out}(P_\min,d)=\text{Prob}(P_r(d)<P_\min)$$
>Which becomes
>$$P_{outage}=1-Q\par{\frac{P_\min-(P_t\db+K\db-10\gamma\logt(d/d_0))}{\sigma_{\psi_\db}}}$$

Proof
From the definition we can rewrite it in the following way:
$$\begin{align}
P_{outage}&=1-P(P_r\geq P_\min)\\
&=1-P(P_t\db)+K\db-10\gamma\logt(d/d_0)+\psi_\db\geq P_\min\\
&=1-P(\psi_\db\geq P_\min-(a))
\end{align}$$
Since $\psi_\db$ is gaussian distributed we can use the tail function $P(X\geq a)=Q(a/\sigma)$ and the proof is complete.

$\endproof$

## 1.3) Multi-Path Fading
In real scenarios Line of Sight (LoS) is not present and the signals arrive by reflections and scattering, that is, from many directions, with different delays ($\tau_n$) and with longer lengths ($l_n$)

The final signal at the receiver can be summarized as a sum of multiple signals:
$$\begin{align}
&r(t)=\Re\{r'(t)e^{j2\pi f_ct}\}\\
&r'(t)=\sum_{N=1}^{N(t)}\alpha_n(t)e^{-j\phi_n(t)}u(t-\tau_n(t))\\
&\phi_n\def2\pi f_c\tau_n-2\pi\int_0^t \frac{v(x)}{\lambda}\cos(\theta_n(x))dx\def2\pi f_c\tau_n-\phi_{D_n}(t)
\end{align}$$
Where $\phi_D$ is the doppler frequency. With a constant speed and angle (approximation for $t\rightarrow 0^+$) we have 
$$\phi_n(t)=2\pi f_c\tau_n-2\pi\frac v\lambda\cos(\theta_n)t$$
>[!example|*]
>Let $f=1 \ GHz$, then at a traveled distance of $d=100 \ m$ we have:
>$$\begin{align}
&\tau_n=\frac dc=0.33 \ \mu s\\
&\theta_n=2\pi f\tau_n=120 \deg
\end{align}$$
>Let's focus on a longer path of $d=110 \ m$
>$$\begin{align}
&\tau_n=\frac dc=0.36 \ \mu s&\approx\tau_{n,{d=100}}\\
&\theta_n=2\pi f\tau_n=240 \deg & = 2\theta_{n,d=100}
\end{align}$$
>Now let $f=20 \ GHz$ and $d=100 m$
>$$\begin{align}
&\tau_n=\frac dc=0.33333 \ \mu s\\
&\theta_n=2\pi f\tau_n=240 \deg
\end{align}$$
At $d=101 \ m$ the delay is roughly the same but the phase $120\deg$.

From the above example it is clear that a slight variation in distance corresponds to a slight difference in delay, but a noticable difference in phase, therefore **the phase component cannot be simplified**

>[!claim]
>The low pass channel can be modeled with an LTI filter with impulse response
>$$g(t,\tau)=\sum_{n=1}^{N(t)}\alpha_n(t)e^{-j\phi_n(t)}\delta(\tau-\tau_{n}(t))$$

Proof
The proof is very straightforward, just convolve the impulse response and the signal, manipulate algebraically and then notice that the form is equivalent
![[Pasted image 20251009171513.png|Proof|450]]
$\endproof$

>[!def] Delay Spread
>The maximum delay between the multi path signal is called delay spread:
>$$\max_{i,j}|\tau_i(t)-\tau_j(t)|=\tau_m\def\text{Delay Spread}$$

Based on the delay spread we can distinguish two cases:
#### Narrowband (FLAT) Fading
$$ $$
>[!assumption|*]
>$$\tau_m\ll B_u^{-1}\approx T_s\implies\tau_i(t)\approx\tau_j(t)\approx\hat\tau \ \forall i,j$$

Now the impulse response can be written as
$$g(t,\tau)=\sum_{n=1}^{N(t)}\alpha_n(t)e^{-j\varphi_n(t)}\delta(\tau-\hat\tau)\def g(t)\delta(\tau-\hat\tau)$$
and the impulse response becomes of linear phase:
$$g(t,\tau)\fourier H(t,f)\def g(t)e^{-j2\pi f\hat\tau}=|g(t)|e^{j\angle g(t)}e^{-j2\pi f\hat\tau}$$
$$\begin{align}
&|H(t,f)|=|g(t)|\\
&\angle H(t,f)=\angle [g(t)]-2\pi f\hat\tau
\end{align}$$
Therefore **gain is constant across frequency and the estimation of g(t) suffices to compensate for phase and amplitude displacements**

#### Frequency Selective (Wideband) Fading
$$ $$
>[!assumption|*]
>$$\tau_m\gg B_u^{-1}\approx T_s$$

>[!col]
>The signals arrive with noticeable different delays and the strongest signals (usually shortest path) arrives with ISI of other (older) signals
>
>![[Pasted image 20251009113509.png|Example|250]]

## 1.4) Basic Statistical Model for the Fading Channels

#### 2D Isotropic Scattering (Narrowband)
$$r(t)=\Re\left\{\left[\sum_{n=1}^{N(t)}\alpha_n(t)e^{-j\phi_n(t)}\right]u[t-\hat\tau]e^{j2\pi f_c t}\right\}$$
Here we can recognize $g(t)$. By setting $N(t)=N$ (fixed) we can write the filter in it's real and imaginary components:
$$\begin{align}
g(t)=g_I(t)+jg_Q(t)=\sum_{n=1}^N\alpha_n(t)\big[\cos(-\phi_n(t))+j\sin(-\phi_n(t)\big]\\
=\sum_{n=1}^N\alpha_n(t)\big[\cos(\phi_n(t))-j\sin(\phi_n(t)\big]
\end{align}$$
#### Rayleigh Fading
By analyzing the expectation of the real part we have:
$$E[g_I(t)]=E\left[\sum_{n=1}^N\alpha_n(t)\cos(\phi_n(t))\right]=\sum_{n=1}^NE[\alpha_n(t)]E[\cos(\phi_n(t))]=0$$

When the phases are uniformly distributed in $[-\pi,\pi]$ (isotropic scattering) the **expectation of the cosine is 0**

Since many signals are received roughly at the same time, N is sufficiently large to use the **central limit theorem** and $X=g_I(t), Y=g_Q(t)$ are both gaussians with zero mean.

Being $G=X+jY$ it can be shown that 
$$Z=|G|=\sqrt{X^2+Y^2}\qquad p_Z(z)=\frac z{\sigma^2}\exp{-\frac{z^2}{2\sigma^2}} \qquad z\geq 0$$
Under these conditions we have
$$\boxed{\alpha(t)=Z=|g(t)|}$$
Now let's start the first order statistical description:
We want to find the **fading power** which is $|g(t)|^2=z^2\def \xi$
$$p_{\alpha^2}(\xi)=\frac{1}{2\sigma^2}\exp{-\frac{\xi}{2\sigma^2}}$$
Now let's **compare Link Budget vs SNR:**
$$P_{RX}(t)=\underbrace{\underbrace{P_{TX}}_{\substack{\text{avg trans}\\\text{power}}}\cdot\underbrace{g_{PL}}_{\substack{\text{gain of}\\\text{path loss}}}}_{\text{Average Received Power}}\cdot\underbrace{\alpha(t)^2}_{\substack{\text{gain of} \\ \text{fading channel}}}=P_{RX}^0\cdot \alpha(t)^2$$
The SNR is:
$$\gamma(t)=\frac{P_{RX}^0}{N_0B}\alpha(t)^2=\gamma_0\alpha(t)^2\longrightarrow \alpha(t)^2=\frac{\gamma(t)}{\gamma_0}\def\xi$$
and by recalling the PDF of the fading power, the PDF of the SNR becomes:
$$\boxed{p_\Gamma(\gamma)=\frac1{\gamma_0}\exp{-\frac\gamma{\gamma_0}}}$$
And the autocorrelation is:
$$E[g(t)g(t+\tau)]=PJ_0(2\pi f_m\tau)$$
where $$\begin{align}
&P=\sum_{n=1}^NE[\alpha_n^2]\\
&J_0(x)=\frac1\pi\int_0^\pi\cos(x\cos\theta)d\theta
\end{align}$$
$J_0$ is called the Bessel function of first type and order zero

The autocorrelation has zero at roughly $$f_m\tau=\frac{v\tau}\lambda=\frac l\lambda\approx \frac12$$
## 1.5) LL Error Models
First let's recap the **SNR**:
$$\gamma_0=\underbrace{\frac{P_{tx}G_{tx}}{A_{tx}}}_{\substack{\text{transmitter}\\\text{figure}}}\cdot\underbrace{\frac{G_{rx}}{A_{rx}}}_{\substack{\text{receiver}\\\text{figure}}}\cdot\frac1{kB}\cdot\underbrace{\frac{1}{P_L(d,\lambda)}}_{\substack{\text{channel}\\\text{gain}}}$$
where the first two terms are the **equivalent irradiated power (EIRP)** and $k$ the **boltzmann constant**. This is only the average SNR

>[!col]
>However, under fading, the average SNR isn't sufficient to do a performance analysis
>
>![[Pasted image 20251021155343.png|Example|350]]

>[!col]
Therefore we divide the time axis in slots of time $T$ equivalent to a PDU transmission time (constant) and we divide it in K states with K+1 thresholds.
>
>![[Pasted image 20251021155629.png|Example|350]]

Then, **markov chains** are used to analyze the probability to change state. For a Raleigh fading we have exponential PDF, the **the steady state probability to be in state k is**
$$\pi_k=\int_{\Gamma_k}^{\Gamma_k+1}f_R(\gamma)d\gamma=e^{-\frac{\Gamma_k}{\gamma_0}}-e^{-\frac{\Gamma_k+1}{\gamma_0}}$$
It can be shown that for a 2D isotropic rayleigh fading the **level crossing rate**, that is, the number of times the fading process crosses a set SNR level is
$$N(\Gamma_k)=\sqrt{\frac{2\pi\Gamma_k}{\gamma_0}}f_m\exp{\frac{-\Gamma_2}{\gamma_0}}$$
Now **assume** the following:
1. the **fading is slow with respect to T**, that is $f_mT\ll 1$ therefore the SNR is approx constant in each slot $\implies$ errors iid in each block
2. **equiprobable steady state probabilities** $\pi_i=\pi_j=1/K$ (Moayeri Model)

From 2 the thresholds can be set using this formula:
$$\begin{align}
&\Gamma_1=\gamma_0\log\par{\frac1{1-\pi_0}}=\gamma_0\log\par{\frac K{K-1}}\\
&\Gamma_k=\gamma_0\log\par{\frac1{e^{\displaystyle{-\Gamma_{k-1}}}-\pi_{k-1}}}=\gamma_0\log\par{\frac{K}{Ke^{\displaystyle{-\Gamma_{k-1}/\gamma_0}}-1}}
\end{align}$$
With 1 the simples method to solve the SNR problem is with the following:
$$\begin{gather}
&P_{i,j}=0\text{ if } |i-j|>1 \\
&P_{k,k+1}\approx \frac{N(\Gamma_{k+1})T}{\pi_k}=KTN(\Gamma_{k+1})\\
&P_{k,k-1}\approx \frac{N(\Gamma_{k})}T{\pi_k}=KTN(\Gamma_{k})\\
&P_{k,k}=1-P_{k,k+1}-P_{k,k-1}=1-KT(N(\Gamma_{k+1})+N(\Gamma_k)
\end{gather}$$
>[!thm] LL PDU Error Probability in state k
>$$ P_e(k)=\int_{\Gamma_k}^{\Gamma_{k+1}}\frac{f_R(\gamma)}{P[\Gamma_k\leq\gamma<\Gamma_{k+1}]}P_{PDU}(\gamma)d\gamma$$
>Where $P_{PDU}=1-(1-P_{bit}(\gamma))^{l_{PDU}}$ is the  probability to have at least one wrong bit in the PDU

^dc862d

Quick recap on probability theory: An integral acts as a weighted average when used with a probability density function (this is the expected value!!!). This next example shows the probability theory approach on how to derive the formula:

>[!example|*] 2-State Markov Model
>In this scenario we only have two states on the markov chain and the regions are called Good (G) and Bad (B) divided by the threshold $\gamma_{th}$
>
>Now the bit error probability in state G is directly found by recalling [[#^dc862d]].
>$$\begin{align}
P_{eG}&=P\curly{\text{PDU is erroneous | Mc in state G}}\\
&=P\curly{\text{PDU wrong | }\gamma\geq\gamma_{th}}\\
&=\int_{\gamma_{th}}^{\infty}\frac{f_R(x)}{P\curly{\gamma\geq\gamma_{th}}}\sq{1-(1-P_{bit}(x))^{l_{PDU}}}dx
\end{align}$$
>Same for $P_{eB}$ just with $\int_0^{\gamma_{th}}$
>The probability is the CDF of a complex rv, that is 
$$P_R[a<\gamma<b]=e^{-\frac{a}{\gamma_0}}-e^{-\frac{b}{\gamma_0}}$$
>We can set the $\gamma_{th}$ in order to have equiprobable steady state probabilities $\pi_G=\pi_B=\frac12$
>$$\frac12=P_R[\gamma\geq\gamma_{th}]=e^{-\frac{\gamma_{th}}{\gamma_0}}\rightarrow \gamma_0\log(2)$$

# 2) ARQ vs HARQ
HARQ is a ARQ that also implements coding. In fact, each segment of the packet will be encoded. Let's start with a recap of coding theory.

The **encoder** encodes a input $x$ of length $k$ into an output $y$ of $n$ bits. The code rate is the percentile of the og message that gets delivered every $T$, that is: $r_c=k/n$. There are exactly $2^k$ valid codewords, one for each input message, but encoded messages live in a bigger space, that is $2^n$. The **hamming distance** is the number of different bits between two messages.
$$\begin{align}
&\underbrace{y}_{n\times1}=\underbrace{G}_{n\times k}\cdot\underbrace{x}_{k\times 1}\\
&\text{Code Rate: }r_c=k/n\\
&\underbrace{2^n}_{\substack{\text{encoded}\\\text{messages}}}-\underbrace{2^k}_{\substack{\text{valid}\\\text{messages}}}=\text{additional strings}\\
&\text{Hamming Distance: }d(y,z)=\sum_{i=0}^{n-1}y_i\otimes z_i
\end{align}$$
In this course we consider **Reed Salomon (RS) codes** which has the following properties
$$\begin{align}
&\text{Minimum Codeword Distance: }d_{min}=N-K+1\\
&\text{Error Correction Capability: } t=\floor{\frac{d_{min}-1}{2}}=\floor{\frac{N-K}{2}} 
\end{align}$$
Under IID assumptions we have that
$$\begin{align}
&\text{Symbol Error Probability: } P_S=1-(1-P_{bit})^b\\
&\text{Decoder Error Probability: } P_T=\sum_{i=t+1}^N\binom{N}{i}P_S^i(1-P_s)^{N-i} \text{ (more than t symbols are wrong)}\\
&\text{Total Error Probability: } P_T=P_E+P_F\\
&P_E\text{ Upper Bound: } P_e\leq P_T\sum_{i=0}^t\binom{N}{i}(2^b-1)^{i-(n-K)}
\end{align}$$
We also use **BCH** codes for the header
$$\begin{align}
\text{Error Correction Capability: } t=\ceil{\frac{d_{min}-1}{8}}=\ceil{\frac{N-K}{8}} \\
\text{Header Error Probability: }P_h=\sum_{e=t+1}^n\binom{n}{e}P_{bit}^e(1-P_{bit})^{n-1}
\end{align}$$

We also consider the difference between two types of error cases:
- **Bursty Errors (Best Case):** all bits are wrong, therefore all of them can be corrected
- **IID Errors (Worst Case):** only t bits can be corrected

![[Pasted image 20251029093813.png|Packet Fragmentation|550]]
Here are the assumptions:
- **Header** uses BCH coding (only iid errors), more performant
- **Data Segments** use RS coding
- Each segment is one codeword
- The last Segment includes CRC check

We can identify 3 cases:
- **Correct Decoding:** The codeword is correctly decoded into the original message. (errors $\leq t$)
- **F error, Decoding Failure:** The codeword is corrupted and no valid codeword is found (errors > t)
- **E error, Decoding Error:** The codeword is decoded into the wrong message (errors < t, d(C,C')>t)

The **E error cannot be detected** by the RS codes, but only by the CRC. This means that it is not possible to identify the wrong segment, we only know that the packet is wrong, a full RETX is required.

![[Pasted image 20251029095650.png|LL Packet Detection Flow|450]]
Three types of HARQ are defined:
- **Type I:** One message (M=1)
- **Type II:** Many messages (M>1) and RETX packet if any segment has E or F errors
- **Type III:** Many messages (M>1) and REXT segment if F error, RETX packet if E error. It is possible that a RETX segment will contain an E error.

## 2.1) Throughput
First define: 
- **Average Number Of Transmitted Bits To Successful LL PDU Delivery:** $E[N_{tr}^i]$ (i is the scheme $i=1,2,3$)
- **Throughput:** $$\eta=\frac{\text{num of information bits in packet }}{E[N_{tr}^i]}$$

#### SR-ARQ
Now consider an **IDEAL SR-ARQ** with feedback after m time slots
![[Pasted image 20251029100508.png|SR_ARQ|450]]
The **avg number of transmissions needed** is:
$$E[N_{tx}]=1+pE[N_{tx}]+(1-p)\cdot 0\rightarrow E[N_{tx}]=\frac1{1-p}$$
Where 1 is the transmission of first PDU, then we need 0 retx if there is no error (1-p), but we need to **statistically restart the connection** if there is an error (p).

The packet error rate is
$$P_R^{no}=1-\underbracket{(1-P_h)}_{\text{header OK}}(1-P_b)^{\underbracket{MTU+CRC}_{\text{PDU size}}}$$
We also define two lengths:
- $L_{inf}$ = MTU+CRC-C (C is CRC+IP)
- $L_{pkt}$ = MTU+CRC+H+O (O is bits added at PHY)

And the number of bits transmitted on avg. is
$$E[N_{tr}^{no}]=L_{pkt}+P_R^{no}E[N_{tr}^{no}]\rightarrow E[N_{tr}^{no}]=\frac{L_{pkt}}{1-P_R^{no}}$$
and so we obtain the throughput as
$$\eta^{no}=\frac{L_{inf}}{E[N_{tr}^{no}]}=\frac{(MTU+CRC-C)(1-P_R^{no})}{L_{pkt}}$$
$$\eta_{SR-ARQ}=R\frac l{l+h}(1-P_{PDU})=R\frac l{l+h}(1-P_{bit})^{l+h}$$
#### HARQ-I
The packet error rate equals to the probability to retx, Moreover $L_{pkt}(\cdot)$ is the bits needed to TX a frame (HARQ-II, III tx different number of frames)
$$\begin{align}
&P_R^I=1-(1-P_h)(1-P_T)\\
&E[N_{tr}^I]=L_{pkt}(1)+P_R^IE[N_{tr}^I]\rightarrow E[N_{tr}^I]=\frac{L_{pkt}(1)}{1-P_R^I}\\
&\eta^I=\frac{Kb-C}{E[N_{tr}^I]}
\end{align}$$
>[!rmk|*]
>The number of bits to TX a frame is:
>$$L_{pkt}(M)=MNb+H+O$$

#### HARQ-II
Here we must also **account for the probability to get e errors and f failures among the M segments**
$$p_{e,f}(M)=\binom Me\binom{M-e}fP_E^eP_F^f(1-P_E-P_F)^{M-e-f}$$
$$\begin{align}
&P_R^I=1-(1-P_h)p_{0,0}(M)\\
&E[N_{tr}^{II}]=L_{pkt}(M)+P_R^{II}E[N_{tr}^{II}]\rightarrow E[N_{tr}^I]=\frac{L_{pkt}(M)}{1-P_R^{II}}\\
&\eta^I=\frac{MKb-C}{E[N_{tr}^I]}=\frac{(MKb-C)(1-P_R^{II})}{L_{pkt}(M)}
\end{align}$$
How do we find the **max PDU size?** Find how to maximiza the throughput ($B_{LL}$ is the bitrate at LL)
$$\eta(x)=B_{LL}\par{\frac{x-o}x}(1-P_b)^x$$
which results in
$$x=\frac{o+\sqrt{o^2-\frac{4o}{\log(1-P_b)}}}{2}$$
![[Pasted image 20251031154707.png|ARQ Performance|350]]
#### HARQ-III
We have 5 **mutually exclusive** cases
1) Wrong Header: RETX PDU
2) NO error (0 E, 0 F): END, no RETX
3) No decoding failure (e E, 0 F): RETX PDU
4) No decoding error (0 E, f F): RETX f segments, it is possible they contain E
5) Both errors (e E,f F): REXT f segments and then, if CRC fails again RETX 

$$\begin{align}
E[N_{tr}^{III}]=&\underbrace{L_{pkt}}_{\text{PDU bits}}+\par{\underbrace{P_h}_{\text{Case 1}}+(1-P_h)\underbrace{\sum_{e=1}^M p_{e,0}(M)}_{\text{Case 3}}}E[N_{tr}^{III}]+\\
+&(1-P_h)\underbrace{\par{\sum_{f=1}^M p_{0,f}(M)\par{A(f)+B(f)E[N_{tr}^III]}}}_{\text{Case 4}}+\\
+&\underbrace{\sum_{f=1}^{M-1}\sum_{e=1}^{M-f}p_{e,f}(M)(A(f)+E[N_{tr}^{III}])}_{\text{Case 5}}+\underbrace{(1-P_h)p_{0,0}(M)}_{\text{Case 2}}\cdot 0
\end{align}$$
Let
- $A(f)$ be the number of TX bits over LL until all f segments are sent correctly
- $B(f)$ be the probability that at least one segment has E error

In fact:
- Case 1: Header error$\rightarrow$ restart connection
- Case 2: No error, so stop process ($\cdot 0$)
- Case 3: Header is wrong ($1-P_h$) $\rightarrow$ restart connection with probability of 0 F errors
- Case 4: Header is wrong ($1-P_h$), for each probability of having 0 E errors and f F errors $A(f)$ bits are sent that have $B(f)$ probability to restart connection
- Case 5: first notice $B(f)=1$ since we are sure at least one E error happened. TODO

It is possible to rewrite it as:
$$E[N_{tr}^{III}]=\frac{\displaystyle L_{pkt}(M)+(1-P_h)\par{\sum_{f=1}^M\sum_{e=0}^{M-f}p_{e,f}(M)A(f)}}{\displaystyle(1-P_h)\par{1-\sum_{f=1}^M p_{0,f}(M)B(f)-\sum_{f=0}^{M-1}\sum_{e=1}^{M-f}p_{e,f}(M)}}$$
# 3) Exercises in Class

#### Warmup Exercise 1
Let a wireless link between a TX and a RX have following specifications:
- PDU Length at LL: $PDU_l$
- Bit Error Rate over Wireless Link: $P_b$
- Max # of TX per PDU: $L$
- Assume iid Errors
Find 1) the packet error rate of RX $P_{PDU}$ (between PHY and LL) and 2) the residual error rate at RX $P_{LL}$ (between LL and NET)

1) This is straight forward as $P_{PDU}=1-(1-P_b)^{PDU_l}$
2) A bit more cumbersome as we must find the probability that L TX are wrong. 
Let X be the rv that counts the # of consecutive unsuccessful TX, this is $X\sim\text{Geom}(P_{PDU})$
Then, we must find
$$\begin{align}
P[X\geq L]&=1-P[X< L]=1-\sum_{n=0}^{L-1} P[X=n]\\
&=1-\sum_{n=0}^{L-1}P_{PDU}^n(1-P_{PDU})=1-(1-P_{PDU})\frac{1-P_{PDU}^L}{1-P_{PDU}}\\
&=P_{PDU}^L
\end{align}$$

#### Warmup Exercise 2
Let a wireless link between a TX and a RX have following specifications:
- PDU Length at LL: $PDU_l$
- Bit Error Rate over Wireless Link: $P_b$
- Max # of TX per PDU: $L$
- Assume iid Errors
- **$PDU_l=H+PAY$ all known**
- **The TX time at LL: $t_F$** 
Find 1)  $B_{LL}^T, B_{LL}^I$, the bitrates at the LL for the total PDU and Information bits in the cases where $L\in\mathbb N$ and $L\rightarrow\infty$.

1) First Notice that $B_{LL}=\mathbb E[\text{data}]/\mathbb E[T]$
And define the following RV:
- X: rv that counts # of succesfull bits TXed
- Y: rv that counts # of successfull information bits TXed
- T: rv that counts tot time to send LL PDU

Notice that X and Y are similar, only with different amounts of size, therefore all results for X can be translated directly to Y by changing $PDU_l$ to $PDU_l-H$.

**First find $\mathbb E[X], \mathbb E[Y]$**
- In the case $L\in\mathbb N$ we have
Notice that X derives from a bernoulli rv $B\sim\text{Bernoulli}(P_{LL})$ and $X=PDU_lB$ where B states the probability to successfully TX a PDU in L tries.
$$\begin{align}
\mathbb E[X]&=PDU_l\cdot\mathbb E[B]=PDU_l\sum_{n=0}^1 b_iP_B(b_i)\\
&=PDU_l(0\cdot P_{LL}+1\cdot(1-P_{LL}))=PDU_l(1-P_{PDU}^L)
\end{align}$$
And for the information bits just $\mathbb E[Y]=(PDU_l-H)(1-P_{PDU}^L)$

- In the case $L\rightarrow\infty$ we have
The PDU clearly gets delivered sometimes and by logic it is clear that $\mathbb E[X]=PDU_l$.
It is also possible to find from the limit of the previous result $\lim_{L\rightarrow\infty} \mathbb E[X]=PDU_l(1-0)$.
The more formal approach is to recalculate $P_{LL}$ and redo the full calculations:
$$P_{LL}=1-(1-P_{PDU})\sum_{n=0}^\infty P_{PDU}^n=1-(1-P_{PDU})\frac{1}{1-P_{PDU}}=0$$
and thus $B\sim\text{Bernoulli}(0)$ and therefore $\mathbb E[X]=PDU_l, \mathbb E[Y]=PDU_l-H$.

**Now we must find $E[T]$ which is more cumbersome:**
- In the case $L\in\mathbb N$ we have
Now $T=t_FG_L+Lt_FB$ since with probability $P_{LL}$ it will not TX in L tries and therefore it will take time $Lt_F$. Moreover $G_L$ is $G\sim \text{Geom}(P_{PDU})$ that counts the number of tries until first success truncated at $L$ # of tries.
Now
$$\begin{align}
\mathbb E[T]&=t_F\mathbb E[G]+Lt_F\mathbb E[B]\\
&=t_F\sum_{0}^{L-1}(n+1)P_{PDU}^n(1-P_{PDU})+Lt_FP_{LL}\\
&=t_F\frac{1-(L+1)P_{PDU}^L+LP_{PDU}^{L+1}}{(1-P_{PDU})^2}(1-P_{PDU})+Lt_FP_{PDU}^L\\
&=t_F\par{\frac{1-(L+1)P_{PDU}^L+LP_{PDU}^{L+1}}{(1-P_{PDU})}+LP_{PDU}^L}
\end{align}$$

- In the case $L\rightarrow\infty$ we have
Again T derives from $T=t_FG$ with $G\sim\text{Geom}(P_{PDU})$ where G is the # of tries until first success
Now 
$$\begin{align}
\mathbb E[T]&=t_F\mathbb E[G]=t_F\sum_{n=0}^\infty (n+1)P_{PDU}^n(1-P_{PDU})\\
&=t_F(1-P_{PDU})\par{\sum nP_{PDU}^n+\sum P_{PDU}^n}\\
&=t_F(1-P_{PDU})\par{\frac{P_{PDU}}{(1-P_{PDU})^2}+\frac1{1-P_{PDU}}}\\
&=t_F\par{\frac{P_{PDU}}{1-P_{PDU}}+1}=\frac{t_F}{1-P_{PDU}}
\end{align}$$


If we take the limit of the finite case we have the result obtained above
$$\lim_{L\rightarrow\infty}\mathbb E[T]=\frac{t_F}{1-P_{PDU}}$$
>[!rmk|*] Two Geometric RV exist
>Two geometric rv exist based on what we count. We set $L$ as the amount of times the rv was run and $p$ the failure probability. 
>- **Count # of unsuccessful tries** $\in\curly{0,...,N}$
>$$P[G_{failures}=k]=p^k(1-p)\qquad \mathbb E=\sum_{n=0}^{L-1} np^n(1-p)\stackrel{L\rightarrow\infty}\longrightarrow\frac{p}{1-p}$$
>- **Count of tries needed until first success** $\in\curly{1,...,N}$
>$$P[G_{success}=k]=p^{k-1}(1-p)\qquad \mathbb E=\sum_{n=1}^L n p^{n-1}(1-p)$$
>alternatively it is also presented as
>$$ \mathbb E=\sum_{n=0}^{L-1} (n+1)p^n(1-p)\stackrel{L\rightarrow\infty}\longrightarrow\frac{1}{1-p}$$
>which is mathematically equivalent.
>For $L\rightarrow\infty$ we can define $G_{success}=G_{failures}+1$ and thus  $\mathbb E[G']=1+\mathbb E[G]$ 


# 4) TCP
From now on our default communication framework is
![[Pasted image 20251123171839.png|Communication framework|350]]
Where $RTT_2$ and $P_{TCP}^2$ are given.

Now recall the path loss model:
$$\begin{align}
P_L(d,\lambda)&=10\beta\logt(d)-20\logt\par{\frac{\lambda}{4\pi}} \ [dB]\\
&=21.98+10\beta\logt(d)-20\logt(\lambda)
\end{align}$$
with $\beta=3.6$
And the SNR is given by
$$p(\gamma)=\frac1{\gamma_0}e^{\gamma/\gamma_0}$$
Where $\gamma_0=P_{RX}^0/N_0B$ and $P_{RX}^0[dBW]=P_{TX}[dBW]-P_L[dB]$
## 4.1) SR-ARQ
#### Intro and Assumption Formulation
This part will study SR-ARQ at LL, knowing how a TCP packet is made.

First recall how both LL PDUs and TCP packets are made:
- At LL: $PDU_l=PDU_h+PDU_p$
- At TCP: $TCP_l=IP_h+TCP_h+TCP_p$

Moreover the rate at the LL is: 
$$R_{LL}=R_b\cdot R_c$$
where $R_b$ is the PHY nominal rate in bits/s, while $R_c$ is the coding rate, which is a pure number $<1$.

At LL we have the time slotted in frames of length $T$. Now we can state the assumptions:
>[!assumption] SR-ARQ
> - TCP packet TXed in a single LL frame
> - In a frame the channel is either in a Good or Bad state (MC)
> - Limit analysis on a single packet

The first assumption can be verified by defining the number of PDUs TXed in a single frame and the number of PDUs that compose a TCP packet.
- The amount of PDUs sent in a frame is:
$$n_{PDU}=\floor{\frac{n_b}{PDU_l}}=\floor{\frac{TR_bR_c}{PDU_l}}$$
- The number of PDUs that compose a TCP packet is:
$$n_{PDU}^T=\ceil{\frac{TCP_l}{PDU_l-PDU_h}}:=K$$
Then, we must have that
$$n_{PDU}^T\ll n_{PDU}$$

This means that a full TCP packet can be sent in a LL slot.

>[!example|*]
>Let $R_c=1/2, \ R_b=3 \ [Mbit/s], \ T= 10 [ms]$ and the packet with sizes $TCP_l=1500 \ [bytes]=12000 \ [bits], \ TCP_p=1460 \ [bytes]$, $PDU_l=350 \ [bits], \ PDU_h=16 \ [bits]$
>Then the amount of LL PDUs in a frame is
>$$n_{PDU}=\floor{\frac{TR_bR_c}{PDU_l}}=42 \ [PDU/Frame]$$
>And one single TCP packet is made of $n_{PDU}^T$ LL PDUs 
>$$n_{PDU}^T=\ceil{\frac{TCP_l}{PDU_l-PDU_h}}=36 \ [PDU/TCP]$$
>The assumption $n_{PDU}^T<n_{PDU}$ holds

Assumptions 2 and 3 can be summarized in the following image:


![[Pasted image 20251123164032.png|Example|350]]
We suppose that this uses a fully reliable ARQ, that is, with infinite attempts and therefore the TCP packet will be correctly TXed eventually. Moreover this can be expressed via an absorbing MC.

#### First Analysis
Now we can start the actual analysis:
First define the function 
$$\Psi(i,k,c)$$
that represents the probability that $k(\leq K)$ of the PDUs are still **unresolved** after $i$ rounds and that the channel in round $i (\in \mathbb N)$ is in state $c(\in\curly{G,B})$.

Now we approach this analysis **by induction**.
**Base Step:**
At the first round we have that:
$$\Psi(1,k,c)=\pi_c\binom{K}{k}P_{ec}^k(1-P_{ec}^{K-k})$$
Where $P_{ec}$ is the PDU error probability in state c.

**From $i-1$ to $i$** with $i>1$:
- Round $i-1$: We send $S$ PDUs while boing in state $c'$. The amount of unresolved packets is $r(\leq S)$
- Round $i$: We send $r$ packets and $k(\leq r)$ of those are lost. We are in state $c$. Moreover $r-k$ PDUs resolved between $i-1$ and $i$.

Now the formula becomes:
$$\Psi(i,k,c)=\sum_{c'\in\curly{B,G}}\sum_{r=k}^K \Psi(i-1,r,c')g(r-k,r,c)p_{c',c}$$
where $r-k$ is the amount of PDUs to resolve in this round
$$g(x,r,c)=\binom rxP_{ec}^{r-x}(1-P_{ec})^x\stackrel{x=r-k}=\binom rkP_{ec}^k(1-P_{ec})^{r-k}$$

#### Relax Fully Reliable and Find $P_{TCP}^1$
Now we **relax the fully reliable assumption** and set the goal to find the probability that the TCP packet is discarded $P_{TCP}^1$.
We define $M$ the maximum number of rounds available and $\eta$ the number of rounds to resolve all PDUs.
Therefore the problem reduces to finding $P[\eta>M]$.
We have that
$$P_{TCP}^1=P[\eta>M]=\sum_{c\in\curly{G,B}}\sum_{r=1}^K\Psi(M,r,c)$$
#### Find RTT
First notice that $P[\eta=n]=P[\eta>n-1]-P[\eta>n]$, from here we have
$$\begin{align}
\mathbb E[\eta|n_{tx}\leq M]&=\sum_{n=1}^MnP[\eta=n]+MP[\eta>n]\\
&=\sum_{n=1}^MnP[\eta=n]+MP_{TCP}^1
\end{align}$$
And finally $RTT^1=T\cdot\mathbb E[\eta|n_{tx}\leq M]$.

## 4.2) TCP Cubic
#### Standard TCP
In TCP Reno we have that each RTT the window size is increased by $a$ and the window is decreased by $1-b$ at each packet loss. The usual values are $(a,b)=(1,1/2)$.

Suppose that a packet loss occurs only when the window size reaches the channel capacity. And suppose we start the analysis then $W_{max}$ is reached and therefore $W_0=(1-b)W_\max$. Each round  $r$ the window is increased by $a$ and thus the number of rounds needed to reach capacity is:
$$W_\max=(1-b)W_\max+ar\rightarrow r=\frac ba W_\max$$
From here the total amount of RTT needed to reach capacity is $N=r+1$

Now it is also possible to find the number of packets sent in an entire cycle $N$.
$$S_{tot}=\sum_{i=0}^N\sq{(1-b)W_\max+a(i-1)}=(1-b)NW_\max+a\frac{N(N-1)}{2}$$
By expanding $N=\frac ba W_\max+1$ we obtain
$$S_{tot}=\frac{(2-b)b}{2a}W_\max^2+\frac{2-b}2W_\max$$

And the avg send rate per RTT is just the normalized version (recall $N=r+1=\frac baW_\max+1$)
$$S=\frac{S_{tot}}N=(1-b)W_{\max}+a\frac{\frac baW_\max}2=\par{\frac{2-b}b}W_\max$$
The goodput also normalizes this with RTT
$$G=\frac1{RTT}S=\frac{2-b}{2RTT}W_\max$$
Since by assumption we had one packet loss every $S_{tot}$ the packet loss probability can be approximated to
$$p=\frac1{NS}=...\approx\frac{2a}{b(2-b)W_\max^2}\rightarrow W_\max=\sqrt{\frac{2a}{b(2-b)p}}$$
Plugging this in to the good put we obtain
$$G\approx\frac1{RTT}\sqrt{\frac a2\frac{2-b}b\frac1p}$$
In the case of TCP Reno ($a,b=1,0.5$) we have
$$W_{Reno}\approx\sqrt{\frac8{3p}}\qquad G_{Reno}\approx\frac1{RTT}\sqrt{\frac32\frac1p}$$
Now it is essential to rewrite $a$ as a function of $b$. Using the goodput formula we obtain
$$a=\frac{3b}{2-b}$$

Now the window size as a function of time is achiavable
$$W_{TCP}(t)=(1-b)W_\max+\frac{3b}{2-b}\cdot\frac t{RTT}$$
The congestion window in Reno is reached after $\frac{W_\max}2RTT$.


However standard TCP doesn't use the actual time, but it uses the number of (cumulative) acks over the cwnd.
$$\begin{cases}
W_{TCP}\leftarrow (1-b)W_\max & \text{ on packet loss}\\
W_{TCP}\leftarrow W_{TCP}+\frac{3b}{2-b}\frac{\text{ack}}{\text{cwnd}} & \text{ on new ack}
\end{cases}$$
These are equivalent to the time expression. Set $t=0$ ($t\in\mathbb N$)when the packet loss is detected, then 
- $W(0)=(1-b)W_\max$
- $W(t+1)=W(t)+a\frac{ack}{cwnd}$
This is a recursive definition from which the formula as a function of $t\in R$ by extension:
$$\begin{align}
W(1)&=W(0)+a\frac1{cwnd}=(1-b)W_\max+a\frac1{cwnd}\\
W(2)&=W(1)+a\frac1{cwnd}=(1-b)W_\max+a\frac2{cwnd}\\
...\\
W(t)&=(1-b)W_\max+a\frac t{cwnd}
\end{align}$$
Where $cwnd=RTT$ since in each RTT are sent cwnd packets.

>[!todo] 
>full expression 

#### From Reno to Cubic
In reno, if the capacity is very high it takes a lot of time to reach it linearly, therefore cubic tries to solve it by having a **concave growth** until capacity, probing it and then have a convex growth.
The formula chosen was
$$W(t)=C(t-T)^3+W_\max$$
Where $T$ is a function of C (and b), therefore the only real parameters are C and b. Usually we have $C,b=0.4,0.2$

To mimic the packet loss in TCP reno we set $W(0)=(1-b)W_\max$ and thus
$$W(0)=(1-b)W_\max=-CT^3+W_\max\rightarrow \boxed{T=\sqrt[3]{\frac{W_{\max}b}{C}}}$$
In one RTT the cwnd is increased by $\Delta cwnd=W(t+RTT)-cwnd=W_{target}-cwnd$ and therefore at each RTT we obtain by
$$\begin{align}
cwnd_{\text{one ack}}&\leftarrow cwnd+\frac{W_{target}-cwnd}{cwnd}\\
cwnd_{\text{one RTT}}&\leftarrow cwnd+\frac{W_{target}-cwnd}{cwnd}cwnd\\
W(t+RTT)&\leftarrow W(t)+\frac{W_{target}-W(t)}{W(t)}\cdot W(t)=W_{target}
\end{align}$$
Notice how in Cubic we have that the congestion window is reached after $T$ time. This shows that in some cases $T>\frac{W_\max}2RTT$ where Cubic is therefore less performant than Reno. This is held in some cases, like
- Solution for W: $W<\sqrt{\frac{8b}{C\cdot RTT^3}}$
- Solution for RTT: $RTT<\sqrt[3]{\frac{8b}{C \cdot W^2}}$
- Solution for W,RTT: $W^2RTT^3<\frac{8b}C$

