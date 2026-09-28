Informal definition of optimization
$$\text{Choose the best decision whose outcome can be measured}$$
That is
$$P=\begin{cases}\min\max f(x)\\
S\\
x\in D
\end{cases}$$

Call $S$ the set of constraints, in this course by an algebraic identity (ex. $g_i(x)\leq 0, \ i = 1,...,m$)
- Feasible $F(P)\not=\emptyset$ 
- Bounded
- Existence of optimal solution

A problem can be feasible and bounded but it might not have an optimal solution
$$\begin{cases}\min e^{-x}\\ x\geq 0 \end{cases}\rightarrow\text{no optimal solution } (x\rightarrow \infty)$$

# 1) Linear Programming
Example
$$LP=\begin{cases}\min\max c^Tx\\
a_i^Tx-b_i\leq 0, & i=1,...,m\\
l_j\leq x_j\leq u_j& j=1,...,n
\end{cases}$$

# 2) MIP Modeling
$$MIP=\begin{cases}\min\max c^Tx\\
a_i^Tx-b_i\leq 0, & i=1,...,m\\
x_j\in \mathbb Z& j=1,...,n
\end{cases}$$