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

# 2) Random Elements
Randomness messes with rati