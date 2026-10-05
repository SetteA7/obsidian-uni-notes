# 1) Lesson 1
## 1.1) Inequalities
- **c)**
$$\frac{x - 1}{x - 2} > \frac{2x - 3}{x - 3}$$
First find the domain:
$$D=x\in\mathbb R/\curly{2,3}$$
Now compute
$$\frac{x - 1}{x - 2} - \frac{2x - 3}{x - 3} > 0 \implies \frac{(x-1)(x-3) - (2x-3)(x-2)}{(x-2)(x-3)} > 0$$
This is $>0$ if numerator and denominator share the same sign:
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

By noti