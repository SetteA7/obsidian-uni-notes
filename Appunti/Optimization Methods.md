Domande Teoriche che ha fatto:
Weal duality, complementary slackness, minimax proble
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
\min &c_{11}x_{11}&+c_{12}x_{12}&+c_{13}x_{13}&+c_{14}x_{14}&+c_{21}x_{21}&+c_{22}x_{22}&+c_{23}x_{23}&+c_{24}x_{24}\\
s.t. &x_{11}&+x_{12}&+x_{13}&+x_{14}&&&&&\leq s_1\\
&&&&&\quad x_{21}&+x_{22}&+x_{23}&+x_{24}&\leq s_2\\
s.t. &x_{11}&&&&+x_{21}&&&&=d_1\\
&&\quad x_{12}&&&&+x_{22}&&&=d_2\\
&&&\quad x_{13}&&&&+x_{23}&&=d_3\\
&&&&\quad x_{14}&&&&+x_{24}&=d_4
\end{cases}$$

look one column at a time (i have removed one item from $O$): chose $c_{ij}$, see the coefficients of associated constraints and multiply by $u,v$ and 
For example for $c_{11}$ both coeff are $1$, so $u_1+v_1\leq c_{11}$. For TODO


#### Theory
Here are some values. The proofs are NOT needed for the exam (?)

>[!thm|*] Weak Duality (Exam)
>If $x$ is any feasible solution of the primal and $\pi$ is any feasible solution of the dual problem, then
>$$\sum_{i=1}^p b_i\pi_i\leq\sum_{j=1}^qc_jx_j$$
>That is, the cost of the dual (feasible) solution cannot exceed the primal (feasible) solutions cost
>
>This has some important consequences:
>>[!lemma|*] Lower/Upper Bound
>>The objective function value of any feasible dual solution is a Lower Bound on the objective function of every feasible primal solution.
>>
>>The objective function value of any feasible primal solution is a Upper Bound on the objective function of every feasible dual solution.

Proof:
Multiply $i$-th constraint by $\pi_i$ and adding them all:
$$\sum_{j=1}^qa_{ij}x_j\geq b_i\ \forall i=1,...,p, \ [\pi_i]\longrightarrow \sum_{i=1}^pb_i\pi_i\leq\sum _{i=1}^p\pi_i\par{\sum_{j=1}^qa_{ij}x_j}$$
also multiply $j$-th constraint by $x_j$ and add them all:
$$\sum_{i=1}^p a_{ij}\pi_j\leq c_j\ \forall j=1,...,q,\ [x_j]\longrightarrow \sum_{j=1}^qx_j\par{\sum_{i=1}^p a_{ij}\pi_j}\leq \sum_{j=1}^q x_jc_j$$
Where the RHS of the first is = to the LHS of the second, so:
$$\sum_{i=1}^p b_i\pi_i\leq\sum_{j=1}^qc_jx_j$$
$\endproof$
