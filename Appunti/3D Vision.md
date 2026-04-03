# 1) Mathematical Model
## 1.1) Projective Plane
#### Perspective Projection
Since from 3D to 2D some information is lost, the perspective is non-linear. The coordinates get divided by z, so that farther objects appear smaller.
The following equations hold:
$$\frac fz=\frac{-u}x=\frac{-v}y\rightarrow \begin{cases}u=-f\frac xz\\v=-f\frac yz\end{cases}$$
Which is a non-linear operation

This allows to represent all 3D points, besides two:
- point inside focal plane (f)
- point on horizontal line (h)
![[Pasted image 20260303152837.png|Example|350]]

#### Homogeneous Coordinates
Consider two lines
$$\begin{bmatrix}x\\y\end{bmatrix}=\begin{bmatrix}a&b\\a'&b'\end{bmatrix}^{-1}\begin{bmatrix}-c\\-c'\end{bmatrix}\rightarrow \begin{bmatrix}x\\y\end{bmatrix}=\frac1{\det{\begin{bmatrix}a&b\\a'&b'\end{bmatrix}}}\begin{bmatrix}bc'-b'c\\a'c-ac'\end{bmatrix}$$
From here they intersect at 
$$x=\frac{bc'-b'c}{ab'-a'b}=\frac uw\qquad y=\frac{a'c-ac'}{ab'-a'b}=\frac vw$$
where the point $(u,v,w)$ is the point in homogeneous coordinates.
In particular:
- $w=0$ the point lies at infinity (all of $(u,v,0)$ form line $l_\infty$)
- $w\not=0$ point lies in euclidean space
- if $(u,v,w)$ solves the system, then also $\lambda(u,v,w)$ does. This means a single Cartesian point can be represented by infinitely many proportional homogeneous triplets.
#### Projective Plane
The projective plane $\mathbb P^2$ is the union of the euclidean plane $\mathbb R^2$ and the line at infinity $l_\infty$.

| Cartesian Plane                                                                             | Projective Plane                                                         |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| Given two different points there exists only one line that contains them                    | Given two different points there exists only one line that contains them |
| There exists only one line with a given direction and containing a certain point P          | Two different lines have only one common point.                          |
| Two different lines have either a common point (incident) or the same directioon (parallel) |                                                                          |
A line in with homogeneous coordinates is expressed in the following way:
$$ax+by+c=0\rightarrow au+bv+cw=0$$
where $X=(u,v,w)$ is a point and the line coefficients $Y=(a,b,c)$ then the line can be expressed via a dot product $X^TY=0$.

Therefore the projective plane contains:
- the euclidean plane $\mathbb R^2$; that is, all lines of form $(a,b,c)$ where at most one between $a,b$ is 0.
- the line at infinity $l_\infty$; that is, the line of form $(0,0,c)=\lambda(0,0,1),\ c=\lambda\not =0$. Here the points are of form $(u,v,0)$ since $cw=0\rightarrow w=0$. These specify a direction

The projective plane $\mathbb P^2$ is made of point triplets $(u,v,w)\not=(0,0,0)$ given the equivalence equation $(u,v,w)\sim \lambda(u,v,w)\ \forall \lambda \not =0$.

This is like representing points as intersection of lines. In fact consider
$$L_1=(a,b,c), L_2=(a',b',c')\rightarrow (u,v,w)=L_1\times L_2$$
Consider two parallel lines $L_1=(a,b,c),L_2=(a,b,c')$ their intersection corresponds in a point at infinity:
$$L_1\times L_2=(2b,-2a,0)=(-b,a,0)$$


---
Example for better understanding:
An euclidean point $(2,4)$ becomes subset of points point $\lambda(2,4,1)$ in homogeneous coordinates. This corresponds to a line in $\mathbb R^3$ going through the origin and containing all the points $\lambda(2,4,1)$. In fact the equation of the line is $l(\lambda)=\begin{cases}u=2\lambda\\v=2\lambda\\w=\lambda\end{cases}=\lambda\cdot \begin{bmatrix}2\\4\\1\end{bmatrix}$.
In general terms the point $(x,y)$ is the homogeneous line $\lambda[x,y,1]^T=(u,v,w), w\not = 0$

As a recap:
- The homogeneous origin is not defined
- All euclidean points cross the plane $z=1$ (shifted xy plane) in homogeneous coordinates
- A direction $(d_x,d_y)$ corresponds to the homogeneous point $(d_x,d_y,0)$
- The origin corresponds to the the z-axis line
- Non euclidean points (points at infinite, directions) never cross the plane $z=1$.
## 1.2) Transformations
#### Affine and Projective Transformations
$$ $$
>[!def] Projective Transformations
**Projective transform** or projectivity is a linear application in homogeneous coordinates
$$f:\mathbb P^n\rightarrow \mathbb P^n\qquad f:x\rightarrow Hx$$
>where H is a non singular $n+1\times n+1$ matrix.
>- They keep collinearity
>- Form a group ($f\in \mathcal G_P$)
>- H and $\lambda H$ are the same

>[!def] Affine Transformations
**Affine transform** or affinity is a projectivity that maps real points in real points and ideal points in ideal points.
>An affinity must be equal to $$H=\begin{bmatrix}A_{n\times n}&b\\0&1\end{bmatrix}$$
>- Keeps parallelism

>[!def] Similarity Transformations
A **similarity** is represented by
$$H=\begin{bmatrix}sR_{n\times n}&b\\0&1\end{bmatrix}$$
>with $s$ scalar and $R$ orthogonal matrix
>- Keeps angles

With $s=1$ it is called **euclidean transformation** and keeps distances and lengths.

## 1.3) Camera Model
#### Camera Model with Homogeneous Coordinates
In homogeneous coordinates the world-camera relation becomes
$$M=\begin{bmatrix}X\\ Y\\ Z\\1\end{bmatrix},\qquad  m=\begin{bmatrix}u\\ v\\1\end{bmatrix}$$
and then
$$Zm=\begin{bmatrix}-fx\\-fy\\z\end{bmatrix}=\underbrace{\begin{bmatrix} -f & 0 & 0 & 0\\0&-f&0&0\\0&0&1&0\end{bmatrix}}_{P}\begin{bmatrix}X\\ Y\\ Z \\ 1\end{bmatrix}=PM$$
and so with respect to scale these are equal
$$m\approx PM$$
- Case $P=[I|0]$: 
	- Z is the optical axis
	- Principal Point is the origin of image plane
- General case:
	- No common axis
	- Size and shape of CCD wrt to principal point

Let $u_0,v_0$ be the coordinates of the principal point, $\theta$ the the orientation of the sensor wrt to CCD and $k_u,k_v$ the pixel size, then the camera matrix becomes
$$P=\left[
\begin{array}{ccc|c}
 -f k_u & -fk_u\cot\theta & u_0 & 0 \\
  0 & \frac{-fk_v}{\sin\theta} & v_0 & 0 \\
  0 & 0 & 1 & 0
\end{array}
\right]$$
Define the **intrsinsic parameter matrix**
$$K=\begin{bmatrix}-fk_u&0&u_0\\0&-fk_u&v_0\\0&0&1\end{bmatrix}$$
then $P=K[I_3|0]$
#### Camera Motion
Now suppose the camera coordinates are not aligned with the world coordinates, then the camera coordinates $M_c$ become:
$$M_c=GM=\begin{bmatrix}R&t\\0_{3\times 1}&1\end{bmatrix}$$
so in general we can do the following:
$$m\approx PM_c=K[I_3|0]GM$$
and the **general camera matrix is**
$$P=K[R|t]$$
the coordinates can be normalized as $p=K^{-1}m$
in these coordinates the projection matrix is $P[I|0]$
#### Principal Point and Center of Projection
A generic camera matrix 𝑃 can be rewritten according to its rows as:
$$P=\begin{bmatrix}p_1^T\\p_2^T\\p_3^T\end{bmatrix}\rightarrow m\approx PM=\begin{bmatrix}p_1^TM\\p_2^TM\\p_3^TM\end{bmatrix}$$

so the coordinates of a pixel in the plane becomes (cartesian coords):
$$\begin{cases}
u=\frac{p_1^TM}{p_3^TM}\\v=\frac{p_2^TM}{p_3^TM}
\end{cases}$$
Notice that the focal plane contains all the points at infinite, so 
$$p_3^TM=0$$
The points on axis $u=0$ and $v=0$ are the projection of 3D points that satisfy $p_1^TM=p_2^TM=0$ and therefore teh COP $C$ becomes $pC=0$.
**In cartesian coordinates the cop becomes**
$$\tilde C=-Q^{-1}q$$
since by writing $P=[Q|q]$ and $C=[\tilde C, 1]^T$ this holds $PC=Q\tilde C+q=0$

#### Optical Ray
Given a point $m$ in the imaging plane, a **ray** is the line that contains COP $C$ and $m$, that is, the set of points M such that:
$$\curly{M:m\approx PM}$$
Therefore by definition one point is $C$  and anther is the ideal point $[Q^{-1}m, 0]^T$ since $P[Q^{-1}m, 0]^T=[Q|q][Q^{-1}m, 0]^T=QQ^{-1}m+q0=m$

So the ray is obtained as
$$M=C+\lambda\begin{bmatrix}Q^{-1}m\\0\end{bmatrix},\ \lambda \in \mathbb R\cup \curly\infty$$
where $\lambda$ is the variable of the ray that selects the point on the line based on the distance from $C$.

>[!example]
>Let $Q$ be the COP and $P$ a pixel in the imaging plane. The optical ray can be written as
>$$M=Q+tV,\ t\in\mathbb R\cup \curly\infty$$
>where $V$ is the $PQ$ direction normalized: $PQ=P-Q\rightarrow V=\frac{PQ}{\|PQ\|}$
>Now suppose I have a surface with normal $n$ at point $S$. The intersection between the ray and the surface is at distance (if they intersect)
>$$t'=\frac{(S-Q)n}{nV}$$
>at point 
>$$P=Q+t'V$$
>and the intersection happens at distance $\|P-S\|$ from $S$.

# 2) Illumination
z-buffer vs raster vs ray tracing
todo
# 3) Animation
3D animation is the spiritual successor of stop motion animation. Some key frames are specified with some key poses and the remaining frames are interpolated.

Uncanny valley: human characters result disturbing
However, non realistic humanoid characters have a better response!

![[Pasted image 20260309143529.png|Uncanny Valley|350]]

#### Articulated Characters
We generate a skeleton for the 3d mesh. Mesh is then modified and connected to the elements of the skeleton via a skinning operation.

![[Pasted image 20260309144228.png|Example|350]]

There are 4 frequent joints:
- Hinge: rotation along 1 axis (1 DoF)
- Saddle: back and forth + up and down (2 DoF)
- Ball-and-socket: rotation along all 3 axes (3 DoF)
- Sliding: translation on a plane (2 DoF)

But a joint can in general support up to 6 DoF

Animating them via key poses is not trivial for complex motions: we resort to **puppeteering** (motion capture).

However real life movements do not work precisely for animation (12 rules of animation) and some very complex elements (hair, water, physiscs) are simulated.

# 4) Homography Estimation
3D objects need to be localized in the image.
>[!def] Homography
>Homography is the function that maps points of plane $\Pi$ on the image plane
>$$\Pi:Z=0$$
>that is, it maps a plane into another plane

$$\begin{bmatrix}u\\v\\1\end{bmatrix}=\begin{bmatrix}p_{11}&p_{12}&p_{13}&p_{14}\\p_{21}&p_{22}&p_{23}&p_{24}\\p_{31}&p_{32}&p_{33}&p_{34}\end{bmatrix}\begin{bmatrix}x\\y\\0\\1\end{bmatrix}=\underbrace{\begin{bmatrix}p_{11}&p_{12}&p_{14}\\p_{21}&p_{22}&p_{24}\\p_{31}&p_{32}&p_{34}\end{bmatrix}}_{H}\begin{bmatrix}x\\y\\1\end{bmatrix}$$
that is:
$$m'=H_\Pi m\quad m\in \Pi$$
where $H$ is a $3 \times 3$ singular matrix defined wrt scale factor (8 DoF).
Homography can also be composed:
![[Pasted image 20260309154735.png|Composition|350]]
Since $m_i'\approx Hm_i$ we have that 
$$m_i'\times Hm_i\approx m_i'\times m_i'=0$$
then
$$[m'_i]_\times Hm_i=0\rightarrow \text{vec}([m'_i]_\times Hm_i)=0\rightarrow (m_i^T\otimes [m'_i]_\times)\text{vec(H)}=0$$

call $A=m_i^T\otimes [m'_i]_\times$ with rank 2 and thus the sizes
$$A_{2n\times 9}\ vec(H)_{9\times1}=0$$
Only 4 points are needed for the homography


##### Basci Linear Algebra Recap
**Scalar product:**
$$a^T\cdot b=<a,b>=\sum_{i=1}^na_ib_i=b^T\cdot a=|a||b|\cos\theta\rightarrow \theta=\frac{<a,b>}{|a||b|}$$
**Outer (vector) product:**
$$c=a\times b=|a||b|\sin\theta \ (u_a\times u_b)$$
let $a=[a_1,a_2,a_3]^T$ similar for b. Then:
$$c=a\times b=\begin{bmatrix}
\hat x &\hat y &\hat z\\
a_1 & a_2 & a_3\\
b_1&b_2&b_3
\end{bmatrix}=\begin{bmatrix} \det \begin{pmatrix} a_2 & a_3 \\ b_2 & b_3 \end{pmatrix} \\ -\det \begin{pmatrix} a_1 & a_3 \\ b_1 & b_3 \end{pmatrix} \\ \det \begin{pmatrix} a_1 & a_2 \\ b_1 & b_2 \end{pmatrix} \end{bmatrix}=\begin{bmatrix}
( a_2b_3-a_3b_2)\\
-( a_1b_3-a_3b_1)\\
( a_1b_2-a_2b_1)
\end{bmatrix}$$
we can also define the external product matrix:
$$[a]_\times=\begin{bmatrix}0& -a_3& a_2\\a_3 & 0 & a_1\\-a_2 & a_1& 0\end{bmatrix}\rightarrow [a]_\times b=a\times b$$
moreover:
$$\det(a\times b\times c)=a^T(b\times c)=(a\times b^T)c$$
then also:
$$[A^{-1}u]_\times=A^T[u]_\times A$$
**Norm of a matrix:**
- Frobenius: $\|A\|=\sqrt{\sum_{i,j} a_{i,j}^2}$
- Euclidean: $\|A\|=\frac{\|Au\|}{\|u\|}$ with $\forall u: \|u\|\leq1$

**Moore Penrose pseudoinverse:**

**Singular Value Decomposition (SVD)**

**Kronecker Product:**
$$[A_{m\times n}\otimes B_{p\times q}]_{mp\times nq}=\begin{bmatrix}a_{1,1}B&a_{1,2}B&...& a_{1,n}\\
a_{2,1}B&a_{2,2}B&...& a_{2,n}\\
\vdots\\
a_{m,1}B&a_{m,2}B&...& a_{m,n}\end{bmatrix}$$
moreover: $rank(A\otimes B)=rank(A)rank(B)$

**Vec operator:**
$$vec(A)=[a_{1,1},...,a_{m,1},a_{1,2},...,a_{1,n},...,a_{m,n}]^T$$
moreover:
$$vec(ABC)=(C^T\otimes A)vec(B)$$


----

## 4.2) Epipolar Geometry

# 5) Stereo Systems
Stereo system uses two views of the same scene to estimate depth. This si done via the disparity between points in a scene.

Call $F$ the $3\times3$ **fundamental matrix** that encapsulates info about epipolar geometry
$$F=[e']_\times Q'Q^{-1}$$
such that the Lounget-Higgins equation becomes:
$$m'^TFm=0$$
#### Simple Triangulation
Let two cameras be parallel and aligned (image plane corresponds), then by knowing:
- $b$ distance between cameras. If unknown the distance is a scaling factor
- $f$
- $(u-u')$ disparity between two points

The distance z is computed by
$$z=\frac{bf}{u'-u}$$
#### General Case
In the generic case a stereo system is not in the ideal condition to estimate distance, however through homographies it is possible to do so.


$$\begin{bmatrix}
p_1^TM-up_3^TM\\
p_2^TM-vp_3^TM\\
p_1'^TM-u'p_3'^TM\\
p_2'^TM-v'p_3'^TM
\end{bmatrix}=AM=0_{4\times 1}$$
With a SVD ($A=U\Sigma V^T$) decomposition of A and by taking the last eigenvector (last vector of $V$) we get the solution. This can be generalized to $N$ cameras.

SVD finds the algebraic minimum, to minimize the geometric cost we can use
$$\epsilon(M)=\|\begin{bmatrix}u\\v\end{bmatrix}-\begin{bmatrix}\frac{p_1^TM}{p_3^TM}\\\frac{p_2^TM}{p_3^TM}\end{bmatrix}\|^2+
\|\begin{bmatrix}u'\\v'\end{bmatrix}-\begin{bmatrix}\frac{p_1'^TM}{p_3'^TM}\\\frac{p_2'^TM}{p_3'^TM}\end{bmatrix}\|^2$$
**Suppose we know $m$ but not $m'$, it is possible to find $m'$ via the epipolar line.**

---
Proof of formula.
Let there be 2 cameras with matrices:
$$P=\begin{bmatrix}p_1^T\\p_2^T\\p_3^T\end{bmatrix}\qquad P'=\begin{bmatrix}p_1'^T\\ p_2'^T\\ p_3'^T\end{bmatrix}$$
where at the i-th row we have the vector $p_i^T$
$$\begin{bmatrix}u\\v\\1\end{bmatrix}=qPM\rightarrow \begin{cases}
u=p_1^TM\\
v=p_2^TM\\
1=p_3^TM
\end{cases}\rightarrow 
\begin{cases}
u(p_3^TM)=p_1^TM\\
v(p_3^TM)=p_2^TM\\
\end{cases}\rightarrow 
\begin{cases}
p_1^TM-up_3^TM=0\\
p_2^TM-vp_3^TM=0\\
\end{cases}
$$
and the final system of linear equations in matrix form becomes (for each camera)
$$\begin{bmatrix}
p_1^TM-up_3^TM\\
p_2^TM-vp_3^TM\\
\end{bmatrix}=0_{2\times 1}$$
combining both cameras we obtain
$$\begin{bmatrix}
p_1^TM-up_3^TM\\
p_2^TM-vp_3^TM\\
p_1'^TM-u'p_3'^TM\\
p_2'^TM-v'p_3'^TM
\end{bmatrix}=AM=0_{4\times 1}$$
With a SVD ($A=U\Sigma V^T$) decomposition of A and by taking the last eigenvector (last vector of $V$) we get the solution. This can be generalized to $N$ cameras.
$\endproof$

#### Image Rectification