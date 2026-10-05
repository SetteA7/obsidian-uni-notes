# 1) Lesson 1
## 1.1) Inequalities
- **c)**
$$\frac{x - 1}{x - 2} > \frac{2x - 3}{x - 3}$$
First find the domain:
$$D=x\in\mathbb R/\curly{2,3}$$
Now compute
$$\frac{x - 1}{x - 2} - \frac{2x - 3}{x - 3} > 0 \implies \frac{(x-1)(x-3) - (2x-3)(x-2)}{(x-2)(x-3)} > 0$$
This is $>0$ if numerator and denominator share the same sign, that is, where the function is positive:
**Numerator:**
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
$$2<x<3$$

## 1.2) Subsets of $\mathbb R$
- **a)**
$$A=S_1\cap S_2=\curly{x\in\mathbb R: x^2+4x+13<0}\cap\curly{x\in\mathbb R: 3x^2+5>0}$$
Subset 1:
$$x^2+4x+13<0\rightarrow \Delta=-36 \implies S_1=\emptyset $$
any intersection with an empty set is an empty set:
$$A=\emptyset\ \cap\ S_2=\emptyset$$
# 2) Symbols
- $\implies$: implies, necessary condition
- $\impliedby$: implied by, sufficient condition
- $\iff$: necessary + sufficient, if and only if "iff"