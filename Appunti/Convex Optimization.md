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

## 1.1) Linear Programming (LP)
A linear program consists in the minimization of a linear function subject to a finite list of linear constraints. In general we have the form:
$$LP=\begin{cases}\min c^Tx\\
a_i^Tx\sim b_i, & i=1,...,m\\
l_j\leq x_j\leq u_j& j=1,...,n
\end{cases}$$
That is $D_j$ is an interval in $\R$. Notice that the constraint $a_i^Tx\sim b_i$ is the same as $a_i^Tx- b_i\leq 0$

#### Integer Linear Programming (MIP)
This allows only for discrete decisions ($x_j\in\mathcal Z$) by adding an additional constraint.
$$MIP=\begin{cases}\min c^Tx\\
a_i^Tx\sim b_i, & i=1,...,m\\
x_j\in \mathbb Z& j=1,...,n\\
\end{cases}$$
## 1.2) Convex Optimization
Adds non-linearity, for convex functions it keeps the LP properties. In general it has the form
$$\begin{cases}\min f(x)\\
g_i(x)\leq b_i, & i=1,...,m\\
l_j\leq x_j\leq u_j& j=1,...,n
\end{cases}$$
where $f(x),g_i(x)$ are required to be convex.

## 1.3) Linear Quadratic Regulator (TODO)


# 2) Convexity
## 2.1) Affine Combinations
Lets start with the definition of affine combination:

>[!def|*] Affine Combination
>Given two points $x_1,x_2\in\R$ we call affine combination the point obtained as $y=\theta_1x_1+\theta_2x_2$  satisfying the condition $\theta_1+\theta_2=1$
>
>In general for $m$ points $x_1,...,x_m\in\R$ and $m$ multipliers $\theta_1,...,\theta_m$ such that $\sum_{i=1}^m\theta_i=1$

A set is affine if it contains any affine combination of its points

A linear sub-space is affine, however containing the origin is too much of a restriction, so

>[!thm|*] Affine Set
>Any affine set $C$ can be expressed as $C=V+x_0$ where $x_0\in C$ and $V$ a vector subspace.

Moreover it is possible to "attach" an affine set to any ordinary set, this is called the **hull of a set**

>[!def|*] Hull
>Given an arbitrary set $C$ (not affine), we define the affine hull $aff(C)$ as all points that can be obtained as an affine combination of elements of $C$

## 2.2) Convex Combinations
A convex combination is just an affine combination where $\theta_i\in\R$.
The consequence is that now the combination is not the line passing through the points, but the segment having these points as endpoints.