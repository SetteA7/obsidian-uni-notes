# 1) Intro
$$\underbracket G_{\text{Graph}}=(\underbracket N_{\text{Node Set}}, \underbracket A_{\text{Arc Set}})$$
With:
- $N=\curly{1,2,...,}$, $|N|=n$
- $A=\curly{(0,0), \ (0,1),..., (i,j)}$ $\forall i,j\in N$, $|A|=m$
- $c_{ij}$ unit cost
- $l_{ij}$ lower bound
- $u_{ij}$ upper bound (capacity)
- $b_i\in\mathbb Z$, $\sum_i b_i=0$: 
	- $b_i>0$: Supply Node
	- $b_i<0$: Demand Node
	- $b_i=0$ Transshipment Node



# 2) Linear Programming (LP)
#### Dual Problem
Let the primal problem be
$$\begin{cases}
\min\sum_{j=1}^qc_jx_j\\
s.t. \sum_{j=1}^qa_{ij}x_j\geq b_i\ &\forall i=1,...,p\\
x_j\in\mathbb R_+\ &\forall j=1,..,p
\end{cases}$$
Now let $\pi_i\in\mathbb R$ be a dual variable associated to i-th constraint. The dual of the primal problem is:
$$\begin{cases}
\min\sum_{i=1}^pb_i\pi_i\\
s.t. \sum_{i=1}^pa_{ij}\pi_i\leq c_j\ &\forall j=1,...,q\\
x_j\in\mathbb R_+\ &\forall i=1,..,p
\end{cases}$$
