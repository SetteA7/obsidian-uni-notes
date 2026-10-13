# 1) Intro
A game is a multi-person multi-objective problem. The models are usually simple.

A player knows the rules and is rational
A rational player does the following:
- Is **selfish**: acts for their own good
- **Aware of consequences**
#### Decision Problem
A decision problem consists of three main elements:
- **actions:** belong to a set $A$
- **outcomes:** is the result of the actions
- **preferences:** describes what is the preferred outcome

#### Preference
A preference is a binary relationship $\succcurlyeq$ on set $A$. If $a,b\in A$ and $a\pref b$ then $a$ is ranked above $b$.
We have two properties; a preference is said to be:
- **Complete:** if $\forall a,b\in A$ a preference is defined
- **Transitive:** if $\forall a,b,c\in A$ there exists an order: $a\pref b\cap b\pref c\implies a\pref c$
If $\pref$ is complete and transitive then it is called **rational**

#### Utilities
Utilities (payoff functions) are an arbitrary quantification $u(q)$ of the goodness coming from some input $q$  
If $q$ is a countable good, $u(q )$ is generally an increasing function of $q$.
The exact formulation of $u(\cdot)$ does not matter, it just maps the order via $\geq$ on numbers.

A preference $\pref$ can be put in a relationship with $u:A\rightarrow\R$ 
$u$ **represents** $\pref$ if 
$$\forall a,b\in A \quad a\pref b\iff u(a)\geq u(b)$$

>[!thm] Representation of $\pref$ and $u(\cdot)$
>On a finite set $A$, $\pref$ can be represented by $u$ $\iff$ $\pref$ is rational
>
>Quick Proof
>$\implies$: is immediate (due to property of $\geq$)
>$\impliedby$: A suitable utility function can be $u(a)=|\curly{b\in A:a\pref b}|$

#### Decision Trees
TODO

# 2) Lotteries
Randomness messes with rationality as it is harder to infer consequences

Example:
$$\begin{align}
\text{Ravioli gives } &u(r)=\begin{cases} 2 & w.p. \ 0.5 \\ 5 &w.p. 0.5\end{cases}\\
\text{While Soup gives } &u(s)=\begin{cases} 1 & w.p. \ 0.8 \\ 10 &w.p. 0.2\end{cases}
\end{align}$$

Usually randomness is given from player actions (one player can also be nature)
Nature is **not** a rational player, its choices are iid as seen in the picture.
![[Pasted image 20260930151134.png|Tree|250]]
With $N\rightarrow\infty$ trials then payoff = expectation, where expectation is
$$\E[u(x)|p]=\sum_{k}p(x_k)u(x_k)$$
In this case we have that $r$ is rationally preferable since $\E[u|r]=3.5\geq \E[u|s]=2.8$.


#### Lottery
A lottery over outcomes $X=\curly{x_1,...,x_n}$ is defined as a probability distribution $p$ over $X$, that is
$$p=\curly{p(x_1),...,p(x_n)}\text{ where } p(x_k)\in[0,1]\text{ and } \sum_k p(x_k)=1$$
if actions are involved $p$ is conditional $p(x_k|a)$

That is, a lottery specifies the probability of a said outcome. It can be conditional and it becomes the probability of an outcome given the previous action.

#### Expected Utility 
We want to define $\pref$ among lotteries, we replace $A$ with the set $P(A)$ of lotteries over $A$

>[!axiom] Continuity Axiom
>For $p,q,r\in P(A)$ it must hold that the following sets are closed
>$$\begin{align}
\curly{a\in[0,1]:ap+(1-a)q\pref r}\\
\curly{a\in[0,1]:r\pref ap+(1-a)q}
\end{align}$$
>That is, arbitrarily small variations in gamble does not change preferred lotteries

If you mix the best outcome ($p$) and the worst outcome ($q$) with a probability $a$, as long as $a$ is high enough, you will prefer that gamble to the sure thing ($r$).

>[!axiom] Independence Axiom
>For $p,q,r\in P(A)$ it holds that $\forall a \in[0,1]$ if $p\pref q$ then $ap+(1-a)\pref aq+(1-a)r$
>That is, when mixing gambles we prefer the preference order not counting other alternatives

>[!thm] Von Neumann & Morgenstern
>If $\pref$ satisfies the four axiums (complete, transitive, continuity and independence) it can be represented by:
> $$u(\cdot) \text{ such that } \forall p,q \in P(A),\  p\pref q\implies \E[u(x)|p]\geq \E[u(x)|q]$$
> This function is called vN-M utility

vN-M does not state to compare expectations but to use affine transformations of $u$. That is a combination of degenerate lotteries $p=p_1(1,0,0,...)+p_2(0,1,0,...)+...$

#### Continuous Case
For example, dig a well to extract water, what is the preferred depth?
The depth is continuous: $0\leq d\leq \text{Eart radius}$
The effort to dig is (imposed by problem): $d^2/2$
The extracted water is uniformly distributed: $W(d)\sim u[0,20d]$

$$\E[u|d]=\E[W(d)-d^2]=10d-\frac{d^2}2$$
The optimal value is therefore $d=10\rightarrow u=50$.

#### Risk Attitude
Suppose three possible outcomes:
$$x_1=0\quad x_2=1\quad x_3=20$$
and two lotteries
$$p_A=(0,1,0)\qquad p_B=(0.95,0,0.05)$$
Both expected utilities are the same, how does one player chose which one is better?

**Risk Neutral:**
A risk neutral player will see these two choices as equivalent. This is a **linear** utility
**Risk Averse:**
A risk averse player prefers the degenerate lottery ($A$) as it guarantees the highest minimum win. This is a **concave** utility
**Risk Loving:**
A risk loving player prefers the lottery that allows for the max possible win. This is a **convex** utility

Therefore monotonic utilities do not change the preference, but change the risk attitude

#### Backwards Induction
Suppose that an entire tree is drawn with both player and nature choices. The solution (optimal decision) is found ia backwards induction

Classify all nodes with $P$ action into groups:
- Group 1: all nodes after which no further action is possible in any case
- Group $k$: includes all nodes that are followed only by at least one Group $k-1$ node and no higher order node
Start from group 1: find rational choice that maximizes utility, then go to group 2, repeat until last group is complete.

![[Pasted image 20261013112031.png|Example|450]]
Here Orange is group 1, yellow group $k=2$.
Now find optimal decision for group 1 and remove the unused branches
![[Pasted image 20261013112315.png|Example Continued|450]]
In the pruned tree we notice that the optimal decision is $r$: $\E[u|r]=4\geq \E[u|s]=2.8$

#### Value of Information
Now suppose a problem is solved with optimal utility $\E[u]=k$. 
And suppose that now the nature choice is already known, then the optimal utility can increase $\E[u|\text{knowledge}]=k'\geq k$ as the uncertainties are removed. 
The value of this information is $k'-k$

# 3) Multi Player Static Games
With multiple players things change. All players want to maximize their payoff!
#### Notation
We consider the following game:
- **static**: all players move together (simultaneous and independent)
- **complete information**: anybody's payoff function is known

An information $E$ is **common knowledge** if:
- Everybody knows $E$
- It is known that everybody knows it

Each player $i$ can access to a set of pure strategies:
- $S_i$ is the set accessible by player i
- $s_i\in S_i$ is the choice taken by player $i$

We define the **strategy profile** all the actions taken by all players, that is
$$s=(s_1,...,s_i,...,s_n)$$
We define the **strategy profile that excludes $i$-th player** choice as
$$s_{-i} = (s_1, \dots, s_{i-1}, s_{i+1}, \dots, s_n)$$

The normal form of the game is 
$$G=\curly{S_1,...,S_n;u_1,...,u_n}$$

The combination of the choices determines the outcome of the game $(a_1,...,a_n)$, the utility of $i$-th player is
$$u_i=u_i(a_1,a_2,...,a_n)$$

If the sets are discrete, this can be written in a $n$ dimensional matrix
#### Dominance and Best Response
A joint strategy $s$ is **Pareto Dominated** by another strategy $s'$ if
$$\begin{align}
u_i(s')\geq u_i(s)&\quad\text{for all players }i\\
u_i(s')>u(s)&\quad\text{for some players }i
\end{align}$$
$s'$ is said to be **pareto efficient**

We say that $s_i$ is **strictly dominated** by $s_i'$ if the payoff of $s_i'$ is always greater than $s_i$
$$u_i(s_{-i},s_i')>u_i(s_{-i},s_i)\quad\forall s_{-i}$$
Rational players do not play $s$ and they can be removed from the table.
This process is called **Iterated Elimination of Strictly Dominated Strategies (IESDS)**

Strategy $s_i\in S_i$ is the **best response** to $s_{-i}\in S_{-i}$  if $u(s_i,s_{-i})\geq u(s_i',s_{-i})$ $\forall s_i'\in S_i$

It is possible that there are multiple best responses (with identical values of $u_i(s_i,s_{-i})$)

>[!claim]
A rational player that believes that the opponent will play $s_{-i}\in S_{-i}$ will always chose the best response to $s_{-i}$

>[!thm]
>if $s_i\in S_i$ is a strictly dominated strategy, it is no best response to any $s_{-i}\in S_{-i}$




>[!example|IESDS]
Consider this example:
>$$\begin{array}{c|c|c}
  & L & R \\ \hline
U & 6,0 & 0,5 \\ \hline
M & 1,0 & 4,3  \\ \hline
D & 0,7 & 2,0 & 
\end{array}$$
So $S_A=\curly{U,M,D},\ S_B=\curly{L,R}$
Notice that for player $A$, $D$ is dominated by $M$ since
$$u_A(M,L)>u_A(D,L)\quad u_A(M,R)>u_A(D,R)$$
Now
>$$\begin{array}{c|c}
  & L & R \\ \hline
U & 6,0 & 0,5 \\ \hline
M & 1,0 & 4,3  \\ 
\end{array}$$
Now for player $B$, $R$ dominates $L$ since
$$u_B(U,R)>u_A(U,L)\quad u_B(M,R)>u_B(M,L)$$
So
>$$\begin{array}{c|c}
  & R \\ \hline
U & 0,5 \\ \hline
M & 4,3  \\ 
\end{array}$$
Now finally for player $A$, $M$ dominates $U$
>$$
\begin{array}{c|c}
  & R \\ \hline
M & 4,3  \\ 
\end{array}$$
rational player play $(M,R)$.
# 4) Rationalizing Solutions

$\mathscr p$ 

**Nash Equilibrium**
Loop of dominant decisions from multiple players: x dominates y, so I play x, my opponent knows I'll do that and if y dominates x he'll play y.

Everybody happy!

Motivation
If this is not in a nash equilibrium then there exists some player $i$ such that $s_i'$ is not the best response
So there is an incentive for player $i$ to change form $s_i'$