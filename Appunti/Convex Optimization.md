# 1) Intro
Informal definition of optimization
$$\text{Choose the best decision whose outcome can be measured}$$
An optimization problem $P$ can be generally expressed as (min can be exchanged with max)
$$P=\begin{cases}\min f(x)\\
S\\
x\in D
\end{cases}$$
Where
- $f(x)$ is a real valued function
- $D$ is the domain of $x$, if $x=(x_1,...,x_n)$ is a tuple, then $D=D_1\times...\times D_n$ and $x_j\in D_j$
- $S$ is the constraint, in this course it is an algebraic identity (ex. $g_i(x)\leq 0, \ i = 1,...,m$)


Any $x\in D$ is a solution of $P$ and can be classified as:
- Feasible: satisfies $S$, the set of feasible solutions is $F(P)$
- Feasible + Optimal: if $f(x^*)\leq f(x)\ \forall x\in F(P)$ and $x^*\in F(P)$ is the optimal solution, it is not necessarily unique
- Infeasible: $F(P)=\emptyset$
	- Unbounded: it has no lower limit on $f(x)$ for $x\in F(P)$


A problem can be feasible and bounded but it might not have an optimal solution
$$\begin{cases}\min e^{-x}\\ x\geq 0 \end{cases}\rightarrow\text{no optimal solution } (x\rightarrow \infty)$$

# 2) Linear Programming (LP)
A linear program consists in the minimization of a linear function subject to a finite list of linear constraints. In general we have the form:
$$LP=\begin{cases}\min c^Tx\\
a_i^Tx\sim b_i, & i=1,...,m\\
l_j\leq x_j\leq u_j& j=1,...,n
\end{cases}$$
That is $D_j$ is an interval in $\R$. Notice that the constraint

#### Integer Linear Programming (MIP)
This allows only for discrete decisions ($x_j\in\mathcal Z$) by adding an additional constraint.

# 3) MIP Modeling
$$MIP=\begin{cases}\min c^Tx\\
a_i^Tx\sim b_i, & i=1,...,m\\
x_j\in \mathbb Z& j=1,...,n
\end{cases}$$