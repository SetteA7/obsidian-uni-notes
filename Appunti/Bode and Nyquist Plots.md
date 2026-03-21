# 1) Bode Diagram
The **Bode diagram** is a useful tool to represent a frequency response in a graph using a pwl (piecewise linear) model that asymptotically approximates the real plot . There are two types of plots, the **amplitude** and the **phase** plot, both in logarithmic scale.

#### Why $\log$ scale?
We know that $W(jw)$ can be represented in trigonometric form as $W(jw)= |W(jw)|e^{j\cdot\text{arg}(W(jw))}$. The, using the neperian complex logarithmic we end up with an expression of form $a+jb$:
$$
\ln(W(jw))=\ln\left(|W(jw)|\right)+\ln\left(e^{j\cdot\text{arg}(W(jw))}\right)=\ln\left(|W(jw)|\right)+j\cdot\text{arg}\left(W(jw)\right)
$$
Moreover we use the **bilogarithmic scale**, that is: $20\log_{10}()$

Recall how a transfer function is usually expressed:
$$
W(s)=\frac{n(s)}{d(s)}=\frac{\displaystyle\sum_{m=0}^{\text{deg(n(s))}} b_ms^m}{\displaystyle\sum_{n=0}^{\text{deg(d(s))}} a_ns^n}
$$
which can be rewritten as
$$
W(s)=\frac{b_m}{a_n}\frac{(s-z_1)...(s-z_m)}{(s-p_1)...(s-p_2)}
$$
With some more algebraic manipulation, and by considering the *Fourier transform* (i.e. the phase representation) it is possible to show that **constant terms, zeroes, poles (real and complex)** give different types of contribution to the bode plot, but all these **contributions are additive**

>[!rmk|*] Electronics
>In electronics we will have that $\frac{b_m}{a_n}=(\frac{\omega_0}{s})^r\tag{}$ which includes the $r$ poles in zero and has $(\omega_0)^r=(\frac{b_m}{a_n})^r$

From now on $\log_{10}$ will be simply referred as $\log$

>[!rmk|*] Semilog scale vs log scale
>Wolfram alpha, and many other representations are in **semilogarithmic scale**. The x axis is in $w$, not $\log w$.
>
>Notice that in log scale the slope becomes $[dB/\text{decade}^2]\stackrel{\text{log scale}}{\rightarrow}[dB/\text{decade}]$.
>
>I will write all results in semilog scale. However the plots are in semilogarithmic scale in order to show more of the graph

## 1.2) Constant Term
The first term ($K_B$) is called **Evans gain** and it is important since it is constant, and it also **determines the gain/attenuation**. A simple way to find it is by finding the **DC/Static gain**:

>[!def] DC/Static Gain
>Given a transfer function $W(s)$ with no pole in the origin, we define it's gain as the value in $W(0)=K_{B}$, Then we can group this term in the expression.
>
>This can also be extended to the case with some poles in the origin, by just ignoring the term $\frac{w_{0}}{s}$ in the calculation

Suppose we have
$$
W(s)=K_B
$$
##### Amplitude Plot
It is just a straight line of form $y=20\log|K_B|$
If $|K_B|>1$ we have a gain in the output, otherwise we have an attenuation

##### Phase Plot
Since $K_B\in\mathbb R$ we have that if $K_B>0$ the phase is null, otherwise it is $\pm 180^\circ$ it doesn't matter which one

![[Pasted image 20241120123659.png|Bode diagram of W(s)=-3|450]]
## 1.3) Pole in Origin
Suppose we have 
$$
W(s)=\frac1{s^v}
$$
where $v$ is the degree which coincides with the amount of poles in the origin.
##### Amplitude plot
The transfer function will be $|W(jw)|_{dB}=-20v\log w$

This means that the resulting plot will be a line passing trough the origin $[0,0]$ and it will:
- $v>0$ go downwards with slope $-20 |v| [dB/\text{decade}]$
- $v<0$ go upwards with slope $20 |v| [dB/\text{decade}]$

##### Phase Plot
The transfer function will be $\arg(W(jw))=-v\cdot90^\circ$.

This means that the resulting line will be of form $y=\mp90^\circ$
- $v>0\implies -|v|90^\circ$ 
- $v<0\implies |v|90^\circ$

![[Pasted image 20241120140348.png|Bode plot of W(s)=1/s|450]]

>[!rmk|*]
>A zero in the origin is the equivalent of a pole in the origin, just with different exponential term


>[!corollary] Pole in Zero with Gain
>As explained before in electronics we will have $(\frac{\omega_0}{s})^r\tag{}$ as the first term which includes the $r$ poles in zero and has $(\omega_0)^r=(K_B)^r$. 
>
>This is actually useful since you can draw just **one line with the contribution of the zero and constant term included**. 
>If we have poles in the origin ($r>0$) this line has negative slope ($-20|r|[{dB}/{\text{decade}}]$) and will pass trough $[|r|\log w_0,0]$.
>Otherwise, if there are zeros in the origin ($r<0$) the line has positive slope ($20|r|[{dB}/{\text{decade}}]$) and will still pass trough $[|r|\log w_0,0]$.
>
>Notice that the lines change sign in the slope and it would suggest that the intersection points would also be switched, but $w_{0}$ becomes it's reciprocal with $r<0$ and thus the effects cancel out.
>
>The phase plot depends on the sign of $(w_0)^r$.
>If it is positive it will give zero contribution to the phase and thus the phase plot will be identical to the case of a pole in the origin. 
>Otherwise, the phase will be shifted by a factor of $180^\circ$.

## 1.4) Real Poles and Zeroes
Suppose we have 
$$
W(s)=(1+sT)^\mu
$$

This is valid for zeroes if $\mu>0$, otherwise it is valid for poles, and $|\mu|$ is the number of poles/zeroes. Both cases are centered in $-1/T$, then we end up with:
$$\begin{align}
&\log|W(jw)|=\mu\log\sqrt{1+(wT)^2} \\
&\arg(W(jw))=\mu\arctan(wT)
\end{align}$$
$$ $$
>[!def] Cutoff frequency
>We define the **cutoff frequency** as $$w_c=\frac1{|T|}$$ This frequency is the minimum required frequency to not have a 0 in the Bode diagram approximation
>
>We can rewrite all the poles and zeroes as $s-p\rightarrow1+\frac{s}{p}\rightarrow1+Ts=1+\frac s{w_c}$
>I will write the results according to $w_c$

Here we see the first implementation of the pwl model, since we will consider the following 2 approximations: $|wT|<<1$, $|wT|>>1$ $\implies$ $w<<1/|T|$, $w>>1/|T|$.
Then we have the two cases:
- $w<<w_c$

$$
\begin{align}
&\log|W(jw)|\approx\mu\log1=0 \\
&\arg(W(jw))\approx\mu\arg1=0^\circ
\end{align}
$$

- $w>>w_c$

$$
\begin{align}
&\log|W(jw)|\approx\mu\log wT=\mu(\log w+\log T)\\
&\arg(W(jw))\approx\mu\arg1=\mu\cdot\text{sign}(T)\cdot90^\circ
\end{align}
$$

From here it is clear that **real zeroes and poles behave in the same way, but with inverted sign**.

##### Amplitude plot
It will be $y=0$ until point $[\log w_c,0]$ (cutoff frequency) on the x-axis, then it will be a line going upwards (zero) or downwards (pole) with slope $\pm20 |\mu|[dB/\text{decade}]$.

>[!rmk|*] Zero in origin
>From here we can see that usually the slope goes upwards for zeroes, and downwards for poles. You can also apply this reasoning for Zeroes and Poles in the origin.

##### Phase Plot
The phase will be 0 until point $[\log (w_c) -1 ,0]$, then it will be a straight line connecting to the point $[\log(w_c)+1,\pm|\mu|\cdot90^\circ]$ if it is zero or pole. 
>[!col]
![[Pasted image 20241120123345.png|Bode diagram of W(s)=1+0,1s|300]]
>
>![[Pasted image 20241120123445.png|Bode diagram of W(s)=(1+0,1s)^-1|300]]

The phase plot has a wrong approximation, but from the real curve it is evident how the slope should be
## 1.5) Complex Conjugate Poles and Zeroes
Suppose we have 
$$
W(s)=\left(1+2\epsilon\frac{s}{w_n}+(\frac{s}{w_n})^2\right)^\mu
$$
Now we have:
$$\begin{align}
|W(jw)|_{dB}&=&10\mu\log\left[\left(1-\left(\frac{w}{w_n}\right)^2\right)+\left(2\epsilon\frac w{w_n}\right)^2\right] \\

\arg(W(jw))&=&\begin{cases}
\arctan\left(\frac{2\epsilon\frac{w}{w_n}}{1-\frac{w^2}{w_n^2}}\right), \ &w<w_n \\

\text{sign}(\epsilon)\cdot\frac\pi2, \ &w=w_n \\

\arctan\left(\frac{2\epsilon\frac{w}{w_n}}{1-\frac{w^2}{w_n^2}}\right)+\text{sign}(\epsilon)\cdot\pi, \ &w>w_n
\end{cases}
\end{align}$$

Now we can find the asymptotic approximations for $w<<w_n$, $w>>w_n$:
- $w<<w_n$

$$\begin{align}
&\log|W(jw)|\approx\mu\log 1=0 \\
&\arg(W(jw))=\mu \arg 1 =0^\circ
\end{align}
$$
- $w>>w_n$

$$\begin{align}
&\log|W(jw)|\approx2\mu\log(\frac{w}{w_n})=2\mu(\log w-\log w_n) \\
&\arg(W(jw))=\mu \cdot\text{sign}(\epsilon)\cdot\pi =\mu \cdot\text{sign}(\epsilon)\cdot180^\circ
\end{align}
$$
So we have find another case of **cutoff**.

Again we have that $\mu$ shows the number of poles or zeroes

##### Amplitude Plot
It will be zero until $[\log w_n,0]$, then it will be a line going upwards (zero) or downwards (pole) with slope $\pm40 |\mu|[dB/\text{decade}]$.
##### Phase Plot
The phase will be 0 until point $[\log (w_c) -1 ,0]$, then it will be a straight line connecting to the point $[\log(w_c)+1,\pm |\mu|\cdot180^\circ]$ if it is zero or pole.

![[Pasted image 20241120140000.png|Bode plot of W(s)=s^2+1.9s+1|450]]
Here the approximation of the phase is correct. Moreover in the example we have $w_n=1,\ \epsilon=0.95,\ \mu = 1$
## 1.6) How to Draw a Bode Diagram With Multiples Zeroes and Poles
It's actually pretty easy by recalling the **additive** property that was given at the start

##### Amplitude Plot
1) Draw every single line corresponding to every zero/pole/constant term
2) In the resulting plot, every point will have a slope corresponding to the sum of the slopes of every line in that point
3) add the constant value gain/attenuation

>[!example|*]
>This is a very dumb example, but consider
>$$W(s)=\frac{1-s}{1-s}$$
>This is clearly 1. And the bode plot will be a straight line of form $y=0$. But suppose we are a dumb student who doesn't notice this and applies every rule.
>1) Zero in 1, that means it gives 0 contribution until $[1,0]$ and then rises with slope $+20 [dB/\text{decade}^2]$ 
>2) Pole in 1, that is 0 contribution until $[1,0]$ and then goes downwards with slope $-20 [dB/\text{decade}^2]$ 
>3) Until $[1,0]$ there is no contribution, then after that point the 2 contributions are $\pm20[dB/\text{decade}^2]$ and thus $20-20=0[dB/\text{decade}^2]$
>
>Applying the rules gives the same result of the "direct" computation $\boxed{}$

##### Phase Plot

1) Draw every single line corresponding to every zero/pole/constant term
2) In the resulting plot, every point will have a slope corresponding to the sum of the slopes of every line in that point
3) When the phase has a constant attribution add\subtract it

# 2) Nyquist Diagram

>[!todo]
Sulla base di queste considerazioni si potrebbe costruire punto per punto il dia-
gramma di Nyquist a partire dal diagramma di Bode. Nella realtà, tuttavia, spesso
ci si accontenta di una conversione molto più grossolana? che tenga unicamente conto
del fatto che, al crescere di w da 0 a +oo, fase e ampiezza crescano oppure decrescano
(si noti che alla crescita/decrescita della fase nel diagramma di Bode corrisponde
una rotazione in verso antiorario/orario nel diagramma di Nyquist)

