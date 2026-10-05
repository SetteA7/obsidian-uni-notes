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
Consider the following inqueality:
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
Consider the following:
$$A=S_1\cap S_2=\curly{x\in\mathbb R: x^2+4x+13<0}\cap\curly{x\in\mathbb R: 3x^2+5>0}$$
Subset 1:
$$x^2+4x+13<0\rightarrow \Delta=-36 \implies S_1=\emptyset $$
any intersection with an empty set is an empty set:
$$\boxed{A=\emptyset\ \cap\ S_2=\emptyset}$$

In general recall:
$$\emptyset\cap S=\emptyset\qquad \emptyset\cup S=S$$

----

#### **Ex c)**
Consider the following:
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

>[!def|*] Upper Bound
>$M\in \mathbb Q$ is called **upper bound** for $A$ if $M\geq a$



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

- $\cup$: Union; and
- $\cap$: Intersection; or  