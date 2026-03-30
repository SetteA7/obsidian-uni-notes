# 1) Quantization
The quantization is the processo of mapping a function $Q$ from $\mathbb R$ to a discrete set called *Dictionary.*
$$Q:x\in\mathbb R\rightarrow y\in C=\curly{\hat x_1,\hat x_2,...}\subset\mathbb R$$
where
- $C$ is the Dictionary a subset of $\mathbb R$
- $\hat x_i$ quantization level (code-word)
- $e=x-Q(x)$: The quantization noise (error)
- $\Theta_i=\curly{x:Q(x)=\hat x_i}$ the decision region. Defined as non intersecting intervals

Quantization can be seen as an encoding/decoding process:
take signal $x(n)$: the encoding step assigns each sample of $x(n)$ to a quantization level $i(n)$. The decoder associates to each quantization level $i(n)$ the corresponding code word (value).

**Performance criteria** are composed of **Rate** $R$ and **distortion** $D$.
By assumption $\boxed{R=\log_2 L}$, which is the 

- The rate $R$ is the avg number of bits needed to represent a sample. We define
$$\boxed{R=\log_2 L}$$
- The distortion $D$ is the MSE which in case of a random signal equals to the variance:
$$D=\E[|x(n)-Q(x(n))|^2]=\sigma_Q^2$$
## 1.1) Uniforma Quantization (UQ)
In uniforma quantizers the input range is divided into $L=2^b$ equal-sized cells with size $\Delta=A/L$. Each cell is represented by its mid-point i.e. the levels are the centers of the cells.
$$\begin{gather}
\forall i, \ \Delta^i=\Delta=A/L\\
t^i=t^{i-1}+\Delta\\
\hat x^i=\frac{t^i+t^{i-1}}2\\
\Theta^i=\par{\hat x^i-\frac\Delta2,\hat x^i+\frac\Delta2}
\end{gather}$$
#### Unsigned Data
In this case the data is in $(a,A)$ and the ceil function suffices. The thresholds are $(0,\Delta,2\Delta,...,L\Delta)$ and thus $t^i=(i-1)\Delta$.
$$\begin{align}
&\text{Encoder: }i=\ceil{\frac x2}\\
&\text{Decoder: }\hat x^i=i\Delta-\frac \Delta 2\\
&\implies Q(x)=\Delta\ceil{\frac x2}-\frac\Delta2
\end{align}$$
#### Unsigned Data
In this case the data is in $(-A/2,A/2)$ and the round function is used. Moreover since 0 must be a quantizer value not a threshold a **odd number of levels is required**
$$\begin{align}
&\text{Encoder: }i=\text{round}\par{\frac x2}\\
&\text{Decoder: }\hat x^i=i\Delta\\
&\implies Q(x)=\Delta\text{round}\par{\frac x2}
\end{align}$$
This is called a **mid-tread** quantizer which keeps near 0 values (noise) to 0.

## 1.2) Rate Distortion (RD) Curve
First recall the uniform distribution:
$$\mathcal X\sim u(a,b),\quad f_X(x)=\begin{cases}\frac1{b-a} &x\in[a,b]\\0&\text{elsewhere}\end{cases}, \quad\E[\mathcal X]=\frac{b-a}2,\quad\var(\mathcal X)=\frac{(b-a)^2}{12}$$
And the Law of the Unconscious Statistician (LOTUS):
$$E[g(x)]=\int g(x)f_X(x)dx$$

---

These allows to calculate the distortion of a uniform RV quantized with UQ:

Let $X\sim U\par{-\frac A2,\frac A2}$ and $Q(x)$ a UQ with $L$ levels. Then:
$$D=\sigma^2_Q=\E[(X-\hat X)^2]=\frac{\Delta^2}{12}=\frac1{12}\frac{A^2}{L^2}=\sigma^2_x2^{-2R}$$
$$SNR=10\logt\frac{\E[X^2]}{D}=10\logt2^{2R}\approx 6R$$

Proof:
todo calculation of interval
From here recall that $R=\log_2 L\rightarrow L=2^R$ and that since $X$ is uniform it has variance $A^2/12$ and thus $\frac{A^2}{12L^2}=\sigma^2_x/2^{2R}$.
The SNR is very straight forward: Notice $\E[X^2]=\sigma^2_x$ 

#### High Resolution (HR) Quantization
For high resolution we mean $L\rightarrow\infty$
For a region $\Theta^i$ the value $p_x$ is constant.
The quantization noise in $\Theta^i$ is $\sim u\par{-\frac{\Delta}{2},\frac{\Delta}{2}}$ and with the total probability law we have
$$E\sim u\par{-\frac{\Delta}{2},\frac{\Delta}{2}}\rightarrow D=\frac{\Delta^2}{12}=\frac{A^2}{12}2^{-2R}$$
and the SNR becomes
$$SNR=10\logt\frac{\E[X^2]}D=10\logt\frac{\sigma_X^2}{A^2/12}2^{2R}\approx 6R-10\logt\frac{A^2/4}{3\sigma_X^2}=6R-10\logt\frac{\gamma^2}3$$
 where $\gamma^2$ is the load factor, that is, the ratio between peak power and avg power. With this in mind:
 $$D=\frac{\gamma^2}3\sigma_x^22^{-2R}=K_X\sigma_X^22^{-2R}$$

## 1.3) Optimal Scalar Quantization (SQ)
For a given probability density function $p_X(x)$ we want to find the quantizer (thresholds $t^i$ and levels $\hat x^i$) that minimizes the distortion $D$ for a given rate $R$

#### Optimal HR Quantizer
Recall the HR hypothesis:
$$L\rightarrow \infty\quad \max_i\Delta_i\rightarrow 0\quad \forall i,u\ \in\Theta^i, \ p_X(x)\approx P_i$$
The RD curve becomes:
$$\sigma^2_Q=c_X\sigma^2_X2^{-2R}\quad\text{with }c_X=\frac1{12}\sq{\int p_U^{1/3}(t)dt}\text{ and }U=\frac X{\sigma_X}$$
$c_X$ is the shape factor since it only depends on the pdf.
some common shape factors are:
- Uniform: $c_X=1$
- Gaussian $c_X=\frac{\sqrt 3}2\pi\approx 2.72$

#### Non HR Quantizer
The solution doesn't have closed analytical formula, but
- There exists necessary conditions
- Lloyd-Max algorithm for local minima

How does the algorithm work?
1. Choose initial dictionary $C^{(0)}=\curly{\hat x^i_0}_{i=1,...,L}$
2. Find best thresholds for given dictionary $\curly{t^i=\frac{\hat x^i+\hat x^{i+1}}{2}}$
3. Find best dictionary for given thresholds $C\iter1=\curly{\hat x_{\iter1}^i}$
4. iterate 2. 3. until convergence (stop condition)

The initial dictionary can be chosen:
- Uniform Initialization: $\hat x^n=-A_0+n\Delta \ \forall n=1,...,L$
- Random initialization: code-words are initialized with the same distribution as data

The (quantizer) decision rule is the nearest neighbor:
$$k=\arg\min_n| x-\hat x^n|\rightarrow Q(x)=\hat x^k$$
The threshold decision rule is:
$$t^i=\frac{\hat x^i+\hat x^{i+1}}2$$

## 1.4) Predictive SQ
Quantization alone is not effective for compression of non-sparse data. Often samples have dependencies between each other (image has many adjecent pixels of same color).

This algorithm exploits the sample correlationand reduces the variance by increasing sparsity
But what is a sparse signal?

>[!def] Sparse Signal
>A signal is sparse if most of its components are zero or close to zero
>- The variance of a sparse signal is low
>- Zero (or close to zero) samples can be neglected (quantized to 0) without introducing distortion
>- Natural signal are not sparse but can easily be transformed into one

The basic idea is to define the prediction error as the signal error
$$q(n)=y(n)-\hat y(n)=x(n)-v(n)-(\hat x(n)-v(n))=\overline q(n)$$
![[Pasted image 20260320160934.png|Quantizer process|350]]
So the SNR can be written as a sum of two terms:
$$SNR=10\logt\frac{\sigma_X^2}{D}=10\logt\frac{\sigma_X^2}{\sigma_Y^2}+10\logt\frac{\sigma_Y^2}D=G_P+G_Q$$
Where $G_Q$ is the standard quantizer SNR on the signal $y$ while $G_P$ is the term added which is positive only if the variance of the sparse signal $y$ is lower than the og signal $x$

>[!example]
>Consider a gaussian signal $X(n) \sim\mathcal N(0,\sigma^2)$ and $V(n)=X(n-1)$. Moreover suppose that $\E[X(n)X(m)]=\sigma^2\rho^{|n-m|}$. The sparse signal becomes $$Y(n)=X(n)-X(n-1)$$
>The variance moreover becomes:
>$$\begin{align}\sigma_Y^2&=\E[(X(n)-X(n-1))^2]\\
&=\E[X(n)^2+X(n-1)^2-2X(n)X(n-1)]\\
&=2\sigma^2-2\sigma^2\rho\end{align}$$
> and the prediction gain becomes
> $$G_p=10\logt\frac{\sigma^2}{2(1-\rho)\sigma^2}$$
> which is good only if $G_P>0\rightarrow \rho>\frac12$

#### Linear Predictor
A linear predictor is a linear combination of the $P$ previous values
$$v(n)=-\sum_{i=1}^Pa_ix_{n-i}$$
I like to see it this way $x_{n-1}=x(n-i)$
The prediction error becomes
$$y(n)=x(n)-v(n)=\sum_{i=0}^P{a_i}x_{n-i}$$
with $a_0=1$
The transfer function reduces to
$$A(z)=\sum_{i=0}^Pa_iz^{-i}=1+a_1z^{-1}+...+a_{P}z^{-P}$$
Therefore the problem becomes a minimization problem: find values of $a_i$ that minimize the variance:
$$\begin{align}
\sigma_Y^2&=\E[Y(n)]=\E\sq{X(n)+\sum_{i=1}^Pa_iX(n-i)}^2\\
&=\E[X(n)^2+2\sum_{i=1}^Pa_i\E[X(n)X(n-i)]+\sum_{i=1}^P\sum_{j=1}^Pa_ia_j\E[X(n-i)X(n-j)]]\\
&=\sigma_X^2+2r^t a+a^tR_Xa
\end{align}$$
where $a$ is the vector with $a_i$ entries and $r$ is the autocorrelation matrix
![[Pasted image 20260320163517.png|r definition|]]
by deriving wrt a we get
$$\frac{\partial \sigma_Y^2}{\partial a}=2r+2R_xa\rightarrow a_{opt}=-R_Xr\rightarrow \sigma_Y^2=\sigma_X^2+r^ta_{opt}$$
and the autocorrelation can be estimated as
$$\hat r_X(k)=\frac1N\sum_{n=0}^{N-1-k}X(n)X(n+k)$$
TODO capire meglio


# 2) Lossless Coding
Lossless coding means to decrease the number of bits needed to encode the data without losing any information: the process is reversible.

The idea is based on variable length coding (VLC) where more probable symbols are encoded in shorter codewords.

Lets start with some notation:
- **Alphabet:** $\mathcal X=\curly{x_1,...,x_M}$ set of symbols to encode
- **Code:** application between $\mathcal X$ and $\curly{0,1}$ (set of finite length bit strings)

---
Digression on fixed length coding (FLC): in FLC all codewords ave the same length, that is $M$ symbols $\rightarrow$ $\ceil{\log M}$ bits to encode each symbol.

>[!example] FLC Text Compression
>An alphabet with 26 symbols is encoded with $\ceil{\log 26}=\ceil{4.7}=5$ bits per codeword. This has a compression ratio of 1.

---
In VLC each codeword $c_i$ has length $l_i$. This is possible if
- **Decodability Condition:** prefix to distinguish codewords
- **Non-equiprobable symbols**

>[!example] Example on Decodability Condition
>Consider the following alphabet $\mathcal X=\curly{A,B,C}$ with the following 4 codes:
>![[Pasted image 20260311130752.png|Coding Schemes|350]]
>- Code 1 cannot be decoded uniquely: example 111111 can be either BBB or CC
>- Code 2 is instaneously decodable (prefix condition)
>- Code 3 is decodable with delay less than or equal to 1 bit (delay counted from last bit)
>- Code 4 is decodable with an undefined delay

## 2.1) Principle of Information Theory
From the 4 codes before we can see that there is a favorite one, based on the following theorem we can choose to focus on **instantaneous codes**

>[!thm] McMillan's Theorem
>Decodable codes do not improve performance with respect to instantaneous codes

>[!thm] Kraft’s Inequality
>There exists a instantaneous code with lengths $\curly{l_1,...,l_M}$ iff
>$$\sum_i2^{-l_i}\leq 1$$
>See [proof](#^3d4d31).

If the equality holds then the code is said to be **optimal**.

#### Information and Entropy Recap
Suppose symbols $\curly{x_i}$ with probabilities $p_i$.
- The information of a symbol is 
$$I(x_i)=-\log_2 p_i=\log_2 \frac1{p_i}$$
- The source entropy of $X=\curly{x_i}$ is
$$H(X)=-\sum_ip_i\log_2p_i=-\E[\log_2(p_X(x))]$$
this is the avg uncertainty of $X$.

- Joint Entropy:
$$H(X,Y)=-\sum_{i,j}p_{i,j}\log p_{i,j}$$
- Conditional Entropy
$$\begin{align}H(X|Y)=\sum_jp_jH(X|Y=y_j)\rightarrow H(X,Y)&=H(Y)+H(X|Y)\\ &=H(Y)+H(Y|X)\end{align}$$
- Properties:
$$\begin{align}
&H(X)>0\\
&H(X,Y)=H(X)+H(Y|X)=H(Y)+H(X|Y)\\
&H(X,Y)\leq H(X)+H(Y) \ (\text{= if }\perp)\\
&H(X|Y)\leq H(X)\ (\text{= if }\perp)\\
&H(X)\leq \log_2 M \ (\text{= if }X\sim u)
\end{align}$$

#### Lagrange's Method
Lagrange's method is used to solve minmax problems with constraints.

Consider a function $f:x\in \R^n\rightarrow\R$
In order to find the maximum or minimum of $f$ subject to the constraint $\phi(x)=0$, we look for the stationary points of 
$$J(x,\lambda)=f(x)+\lambda\phi(x),\quad \lambda \in \R$$
The stationary points are computed by setting to zero all the derivatives of $J$:
$$\frac{\partial J}{\partial x_i}=0,\quad \frac{\partial J}{\partial \lambda}=0$$
>[!example] Distribution with Maximum Entropy
>The distribution maximizing the entropy of a M-ary discrete r.v. is found applying the Lagrange’s method:
>$$p^*=\arg\max_p\sum_{i=1}^Mp_i\log\frac1{p_1},\qquad \sum_ip_i=1\rightarrow \phi(x)=\sum_ip_i-1=0$$
>Write $J$:
>$$J(p.\lambda)=-\sum_ip_i\log p_i+\lambda\par{\sum_ip_i-1}$$
>Calculate the derivative (specific $p_i$)
>$$\frac{\partial J}{\partial p_i}=-\par{\frac{\log e}{p_i}p_i+\log p_i}+\lambda=0\rightarrow p_i=\lambda-\log e$$
>The max uncertainty is obtained by setting all probabilities equal, that is $p_i=1/M$.

## 2.2) Optimal Code
Given a set of $M$ symbols with probabilities $p_i$ we want to find the set of $M$ lengths $l_i$ such that:
- Kraft Inequality is satisfied (prefix code)
- $\forall i =1,...,M,\ l_i\in\mathbb N$
- The avg length $L=\sum_ip_il_i$ is minimized among all sets of $l_i$
$\implies$ constrained minimization problem
$$l^*=\arg\min_l\sum_ip_il_i\quad\text{ subject to }\sum_i2^{-l_i}=1$$
TODO Proof
The optimal length, which is also the lower bound, corresponds to the entropy:
$$L^*=-\sum_ip_i\log p_i=H(X)$$
However $H(X)\in \mathbb R$ not $\mathbb N$.
Taking $l_i=\ceil{-\log p_i}$ suffices to find a code such that $H(X)\leq L^*<H(X)+1$

Proof:
Kraft is satisfied:
$$\begin{gather}
l_i=-\log p_i+\delta_i \quad \delta \in[0,1)\\
2^{-l_i}=p_i2^{-\delta_i}=\epsilon_ip_i\quad\epsilon_i\in\left(\frac12,1\right]\\
\sum_i2^{-l_i}=\sum_i\epsilon_ip_i\leq\sum_ip_i=1
\end{gather}$$
The avg length is:
$$\begin{gather}
l_i=\ceil{-\log p_i}<-\log p_i+1\rightarrow p_il_i=-p_i\log p_i+p_i\\
H(X)<\sum_i p_il_i<\sum_i-pi\log p_i+p_i\\
H(X)\leq L^*<H(X)+1
\end{gather}$$
$$\endproof$$
#### Huffman Coding
Huffman discovered how to build the optimal lossless coder for any source with known probabilities.

Algorithm:
1. Create leaf nodes for each symbol, weighted by $p_i$
2. While there is more than one node:
	- Select two nodes with lowest weights
	- Create a new internal node as their parent
	- Set new node’s weight as sum of children’s weights
3. Assign ’0’ to left edges, ’1’ to right edges
4. Read code for each symbol from root to leaf

![[Pasted image 20260313110534.png|Example|250]]
This code has avg length $L^*=2.3$ and entropy $H(X)=2.246$

As a brief recap consider this:
$$\boxed{\begin{gather}
l_i=\ceil{\log_2p_i}\qquad H(X)=-\sum_ip_i\log_2p_i\\
H(X)\leq L^*=\sum_ip_il_i<H(X)+1
\end{gather}}$$
#### Block Coding
Instead of mapping one symbol into one codeword, we can map many subsequent symbols into a single codeword. 
This gives a better performance as:
Let $X^K=(X_1,X_2,...X_K)$ a block of K symbols. Then 
$$H(X^K)=H(X_1,X_2,...,X_K)\leq\sum_{i=1}^KH(X_i)$$
Then there are 2 scenarios ($L_s$ is the avg symbol length):
- Symbols not independent:
$$\frac{H(X^K)}K<H(X_i)\rightarrow L<H(X^K)+1\iff L_s<\frac{H(X^K)}K+\frac1K$$
- Symbols identically distributed (but not necessarily independent):
$$L_s<\frac{H(X^K)}K+\frac1K\leq H(X_i)+\frac 1K$$
These blocks are encoded via Huffman.


>[!example] BW image with iid pixels
>Let a BW image have probability $p$ of having a black pixel. Then we group pixels into blocks of 2, the probabilities are:
>$$P(BB)=p^2\quad P(BW)=P(WB)=p(1-p)\approx p\quad P(WW)=(1-p)^2\approx 1-2p$$
>from here
>$$H(X_1,X_2)=2H(X)\ll 2$$
>Apply the huffman code to the blocks and by an appropriate code we have
>$$L\approx 1\text{ but } L_s\approx \frac 12$$

Now define the Entropic Rate:
>[!def] Entropic Rate
>When the rate is converging, then
>$$\mathcal H(X)=\lim_{K\rightarrow\infty}\frac{H(K)}{K}=\lim_{K\rightarrow\infty} L^*_s\leq H(X)$$

Recall the avg length of the optimal code:
$$\begin{gather}
H(X^K)\leq L^*<H(X^K)+1\\
\frac{H(X^K)}{K}\leq L_s^*<\frac{H(X^K)}{K}+\frac{1}{K}\\
\downarrow K\rightarrow\infty\\
L^*_s\rightarrow\mathcal H(X)\leq H(X)
\end{gather}$$
where the last steps inequality uses the joint entropy property.


Therefore huffman code is optimal with larger and larger block sizes. This is practically unobtainable as complexity is exponential with K and probability estimation is hard with bigger blocks.

#### Arithmetic Coding
Arithmetic coding solves the exponential complexity with $K$ increasing. This coding is suboptimal but asymptotically optimal.
$$L\leq H(X^K)+2\rightarrow L_s=\frac LK\stackrel{K\rightarrow\infty}\longrightarrow\mathcal H(X)$$
This is done achieved by **encoding a sequence as the center interval** with arbitrary precision $q\in[0,1]$ a fractional number. The arithmetic code can encode blocks of any size, even the entirety of the message.

This requires **2 multiplications and 2 sums per symbol**

![[Pasted image 20260323135724.png|Example|350]]
The avg length can be calculated as (iid symbols):
$$\begin{gather}
L(n)=-\ceil{\sum_{i=1}^n\log_2p(x_i)}+1<-{\sum_{i=1}^n\log_2p(x_i)}+2\\
\overline L(n)<\frac{-{\sum_{i=1}^n\log_2p(x_i)}+2}n\\
\begin{aligned}
L=\E[\overline L(n)]&<\frac{-\sum_{i=0}^n\E[\log_2p(x_i)]+2}n\\
&<\frac{-\sum_{i=0}^n H(X_i)+2}n\\
&<H(X)+\frac 2n\stackrel{n\rightarrow\infty}\longrightarrow H(X)
\end{aligned}
\end{gather}$$
For non iid symbols we have
$$L(n)<-\log_2p(x^n)+2\rightarrow L=\frac{\E[L(n)]}n<\frac{H(X^n)+2}{n}\rightarrow\mathcal H(X)$$

However $p(x^n)$ is hard to estimate for non iid symbols (if iid $p(x^n)=\prod_i^n p(x_i)$)

#### Context Based Coding
This approach consists in looking at  $N_s$ previous symbols to recognize the context (max $N_c=M^{N_s}$ with $M$ the alphabet) and changes the encoder based on the context. This conditioning reduces the entropy of the source.

## 2.3) Other Coding Techniques

### 2.3.1) Exp-Golomb Coding
Universal coding for integer numbers, size (bits) proportional to magnitude
#### Unisgned Integer
Given int $n\in\mathbb N$ the representation consists in
- write $n+1$ in binary
- use min number of bits: $b=\floor{\log_2(n+1)}+1$
- place $b-1$ leading zeroes

Example:
$$n=0\rightarrow \begin{cases}n+1=1_{10}\rightarrow 1_2\\
b=\floor{\log_21}+1=1\\
b-1=0\end{cases}\longrightarrow 1$$
$$n=6\rightarrow \begin{cases}n+1=7_{10}=111_{2}\rightarrow 1_2\\
b=\floor{\log_27}+1=3\\
b-1=2\end{cases}\longrightarrow 00111$$
#### Signed Integer
Given int $n\in\mathbb Z$ the representation consists in
- Map $\mathbb Z\rightarrow \mathbb N$ using $m(n)=\begin{cases}2n-1 &n>0\\-2n &n\leq0\end{cases}$
- Use Exp-Golomb for unsigned integer

Example:
$$n=-3\rightarrow m(n)=6\rightarrow 00111$$
$$n=-6\rightarrow m(n)=12\rightarrow \begin{cases}n+1=13_{10}=1101_{2}\rightarrow 1_2\\
b=\floor{\log_27}+1=4\\
b-1=3\end{cases}\longrightarrow 0001011$$
### 2.3.2) Dictionary Based Coding
The idea is to ignore initial statistics and build a dictionary of codewords learned in long term. This allows universal capabilities

>[!thm] Asymptotic Optimality Theorem
>For stationary and ergodic sources, the dictionary approach is asymptotically optimal:
>With length $n\rightarrow\infty$ the average codewrod length $L_n$ converges to the entropy rate $\mathcal H$ of the source

Characteristics:
- **Dynamic Dictionary Construction:** Dictionary built on the fly during encoding process
- **Universality:** No prior knowledge of source statistics or probability distributions is required
- **Adaptivity:** adapts to non stationary signals that change over time
- **Practical Efficiency:** used in many formats (zip, gzip, etc)
- **Why:** This approach scales well with long patterns

#### LZW Encoding (TODO Important non si capisce un cazzo)
It uses a **greedy matching process:**
- Encoder reads symbol by symbol
- For each new input, it checks if the pattern (Prefix $W$+Next $K$) already exists
- **Iterative search:** If $W+K$ is found, it continues to read until new pattern is found

**Dictionary Evolution and Merging**
- **New pattern is found:** Index of longest prefix $W$ is sent to bitstream (output), then $W+K$ is added to dictionary
- **Prefix Merging:** This mechanism merges known prefixes with new suffixes, allowing the dictionary to naturally evolve and "track" local statistics.
##### Example:
Input: $0001000000101000010000010$
Alphabet: $0,1$

Initialization: $0\rightarrow 0, \ 1\rightarrow 1$ 

- First symbol: $0$
The encoder passes through the first symbol: Symbol $0$ exists in table (0). Continue search. 
Encoder now sees $00$: new symbol, adds it to table: $2\rightarrow00$. Write in output the codeword of $0$: 
Output = $0$

- Second symbol: $0$
We are still at the second $0$. $0$ is in the table, continue. $00$ is in the table (2), continue.
$001$ is not in table, add it: $3\rightarrow 001$
Output: $0 \ 2$

- Fourth symbol: $1$
1 is in table (1), continue. $10$ is not in table, add it: $4\rightarrow 10$
Output: $0\ 2\ 1$

- Fifth symbol: $0$
$0$ is in table, continue. $00$ is in table (2), continue. $000$ is new, add it to table: $5\rightarrow 000$
Output: $0 \ 2 \ 1 \ 2$


Here a merge is possible: notice that 2, 3 and 5 have the same prefix $00$. 


- Seventh symbol. $0$
0 is in table, 00 is in table, 000 is in table (2), 0000 is not in table, add it: $5\rightarrow 0000$
Output: $0\ 2 \ 1 \ 2\ 2$

# 3) Transform Coding and JPEG

## 3.1) Block Coding And Quantization
Recall block coding:
Let $X_k$ be a rv with variance $\sigma^2_k$, the quantizer distortion is: $D_k=c_k\sigma^2_k2^{-2R_k}$
Now consider a block of rv (not iid): $X=[X_1,...,X_M]^T$

**We apply a quantization step:**
From the  **Huang-Schilteiss formula** the optimal rate per block is:
$$R_k^*=\frac{R_{tot}}M+\frac12\log\sq{\frac{c_k\sigma^2_k}{c_{GM}\sigma^2_{GM}}}$$
The optimal case diverges from the uniform Resource distribution case (call $\overline R=R_{tot}/M$) we get that the single sample distortion equals to the global distortion:
$$\begin{gather}
D_k^*=c_{GM}\sigma_{GM}^22^{-2\overline R}\\
\mathcal D^*=\frac1M\sum_{k=1}^{M}D_k=c_{GM}\sigma_{GM}^22^{-2\overline R}
\end{gather}$$
In particular consider the gaussian case (shape factor constant $c_{GM}=x_k=c_\mathcal N$): 
$$\mathcal D^*=c_\mathcal N\sigma_{GM}^22^{-2\overline R}$$
and if the signals are iid (same variance $\sigma_{GM}^2\sigma_X^2$ and shape factor) the optimal rate is the uniform allocation. For historical reasons it is called PCM:
$$\begin{gather}
R_k^*=\overline R+\frac12\log_2\underbrace{\sq{\frac{c_k\sigma_k^2}{c_{GM}\sigma_{GM}^2}}}_{=1}=\overline R\\
\mathcal D_{PCM} =c_X\sigma_X^22^{-2\overline R}
\end{gather}$$

##### Proofs
Using uniform resource allocation the global distortion is:
$$\begin{align}
\mathcal D&=\frac1M\E[\|X-Q(X)\|^2]=\frac1M\E[(X-Q(X))^T(X-Q(X))]\\
&=\frac1M\E[\sum_{k=1}^M(X_k-Q(X_k))^2]=\frac1M\sum_{k=1}^M\E[(X_k-Q(X_k))^2]\\
&=\frac1M\sum_{k=1}^MD_k=\frac1M\sum_{k=1}^Mc_k\sigma_k^22^{-2R_k}
\end{align}$$
$\endproof$

---
The optimal rate is obtained by using the lagrangian multipliers method:
The constraint is: $\displaystyle \sum_{k=1}^{M-1}R_k\leq R_{tot}$
Then the optimization problem becomes:
$$J(R,\lambda)=\frac1M\sum_{k=1}^Mc_k\sigma_k^22^{-2R_k}+\lambda(\sum_{k=1}^{M-1}R_k- R_{tot})$$
Find the derivatives:
$$\frac{\partial J}{\partial R_k}=-\frac{2\ln2}Mc_k\sigma^2_k2^{-2R_k}+\lambda\qquad \frac{\partial J}{\partial\lambda}=\sum_{k=1}^{M-1}R_k- R_{tot}$$
Set the gradient to 0 and solve:
$$\begin{gather}
-\frac{2\ln2}Mc_k\sigma^2_k2^{-2R_k}+\lambda=0\\
-2R_k={\log_2(\frac{M\lambda}{2\ln 2})}+\log_2(\frac1{c_k\sigma^2_k})\\
R_k^*=\underbrace{\frac12\log_2\par{\frac{2\ln 2}{M}}}_{\lambda'}+\frac12\log_2(c_k\sigma_k^2)
\end{gather}$$
Now write it with $R_{tot}$
$$\begin{align}
R_{tot}&=\sum_{k=1}^MR_k^*=M\lambda'+\frac12\sum_{k=1}^M\log_2(c_k\sigma_k^2)\\
\downarrow\\
\lambda'&=\frac{R_{tot}}M-\frac1{2M}\sum_{k=1}^M\log_2(c_k\sigma^2_k)=\frac{R_{tot}}M-\frac12\log_2\par{\prod_{k=1}^M(c_k\sigma^2_k)^{1/M}}\\
&=\frac{R_{tot}}M-\frac12\log_2(c_{GM}\sigma_{GM}^2)\\
\downarrow\\
R_k^*&=\lambda'+\frac12\log_2(c_k\sigma^2_k)=\frac{R_{tot}}M-\frac12\log_2(c_{GM}\sigma_{GM}^2)+\frac12(c_k\sigma^2_k)\\
&=\frac{R_{tot}}M+\frac12\log_2(\frac{c_k\sigma^2_k}{c_{GM}\sigma^2_{GM}})\\
\end{align}$$
The solution is the **Huang-Schilteiss formula:**
$$R_k^*=\frac{R_{tot}}M+\frac12\log\sq{\frac{c_k\sigma^2_k}{c_{GM}\sigma^2_{GM}}}$$
$\endproof$

---

Apply the optimal rate to the single distortion
$$\begin{gather}
D_k^*=c_{k}\sigma_{k}^22^{-2R_k^*}=c_{k}\sigma_{k}^22^{-2\overline R-\log_2\frac{c_k\sigma^2_k}{c_{GM}\sigma^2_{GM}}}=c_{GM}\sigma_{GM}^22^{-2\overline R}
\end{gather}$$

$\endproof$
#### Digression on Arithmetic VS Geometric Mean (AM, GM)
The means are defined as:
$$z_{AM}=\frac1M\sum_{k=1}^Mz_k\geq z_{GM}=\sqrt[M]{\prod_{k=1}^M z_k}$$
##### Proof
By Jenses Inequality we have:
$$f(\frac1M\sum_{k=1}^Mz_k)\geq \frac1M\sum_{k=1}^Mf(z_k)$$
with $f$ the log function.
$$\log(z_{AM})\geq\frac{1}{M}\sum_{k=1}^M \log(z_k) = \log\!\left(\prod_{k=1}^M z_k^{1/M}\right) = \log(z_{GM})\rightarrow z_{AM}\geq z_{GM}$$

## 3.2) Transform Coding
The aim is to make the signal sparse, that is, few large samples (low rate EQ) and many small ones (high EQ). This transforms the id (not iid) signal into blocks with diverse variances (same mean) so to minimize $\sigma_{GM}^2$.
For example a fourier transform of a pure sound is sparse: All zereos except for $f_w$.

The operator has the following properties:
- Reversible: $Y=T(X)\iff X=T^{-1}(Y)$
- Input in $\R^M$: an image is $\R^2$
- Input is not sparse
- Output is sparse

We consider $Y=\mathcal TX$ where $\mathcal T$ is an invertible matrix
- Inverse exists by definition
- This acts as a basis change: basis is set of signals to reconstruct intended signal
- If $\mathcal T$ is orthogonal the quantization is the same

So the paradigm becomes:
$$x\rightarrow y=\mathcal Tx\rightarrow \hat y=Q(y)\rightarrow\hat x=\mathcal T^{-1}\hat y$$
#### Orthogonal Transform
Orthogonal Transform has $\mathcal T$ as an orthogonal matrix. This gives many advantages:
- Inverse is immediate: $\mathcal T^{-1}=\mathcal T^T$
- Is an isometry keeps $\mathcal L^2$ norm of any $X$: $\|\mathcal TX\|^2=\|X\|^2$
- Isometry keeps distortion the same on the output: $D_X=D_Y$

Now consider block coding on id (not iid) gaussian rvs. With orthogonal transform we get:
- Distortion can be applied directly to the quantized output:  $D_T=D_Y\stackrel{\text{optimal } R_k}=c_{GM,Y}\sigma_{GM,Y}^22^{-2R_k}$
- Variance of $Y$ is the AM of $X$: $\sigma_{AM,Y}^2=\sigma_X^2$
- AM variance is constant

Finally define the **Coding Gain:**
$$G_T=\frac{D_{PCM}}{D_T}=\frac{c_\mathcal N\sigma^2_{X}2^{-2R_k}}{c_\mathcal N\sigma_{GM,Y}^22^{-2R_k}}=\frac{\sigma_{AM,Y}^2}{\sigma_{GM,Y}^2}\geq1$$
this shows that if the transform reduces the GM variance (with non id samples), then the transform is more efficient.

>[!example|*]
>Consider a signal where $X_1,X_2\sim u\sq{-\frac{\Delta_1}{2\sqrt 2},\frac{\Delta_1}{2\sqrt 2}}$ and have the joitn distribution $f_{X_1,X_2}(x_1,x_2)=\begin{cases}\frac1{\Delta_1\Delta_2}&(x_1,x_2)\in S\\0&(x_1,x_2)\not\in S\end{cases}$ there $S$ is an oriented rectangle ($45^\circ$) with dimension $\Delta_1\times\Delta_2$. With $\Delta_1\gg \Delta_2$.
>![[Pasted image 20260330181539.png|Image|200]]
>
>Apply uniform quantization (best fit for uniform rv, but not optimal) directly on the samples:
>Notice that $X_1,X_2$ have the same variance $\sigma^2=\Delta_1^2/24$ and form factor $c=1$
>Based on how many bits are assigned to the single rv we get
>![[Pasted image 20260330181038.png|Table|250]]
>Apply the following transform $\mathcal T=\frac1{\sqrt 2}\begin{bmatrix} 1 & -1 \\ 1 & 1 \end{bmatrix}$ (orthogonal since $\mathcal T^T\mathcal T=I$) then the rvs become: $Y_i\sim u\sq{-\frac{\Delta_i}2,\frac{\Delta_i}2}$ and the joint distribution $f_{Y_1,Y_2}(y_1,y_2)=\begin{cases}\frac1{\Delta_1\Delta_2}&(y_1,y_2)\in S'\\0&(y_1,y_2)\not\in S'\end{cases}$ where $S'$ is the rotated surface from before
>![[Pasted image 20260330181844.png|Image|200]]
>Now the variances are different $\sigma^2_1=\Delta_1^2/12=2\sigma^2,\ \sigma_2^2=\Delta_2^2/12\ll\sigma^2$  and the distortion becomes:
>![[Pasted image 20260330182023.png|Table|250]]

##### Proofs
Inverse is by definition.
$\endproof$

---

Isometry:
$$\|\mathcal TX\|^2=(\mathcal T X)^T(\mathcal T X)=(X^T\mathcal T^T)(\mathcal T X)X^T(\mathcal T^T\mathcal T)X=X^TX=\|X\|^2$$

And distortion on isometry:
$$D_Y=\frac1M\E[\|Y-\hat Y\|^2]=\frac1M\E[\|\mathcal T(X-\hat X)\|^2]=\frac1M\E[\|(X-\hat X)\|^2]=D_X$$

$\endproof$

---

Same distortion:
$$\mathcal D_T=\frac1M\E[\|X-\hat X\|^2]=\frac1M\E[\|\mathcal T^{-1}Y-\mathcal T^{-1}\hat Y\|^]=\frac1M\E[\|Y-\hat Y\|^2]=D_Y$$
$\endproof$

---

Variance equivalences:
$$\begin{align}
\sigma_X^2&=\sigma_{AM,X}^2=\frac1M\sum_{k=1}^M\E[X_k^2]=\frac1M\E\sq{\sum_{k=1}^MX_k^2}=\frac1M\E[\|X\|^2]\\
&\qquad(\text{recall: } \|Y\|^2=\|\mathcal TX\|^2=\|X\|^2)\\
&=\frac1M\E[\|Y\|^2]=\frac1M\E\sq{\sum_{k=1}^MY_k^2}=\frac1M\sum_{k=1}^M\E[Y_k^2]\\
&=\sigma_{AM,Y}^2
\end{align}$$
$\endproof$
## 3.3) Practical Implementation of Huang-Schulteiss

HS has a series of limitations:
- Returns negative values
- Returns non-integer values

The **Modified HS algorithm** is very simple:
1. Use HS with all $M$ components
2. If there are negative values, set $R=0$ of the component and recalculate HS with $M-N$ components
3. When there are only positive values, floor the results
4. Calculate residual rate and allocate eventual residual bits to the results that got rounded the most

>[!example|*]
>Let there be a gaussian input with 4 components and $R_{tot}=10$:
>$$\sigma_1^2=1000, \ \sigma_2^2=100, \ \sigma_3^2=50,\ \sigma_4^2=1$$
>The GM is $\approx47.29$
>We get:
>$$R(1)\approx4.7,\ R(2)\approx3.04,\ R(3)\approx2.54, \ R(4)\approx -0.28\stackrel{\text{negative}}\longrightarrow 0$$
>Recompute HS with 1,2,3:
>GM $\approx 171$
>We get (also floor):
>$$R(1)\approx4.61\rightarrow4,\ R(2)\approx2.95\rightarrow2,\ R(3)\approx2.45\rightarrow2, \ R(4)=0\rightarrow0$$
>Since $4+2+2+0\not=10$ we can allocate 2 residual bits to components 1 and 4
> $$R(1)=5,\ R(2)=3,\ R(3)=2, \ R(4)=0$$
> The total distortion is:
> $$D=\sum D_i=0.98+1.56+3.13+1=6.67$$
> 

The **greedy algorithm** returns the same allocation but is faster:
- Initialization. $R_k=0\ \forall k\in\curly{0,...,M-1}\qquad D_k=\sigma_k^2\forall k\in\curly{0,...,M-1}$
- While $\sum R_k\leq R_{tot}$
	- $l=\arg\max_k D_k$
	- $R_l\leftarrow R_l+1$
	- $D_l\leftarrow D_l/4$


# 4) Proofs
**Kraft Inequality:**
Proof of Necessity ($\implies$): 
Codewords are already given. Set $L_\max=\max_i(l_i)$ ^3d4d31

Build binary tree with depth $=L_\max\rightarrow 2^L_\max$ number of leaves.

Each codeword with prefix property occupies an entire subtree (since no other codeword must start with same bits). So a codeword with length $l_i$ occupies $2^{L_\max-l_i}$ leaves $\rightarrow$ No codeword is a descendant of another, thus these sets of leaves are disjoint.

From here notice that The total number of blocked leaves cannot exceed the available leaves, formally:
$$\sum_{i=1}^N2^{L_\max-l_i}\leq2^{L_\max}\rightarrow \sum_{i=1}^N2^{-l_i}\leq 1$$
Proof of Sufficiency ($\impliedby$):
We have given $\curly{l_i}$ such that $\sum 2^{-l_i}\leq 1$
Again build a binary tree:
The codes can be built as follows:
1. Sort all lengths $l_1\leq....\leq l_N$
2. At each step $k=\curly{1,...,N}$ pick an available position at depth $l_k$ (decreasing order)
3. Mark descendants of $l_k$ as forbidden. $2^{-l_i}$ nodes are blocked.

At each step the unavailable nodes are $\displaystyle\sum_{i=1}^{k-1}2^{-l_i}$. Therefore we have $\displaystyle1-\sum_{i=1}^{k-1}2^{-l_i}$ available nodes and by Kraft’s Inequality we have 
$$\sum_{i=1}^N2^{-l_i}=\sum_{i=1}^{k-1}2^{-l_i}+2^{-l_k}\leq 1\rightarrow 1-\sum_{i=1}^{k-1}2^{-l_i}\geq2^{-l_k}$$
Since the remaining free capacity is at least $2^{-l_k}$, there must exist at least one free node at depth $l_k$ where the k-th codeword can be placed.
$$\endproof$$

---