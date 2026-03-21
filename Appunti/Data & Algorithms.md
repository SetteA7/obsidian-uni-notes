![[Data Structures and Algorithms in Java (Michael T. Goodrich, Roberto Tamassia etc.) (z-lib.org)-1.jpg]]
# 1) Basis concepts
Let's start with some basic definitions:

>[!def] Computational problem
>A **computational problem** consists of the set *$I$* of possible instances (the inputs) and a set *$S$* of all possible solutions. These two sets are connected via a relation $\prod$ that links every input to one or more solutions. $\prod$ is a subset of $I \times S$.

>[!def] Algorithm
>%%main%%
>An **algorithm** is a set of instructions that solves a computational problem in a finite amount of iterations

An important way to describe an algorithm is through the use of **pseudocode**, that is structured as follows:

**Algorithm:** name (parameters)
**Input:** brief description of input instances
**Output:** brief description of the desired outcome

*here is the actual algorithm*

>[!def] Data structure
>A data structure is a collection of objects and methods related to access and modify these objects. We can define 2 levels of abstraction:
>- Logical level: specifies the logical organization of the objects in the collection, and the input-output relationship of each method
>- Physical level: specifies the physical layout of the data and the implementation of the methods by algorithms

# 2) Analysis of Algorithms
In this course we will analyse the time complexity and the correctness of an algorithm.
## 2.1) Time Complexity Analysis

>[!def] Worst case time complexity
>The **worst case time complexity** of $A$ is a function $t_A$ defined as the maximum number of operations required to solve an instance of size $n$.

The experimental study is obviously flawed so we need to develop some analytical methods to find this data. First it is important to notice that it's not necessary to determine an exact number of instances, but only an asymptotic analysis in necessary, that is, we just need an upper an lower bound of $t_A$ 
### 2.1.1) Orders of Magnitude
The study of an asymptotic behaviour aims to find the order of magnitude of $t_A$

>[!def] Big-Oh
>Let $c, \ n_0$ be constants independent from $n$, then we say that:
>$$f(n) \in O(g(n)) \iff \exists c>0, \ \exists n_0 \geq 1 \text{ such that } f(n) \leq c g(n), \ \forall n \geq n_0$$

Here is a graphical representation to understand it better:
![[Pasted image 20240820140846.png|Big-Oh Graphical Representation|350]]
In a similar vein, we have:
>[!def] Big Omega
>Let $c, \ n_0$ be constants independent from $n$, then we say that:
>$$f(n) \in \Omega(g(n)) \iff \exists c>0, \ \exists n_0 \geq 1 \text{ such that } f(n) \geq c g(n), \ \forall n \geq n_0$$

This is essentially the inverted definition of Big-Oh in order to find the lower bound. Here's a graphical representation:
![[Pasted image 20240820141736.png|Big Omega Graphical Representation|350]]
By combining the two definitions, we get this:
>[!def] Big Theta
>Let $c_1, c_2, \ n_0$ be constants independent from $n$, then we say that:
>$$f(n) \in \Theta(g(n)) \iff f(n) \in O(g(n)) \text{ and } f(n) \in \Omega(g(n))$$
>that is:
>$$c_1 g(n) \leq f(n) \leq c_2 g(n)$$

![[Pasted image 20240820142253.png|Big Theta Graphical Representation|350]]
Technically speaking Big Oh/Omega can be as big/small as possible, but this way they end up loosing all meaning, it is recommended to keep these assumptions as close to $f(n)$ as possible
>[!example|*] Example
>Let $f(n)=a_1 + a_2n^2$ it is clear to see that for $n_0 = 1$ we can set $c_1 = a_1+a_2, \ c_2 = a_2$, thus $f(n) \in \Theta(n^2)$

>[!theorem] Properties of Orders of Magnitudes
>- A polynomial of degree $p$ with $a_p > 0$ has $\Theta(n^p)$
>- $\log_b(n) \in \Theta(\log_a(n))$
>- $(\log_b(n))^k \in o(n^h)$
>- $n^k \in o(a^n)$ if $k>0, \ a>1$

As a recap, here are some notable summations:
- $\sum_0^n i = \frac{n(n+1)}{2}$
- $\sum_0^n a^i = \frac{a^{n+1}-1}{a-1} \in \Theta(a^n) \text{ if } a>1$
- $\sum_1^n a^i = \frac{a^{n+1}-a}{a-1}$

>[!rmk|*]
>There might be some **pathological instances** where an algorithm performs out of the normal, these can be considered but it's also important to exclude them from the asymptotic analysis sometimes
>
>**Constants** can be usually neglected, but if a constant is too big it will affect real time performance and thus the number of constants should be kept small

## 2.2) Correctness Analysis
There are many ways to prove the correctness of an algorithm. The main caveats used in calculus classes still apply, but most importantly, we introduce the **proof by invariance**.

The "easy" traditional methods are the **proof by absurdity and the proof by counterexample**. A bit harder is the **proof by induction**, let's recall the steps:
1. Prove for an integer $k$
2. Prove for at least another integer $k+m$
3. **Inductive step:** prove for a generic integer $n > k + m$

In an algorithm made of more steps, and also loops, we introduce more tactics. These are the generic steps we will use:
1. Identify an initial and a final state
2. decompose the algorithm in segments
3. demonstrate that by repeating the segments the algorithm solves the problem

We use an **invariant** to help with these steps.
>[!def] Invariant
>An **invariant** is a property expressed as a function of the variables used in the loop, which describes the state in which the execution is located during the various iterations of the loop. In particular it is:
>- valid at the beginning of the cycle
>- valid at the end of each iteration
>- valid at the end of the last iteration and it has reached the desired state

Here's two examples:
>[!col]
>![[Pasted image 20240821145718.png|arrayMax(A) Example]]
>>[!col]
>>We can identify the invariance in the currMax variable, it should be the max value in $\{A[0],...,A[i]\}$.
>>Thus, $S_{\text{init}}$: currMax = A[0]
>>$S_{\text{end}}$: max{A[0],...,A[n-1]}
- $S_{\text{init}}$: At $i=0$ it holds since currMax $\leftarrow$ $max\{A[0]\}$
- Suppose i-th iteration to be true, then at iteration $i+1$ we have currMax $\leftarrow$ max{currMax, A[i]} which verifies invariant
- $S_{\text{end}}$: at last iteration we have max{A[0],...,A[n-1]} which is the entire array
>[!col]
>![[Pasted image 20240821151856.png|arrayFind(a) Example]]
>>[!col]
>>i is invariant: it means that before i x wasn't found, i.e. $x \not\in A[j], \ 0 < j \leq i$
>>Thus, $S_{\text{init}}$: $i = 0$
>>$S_{\text{end}}$: $i < n \text{ if } x\in A$ or $i = n \text{ if } x\not\in A$
- $S_{\text{init}}$: the interval $[0, i(=0)]$ is null so the invariant holds
- at i-th iteration 2 things can happen:
	- x is found: i is not incremented and loop is exited, the invariant holds
	- x is not found: i is incremented
- $S_{\text{end}}$: here we must, again, study the 2 cases: 
	- x was found: $i < n$
	- x was not found: $i = 0$

# 3) Trees

## 3.1) Definitions
A tree is a collection of nodes with a hierarchical structure that starts on the *root* and has relations like *parent-child*.

>[!def] Rooted Tree
>A **rooted tree** is a collection of nodes that, if it is not empty, satisfies the following properties:
>- $\exists$ a special node $r \in T $
>- $\forall \ v \in T, v \not= r:\exists ! u \in T$: u is parent of v (v is child). This means that every node has a parent, except for the root
>- $\forall \ v \in T, v \not= r$ going up we always arrive at root

^b17370

Let's define some terms commonly used when describing trees:
- **Ancestor**: x is ancestor of y if $x=y$ or x is ancestor of father of y (x is parent of y or y)
- **Descendant**: x is descending from y if y is ancestor of x (x is child of y)
- **Interior nodes**: all nodes with $\geq$ nodes
- **Leaves**: all nodes with no children
- **Subtree with root v**: $T_v$ is a tree composed by descendants of v
- **Sorted Tree**: T is a sorted tree if there is defined a linear ordering among the children

>[!def] Recursive definition of rooted tree
>A **rooted tree** is a collection of nodes that, if not empty, are partitioned this way:
>$$T=\{r\}\cup T_1\cup...\cup T_k$$
>for any $k \geq 0$.
>- r is root with children $u_1,...,u_k$
>- $\forall i, 1 \leq i \leq k: T_i$ is a non empty tree with root $u_i$
> 
>![[Pasted image 20240823095357.png|Graphic Representation of this Definition|350]]

Now let's expand what info a tree/node can hold

>[!def] Depth of a node: depth$_T$(v)
>There are two different definitions for **depth**:
>
>Def. 1: depth$_T$(v) = | ancestors(v) | -1
>
>Def. 2 (recursive):
>if $v=r$  $\implies$ depth$_T$(v) = 0
>otherwise depth$_T$(v) = 1 + depth$_T$(father(v))
>
>Essentially this indicates how many nodes under r v is found

>[!def] Level $i$
>The **level** is defined as the set of nodes with depth $i$ ($\forall i \geq 0$)

>[!def] Height of a Node: height$_T$(v)
>if v is leaf $\implies$ height$_T$(v) = 0
>otherwise height$_T$(v)= 1 + max$w:w \text{ child of } v$(height$_T$(w))

To have a better understanding of height we can use the following preposition which essentially states that the height shows how deep the deepest leaf in $T_v$ is ^73df33

>[!proposition]
>Given a tree T, height(T) = max$_{v \in T: v \text{ leaf}}$(depth$_T$(v))
>`\begin{proof}`
>This proof is done via induction on T with root r and $n\geq 1$ nodes
>**Base step:** n = 1, only root thus height = depth = 0
>
>**Ind. Hyp.:** valid $\forall$ tree with $m \in [1, n]$ nodes
>
>**Inductive step:**
>- Consider a tree with $n+1$ nodes, it has children $T_1,...,T_k$
>- By ind. hyp., height($T_i$)=max depth$_{T_i}$(v) since $T_i$ has $<n$ nodes
>- Thus, height(T) = 1+max height($T_i$) = 1 + max$_{1\leq i \leq k}${max$_{v \in T_i}$ depth$_{T_i}$(v)}
>- Since $T_i$ are all on same level, the 1+ can be ignored by choosing the parent of $T_i$( i.e. the root) as the base of depth function
>height(T) = max$_{1\leq i \leq k}${max$_{v \in T}$ depth$_{T}$(v)}
>- Since the leaves of T are $T_i$, we can ignore the first max, since it is implicitly included
>height(T) = max$_{v \in T}$ depth$_{T}$(v)
`\end{proof}`

![[Pasted image 20240823101056.png|Tree Depth in Black, Height in Blue|450]]
## 3.2) Visits
An important way to analyse trees is by using visits. A visit is an interaction with a node

>[!def] Visiting a Tree
>**Visiting a tree** consists on systematically scanning all nodes in T to perform a specific operation (visit) on each node

This represents an **algorithmic design pattern**
There are 2 main ways to visit a tree:
- **Preorder:** visit first the parent then, recursively, the subtrees in the children starting from the left node
- **Postorder:** recursively visit first the subtrees of the children, then the parents

>[!col]
>![[Pasted image 20240823121357.png|Example|200]]
>>[!col]
>>- **Preorder:** A-B-E-F-C-D-E
>>- **Postorder:** E-F-B-C-G-D-A
## 3.3) Algorithms

### 3.3.1) **Depth Algorithm**
![[Pasted image 20240823103131.png|depth(v) Pseudocode|450]]
>[!conjecture|*] $\Theta(dv +1)=\Theta(n)$
>`\begin{proof}`
Any node has one and only one parent. The algorithm runs once per node it encounters (even on root/start node), thus it will always perform dv (depth) + 1 calls.
In the worst case scenario a tree is made of n nodes in a straight line, thus dv + 1 ~ n
`\end{proof}`

>[!claim|*]
>Inv. hypothesis: after each iteration depth returns depth of v in subtree $T_w$, w = current node
>- $S_{\text{init}}$: $T_w = T_v$ and since v is the root of this subtree the invariant = 0 holds
>- $S_i$: suppose i-th step correct, then at i+1 and the invariant holds
>-  $S_{\text{end}}$: the last case is the base case of the recursive algorithm: the tree $T_w=T$ and thus w = root and and the algorithm stops

### 3.3.2) Height Algorithm
![[Pasted image 20240823105251.png|height(v) Pseudocode|450]]
>[!conjecture|*] $\displaystyle\Theta(\sum_{u \in T_v} (c_u +1))=\Theta(2n_v - 1)=\Theta(n)$
>`\begin{proof}`
When u is a leaf (base case) there are no children and the algorithm stops: $\Theta$(1)
In any other case each child of u considered: $\Theta$($c_u +1$) with $c_u$ # of children of u
Thus the complexity is $\Theta$($\sum_{u \in T_v} (c_u +1)$)
By computing the sum we get:
>$$
\sum_{u \in T_v}(c_u +1)= \sum_{u \in T_v} (c_u) +\sum_{u \in T_v}1 = \sum_{u \in T_v}(c_u) + n_v \ \text{ nodes of }T_v $$
>To solve the remaining sum we will use a theorem that states: $\sum_{u \in T_v}c_u = n_v -1$
(the proof of this theorem is really intuitive: we sum each child except the root)
thus: $\Theta$($\sum_{u \in T_v} (c_u +1)$)$= \Theta(2n_v - 1)=\Theta(n_v)$
`\end{proof}`


It is clear how height and depth have an asymmetry in complexity

### 3.3.3) Preorder/Postorder Visit
>[!col]
>![[Pasted image 20240823121635.png|preorder(T,v) Algorithm|250]]
>>[!col]
>>![[Pasted image 20240823121907.png|postorder(T, v) Algorithm|350]]

These algorithms are very similar between each other, thus we study them together
>[!conjecture|*] $\displaystyle\Theta(c_u+t_u+1)=\Theta(n+\sum_{e\in T}t_u)=\Theta(n)$
>`\begin{proof}`
The algorithms perform once per every node
As before $\Theta(c_u+1+t_u)$ with $c_u$ children of u, $t_u$ cost of visiting u
$$\sum_{u \in T_v}(c_u +1 +t_u)= \sum_{u \in T_v}(c_u) +\sum_{u \in T_v}(t_u) + n_v= 2n_v -1 +\sum_{u \in T_v}(t_u)$$
Since we care about the post/preorder time complexity, we set the visit to $\Theta$(1) and thus the time complexity becomes $\Theta$(n)
`\end{proof}`

#### 3.3.3.1) Example Using these Algorithms
Design of **AllDepths** algorithm that calculates the depth of each node in the given tree
Since the depth depends on the parent, a preorder visit is the most convenient to use

```js
/*
Algorithm: allDepths(T, v)
Input: T, tree and v root of subtree to consider
Output: every node has it's depth saved in v.depth
*/
//(visit)
if (T.isRoot(v)) then v.depth <- 0
else
	v.depth <- 1+T.parent(v).depth

//(preorder)
foreach w <-T.children(v) do allDepth(T,w)
```

This is a preorder visit with a complexity of each visit of $\Theta(1)$, thus it's overall **complexity** is $\Theta(n)$.

## 3.4) Binary Trees

>[!def] Binary Tree
>A **binary tree** T is an ordered tree in which
>- Every node has at most 2 children
>- Each child is labeled as sx/dx node
>- A left child precedes a right child

>[!def] Proper Binary Tree
>A **proper binary tree** is a binary tree such that each internal node has exactly 2 children

![[Pasted image 20240823134735.png|Binary Tree and Proper Binary Tree|450]]
There are some properties arising from the definition of a full tree:
>[!theorem] Properties
>Let:
>- n = # of nodes in T
>- m = # of leaves in T
>- $n_I$ = # of internal nodes in T ($n_I = n-m$)
>- h = height of T
>
>then, we can define the following properties:
>- $m = n_I +1$
>- $h+1 \leq m \leq 2^h$
>- $h \leq n_I \leq 2^h-1$
>- $2h +1 \leq n \leq 2^{h+1}-1$
>- $log_2(n+1)-1\leq h\leq{\frac{n-1}{2}}$

Here are the various proofs:
`\begin{proof}` $m = n - m + 1$
By induction

**Base step:** $h = 0 \implies n = m = 1$

**Ind. hp.:** the property is valid for every tree of height $0 \leq h\leq h_T$
**Inductive step:** 
- Suppose it is valid at h, study h+1
- Since it is a full binary tree, each node has a subtree in which the ind. hp. holds and $h+1 = 1 + \max\{h_1,h_2\}$
- Since T is made of $T_1 \cap T_2$ we know that $m = m_1 + m_2$ and $n = n_1+n_2$
$$m = m_1+m_2=(n_1-m_1+1)+(n_2-m_2+1)=n_1+n_2-m_1-m_2+1=n-m+1$$
`\end{proof}`
`\begin{proof}`$h+1 \leq m \leq 2^h$
1. $m\leq 2^h$
By induction:
**Base step:** $h=0 \implies m=1$

**Ind. hp:** valid for any tree of height $0 \leq h\leq h_T$

**Inductive step:**
- Suppose valid at h, study h+1
- I know that $h_1, h_2 \leq h$
$$m = m_1 + m_2 \leq 2^{h_1}+2^{h_2}\leq2^h+2^h\leq2^{h+1}$$

`\end{proof}`

We can now define a new type of visit: **Inorder visit:**
First, recursively the left subtree, then the right one
![[Pasted image 20240823143411.png|Inorder Visit Algorithm|350]]
>[!conjecture|*] $\Theta(n + \sum t_u)$


![[Pasted image 20240823143933.png|Example|200]]

### 3.4.1) Parse Tree

A specific type of proper binary tree is the parse tree, which is associated to arithmetic expressions

>[!def] Parse Tree
>A **parse tree** is a proper binary tree where:
>- internal nodes contain operators
>- laves contain constant/variables

>[!rmk|*]
>If E is a constant then the tree is made of only a single leaf

## 3.5) Complete Binary Tree

>[!def] Complete Binary Tree
>Given a binary tree of heigh h, it is **complete** if:
>- $\forall i, 0 \leq i \leq h-1$ the level i has $2^i$ nodes (max value)
>- At the h-1 level, all internal nodes are on the left of eventual leaves except the last internal node which might have only the lx child
>![[Pasted image 20240823153714.png|Example of Complete Binary Tree|450]]

>[!theorem] Complete Binary Tree Height
>A complete binary tree with n nodes has height $h=\lfloor{\log_2n}\rfloor$
>`\begin{proof}`
>Starting from the top of a tree, every level has $2^i$ nodes. Thus until level h-1 we have $$\sum_0^{h-1}2^i=\frac{2^{h-1+1}-1}{2-1}=2^h-1$$ nodes.
>On the last level we have $x \in [1,2^h]$ nodes, thus
>$$\begin{align}
>2^h\leq n& \leq 2^{h+1}-1 \\
>h \leq \log_2n& \leq h+1
>\end{align}$$
`\end{proof}`
## 3.6) Search Binary Tree
>[!def] Search Binary Tree
>A **search binary tree** is a proper binary tree where each node holds a key from an ordered universe. Given a node v, these properties hold:
>- The keys in the left subtree are < k
>- The keys in the right subtree are > k
>- all leaves are empty

![[Pasted image 20240824143523.png|Example|350]]
>[!rmk|*]
>The inorder visit touches entries in non decreasing order.

With this remark we can easily implement a TreeSearch algorithm

### 3.6.1) TreeSearch Algorithm

The tree search algorithm is similar to a binary search of a sorted array
![[Pasted image 20240824143839.png|Pseudocode|550]]
>[!conjecture|*] $\Theta(h)$
>`\begin{proof}`
It executes only once per level, thus it has O(h)
`\end{proof}`
### 3.6.2) Put Algorithm

^43c0a8

![[Pasted image 20240824145018.png|Pseudocode|450]]
expandExternal() transforms w in node containing the entry and 2 empty leaves ^449c07

The remove() algorithm will be explained [here](#^8b54d8).

## 3.7) Multi-Way Search Tree

^917a4d

This type of tree is a generalisation of a search tree. It's not a binary tree anymore as it has more than 2 leaves and also more than one entry per node

>[!def] Multi-Way Search Tree
>A **multi-way search tree** is ordered in the following way
>- Each internal node has $d\geq 2$ children that follow the following properties:
>	- It stores d-1 entries $(k_1),...,(k_{d-1})$ with $k_1<...<k_{d-1}$
>	- For a child $1\leq i \leq d$   $T_i$ with entry e, it holds a key such that $k_{i-1}\leq e.getKey()\leq k_i$

![[Pasted image 20240824152048.png|Example|450]]
![[Pasted image 20240824152123.png|Another Example|450]]
>[!theorem]
>A MWS-Tree with n entries has n+1 leaves
>`\begin{proof}`
>**Base Step:** h=0, there is only 1 leaf, 0 entries
>**Ind. Hp.:** 
>**Ind Step:** suppose it works at h, now study h+1
>	Set these parameters: $h_i$ height of tree $T_i$ which is subtree of $T$, and $n_i$ is number of entries, $m_i$ is number of leaves
>	We must show that m=n+1
>	$$ m = \sum m_i=\sum_1^{d} (n_i+1) =\sum n_i+ d$$
>	Notice that $\sum (n_i)+d-1 = n$, then
>$$\sum n_i+ d = \sum n_i d-1 + 1=n+1$$
>`\end{proof}`

### 3.7.1) Search Method

This algorithm might seem complicated at first glance, but it's actually quite easy.

The base case is when a leaf is encountered. 

The middle part selects the right key to search in the node: $k$ is the value we need to Find, $k_i$ are the values in the node. We must find i such that $k_i\leq k \leq k_{i+1}$ 
If $k\not=k_i, \ \forall i$ then it might be found in the child with values $k_{i-1}\leq k\leq k_i$ (intermediate).

![[Pasted image 20240824153723.png|Pseudocode|450]]
>[!conjecture|*] $\Theta(d_{\text{max}}h)$
>`\begin{proof}`
Set $d_{max}$ = max # of children and $h$ = height of T
It calls at most h+1 times and at every call it performs at most $d_{max}$ calls
`\end{proof}`
### 3.7.2) Get Method

![[Pasted image 20240824154633.png|Pseudocode|450]]
>[!conjecture|*] $\Theta(d_{\text{max}}h)$

## 3.8) (2,4)-Tree

This kind of tree is a generalisation of MWS-Tree with $2\leq d\leq4$ and **all leaves on the same depth**. It has the same search and get methods

>[!theorem] Height of (2,4)-Tree
>Since this is a complete tree, a tree with n>0 entries has a height of $\Theta(\log n)$

### 3.8.1) Put Method
The put method is similar to the one already seen, but it must check if the node is still valid ($d \leq 4$)

![[Pasted image 20240824155930.png|Pseudocode|450]]
![[Pasted image 20240824160012.png|Operators in Red|450]]

![[Pasted image 20240824160241.png|Pseudocode of Split|450]]
>[!conjecture|*] $\Theta(\log n)$

The first if checks if such key is already present, in that case it is just necessary to get the old value, store the new and return the old one

Then, if it is external it can be either a root or a leaf:
- Root: it creates a new root made by w as the only key
- Leaf: it adds another key in the node, then it adds a leaf to complete the node: now the node might have 5 children, we must split it
	- the first 2 entries form u', the last entry u''. The third entry is inserted in the parent and u', u'' are the children
	- It propagates until it hasn't generated a new 5 node, or until root: if it is root, then it creates a new root 



### 3.8.2) Remove Method
The remove() method is even worse. It is made by a total of <big><b>5</b></big> different cases
![[Pasted image 20240824160959.png|Pseudocode|450]]
Here we only find the correct entry to delete.  It's only possible to remove an entry at height 1. If it's not at such height, the left subtree is searched and the biggest entry (e') is taken and copied at e (correct same as [remove in a search tree](#^421103)). Now e' in it's original position must be deleted

#### 3.8.2.1) Delete Sub-Algorithm
![[Pasted image 20240824173816.png|450]]
in this case, once the entry get's removed, it might happen that the node is empty

Case 1: u root
![[Pasted image 20240824173925.png|350]]
Case 2/3: u has sibling u$_{l/r}$ that is a d node with $d \geq 3$
![[Pasted image 20240824174101.png|350]]
![[Pasted image 20240824174125.png|350]]
Case 4/5: u has sibling u$_{l/r}$ that is a 2 node
![[Pasted image 20240824174240.png|350]]
![[Pasted image 20240824174339.png|350]]

>[!conjecture|*] $\Theta(\log n)$


A last example of a tree, called **free tree** can be found in the [chapter about graphs](#^12ae6f) at [[#^fb6abe]]
# 4) Priority Queue

A clever way to use trees is trough the implementations of priority queues. But in order to study them we must first introduce one basic concept:

>[!def] Entry
>An **Entry** is a pair (key, value) where the key comes from a domain K and the value from a domain v

^9bda0d

For example a student is saved as a student id(key) and then some data (value)

It is possible to implement queues via lists, with the following complexities:

| List        | insert      | min         | removeMin   |
| ----------- | ----------- | ----------- | ----------- |
| not ordered | $\Theta(1)$ | $\Theta(n)$ | $\Theta(n)$ |
| ordered     | $\Theta(n)$ | $\Theta(1)$ | $\Theta(1)$ |
we will see how it is possible to optimise such time complexities with a specific form of a tree, a heap

|      | insert            | min         | removeMin         |
| ---- | ----------------- | ----------- | ----------------- |
| Heap | $\Theta(\log(n))$ | $\Theta(1)$ | $\Theta(\log(n))$ |
## 4.1) Heap

>[!def] Min-Heap
>A **min-heap** is a complete binary tree whose nodes store entries and satisfy the following **heap-order property:**
>$$k_1 \leq \min\{k_2, k_3\}$$
>![[Pasted image 20240823155119.png|Orders of k in a Heap|250]]

^04cc53

Similarly a max heap has the same definition but with $k_1 \geq \min\{k_2, k_3\}$.

>[!def] Last Node
>It is also important to define a **last node** in the heap. That is the rightmost node at level h

>[!theorem] Properties
>- the root has the minimal key
>- the key encountered in an upwards path are nondecreasing
>- if the keys are all distinct, the i-th smallest key is at depth d < i
>- if the keys are all distinct, the largest key is in a leaf
>- any descendants of a node has a bigger key

To construct a heap we use an array, it is important to know the index of an array corresponding to each node of a tree.

>[!def] Level Numbering
>The following **level numbering** allows to map a binary tree on an array $P=P[1],...$
>- Root: $P[1]$
>- Children of $P[i]: P[2i], P[2i+1]$
>- Parent of $P[i]:P[\lfloor\frac i2\rfloor]$

![[Pasted image 20240823160531.png|Example|450]]
>[!theorem] Properties of Level  Numbering
>- $\forall i, 0 \leq i \leq h$: the $2^i$ nodes of the level i taken from left to right are: 
>$$P[2^i],P[2^i+1],...,P[2^{i+1}-2],P[2^{i+1}-1]$$
>- The nodes on the level h are:
>$$P[2^h],P[2^h+1],...,P[n] \text{ with n the last node}$$

This implementation is space efficient. Moreover any array can be seen as a complete binary tree.

### 4.1.1) Implementing the Methods of the Priority Queue
>[!def|*] Notation for Pseudocode
>Entry is defined as $P[i]$
>The last entry is $P[\text{last}]$

The min method returns the first item of the array, thus it has complexity $\Theta(1)$

### 4.1.2) Insert Method

^3c824a

The idea for this algorithm is to:
1. Insert the entry as a successor of the last node
2. Reconstruct heap from last node to root
	- The up-heap bubbling switches the new node with the parent if it doesn't respect order

![[Pasted image 20240823164346.png|insert Method|450]]
>[!conjecture|*] $\Theta(\log n)$
>`\begin{proof}`
Since the node can only go upwards, the complexity is at most the height of the tree, which is $\lfloor{\log_2n}\rfloor$, thus $\Theta(\log n)$
`\end{proof}`

>[!claim|*]
> Inv: at the end of every loop, $P[i]$ follows heap order priority with descendants
> **$S_{init}$:** when entry is inserted it it at $P[n]$, thus it is the last entry and has no descendants
> $S_i$: suppose it holds at $P[i]$, study at $P[\lfloor\frac i2\rfloor]$ (call $\lfloor\frac i2\rfloor$ j)
> - heap priority holds with descendants, but it might conflict with parent node
>- if it doesn't swap the invariant holds and the heap is restored
>- if it swaps the invariant holds since, by knowing that parent $\leq$ children, if the swap occurred, the node was also smaller than the other child
>
>**$S_{end}:$** at the last loop the heap was either restored midway, where the heap was guaranteed above and then also below, or it arrived at the root with every node below holding the priority

### 4.1.3) RemoveMin Algorithm
The idea for this algorithm is to:
1. Remove the first entry as it is the smallest
2. Put the last node in root position
3. Reconstruct heap from root
	- The down-heap bubbling switches with the smallest child
![[Pasted image 20240823172052.png|removeMin Method|550]]
>[!conjecture|*] $\Theta(\log n)$
>`\begin{proof}`
Since the node can only go downwards from the second level, the complexity is at most the height of the tree, which is $\lfloor{\log_2(n-1)}\rfloor$, thus $\Theta(\log n)$
`\end{proof}`

>[!claim|*]
Inv: $P[i]$'s ancestors don't violate the heap:
**$S_{init}:$** at start $P[i]=P[1]$ is root so the only ancestor is itself
**$S_i$:** suppose it holds at i level, see if it holds at the i+1 level:
>- it is necessary to check just with smallest child as parent $\leq$ children
>- if it is bigger, then swap it and the invariant holds
>
>**$S_{end}$:** if it stopped midway the order was guaranteed downsides by the heap correctness, while if it ended at the leaf the correctness was guaranteed by invariant ^063e14
### 4.1.4) How to Construct a Heap

Up until now we have studied the methods of an already formed heap, but how is it actually constructed? A trivial solution is to empty P in a support structure and call insert() n times, this is inefficient as in uses more space
>[!def] In-Place Algorithm
>An algorithm is called **in-place** if it uses O(1) space.

There are 2 main ways to implement a heap in-place, both share the same specification

```js
/*
Algorithm: heap
Input: array P with n entries P[1, n]
Output: P organized to represent a heap
*/
```

#### 4.1.4.1) Top-Down Approach
>[!col]
>The idea is to build the heap by starting from the top.
>.
>The invariant is j and states that from 1 to j the heap is formed.
>.
>As $P[j]$ gets inserted an up-heap bubbling is performed
>.
>The correctness is valid from the up-heap bubbling claims made in the paragraphs before
>>[!col]
>>![[Pasted image 20240824103036.png|Graphical Representation of the Invariant|250]]

![[Pasted image 20240824103251.png|Pseudocode|450]]
>[!conjecture|*] $\Theta \sum_{j=1}^{n-1}\log j$
>`\begin{proof}`
It is a consequence of the analysis of the insert() algorithm (see: [here](#^3c824a)).
$O \sum_{j=1}^{n-1}\log j$ is just the sum of all the bubblings
$\Omega \sum_{j=1}^{n-1}\log j$ is given by a decreasingly ordered array, this forces the worst bubbling in each loop
`\end{proof}`

This complexity isn't much explicative of the running time of this algorithm, thankfully there is a useful theorem that can help us
>[!theorem] 
>$\sum_{j=1}^{n-1}\log j \in \Theta(n\log n)$
>
>`\begin{proof}`
>$$\begin{align}
>\sum_{j=1}^{n-1}\log j = \log(\prod_2^nj)=\log(n!) \\
>
>\end{align}$$
>By the sterling approximation:
>$$\begin{gather*}
>n! = c \sqrt{2\pi n}(\frac ne)^n \text{ (sterling)}\\
>\log(n!)=\log(\sqrt{2\pi n}) + \log[(\frac ne)^n]=\log(\sqrt{2\pi n}) + n\log(\frac ne) \\
>\Theta(\log(\sqrt{2\pi n}) + n\log(\frac ne))=\Theta(n\log n)
>\end{gather*}$$
>
>`\end{proof}`

^6dfd8c

#### 4.1.4.2) Bottom-Up Approach
>[!col]
The idea is the opposite as before, we build the heap from the bottom
>.
>The invariant is j and states that from j to n the heap is formed.
>.
>As $P[j]$ gets inserted an down-heap bubbling is performed
>.
>The correctness is valid from the down-heap bubbling claims made in the paragraphs before
>>[!col]
>>![[Pasted image 20240824105313.png|Graphical Representation|250]]

^75eab7

![[Pasted image 20240824105450.png|Pseudocode|450]]
>[!conjecture|*] $\displaystyle O(n+\sum_{j=1}^{\lfloor n/2\rfloor}t_{P[j]})=O(n+\sum_{i=0}^{h-1}2^i(h-1))=\Theta(n)$
`\begin{proof}`
Set $t_{P[j]}$ as the cost of down heap bubbling from j. From here the first term is clearly explained.
The sum can be rewritten by noticing this:
>- At level $0 \leq i \leq h-1$ there are $2^i$ nodes and have a down-heap cost of $O(h-i)$
>
>The last term will be discussed in a separate theorem
`\end{proof}`

>[!theorem]
>$$\sum_{i=0}^{h-1}2^i(h-1)\in\Theta(n)$$
>
>`\begin{proof}`
>First we prove the following claim: $\sum_1^hl(\frac12)^l<3$
>TODO
>Now, we can use this to prove the theorem
>$$\begin{gather}
>\sum_{i=0}^{h-1}2^i(h-1)=2^h\sum_{i=0}^{h-1}\frac{2^i}{2^h}(h-1)=2^h\sum_{i=0}^{h-1}\frac{h-1}{2^{h-i}} \\
>\text{change of variable: } l = h-i \\
>2^h\sum_{l=1}^{h}l(\frac12)^l<3\times2^h \in \Theta(2^h)
>\end{gather}$$
>Since $h=\lfloor\log_2n\rfloor$ we have that $2^h=n$, thus $\Theta(2^h)=\Theta(n)$
>`\end{proof}`

^d3bc16

## 4.2) Sorting Through a Priority Queue

It is possible to sort a sequence $S$ of n keys by inserting them in a priority queue and extracting them back in $S$

Here's a recap of the "traditional" sorting algorithms and their comparison with the heap-sort:

|             | SelectionSort | InsertionSort | HeapSort                |
| ----------- | ------------- | ------------- | ----------------------- |
| insert()    | $\Theta(n)$   | $\Theta(n^2)$ | $\Theta(n)$ (bottom-up) |
| removeMin() | $\Theta(n^2)$ | $\Theta(n)$   | $\Theta(n\log n)$       |
That was the trivial approach, now let's see how to implement it in-place:

### 4.2.1) HeapSort In-Place
This algorithm is divided in 2 steps:
1) Rearrange the keys in a max-heap arrangement
2) Rearrange the max-heap in order

Phase 1 is very similar to a [min-heap](#^75eab7) implementation:
![[Pasted image 20240824112405.png|Max-Heap Implementation|450]]
the only difference is that the algorithm searches for the maxChild and therefore for a bigger key

Phase 2 on the other hand is a bit more complicated:
![[Pasted image 20240824112655.png|Phase 2 Implementation|450]]
The idea is to have $S[0, n-j-1]$ have the smallest key in max-heap form and the remaining keys are the biggest keys left in increasing order
![[Pasted image 20240824113016.png|350]]
A quick informal proof is to notice that the swap operation takes the top biggest remaining number in the max-heap and swaps it in the first position of the ordered sequence, thus keeping the invariant of the order true
Then the heap is restored by down-heap bubbling

>[!conjecture|*] $\Theta(n\log n)$
`\begin{proof}`
The complexity corresponds to n-1 removeMax(), thus:
$$\Theta(\sum_{1}^{n-1}\log i)\in\Theta(n\log n)$$
`\end{proof}`
# 5) Maps

A Map is a collection of entries that allows searching, inserting and remove entries based on their keys

>[!def] Map
>a **map** is a collection of entries with different keys from an universe $U$ in which "$=$" operator is defined, supporting the methods get, put, and remove

^a93ef5

A list implementation is inefficient, while an array of size $|U|$ has a disproportionate, if not impossible, size

## 5.1) Hash Table
A hash table is an array of size $N << U$ that has ways to assign each key in an array cell

>[!def] Hash Table
>A **hash table** consists of 3 main ingredients:
>- **Hash Function:** $h: U =\{keys\} \rightarrow [0, N]$
>- **Bucket Array:** is an array A of size N where $A[i]$ contains all entries associated with said key
>- **Method to resolve collisions:** since $N << U, \ h$ can't map all keys 1:1 and thus it must handle these edge-cases

>[!rmk|*]
>$h$ must be fast to compute and have an uniform distribution so that there are no preferred buckets and no particular correlations between keys

There are various ways to implement a collision resolution, we will study just one: **separate chaining:** each bucket is a smaller map implemented via a list

One significant parameter on the efficiency of a hash table is the **load factor**
>[!def] Load Factor
>For a hash table of capacity $N$ which memorizes n entries, the **load factor** is defined as:
>$$\lambda = \frac nN$$
>and represents the median length of a bucket.

TODO rehashing, complexity

## 5.2) Map Through Search Tree

The method put() is implemented exactly as the one mentioned [here](#^43c0a8).
### 5.2.1) Get Method
![[Pasted image 20240824144356.png|Pseudocode|450]]
>[!conjecture|*] $\Theta(h)$

### 5.2.2) Remove Method

^421103

remove() is a bit more interesting as it consists of 2 main cases:

![[Pasted image 20240824145622.png|Pseudocode without Cases|450]]
![[Pasted image 20240824145710.png|Case 1|350]]
![[Pasted image 20240824145740.png|Case 2|350]] ^8b54d8

>[!conjecture|*] $O(h)$

>[!claim|*]
The correctness is trivial. Just the case 2 is a bit harder to understand. The y node is the inorder predecessor of w. Being in the left subtree it is < than any other entry in the right subtree but it's the biggest one in the left subtree. The switch is then very easy.

>[!rmk|*]
>$O(h)\not=O(\log n)$ since it's not a complete tree and could be heavily unbalanced. Thus it might happen that $h \sim n$.

By looking at [multi-way search tree](#^917a4d) it is possible to use those methods to implement a more efficient map

## 5.3) Multimap

>[!def] Multimap
>A **multimap** is a map that admits entries with the same key.

in this case get() returns a collection of values, put() doesn't delete the old entry and remove() removes a pair of specified (key,value)

An example is a ranking. Suppose 3 players are playing a game where every manche their points change. A map would save them like
(1, 10), (1, 15), (1, 30), (2, 0), (2, 5), (2, 15), (3, 5), (3, 15), (3, 45)
while a multimap would save them as
(1, 10-15-30), (2, 0-5-15), (3, 5-14-45)


Here is a recap of the time complexities:

| Map      | Hash Table            | SBT           | (2,4)-Tree         |
| -------- | --------------------- | ------------- | ------------------ |
| get()    | $\Theta(1+\lambda)$   | $\Theta(h)$   | $\Theta(\log n)$   |
| put()    | $\Theta(1+\lambda)$   | $\Theta(h)$   | $\Theta(\log n)$   |
| remove() | $\Theta(1+\lambda)$   | $\Theta(h)$   | $\Theta(\log n)$   |
| Multimap |                       |               |                    |
| get()    | $\Theta(1+\lambda)$   | $\Theta(h)$   | $\Theta(\log n)$   |
| put()    | $\Theta(1+\lambda)$   | $\Theta(h)$   | $\Theta(\log n)$   |
| remove() | $\Theta(s+1+\lambda)$ | $\Theta(s+h)$ | $\Theta(s+\log n)$ |


# 6) Graphs

^12ae6f

Up until now we have studied trees, but these are just a particular case of a graph.
>[!def]
>A **graph** $G = (V, E)$, with:
>- $V \equiv$ set of vertices/nodes
>- $E \equiv$ set of arc/edges (i.e. pair of nodes)
>
>A graph is called **directed** if each edge $(u,v)\in E$ is an ordered pair $(u\rightarrow v)$, otherwise it is called **undirected** $(u-v)$
>Here's some **terminology:**
>- Given an edge $e = (u,v)\in E$ it is said that e is **incident** on u, v and that these two nodes are **adjacent**
>- Given a node v, the set of nodes $u_i : (v,u_i)\in E$ are called **neighbours** of v
>- The **degree** of a vertex is the number of edges i.e. the number of neighbours


![[Pasted image 20240825104047.png|Undirected and Directed Graph|550]]
>[!rmk|*]
>The definition allows for multiple edges between the same nodes and self loops. A graph without these elements is called **simple graph**.

## 6.1) Topological Definitions

First we need to define some fundamental topological concepts. These are very easy, but also important

>[!def] Path
>A **path** on a graph is described as:
>$$\text{Path: }u_1,...,u_k \text{ with } (u_i,u_{i+1})\in E \text{ for } 1\leq i\leq k$$
>the **length of a path** is the number of edges, or k-1. If the edges are weighted it's the sum of those weights
>A path is said **simple** if it has no repeated vertices

>[!def] Minimum Path
>Given two vertices $x,y \in V$ the **minimum path** between them is the path of minimum length
>
>It's length is called **distance $d(x,y)$**. By convention if a path doesn't exist it has infinite length

>[!def] Cycle
>A **cycle** is a path with $u_1=u_k$

>[!def] Subgraph and Spanning Subgraph
>A **subgraph** is defined as $G' = (V',E')$ with $V'\subseteq V, E'\subseteq E$ such that the arcs of $E'$ affect only $V'$.
>
>A **spanning subgraph** is a subgraph where $V' = V$ (some edges are missing from the full graph)

>[!def] Connected/Disconnected Graph
>A graph is said **connected** if $\forall (u,v)\in V \ \exists$ a path connecting them
>A graph is **disconnected** if it is not connected

>[!def] Connected Component
>The **connected components** of a graph $G$ are the maximal connected subgraphs of $G$, or the family of subgraphs $G_i = (V_i, E_i), \ i\in[1,k]$ such that:
>- $G_i$ is connected $\forall i$
>- $V=\displaystyle\bigcup_i^kV_i$ (partitions of $V$)
>- $E=\displaystyle\bigcup_i^kE_i$ (partitions of $E$)
>- $\forall i \not= j$, there are no edges between $V_i, V_j$

>[!def] Trees
>As stated before, trees are a special type of graph, let's define it:
>>[!def|*] Rooted Tree
>A **rooted tree** is a graph $G$ such that:
>>- There is a root node $r$
>>- $\forall u \in V$ with $u\not=r$ there is a unique parent $p(u)\in V$ the tree then has $E=\{u, p(u):u\in V, u\not=r\}$
>
>>[!def|*] Free Tree
>>A **free tree** is a graph connected without cycles
>
>>[!def|*] Forest
>>A **forest** is a graph that is a set of disjointed free trees
>
>>[!def|*] Spanning Tree
>>A **spanning tree** is a subgraph of $G$ with no cycles (free tree).
>
>>[!def|*] Spanning Forest
>>A **spanning forest** is a spanning subgraph with no cycles
>
>
>>[!rmk|*]
>>the concept of tree and free tree are equivalent by correctly choosing a root node in the free tree

^fb6abe

>[!theorem] Properties
>Let $G$ be a simple non directed graph with $|V|=n, |E|=m$, then
>- $\sum_{v \in V}\text{degree}(v) = 2m$
>- $m \leq \binom n2$, then $m\in O(n^2)$
>- If $G$ is a tree, then $m=n-1$
>- If $G$ is connected, then $m\geq n-1$
>- If G is without cycles (forest), then $m\leq n-1$

Let's prove them:
`\begin{proof}`
1) By considering every neighbour of every node each edge is counted twice
2) Notice that: $$\binom n2 = \frac{n!}{2(n-2)!}=\frac{n(n-1)\cancel{(n-2)!}}{2\cancel{(n-2)!}}\in O(n^2)$$
3) Every edge represents a parent-child relationship. The root is the only node not having a parent $\implies m = n-1$
4) Idk
5) If $G$ is connected, then it is a spanning tree and 3) holds
	if it is not connected it is made of $k\geq2$ spanning trees: $$
	\sum_{i=1}^km_i=\sum(n_i-1)=\sum(n_i)-k=n-k<n-1
	$$
`\end{proof}`

## 6.2) Graph Representation

The easiest representation uses two lists $(L_V, L_E)$, one for the vertices and one for the edges:
![[Pasted image 20240825120150.png|List Representation of a Graph|450]]
This implementation is inefficient as it is necessary to have a direct link to neighbours. An **adjacency list** is a list that holds a list of adjacent nodes for every node:
![[Pasted image 20240825120353.png|Adjacency List Representation|450]]
This uses $\Theta(n+m)$ space and allows for sequential access to neighbours in linear time. Unless specified, we assume this representation is used.

There is a third type of representation using a matrix in $\Theta(n^2)$ space and has the form:
$$A[i_1,i_2]=
\begin{cases}
\text{null} \\
\text{pointer to }e =(i_i,i_2)\in E
\end{cases}$$
![[Pasted image 20240825120944.png|Adjacent Matrix Representation, the Arrows Link the Same Edge|350]]
## 6.3) Visits

There are two main ways to visit a graph:
- **Breadth-First Search (BFS):** first visit all neighbours, then continue with all the neighbours of neighbours
- **Depth-First Search (DFS):** visit one neighbour, continue from there

![[Pasted image 20240825121507.png|Example|350]]
### 6.3.1) BFS
Before explaining the algorithm we define some more notations:
>[!def|*] Notation
>- Given $s\in V, \ C_s \subseteq G$ denotes the connected component of $G$ containing $S$
>- Assume each node has a field v.ID that is 1 if it has been visited
>- Assume each edge can be labeled as **discovery edge** or **cross edge** or not be labeled if the algorithm hasn't visited it

The idea of the algorithm is simple: start from $s$, then
- visit all vertices of $C_s$
- label all the arcs of $C_s$
- partition the vertices of $C_s$ into levels $L_i$ according to their distance i from s

![[Pasted image 20240825134837.png|Specification|350]]
![[Pasted image 20240825134859.png|Pseudocode|450]]

The first while loop is a simple check: if $L_i$ is empty, there are no neighbours of any node left, i.e. there's no node left

The list $L_{i+1}$ is the list where all the new neighbours are stored for the next iteration

then, check every edge for every node of $L_i$.
- if the edge was labelled then both nodes were already been visited
- otherwise it must check the id of w
	- ID = 1: e is a cross edge as both have been already visited
	- ID = 0: e is a discovery edge and w is visited, added to $L_{i+1}$ and ID set to 1

>[!conjecture|*] $\Theta(m_s)$ with $m_s$ the # of edges in $C_s$
>`\begin{proof}`
>>[!todo]
>`\end{proof}`


>[!theorem] Properties of BFS
>At the end of each cycle these following propositions are valid
>- In $C_s$ all nodes and edges have been visited/labeled
>- By only considering *discovery edges* we can define a spanning tree of $C_s$
>- The path from s to any node $v \in L_i$ has distance i
>- If an edge is a *cross edge*, it's nodes level differ at max of $i = 1$

`\begin{proof}`1)
Actually visiting all nodes of $C_s\implies$ labelling all edges.
Consider $z\in C_s$, then there must be a path $s=u_o,u_i,...,u_k=z$
since s has been visited, and at any loop all the neighbours are visited, after k loops any node at k distance has been visited
`\end{proof}`
`\begin{proof}`2)
Consider only discovery edges, if v discovers w we know that $v\in L_i, \ w\in L_{i+1}$
It is immediate that:
- $\forall w\in C_s, \ w\not=s$ w is discovered only once(otherwise it is a cross edge and we must ignore it). That is: there exists only one father at a higher level
- going back from parent to parent we arrive at s (tree)
`\end{proof}`
`\begin{proof}`3)
As seen in 2) it is possible to go back parent by parent thus confirming the i length
Consider by contradiction that there exists a shorter path, then it is possible to have
$$\begin{align}
&s = z_0 &\in L_0 \\
&z_1 &\in L_1 \\
&... \\
&v = z_k &\in L_j &\text{ with } j\leq k<i \text{ that is, there is one or more shorter steps}\\
\end{align}$$
but this can't be since we have supposed $v \in L_i$ in 2) 

`\end{proof}`
`\begin{proof}` 4)
By contradiction suppose $v\in L_i, u \in L_{i+k}, k\geq 2$
But the once the algorithm finds $v \in L_i$ it will add all it's neighbours (including $u$) in $L_{i+1}$
`\end{proof}`

To visit all the graph this snippet is added:
![[Pasted image 20240825135331.png|Pseudocode|250]]
>[!remark|*]
>BFS is the optimal way to find a **minimum path**
### 6.3.2) DFS
![[Pasted image 20240826135954.png|Specification|400]]
![[Pasted image 20240826135554.png|Pseudocode|450]]
This algorithm is recursive. It is easy to see how the if w.ID=0 statement launches another recursive call and therefore the visits propagate in depth first.
if ID=1 for all neighbours, the algorithm can go to the next neighbour of same level

>[!conjecture|*] $\Theta(m_s)$ with $m_s$ the # of edges in $C_s$ 

>[!theorem]
>At the end of each execution, on $C_s$ we have that:
>- In $C_s$ vertices are visited and all edges are labelled
>- The *discovery edges* form a spanning tree of $C_s$
>- In the edges that got labelled as back edges, the opposite vertex is an ancestor of the current node

`\begin{proof}` 3)
If an edge isn't labeled and w.ID = 1 this means that w was already visited but DFS wasn't concluded (otherwise e would've been labeled). Then there exists a sequence w-v where DFS was executed directly on all nodes in path
`\end{proof}`
## 6.4) Weighted Shorted Path

Recall that in a weighted graph the path length is given by the sum of it's weights, so the shortest path doesn't necessarily correspond to the minimum number of edges

We will use the Dijkstra algorithm which uses a priority queue based on the path length to store the paths

here are some additional specifications required:
- v.D stores current distance from a
- v.parent stores predecessor in current shortest path from s to v
- for the priority queue we assume that:
	- the key is v.d
	- Q.has(v) returns true if it contains v
	- Q.decreaseKey(v.D, v) replaces entry with same node replaces the distance if v.D > old v.D while keeping the heap intact

![[Pasted image 20240826144348.png|Specification|350]]![[Pasted image 20240826144430.png|Pseudocode|450]]
The while loop extracts the node with the shortest path from the queue (first iteration extracts s).
The forall method checks with every neighbour (v) of the extracted node (u) the following:
- if queue has still v, and the path coming from u is shorter than what v has stored, then the key of v gets decreased in the queue and u is set as parent

>[!claim|*]
>The correctness is a direct consequence of the following two theorems:
>>[!theorem|*]
>>At the end of each iteration of the while cycle the following inv. is valid:
>>- if v.D = $+\infty$, thus v.parent = null
>>- if v.D < $+\infty$, thus the the obtained path by ascending parent by parent is a path of length v.D
>
>>[!theorem|*]
>>When a vertex is extracted from the queue, it is equivalent to the correct smallest distance
>>
>>`\begin{proof}`
>>By contradiction suppose lemma 2 is wrong
>>Call z the first extracted vertex with z.D $\not=$ d(s, z), then it must hold that:
>>- $z \not= s$
>>- z.D > d(s, z)
>>>[!todo]
>>`\end{proof}`
>
>By these 2 lemmas the correctness holds, since:
>- From 1), when v is extracted from Q by going up parent by parent we obtain the distance
>- From 2), when v is extracted we have that v.D is the right distance

>[!conjecture|*]
>|                  | Heap             | Doubly-Linked List |
| ---------------- | ---------------- | ------------------ |
| Initial Building | $\Theta(n)$      | $\Theta(n)$        |
| removeMin()      | $\Theta(\log n)$ | $\Theta(n)$        |
| has()            | $\Theta(1)$      | $\Theta(1)$        |
| decreaseKey()    | $\Theta(\log n)$ | $\Theta(1)$        |
>
> Then, by the following theorem we have:
>>[!theorem]
>>The complexity of ShortestPath() is $O(\min\{n^2, (n+m)\log n\})$
>>The algorithm is going to choose the best implementation based on what is faster
>>The list is $O(n^2)$, the heap $O((n+m)\log n)$
>>
>>The heap executes n times removemin, and m times decreaseKey (during the edge relaxation)


The following algorithm has **complexity $Theta(n+m\log n)$**. This is because it inserts entries in Q when their distance is set. The while loop performs $n_S$ iterations but each entry is inserted/extracted only once and still m edge relaxations TODO
![[Pasted image 20240901170153.png|Pseudocode|450]]
## 6.5) Directed Graphs

>[!def] Directed Graph
>In a directed graph each edge can be either outgoing or ingoing
>Given a vertex v:
>- Edges (v, u) are **outgoing** 
>- Edges (u, v) are **incoming**
>- **Outdegree** # of outgoing edges
>- **Indegree** # of incoming edges
>
>A simple graph is a directed graph where each group of neighbours has both incoming and outcoming edges

### 6.5.1) Topology
>[!def] Reachable Vertices
>Given a vertex v, the **reachable set of vertices of v** are all the nodes that allow a path from v to u

>[!def] Undirected Version of a Directed Graph
>By ignoring the directions of the edges of $G$, we can define it as being undirected $G^U$

>[!def] Strongly\weakly connected graph
>A graph is called **strongly connected** if there exists a path for all pair of nodes
>It is **weakly connected** if only $G^U$ is connected

A directed graph is represented via adjacency lists where only the outgoing neighbours are listed for each node
![[Pasted image 20240826171301.png|Example|450]]

### 6.5.2) Visiting
The traversing is very similar as before, but we must change the way we label edges:
![[Pasted image 20240826171652.png|Changes made to the previous algorithms|450]]
Clearly this will visit only the reachable set of vertices of s.

## 6.6) Directed Acyclic Graph
>[!todo]
# 7) Sorting

>[!def] Comparison Based Algorithms
>In a **comparison-based sorting algorithm** the sorting of keys for any sequence $S$ is determined exclusively by comparing pairs of keys

All comparison based algorithms have the same specification:
![[Pasted image 20240827094243.png|Spacification|350]]
## 7.1) Design Pattern: Divide and Conquer

To solve sorting problems a common design pattern is used, called **divide and conquer**. The idea is to divide each instance of the computational problem in 3 instances:
1) **Divide:** 
	- if $n\leq n_0$, resolves i directly (base case)
	- if $n>n_0$ it identifies, starting from i, 2 or more instances for each size < n
2) **Conquer:** it solves each instance
3) **Combine:** it  correctly combines all solved instances

## 7.2) Merge Sort
 We will implement the following algorithm with the divide and conquer approach:
 Base case: $n_0=1$
 1) Divide: $S_1$ subsequence with first half of $S$, $S_2$ subsequence with second half
 2) Conquer: Recursively order $S_1, \ S_2$
 3) Combine: fuse the two ordered subsequences

![[Pasted image 20240827095003.png|Pseudocode|400]]
![[Pasted image 20240827095100.png|Merge Pseudocode|400]]
>[!conjecture|*] $\Theta(n\log n)$
>`\begin{proof}`
>to find the complexity of merge sort we must first find the complexity of merge:
>>[!conjecture|*] $\Theta(n)$ with n the sum of keys in $S_1,S_2$
>>`\begin{proof}`
>>Since both arrays get added, and every add is $\Theta(1)$, then we have $S_1 + S_2 = n$ operations
>>`\end{proof}`
>
>By using a recursion tree:
>- Case $n=2^d$: here the recursion tree is complete and has $d+1$ levels and $2^i$ nodes per level. Thus on every entry at level i the cost of merge is $\Theta(\frac{n}{2^i})\implies \Theta(2^i\frac{n}{2^i})\Theta(n)$ aggregated cost at level i. $\Theta(n\cdot d)=\Theta{n\log n}$
>- Case $2^d<n<2^{d+1}$: In the recursion tree there are $\leq2^i$ nodes per level. That is there are d+2 levels in the tree
>`\end{proof}`

## 7.3) Quick Sort
Base case: $n_0=1$
1) Divide: $p \leftarrow S[n-1]$, create 3 not sorted arrays: $$\begin{align}&L \leftarrow \ \text{keys in < p in S} \\ &E \leftarrow \ \text{keys in = p in S} \\ &G \leftarrow \ \text{keys in > p in S}\end{align}$$
2) Conquer: Recursively order L, G
3) Combine: $S \leftarrow L + E + G$ by concatenation

![[Pasted image 20240827103106.png|Pseudocode|400]]
![[Pasted image 20240827103134.png|Partition Pseudocode|400]]
Partition is really simple: Given $S[a \div b]$ sets $l\leftarrow a, r\leftarrow b-1, p = S[b]$ and while advancing l,r towards the center it checks if they are smaller/bigger then p. once it finds 2 in the wrong position it swaps them. It continues until r and l meet and returns l. As l is returned $S[l]=p$ is in the correct position as it was the middle value between L, G

>[!conjecture|*] $\Theta(n^2)$
>`\begin{proof}`
>To prove this we must discuss the time complexity of partition:
>>[!conjecture|*] $\Theta(b-a+1)
>>`\begin{proof}`
>>Every 2 iterations of the outer while at least one, if not both, of l,r move
>>The number of operations is proportional to the number of moves
>>$\implies$ the number of total moves is b-a +1
`\end{proof}`
>
>We know that after each iteration a set of $\geq1$ keys are ordered $\implies$ the recursion tree has max n depth
>By partition each level has $O(n-i)$ complexity:
>$$\sum_{i = 0}^{n-1}(n-i)= n\cdot n-\frac{n(n+1)}{2}\in O(n^2)$$
`\end{proof}`

### 7.3.1) Randomised QuickSort
There is a variant of quick sort that **avoids the worst case probabilistically**
the only difference happens in partition(): instead of $p\leftarrow S[b]$ we write:
![[Pasted image 20240827105946.png|Pseudocode Difference|250]]
## 7.4) Insertion Sort
![[Pasted image 20240827113529.png|Pseudocode|350]]
>[!conjecture] $\Theta(n^2)$

>[!todo]

## 7.5) Sorting Not Based on Comparisons
Actually at the core a comparison is still made, but we use previously studied data structures to sort.

### 7.5.1) Bucket Sort

Bucket sort is a stabile sorting algorithm
>[!def] Stabile Sorting Algorithm
>Entries with the same key have the same relative order in input/output

The sequence used in a bucket sort must have integer entries belonging in $[0, N-1]$
- In the first scan it creates N buckets(queue) and inserts entry with key k in bucket k
	- from here the fifo ordering is explicited and shows that this algorithm is stable
- In the second scan it extracts them

![[Pasted image 20240827114236.png|Pseudocode|400]]
>[!conjecture] $\Theta(n+N)$ with n # of keys and N range of keys
>`\begin{proof}`
>The first loop is executed n times, $\Theta(n)$
>The second loop has $n_k$ entries in $B[k]$: $\sum_{k=0}^{N-1}n_k=n$
>	Thus we require $n_k+1$ operations in each cycle: $\sum_{k=0}^{N-1}n_k+1=n+N$
>`\end{proof}`

>[!rmk|*]
>If $N\in n\log n$ then bucket sort is better than any sorting algorithm

### 7.5.2) Radix Sort
Radix sort is a generalisation of bucket sort and receives as inputs entries made of $d\in [0,N-1]$ digits
It implements a bucket sort on any digit position

![[Pasted image 20240902105440.png|Pseudocode|450]]

It is possible to represent any number of an interval $[0, M-1]$ with M>n with a base $N\leq M$ representation
To do this it set $N=n$ and $d=\lceil\log_N M\rceil$, then each number k can be represented as $k = \sum_0^{d-1}c_i N^i$ with $c_i=\frac{k}{N^i}\mod N$.
This will give a complexity of $d(n+N)=\log_N(M)(n+N)=\frac{\log N}{\log M}(n+N)$
if $N=n$ the formula is minimised
# 8) Trick I Noticed in Exercises
## 8.1) Trees:
If the problem asks to find max node based on depth/height the algorithm is recursive and has 2 outputs: result, info needed for recursive step.
![[Pasted image 20240829105715.png|Example|350]]