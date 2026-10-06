# 1) Lesson 1
## 1.1) Inequalities
In general: $\log_2$
1) Find domain $D$
2) Rewrite so that it is function bigger/smaller than 0
3) Divide in different products and analyze them individually
	1) find zeroes
	2) study sign
4) Final sign analysis

From bolzano weierstrass theorem (you will see this later) we have that every intersection at 0, that is, at every zero of the function. there is a change of sign.

3 main cases:
$$\begin{align}
&\frac{A(x)}{B(x)}\geq 0 &&\text{Study sign of both}\\
&\sqrt{A(x)}\geq B(x) &&\text{Add condition: } B(x)\geq 0\\
&|A(x)|\geq 0 &&\text{Divide using abs. value definition: }\begin{cases}A(x)&A(x)\geq 0\\-A(x)&A(x)<0\end{cases}
\end{align}$$

####  **Ex c)**
Solve the following inequality:
$$\frac{x - 1}{x - 2} > \frac{2x - 3}{x - 3}$$

First find the domain:
$$D=x\in\mathbb R\setminus\curly{2,3}$$
Now compute
$$\frac{x - 1}{x - 2} - \frac{2x - 3}{x - 3} > 0 \implies \frac{(x-1)(x-3) - (2x-3)(x-2)}{(x-2)(x-3)} > 0$$
This is $>0$ if numerator and denominator share the same sign, that is, where the function is positive.

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

In this case since $\Delta = 9 - 12 = -3 < 0$ we don't have any solutions, hence since $a<0$ the whole numerator is negative.

**Denominator:**
Here the function already shows the zeroes, so we can plot the graph to see the regions:

![[Pasted image 20261005144306.png|Curve|250]]

 
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

#### Ex i)
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
Each system can be solved independently from the other, just the result must be intersected ($\cap$) with the condition of the system.

**Solve first equation:**
Here we have a problem, since $x$ can be negative:
$$\sqrt{x^2-4}\geq x$$
clearly if it is negative then then it is always true, so we have already found some solutions $x\leq -2$

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

It is immediately clear that $A$ is the union of two sets, mainly
$$A=S_1\cup S_2\text{ where } \quad \begin{align}
&S_1 = \{n \in \mathbb{N} \setminus \{0\}\} = \{1, 2, 3, 4, \dots\}\\
&S_2 = \left\{\frac{1}{n^2} \mid n \in \mathbb{N} \setminus \{0\}\right\} = \left\{1, \frac{1}{4}, \frac{1}{9}, \frac{1}{16}, \dots\right\}
\end{align}$$

Find the bounds on both sets individually (not required but the result is clearer).

**Study the first subset $S_1$:** notice that it is just the natural numbers with zero excluded, so its properties are already known.
- No upper bound, so also no max or sup
- Lower bound: $m_1\leq 1$
	- $\overline m_1=\max m_1\leq 1=1\in S$ which is also the infimum!

**Study the second subset $S_2$:** Intuitively we know that the function describing the set is monotonically decreasing: we can express it by saying:

Call $x_n$ the value of x for any chosen $n$, then $x_{n+1}<x_n$.
This is easily shown as the following inequality is true for $n\in \mathbb N\setminus \curly 0$ (check at home):
$$\frac{1}{(n+1)^2}<\frac1{n^2}$$
Therefore for every number $x_n>0$ we can find a smaller number such that $0<x_{n+1}<x_n$

With this digression aside, we also know that $0\not \in S_2$.
As before analyze:
- Lower bound: $m_2\leq 0$
	- No minimum: $\overline m_2=\max m_2\leq 0=0\not \in S_2$
	- Infimum is $\text{inf }S_2=0$
- Upper bound: $M_2\geq 1$
	- $\overline M_2=\min M_2\geq 1=1\in S_2$ which is also supremum!


**Putting all together:**
Now consider the union, so:
- No upper bound since $S_1$ is unbounded
	- therefore no max and sup
- Lower bound: the minimum of the two lower bounds is $m\leq 0$
	- no minimum since $0\not in A$
	- Infimum is $\text{inf }A=0$



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

- $\exists$: there exists