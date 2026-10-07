# 1) Lesson 1
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
Now notice that the sqrt is always positive, so when $x+2<0\rightarrow x<-2$ the disequality is satisfied.
That is, our first part of the result includes the part of the domain less than $-2$
$$S_1=D\cap\curly{x<-2}=\curly{x<-2}$$


Now for $x\geq-2$ square of both sides:
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

**Solve first equation:**
Recall that when LHS (x) is negative there is always a solution.
$$\sqrt{x^2-4}\geq x$$
Therefore one part of the solution includes $x<0$ when 


Now study in the interval $x\geq 2$: since we are sure that both sides are $\geq0$ we can square both sides:
$$x^2-4\geq x^2\rightarrow -4\geq 0$$
Not possible, so the only solution to this part is $x\leq -2$

**Solve the second equation:**
As before a solution always exists for $x\geq 0$. Now consider only the positive values ($x\geq 0$) in order to be able to square both sides:
$$\sqrt{4-x^2}\geq x\rightarrow 4-x^2\geq x^2\rightarrow 4-2x^2\geq 0\rightarrow -\sqrt 2<x<\sqrt 2$$
So recap:
- solution always exists for $x\leq 0$
- for positive $x$ the solution is $x\in [-\sqrt 2,\sqrt 2]$
- All this with $x\in[-2,2]$ from the initial system
Here it is clear that the union results in $x\in[-2,\sqrt 2]$.

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



# 2) Symbols
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