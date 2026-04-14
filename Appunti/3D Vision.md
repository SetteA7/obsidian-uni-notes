# 1) Mathematical Model

## 1.1) Image Formation
#### Pinhole Model

Consider the following:
- $M$ 3D world point
- $m$ 2D image point corresponding, projection of $M$

![[Pasted image 20260414190909.png|Geometry|250]]
The projection is non-linear
$$\frac fz=\frac{-u}x=\frac{-v}y\rightarrow \begin{cases}u=-f\frac xz\\v=-f\frac yz\end{cases}$$
The angles and distances are lost, but straight lines remain straight.

![[Pasted image 20260414191217.png|Notation|450]]
## 1.2) Projective Plane
#### Perspective Projection
Recall the non linear projection
$$\begin{cases}u=-f \cdot x/z\\v=-f\cdot y/z\end{cases}$$

This model takes a point $M$ and traces a line throuhg $C$. The intersection of that line and $R$ is $m$

This allows to represent all 3D points, besides two:
- point inside focal plane (f)
- point on horizontal plane passing through $C$  (h)
![[Pasted image 20260303152837.png|Example|350]]
To solve this problem we extend the euclidean plane with ideal lines lying at infinite. This is the projective plane:
$$\text{Projective Plane: }\mathbb P^2=\mathbb R^2\cup l_\infty$$
_(can be generalized to $\mathbb P^N$)_

The projective plane and the euclidean plane have different properties:

| Cartesian Plane                                                                             | Projective Plane                                                         |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| Given two different points there exists only one line that contains them                    | Given two different points there exists only one line that contains them |
| There exists only one line with a given direction and containing a certain point P          | Two different lines have only one common point.                          |
| Two different lines have either a common point (incident) or the same directioon (parallel) |                                                                          |

---

#### Homogeneous Coordinates
Homogeneous coordinates are used in order to transform the non linear projection equation to a linear one. Concretely it just consists in adding a new coordinate:
$$\tilde m=\begin{bmatrix}u\\ v\end{bmatrix}\longrightarrow  m=\begin{bmatrix}u\\ v\\1\end{bmatrix}$$
But the last coordinate is not always 1.
Call the last coordinate $w$. 
- It turns out that any point with $w\not=0$ is an euclidean point corresponding to point $( u/w,v/w)$. That is:
$$\forall \lambda \neq 0,\quad m=\begin{bmatrix} u \\ v \\ w \end{bmatrix} \simeq \lambda m=\begin{bmatrix} \lambda u \\ \lambda v \\ \lambda w \end{bmatrix} \quad \longrightarrow \quad \tilde{m} = \begin{bmatrix} u/w \\ v/w \end{bmatrix}$$
where $\simeq$ is the equivalence w.r.t. scale factor.
- Therefore if $(u,v,w)$ solves a system, so does $(\lambda u,\lambda v,\lambda w)$
- If $w=0$ the point does not lie in euclidean space, it lies at infinity and so it is a part of the projective plane.

Therefore homogeneous coordinates are used to represent points in the projective plane.

---
Proof:
Euclidean coordinates express the point as the intersection of two lines.
Consider two generic lines:
$$\begin{bmatrix}x\\y\end{bmatrix}=\begin{bmatrix}a&b\\a'&b'\end{bmatrix}^{-1}\begin{bmatrix}-c\\-c'\end{bmatrix}\rightarrow \begin{bmatrix}x\\y\end{bmatrix}=\frac1{\det{\begin{bmatrix}a&b\\a'&b'\end{bmatrix}}}\begin{bmatrix}bc'-b'c\\a'c-ac'\end{bmatrix}$$
From here they intersect at 
$$x=\frac{bc'-b'c}{ab'-a'b}=\frac uw\qquad y=\frac{a'c-ac'}{ab'-a'b}=\frac vw$$
where the point $(u,v,w)$ is the point in homogeneous coordinates.
The three cases presented are a direct consequence (cannot divide by $w=0$ so is not point in euclidean space)
$\endproof$
#### Projective Plane
Recall the projective plane contains the lines at infinite
$$\mathbb P^n=\mathbb R^n\cup l_\infty$$
In turns out that, a point in $\mathbb P^n$ are all the points on a line in $\mathbb R^{n+1}$.

Limit the study to $n=2$:

##### Points to Lines
Recall that any non-zero homogeneous point $(u,v,w)\not = (0,0,0)$ is equivalent w.r.t. scale factor to other points:
$$(u,v,w)\simeq \lambda (u,v,w)\quad \forall\lambda\not =0$$
However notice that a triplet of values is a line in $\mathbb R^3$ **passing through the origin**. In fact the line is:
$$l(\lambda)=
\begin{cases}
x(\lambda)=\lambda u\\
y(\lambda)=\lambda v\\
z(\lambda)=\lambda w
\end{cases}
=\ \lambda\cdot \begin{bmatrix}u\\ v\\ w\end{bmatrix}$$
Here we can see that the image plane is defined by the plane $w=1$. Again with this we can see that the projective plane contains all the points where $w\not =0$. 

##### Lines to Points
If points are already lines. Then how do we represent a line in the projective plane?
A line in homogeneous coordinates is expressed as the dot product of a point $X=(u,v,w)$ and a direction $Y=(a,b,c)$:
$$X^TY=0\rightarrow au+bv+cw=0$$
This corresponds to taking a non-homogeneous point $x,y$ and making it intersect with a line:
$$ax+by+c=0\rightarrow a\frac uw+b\frac vw+c=0\stackrel{w\not =0}\longrightarrow au+bv+cw=0$$
Clearly now based on the direction we can find these results:
- $a=b=0$ then the line is an ideal line $l_\infty$ (never passes through $w=1$)
- The full euclidean plane is contained in the projective plane
- The euclidean origin corresponds to the the z-axis line

This is like representing points of $\mathbb P^2$ as intersection of lines in $\mathbb R^3$. In fact consider
$$L_1=(a,b,c), L_2=(a',b',c')\rightarrow (u,v,w)=L_1\times L_2$$
Consider two parallel lines $L_1=(a,b,c),L_2=(a,b,c')$ their intersection corresponds in a point at infinity:
$$L_1\times L_2=(2b,-2a,0)=(-b,a,0)$$
A direction $(d_x,d_y)$ corresponds to the homogeneous point $(d_x,d_y,0)$, this is where two parallel lines intersect.

## 1.3) Transformations
#### Affine and Projective Transformations


| Transformation | D.o.f. | Matrix $H$                                                                                       | Preserves           | Description and additional info                                                                       |
| -------------- | ------ | ------------------------------------------------------------------------------------------------ | ------------------- | ----------------------------------------------------------------------------------------------------- |
| Projectivity   | 8      | $\begin{bmatrix}H_{11}&H_{12}&H_{13}\\ H_{21}&H_{22}&H_{23}\\ H_{31}&H_{32}&H_{33}\end{bmatrix}$ | Collinearity        | $H$ is a non singular  matrix. Moreover $H=\lambda H$. This maps projective plane to projective plane |
| Affinity       | 6      | $\begin{bmatrix}H_{11}&H_{12}&H_{13}\\ H_{21}&H_{22}&H_{23}\\ 0&0&1\end{bmatrix}$                | Parallelism         | maps real points in real points and ideal points in ideal points.                                     |
| Similarity     | 4      | $\begin{bmatrix}sR&t\\0&1\end{bmatrix}$                                                          | Angles              |                                                                                                       |
| Euclidean      | 3      | $\begin{bmatrix}R&t\\0&1\end{bmatrix}$                                                           | Distance and length |                                                                                                       |


---

## 1.4) Camera Model
#### Camera Model with Homogeneous Coordinates
Rewrite the projective equations so to use the homogeneous coordinates:
$$\begin{cases} u=-f \frac xz\\ v=-f\frac yx\end{cases}$$

Which in matrix form becomes
$$zm=z\begin{bmatrix}u\\ v\\ 1\end{bmatrix}=\begin{bmatrix}-fx\\-fy\\z\end{bmatrix}=\underbrace{\begin{bmatrix} -f & 0 & 0 & 0\\0&-f&0&0\\0&0&1&0\end{bmatrix}}_{P}\begin{bmatrix}X\\ Y\\ Z \\ 1\end{bmatrix}=PM$$
and thus w.r.t. scale
$$m\simeq PM$$
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


# 2) Rendering Techniques
## 2.1) Illumination
z-buffer vs raster vs ray tracing
todo
## 2.2) Animation
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

# 3) Homography Estimation
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

## 3.2) Epipolar Geometry

# 4) Stereo Systems
Stereo system uses two views of the same scene to estimate depth. This si done via the disparity between points in a scene.

This chapter will follow this structure:
- Understand the basic case (simple triangulation)
- Understand the general case and how this tells us that conjugate points are on the same epipolar line
- Rectify the images so that the generic case becomes the simple triangulation case
- Given $m$ find the matching point $m'$ 
#### Simple Triangulation
Let two cameras be parallel and aligned (image plane corresponds), then by knowing:
- $b$ distance between cameras. If unknown the distance is a scaling factor
- $f$ focal distance
- $(u-u')$ disparity between two points

The distance z is computed by
$$z=\frac{bf}{u-u'}$$
In this case the camera matrices are
$$P=K[I|0]\qquad P'=K[I|(-b,0,0)^T]$$
## 4.2) Passive Stereo Systems
#### General Case
**Suppose we know $m$ but not $m'$, it is possible to find $m'$ via the epipolar line.** This is because the ray of camera $C$ to point $M$ is seen by camera $C'$ as a line (epipolar line).

Call $F$ the $3\times3$ **fundamental matrix** that encapsulates info about epipolar geometry
$$F=[e']_\times Q'Q^{-1}$$
such that the Lounget-Higgins equation becomes:
$$m'^TFm=0$$
The epipolar line is $l'=Fm$ so the equation tells us that $m'$ lies on $l'$. 

Now suppose that the matching points are known:
In the generic case a stereo system is not in the ideal condition. The generic cameras are
$$P=\begin{bmatrix}p_1^T\\p_2^T\\p_3^T\end{bmatrix}\qquad P'=\begin{bmatrix}p_1'^T\\ p_2'^T\\ p_3'^T\end{bmatrix}$$
Knowing the two matching points, the point in 3d space $M$ is found by solving this equation
$$\begin{bmatrix}
p_1^TM-up_3^TM\\
p_2^TM-vp_3^TM\\
p_1'^TM-u'p_3'^TM\\
p_2'^TM-v'p_3'^TM
\end{bmatrix}=AM=0_{4\times 1}$$
With a SVD decomposition of A ($A=U\Sigma V^T$) and by taking the last eigenvector (last vector of $V$) we get the solution. This can be generalized to $N$ cameras.

Since in real case scenarios due to noise the points don't lie on the epipolar line but slightly diverge, then SVD finds the algebraic minimum, to minimize the geometric cost we can use (find $M$ that minimizes)
$$\epsilon(M)=\|\begin{bmatrix}u\\v\end{bmatrix}-\begin{bmatrix}\frac{p_1^TM}{p_3^TM}\\\frac{p_2^TM}{p_3^TM}\end{bmatrix}\|^2+
\|\begin{bmatrix}u'\\v'\end{bmatrix}-\begin{bmatrix}\frac{p_1'^TM}{p_3'^TM}\\\frac{p_2'^TM}{p_3'^TM}\end{bmatrix}\|^2\rightarrow M=\arg\min_M\epsilon(M)$$
This however is harder to compute.

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

---
Proof that in the simple case the matching points are on the epipolar lines:
Let
$$P=K[I|0]\qquad P'=K[I|t=(-b,0,0)^T]$$
Find $[t]_\times$:
$$[\mathbf{t}]_\times = \begin{bmatrix} 0 & -t_z & t_y \\ t_z & 0 & -t_x \\ -t_y & t_x & 0 \end{bmatrix} = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & b \\ 0 & -b & 0 \end{bmatrix}$$
Since there is no rotation, $Q'Q^{-1}=I$ and the fundamental matrix is $F=[t]_\times I=[t]_\times$, then the epipolar line is:
$$l' = F m = \begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & b \\ 0 & -b & 0 \end{bmatrix} \begin{bmatrix} u \\ v \\ 1 \end{bmatrix} = \begin{bmatrix} 0 \\ b \\ -bv \end{bmatrix}$$
The Lounget-Higgins equation now is:
$$m'^TFm=\begin{bmatrix} u' & v' & 1 \end{bmatrix} \begin{bmatrix} 0 \\ b \\ -bv \end{bmatrix}=(u' \cdot 0) + (v' \cdot b) + (1 \cdot -bv) = b(v' - v)=0\stackrel{b\not =0}\rightarrow v'=v$$
they are on the same epipolar line (horizontal) $m=[u,v,1], \ m'=[u'=u+d,v',1]$
$\endproof$
In the general case we have
$$P=K\begin{bmatrix}I|0\end{bmatrix}\qquad P'=K'\begin{bmatrix}R|t\end{bmatrix}$$
assume that $K=K'=I$. The optical ray of the first image and going to point $M$ is:
$$M=\lambda \begin{bmatrix}m\\1\end{bmatrix}=\lambda\hat m$$
These points are projected onto the second camera
$$q'm'=\lambda Rm+t$$
Multiply by $t$ to remove scalars (recall $t\times t=0$) and multiply by $m'$ to remove left term (recall $t\times m'\perp m'$)
$$ t\times(q'm')=t\times(\lambda Rm+t)\rightarrow q' (\mathbf{t} \times m') = \lambda (\mathbf{t} \times R m)\rightarrow m'^T(t\times Rm)=0$$
where $F=t\times R$ is the fundamental matrix
$\endproof$


---
#### Image Rectification
Image rectification is the process of transforming (using homographies) the image so that the focal planes are the same (epipoles at infinite and vertical coordinates of conjugate points are the same). This allows us to find the distance using the simple triangulation.
![[Pasted image 20260403185354.png|Rectification Process|300]]
This is done by rotating around $C$ (or $C'$). This needs to be computed once, then if the cameras are not moved the rotation matrix is the same.

#### Conjugate Points Matching
Since the cameras are differently orientated, some matches can be wrong for various reasons:
- **False matches:** given by sift
- **Occlusion:** due to parallax some points can be occluded in one image and be visible in the other. *Their identification is important*
- **Radiometric Distortion:** different lighting conditions based on different angles
- **Perspective Distortion:** change of geometry based on different angles

The constraints we are looking for are:
- **Similarity:** similar pixels in both images
- **Epipolar Geometry:** the correspondence is only o the epipolar line
- **Smoothness:** close pixels have approx same disparity if on same region
- **Uniqueness:** no double matches
- **Ordering:** position depends on camera itself

There are two different classes of algorithms (methods)
- **Local Methods:** uses local characteristic that affects small regions at a time
- **Global Methods:** constraint on whole scan line or entire image

##### Local method: Block Matching
Block matching is a local method that can be summarized by the following passages.
- Around each pixel $m=(u,v)$,and its conjugate candidate $m'=(u+d,v)$ it selects a block of $(2n+1)\times(2m+1)$ pixels
- Compute a coupling metric between the block around $m$ and $m'$
- Operation repeated for different disparity values $d\in[d_\min,d_\max]$
- Find $d_0(u,v)$ that minimizes/maximizes the metric

Various metrics can be used based on:
- correlation (NCC, ZNCC) (maximize)
- intensity difference (SSD. SAD) (minimize)
- rank operators (census) (minimize)

These metrics are for dense estimation, find matching point for all pixels (in theory)

Small window: not reliable disparity, only reliable if signal is highly variable in the window
Large window: noisy measurments

A solution is to use multi resolution windows or fixed windows.

###### **Sum of Squared Difference (SSD):**
Minimize
$$SSD(u,v,d)=\sum_{k,l}(I_1(u+k,v+l)-I_2(u+k+d,v+l))^2\quad k\in[-n,n]\  l\in[-m,m]$$
Then minimize it
$$d_0(u,v)=\arg\min_{d\in[-d_\max,d_\max]}SSD(u,v,d)$$
###### **Sum of Absolute Differences (SAD)**
Minimize
$$SAD(u,v,d)=\sum_{k,l}|I_1(u+k,v+l)-I_2(u+k+d,v+l)|\quad k\in[-n,n]\  l\in[-m,m]$$
And again minimize it

This is better than SAD since:
- is less sensitive to noise
- requires well limited complexity
- better functions can be defined such as Cauchy Functios

larger block size smooths the output.

###### **Normalized Cross Correlation (NCC)**
Maximize
$$NCC(u,v,d)=\frac1{(2n+1)(2m+1)}\sum_{k,l}\frac{I_1(u+k,v+l)I_2(u+k+d,v+l)}{\sqrt{M_1(u,v)}\sqrt{M_2(u+d,v)}}$$
where $M$ is the mean intensity of the block
$$M=\frac1{(2n+1)(2,+1)}\sum_{k,l} I(u+k,v+l)^2$$

###### **Zero-Mean Normalized Cross Correlation (ZNCC)**
Maximize
This is invariant to illumination changes as it normalizes with the window average ($M$) and variance ($\sigma$)
$$\begin{align}
ZNCC(u,v,d)=&\frac1{(2n+1)(2m+1)}\ \cdot\\
&\cdot \sum_{k,l}\frac{(I_1(u+k,v+l)-M_1(u,v))(I_2(u+k+d,v+l)-M_2(u+d,v))}{\sigma_1{(u,v)}\sigma_2{(u+d,v)}}
\end{align}$$
with
$$\sigma(u+v)=\frac1{(2n+1)(2m+1)}\sum_{k,l}(I(u+k,v+l)-M(u,v))^2$$
###### **Census Transform**
Minimize
This transform the window in a binary string and then calculates the humming distance between windows
The function that transforms two pixels into a bit is:
$$\varepsilon(I,p,p')=\begin{cases}
1 & I(p)>I(p')\\
0
\end{cases}$$
And the block is found by concatenating ($S$ is the block)
$$C[I(p)]=\bigodot_{p'\in S}\varepsilon(I,p,p')$$
![[Pasted image 20260403202226.png|Example|250]]



The **Sum of Census Hamming Distances (SCH)** is
$$SCH(u,v,d)=\sum_{k,l}C[I_1(u+k,v+l]\ominus C[I_2(u+k+d,v+l)]$$
This is:
- invariant to changes in gain, bias, illumination
- robust to occlusion
- can be parallelized
- only computes on integers (fast and precise)



#### Exercises
Recall that given the pixel size $p_u,p_v$ the coordinates must be scaled by $k_i=1/p_i$ and the pixels are therefore interpolated.

>[!exercise|*]
>Suppose we have a stereo system with:
>![[Pasted image 20260404161947.png|Parameters|300]]
>What is the **maximum measurable distance?** Assume minimum disparity = 1 and rectified cameras.
>Recall the distance formula:
>$$z=\frac{bf}{\Delta u}$$
>from the table we get: $b=0.15 \unit{m}, f_c=0.018\unit m$.
>From the resolution and sensor size we get the pixel size (which is square):
>$$p_u=\frac{23.55\unit{mm}}{6000}=3.9\unit{\mu m}\qquad p_v=\frac{15.6\unit{mm}}{4000}=3.9\unit{\mu m}$$
>The focal becomes: $$f=\frac{f_c}{p_u}=4615$$
>Since the minimum resolution is 1 we get:
>$$z_\max=\frac{bf}1=692\unit m$$
>What is the **depth estimation error?**
>Derive the distance and find the magnitude:
>$$\frac{\partial z}{\partial\Delta u}=-\frac{bf}{\Delta u^2}\rightarrow \abs{\partial z}=\frac{bf}{\Delta u^2}\partial \Delta\stackrel{\Delta u=\frac{bf}{z}}\longrightarrow \abs{\partial z}=\frac{z^2}{bf}\partial\Delta$$
>This formula tells that it works for close distances but the error becomes increasingly large for bigger distances


>[!exercise|*]
>Now suppose I have 4 points (table), which are percieved separate?
>![[Pasted image 20260404163929.png|parameters|400]]
>Find the parameters as before:
>$$\begin{align}
b=0.07\unit m\\
f_l=0.006\unit m\\
p_u=7.4\unit{\mu m}\\
f=810\\
z_\max =bf=57 \unit m
\end{align}$$
>Recall the error formula:
>	$$\Delta z=\frac{z^2}{bf}\Delta u\stackrel{\Delta u=1}\rightarrow \begin{cases}
P_1: \Delta z_1=1.7 \unit m\\
P_2:\Delta z_2=11\unit m\\
P_3:\Delta z_=74 \unit m\\
P_4:\Delta z_=112 \unit m
\end{cases}$$
>so we can draw this quick graph:
>![[Pasted image 20260404170045.png|Graph|350]]
>Clearly $P_1,P_2$ are distinguishable but $P_3,P_4$ can be misinterpreted for any other point.
>


## 4.3) Active Stereo Systems
Active stereo systems are used to illuminate the world with a light source (projector) and then using this additional information on the passive stereo system.

This can be done via **Active Stereo Methods**:
- **Structured light:** place custom texture on the world
![[Pasted image 20260404171146.png|Example|250]]
- **Laser pointer:** a laser light is projected on a point of the scene; the two stereo cameras acquire the image and localize the point. Multiple acquisitions are needed (one 3D point per image).
![[Pasted image 20260404171336.png|Example|250]]
- **Laser Line:** a laser line (blade) is projected on the object; acquired line is intersected with the two epipolar lines. A single line of 3D point is acquired. Multiple acquisitions are needed.
![[Pasted image 20260404171351.png|Example|250]]

or also **Active Triangulation Methods:**
- **Laser line:** similar to active stereo methods with laser line. Intersect the plane of the line with optic rays. Need for a geometric model of projector and calibration
![[Pasted image 20260404171529.png|Example|250]]
- **Coded light:** multiple bands are projected on the surfaces of objects. More lines (planes) = less images required.
![[Pasted image 20260404171546.png|Example|250]]
For short range scanners we have:
Todo

#### Active Triangulation
In the case of 1 projector and 1 camera we have that the relation of the point $M$ in the world coordinates of the two cameras is:
$$M_p=RM_c+t$$
The distance can be estimated by knowing the rotation between the two cameras $R$, their traslation $t$ and the point $u_p$ of the camera image plane.
$$z_c=\frac{t_1-t_3u_p}{(u_pr_3^T-r_1^T)p_c}$$

It is possible to use multiple stripes with $N$ different patterns to estimate multiple points at once: 
TODO
##### Structured light depth camera
These cameras are based on active triangulation (kinect and others).

The kinect camera projects an IR pattern on the scene. The pattern is know and when the camera captures the image, it calculates the disparity between the pattern and the captured image. Using the disparity the distance can be found by:
$$z=0.1236\tan\par{\frac{D(u,v)}{2842.5}}$$

The pixel difference is of form $u_c=u_p+d$ .
This is a 2.5D not fully 3D since only one point of view

Pros and cons:
todo

Coding:
todo

---

Proof of relation between $M_p$ and $M_c$:
First focus on the projector $C$ project point $m_p$ to a real world point $M_p$ on plane $\Upsilon$.
We have the classic relation:
$$\begin{cases}
u_p=-f_p\frac{x_p}{z_p}\\
v_p=-f_p\frac{y_p}{z_p}
\end{cases}
$$

By assuming that point $m_p$ is in normalized coordinates $p_p$ (that is $f_p=-1$ or $K_p=I$):
$$p_p=\begin{bmatrix}
u_p\\ v_p\\1
\end{bmatrix}=
\begin{bmatrix}
x_p/z_p\\ y_p/z_p\\z_p/z_p
\end{bmatrix}=
\frac1{z_p}M_p
$$
where 
$$M_p=\begin{bmatrix}
x_p\\ y_p\\ z_p
\end{bmatrix}=G_pM=[R_p|t_p]M$$
The point M is therefore
$$\begin{aligned}
M_p=R_pM+t_c
\end{aligned}$$

Now focus on the camera. This will project point $M_c$ onto its image plane $m_c$. Expressing in normalized coordinates we have (identical as before):
$$p_c=\begin{bmatrix}u_c\\ v_c\\1
\end{bmatrix}=
\begin{bmatrix}
x_c/z_c\\ y_c/z_c\\ z_c/z_c
\end{bmatrix}=
\frac1{z_c}M_c$$
where again:
$$M_c=\begin{bmatrix}
x_c\\ y_c\\ z_c
\end{bmatrix}=G_cM=[R_c|t_c]M$$
Set the reference point on the camera($R_c=I,T_c=0$). Now we have:
$$M_c=M$$
Clearly point $M$ is the same for both cameras and the relation between $M_c$ and $M_p$ becomes
$$M_p=R_pM_c+t_p$$
or in the general case:
$$M_p=\underbrace{R_pR_c^T}_{R}M_c+\underbrace{t_p-R_pR_c^Tt_c}_t$$
$\endproof$
Proof of distance:
From the previous result we have
$$M_p=RM_c+t\qquad p_p=\frac1{z_p}M_p\qquad p_c=\frac1{z_c}M_c$$
combining them we end up with
$$\begin{aligned}
z_pp_p=M_p\\
z_cp_c=M_c
\end{aligned}\rightarrow 
z_pp_c-z_cRp_c=t\rightarrow
\begin{cases}
z_pu_p-z_cr_1^Tp_c=t_1\\
z_pv_p-z_cr_2^Tp_c=t_2\\
z_p-z_cr_3^Tp_c=t_3
\end{cases}$$
$v_p$ cannot be estimated so we remove that equation, we can now solve the system and we get:
$$z_c=\frac{t_1-t_3u_p}{(u_pr_3^T-r_1^T)p_c}$$
This is actually the generalized disparity case.
$\endproof$
Proof of simple active triangulation:
Lets return to the case of simple triangulation $R=I$ and $t=[-b,0,0]^T$. The formula now becomes:
$$z_c = \frac{-b - (0 \cdot u_p)}{(u_p [0, 0, 1] - [1, 0, 0]) \begin{bmatrix} u_c \\ v_c \\ 1 \end{bmatrix}}=\frac{-b}{u_p-u_c}$$
this reduces to the disparity.
Otherwise solve directly the system (recall $z_p=z_c=z$):
$$z_pp_c-z_cRp_c=t\rightarrow z \begin{bmatrix} u_p \\ v_p \\ 1 \end{bmatrix} = z \begin{bmatrix} u_c \\ v_c \\ 1 \end{bmatrix} + \begin{bmatrix} -b \\ 0 \\ 0 \end{bmatrix}$$
the first line becomes:
$$z u_p = z u_c - b \implies z(u_p - u_c) = -b \implies \mathbf{z = \frac{-b}{u_p - u_c}}$$
exactly the disparity (with $f_c=-1$)
$\endproof$

# 5) Lidar and ToF
## 5.1) Time Of Flight (ToF)
A Time of Flight (ToF) sensor isn active sensor that estimates distance by measuring the time it takes to send a light pulse and receive the reflected signal.

For a flat surface the distance ($z$) can be calculated by knowing the e2e time of flight ($\tau$)
$$z=\frac {c\tau}2\qquad \tau=\frac{2z}{c}\qquad c\approx 3\cdot 10^8 \unit{m/s}$$
#### Basic Idea
**Signal And acquisition:**
The camera sends a **amplitude modulated signal** at a modulated frequency $f_{mod}$:
$$s_E(t)=A_E[1+\sin(2\pi f_{mod}t)]$$
When the signal is reflected and acquired by the camera, the returned signal is
$$s_R(t)=A_R[1+\sin(2\pi f_{mod}t+\Delta\phi)]+B_R$$
where $A_R\propto1/z^2$ and the phase $\Delta \phi\propto \tau$, while $B_R$ depends on other sources of illumination.

![[Pasted image 20260407183227.png|Example|350]]
Therefore the phase difference can be used to calculate the distance:
$$\Delta\phi=2\pi f_{mod}\tau=2\pi f_{mod}\frac{2z}c\rightarrow z=\frac c{4\pi f_{mod}}\Delta \phi$$
While $A_R,B_R$ are used to better estimate the process


**Parameter Estimation:**
The signal is processed in discrete time with at least 4 samples/period. $T_S=1/4f_{mod}$, that is $F_S=4f_{mod}$.
The estimation is the MD:
$$(\hat A_R,\hat B_R,\hat {\Delta\phi})=\arg\min_{A_R,B_R,\Delta \phi}\sum_{n=0}^3\abs{s_R^n-A_R\sin(n\frac\pi2+\Delta\phi)-B_R}^2$$
The solution to the minimization problem becomes:
$$\begin{gather}
\hat A_R=\frac{\sqrt{(s_R\iter0-s_R\iter2)^2+(s_R\iter 1-s_R\iter 3)^2}}2\\
\hat B_R=\frac{s_R\iter 0+s_R\iter 1+s_R\iter 2+s_R\iter 3}2\\
\hat{\Delta\phi}=\text{arctan2}(s_R\iter0-s_R\iter 2,s_R\iter 1-s_R\iter 3)
\end{gather}$$
where the arctan2 returns the correct quadrant.

**Phase Wrapping and Further Estimations:**
Since $\Delta\phi\in[0,2\pi]$ the distances are $z\in[0,c/2f_{mod}]$. (example $f=30\unit{Hz}\rightarrow z_\max =5 \unit m$). This **phase wrapping** can be solved using multiple $f_{mod}$

Now focus on the other parameters:
Noise depends on the incoming light power (scattering and other light sources). Model it as a gaussian distribution with variance
$$\sigma_p=\frac{c}{4\pi f_{mod}}\frac{\sqrt{B_R}}{\sqrt 2 A_R}$$

Within the area of a pixel, there might be multiple measured distances, so we take the mean between the biggest and the smallest distance.

#### Matricial ToF Sensors
For a camera with $N\times M$ pixels, we cannot use $N\times M$ rays. A lens can be used to collimate the rays:
$$z_T\begin{bmatrix} u_T\\  v_T \\ 1
\end{bmatrix}=K_T\begin{bmatrix}x_T\\ y_T \\ z_T
\end{bmatrix}$$
This adds a distortion of 
$$\hat m_T=\begin{bmatrix}\hat u_T\\ \hat v_T \\ 1
\end{bmatrix}=\psi(m_T)$$
Now estimate the distance:
$$\hat r_T=\sqrt{\hat x_T^2+\hat y_T^2+\hat z_T^2}=\abs{[\hat x_T^2,\hat y_T^2,\hat z_T^2]^T}$$
and undistort the lens
$$m_T=\psi^{-1}(m_T)$$
The final distance is 
$$\hat z_T=\frac{\hat r_T}{\abs{K_T^{-1}m_T}}$$
which corresponds to the point in 3D space
$$M_T=K_T^{-1}\begin{bmatrix} u_T\\  v_T \\ 1
\end{bmatrix}\hat z_T$$
using 2 modulated frequencies $f<f'$ 
For each frequency calculate the phase difference as before:
$$\Delta\phi_i=\par{2\pi f_i\frac{2z}c}(\mod2\pi)$$
then calculate their difference:
$$\begin{gather}\Delta\phi_{syn}=\Delta\phi_2-\Delta\phi_1(\mod 2\pi)\\ f_{syn}=f_2-f_1\end{gather}$$
the max measurable distance is:
$$z=\frac c{4\pi f_{syn}}\qquad z_\max=\frac c{2f_{syn}}\Delta\phi_{syn}$$
## 5.2) Light Detection And Ranging (LiDaR) TODO
Lidar is a specific type of ToF sensor with wavelengths in IR (10 $\mu m$) or UV (250 $nm$)

## 5.3) 3D RF Sensor
The radar-based RF sensor Walabot Pro senses the environment by transmitting, receiving and recording signals from an array of linearly polarized broadband antennas. It creates a 3D RF map of the radiated environment

Combined with ML (DL) techniques it can be sued for hand gesture recognition or also **material classification**. 

Also mmWaves were proposed for hand gestures (Pixel 4) or in autonomous driving.

# 6) Multi View Reconstruction SLAM and SfM
The aim of multi view reconstruction is to compute the 3D structure of a scene.

Intrinsics of the camera are known and conjugate points are available (SIFT).

This is partially done by stereo systems but 2 cameras are needed and they need to be calibrated. The return a dense reconstruction

Multi view reconstruction needs 1 camera and only intrinsic parameters are known and the camera is moving. The result is a sparse match of conjugate points and the camera location at different instants


|             | Steropsis        | Multi View                                                  |
| ----------- | ---------------- | ----------------------------------------------------------- |
| Camera (s)  | 2 (fixed)        | 1 (moving)                                                  |
| Calibration | Full calibration | Intrinsic parameters $K$ known (SLAM) or uncalibrated (SfM) |
| Output      | Dense map        | Sparse conjugate points                                     |
| Scale       | Absolute         | Relative                                                    |

---

We will compare two methods:

|               | SLAM                           | SfM          |
| ------------- | ------------------------------ | ------------ |
| Time          | Real Time                      | Offline      |
| Input         | Ordered                        | Unordered    |
| Setup         | Intrinsic parameters $K$ known | Uncalibrated |
| Spatial Scale | Local (few km)                 | Planetary    |
| Frame         | Only last $N$ frames           | All frames   |

---

## 6.1) Spatial Localization And Mapping (SLAM)
SLAM works in **real-time** on an **ordered** sequence of images acquired from a fixed camera set-up.

However some key limitations arise:
- Incremental process so errors stack up (drift)
- Small spatial scale
- Noisy estimation so bundle adjustment is needed

#### 2 Images
Consider two images taken by the same camera where the intrinsic parameters matrix $K$ is known.

First we introduce the **Essential Matrix**
$$E\def[t]_\times R$$
which in the Lounget-Higgins equation is the relation between the two normalized points (one point is on the epipolar line of the other)
$$p'^T[t]_\times Rp=0$$
The essential matrix has these properties:
- $\text{rank}(E)=2$ since $\det(\stackvec t)=0$
- Scale factor change does not affect $E$
- 3 rotation d.o.f, 2 translation d.o.f.
- since points are in front of camera, the third coordinate must be positive
- With SVD decomposition the 3 singular values are $\begin{cases}\sigma_1=\sigma_2\not=0\\\sigma_3=0\end{cases}$

But $R,t$ (roto-traslation between the two frames) are not known and therefore $E$ needs to be estimated using the **8 Points Algorithm**:
Let the first image have $P=K[I|0]$ and the second have $P'=[R|t]$.  The conjugate points $(m'_i,m_i)$ can be normalized to $(p=K^{-1}m, p'=K^{-1}m')$ which must satisfy the equation
$$p_i'^TEp_i=0$$
which can be decomposed into
$$(p_i^T\otimes p_i'^T)\text{vec}(E)=0
\rightarrow 
\underbrace{\begin{bmatrix}
p_1^T\otimes p_1'^T\\
\vdots\\
p_n^T\otimes p_n'^T
\end{bmatrix}}_{U_n}
\text{vec}(E)=0$$
where the kernel of $U_n$ is the solution. Notice that if $n=8\rightarrow \text{dim} U_n=1$. If more than 8 couples are available, then this becomes a linear least squares problem where the solution is the minimum eigenvalue of $U_n^TU_n$.

In general $E$ does not satisfy the last property and has this form:
$$E=UDV^T\qquad D=\begin{bmatrix}
\sigma_1&0&0\\
0&\sigma_2& 0\\
0&0&\sigma_3
\end{bmatrix}\quad  \sigma_1\geq \sigma_2\geq \sigma_3$$
the closest $\hat E$ in frobenious norm is used:
$$\hat E=U\hat DV^T\qquad \hat D=\begin{bmatrix}
\frac{\sigma_1+\sigma_2}2&0&0\\
0&\frac{\sigma_1+\sigma_2}2& 0\\
0&0&0
\end{bmatrix}$$
From this we can get the decomposition $E=SR=\stackvec tR$
where 4 decompositions are possible
$$S=U(\pm S')U^T\qquad R=UR'U^T\text{ or } UR'^TU^T$$
and
$$S'\def\begin{bmatrix}0&-1&0\\1&0&0\\0&0&0\end{bmatrix}\qquad R'\def\begin{bmatrix}0&1&0\\-1&0&0\\0&0&1\end{bmatrix}$$

Now $M_i$ can be estimated with triangulation.

The whole process is:
- Input: two images, intrinsic parameters matrix $K$ and conjugate points $(m'_i,m_i)$
1. Find couples of normalized points $(p'_i,p_i)$: $p=K^{-1}m\quad p'=K^{-1}m'$
2. Compute $E$ with 8 points algorithm
3. Decompose $E$ into $E=SR=\stackvec tR$
4. Compute projection matrix $P[I|0], P'[R|t]$
5. Compute $M_i$ with triangulation

#### Multiple Images
In multiple scale it is important that all estimated $R_i,t_i$ are choerent wrt the same scale factor.
Suppose we have 3 images, their real relation is
$$t_{13}=R_{23}t_{12}+t_{23}$$
but the SLAM takes them wrt to a scale factor
$$\hat t_{13}=\mu_1\hat R_{23}\hat t_{12}+\mu_2\hat t_{23}\qquad \mu_1=\frac{\abs{t_{12}}}{\abs{t_{13}}}\quad \mu_2=\frac{\abs{t_{23}}}{\abs{t_{13}}}$$
and has the solution (only wrt relative scale)
$$\mu_1 = \frac{(\hat{t}_{13} \times \hat{t}_{23})^T (R_{23}\hat{t}_{12} \times \hat{t}_{23})}{\|R_{23}\hat{t}_{12} \times \hat{t}_{23}\|^2}$$
but these points are highly noisy, **Bundle Adjustment** is used, where
- Fix $M_j$ and compute $R_i,t_i$
- Fix $R_i,t_i$ and compute $M_j$
- repeat until threshold is reached

In general the minimization target is
$$\min_{R_i,t_i,M_j}\sum_{i=1}^N\sum_{j=1}^n\abs{m_j^i-K_i[R_it_i]M_j}^2$$

## 6.2) Structure From Motion (SfM)
The aim of SfM is to reconstruct $M^J,P_i$ from a set of conjugate projection points $m_i^j\approx P_iM^j$. The solution is found wrt an arbitrary projection $T_{4\times 4}$. The output is a euclidean reconstruction wrt a similarity (rigid transform + scale change).


C matrix tells how many points in common

## 6.3) Example and Comparisons

Now we will compare Steropsis, mainly (passive) stereo systems, Laser Scanner and LiDAR with Multi View Reconstruction methods

**Which of the following 3d reconstruction methods is the most accurate for the following scene preservation?**


|               | Historic Building                                           | Drone                               | Video Surveillance                        | Robot                                                       | AR Mirror                                 |
| ------------- | ----------------------------------------------------------- | ----------------------------------- | ----------------------------------------- | ----------------------------------------------------------- | ----------------------------------------- |
| Stereo System | Mixed; very high precision, but needs extensive calibration | Good                                | Mixed; Does not work in dark environments | Mixed; Does not work in dark environments, gives real scale | Mixed; needs 2 cameras but otherwise good |
| Laser Scan    | Good; very high precision                                   | Bad; too slow, drone moves too much | Bad; Too slow for moving details          | Good; gives real scale                                      | Good                                      |
| ToF Sensor    | Good                                                        | Good                                | Good; reliable and fast                   | Good; reliable and fast, gives real scale                   | Best choice                               |
| LiDAR         | Mixed bad; captures spherical view                          | Bad; IR from sun changes perception | Good; reliable and fast                   | Good; reliable and fast, gives real scale                   | Good                                      |
| SLAM          | Bad; Not too accurate                                       | Good                                | Bad; Camera is fixed                      | Good                                                        | Bad; Camera is fixed                      |
| SfM           | Bad; Not too accurate                                       | Bad, too slow                       | Bad; Camera is fixed, also too slow       | Bad; too slow, need real time                               | Bad; Camera is fixed, too slow            |

## 6.4) Orientation
Computing a rigid transformation of 3D points starting from a set of correspondences.
- 2D-2D (rgb camera): we know the projection of 3D points on two image planes; compute the transformation between the two reference system
- 3D-3D (depth camera): correspondences between 3D points are available; compute the transformations between the two coordinate systems
- 3D-2D ("calibration"): given the 3D points of the objects and their projections to camera plane, compute the transformation between camera system and object system.