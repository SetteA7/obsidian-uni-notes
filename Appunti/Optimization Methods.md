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
$$\text{Primal}=\begin{cases}
\displaystyle\min\sum_{j=1}^qc_jx_j\\
\displaystyle s.t. \sum_{j=1}^qa_{ij}x_j\geq b_i\ &\forall i=1,...,p\\
x_j\in\mathbb R_+\ &\forall j=1,..,p
\end{cases}$$
Now let $\pi_i\in\mathbb R$ be a dual variable associated to i-th constraint. The dual of the primal problem is:
$$\text{Dual}=\begin{cases}
\displaystyle \max\sum_{i=1}^pb_i\pi_i\\
\displaystyle s.t. \sum_{i=1}^pa_{ij}\pi_i\leq c_j\ &\forall j=1,...,q\\
\pi_i\in\mathbb R_+\ &\forall i=1,..,p
\end{cases}$$
Moreover also $\forall\leftrightarrow\sum$.

Example:
$$\begin{cases}
\min &\displaystyle\sum_{i\in O}\sum_{j\in D}c_{ij}x_{ij}\\
s.t. &\displaystyle\sum_{j\in D}x_{ij}\leq s_i\ &\forall i\in O, [u_i]\\
&\displaystyle\sum_{i\in O}x_{ij}=d_j&\forall j\in D, [v_j]\\
&x_{ij}\in\mathbb R_+\ &\forall i\in O,\ \forall j\in D
\end{cases}
\leftrightarrow 
\begin{cases}
\max &\displaystyle\sum_{i\in O}s_iu_i+\sum_{j\in D}d_jv_j\\
s.t. &\displaystyle u_i+v_j\leq c_{ij} &\forall i\in O,\ \forall j\in D\\
& u_i\in \mathbb R_-& \forall i\in O\\
& v_j\in \mathbb R& \forall j\in D\\
\end{cases}
$$
This has 12 variables and 2 _sets_ of constraints (7 constraints total). I have called vectors $u,v$ the sets of constraints to define the 7 dual variables. 

The first part ($\min\leftrightarrow\max$) is done as we convert from from 12 primal variables ($O\cdot D$) to 7 dual variables ($O+D$).

$$\begin{cases}
\min &c_{11}x_{11}&+c_{12}x_{12}&+c_{13}x_{13}&+c_{14}x_{14}+c_{21}x_{21}+c_{22}x_{22}+c_{23}x_{23}+c_{24}x_{24}+c_{31}x_{31}+c_{32}x_{32}+c_{33}x_{33}+c_{34}x_{34}\\
s.t. &x_{11}&+x_{12}+&x_{13}&+x_{14}\leq s_1\\
x_{21}+x_{22}+x_{23}+x_{24}\leq s_2\\
x_{31}+x_{32}+x_{33}+x_{34}\leq s_3\\
s.t. x_{11}+x_{21}+x_{31}=d_1\\
x_{12}+x_{22}+x_{32}=d_2\\
x_{13}+x_{23}+x_{33}=d_3\\
x_{14}+x_{24}+x_{34}=d_4
\end{cases}$$

look one column at a time: chose $c_{ij}$, see the coefficients of associated constraints and multiply by $u,v$
For example $c_{11}$