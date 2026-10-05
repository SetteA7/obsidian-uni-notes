# 1) Lesson 1

In general:
1) Find domain $D$
2) Rewrite so that it is function bigger/smaller than 0
3) Divide in different products and analyze them individually
	1) find zeroes
	2) study sign
4) Final sign analysis
## 1.1) Inequalities
####  **Ex c)**
Solve the following inqueality:
$$\frac{x - 1}{x - 2} > \frac{2x - 3}{x - 3}$$

First find the domain:
$$D=x\in\mathbb R\setminus\curly{2,3}$$
Now compute
$$\frac{x - 1}{x - 2} - \frac{2x - 3}{x - 3} > 0 \implies \frac{(x-1)(x-3) - (2x-3)(x-2)}{(x-2)(x-3)} > 0$$
This is $>0$ if numerator and denominator share the same sign, that is, where the function is positive:
**Numerator:**
First we find the zeroes of the numerator function:
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

In this case since $\Delta = 9 - 12 = -3 < 0$ we have that since $a<0$, then the whole numerator is negative.

The sign analysis of the numerator is therefore also complete:

**Denominator:**
Here the function already shows the zeroes, so we can plot the graph to see the regions:
 TODO DRAWING
 
 So we have 
 $$D>0\iff x<2\ \cup\ x>3$$

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


Consider the following:


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
The domain is $7x+1\geq 0\rightarrow D=\curly{x\leq 17}$
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
>Reespectively it is called **lower bound** if $M\leq a,\forall a\in A$

Notice $M$ does not need to be in $A$
Example: consider set $A=[0,1)$ any $m\leq0$ is a lower bound and any $M\geq 1$ is upper bound

>[!def|*] Maximum/Minimum of $A$
>If $\overline M$ is an upper bound for $A$ and $\overline M\in A$, if $\overline M$ is the *minimum* possible *upper* bound, then it is the **maximum** of $A$.
>
>If $\overline M$ is an upper bound for $A$ and $\overline M\in A$, if $\overline M$ is the *maximum* possible *lower* bound, then it is the **minimum** of $A$.

In this case $\overline M\in A$ by definition. 
From the previous example: $\overline m =\max\curly{m\leq 0}=0\in A$ is the correct minimum of $A$, however $\overline M =\min\curly{M\geq 1}=1\not\in A$ means that we don't have a maximum

>[!def|*] Supremum/Infimum
>The **supremum of $A$** $\text{sup } A$ is the minimum of the upper bounds of $A$. If a set allows for a maximum, then it is also the supremum
>
>The **infumum of $A$** $\text{inf } A$ is the maximum of the lower bounds of $A$. If a set allows for a minimum, then it is also the infimum.

Finish the example: we know $\overline m=0\in A$ so this is both minimum and infimum of $A$. We know also $\overline M=1\not \in A$, therefore $\text{sup A}=1$ but it is not the maximum.

#### Ex a)
Tell wether this subsets is bounded and the sup/inf and if it allow for maximum/minimum.
$$A=\curly{x\in\mathbb R: x=n\text{ or } x=\frac1{n^2},n\in N\setminus\curly 0}$$
First get an idea of what this set is. It is the union of two sets, mainly
$$S_1=\curly{x\in R:x=n, n\in N\setminus \curly 0}=\curly{\mathbb N\setminus \curly 0}$$
$$S_2=\curly{x\in\mathbb R: x=\frac1{n^2},n\in N\setminus\curly 0}$$

Find the bounds on both sets individually (not required but the result is clearer)
$S_1$: This is just the natural numbers without $0$:
Lower bounded: yes; $m_1\leq 1$
Upper bounded: no $\not \exists M_1$

Minimum: $\overline m_1=\max m_1\geq 1=1\in S_1$ (it is also inf)
Maximum: no

Inf: $\text{inf } S_1=1$
Sup: no

$S_2$:
Intuitively we know that the function describing the set is monotonically decreasing: we can express it by saying:

Call $x_n$ the value of x for any chosen $n$, then $x_{n+1}<x_n$.
This is easily shown as the following inequality is true for $n\in \mathbb N\setminus \curly 0$ (check at home):
$$\frac{1}{(n+1)^2}<\frac1{n^2}$$
Therefore for every number $x_n>0$ we can find a smaller number such that $0<x_{n+1}<x_n$

With this digression aside, we also know that $0\not \in S_2$. Now we say:
Lower bounded: yes; $m_1\leq 0$
Upper bounded: yes, just see value of $x_1$ $\not \exists M_1$


Minimum: $\overline m_1=\max m_1\geq 1=1\in S_1$ (it is also inf)
Maximum: no

# 2) Symbols
- $\implies$: implies, necessary condition
- $\impliedby$: implied by, sufficient condition
- $\iff$: necessary + sufficient, if and only if "iff"

- $\emptyset$: empty set
- $\mathbb N$: natural numbers; $\curly{0,1,2,...}$
- $\mathbb Z$: integer numbers; $\curly{,...,-2,-1,0,1,2,...,}$
- $\mathbb Q$: rational numbers; $\curly{\frac mn\ m,n\in\mathbb Z, n\not = 0}$
- $\mathbb R$: real numbers
- $\mathbb C$: complex numbers

- $\cup$: Union; or
- $\cap$: Intersection; and