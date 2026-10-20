Domande Teoriche che ha fatto:
Weak duality, complementary slackness, minimax problem
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
A LP is a optimization problem with
- $q$ non.negative variables
- a _linear objective_
- $p$ linear constraint
- a set of _non negativity restrictions_

The standard form is as follows:
$$\text{LP}=\begin{cases}
&\displaystyle\min\sum_{j=1}^qc_jx_j\\
s.t. &\displaystyle\sum_{j=1}^qa_{ij}x_j= b_i\ &\forall i=1,...,p\\
&x_j\in\mathbb R_+\ &\forall j=1,..,q
\end{cases}$$
in matrix form:
$$\min_{x\in\mathbb R^q_+}\curly{cx|Ax=b}$$
Where
- $|A|=p\times q$
- $c\in\mathbb R^q$
- $x\in\R^q_+$
- $b\in\R^q_+$

#### Graphical Procedure
Particularly for cases in which $q=2$ it is possible to delimit an area in $\mathbb R^q$ in which all feasible solutions exist. The optimal solution is found in one **extreme point**, that is one of the verteces of the polyhedron.


#### Dual Problem
Any LP has it's dual that follows this logic:
$$\begin{array}{cc} \hline \text{Primal} & \text{Dual} \\ \hline \min & \max \\ q \text{ variables} & q \text{ constraints} \\ p \text{ constraints} & p \text{ variables} \\ \text{constraint } \boldsymbol{A}_i \boldsymbol{x} \le b_i & \text{variable } \pi_i \le 0 \\ \text{constraint } \boldsymbol{A}_i \boldsymbol{x} \ge b_i & \text{variable } \pi_i \ge 0 \\ \text{constraint } \boldsymbol{A}_i \boldsymbol{x} = b_i & \text{variable } \pi_i \in \mathbb{R} \\ \text{variable } x_j \ge 0 & \text{constraint } \boldsymbol{a}_j^T \boldsymbol{\pi} \le c_j \\ \text{variable } x_j \le 0 & \text{constraint } \boldsymbol{a}_j^T \boldsymbol{\pi} \ge c_j \\ \text{variable } x_j \in \mathbb{R} & \text{constraint } \boldsymbol{a}_j^T \boldsymbol{\pi} = c_j \\ \hline \end{array}$$
From canonical primal ($q$ variables $x_j$ and $p$ parameters $b_{i}$) to canonical dual ($p$ variables $\pi_i$ and $q$ parameters $c_i$):
$$\text{Primal}=\begin{cases}
\displaystyle\min\sum_{j=1}^qc_jx_j\\
\displaystyle s.t. \sum_{j=1}^qa_{ij}x_j\geq b_i\ &\forall i=1,...,p\\
x_j\in\mathbb R_+\ &\forall j=1,..,p
\end{cases}\longrightarrow\text{Dual}=\begin{cases}
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
Define the two dual variables as $u_i, v_j$

Now by looking at the table:
Dual Max (primal min):
Convert from from 12 primal variables ($O\cdot D$) to 7 dual variables ($O+D$).

$$\min \sum_{i\in O}\sum_{j\in D}c_{ij}x_{ij}\longleftrightarrow \max \sum_{i \in O} s_i u_i + \sum_{j \in D} d_j v_j$$
Dual Variables (primal constraints):
$$\begin{align}
\displaystyle\sum_{j\in D}x_{ij}\leq s_i\quad \forall i\in O
&\longleftrightarrow  u_i\in \mathbb R_- \quad \forall i\in O\\
\displaystyle\sum_{i\in O}x_{ij}=d_j\quad \forall j\in D  
&\longleftrightarrow v_j\in \mathbb R\quad \forall j\in D\\
\end{align}$$
Dual Constraints (primal variables):
$$x_{ij}\in \mathbb R_+\quad \forall i\in O,\ \forall j\in D\longleftrightarrow u_i+v_j\leq c_{ij}\quad \forall i\in O, \ \forall j\in D$$

#### Theory
Here are some values. The proofs are NOT needed for the exam (?)

>[!thm|*] Weak Duality (Exam)
>If $x$ is any feasible solution of the primal and $\pi$ is any feasible solution of the dual problem, then
>$$\sum_{i=1}^p b_i\pi_i\leq\sum_{j=1}^qc_jx_j$$
>That is, the cost of the dual (feasible) solution cannot exceed the primal (feasible) solutions cost.
>
>This has some important consequences:
>>[!lemma|*] Lower/Upper Bound
>>The objective function value of any feasible dual solution is a Lower Bound on the objective function of every feasible primal solution.
>>
>>The objective function value of any feasible primal solution is a Upper Bound on the objective function of every feasible dual solution.
>
>>[!lemma|*] Unbounded Solutions
>>If the primal (dual. respectively) has an unbounded solution, the dual (primal, respectively) is infeasible.
>>
>>[!lemma|*] Optimal Solution
>>If the theorem holds as an equality, then $x,\pi$ are optimal primal/dual solutions.

Proof:
Multiply $i$-th constraint by $\pi_i$ and adding them all:
$$\sum_{j=1}^qa_{ij}x_j\geq b_i\ \forall i=1,...,p, \ [\pi_i]\longrightarrow \sum_{i=1}^pb_i\pi_i\leq\sum _{i=1}^p\pi_i\par{\sum_{j=1}^qa_{ij}x_j}$$
also multiply $j$-th constraint by $x_j$ and add them all:
$$\sum_{i=1}^p a_{ij}\pi_j\leq c_j\ \forall j=1,...,q,\ [x_j]\longrightarrow \sum_{j=1}^qx_j\par{\sum_{i=1}^p a_{ij}\pi_j}\leq \sum_{j=1}^q x_jc_j$$
Where the RHS of the first is = to the LHS of the second, so:
$$\sum_{i=1}^p b_i\pi_i\leq\sum_{j=1}^qc_jx_j$$
$\endproof$
For the second lemma:
If the primal is unbounded, its cost drops toward $-\infty$. If a dual solution existed, its fixed cost would have to be less than or equal to all those arbitrarily small numbers, which is impossible. Thus, no dual solution can exist.

>[!thm|*] Strong Duality
>If the primal problem and dual problems are feasible, there exists an optimal primal solution $x^*$ and an optimal solution $\pi$ and $\sum_i b_i\pi_i^*=\sum_j=c_jx_j^*$

>[!thm|*] Complementary Slackness Property (Exam)
>A pair $(x,\pi)$ of the primal and dual feasible solutions satisfies the complementary slackness if
>$$\pi_i\par{\sum_{j=1}^q a_{ij}x_j-b_i}=0\ \forall i=1,...,p\text{ and }x_j\par{c_j-\sum_{i=1}^p a_{ij}\pi_i}=0\ \forall j=1,...,q$$
>Notice that the term in the parenthesis cannot be negative

>[!thm|*] Complementary Slackness Optimality Conditions
>A feasible primal solution $x$ and a feasible dual solution $\pi$  are optimal solutions of the primal and dual problems iff they satisfy the complementary slackness property

# 3) Paths, Trees, Cycles
## 3.1) Notation and Definitions
**Directed Graph:** $G=(N,A)$
consist in a set $N$ of nodes and a set $A$ of arcs, whose elements are ordered pair of distinct nodes; an arc $(i,j)$ behaves like a one-way street: permits flow from $i$ to $j$ only, not vice versa.

**Undirected Graph:** $G=(N,E)$
consist in a set $N$ of nodes and a set $E$ of edges, whose elements are unordered pair of distinct nodes; an edge $(i,j)$ behaves like a two-way street: permits flow in both directions. Indeed, we can refer to an edge using $(i,j)$ or $(j,i)$.

**Tail and Head**
In an arc $(i,j)$ there are two endpoints:
- Tail $i$: the arc _emanates_ from $i$
- Head $j$: the arc _terminates_ at $j$
We say that $i$ is **adjacent** to $j$ (but not vice versa)

**Degree**
The degree of a node $i$ is the **number of connected arcs.**
More strictly, it is the _sum of its **indegree** and **outdegree**_.
- Indegree: # of incoming arcs
- Outdegree: # of outgoing arcs

**Adjacency List**
We talk about adjacency list of node / of arc of each node.
- Arc adj list: The arc adjacency list $A(i)$ of a node $i$ is the set of arcs _emanating_ from $i$.
$$A(i)=\curly{(i,j)\in A|j\in N|}$$
- Node adj list: The node adjacency list $A(i)$ of a node $i$ is the set of nodes adjacent to $i$.
$$A(i)=\curly{j\in N|(i,j)\in A}$$

In both cases, notice how $|A(i)|$ equals the outdegree of $i$.

**Subgraph**
A graph $G'=(N',A')$ is a subgraph of $G(N,A)$ if $N'\subseteq N$ and $A'\subseteq A$.
$G'$ is the subgraph of $G$ induced by $N'$ if $A'$ contains every arc of $A$ and with both endpoints in $N'$.

**Walk**
A _walk_ is a subgraph of $G = (N,A)$ consisting in a sequence of nodes _$i_1 -i_2-...-i_r$ ,_ satisfying the property that for $k=1,...,r-1$ either $(i_k, i_{k+1}) \in A$ or $(i_{k+1}, i_k) \in A$ (cioè i nodi sono collegati anche se non seguono la direzione degli archi).

Instead, a _directed walk_ is a walk such that $(i_k, i_{k+1}) \in A$ (cioè stavolta devi seguire gli archi).

**Path**
A _**path**_ is a walk without any repetition of nodes.
A _**directed path**_ is a directed walk without any repetition of nodes.

#### Representations
**Node-Node Adjacency Matrix**
This is just a $n\times n$ matrix where each entry $a_{ij}$ is the value (or the index of the values array) for the arch $i\rightarrow j$
$$
\begin{array}{r@{\mkern 8mu} c}
  & \begin{array}{cccccccc} 
      (1, 2) & (1, 3) & (2, 4) & (3, 2) & (4, 3) & (4, 5) & (5, 3) & (5, 4) 
    \end{array} \\[4pt]
  \begin{array}{c} 1 \\ 2 \\ 3 \\ 4 \\ 5 \end{array} &
  \left[
    \begin{array}{rrrrrrrr}
       1 &  1 &  0 &  0 &  0 &  0 &  0 &  0 \\
      -1 &  0 &  1 & -1 &  0 &  0 &  0 &  0 \\
       0 & -1 &  0 &  1 & -1 &  0 & -1 &  0 \\
       0 &  0 & -1 &  0 &  1 &  1 &  0 & -1 \\
       0 &  0 &  0 &  0 &  0 & -1 &  1 &  1
    \end{array}
  \right]
\end{array}
$$

**Node-Arc Incidence Matrix**


How can a graph be stored?


  

$$\begin{align}
&\min \sum_{(i,j)\in A} c_{ij} x_{ij} \\
s.t \qquad &\sum_{j\in \delta^+_s} x_{sj} \ = \ n-1 \\
&\sum_{i\in \delta^-_k} x_{ik} - \sum_{j\in \delta^+_k} x_{kj} \ = \ 1  &\forall k \in N \setminus \{s\} \\
&x_{ij} \in \R_+  &\forall (i,j) \in A
\end{align}$$