# 1) Lesson 9/10/26
## 1.1) Inequalities
**General Procedure:**
1. Determine the domain $D$.
2. Bring all terms to one side: $f(x) \gtrless 0$.
3. Factor into products or fractions: $\frac{A(x)}{B(x)} \gtrless 0$.
	1. Find the roots of each factor.
	2. Construct a sign chart.
4. Intersect the resulting intervals with the domain $D$.

There can happen 3 main cases: fractions, square roots or absolute values
####  **Ex c)** Fraction
Solve the following inequality:
$$\frac{x - 1}{x - 2} > \frac{2x - 3}{x - 3}$$

Domain:
$$D=x\in\mathbb R\setminus\curly{2,3}$$
Simplify:
$$\frac{x - 1}{x - 2} - \frac{2x - 3}{x - 3} > 0 \implies \frac{(x-1)(x-3) - (2x-3)(x-2)}{(x-2)(x-3)} > 0$$
This is of form $A(x)/B(x)$ so the study of the numerator and denominator needs to be done independently

**Numerator:**
Find zeroes:
$$\begin{align}
(x-1)(x-3) - (2x-3)(x-2)&=(x^2 - 4x + 3) - (2x^2 - 7x + 6) \\
&= -x^2 + 3x - 3
\end{align}$$
Recall the quadratic formula:
Let $a,b,c\in\mathbb R$, then $ax^2+bx+c=0$ has the following solution:
$$x_{1,2}=\frac{-b\pm\sqrt{b^2-4ac}}{2a}$$
Where the discriminant $\Delta=b^2-4ac$ determines the types of solution:
- $\Delta>0$: two real (distinct) solutions
- $\Delta=0$: two real (identical) solutions
- $\Delta<0$: no real solution

In this case since $\Delta = 9 - 12 = -3 < 0$ we don't have any solutions, hence since $a<0$ the whole numerator is negative.

**Denominator:**
Here the function already shows the zeroes, so we can plot the graph to see the regions:

![[Pasted image 20261005144306.png|Curve|250]]

 
 So we have positive denominator for $x<2\ \cup\ x>3$.

By noticing the interval where they have the same sign:
$$
\begin{array}{c|ccc}
x & (-\infty,2) & (2,3) & (3,+\infty) \\ \hline
\text{Numerator} & - & - & - \\
\text{Denominator} & + & - & + \\ \hline
\text{Fraction} & - & + & -
\end{array}
$$
Finally we have:
$$\boxed{2<x<3}$$

---

#### **Ex d)** Absolute value
Solve the following inequality:
$$\frac{|x|}{x-1}>\frac{x+1}{2x-1}$$
Domain:
$$D = x \in \mathbb{R} \setminus \left\{\frac{1}{2}, 1\right\}$$
Now recall the abs value definition:
$$|f(x)|=\begin{cases}
f(x) & f(x)\geq 0\\
-f(x)& f(x)<0
\end{cases}$$
In this case $f(x)=x$ so we have:
$$\begin{cases}
\displaystyle \frac{x}{x-1}>\frac{x+1}{2x-1} & x\geq 0\\
\displaystyle \frac{-x}{x-1}>\frac{x+1}{2x-1} & x<0
\end{cases}$$
Remeber:
- The solution to each part of the system must be put in intersection with the condition
- The solutions of the parts of a system are in union with each other

**Start with case 1:**
Rewrite so that it is a single fraction:
$$\frac{x}{x-1} - \frac{x+1}{2x-1} > 0 \implies \frac{x(2x-1) - (x+1)(x-1)}{(x-1)(2x-1)} > 0$$
- Numerator:

$$x(2x-1) - (x^2-1) = 2x^2 - x - x^2 + 1 = x^2 - x + 1$$

Find the zeroes of the numerator:

$$x^2 - x + 1 = 0 \rightarrow \Delta = -3$$

Since $\Delta < 0$ and $a = 1 > 0$, the numerator is strictly positive.

- Denominator:

$$(x-1)(2x-1) > 0 \iff x < \frac{1}{2} \ \cup \ x > 1$$

Sign analysis for Case 1:

$$\begin{array}{c\|ccc} x & \left(-\infty, \frac{1}{2}\right) & \left(\frac{1}{2}, 1\right) & (1, +\infty) \\ \hline \text{Numerator} & + & + & + \\ \text{Denominator} & + & - & + \\ \hline \text{Fraction} & + & - & + \end{array}$$

So the fraction is $>0$ on $\left(-\infty, \frac{1}{2}\right) \cup (1, +\infty)$.

Intersecting with the case condition $x \geq 0$:
$$S_1 = \left[0, \frac{1}{2}\right) \cup (1, +\infty)$$
**Case 2:**
Same procedure as case 1:
$$\frac{-x}{x-1} - \frac{x+1}{2x-1} > 0 \implies \frac{-x(2x-1) - (x+1)(x-1)}{(x-1)(2x-1)} > 0$$

- Numerator:
$$-2x^2 + x - (x^2-1) = -3x^2 + x + 1$$
Find the zeroes of the numerator:
$$x_{1,2} = \frac{-1 \pm \sqrt{13}}{-6} = \frac{1 \mp \sqrt{13}}{6}$$
Since $a = -3 < 0$, the parabola opens downward:
$$N > 0 \iff x_1=\frac{1-\sqrt{13}}{6} < x < \frac{1+\sqrt{13}}{6}=x_2$$
Denominator:
The denominator roots are $\frac{1}{2} = 0.5$ and $1$.

Sign analysis for the factors:

$$\begin{array}{c\|ccccc} x & \left(-\infty, x_1\right) & (x_1, 1/2) & (1/2, x_2) & (x_2, 1) & (1, +\infty) \\ \hline \text{Numerator} & - & + & + & - & - \\ \text{Denominator} & + & + & - & - & + \\ \hline \text{Fraction} & - & + & - & + & - \end{array}$$

The fraction is $>0$ on $\left(x_1, \frac{1}{2}\right) \cup (x_2, 1)$.

Intersecting with the case condition $x < 0$:
$$S_2 = \left(\frac{1-\sqrt{13}}{6}, 0\right)$$
Taking the union of both cases $S = S_1 \cup S_2$:
$$S = \left(\frac{1-\sqrt{13}}{6}, 0\right) \cup \left[0, \frac{1}{2}\right) \cup (1, +\infty)$$
Notice that $0$ is included in the solution set, so the first two intervals join together:
$$\boxed{S = \left(\frac{1-\sqrt{13}}{6}, \frac{1}{2}\right) \cup (1, +\infty)}$$


---


#### **Ex f)** Square Root
Solve the following inequality:
$$\sqrt{x^2-6x}>x+2$$
First notice that the domain is
$$x^2-6x\geq 0\rightarrow D=(-\infty, 0]\cup[6,+\infty)$$
First notice that when $x+2<0$ the solution inequality holds (in the domain). So one part of the solution is:
$$S_1=D\cap\curly{x<-2}=\curly{x<-2}$$

Now for $x+2\geq0$ of both sides can be squared:
$$x^2-6x>x^2+4x+4\rightarrow 0>10x+4\rightarrow x<-\frac25$$
This clearly for the values bigger than $-2$ in the domain, that is
$$S_2=D\cap\curly{\curly{x\geq -2}\cap\curly{x<-\frac25}}=D\cap\curly{-2\leq x<-\frac25}=\curly{-2\leq x<-\frac25}$$


So the result is:
$$S=S_1\cup S_2=\curly{x<-2}\cup\curly{-2\leq x<-\frac25}=x<-\frac25$$


---

#### **Ex i)** Mixed Together
Solve the following inequality:
$$\sqrt{|x^2-4|}-x\geq0$$
Domain: $|x^2-4|\geq 0\rightarrow D=\mathbb R$

Now recall the abs value definition:
$$|f(x)|=\begin{cases}
f(x) & f(x)\geq 0\\
-f(x)& f(x)<0
\end{cases}$$
In this case $f(x)=x^2-4=(x+2)(x-2)$ so $f(x)\geq0\rightarrow x\leq-2\cup x\geq2$

Now we can rewrite the inequality as a system of two inequalities:
$$\sqrt{|x^2-4|}-x\geq0\rightarrow\begin{cases}
\sqrt{x^2-4}-x\geq 0 & x\leq-2\cup x\geq 2\\
\sqrt{4-x^2}-x\geq 0 & -2<x<2
\end{cases}$$
Each system can be solved independently from the other.
Call the conditions of the cases $D_1$ and $D_2$ respectively.

**Solve first case:**
Recall that when RHS (x) is negative there is always a solution.
$$\sqrt{x^2-4}\geq x$$
Therefore one part of the solution includes $x<0$

Now study in the interval $x\geq 0$: since we are sure that both sides are $\geq0$ we can square both sides:
$$x^2-4\geq x^2\rightarrow -4\geq 0$$
Not possible, so the only solution to this part is when $x$ is negative:
$$S_1=x\leq 0\cap D_1=x\leq -2$$

**Solve the second equation:**
As before a solution always exists for $x< 0$. Now consider only the positive values ($x\geq 0$) in order to be able to square both sides:
$$\sqrt{4-x^2}\geq x\rightarrow 4-x^2\geq x^2\rightarrow 4-2x^2\geq 0\rightarrow -\sqrt 2\leq x\leq\sqrt 2$$
So we have $S_2=D_2\cap\curly{ x<0\cup-\sqrt 2\leq x\leq \sqrt 2}=D_2\cap x\leq\sqrt 2=-2<x\leq\sqrt 2$



The result is therefore the union of both cases which yields:
$$\boxed{S=x\leq -2\cup -2< x\leq\sqrt 2\rightarrow S=x\leq \sqrt 2}$$
---
## 1.2) Subsets of $\mathbb R$
#### **Ex a)**
Describe the following set:
$$A=S_1\cap S_2=\curly{x\in\mathbb R: x^2+4x+13<0}\cap\curly{x\in\mathbb R: 3x^2+5>0}$$
Subset 1:
$$x^2+4x+13<0\rightarrow \Delta=-36 \implies S_1=\emptyset $$
any intersection with an empty set is an empty set:
$$\boxed{A=\emptyset\ \cap\ S_2=\emptyset}$$

In general recall:
$$\emptyset\cap S=\emptyset\qquad \emptyset\cup S=S$$

----

#### **Ex c)**
Describe the following set:
$$C=\curly{x\in\mathbb R: \frac{x^2-5x+4}{x^2-9}<0}\cup\curly{x\in\mathbb R:x+\sqrt{7x+1}=17}$$
**Subset 1:**
First notice that the domain is $x\not=\pm 3$

Numerator:
$$x^2-5x+4=0\rightarrow x_{1,2}=1, \ 4\rightarrow N>0\iff x<1\cup x>4$$
Denominator:
$$x^2-9=(x+3)(x-3)=0\rightarrow D>0\iff x<-3\cup x>3$$

$$\begin{array}{c|ccc}
x & (-\infty,-3) & (-3,1) & (1,3) & (3,4) & (4,+\infty)\\ \hline
\text{Numerator} & + & + & - & - & + \\
\text{Denominator} & + & - & - & + & + \\ \hline
\text{Fraction} & + & - & + & - & +
\end{array}$$
so $S_1=(-3,1)\cup (3,4)$

**Subset 2:**
This is just an equality:
$$\sqrt{7x + 1} = 17 - x$$
The domain is $7x+1\geq 0\rightarrow D=\curly{x\geq -\frac17}$
Moreover as before, both sides must have the same sign when squaring and since the sqrt is always $\geq0$ we must have that also $17-x\geq0\rightarrow x\leq 17$ so we can further reduce the domain to 
$$D=\sq{-\frac17,17}$$

Square both sides:
$$7x+1=(17-x)^2\rightarrow 7x+1=x^2-34x+17^2\rightarrow x^2-41x+288=0$$
$$x_{1,2}=9, \ 32$$
But only 9 is acceptable as $32\not \in D$

Finally:
$$\boxed{C=(-3,1)\cup(3,4)\cup \curly9}$$


---

## 1.3) Max/Min, Sup/Inf
Recall the theory

>[!def|*] Upper/Lower Bound
>$M\in \mathbb Q$ is called **upper bound** for $A$ if $M\geq a, \forall a\in A$.
>
>Respectively it is called **lower bound** if $M\leq a,\forall a\in A$

Notice $M$ does not need to be in $A$
Example: consider set $A=[0,1)$ any $m\leq0$ is a lower bound and any $M\geq 1$ is upper bound

>[!def|*] Maximum/Minimum of $A$
>If $\overline M$ is an upper bound for $A$ and $\overline M\in A$, then $\overline M$ is the *minimum* possible *upper* bound and is the **maximum** (of $A$).
>
>If $\overline m$ is an lower bound for $A$ and $\overline m\in A$, then $\overline m$ is the *maximum* possible *lower* bound and the **minimum** (of $A$).

In this case $\overline M\in A$ by definition. 
From the previous example: $\overline m =\max\curly{m\leq 0}=0\in A$ is the correct minimum of $A$, however $\overline M =\min\curly{M\geq 1}=1\not\in A$ means that we don't have a maximum

>[!def|*] Supremum/Infimum
>The **supremum of $A$** $\text{sup } A$ is the minimum of the upper bounds of $A$.
>
>The **infimum of $A$** $\text{inf } A$ is the maximum of the lower bounds of $A$. 

Finish the example: we know $\overline m=0\in A$ so this is both minimum and infimum of $A$. We know also $\overline M=1\not \in A$, therefore $\text{sup A}=1$ but it is not the maximum.

Recall that if a set is unbounded, then
$$\sup A = +\infty \quad \text{if } A \text{ is unbounded from above}$$
$$\inf A = -\infty \quad \text{if } A \text{ is unbounded from below}$$
#### Ex a)
Tell wether this subsets is bounded and the sup/inf and if it allow for maximum/minimum.
$$A=\curly{x\in\mathbb R: x=n\text{ or } x=\frac1{n^2},n\in N\setminus\curly 0}$$

It is immediately clear that $A$ is the union of two sets, mainly
$$A=S_1\cup S_2\text{ where } \quad \begin{align}
&S_1 = \{n \in \mathbb{N} \setminus \{0\}\} = \{1, 2, 3, 4, \dots\}\\
&S_2 = \left\{\frac{1}{n^2} \mid n \in \mathbb{N} \setminus \{0\}\right\} = \left\{1, \frac{1}{4}, \frac{1}{9}, \frac{1}{16}, \dots\right\}
\end{align}$$

Find the bounds on both sets individually (not required but the result is clearer).

**Study the first subset $S_1$:** notice that it is just the natural numbers with zero excluded, so its properties are already known.
- No upper bound, so also no max
	- Supremum: since unbounded; $\text{sup }S_1=+\infty$
- Lower bound: $m_1\leq 1$
	- Minimum: $\overline m_1=\max m_1\leq 1=1\in S$

**Study the second subset $S_2$:** Intuitively we know that the function describing the set is monotonically decreasing: we can express it by saying:

Call $x_n$ the value of x for any chosen $n$, then $x_{n+1}<x_n$.
This is easily shown as the following inequality is true for $n\in \mathbb N\setminus \curly 0$ (check at home):
$$\frac{1}{(n+1)^2}<\frac1{n^2}$$
Therefore for every number $x_n>0$ we can find a smaller number such that $0<x_{n+1}<x_n$

Is $0$ the maximum lower bound?
By contradiction suppose there exists a lower bound $\delta>0$ then if 0 is the maximum lower bound we have
$$\exists n \in \mathbb{N} \setminus \{0\} \quad \text{such that} \quad \frac{1}{n^2} < \delta$$
Now compute
$$\frac{1}{n^2} < \delta \rightarrow n^2 > \frac{1}{\delta} \rightarrow n > \frac{1}{\sqrt{\delta}}$$
Because $\delta > 0$, the number $\frac{1}{\sqrt{\delta}}$ is just a fixed positive real number and an appropriate $n$ exists.


With this digression aside, we also know that $0\not \in S_2$.
As before analyze:
- Lower bound: $m_2\leq 0$
	- No minimum: $\overline m_2=\max m_2\leq 0=0\not \in S_2$
	- Infimum is $\text{inf }S_2=0$
- Upper bound: $M_2\geq 1$
	- $\overline M_2=\min M_2\geq 1=1\in S_2$


**Putting all together:**
Now consider the union, so:
- No upper bound since $S_1$ is unbounded
	- therefore $\text{sup }A=+\infty$
- Lower bound: The infimum is the **maximum** of all lower bounds: $\inf A = \min(\inf S_1, \inf S_2) = \min(1, 0) = 0$. Since $0 \notin A$, $\min A$ does not exist.




# 2) Lesson 16/10/26
## 2.1) Domains
$\newcommand{\dom}{\text{dom }}$
Recall:
$$f(x)=\begin{align}
\frac{a(x)}{g(x)}&\qquad\dom f=\curly{g(x)\not=0}\\
\sqrt{g(x)}&\qquad\dom f=\curly{g(x)\geq 0}\\
\log(g(x))&\qquad\dom f=\curly{g(x)>0}\\
\end{align}$$
#### a) Fraction and Sqrt
Determine the domains of the following function:
$$f(x)=\frac{\sqrt{x^2-3x-4}}{x+5}$$
Here the domain is given by two solutions that must hold simultaneously.

**Fraction:**
Here $D_1=\curly{x+5\not = 0}=\curly{x\not = -5}$

**Sqrt:**
Here $D_2=\curly{x^2-3x-4\geq 0}$. The zeroes of this function are $x_{1,2}=-1,4$ so the inequality holds for $D_2=\curly{x\leq-1\cup x\geq 4}$

Finally
$$\dom f=D_1\cap D_2=\curly{x\leq-1\cup x\geq 4}\setminus\curly{-5}=(-\infty, -5)\cup(-5,-1]\cup[4,+\infty)$$
where the last part is the correct formal way to write the result.
#### b) Logarithm
Determine the domains of the following function:
$$f(x)=\log(x^2-x)$$
The domain is given by $x^2-x>0$, so solve the inequality:
$$x^2-x=x(x-1)>0$$
The first term is positive for $x>0$, the second for $x>1$, so 
$$\dom f=\curly{x<0\cup x>1}$$
#### c) System
Determine the domains of the following function:
$$f(x)=\begin{cases}
\displaystyle\frac1{2x+1}&x\geq 0\\
e^{\sqrt{x+1}}&x<0
\end{cases}$$
Here the domain is given by the union of the two cases. 

**Case 1:**
Here the domain is given by $D_1^*=\curly{2x+1\not=0}=\curly{ x\not =-\frac12}$. However since this is a system, this must hold only inside the specified case, so $D_1=D_1^*\cap\curly{x\geq 0}=\curly{x\geq 0}$ since $-\frac12\not\in\curly{x\geq0}$, so this part of the map is always valid.

**Case 2:**
Here the domain is given by $x+1\geq 0\rightarrow x\geq -1$ which combined with the system is $x\in [-1,0)$

The final domain becomes the union of the two cases, so
$$\dom f=\curly{x\geq 0}\cup\curly{-1\leq x<0}=\curly{x\geq -1}$$
## 2.2) Symmetries and Periodicity
If a function is symmetric, it can have either even or odd symmetry:
- Even Symmetry: mirrored along y axis: $f(x)=f(-x)$
- Odd Symmetry: mirrored along x and y axis: $f(x)=-f(-x)$
#### a) Sqrt and Abs
Sketch the graph of the following function indicating the possible symmetries and/or periodicity:
$$f(x)=\sqrt{1-|x|}$$
**Domain:**
$$D=\curly{1-|x|\geq0}=\curly{|x|\leq 1}=\curly{x\in[-1,1]}$$
So clearly the function cannot be periodic. By definition, a periodic function requires $x \in \text{dom } f \implies x + T \in \text{dom } f$ for all $x$, which cannot hold on a bounded interval

**Symmetry:**
Since $f$ is the result of a sqrt, it can only be non negative (roots at $x=\pm1$), therefore an odd symmetry is not possible (only possible if $f$ is constant 0). Try the even symmetry:
$$f(-x)=\sqrt{1-|-x|}=\sqrt{1-|-1|\cdot|x|}=\sqrt{1-1\cdot|x|}=f(x)$$
The final sketch can be done by sampling points only between $[0,1]$ since then it can be mirrored.
![[Pasted image 20261012120934.png|Sketch|450]]
#### b) Cosine
Sketch the graph of the following function indicating the possible symmetries and/or periodicity:
$$f(x)=1+\cos(2x)$$
There is no restriction in the domain, so start with the symmetries. Again since $\cos(z)\in[-1,1]$ the function returns only non-negative values, so an odd symmetry is excluded, moreover since $\cos(z)$ is an even function, we can guess that the function is even, let's prove it:
$$f(-x)=1+\cos(-2x)=1+\cos(2x)=f(x)$$
**Periodicity:**
$T_1$: 1 is a constant function. A constant function $c(x) = c$ satisfies $c(x + T) = c(x)$ for **every** $T > 0$. Therefore, every positive real number is a period. However it does not have a fundamental period (0 cannot be period)
$T_2$: $\cos(\theta)$ has period $2\pi$, that is $\cos(\theta+2\pi)=\cos(\theta)$, but what about $g(x)=\cos(2x)$? Let's try the generic case $\cos(ax)$, $a>0$

By the definition of period, we must find a $T>0$ such that
$$\min_T\curly{T>0:g(x+T)=g(x)\ \forall x\in \mathbb R}=\min_T\curly{\cos(a(x+T))=\cos(ax)}$$
Recall that $\cos(\theta+2\pi)=\cos(\theta)$ and by comparing it with the argument of the minimum we get
$$aT=2\pi\rightarrow T=\frac{2\pi}{a}$$
And in our case $T_2=\pi$

Adding a constant is merely a vertical translation and leaves the periodic properties unchanged:
$$f(x+T) = f(x) \iff 1 + \cos(2(x+T)) = 1 + \cos(2x) \iff \cos(2(x+T)) = \cos(2x)$$
Therefore, the fundamental period of $f(x)$ is simply the fundamental period of $\cos(2x)$:
$$T = \frac{2\pi}{2} = \pi$$
![[Pasted image 20261012144511.png|Sketch|450]]
#### Two sinusoids
Determine the period of the following function:
$$f(x) = \sin(2x) + \cos(\pi x)$$
From the previous exercise we know that a sinusoidal has period
$$T=\frac{2\pi}a$$
So we know the two periods:
$$T_1=\frac{2\pi}{2}=\pi\qquad T_2=\frac{2\pi}\pi=2$$

Now for the final period, recall that **the sum of two periodic functions is periodic if and only if the ratio of their periods is a rational number.**
Check the ratio:
$$\frac{T_1}{T_2}=\frac\pi2\not\in \mathbb Q$$
so the function is aperiodic.

---

Now consider
$$f(x) = \sin(2x) + \cos(3 x)$$
therefore
$$\begin{align}
&T_1=\pi\\
&T_2=\frac{2\pi}3
\end{align}\qquad \frac{T_1}{T_2}=\frac32\in\mathbb Q$$
We know the function is periodic! But how is the period found? 
To find the fundamental period $T$, any common period must satisfy $f(x + T) = f(x)$ for all $x$. For the sum of two independent sinusoids, this requires $T$ to be a simultaneous integer multiple of both individual periods $T_1$ and $T_2$:
$$T = k_1 T_1 = k_2 T_2 \quad \text{for some } k_1, k_2 \in \mathbb{Z}^+$$
That is:
$$k_1 \pi = k_2 \left(\frac{2\pi}{3}\right) \implies k_1 = \frac{2}{3}k_2 \implies \frac{k_1}{k_2} = \frac{2}{3}\qquad k_1=2, k_2=3$$
and thus the period is
$$T=2\pi=3\cdot\frac{2\pi}3$$
#### 1) Arcsin
Determine domain, sign and possible symmetries and periodicity of the following function:
$$f(x) = \arcsin\left(\left\vert{}x^3 - \frac{1}{2}\right\vert{}\right)$$
Properties of $\arcsin(t)$
The $\sin$ function is not bijective (surjective but not injective) the map is $\mathbb R\rightarrow[-1,1]$. So the arcsin is defined on the restriction in which this function is strictly increasing and bijective, that is
$$\sin\Big\vert{}_{[-\frac{\pi}{2}, \, \frac{\pi}{2}]}: \left[-\frac{\pi}{2}, \, \frac{\pi}{2}\right] \longrightarrow [-1, 1] \implies \arcsin: [-1, 1] \longrightarrow \left[-\frac{\pi}{2}, \, \frac{\pi}{2}\right]$$
The domain is therefore 
$$\dom\arcsin=[-1,1]$$
The sign coincides with the sign of the argument.

Domain:
Recall that $\arcsin(t)$ is defined for $t\in[-1,1]$, so we must impose this as the domain:
$$-1 \le \left\vert{}x^3 - \frac{1}{2}\right\vert{} \le 1$$
Since the absolute value is always non-negative we have
$$\left\vert{}x^3 - \frac{1}{2}\right\vert{} \le 1\rightarrow-1 \le x^3 - \frac{1}{2} \le 1\rightarrow-\frac{1}{\sqrt[3]{2}} \le x \le \sqrt[3]{\frac{3}{2}}$$
So we have 
$$\dom f=\sq{-\frac{1}{\sqrt[3]2},\sqrt[3]{\frac32}}$$
Here we can notice that since the domain is not symmetric wrt the origin, the function does not have any symmetries, that is: A function can have symmetry **only if** its domain is symmetric with respect to the origin
$$x \in \text{dom } f \implies -x \in \text{dom } f$$

Moreover, since it has a finite domain it cannot be periodic.

Sign:
In our case since we have only positive values, the function will always be positive
$$\arcsin(t) \in \left[0, \, \frac{\pi}{2}\right] \implies \arcsin(t) \ge 0$$
The  root is at $\left\vert{}x^3 - \frac{1}{2}\right\vert{}=0\rightarrow x=\sqrt[3]\frac12$

#### 3) Exponential
Determine domain, sign and possible symmetries and periodicity of the following function:
$$f(x)=\log(e^{2x}-4e^x+4)$$
First we do a substitution, $y\def e^x$ and therefore
$$f(y)=\log(y^2-4y+4)$$
Domain:
From the log we impose $y^2-4y+4>0$
The roots are $y_{1,2}=2$ which for x becomes: 
$$\begin{align}2&=e^x\\
\log 2&=\log e^x\\
x&=\log 2
\end{align}$$
so the domain is just $\dom f=\mathbb R\setminus\curly {\log2}=(-\infty,\log2)\cup(\log2,+\infty)$
Since domain is not symmetric wrt to origin, we don't have any symmetry.

Sign:
Recall $\log(z)\geq 0\iff z\geq1$, so $$y^2-4y+4\geq 1\rightarrow y^2-4y+3\geq 0$$
The roots are $y_{1,2}=1,3\rightarrow x_{1,2}=0,\log 3$ 
The inequality holds for $x\leq 0\cup x\geq \log3$

So $f(x)\geq 0\iff x\leq 0\text{ or }x\geq \log3$
And the roots are at $x=0,\ x=\log3$

#### 7) Hyperbolic Cosine
Determine domain, sign and possible symmetries and periodicity of the following function:
$$f(x)=\frac1{\cosh(\sin(x))}$$
What is the hyperbolic cosine?
$$\cosh(t)=\frac{e^t+e^{-t}}2$$
So this is always defined and is always positive. 
This is also an even function:
$$\cosh(-t)=\frac{e^{-t}+e^t}2=\cosh(t)$$

Domain:
First define $a=\sin(x)\in[-1,1]$
The denominator cannot be 0 so
$$\cosh(a)=\frac{e^a+e^{-a}}2\not = 0$$
Which is valid $\forall a$ as $e^k>0\quad\forall k\in\mathbb R$.

So 
$$\dom f=\mathbb R$$
Sign:
Hyperbolic cosine is always positive so also this function is always positive with no zero

Symmetry:
Cosh is even $\cosh(x)=\cosh(-x)$, sin is odd $\sin(-x)=-\sin(x)$.
Try even:
$$f(-x)=\frac1{\cosh(\sin(-x))}=\frac1{\cosh(-\sin(x))}=\frac1{\cosh(\sin(x))}=f(x)$$
So it is even!

Is it periodic?
As before impose
$$f(x + T) = f(x) \quad \text{for all } x \in \mathbb{R}$$
Substituting
$$\frac{1}{\cosh(\sin(x + T))} = \frac{1}{\cosh(\sin(x))}\rightarrow\cosh(\sin(x + T)) = \cosh(\sin(x))$$



Easy way: Try period of $\sin(x)$ ($2\pi$):
$$\begin{align}
\cosh(\sin(x+2\pi))=\cosh(\sin(x))\\
\cosh(\sin(x))=\cosh(\sin(x))\\
\end{align}$$
Harder way:
Since cosh has even symmetry:
$$\cosh(t) = \cosh(-t) \implies \cosh(t) = \cosh(\vert{}t\vert{}) \quad \forall t \in \mathbb{R}$$
And therefore (prove at home):
$$\cosh(\vert{}u\vert{}) = \cosh(\vert{}v\vert{}) \iff \vert{}u\vert{} = \vert{}v\vert{}$$
And thus impose:
$$\vert{}\sin(x + T)\vert{} = \vert{}\sin(x)\vert{} \quad \forall x \in \mathbb{R}$$
Squaring both sides:
$$\sin^2(x + T) = \sin^2(x)$$
Using the identity $\sin^2(\theta) = \frac{1 - \cos(2\theta)}{2}$:
$$\frac{1 - \cos(2x + 2T)}{2} = \frac{1 - \cos(2x)}{2} \iff \cos(2x + 2T) = \cos(2x) \quad \forall x \in \mathbb{R}$$
Therefore the period is the same as $\cos(2x)$ which is $T=\pi$ and thus $2\pi$ is not the fundamental period (it is a period nonetheless).

#### 10) 
Determine domain, sign and possible symmetries and periodicity of the following function:
$$f(x)=\frac{\log(\sin(x))}{\sin(x)-1}$$
Domain:
Denominator forces $\sin(x)\not=1$ which holds for $x\not=\frac\pi2+2k\pi \quad k\in\mathbb Z$
The log forces $\sin(x)>0$ which is true for $x\in(2k\pi,\pi+2k\pi)\quad k\in\mathbb Z$
so the generic $k$-th interval is $(2k\pi,\frac\pi2+2k\pi)\cup(\frac\pi2+2k\pi,\pi+2k\pi)$
The domain is the union of all these intervals:
$$\dom f=\bigcup_{k\in\mathbb Z}(2k\pi,\frac\pi2+2k\pi)\cup(\frac\pi2+2k\pi,\pi+2k\pi)$$
which is not symmetric wrt the origin and thus there is no symmetry

Sign:
The denominator is always negative since $\max \sin(x)=1$ and thus $\max\sin(x)-1=0$ (which is excluded by domain)
The numerator is also always negative:
$$\log(\sin(x))\geq0\iff\sin(x)\geq 1\iff \sin(x)=1$$
which is excluded from the domain

Therefore this function is always positive

Periodicity:
Notice that the domain itself needs to be
periodic (or to be $\mathbb R$). In this case the domain is given by intervals given by $\sin(x)$ and it can be shifted only by $2k\pi$ to hold correctly. Therefore we can directly try with $T=2\pi$:
$$f(x + 2\pi) = \frac{\log(\sin(x + 2\pi))}{\sin(x + 2\pi) - 1} = \frac{\log(\sin(x))}{\sin(x) - 1} = f(x)$$


# 3) Lesson 23/10/26


$$\lim_{x\rightarrow 0^+}\frac{e^{2x}-1-\sin(2x)}{\sinh^2(x)+x^\frac92}$$

## 3.1) Limits
Recall the following indeterminate forms:
$$\begin{gather}
(+\infty)+(-\infty)\tag 1\\
0^\pm\cdot(\pm\infty)\tag 2\\
\frac{0^\pm}{0^\pm}\tag 3\\
\frac{\pm\infty}{\pm\infty}\tag 4
\end{gather}$$
Where $D'$ is the 
Limits at infinity are used to find asymptote. This has an equation of form:
$$y=mx+q$$
Two cases happen:
- $\lim_{x\rightarrow\infty}f(x)=c\in \mathbb R\longrightarrow$ asymptote is $y=c$ ($m=0$)
- $\lim_{x\rightarrow\infty}f(x)=\pm\infty\longrightarrow$ here we might have an oblique asymptote ($m\not=0$) or a generic divergence. The slope can be found with:
$$m=\lim_{x\rightarrow\pm\infty}\frac{f(x)}x$$
if $m=\pm\infty$ there is no asymptote, otherwise $q$ can be found as
$$q=\lim{f(x)-mx}$$
#### 1) Fraction
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.
$$f(x)=\frac{x-5}{x^2-9}$$
**Domain:**
$$D=x\in\mathbb R\setminus\curly{\pm 3}$$
**Sign:**
- Numerator $> 0\longrightarrow x> 5$
- Denominator $>0\longrightarrow x\in(-\infty,-3)\cup(3,+\infty)$

$$f(x)>0\iff x\in(-3,3)\cup(5,+\infty)$$

**Limits at infinity:**
- Positive Infinity:
$$\lim_{x\rightarrow\infty}f(x)=\frac\infty\infty\quad\text{indeterminate form !}$$
Notice that:
$$f(x)=\frac{x(1-\frac 5x)}{x^2(1-\frac9{x^2})}=\frac{(1-\frac 5x)}{x(1-\frac9{x^2})}$$
The fractional terms tend to zero ($\lim_{x\rightarrow \infty}c/x^n=0$) so
$$\lim_{x\rightarrow\infty}f(x)=\lim_{x\rightarrow\infty}\frac{(1-\frac 5x)}{x(1-\frac9{x^2})}=\frac{1-0^+}{\infty(1-0^+)}=\frac{1^-}{\infty}=0^+$$
- Negative Infinity:
$$\lim_{x\rightarrow-\infty}f(x)=\frac{1-0^-}{-\infty(1-0^-)}=\frac{1^+}{-\infty}=0^-$$
**Limits at accumulation points:**
Here the use of the sign will be useful to determine if we have $0^+$ or $0^-$ at the denominator
- At $+3$:
$$\lim_{x\rightarrow 3^+}f(x)=\frac{-2}{0^+}=-\infty$$
check also $3^-$:
$$\lim_{x\rightarrow 3^-}f(x)=\frac{-2}{0^-}=+\infty\not = \lim_{x\rightarrow 3^+}f(x)$$
So the limit doesn't exist.
- At $-3$:
$$\lim_{x\rightarrow -3^+}f(x)=\frac{-8}{0^-}=+\infty\not = \lim_{x\rightarrow -3^-}f(x)=\frac{-8}{0^+}=-\infty$$
![[Pasted image 20261022111654.png|Graph|250]]

#### 2) Oblique Asymptote
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.
$$f(x)=\frac{x^3}{x^2-1}$$
**Domain:**
$$D=x\in\mathbb R\setminus\curly{\pm 1}$$
**Sign:**
- Numerator $> 0\longrightarrow x> 0$
- Denominator $>0\longrightarrow x\in(-\infty,-1)\cup(1,+\infty)$

$$f(x)> 0\iff x\in(-1,0)\cup (1,+\infty)$$

**Limits at infinity:**
- Positive Infinity:
$$\lim_{x\rightarrow\infty}f(x)=\frac\infty\infty\quad\text{indeterminate form !}$$
Notice that:
$$f(x)=\frac{x^3}{x^2(1-\frac1{x^2})}=\frac{x}{1-\frac1{x^2}}$$
The fractional terms tend to zero ($\lim_{x\rightarrow \infty}c/x^n=0$) so
$$\lim_{x\rightarrow\infty}f(x)=\lim_{x\rightarrow\infty}\frac{x}{1-\frac1{x^2}}=\frac{\infty}{1-0^+}=\infty$$
Is there an oblique asymptote?
$$\begin{align}
m=\lim_{x\rightarrow\infty}\frac{f(x)}x=\lim_{x\rightarrow\infty}\frac1{1-\frac1{x^2}}=1\\
q=\lim_{x\rightarrow\infty}f(x)-x=\lim_{x\rightarrow\infty}\frac {1}{x(1-\frac1{x^2})}=0^+
\end{align}$$

- Negative Infinity:
$$\lim_{x\rightarrow-\infty}f(x)=\lim_{x\rightarrow-\infty}\frac{x}{1-\frac1{x^2}}=\frac{\infty}{1-0^+}=-\infty$$

Is there an oblique asymptote?
$$\begin{align}
m=\lim_{x\rightarrow-\infty}\frac{f(x)}x=\lim_{x\rightarrow-\infty}\frac1{1-\frac1{x^2}}=1\\
q=\lim_{x\rightarrow-\infty}f(x)-x=\lim_{x\rightarrow-\infty}\frac {1}{x(1-\frac1{x^2})}=0^-
\end{align}$$

**Limits at accumulation points:**
- At $+1$:
$$\lim_{x\rightarrow 1^+}f(x)=\frac{1}{0^+}=\infty\not = \lim_{x\rightarrow 1^-}f(x)=\frac{1}{0^-}=-\infty$$
- At $-1$:
$$\lim_{x\rightarrow -1^+}f(x)=\frac{-1}{0^-}=+\infty\not = \lim_{x\rightarrow -1^-}f(x)=\frac{-1}{0^+}=-\infty$$

![[Pasted image 20261022114406.png|Asymptote in Blue|350]]

#### 4) Log
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.
$$f(x)=\log\par{\frac{x+1}{x-1}}$$
**Domain:**
$$D = \curly{\frac{x+1}{x-1}>0} \cap \curly{x\not = 1} = (-\infty,-1) \cup (1,+\infty)$$
**Sign:**
 $$f(x)> 0\iff \frac{x+1}{x-1}> 1\rightarrow x>1$$
 We don't have any zero.

**Limits at infinity:**
- Positive Infinity:
$$\lim_{x\rightarrow\infty}f(x)=\log\par{\frac\infty\infty}\quad\text{indeterminate form!}$$
Notice that $\frac{x+1}{x-1}=\frac{x(1+1/x)}{x(1-1/x)}=\frac{1+\frac1x}{1-\frac1x}$ so
$$\lim_{x\rightarrow\infty}f(x)=\log(1^+)=0^+$$
where we know that the solution must be positive from the domain.
In general recall that a ratio of polynomial can be solved by just looking at the max degree of numerator and denominator!
- Negative Infinity:
$$\lim_{x\rightarrow-\infty}f(x)=\log\par{1^-}=0^-$$
sign is deduced from previous sign analysis!

**Limits at accumulation points:**
- At $1$ (only $1^+$ due to domain):
$$\lim_{x\rightarrow 1^+}f(x)=\log\par{\frac2{0^+}}=\log (+\infty)=\infty$$
- At $-1$ (only $-1^-$ due to domain):
$$\lim_{x\rightarrow -1^-}f(x)=\log\par{\frac{0^-}{-2}}=\log (0^+)=-\infty$$
![[Pasted image 20261022122003.png|Graph|250]]

#### 7) Log o Log
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.$$f(x)=\frac{\log(\log(x))}{1+\log (x)}$$**Domain:**
We have three conditions:
- Inner logarithm requires: $x > 0$
- Outer logarithm in the numerator requires: $\log(x) > 0 \implies x > 1$
- Denominator must not vanish: $1 + \log(x) \neq 0 \implies \log(x) \neq -1 \implies x \neq \frac{1}{e}$
Since $\frac{1}{e} \approx 0.37 < 1$, the condition $x \neq \frac{1}{e}$ is automatically satisfied for $x > 1$.$$D = (1, +\infty)$$**Sign:**
- Denominator: For all $x \in D = (1, +\infty)$, $\log(x) > 0$, so $1 + \log(x) > 1 > 0$ (always positive).
- Numerator:$$\log(\log(x)) > 0 \iff \log(x) > 1 \iff x > e$$

$$f(x) > 0 \iff x \in (e, +\infty)$$

**Limits at infinity:**
- Positive Infinity:$$\lim_{x\rightarrow+\infty} f(x) = \frac{+\infty}{+\infty} \quad \text{indeterminate form!}$$
Substitute $t = \log(x)$. 
As $x \to +\infty$, $t \to +\infty$:$$\lim_{t\rightarrow+\infty} \frac{\log(t)}{1+t} = \lim_{t\rightarrow+\infty} \frac{\log(t)}{t\left(1 + \frac{1}{t}\right)} = \lim_{t\rightarrow+\infty} \frac{\log(t)}{t} \cdot \frac{1}{1 + \frac{1}{t}}$$Recall the hierarchy of infinities ($\lim_{t\rightarrow+\infty} \frac{\log(t)}{t} = 0^+$):$$\lim_{x\rightarrow+\infty} f(x) = 0^+ \cdot 1 = 0^+$$

- Negative Infinity: Excluded by domain.

**Limits at accumulation points:**
- At $1$ (only $1^+$ due to domain):
Numerator: as $x \to 1^+$, $\log(x) \to 0^+ \implies \log(\log(x)) \to -\infty$
Denominator: $1 + \log(1^+) = 1 + 0^+ = 1^+$$$\lim_{x\rightarrow 1^+} f(x) = \frac{-\infty}{1^+} = -\infty$$The line $x = 1$ is a vertical asymptote from the right.

![[Pasted image 20261022150353.png|Graph|250]]

#### 8) Limited
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.$$f(x)=\frac{\sqrt{1+x}-\sqrt{1-x}}{x}$$**Domain:**
$$D = \curly{1+x\geq 0}\cap\curly{1-x\geq 0}\cap\curly{x\not = 0} = [-1, 0) \cup (0, 1] = [-1, 1] \setminus \{0\}$$**Sign:**
Two alternatives:
1) Find numerator denominator as usual (do at home):
Numerator $>0\iff x\in(0,1]$
Denominator $>0\iff x>0$
so $f(x)>0\forall x\in D$

2) Rationalize
$$\begin{align}
f(x) &= \frac{(\sqrt{1+x}-\sqrt{1-x})(\sqrt{1+x}+\sqrt{1-x})}{x(\sqrt{1+x}+\sqrt{1-x})} \\
&= \frac{(1+x) - (1-x)}{x(\sqrt{1+x}+\sqrt{1-x})} \\
&= \frac{2x}{x(\sqrt{1+x}+\sqrt{1-x})}\\
&= \frac{2}{\sqrt{1+x}+\sqrt{1-x}} \quad\par{\text{ only since }D\text{ excludes }0}
\end{align}$$
Since $\sqrt{1+x} + \sqrt{1-x} > 0$ for all $x \in [-1, 1]$:$$f(x) > 0 \quad \forall x \in D$$We don't have any zeros.

**Limits at infinity:**
Positive and Negative Infinity are excluded by domain ($D \subset [-1, 1]$, so $\pm\infty$ are not accumulation points of $D$).
There are no horizontal or oblique asymptotes.

**Limits at accumulation points:**
- At $0$:$$\lim_{x\rightarrow 0} f(x) = \frac{0}{0} \quad \text{indeterminate form!}$$
Using the rationalized form:$$\lim_{x\rightarrow 0} f(x) = \lim_{x\rightarrow 0} \frac{2}{\sqrt{1+x}+\sqrt{1-x}} = \frac{2}{\sqrt{1} + \sqrt{1}} = \frac{2}{2} = 1$$Notice that:$$\lim_{x\rightarrow 0^+} f(x) = \lim_{x\rightarrow 0^-} f(x) = 1$$So the two-sided limit exists! $x = 0$ is a removable discontinuity (eliminable singularity).
- At $+1$ (only $1^-$ due to domain): Since $1 \in D$, the function is continuous from the left:$$\lim_{x\rightarrow 1^-} f(x) = f(1) = \frac{\sqrt{2} - 0}{1} = \sqrt{2}$$
- At $-1$ (only $(-1)^+$ due to domain):Since $-1 \in D$, the function is continuous from the right:$$\lim_{x\rightarrow -1^+} f(x) = f(-1) = \frac{0 - \sqrt{2}}{-1} = \sqrt{2}$$There are no vertical asymptotes.

![[Pasted image 20261022152815.png|Graph|250]]


# 4) Lesson 26/10/26

## 4.1) Standard Limits Exercises
#### 3) Two Policemen (Harder!)
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.
$$f(x)=\log(e^{2x}-1)$$
**Domain:**
$$D=\curly{e^{2x}-1>0}=\curly{x>0}$$
**Sign:**
 $$f(x)> 0\iff e^{2x}-1> 1\rightarrow x>\frac{\log 2}2$$

**Limits at infinity:**
- Positive Infinity:
$$\lim_{x\rightarrow\infty}f(x)=\log(\infty-1)=\infty$$
Is there an oblique asymptote?
Notice how we can rewrite the logarithm:
$$f(x)=\log\sq{e^{2x}\par{1-\frac1{e^{2x}}}}=\log\par{e^{2x}}+\log\par{1-{e^{-2x}}}=2x+\log\par{1-{e^{-2x}}}$$
so we have an oblique asymptote:
$$\begin{align}
m=\lim_{x\rightarrow\infty}\frac{f(x)}x=\lim_{x\rightarrow\infty}2+\frac{\log\par{1-e^{-2x}}}{x}=2+\frac{\log(1^-)}{+\infty}=2+\frac{0^-}{+\infty}=2
\end{align}$$

Alternatively the **squeeze theorem** can be used:
$$m=\lim_{x\rightarrow\infty}\frac{f(x)}x=\lim_{x\rightarrow\infty}\frac{\log(e^{2x}-1)}{x}$$
Now find the bounds:
- Upper bound: $e^{2x}-1<e^{2x}\rightarrow \log(e^{2x}-1)<2x$
- Lower bound: $e^{2x}-1>\frac{e^{2x}}2\rightarrow \log(e^{2x}-1)>2x-\log (2)$ valid for large $x$ ($x>1$)
Now divide by $x>0$
$$2 - \frac{\log(2)}{x} \leq \frac{\log(e^{2x}-1)}{x} \leq 2$$
Take the limit:
$$2 \leq \lim_{x\rightarrow \infty}\frac{f(x)}{x} \leq 2$$
The interception is:
$$\begin{align}q=\lim_{x\rightarrow\infty} f(x)-2x&=+\infty-\infty\quad\text{indeterminate form!}\\
&=2x+\log(1-e^{-2x})-2x\\
&=\log(1-e^{-2x})=0^-
\end{align}$$


- Negative Infinity excluded by domain.


**Limits at accumulation points:**
Here we just need to check for $0^+$ as $0^-$ is not in the domain!
- At $0^+$:
$$\lim_{x\rightarrow 0^+}f(x)=\log(1^+-1)=\log (0^+)=-\infty$$

![[Pasted image 20261022120429.png|Asymptote in Blue|200]]

#### 5) Exponential (Harder)
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.$$f(x)=e^{\frac{x^2-4}{x-1}}$$**Domain:**
$$D =\curly{x-1\not = 0}= \mathbb{R}\setminus\{1\} = (-\infty, 1) \cup (1, +\infty)$$**Sign:**
Since the exponential function satisfies $e^t > 0$ for all $t \in \mathbb{R}$:$$f(x) > 0 \quad \forall x \in D$$We don't have any zeros.

**Limits at infinity:**
- Positive Infinity: 
$$\lim_{x\rightarrow+\infty} f(x) = e^{+\infty} = +\infty$$Is there an oblique asymptote?
Check the slope $m$:$$m = \lim_{x\rightarrow+\infty} \frac{f(x)}{x} = \lim_{x\rightarrow+\infty} \frac{e^{\frac{x^2-4}{x-1}}}{x}$$Notice by polynomial division that $\frac{x^2-4}{x-1} = x + 1 - \frac{3}{x-1}$, so:$$\frac{f(x)}{x} = \frac{e^{x+1} \cdot e^{-\frac{3}{x-1}}}{x} = e  \cdot e^{-\frac{3}{x-1}}\cdot \frac{e^x}{x}$$
Therefore 
$$\lim_{x\rightarrow\infty}\frac{f(x)}x=e\cdot e^{0}\cdot\infty=\infty$$There is no horizontal or oblique asymptote as $x \to +\infty$.
- Negative Infinity:
$$\lim_{x\rightarrow-\infty} f(x) = e^{-\infty} = 0^+$$We have a horizontal asymptote at $y = 0$ as $x \to -\infty$.

**Limits at accumulation points:**
- At $1$
$$\lim_{x\rightarrow 1^+} \frac{x^2-4}{x-1} = \frac{-3}{0^+} = -\infty \implies \lim_{x\rightarrow 1^+} f(x) = e^{-\infty} = 0^+$$$$\lim_{x\rightarrow 1^-} \frac{x^2-4}{x-1} = \frac{-3}{0^-} = +\infty \implies \lim_{x\rightarrow 1^-} f(x) = e^{+\infty} = +\infty$$
![[Pasted image 20261022124121.png|Graph|250]]
#### 6) Sqrt (Hardest)
Determine the natural domain, the sign, and the limits at infinity (if any) and at the accumulation points of the domain.$$f(x)=5x+2-\sqrt{25x^2+12x}$$**Domain:**
The roots are $x = -\frac{12}{25}$ and $x = 0$. Taking the external intervals:$$D =\curly{25x^2+12x\geq 0}= \left(-\infty, -\frac{12}{25}\right] \cup [0, +\infty)$$**Sign:**$$f(x) > 0 \iff \sqrt{25x^2+12x} < 5x+2$$As seen in first class (case $\sqrt{A(x)}<B(x)$) we have:$$\begin{cases} A(x) \ge 0 \\  B(x) > 0 \\  A(x) < [B(x)]^2 \end{cases} \iff \begin{cases} x \in \left(-\infty, -\frac{12}{25}\right] \cup [0, +\infty) \\  5x+2 > 0 \implies x > -\frac{2}{5} \\  25x^2+12x < 25x^2+20x+4 \implies x > -\frac{1}{2} \end{cases}$$
Then:
$$f(x)>0\iff x \in [0, +\infty)$$

**Limits at infinity:**
- Positive Infinity:$$\lim_{x\rightarrow+\infty} f(x) = (+\infty) - (+\infty) \quad \text{indeterminate form!}$$
Rationalize the expression:
To rationalize the idea is as follows:
$$a\pm\sqrt b=(a\pm\sqrt b)\frac{a\mp\sqrt b}{a\mp\sqrt b}=\frac{a^2-b}{a\mp\sqrt b}$$
Apply it directly
$$\begin{align}f(x) &=2+(\underbracket{5x}_a-\sqrt{\underbracket{25x^2+12x}_b})\\
&= 2 + \frac{(5x - \sqrt{25x^2+12x})(5x + \sqrt{25x^2+12x})}{5x + \sqrt{25x^2+12x}} \\
&= 2 + \frac{25x^2 - (25x^2+12x)}{5x + \sqrt{25x^2+12x}} \\
&= 2 - \frac{12x}{5x + \sqrt{25x^2+12x}}\\
&=2-\frac{12x}{5x+|x|\sqrt{25+\frac{12}x}}
\end{align}$$For $x > 0$, extract $|x|=x$:
$$\lim_{x\rightarrow+\infty} f(x) =\lim_{x\rightarrow+\infty}2-\frac{12}{5+\sqrt{25+\frac{12}x}}= 2 - \frac{12}{5 + 5} = \frac{4}{5}$$Since the limit is finite ($c \in \mathbb{R}$), we have a horizontal asymptote.
- Negative Infinity:$$\lim_{x\rightarrow-\infty} f(x) = 5(-\infty) + 2 - \sqrt{+\infty} = -\infty - \infty = -\infty$$
This is not indeterminate.
Is there an oblique asymptote?
Find the slope $m$ (recall now since $x<0\rightarrow |x|=-x$):
$$m = \lim_{x\rightarrow-\infty} \frac{f(x)}{x} = \lim_{x\rightarrow-\infty} \left(5 + \frac{2}{x} - \frac{\sqrt{25x^2+12x}}{x}\right)=5+\lim_{x\rightarrow-\infty}\frac{x\sqrt{25+\frac{12}x}}{x}=10$$
Now find the intercept $q$:$$q = \lim_{x\rightarrow-\infty} [f(x) - 10x] = \lim_{x\rightarrow-\infty} [2 - 5x - \sqrt{25x^2+12x}] = 2 - \lim_{x\rightarrow-\infty} \left(5x + \sqrt{25x^2+12x}\right)$$This is an indeterminate form $(-\infty) + (+\infty)$. 
Rationalize 
$$\begin{align}
5x + \sqrt{25x^2+12x}&=\par{5x + \sqrt{25x^2+12x}}\frac{5x - \sqrt{25x^2+12x}}{5x - \sqrt{25x^2+12x}}\\
&=\frac{25x^2 - \par{25x^2+12x}}{5x - \sqrt{25x^2+12x}}\\
&=\frac{-12x}{5x - \sqrt{25x^2+12x}}\\
&=\frac{-12x}{5x - |x|\sqrt{25+\frac{12}x}}
\end{align}$$
Then
$$q=2+\lim_{x\rightarrow -\infty}\frac{12x}{5x - |x|\sqrt{25+\frac{12}x}}=2+\lim_{x\rightarrow -\infty}\frac{12}{5+ \sqrt{25+\frac{12}x}}=2+\frac{12}{10}=\frac{16}5$$


We have an oblique asymptote:$$y = 10x + \frac{16}{5} \quad \text{as } x \to -\infty$$**Limits at accumulation points:**
- At $0$ (only $0^+$ due to domain):$$\lim_{x\rightarrow 0^+} f(x) = f(0) = 5(0) + 2 - 0 = 2$$
- At $-\frac{12}{25}$ (only $\left(-\frac{12}{25}\right)^-$ due to domain):$$\lim_{x\rightarrow \left(-\frac{12}{25}\right)^-} f(x) = f\left(-\frac{12}{25}\right) = 5\left(-\frac{12}{25}\right) + 2 - 0 = -\frac{12}{5} + 2 = -\frac{2}{5}$$There are no vertical asymptotes.

![[Pasted image 20261022145406.png|Asymptote in Green|250]]

## 4.2) Taylor Expansion
A **Taylor expansion** takes a smooth function $f(x)$ near a specific point $x_0$ and replaces it with a **polynomial clone** $P_n(x)$ of degree $n$, plus a tiny error term (the remainder). This is useful as it transforms complicated functions in a simple polynomial function, which are easier to manipulate
$$f(x) = \sum_{k=0}^{n} \frac{f^{(k)}(x_0)}{k!}(x - x_0)^k + o\big((x - x_0)^n\big) \quad \text{as } x \to x_0$$
But we will mostly limit our study cases at $x\rightarrow 0$ (for now)
$$f(x) = \sum_{k=0}^n \frac{f^{(k)}(0)}{k!} x^k + o(x^n) \quad \text{as } x \to 0$$
For now, since derivatives are not yet introduced, all the expansions will be provided.

Consider $f(x)=e^x$ at $x_0=0$. It's expansion is (up to order 3) $e^x = 1 + x + \frac{x^2}{2} + \frac{x^3}{6} + o(x^3)$. 
Now let's consider how well the various orders approximate $e^{0.5}=1.64872$

$$\begin{array}{cccc}
\text{Order } n & P_n(x) & P_n(0.5) & e^{0.5}-P_n(0.5) \\ \hline
0 & 1 & 1 & 0.649 \\
\color{orange}1 & 1+x & 1.5 & 0.149 \\
2 & 1+x+\frac12x^2 & 1.625 & 0.024\\
\color{red}{3} & 1+x+\frac12x^2+\frac16x^3 & 1.64583 & 0.0029
\end{array}$$
at order $3$ it is already $99.8\%$ accurate!
![[Pasted image 20261024144924.png|f(x) in black, 1st order expansion in orange, 3rd order expansion in red|350]]

### 4.2.1) Little-$o$ Notation
Little o is the correction term. This encapsulates the difference of $f(x)$ and $P_n(x)$.

>[!def] Little-$o$
Given two functions $f(x)$ and $g(x)$ near $x_0$ (with $g(x) \neq 0$ in a punctured neighborhood of $x_0$), we say that **$f(x)$ is "little-o" of $g(x)$ as $x \to x_0$**, written $f(x) = o\big(g(x)\big)$, if:
$$\lim_{x \to x_0} \frac{f(x)}{g(x)} = 0$$

This is, in the Taylor expansion writing $o(x^n)$ means that all the next order terms go to zero faster than $x^n$ and can be ignored.

For now let's just focus on $x\rightarrow 0$

Intuitively, little-$o$, refers to any function that shrinks faster then the specified function. Therefore we can say that $f(x)=o(g(x))$ is an abuse of notation as it should be $f(x)\in o(g(x))$ since $o(g(x))$ is a set that refers to all functions $h(x)$ where $h(x)\ll g(x)$

For example consider powers. As $x\rightarrow 0$ we have 
$$x^n\ll x^m\quad\text{ for }n> m$$
Therefore we can say:
- $x^3=o(x^2)$ since $\lim_{x\rightarrow 0}x^3/x^2=\lim_{x\rightarrow0}x=0$
- But not $x^2=o(x^3)$ since $\lim_{x\rightarrow 0}x^2/x^3=\lim_{x\rightarrow0}1/x=\pm\infty$

>[!thm] Little-$o$ Propeeties
>Here are some properties of little-$o$. Let $n>0$:
>- Constant Multiplication: 
>$$c\cdot o(x^n)=o(x^n)\ \text{ for any constant }c\neq 0\qquad \text{The error has the same order}$$
>- Same Order Addition/subtraction:
>$$o(x^n)\pm o(x^n)=o(x^n)\quad \text{ Important: }o(x^n)-o(x^n)\text{ is NOT =0}$$
>- Different order addition (Absorption):
>$$o(x^n)+o(x^m)=o(x^{\min(n,m)})\quad\text{Ex: }o(x^2)+o(x^4)=o(x^2)\text{ since }x^4\in o(x^2)$$
>- Absorbing Powers:
>$$c\cdot x^m+o(x^n)=o(x^n)\text{ if }m>n\quad\text{Ex: }5x^7+o(x^3)=o(x^3)\text{ since }x^7\in o(x^3)$$
>- Multiplication by powers:
>$$x^m\cdot o(x^n)=o(x^{m+n})\quad\text{Ex: }x^5\cdot o(x^3)=o(x^8)$$
>- Product of two Little-$o$'s:
>$$o(x^m)\cdot o(x^n)=o(x^{m+n})\quad\text{Ex: }o(x^2)\cdot o(x^3)=o(x^5)$$
>- Powers of Little-$o$:
>$$[o(x^n)]^k=o(x^{n\cdot k})\quad\text{Ex: }[o(x^2)]^3=o(x^6)$$

---

Proofs (very quick):
1. Constant Multiplication: $c \cdot o(x^n) = o(x^n)$ ($c \neq 0$)  
Let $f(x) \in o(x^n)$, consider $g(x) = c \cdot f(x)$:  
$$\lim_{x \to 0} \frac{g(x)}{x^n} = \lim_{x \to 0} \frac{c \cdot f(x)}{x^n} = c \cdot \lim_{x \to 0} \frac{f(x)}{x^n} = c \cdot 0 = 0$$
Therefore, $c \cdot f(x) \in o(x^n)$.  

2. Same-Order Addition / Subtraction: $o(x^n) \pm o(x^n) = o(x^n)$  
Let $f(x), g(x) \in o(x^n)$, consider $h(x) = f(x) \pm g(x)$:  
$$\lim_{x \to 0} \frac{h(x)}{x^n} = \lim_{x \to 0} \left( \frac{f(x)}{x^n} \pm \frac{g(x)}{x^n} \right) = \lim_{x \to 0} \frac{f(x)}{x^n} \pm \lim_{x \to 0} \frac{g(x)}{x^n} = 0 \pm 0 = 0$$  
Hence, $f(x) \pm g(x) \in o(x^n)$.  

3. Different-Order Addition (Absorption): $o(x^n) + o(x^m) = o(x^{\min(n,m)})$  
Assume (without loss of generality) that $n \le m$, so $\min(n, m) = n$ .  
Let $f(x) \in o(x^n)$ and $g(x) \in o(x^m)$.  
Examine the quotient with $x^n$:  
$$\lim_{x \to 0} \frac{f(x) + g(x)}{x^n} = \lim_{x \to 0} \frac{f(x)}{x^n} + \lim_{x \to 0} \frac{g(x)}{x^n}$$By assumption, $\lim_{x \to 0} \frac{f(x)}{x^n} = 0$. 
For $g(x)$, rewrite the fraction by factoring out $x^{m-n}$ (where $m - n \ge 0$):  
$$\lim_{x \to 0} \frac{g(x)}{x^n} = \lim_{x \to 0} \left( \frac{g(x)}{x^m} \cdot x^{m-n} \right) = \left(\lim_{x \to 0} \frac{g(x)}{x^m}\right) \cdot \left(\lim_{x \to 0} x^{m-n}\right) = 0 \cdot \lim_{x \to 0} x^{m-n} = 0$$
Thus:  
$$\lim_{x \to 0} \frac{f(x) + g(x)}{x^n} = 0 + 0 = 0 \implies f(x) + g(x) \in o(x^n)$$

4. Absorbing Powers: $c \cdot x^m + o(x^n) = o(x^n)$ if $m > n$  
Let $f(x) \in o(x^n)$ and $h(x) = c x^m + f(x)$ with $m > n$.  
Compute the limit:  
$$\lim_{x \to 0} \frac{h(x)}{x^n} = \lim_{x \to 0} \left( \frac{c x^m}{x^n} + \frac{f(x)}{x^n} \right) = \lim_{x \to 0} \left( c x^{m-n} + \frac{f(x)}{x^n} \right)$$
Because $m - n > 0$:  
  $$\lim_{x \to 0} c x^{m-n} = 0 \quad \text{and} \quad \lim_{x \to 0} \frac{f(x)}{x^n} = 0$$
Adding the limits yields $0 + 0 = 0$, confirming $c x^m + f(x) \in o(x^n)$.  

5. Multiplication by Powers: $x^m \cdot o(x^n) = o(x^{m+n})$  
Let $f(x) \in o(x^n)$. Consider $g(x) = x^m \cdot f(x)$:  
$$\lim_{x \to 0} \frac{g(x)}{x^{m+n}} = \lim_{x \to 0} \frac{x^m \cdot f(x)}{x^m \cdot x^n} = \lim_{x \to 0} \frac{f(x)}{x^n} = 0$$
Hence, $x^m \cdot f(x) \in o(x^{m+n})$.  

6. Product of Two Little-$o$'s: $o(x^m) \cdot o(x^n) = o(x^{m+n})$  
Let $f(x) \in o(x^m)$ and $g(x) \in o(x^n)$. Consider $h(x) = f(x) \cdot g(x)$:  
$$\lim_{x \to 0} \frac{h(x)}{x^{m+n}} = \lim_{x \to 0} \left( \frac{f(x)}{x^m} \cdot \frac{g(x)}{x^n} \right) = \left( \lim_{x \to 0} \frac{f(x)}{x^m} \right) \cdot \left( \lim_{x \to 0} \frac{g(x)}{x^n} \right) = 0 \cdot 0 = 0$$
Hence, $f(x) \cdot g(x) \in o(x^{m+n})$.  

7. Powers of Little-$o$: $[o(x^n)]^k = o(x^{n \cdot k})$ ($k \in \mathbb{N}_{\ge 1}$)  
Let $f(x) \in o(x^n)$. Consider $g(x) = [f(x)]^k$:  
$$\lim_{x \to 0} \frac{g(x)}{x^{n \cdot k}} = \lim_{x \to 0} \frac{[f(x)]^k}{(x^n)^k} = \lim_{x \to 0} \left( \frac{f(x)}{x^n} \right)^k$$
By the continuous mapping theorem (or the product rule applied $k$ times):  
$$\lim_{x \to 0} \left( \frac{f(x)}{x^n} \right)^k = \left( \lim_{x \to 0} \frac{f(x)}{x^n} \right)^k = 0^k = 0$$
Thus, $[f(x)]^k \in o(x^{n \cdot k})$.

---

## 4.3) Exercises
#### 1) Little-$o$ Warm Up Exercise:
Simplify the following expression as $x\rightarrow 0$:
$$E(x) = \left(x + 2x^2 + o(x^2)\right) - \left(x - x^2 + 4x^3 + o(x^3)\right)$$
Do the basic algebraic simplifications:
$$E(x) = 3x^2 - 4x^3 + o(x^2) - o(x^3)$$
Since $o(x^2)+o(x^3)=o(x^2)$ we have
$$E(x) = 3x^2 - 4x^3 + o(x^2)$$
But notice that now $4x^3\in o(x^2)$ and thus
$$E(x)=3x^2+o(x^2)$$
#### 2) Classic Cancellation Limit
Compute the limit:
$$\lim_{x \to 0} \frac{\sin(x) - x}{x^3}$$
Recall the expansion for $\sin$:
$$\sin(x)={\displaystyle \displaystyle \sum _{n=0}^{\infty }(-1)^{n}{\frac {x^{2n+1}}{(2n+1)!}}=x-{\frac {x^{3}}{3!}}+{\frac {x^{5}}{5!}}-\cdots }$$

---

This cannot be computed via the notable limit since:
$$\lim_{x \to 0} \frac{\sin(x) - x}{x^3}=\lim_{x \to 0} \frac{\sin(x)}{x^3}-\frac1{x^2}=\lim_{x\rightarrow 0}\frac{\sin(x)}{x}\cdot\frac1{x^2}-\frac1{x^2}$$
Where it is known that $\lim_{x\rightarrow 0}\sin(x)/x=1$ therefore:
$$\lim_{x\rightarrow 0}\frac{\sin(x)}{x}\cdot\frac1{x^2}-\frac1{x^2}=\lim_{x\rightarrow 0}\frac1{x^2}-\frac1{x^2}=0$$
But the last step is illegal, as the limit cannot be evaluated partially (that is we cannot simplify out $\sin(x)/x$ but keep $1/x^2$)

Try with order $1$ expansion:
$$\lim_{x \to 0} \frac{\sin(x) - x}{x^3}=\lim_{x \to 0} \frac{x+o(x) - x}{x^3}=\lim_{x \to 0} \frac{o(x)}{x^3}$$
but since $o(x)/x^3=x^{-3}o(x)=o(x^{-2})$ we cannot determine it.

Since the denominator is of order $3$, we expand until this order:
$$\lim_{x\rightarrow 0}\frac{x-\frac{x^3}6+o(x^3)-x}{x^3}=\lim_{x\rightarrow 0}\frac{-\frac{x^3}6+o(x^3)}{x^3}=\lim_{x\rightarrow 0}-\frac16-\frac{o(x^3)}{x^3}=-\frac16-0=-\frac16$$
since $o(x^3)/x^3=x^{-3}o(x^3)=o(1)\rightarrow 0$ as $x\rightarrow 0$ and more in general $\lim_{x\rightarrow 0}o(x^n)/x^m=0$ if $n\geq m$.

#### 3) Two Expansions:
Compute the limit:
$$\lim_{x \to 0} \frac{e^x - \cos(x) - x}{x^2}$$
Recall both expansions:
$$\begin{align}
e^x&={\displaystyle \displaystyle \sum _{n=0}^{\infty }{\frac {x^{n}}{n!}}=1+x+{\frac {x^{2}}{2!}}+{\frac {x^{3}}{3!}}+\cdots }\\
\cos(x)&={\displaystyle \displaystyle \sum _{n=0}^{\infty }(-1)^{n}{\frac {x^{2n}}{(2n)!}}=1-{\frac {x^{2}}{2!}}+{\frac {x^{4}}{4!}}-\cdots }
\end{align}$$

Apply them until order $2$
$$\begin{align}
e^x - \cos(x) - x &= \left(1 + x + \frac{x^2}{2} + o(x^2)\right) - \left(1 - \frac{x^2}{2} + o(x^2)\right) - x\\
&=1-1+x-x+\frac{x^2}2+\frac{x^2}2+o(x^2)+o(x^2)\\
&=x^2+o(x^2)
\end{align}$$
Then the limit becomes:
$$\lim_{x \to 0} \frac{e^x - \cos(x) - x}{x^2}=\lim_{x \to 0}\frac{x^2+o(x^2)}{x^2} =1+0=1$$
#### 4) Substitution
Find the Taylor expansion of order $4$ at $x_0 = 0$ for $g(x) = e^{-x^2}$ and use it to compute:
$$\lim_{x \to 0} \frac{e^{-x^2} - \cos(x)}{x^4}$$
Recall both expansions:
$$\begin{align}
e^x&={\displaystyle \displaystyle \sum _{n=0}^{\infty }{\frac {x^{n}}{n!}}=1+x+{\frac {x^{2}}{2!}}+{\frac {x^{3}}{3!}}+\cdots }\\
\cos(x)&={\displaystyle \displaystyle \sum _{n=0}^{\infty }(-1)^{n}{\frac {x^{2n}}{(2n)!}}=1-{\frac {x^{2}}{2!}}+{\frac {x^{4}}{4!}}-\cdots }
\end{align}$$

We need to expand up to order $4$. For cosine it is known, but $e^{-x^2}$ doesn't have the basic formula.
Notice that with $t=-x^2$ we can expand $e^t$ up to order $2$ (since $o(t^2)\rightarrow o(x^{4})$). This can be done since both tend to 0 as $x\rightarrow 0$
$$e^t = 1 + t + \frac{t^2}{2} + o(t^2)\rightarrow e^{-x^2}=1-x^2+\frac{x^4}2+o(x^4)$$
Now expand the limit:
$$\begin{align}
\lim_{x \to 0} \frac{e^{-x^2} - \cos(x)}{x^4}&=\lim_{x\rightarrow 0}\frac{1-x^2+\frac{x^4}2+o(x^4)-1+\frac{x^2}2-\frac{x^4}{24}-o(x^4)}{x^4}\\
&=\lim_{x\rightarrow 0}\frac{-\frac12x^2+\frac{11}{24}x^4+o(x^4)}{x^4}\\
&=\lim_{x\rightarrow 0}\frac{11}{24}-\frac1{2x^2}+\frac{o(x^4)}{x^4}\\
&=\frac{11}{24}-\infty+0\\&=-\infty
\end{align}$$

#### 5) Exam 12.09.22
Compute the limit $\forall \alpha\in\mathbb R$:
$$\lim_{x\rightarrow 0^+}\frac{\sin x-\alpha x+\frac16\alpha x^3}{\arctan(x^2+4x^3)}$$
First recall the standard expansions:
$$\begin{align}
\sin(x) = x - \frac{x^3}{6} + \frac{x^5}{120} + o(x^5)\\
\arctan(x) = x-\frac{x^3}3+\frac{x^5}5 + o(x^5)
\end{align}$$
Since the highest order degree is $x^3$ we expand at order $3$:
Numerator:
$$\sin x-\alpha x+\frac\alpha6x^3=x-\frac{x^3}6-\alpha x+\frac\alpha6x^3+o(x^3)=(1-\alpha)x+\frac{\alpha-1}6x^3+o(x^3)$$
Denominator:
Use the substitution $t=x^2+4x^3$ (again since both t and x tend to $0$ as they go to $0^+$) and expand only until first order since $o(t)=o(x^2+4x^3)=o(x^3)$
$$\arctan t=t+o(t)=x^2+4x^3+o(x^3)$$
Now rewrite the entire limit:
$$\lim_{x\rightarrow 0^+}\frac{\sin x-\alpha x+\frac16\alpha x^3}{\arctan(x^2+4x^3)}=\lim_{x\rightarrow 0^+}\frac{(1-\alpha)x+\frac{\alpha-1}6x^3+o(x^3)}{x^2+4x^3+o(x^3)}$$

- Case $\alpha=1$ (since obviously simplifies a lot)
$$\begin{align}
\lim_{x\rightarrow 0^+}\frac{o(x^3)}{x^2+4x^3+o(x^3)}&=\lim_{x\rightarrow 0^+}\frac{o(x^3)}{x^2(1+4x+\frac{o(x^3)}{x^2})}\\
&=\lim_{x\rightarrow 0^+}\frac{o(x^3)}{x^2}\cdot\frac1{1+4x+\frac{o(x^3)}{x^2}}\\
&=0\cdot\frac1{1+0+0}=0
\end{align}$$
- Case $\alpha\neq1$
Now analyze the three parts of the limit:
$$\begin{align}
&\lim_{x\rightarrow 0^+}\frac{(1-\alpha)x}{x^2+4x^3+o(x^3)}=\lim_{x\rightarrow 0^+}\frac{(1-\alpha)}{x+4x^2+{o(x^2)}}=\frac{\text{constant}}{0^++0^++0^+}=
\begin{cases}
\infty&\text{if }\alpha<1\\
-\infty&\text{if }\alpha>1
\end{cases}\\
&\lim_{x\rightarrow 0^+}\frac{\frac{\alpha-1}6x^3}{x^2+4x^3+o(x^3)}=\lim_{x\rightarrow 0^+}\frac{\frac{\alpha-1}6x}{1+4x+{o(x)}}=\frac{\text{constant}\cdot0^+}{1+0^++0^+}=0^+\\
&\lim_{x\rightarrow 0^+}\frac{o(x^3)}{x^2+4x^3+o(x^3)}=0
\end{align}$$

So the final result is 
$$\lim_{x \to 0^+} \frac{\sin(x) - \alpha x + \frac{1}{6}\alpha x^3}{\arctan(x^2 + 4x^3)} = \begin{cases} +\infty & \text{if } \alpha < 1 \\ 0 & \text{if } \alpha = 1 \\ -\infty & \text{if } \alpha > 1 \end{cases}$$


Alternatively notice it can be rewritten as
$$\lim_{x \to 0^+} \frac{x \left[ (1-\alpha) + \frac{\alpha-1}{6}x^2 + \frac{o(x^3)}{x} \right]}{x \left[ x + 4x^2 + \frac{o(x^3)}{x} \right]}=\lim_{x\rightarrow 0^+}\frac{1-\alpha+\frac{\alpha-1}6x^2+o(x^2)}{x+4x^2+o(x^2)}$$
Which can be easily computed.


# 5) Symbols
- $\implies$: implies, sufficient condition ($P \implies Q$ means $P$ is sufficient for $Q$, $Q$ is necessary for $P$).
- $\impliedby$: implied by, necessary condition
- $\iff$: necessary + sufficient, if and only if "iff"

- $\emptyset$: empty set
- $\mathbb N$: natural numbers; $\curly{0,1,2,...}$
- $\mathbb Z$: integer numbers; $\curly{...,-2,-1,0,1,2,...}$
- $\mathbb Q$: rational numbers; $\curly{\frac mn\ m,n\in\mathbb Z, n\not = 0}$
- $\mathbb R$: real numbers
- $\mathbb C$: complex numbers

- $\cup$: Union; or
- $\cap$: Intersection; and

- $\exists$: there exists