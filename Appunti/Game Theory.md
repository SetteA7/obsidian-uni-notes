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

![[Pasted image 20260930151134.png|Tree|250]]

With $N\rightarrow\infty$ trials then payoff = expectation, where expectation is
$$\E[u(x)|p]=\sum_{k}p(x_k)u(x_k)$$
#### Lottery
A lottery over outcomes $X=\curly{x_1,...,x_n}$ is defined as a probability distribution $p$ over $X$, that is
$$p=\curly{p(x_1),...,p(x_n)}\text{ where } p(x_k)\in[0,1]\text{ and } \sum_k p(x_k)=1$$
if actions are involved $p$ is conditional $p(x_k|a)$

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
>That is, when mixing gambles we prefer the TODO


vN-M does not state to compare expectations but to use affine transformations of $u$

#### Continuous Case

# 3) Static Games of Complete Infromation

# 4) Rationalizing Solutions
Strategy $s_i\in S_i$ is the best response to $s_{-i}\in S_{-i}$  if $u(s_i,s_{-i})\geq u(s_i',s_{-i})$ $\forall s_i'\in S_i$

$\mathscr p$ 

**Nash Equilibrium**
Loop of dominant decisions from multiple players: x dominates y, so I play x, my opponent knows I'll do that and if y dominates x he'll play y.

Everybody happy!

Motivation
If this is not in a nash equilibrium then there exists some player $i$ such that $s_i'$ is not the best response
So there is an incentive for player $i$ to change form $s_i'$