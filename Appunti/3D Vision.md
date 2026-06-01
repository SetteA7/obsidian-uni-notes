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

This model takes a point $M$ and traces a line through $C$. The intersection of that line and $R$ is $m$

This allows to represent all 3D points, besides two:
- point inside focal plane (f)
- point on $C$  (h) (here also no line can be defined)
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

Limit the study to $n=3$

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
$$L_1\times L_2=(2b,-2a,0)\simeq(-b,a,0)$$
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

To write the full camera model we need many steps:
#### Camera Model with Homogeneous Coordinates
Rewrite the projective equations so to use the homogeneous coordinates:
$$\begin{cases} u=-f \frac xz\\ v=-f\frac yz\end{cases}$$

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

We can further generalize $P$ by including:
- pixel size $(k_u=1/p_u,k_v=1/p_v)$
- principal point coordinates $(u_0,v_0)$
- ange of image sensor $\theta$
$$P=\left[
\begin{array}{ccc|c}
 -f k_u & -fk_u\cot\theta & u_0 & 0 \\
  0 & \frac{-fk_v}{\sin\theta} & v_0 & 0 \\
  0 & 0 & 1 & 0
\end{array}
\right]$$
Define the **intrinsic parameter matrix**
$$K=\begin{bmatrix}-fk_u&0&u_0\\0&-fk_u&v_0\\0&0&1\end{bmatrix}$$
then $P=K[I_3|0_3]$.

**$P$ is the projection matrix $\mathbb P^3\rightarrow\mathbb P^2$**
#### Camera Motion
Now suppose the camera coordinates are not aligned with the world coordinates, then the camera coordinates $M_c$ become:
$$M_c=GM=\begin{bmatrix}R&t\\0_{3\times 1}&1\end{bmatrix}M$$
so in general we can do the following:
$$m\approx PM_c=K[I_3|0_3]M_c=K[I_3|0_3]GM$$
and the **general camera matrix is**
$$P_{3\times 4}=K_{3\times3}[R_{3\times3}|t_{3\times1}]$$

the **extrinsic parameters** are therefore $R,t$.

the coordinates can be normalized as $p=K^{-1}m$
in these coordinates the projection matrix is $P[I|0]$
#### Principal Point and Center of Projection
By how we previously defined $P$ it is clear how **the COP is the only point in $\mathbb P^3$ to not be defined in $\mathbb P^2$. In other words, it is the null space of $P$ by definition**

Since every light ray passes through this point, if an object is placed in C there are infinitely many rays passing through it.

From here we can see how the COP is the null space of $P$:
$$PC=0$$
In general the camera matrix has 3 rows, so we can explicit them:
$$P=\begin{bmatrix}p_1^T\\p_2^T\\p_3^T\end{bmatrix}\rightarrow m\simeq PM=\begin{bmatrix}p_1^TM\\p_2^TM\\p_3^TM\end{bmatrix}$$
Now find the null space:
$$\begin{cases}
p_1^TC=0\\
p_2^TC=0\\
p_3^TC=0
\end{cases}\iff PC=0$$
The three rows of the system identify 3 planes:
- $p_3^TC=0$ is the focal plane
- $p_2^TC=0$ is the plane defined by COP and x axis of image plane $u=0$
- $p_1^TC=0$ is the plane defined by COP and y axis of image plane $v=0$

Since the COP is a real point in 3D space but is not defined in the projective plane we need to find it's cartesian coordinates.
First give these notation:
$$P=K[R|t]=[Q_{3\times3}|q]\qquad C=\begin{bmatrix}\tilde C\\1\end{bmatrix}$$
Then we have:
$$PC=0\rightarrow [Q|q]\begin{bmatrix}\tilde C\\1\end{bmatrix}=0\rightarrow Q\tilde C+q=0\rightarrow \boxed{\tilde C=-Q^{-1}q}$$
Try to understand what $Q$ and $q$ are:
- $Q$ contains information on both rotation and intrinsic parameters of the camera
- $q$ is related to translation of camera, but it is not the position
- $-Q\tilde C$ is the position of the camera
- $p_3$ is the optical axis

The principal point can also be easily found:
Recall that $m_0=K[0,0,1]^T$. Let $P=[Q|q]$, then
$$QQ^T=(KR)(KR)^T=KRR^TK^T=KK^T\rightarrow m_0=K\par{K^T\begin{bmatrix}0\\0\\1\end{bmatrix}}=K\begin{bmatrix}0\\0\\1\end{bmatrix}$$


#### Optical Ray
Given a point $m$ in the imaging plane, a **ray** is the line that contains COP $C$ and $m$, that is, the set of points M such that:
$$\curly{M:m\simeq PM}$$
Recall that a line is defined by a point and a direction, in the projective plane the line $M$ is defined by these two points:
- COP: point $C$
- Direction vector: Ideal Point $[Q^{-1}m, 0]^T$
Now find $PM$ with the ideal point:
$$PM\rightarrow [Q|q]\begin{bmatrix}Q^{-1}m\\0\end{bmatrix}=QQ^{-1}m+q\cdot 0=m$$
recall that $Q$ is non singular and invertible, then $QQ^{-1}=I$
So the ray is obtained as
$$M(\lambda)=C+\lambda\begin{bmatrix}Q^{-1}m\\0\end{bmatrix},\ \lambda \in \mathbb R\cup \curly\infty$$
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


# 2) Computer Graphics

The standard image pipeline in computer graphics is:
![[Pasted image 20260415153648.png|Pipeline|350]]
## 2.1) Modeling
The modeling of a 3D scene consists in modeling and placing the objects, while also illuminating the scene and selecting the viewpoints

3 types of modeling exist:
- **Manual**: use software to model by hand (Blender)
- **Automatic**: obtain model from real 3D objects (SfM)
- **Procedural**: use a function to generate a model (fur, grass, water, etc)

Objects are **finite, closed and continuous** and can be represented as a volume or by contours.

The classic polygon representation is the contour representation (boundary-rep) that uses a set of convex polygons to approximate a surface.

Two main approaches exist:
- **Triangular mesh**: dense, no redundancy, high quality
- **Point Cloud**: sparse, redundant, low complexity

How are meshes represented?
- **Simple representation**: define all faces as a list of triplets: simple but with much repetition
$$T_1\curly{\par{a_1,a_2,a_3},\par{b_1,b_2,b_3},\par{c_1,c_2,c_3}}\qquad T_2\curly{\par{b_1,b_2,b_3},\par{d_1,d_2,d_3},\par{c_1,c_2,c_3}}$$
![[Pasted image 20260415154945.png|Example|250]]
- **List of vertices**: every face defined by list of vertices, edge repetition but no vertices, difficult to find adjacent faces
$$\begin{gather}v_a=(a_1,a_2,a_3)\quad v_b=(b_1,b_2,b_3)\quad v_c=(c_1,c_2,c_3)\\
T_1=\curly{v_a,v_b,v_c}\qquad T_2=(v_b,v_c,v_d)
\end{gather}$$
- **List of edges**: face defined by list of edges, no repetition, simpler adjacent search
$$\begin{gather}l_1=(v_a,v_b)\quad l_2=(v_b,v_c)\quad l_3=v_c,v_a\quad l_4=(v_b,v_d)\quad l_5=(v_d,v_c)\\
T_1=\curly{l_1,l_2,l_3}\qquad T_2=\curly{l_2,l_4,l_5}
\end{gather}$$
##### PLY Format
![[Pasted image 20260504113744.png|Example|250]]
Consider the following PLY file. The header:
- Defines 8 vertices with $(x,y,z)$ and (r,g,b) components
- Defines 7 faces as a its of vertices index
- Defines 5 edges as 2 vertices and (r,g,b)
After the header these elements are defined one by one

#### Other Formats
It is also possible to define surfaces with a **bezier curve** and a set of control points
$$P(u,v)=\sum_i\sum_jX_{n,i}(u)X_{m,j}P_{ij}$$
where $P_{ij}$ are the control points and $X$ the control function

also using **Constructive Solid Geometry (CSG)** which builds models starting from some primitives and then boolean operations. This is used for CAD modeling.

Spatial partitioning (voxels) are also used, these discretize the space in tiny cells that can be either empty or occupied.

##### Recap
Models are: **finite, closed and continuous**
Defined via: **contours or volumes**
Types of modeling strategies: **manual, automatic, procedural**

**Polygon Meshes:** vertices, edges faces. Collection of flat polygons.
**Point Clouds:** sparse collection of 3d points. Highly redundant.
**Parametric Surfaces:** Bezier curves
**Spatial Partitioning/Voxels:** quadtrees or marching cubes.
**Constructive Solid Geometry:** boolean operation on elementary shapes
## 2.2) Rendering and Illumination
Now we move forward to the graphical pipeline and rendering part:

Rendering is the set of algorithms used to generate the image of the scene.
There are two main approaches to rendering: process objects one by one and update pixels accordingly or process each pixel separately.

### 2.2.1) Rendering Techniques
#### Z-Buffer
Every pixel is extended with a depth value $(r,g,b)\rightarrow(r,g,b,d)$ this is the distance of the projected point to the camera. 
![[Pasted image 20260416113234.png|Algorithm|450]]
This is applied to objects in the view frustum.
![[Pasted image 20260416113332.png|View Frustum|250]]
#### Ray Casting
Ray casting consists in fixing the COP and the image plane. An optic ray is drawn from COP ($\tilde Q$) to each pixel ($\tilde P$). The color of the pixel is computed along the ray.

First the versor of the ray is computed and it is used to find the ray:
$$V=\frac{\tilde P-\tilde Q}{\abs{\tilde P-\tilde Q}}\ \longrightarrow\ \tilde M(t)=\tilde Q+Vt$$
Define a plane by a point $S$ and a normal vector $n$. The ray intersects the plane at
$$\text{Surface: } t_0=\frac{(S-Q)\cdot n}{n\cdot V}\qquad \text{Sphere: }t_0=(S-Q)V$$
A plane is very useful, as it can be used for many forms:
- **Disk** with radius $r$ and center $S$: find distance between center and intersection of ray point $d=\abs{M(t_0)-S}^2$ if it is smaller than $r$ then the ray intersects the disk. ad distance $t_0$ at point $M(t_0)$
$$d=\abs{M(t_0)-S}^2\rightarrow \begin{cases}\text{Intersection at } M(t_0)&\text{ if }d\leq r\\\text{No intersection}&\text{ if } d>r\end{cases}$$
- **Sphere** with radius $r$ and center $S$: find distance between center and intersection of ray point $d=\abs{M(t_0)-S}^2$. Then find $a=\sqrt{r^2-b^2}$ and the two intersections are at distance $t_{1,2}=t_0\pm a$ and correspond to points $M(t_1),M(t_2)$. (Moreover in the sphere we set $n=V$)
$$\begin{gather}
d=\abs{M(t_0)-S}^2\rightarrow a=\sqrt{r^2-d^2}\\
\downarrow\\
\begin{cases}
\text{Intersection at } M(t_1),M(t_2), \ t_{1,2}=t_o\pm a&\text{ if }a\in\R \\
\text{No intersection}&\text{ otherwise }
\end{cases}
\end{gather}$$

![[Pasted image 20260416115908.png|Visualization|300]]

#### Rasterization
Instead of tracing a ray through every pixel, each polygon traces a ray to the camera. The intersected pixels are used as a base to reconstruct the object.
![[Pasted image 20260416170704.png|Example|350]]
This is **more performant than ray casting**, more problems have to be accounted for.

**Geometric Processing Step:**
1. **Standard Coordinates:** scene and objects
2. **Camera Coordinates:** via a **modelview matrix** transform space with camera as origin
3. **Clip Coordinates:** a **projection matrix** defines the view frustum and clips all geometry outside of this view.
4. **Normalized Device Coordinates:** The view frustum is first **transformed using a projective transformation** into a canonical unit cube
5. **Window Coordinates:** with a **viewport matrix** the image is projected onto a 2D screen.

However lighting and clipping are notoriously hard to solve:
- For clipping a z-buffer is usually used in combination with HSR.
- For shading a mix between compute shaders and some shading algorithm is used:
	- **Flat shading:** normal is computed for one polygon and it is shaded the same on the entire surface
	- **Gourad shading:** shade is computed for each vertex and interpolated for the surface pixels
	- **Phong shading:** shade is computed pixel by pixel.
#### Hidden Surface Removal (HSR)
This applies multiple techniques:
- **Back Face Culling:** remove faces that are hidden wrt viewpoint
- **List-priority:** order objects to render in sequence
- **Painter/depth sort:** polygons ordered based on depth

#### Scan Conversion
Recall that in rasterization, each vertex of a polygon is mapped to a pixel, then **Bresenham algorithm** approximates what pixels to fill based on 2 connected verteces. 
![[Pasted image 20260504123840.png|Bresenham|100]]

**Scan line algorithm** is used to fill the pixels of the faces. Essentially it fills the pixels if the pixel is after a odd number of lines. The color is found by interpolation.
![[Pasted image 20260504123822.png|Scan Line example|100]]


### 2.2.2) Lighting Models (Shading)
A good lighting model should be able to encapsulate most physical light phenomena both from a material perspective and light perspective:
- **Radiometry**: study of light propagates and is emitted
- **Diffusion:** material property on how light is absorbed and reflected

##### Phong Model
A good model for the light is the **phong model:**
$$\begin{align}
I_{\text{out}}&=I_{\text{out, ambient}}+I_{\text{out, diff}}+I_{\text{out, refl}}+I_{\text{out,emit}}\\
&=I_ak_a+Ik_d(\vec n\cdot L)+Ik_s(\vec n\cdot h)^n
\end{align}$$

- **Ambient Light:** minimum light present on all objects, even unlit ones $I^{out}_a=I_ak_a$ since model doesn't take into account multiple bounces
- **Diffused Light:** depends on surface normal (not viewing angle) $I_d^{out}=Ik_d\cos\theta$
- **Specular Light:** this is how much glossy or rough the surface looks. This is calculated via the half way vector. 

Let $S$ be the point on the surface and $R$ the (point) light source. All vectors must be exiting, then we can define them as:
$$v=-\frac{P-Q}{\abs{P-Q}}\quad L=\frac{R-S}{\abs{R-S}}\quad h=\frac{L+v}{\abs{L+v}}$$

The biggest missing part is:
 - attenuation (intensity decreases with distance)
 - reflection, refraction
 - light source characterization, no light emitters

![[Pasted image 20260416164425.png|Example of light|150]]

##### Ray Tracing
This enhances ray-casting and phong by taking into account the reflections ($k_sI_r$) and refraction ($k_tI_t$) of light. Moreover the reflection generates a new ray in the reflected direction. The pixel will have a weighted sum of the surface and reflected ray contributions.

Therefore it becomes:
$$I_{out}=\underbracket{I_ak_a+Ik_d(\vec n\cdot L)+Ik_s(\vec n\cdot h)^n}_{\text{Phong}}+k_sI_r+k_tI_t$$

#### Shaders
Small script that runs on gpu that modifies the pixel value of an entire object based on the light input and material.

### 2.2.3) Other Techniques
#### Anti Aliasing
Average the shading in order to hide discrete nature of images
![[Pasted image 20260504124025.png|Example|450]]
#### Textures
To simplify models, it is possible to use textures (instead of one face per texture pixel). These are images that get overlayed on a model.

The unit pixel of a texture is called a **texel**. To project it onto a surface (color mapping) the surface needs to be parameterized or mapped to vertices via a lookup table

How are they mapped?
- **Color Mapping:** Overlay image onto a 3d surface
- **2-Step Mapping:** Map og texture to intermediate surface $S$ so that the map from $S$ to $O$ is simpler. O-Mapping can be done via intersection of normals (of the $S$ or $O$ surface) or via interm lines from centroids
![[Pasted image 20260504124655.png|Example|250]]
All these are done in one of two ways:
- **Forward mapping:** maps texels $\rightarrow$ pixels. More computationally expensive, can result in missing textures and artifacts that require heavy filters.
- **Inverse mapping:** most used as you only draw what is seen: Map vertex into pixel , find intersection between rays and tris, compute coordinate on texture, get pixel value. Map pixels $\rightarrow$ texels

#### Bump Mapping
Type of texture that defines normals as a texture without having them geometrically modeled on the surface. 

#### Level of Detail (LOD)
Design models with different amount of verteces and change them based on distance from camera

#### Sprites
Place 3d images in 3d world to create the illusion of 3d.

## 2.3) Animation
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

# 3) Homography & Epipolar Geometry
## 3.1) Homography
$$ $$
>[!def] Homography
>Homography is the function that maps points of plane $\Pi$ on the image plane
>$$\Pi:Z=0$$
>that is, it maps a plane into another plane.
>The homography matrix $H_\Pi$ is a $3\times3$ non singular matrix with 8 d.o.f. 

$$\begin{bmatrix}u\\v\\1\end{bmatrix}\simeq\begin{bmatrix}p_{11}&p_{12}&p_{13}&p_{14}\\p_{21}&p_{22}&p_{23}&p_{24}\\p_{31}&p_{32}&p_{33}&p_{34}\end{bmatrix}\begin{bmatrix}x\\y\\0\\1\end{bmatrix}\simeq\underbrace{\begin{bmatrix}p_{11}&p_{12}&p_{14}\\p_{21}&p_{22}&p_{24}\\p_{31}&p_{32}&p_{34}\end{bmatrix}}_{H_\Pi}\begin{bmatrix}x\\y\\1\end{bmatrix}$$
that is:
$$m'\simeq H_\Pi m\quad m\in \Pi$$
Homography can also be composed:
![[Pasted image 20260309154735.png|Composition|350]]
#### Homography Estimation
##### Noise Free
Let there be a set of coupled points between two images $m_i,m'_i=Hm_i$. To compute the homography $H$ between the two images, a set of at least $n=4$ matching points are needed with noise free matches.
The solution is found by finding  $ker(A)$ of this system:
$$\begin{bmatrix}
m_1^T\otimes\stackvec{m_1'}\\
m_2^T\otimes\stackvec{m_2'}\\
\vdots\\
m_n^T\otimes\stackvec{m_n'}\\
\end{bmatrix}vec(H)=Avec (H)=0_{2n\times 1}$$

##### Noisy: RANdom SAmple Consensus (RANSAC)
If matches are noisy, RANSAC is used. This is an iterative method to compute homographies by finding a subset of inliers. 

An inlier for a homography $H$ is a couple of matching points that satisfy
$$\abs{m_i'-Hm_i}\leq \epsilon$$
Let the set of couples be $\mathcal M=\curly{m_i,m_i'}$ with cardinality $N$. At each iteration 

Now RANSAC is applied to the N matches in set $\mathcal M=\curly{m_i,m_i'}$.
1. Select $N_0<N$ couples from $\mathcal M$ and create subset $\mathcal M_0$.
2. Compute the estimated matrix $H_0$ on $\mathcal M_0$ (via minimum distance)
3. Compute the number of inliers $N_{in}$
4. if $N_{in}>T$ or max iterations stop, otherwise restart from 1. Always keep best $H_0,\mathcal M_0$ 

5. Before concluding, recalculate inliers on all $\mathcal M$ (not just $\mathcal M_0$) an recompute $H_0$ on all inliers.

--- 
Proof of noise free homography:
Let there be a set of coupled points between two images $m_i,m'_i\simeq Hm_i$. 
Notice that 
$$m_i'\times Hm_i=0\rightarrow \stackvec{m_i'}H m_i=0_{2\times 1}$$
Apply the vec operator:
$$vec\par{\stackvec{m_i'}Hm_i}=vec (0)=0$$
Now expand: ^77c63e
$$
vec\par{\stackvec{m_i'}Hm_i}=(m_i^T\otimes\stackvec{m_i'})vec(H)=0 
$$
Notice that $m_i^T\otimes\stackvec{m_i'}$ is a $3\times9$ matrix and has rank 2, therefore the system is underdetermined with 2 equations in 8 unknowns. By adding some matching points couple we can solve the system.

$$
\begin{bmatrix}
m_1^T\otimes\stackvec{m_1'}\\
m_2^T\otimes\stackvec{m_2'}\\
\vdots\\
m_n^T\otimes\stackvec{m_n'}\\
\end{bmatrix}vec(H)=Avec (H)=0_{2n\times 1}$$
The $A$ matrix is a $2n\times9$ matrix with rank 8. With $n=4$ there is one solution, while with $n>4$ the system is overdetermined. 

The solution is to find $ker(A)$. 
Since $dim(ker(A))=1$ the solution can be found by applying SVD decomposition on $A$ and taking the last row of $V^T$.
$\endproof$

##### Basic Linear Algebra Recap
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
$$[a]_\times=\begin{bmatrix}0& -a_3& a_2\\a_3 & 0 & -a_1\\-a_2 & a_1& 0\end{bmatrix}\rightarrow [a]_\times b=a\times b$$
moreover:
$$\det(a\times b\times c)=a^T(b\times c)=(a\times b^T)c$$
then also:
$$[A^{-1}u]_\times=A^T[u]_\times A$$
**Norm of a matrix:**
- Frobenius: $\|A\|=\sqrt{\sum_{i,j} a_{i,j}^2}$
- Euclidean: $\|A\|=\frac{\|Au\|}{\|u\|}$ with $\forall u: \|u\|\leq1$

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
There are 3 main geometric structures in the epipolar geometry:
- **Epipolar Plane $\mathscr E$:** plane containing $m,m',M$ or $m, C, C'$ (defined by intersection between $Mm,Mm'$)
- **Epipolar Line:** intersection between epipolar plane and image plane (lines $em, e'm'$)
- **Epipoles $e$:** projection of COP into other cameras image plane. ($\boxed{e=PC', e'=P'C}$)

![[Pasted image 20260418113353.png|Example|250]]
For noise-free matching point estimation we know that $m_i$ has matching point $m_i'$ on the epipolar line, no other part of image can contain it. This is shown in the lounget higgins equation.

We can define the **fundamental matrix** which contains all the information about the epipolar geometry.
$$F=\stackvec{e'}Q'Q^{-1}$$

A fundamental equation is the **Longuet Higgins Equation:**
$$m'^T\stackvec{e'}Q'Q^{-1}m=m'^TFm=0$$
this equation is a bilinear relation between $m,m'$ with $P=[Q|q],\ P'=[Q'|q']$. This allows to find if $m,m'$ are on the same epipolar line without knowing the depth of $M$.

Louget higgins has also some other forms which are mainly used in proofs:
$$m'\simeq e'+\lambda Q'Q^{-1}m\qquad \lambda'm'= e'+\lambda Q'Q^{-1}m$$

By aligning the world coordinates to the first camera we can write the funamental matrix using the camera parameters and roto-translation:
$$P=K[I|0]\quad P'=K'[R|t]\longrightarrow F=\stackvec{Kt}K'RK^{-1}$$
Now louget higgins becomes:
$$m'\simeq K'RK^{-1}m+K't$$

If the coordinates are also normalized:
$$p=K^{-1}m\qquad p'=K'^{-1}m'$$
The camera matrices become:
$$P_0=K^{-1}P=[I|0]\qquad P_0'=[R|t]$$
Recall that with normalized coordinates a point becomes:
$$p=P_0M$$


And we find a specific instance (world aligned+normalized) of the fundamental matrix called **Essential Matrix**:
$$E=\stackvec tR$$

---
Proof of Longuet-Higgins Equation
Longuet-Higgins equation relates matching points only by an epipolar line and the camera matrices.
Let two generic camera matrices be:
$$P\simeq [Q|q],\qquad P'\simeq [Q'|q']$$
Since point $M$ is the same for both cameras, find the optical ray of the first camera and project it on the second camera in order to relate m and m' wrt scale:
$$M=C+\lambda \begin{bmatrix}Q^{-1}m\\ 0\end{bmatrix}\rightarrow P'M=P'C+\lambda P'\begin{bmatrix}Q^{-1}m\\ 0\end{bmatrix}$$
Notice that $P'C$ is the epipole on $P'$ by definition and therefore
$$m'\simeq e'+\lambda Q'Q^{-1}m$$

From here only a series of algebraic steps are needed:
Vector multiply by $e'$:
$$e'\times m'\simeq e'\times(e'\lambda Q'Q^{-1}m)=\lambda e'\times Q'Q^{-1}m$$
and finally a scalar multiplication with $m'^T$:

$$m'^T\cdot (e'\times m)=0=m'^T\cdot [e']_\times Q'Q^{-1}m$$
By noticing that since by definition $e'\times m'\perp m'$ and therefore the LHS is 0 and by calling $[e']_\times Q'Q^{-1}=F$ we end up with the equation:
$$m'^TFm=0$$

$\endproof$

---
Fundamental Matrix in the world coordinates system
Center the world coordinates on $P$ and then $P'$ is a roto translation:
$$P=K[I|0]=[K|0]\qquad P'=K'[R|t]$$
The optical center becomes:
$$C=\begin{bmatrix}-Q^{-1}q\\1\end{bmatrix}=\begin{bmatrix}-K^{-1}q\\1\end{bmatrix}=\begin{bmatrix}0_{1\times 3}\\1\end{bmatrix}$$
And the epipole is easily found by definition:
$$e'=P'C=K'[R|t]\begin{bmatrix}\vec 0\\1\end{bmatrix}=K't$$
By plugging this into the fundamental matrix we have:
$$F=\stackvec{K't}K'RK^{-1}$$

---
Derive $E$ from LH
Let
$$P=K[I|0]\qquad P'=K[R|t]$$
So $Q=KI,Q'=KR$
Now recall LH:
$$m'^T\stackvec{e'}Q'Q^{-1}m'=0$$
The epipole in this case becomes:
$$e'=P'C=K[R|t]\begin{bmatrix}0_{3\times1}\\1\end{bmatrix}=Kt$$
Now recall that:
$$\stackvec{Mv}=\det(M)M^{-T}\stackvec v M^{-1}\simeq M^{-T}\stackvec v M^{-1}$$
therefore
$$[Kt]_\times\simeq K^{-T}[t]_\times K^{-1}$$
therefore the fundamental matrix becomes:
$$[Kt]_\times RK^{-1}=K^{-T}[t]_\times K^{-1}KRK^{-1}=K^{-T}[t]_\times RK^{-1}$$
Now normalize the coordinates:
$$p=K^{-1}m\qquad p'=K^{-1}m'$$
by substituting into LH:
$$m'^T\stackvec{e'}Q'Q^{-1}m'=p'^TK^TK^{-T}\stackvec t RK^{-1}Kp=p'^T\stackvec tRp=0$$
Where $E=\stackvec t R$.

## 3.3) Homography Motion Estimation
With epipolar geometry and homography we can estimate motion. First we need to find the homographies for the two types of motion (rotational and planar). Then the motion of the camera can be studied by also setting $K=K'$

#### Rotational Motion
In this case $t=0$. It turns out that 
$$\frac{\lambda'}{\lambda}m'=K'RK^{-1}m=H_\infty m$$
and the homography doesn't depend on the 3d structure of the points.

---
Proof:
Let
$$P=K[I|0]=[K|0]\qquad P'=K'[R|0]$$
Plugging these into Lounguet Higgins we get:
$$m'\simeq K't+\lambda K'RK^{-1}m$$
adjust $m'$ scale to get a strict equality:
$$\lambda'm'=K't+\lambda K'RK^{-1}m$$
By defining $H_\infty=K'RK^{-1}$ we get that:
$$\frac{\lambda'}{\lambda}m'=H_\infty m$$
$\endproof$

#### Planar Scene
In this case the homography is more evident: All $M$ points lie on plane $\Pi$, therefore they must satisfy the following (projective space - euclidean space):
$$d^TM=0\qquad n^T\tilde M=d$$
where $N$ is the normal vector to the surface
and therefore 
$$\frac{\lambda'}{\lambda}m'=\par{H_\infty+\frac{K'tn^TK^{-1}}d}m=H_\Pi m\stackrel{d\rightarrow\infty}\longrightarrow H_\infty m$$
In fact in panoramic images, far away objects can be stitched together as if the motion were purely rotational based on their high distance from the camera.

---
Proof:
In this case the homography is more evident: All $M$ points lie on plane $\Pi$, therefore they must satisfy the following in euclidean space:
$$n^T\tilde M=d$$
Notice that for the first camera $\tilde M$ can be written as:
$$\lambda m=PM=[K|0]\begin{bmatrix}\tilde M\\1\end{bmatrix}=K\tilde M$$
and therefore:
$$d=n^T\lambda K^{-1}m\rightarrow 1=\frac{n^T\lambda K^{-1}m}d$$
Now the lounget higgins equation becomes:
$$\frac{\lambda'}\lambda m'=K'RK^{-1}m+\frac1\lambda K't\cdot \frac{n^T\lambda K^{-1}m}d=H_\infty m+\frac{K'tn^TK^{-1}}dm$$

#### Camera Motion Estimation


# 4) Stereo Systems
Stereo system uses two views of the same scene to estimate depth. This is done via the **disparity** between points in a scene.

This chapter will follow this structure:
- Understand the basic case (simple triangulation)
- Understand the general case and how this tells us that conjugate points are on the same epipolar line
- Rectify the images so that the generic case becomes the simple triangulation case
- Given $m$ find the matching point $m'$ 

## 4.1) Passive Stereo Systems
#### Simple Triangulation
Let two cameras be parallel and aligned (image plane corresponds), then by knowing:
- $b$ distance between cameras. If unknown the distance is a scaling factor
- $f$ focal distance
- $(u-u')$ disparity between two points

![[Pasted image 20260428104129.png|Study Case|300]]

The distance z is computed by
$$z=\frac{bf}{u-u'}$$
_(if $b$ is not known the measure differs by a scale factor)_

In this case the camera matrices are
$$P=K[I|0]\qquad P'=K[I|(-b,0,0)^T]$$
The estimation error is:
$$\frac{\partial z}{\partial\Delta u}=-\frac{bf}{\Delta u^2}\rightarrow \abs{\partial z}=\frac{bf}{\Delta u^2}\partial \Delta\stackrel{\Delta u=\frac{bf}{z}}\longrightarrow \abs{\partial z}=\frac{z^2}{bf}\partial\Delta$$

---
To prepare for the next section, compute the fundamental matrix in this case:
Notice that:
$$P=K[I|0]=[K|0]\qquad P'=K[I|t]=[K|Kt]$$
So it is clear that 
$$Q'Q^{-1}=KK^{-1}=I$$
Then the epipole must be found:
$$e'=P'C=[K|Kt]\begin{bmatrix}0\\0\\0\\1\end{bmatrix}=Kt$$
By expanding both $K$ and $t$ we have:
$$e'=Kt=\begin{bmatrix}-fk_u&0&u_0\\0&-fk_u&v_0\\0&0&1\end{bmatrix}\begin{bmatrix}
-b\\0\\0
\end{bmatrix}=\begin{bmatrix}
-bfk_u\\0\\0
\end{bmatrix}$$
Which in product form becomes:
$$F\simeq \stackvec{e'}=bfk_u\begin{bmatrix}0&0&0\\0&0&1\\0&-1&0\end{bmatrix}$$
this is the fundamental matrix.
Alternatively we can use the world coordinates form:
$$F=\stackvec{Kt}KRK^{-1}=\begin{bmatrix}
-bfk_u\\0\\0
\end{bmatrix}\times KIK^{-1}=\begin{bmatrix}0&0&0\\0&0&1\\0&-1&0\end{bmatrix}I=\begin{bmatrix}0&0&0\\0&0&1\\0&-1&0\end{bmatrix}$$

#### General Case
**Suppose we know $m$ but not $m'$, it is possible to find $m'$ via the epipolar line.** 
This is because the ray of camera $C$ to point $M$ is seen by camera $C'$ as a line (epipolar line).

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
With a SVD decomposition of A ($A=U\Sigma V^T$) and by taking the last eigenvector (last vector of $V$) we get the solution. This can be generalized to $N$ cameras via the **linear eigen method** that returns $2N$ equations from $N$ cameras.

Since in real case scenarios due to noise the points don't lie on the epipolar line but slightly diverge, then SVD finds the algebraic minimum, to minimize the geometric cost we can use (find $M$ that minimizes)
$$\epsilon(M)=\abs{\begin{bmatrix}u\\v\end{bmatrix}-\begin{bmatrix}\frac{p_1^TM}{p_3^TM}\\\frac{p_2^TM}{p_3^TM}\end{bmatrix}}^2+
\abs{\begin{bmatrix}u'\\v'\end{bmatrix}-\begin{bmatrix}\frac{p_1'^TM}{p_3'^TM}\\\frac{p_2'^TM}{p_3'^TM}\end{bmatrix}}^2\rightarrow M=\arg\min_M\epsilon(M)$$
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
- **Epipolar Geometry:** the correspondence is only on the epipolar line
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
Compute $\mathcal L_1$ norm in a small window
$$SSD(u,v,d)=\sum_{k,l}(I_1(u+k,v+l)-I_2(u+k+d,v+l))^2\quad k\in[-n,n]\  l\in[-m,m]$$
and minimize it
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
And the block is found by concatenating ($S$ is the block) (p is center pixel)
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


## 4.2) Active Stereo Systems
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
where wrt the reference system of the projector we have
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
z_cp_c-z_cRp_c=t\rightarrow
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

This is a very fast approach, that can be extended to an entire image (matricial ToF), highly accurate with robustness to noise ad deformations and might also be very low power.

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

Two detection methods exists:
- **Energy detection (incoherent):** measure amplitude change ($\propto1/z^2$) used for:
- **Optical heterodyne (coherent):** phase and amplitude variation, this is more precise uses less power but requires more complex electronics. this is used for

Many scan technologies exist:
- Incoherent:
	- MEMs (Microelectromechanical systems): mirrors who tilt angles, requires multiple mirros and is suscettibel to shock and vibrations
	- Flash LiDAR: focal plane of photodetectors captures back scattered light, requires high power but is not sensitive to vibrations
	- Optical Phased Array (OPA): optical phase modulator controls speed of light passing through lense
- coherent: 
	- Frequency-modulated continuous wave (FMCW)

It can either use a pulse model, with micropulses (burst of impulses) at low or high energy, or lasers

The waveform of the laser is modified by the objects, this can be used to infer the type of the object

The final PC is saved as a .las file.


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

##### Essential Matrix
First we introduce the **Essential Matrix**
$$E\def[t]_\times R$$
which in the Lounget-Higgins equation is the relation between the two normalized points (one point is on the epipolar line of the other)
$$p'^TEp=0$$
The essential matrix has these **properties**:
- $\text{rank}(E)=2$ since $\det(\stackvec t)=0$
- Scale factor change does not affect $E$
- 3 rotation d.o.f, 2 translation d.o.f.
- since points are in front of camera, the third coordinate must be positive
- With SVD decomposition the 3 singular values are $\begin{cases}\sigma_1=\sigma_2\not=0\\\sigma_3=0\end{cases}$

>[!thm] Decomposing Essential Matrix
>A $3\times3$ essential matrix can be decomposed into the product of a non null antisymmetric matrix $S$ and a rotation $R$ iff $E$ has two equal singular values and the third equal to zero $\begin{cases}\sigma_1=\sigma_2\not=0\\\sigma_3=0\end{cases}$:
>$$E=SR\iff \begin{cases}\sigma_1=\sigma_2\not=0\\\sigma_3=0\end{cases}$$
>Proof:
>Proof of $\implies$:
>Since $E=\stackvec tR=SR$ then $S=\stackvec t$ with $\abs t=1$ (no loss of generality since E is defined wrt scale factor)
>Define a rotation $U$ as to have $Ut=[0,0,1]^T\def a\rightarrow t=U^Ta$ and therefore
>$$S=\stackvec t=\stackvec{U^Ta}=(U^T)^{-T}\stackvec a(U^T)^{-1}=U^{-1}\stackvec a U^{-T}=U^T\stackvec aU$$
>since $U$ is a rotation $U^T=U^{-1}$ and also $U=U^{-T}$
>The singular values can be found by SVD decomposition $E=U\Sigma V^T$. By computing $EE^T=U(\Sigma\Sigma^T)U^T$ and noticing that $\Sigma$ is diagonal, then the diagonal of $\Sigma$ has the squared singular values of $E$:
>Now the singular values are found as:
>$$EE^T=SRR^TS^T=SS^T=U^T\stackvec a UU^T\stackvec a^TU=U^T\begin{bmatrix}1&0&0\\0&1&0\\0&0&0\end{bmatrix}U$$
>since $\stackvec a=\begin{bmatrix}0&-1&0\\1&0&0\\0&0&0\end{bmatrix}$
>Proof of $\impliedby$
>By SVD we have $E=UDV^T$ with $D=\begin{bmatrix}1&0&0\\0&1&0\\0&0&0\end{bmatrix}$.
>It is possible to write $D$ as a product of two matrices $S'=\begin{bmatrix}0&-1&0\\1&0&0\\0&0&0\end{bmatrix},R'=\begin{bmatrix}0&1&0\\-1&0&0\\0&0&1\end{bmatrix}$ . 
>Then notice the following:
>$$E=UDV^T=US'R'V^T=US'\cdot (U^TU)\cdot R'V^T=(US'U^T)(UR'V^T)=SR$$
> S is antisymmetric ($A^T=-A$) since:
> - Notice that $S'^T=-S$
> - $S^T=(US'U^T)^T=US'^TU^T=-US'U^T=-S$
> And it is non null ($S\not=0$) since $US'U^T=0\rightarrow U^TUS'U^TU=U^T0U=0\rightarrow S'=0$ which is not true
>
>R is a rotation matrix ($RR^T=I$) since
>- Notice $R'R'^T=I$
>- $RR^T = UR' (V^T V) (R')^T U^T = UR' (I) (R')^T U^T = U (R' (R')^T) U^T=UU^T=I$
> Where 4 possible choices can be made with $\pm S, \pm R$ 

^ecaece

The following property was used in the proof:
$$\stackvec{A^{-1}u}=A^T\stackvec u A\iff \det A=1$$

##### 8 points Algorithm
However, since $R,t$ are not known a priori the $E$ matrix needs to be estimated. 

Let the first image have $P=K[I|0]$ and the second have $P'=K[R|t]$.  The conjugate points $(m'_i,m_i)$ can be normalized $(p=K^{-1}m, p'=K^{-1}m')$ which must satisfy the equation
$$p_i'^TEp_i=0$$
which can be decomposed into (same as [homography estimation](#^77c63e))
$$(p_i^T\otimes p_i'^T)\text{vec}(E)=0
\rightarrow 
\underbrace{\begin{bmatrix}
p_1^T\otimes p_1'^T\\
\vdots\\
p_n^T\otimes p_n'^T
\end{bmatrix}}_{U_n}
\text{vec}(E)=0$$
where:
- if $n=8\rightarrow \text{dim} U_n=1$ the kernel of $U_n$ is the solution. 
- If more than 8 couples are available, then this becomes a linear least squares problem where the solution is the minimum eigenvalue of $U_n^TU_n$.

$E$ depends on 5 dof values and the polynomial bounds of [[#^ecaece]]

In general $E$ does not satisfy the theorem and has this form:
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

---
Proof Essential Matrix:
Let the normalized coordinates be:
$$p=K^{-1}m\qquad p'=K^{-1}m'$$
Then by supposing that the first camera is centered on the origin and the second camera is just a rototranslation we have in normalized coordinates:
$$P=[I|0]\qquad P'=[R|t]$$
Lounget Higgins now becomes:
$$p'^T\stackvec tRp=p'^TEp=0$$
Where $E=\stackvec tR$ is the essential matrix.

---
Derive $E$ from LH
Let
$$P=K[I|0]\qquad P'=K[R|t]$$
So $Q=KI,Q'=KR$
Now recall LH:
$$m'^T\stackvec{e'}Q'Q^{-1}m'=0$$
The epipole in this case becomes:
$$e'=P'C=K[R|t]\begin{bmatrix}0_{3\times1}\\1\end{bmatrix}=Kt$$
Now recall that:
$$\stackvec{Mv}=\det(M)M^{-T}\stackvec v M^{-1}\simeq M^{-T}\stackvec v M^{-1}$$
therefore
$$[Kt]_\times\simeq K^{-T}[t]_\times K^{-1}$$
therefore the fundamental matrix becomes:
$$[Kt]_\times RK^{-1}=K^{-T}[t]_\times K^{-1}KRK^{-1}=K^{-T}[t]_\times RK^{-1}$$
Now normalize the coordinates:
$$p=K^{-1}m\qquad p'=K^{-1}m'$$
by substituting into LH:
$$m'^T\stackvec{e'}Q'Q^{-1}m'=p'^TK^TK^{-T}\stackvec t RK^{-1}Kp=p'^T\stackvec tRp=0$$
Where $E=\stackvec t R$.
#### Multiple Images
In multiple scale it is important that all estimated $R_i,t_i$ are coherent wrt the same scale factor.
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
SfM is an uncalibrated reconstruction starting from a set of pictures. These pictures don't need the cameras to be calibrated (since $R,t$ will be estimated), however $K$ needs to be known. Moreover the images must not be a pure rotation, as otherwise triangulation won't work

Suppose that we have a set of conjugate points $m_i^j$, that is point $M^j$ projected into camera $P_i$, then the aim is to reconstruct $M^j$ and $P_i$ such that $m_i^j\simeq P_iM^j$.

The solution is found wrt an arbitrary projection $T_{4\times 4}$. The output is a **euclidean reconstruction** wrt a similarity (rigid transform + scale change), that is:
$$\text{if } P_i,M^j\text{ is a slution, then } P_iT, T^{-1}M^j\text{ is a solution as well}$$

![[Pasted image 20260512121515.png|Example|250]]

#### Projective Reconstruction
Given $i=1,...,h$ cameras and $j=1,...,n$ points we can write this  system:

$$\zeta_i^jm_i^j=P_iM^j\rightarrow \begin{bmatrix}
\zeta_1^1m_1^1& \zeta_1^2m_1^2&...&\zeta_1^nm_1^n\\
&\vdots\\
\zeta_h^1m_h^1& \zeta_h^2m_h^2&...&\zeta_h^nm_h^n
\end{bmatrix}=\begin{bmatrix}P_1\\\vdots\\ P_h\end{bmatrix}\begin{bmatrix}M^1&...&M^n\end{bmatrix}$$
Which can be rewritten as
$$W_{h\times n}=P_{h\times 4}M_{4\times n}$$
Matrix $W$ has $m^i_j$ known but the scale factors $\zeta_h^n$ unknown. Both $P,M$ matrices are unknown.
The solution to this system is a chicken-egg problem as knowing the scale factors allows to find $P,M$ and vice versa. In fact:

- If the scale factor $\zeta _i^j$ is known then $W$ is known and it can be solved via SVD.
Since $W$ is defined by $P$ and $M$ then if $M$ has rank 4, also $W$ has rank 4. This leads to the factorization
$$W=\underbrace{U_{3h\times 4}\begin{bmatrix}\sigma_1 & 0 & 0 & 0 \\
0 & \sigma_2 & 0 & 0\\
0& 0& \sigma_3 & 0 \\
0 & 0 & 0 & \sigma_4\end{bmatrix}}_{P}\underbrace{V_{4\times n}^T}_M=PM$$
this minimizes the frobenious norm
If the data is noisy then $rank (W)\not=4$ but by zeroing the singular values after $\sigma_4$ the solution can still be obtained.

- Now suppose only $P,M$ are known, then:
$$PM^j=\begin{bmatrix}\zeta_1^jm_1^j\\\vdots\\\zeta_h^jm_h^j\end{bmatrix}=\begin{bmatrix}
m_1^j & 0 & ... & 0\\
0 & m_2^j & ... & 0\\
\vdots & &\ddots& \vdots\\
0 & ... & & 0
\end{bmatrix}
\begin{bmatrix}\zeta_1^j\\\vdots\\\zeta_h^j\end{bmatrix}=Q^j\zeta^j$$



This can be solved via an iterative operation.
1. Set scale factors to $1$ and generate $W$.
2. Normalize $W$ (so that scale factors are not 0)
3. Apply SVD and find $P,M$
4. If $\abs{W-PM}_2^2$ is small enough go to 8
5. Find scale factors from $Q^j\zeta^j=PM, \ j=1,...,n$
6. Update $W$
7. Repeat from 2
8. End

#### SfM Pipeline
The pipeline is straight forward
1. Collect images (unordered)
2. Find matching points via SIFT and create matrix $C$. The $C$ matrix contains how many matching points are in common between two images
3. Compute epipolar geometry (order matters)
4. Decompose matrix into $R,T$
5. Refine using bundle adjustment


![[Pasted image 20260512152215.png|C Matrix|250]]
**Image collection:** As stated before images don't need to be ordered, however the camera parameter matrix $K$ needs to be known. Moreover, compressed images should be avoided as they are not reliable for key point matching.

**Matching Points and Best Next View:** 

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

#### Mathematical Notation
The standard way to represent rotations via matrices is with Yaw, Pitch and Roll $3\times 3$ matrices.
$$\begin{aligned}
&R_x=\begin{bmatrix}1 & 0 & 0\\
0 & \cos\theta_x&-\sin\theta_x\\
0 & \sin\theta_x&\cos\theta_x\end{bmatrix}
\\
&R_y=\begin{bmatrix}\cos\theta_y&0&\sin\theta_y\\
0&1&0\\
-\sin\theta_y&0&\cos\theta_y\end{bmatrix}
\\
&R_z=\begin{bmatrix}\cos\theta_z&-\sin\theta_z&0\\
\sin\theta_z&\cos\theta_z&0\\
0&0&1\end{bmatrix}
\end{aligned}\longrightarrow R=R_xR_yR_z$$
Which can be rewritten as the rodriguez equation: 
$$R=I+\sin(\theta )N+(1-\cos\theta)N^2\qquad N=\stackvec u$$
and also if $\abs u=1$
$$r=\theta u$$
However this presents a discontinuity between $-\pi,\pi$

To solve this simple problem we introduce a heavily complex mathematical structure: Hamiltonians. This number space contains one real axis and 3 imaginary ones called $i,j,k$. So a number is expressed as
$$q=a+ib+jc+kd\rightarrow q=e^{\frac12\theta(iu_x+ju_y+ku_z)}$$
These axes have the following properties:
$$\begin{array}{c|rrrr} & 1 & i & j & k \\ \hline 1 & 1 & i & j & k \\ i & i & -1 & k & -j \\ j & j & -k & -1 & -i \\ k & k & j & i & -1 \end{array}$$
Essentially it can be seen as this:
- $i,j,k$ are versors and their product can be seen as a vector product
- Each axis retains the complex identity $\sqrt{-1}=i,j,k$ 
- One final fundamental property (which is a direct consequence of the first two) is $i\cdot j\cdot k=1$

#### 2D-2D Orientation
Used to **compute second camera orientation wrt first camera**. 
1. Normalize coordinates
2. Compute $E$ using 8 points algorithm
3. Factorize $E$ to find $R,t$

Here **Horn's method is used** if the rotation and translation to be estimated are small

![[Pasted image 20260512163446.png|Example|250]]

Lounguet Higgins can be written as
$$p_i'^Tt\times Rp_i=0$$
The LS solution is found by minimizing
$$\epsilon=\sum_{i=1}^n(p_i^Tt\times Rp_i)^2$$
by supposing they are gradually refined, we can replace $t,R$ with $\delta t, \delta w$ and have:
$$\epsilon=\sum_{i=1}^n(s_i+c_i^T\delta t+d_i\delta w)^2$$
with:
$$\begin{align}
&s_i=p_i'^Tt\times Rp_i\\
&c_i=Rp_i\times p_i'\\
&d_i=Rp_i\times(p_i'\times t)
\end{align}$$
and an additional constraint to unitary translation (correction must not alter length)
$$t^T\delta t=0$$
And using Lagrange's multipliers we can solve
$$\epsilon '=\epsilon+2\lambda (t^T\delta t)$$
where we can find $\delta t,\delta w,\lambda$ by finding their partial derivatives and setting them to 0. Finally:
$$\begin{align}
&t\leftarrow t+\delta t\\
&R=R\begin{bmatrix}0&-\delta w_3&\delta w_2\\\delta w_3&0&-\delta w_1\\-\delta w_2&\delta w_1&0\end{bmatrix}=R\stackvec{\delta w}
\end{align}$$
#### 3D-3D Absolute Orientation
This computes the orientation between two set of points:
We know $\tilde M_i,\tilde M_i'$, then
$$\tilde M_i'=s(R\tilde M_i+t)\quad i=1,...,n$$
And therefore we must find $R,s,t$ such that
$$\min_{s,R,t}=\sum_{i=1}^n\abs{\tilde M_i'-s(R\tilde M_i+t)}^2$$
which can be solved via SVD
![[Pasted image 20260512163507.png|Example|250]]
##### SVD Based Method / Orthogonal Procrustian Problem
The best estimate for $t$ is the average of points:
$$t = \frac{1}{s} \left( \frac{1}{n} \sum_{i=1}^{n} \tilde{M}_{i}' \right) - R \left( \frac{1}{n} \sum_{i=1}^{n} \tilde{M}_{i} \right)$$
then the minimization problem becomes
$$\min_{s,R}\sum_i\abs{\overline M_i'-sR\overline M_i}^2$$
where $\overline M_i$ are the zero centered points $\overline M_i=\tilde M_i-\frac1n\sum_{i=1}^n \tilde M_i$

Notice that $R$ is orthogonal so it has unit norm, therefore we have that the points norm match a scaled version of the original ones (procrustes!):
$$\abs {\overline M_i'}=s\abs{\overline M_i}$$
Create the matrices
$$\overline M_{3\times n}=[s\overline M_1\ ... \ s\overline M_n]\qquad \overline M_{3\times n}'=[\overline M_1'\ ... \ \overline M_n']$$
the minimization problem now becomes:
$$\epsilon = \sum_{i=1}^n\abs{\overline M_i'-sR\overline M_i}^2=\abs{\overline M'-R\overline M}_F^2$$
Which is the formal definition of the precrustian problem.

And we must find the nerarest orthogonal matrix to:
$$M_P=\overline M'\overline M^T=U\Sigma V^T\rightarrow R=\arg\min_R\abs{R\overline M-\overline M'}_F$$
The solution can be found from SVD:
$$R=UV^T$$

---
Proof
Recall that the frobenius norm can be written in the following way (for notation $M=\overline M$):
$$\abs{RM-M'}_F=<RM-M',RM-M'>=\abs{RM}_F^2+\abs{M}_F^2-2<RM,M'>$$
By noticing that $\abs{RM}_F^2=\abs{M}_F^2$ and thus the argmin becomes the maximization of the double product we have
$$R=\arg\max_R<R,M'M^T>=U(\arg\max_R'<R'\Sigma>)V^T=UR'V^T$$
which is maximized for $R'=I$.

##### Iterative Closest Point (ICP)
Suppose that the points live on two surfaces
$$M_i\in\mathcal M,M_j'\in\mathcal M'$$
Given a point $M_i$ we assume that the corresponding point is the closes one:
$$M_i'=\arg\min_j\abs{M'_j-M_i}^2$$
This however works only of the two orientations are not too far

Algorithm:
1. $\forall M_i$ find $M_i'$
2. Now compute $R,t$ (via procrustes)
3. Change $M_i$ to be aligned: $M_i\leftarrow RM_i+t$
4. Find avg error, if it is small enough stop, otherwise repeat:
$$\epsilon =\frac1n\sum_{i=1}^n\abs{M_i'-M_i}^2$$
This method works only with small rotations (less than$20^\circ$) and many points
#### 3D-2D External Orientation
This aims to **find position and orientation of camera given some 3d points**

![[Pasted image 20260512172547.png|Example|250]]
In general 6 normalized points are required to estimate $R,t$
$$p_i=\begin{bmatrix}u_i\\ v_i\\1\end{bmatrix}=K^{-1}m_i\qquad p_i\simeq[R|t]M_i$$
##### Fiore's Linear Method
Define scale factor:
$$\zeta_ip_i=[R|t]M_i\rightarrow \zeta_iK^{-1}m_i=R\tilde M_i+t$$
The system of $n$ points becomes
$$K^{-1}\underbrace{[\zeta_1m_1,\ \zeta_2m_2,\ ..., \ \zeta_nm_n]}_W=[R|t]\underbrace{[M_1,\ M_2,\ ...,\ M_n]}_M\rightarrow K^{-1}W=[R|t]M$$
Let $r=\text{rank}(M)$ then the solution via SVD requires the last $n-r$ rows of $V^T$:
$$MV_r=0\rightarrow K^{-1}WV_r=0$$
Notice that W under vec can be written as:
$$vec(W)=\begin{bmatrix}\zeta_1m_1\\\vdots\\\zeta_nm_n\end{bmatrix}=\begin{bmatrix}m_1& 0&...&0\\
0 & m_2 &...&0\\
\vdots&&\ddots&\vdots\\
0 & ... &  & m_n\end{bmatrix}\begin{bmatrix}\zeta_1\\\vdots\\\zeta_n\end{bmatrix}=D\zeta$$
And with the vec trick we end up with:
$$(V_r^T\otimes K^{-1})vec(W)=((V_r^T\otimes K^{-1})^TD)\zeta=0$$
So $\zeta$ can be found with the kernel of $(V_r^T\otimes K^{-1})^TD$. And to do so we need at least
$$n\geq \frac{3r-1}2$$
points

Linear ,ethod that is very fast with no convergence problems, however it needs lot of points and minimizes algebraic error
##### Lowe's Non Linear Method TODO
Needs less points but requires more computation and wrong matches affect the result more.


# 7) Optical Flow
Optical flows relates a motion vector field to pixels. This represents the 2D projection of the physical movement of points relative to observer which is equal as saying the 2D displacements of the pixel patches on the image plane. Optical flow is important as it allows to understand scene dynamics.

One common assumption is the **constant illumination assumption:**
$$I(p_i,t)=I(p_i+v_i,t+1)$$
this is obviously not true in practice (not lambertian surfaces, occlusions)

From here we get the **Image brightness constancy equation**
$$\nabla I(x,t)v+\dot I(x,t)=0$$
which has 2 unknowns ($v=(v_x,v_y)$) but one single equation (underdetermined).

It is possible that with repetitive motion the vexctor field might break (large spot with same color)
![[Pasted image 20260517120823.png|Example|250]]
So the system is limited by:
- Textureless surfaces
- Aperture problems: motion perpendicular to edge, not along it
- Brightness not constant
- Occlusion and noise


---
Proof of Image brightness constancy equation
Let
$$I(x,t)=I(x+v\Delta t,t+\Delta t)$$
With the first order taylor expansion we get:
$$I(x+v\Delta t,t+\Delta t)=I(x,t)+\tilde\nabla I(x,t)^T\begin{bmatrix}v\Delta t\\\Delta t\end{bmatrix}=I(x,t)+\nabla I(x,t)v\Delta t+\dot I(x,t)\Delta t$$
with $\tilde\nabla I(x,t)$ is the array of all partial derivatives (space, time)
$$\tilde\nabla I(x,t)=\begin{bmatrix}
\nabla I(x,t)\\
\dot I(x,t)
\end{bmatrix}$$


#### Tracking in 1D Case
Consider this case
![[Pasted image 20260517121336.png|Example|300]]
From the brightness constancy and by supposing small motion we get:
$$I_x=\frac{\partial I}{\partial x}|_t\quad I_t=\frac{\partial I}{\partial t}|_{x=p}\rightarrow v=-\frac{I_t}{I_x}$$
This converges at about the 5th iteration.

1. Compute local derivative around $p$: $I_x$
2. Initialize velocity vector $v\leftarrow 0$
3. Repeat the following:
	1. Compensate for current velocity vector: $I'(x,t+1)=I(x+v,t+1)$
	2. Compute temporal derivative $I_t=I'(p,t+1)-I(p,t)$
	3. Update velocity vector $v\leftarrow v-I_t/I_x$


#### Algorithms
It is possible to regularize the window $S$. Using a window implieas that all pixels inside the window have the same velocity, a bigger block size optimizes algorithm complexity but decreases accuracy.

A set of bounds can be implemented to make the estimation more accurate.
##### **Horn Schunk** regularization:
$$\min\int_S[\nabla I^Tv+\dot I]+\lambda\par{\abs{\nabla v_x}^2+\abs{\nabla v_y}^2}^2dS$$
this penalizes the large change in displacement. A close imperfect match is better than a very distant perfect match.

##### **Lucas Kanade** regularization:
Here $v$ is assumed constant and that the central pixel $p$ of window $S$ is more likely to be correct:
$$\forall x_i\in S\quad \nabla I(x_i,t)^Tv=-\dot I(x_i,t)$$
This is solved via pseudo inverse and by calling $A$ the spatial derivative matrix and $b$ the temporal derivative matrix:
$$Av=b\rightarrow v=A^\dagger b=(A^TA)^{-1}A^Tb$$
Now add the weights (useful since we know center pixel more likely to be correct):
$$\forall x_i\in S\quad w(x_i)\nabla I(x_i,t)^Tv=-w(x_i)\dot I(x_i,t)$$
with $W$ the weight matrix (diagonal!):
$$A=WA, b=Wb\rightarrow v=(A^TW^2A)^{-1}A^TW^2b$$

The algorithm is:
1. Filter spatially using 2D gaussian kernel
2. Filter temporally using 1D gaussian kernel
3. For every image and pixel do:
	1. Compute gradient $\nabla I(x_i,t)$ and spatial derivative $\dot I(x_i,t)$
	2. compute $A,b$
	3. compute $v=$ pseudo inverse


In Harris corner detection method $A^TW^2A$ is used. The problem is well conditioned if $c=\lambda_\max/\lambda_\min\approx 1$ that is, the matrix can be inverted and therefore it implies we have strong textures. This does not work well on edges!

Edge example: $\lambda_1\gg \lambda_2$:
![[Pasted image 20260601123144.png|Example|350]]


##### Kanade Lucas Tomasi TODO
This allows for coupling points along a trajectory

1. Estimate field using Lucas Kanade
2. Warp the image based on the field
3. Repeat until convergence

# 8) 3D Gaussian Splatting Rendering
A point cloud is usually rendered as a volume.  The rendering uses ray casting and by simulating light absorption through the volume.


The transmittance is the amount of light that reaches point t along a ray (without being abosrbed)
$$T_i=\exp{-\sum_{j=1}^{i-1}\sigma_j\delta_j}=\prod_{j=1}^{i-1}\exp{-\sigma_j\delta_j}$$
where $i$ is the sample index we are reaching, and $j$ all previous samples indexes.
Opacity is the amount of light absorbed by the segment:
$$\alpha_i=1-\exp{-\sigma_i\delta_i}$$
It is possible to rewrite the transmittance as a function of opacity by noticing:
$$1-\alpha_i=\exp{-\sigma_i\delta_i}\rightarrow T_i=\prod_{j=1}^{i-1}\exp{-\sigma_j\delta_j}=\prod_{j=1}^{i-1}(1-\alpha_i)$$

The final color takes into account the transmittance at each sample:
$$C=\sum_{i=1}^N T_i\alpha_ic_i$$

Here is a graphical example
![[Pasted image 20260517124855.png|Example|350]]
This has a significant throwback: it must sample also empty space which also takes computational effort


#### 3DGS Algorithm
3DGS wants to optimize this process.
We represent the 3D scene as a set of $N$ 3D gaussians $c_i,\mu_i,\Sigma_i$. Which are colored, translated and scaled. These parameters are learned.

the 3D gaussian is an anisotropic (ellipsoid) figure in space. 

**Initialization:**
SfM is used to generate the first PC where the first gaussians are set

**Loop:**
The 3DGS algorithm renders the scene and compares it to the og images in order to use the **adaptive density control** to optimize and improve the scene

**Adaptive Density Control**
the aim of the algorithm is to increase the gaussians in higher precision areas and decrease them in lower precision areas. Every 100 steps gaussians are added (densification), while every 3000 steps gaussians are removed (regularization)

**Strategy:**
- Start from SfM points
- Every 100 iterations add new gaussians
- Every 3000 iterations do a reset step for regularization
- Densification until iteration 15.000
- Run for 30.000 optimizations

**The densification step can:**
- Clone: duplicate gaussians in under-Reconstructed regions
- Split: divide gaussian into smaller ones in over-Reconstructed regions

![[Pasted image 20260517130326.png|Example|250]]
**The regularization step can:**
Regularization reduces all $\alpha$ near to 0 and augments it only for relevant gaussians. All gaussians with $\alpha$ under a threshold are purged (culling step).

**Rasterization Rendering Step**
1. **Tile Screen:** tile screen into $16\times16$ tiles (enables parallel processing)
2. **Project and Cull:** Project gaussian into space to obtain 2D ellipse. Discard gaussians outside of view frustum and that do not intersect tile with 99% probability
3. **Assign Keys:** Remaining gaussians get a key containing depth and tile ID they intersect
4. **Sort Gaussians:** use radix sort to sort gaussians closer to camera, important for transparence handling
5. **Build Per Tile lists:** store only first and last

6. Assign sorting keys: rendered gaussians get a key containing their depth and tile
7. Sort al gaussians: sort front to back (radix sort) so to process first closest splats
8. Build per tile list: For each tile, store the first and last indices in the sorted list of Gaussians that overlap it.
9. $\alpha$ blend per pixel: find the color on each pixel
$$\sigma_n=\frac12\Delta_n^T\Sigma_n^{-1}\Delta_n\quad \alpha'_n=\alpha_n\exp{-\sigma_n}\quad T_n=\prod_{m=1}^{n-1}1-\alpha'_m\rightarrow C_i=\sum_{n=1}^N c_n\alpha'_nT_n$$

# 9) Point Cloud
## 9.1) Compression
Point clouds come from various sources and have different characteristics. They contain huge amount of information and are hard to transmit efficiently.

Point cloud can be
- **static:** 10s M points
- **dynamic:** 1M per frame, 30 fps

Each point has $(x,y,z)$ coords and some attributes (normals, color, etc). **Point cloud coding (PCC)** exploits the high redundancy and correlation between samples. It should be possible to have flexible (multiple resolutions and quality) levels.

This chapter heavily relies on concepts from [[Multimedia Communications]]. Here is brief recap on how a lossy encoder/decoder works:
- **Analysis Transform:** $x$ is transformed into a more efficient (possibly sparse) representation $y=G(x)$
- **Lossy Step (Quantization):** $y$ is quantized $\hat y=Q(y)$
- **Entropy Encode:** using entropy coding $\hat y$ is transformed into a lossless more efficient representation to use into bitstream $P(\hat y)$
- **Decoding: Entropy Decode:** $P(\hat y)$ is decoded into $\hat y$
- **Decoding: Synthesis Transform:** $\hat y$ is decoded into $\hat x$ which is a lossless reconstruction of $\hat x$

Point clouds can be **represented** in multiple ways:
- octree (see G-PCC)
- Triangle Cloud: group points into triangles to create pieces of meshes.
- point arrays: rows of $x,y,z$ coords (useful for sparse data)
- depth maps
- different coordinates (cylindrical, spherical, etc)
- multiview projection (see V-PCC)

The **transformations** on point clouds are:
- 3D Wavelet Transform
- Graph Transform
- Cellular Automata
- Random PC access


### 9.1.1) PCC Quality Metrics
Two qualities:
- PSNR D1: similar to standard PSNR, that is MSE between compressed point and og point
- PSNR D2: project point on plane defined by normal. MSE between og point and projected reconstructed point.

Bitrate in bit per voxel (bpv): $bpv=B/N$

### 9.1.2) **MPEG PCC** 
The general scheme is the following:
![[Pasted image 20260520153828.png|General Scheme|350]]
Two coding schemes were proposed:
- **(Geometry) G-PCC (TMC13)**: focuses on compressing geometric info using octree. Static PC
- **(Video) V-PCC (TMC2)**: focuses on temporal compression using HEVC. Dynamic PC

#### G-PCC
Now will focus on **G-PCC:**  

![[Pasted image 20260520160858.png|Scheme|400]]
![[Pasted image 20260522154555.png|Encoder/Decoder|500]]

The general idea (encoder) is the following:
- Transform position (voxelize) and attributes (wavelet)
- **Geometry:** Construct octree and analyze surface approximation (TriSoup) send geometry info arithmetically encoded to bitstream
- **Attributes:** wrt reconstructed geometry compute RAHT and LODs, send them quantized and arithmetic encoded to bitstream

##### Geometry Steps
Let's start with the **geometry analysis**:

1. **Voxelization:** first step, is *lossy* and transforms the scene into a dense voxel grid (power of 2).


2. **Octree:** voxelization with different LODs, compression happens for empty voxels
We say that a octant is full if it contains one geometry component. An empty octant (bit value = 0) means that the furter resolutions are empty and will not need to be encoded. One full octant is encoded as 1, this means that the bitstream will contain a further byte of this octant at a deeper lod.

- First create a dense voxel grid (multiple of 2). This is the lossy step.
- Now divide the space into 8 parts (2x2x2 volume). Encode the bits and add the byte to bitstream. The bitstream holds the following info:
	- Bit $= 0$: all further lods are empty and won't be further encoded
	- Bit $= 1$: The next lod will be encoded further in bitstream
- For each octant, divide it in 8 parts and redo the encoding.
- Continue until original lod is achieved.
- The bitstream allows a gradual reconstruction from the worst lod to the original one.
![[Pasted image 20260520155329.png|Example|450]]
This example has a max lod of 2 ($4\times4\times4, \quad 4=2^{LOD}$) and will be encoded as:
$$\underbrace{[11100000]}_{\text{Lod: 1}}\ \underbrace{[1\times 8][11110000][11001100]}_{\text{Lod: 2}}$$


3. **Cellular Automata Block Transform:** Non-linear transformation. Used to maximize empty space (and therefore better octree compression)
Use a $2\times 2\times2$ voxel cube and transform it into a 8-bit state $s$. Use a transformation to evaluate the state of the voxels in the cube based on their neighbors. 

This transformation is (similar to) a DCT. Therefore 
$$\text{8-bit State: }s\stackrel{\text{CA Transform}}\longrightarrow\text{DCT Coefficients: } s^p$$

so similar to wavelet it adds *6 additional LODs per octree lod*


4.  **TriSoup:** compression of dense geometry. Uses pruned octree.
Approximate dense geometry as a surface by reconstructing it as triangles
- First build pruned octree
- Each cube represents the surface passing through or near that cube
- signal what segment contains a vertex.

##### Attributes Steps TODO
Now focus on the **attributes**, mainly RGB colors.

RAHT:
Process in a $2\times2\times2$ voxel block the DCT on the colors on the $x,y,z$ coordinates. For each coordinate find DC and AC values using
$$\begin{bmatrix}DC\\AC\end{bmatrix}=\frac{1}{\sqrt{w_1+w_2}}\begin{bmatrix}\sqrt{w_1} & \sqrt{w_2}\\-\sqrt{w_1}&\sqrt{w_2}\end{bmatrix}\begin{bmatrix}C_1\\C_2\end{bmatrix}$$


Also **PredLift** can be used, which uses predictive coding (color difference) at the lowest lod

#### V-PCC
G-PCC doesn't perform well in moving scenes, V-PCC consists in compressing the 3D scene into 2D information and transferring them using standard HEVC format.

![[Pasted image 20260511151123.png|VPCC|500]]

1. **Patches:**
Patches are created in the following way:
- Define 6 6 ortographc projections ($\pm x,\pm y,\pm z$)
- Based on the normal of each point, assign the point to one projection
- Refine the position based on neighbours
- Points are connected using a connected component algorithm: 3D Patch
- So each patch defines: 2 coordinates remain the same, third coordinate (projection) encodes the distance.

#### Coding with AI
The general idea behind AI coding is to use some AI information to aid the coding process. This however introduces some challengers, mainly:
- Multiple models for different data types
- Many approaches lack features of standard codexes (ex: scalability)
- Specific design hard to generalize

#### AI Coding - JPEG Pleno
The pipeline is divided in two parts:
- Geometric encoding
- Color encoding (takes also geometric info)

![[Pasted image 20260511152953.png|Scheme|350]]
In detail we have:
![[Pasted image 20260522183402.png|Architecture|350]]
A total of 3 informations are sent:
- Encoded Coordinates ($y_C$): $x\stackrel{\text{Analysis Transform}}\longrightarrow y=(y_C,y_F),\ y_c$ is G-PCC encoded and sent
- Side Info ($(\mu,\sigma)$): $x\stackrel{\text{Analysis Transform}}\longrightarrow y\stackrel{\text{Hyper-Analysis Transform}}\longrightarrow z$ which contains info on distribution
- Latents Bitstream ($\hat r$): $r=y_F-\mu_{\hat z}$ so that $\hat r+\mu_{\hat z}=\hat y_F$


The pipeline is the following
1. **Analysis Transform** input $x$ into the latent representation $y=(y_C,y_F)$
2. **Send** $y_C$ through standard G-PCC pipeline
3. **Compute Hyper Analysis Transform** of $y\rightarrow z$ and round it ($\hat z$) so to be able to compute Hyper-Synthesis Transform of $\hat z\rightarrow (\mu,\sigma)$ so to have $P(\hat y|\hat z)=\mathcal N(\mu,\sigma)$. This is required since $P(\hat y)$ cannot be estimated for each PC. Mathematically the entropy is the same:
$$H(\hat y|\hat z)+H(\hat z)=H(\hat y,\hat z)=H(\hat y)$$
4. Encode the latents as $r=y_F-\mu$, and round them. 
5. Finally, the received bitstreams yield  $\hat y_F=\hat r+\mu$, $y_C$ and thus $\hat y=(y_C+\hat y_F)$ which using the **synthesis transform** becomes $\hat x$

## 9.2) Segmentation
Segmentation is the task of dividing the input data into homogeneous regions that share the same semantic meaning. 

Segmentation is usually a convolutional autoencoder. Call $G$ the ground truth and $P$ the predictions, we define 5 metrics:
- Precision:
$$\text{Precision}=\frac{A\cap P}P$$
- Recall:
$$\text{Recall}=\frac{A\cap P}A$$
- Dice:
$$\text{Dice}=\frac{2\par{A\cap P}}{A+P}$$
- **Intersection Over Union (IoU):**
$$\text{IoU}=\frac{A\cap P}{A\cup B}$$
- **Mean Intersection Over Union (mIoU):**
$$mIoU=\frac1{K+1}\sum_{i=0}^K\frac{p_{ii}}{\sum_{j=0}^K p_{ij}+\sum_{j=0}^Kp_{ji}p_{ii}}$$


Accuracy is not used as it is not representative of the result (road image with one segment road is accurate at 60% but has mIoU of 3%)

The loss functions are:
- **Cross Entropy:** $$L_{CE}=-\sum_{\text{classes}}y\log y_{pred}$$
- Dice loss: $$L_{Dice}=1-\text{Dice}$$


# 10) Gen AI & Diffusion

## 10.1) Variational Autoencoders (VAE)
The idea of a VAE is to to find a general feature space of the object it wants to create and sample from it in order to create a new object of the same type.

The **training phase** consists in letting the autoencoder map samples into a (compressed) latent feature space so that samples are mapped into clustered regions.

## 10.2) Implicit Neural Representations (INRs)
When $\#\text{parameters}\approx \#\text{samples}$ the model will likely overfit. This is usually an undesired behaviour as the main aim of a model is to generalize.

In some cases this is actually helpful. If a model is trained on just one image, it will generalize it and make it **independent of spatial resolution**

#### Neural Radiance Field (NeRF)
This technique is used to **represent a 3D scene with implicit neural representations for the synthesys of an arbitrary view**

Train network on a set of images where position $(x,y,z)$ and the viewing direction $(\theta,\phi)$ are known. The network will be overfitted to that specific scene and can now generate arbitrary views. 

Used for synthetic view generation, complex geometry handling, compression. But gaussian splats are more efficient! This model is used for very HQ stuff: radio study, complex lighting simulations...

There are many other downsides:
- very slow training time: needs to be re trained for every different scene
- hard to converge: depends on initial conditions

## 10.3) Generative Adversarial Networks (GAN)
The idea of a GAN is to generate realistic data through a competition where one network learns to create convincing fakes while another network learns to detect them.

The two competing networks are:
- **Discriminator:** wants to distinguish between real samples and fake samples $D(\cdot)=\begin{cases}0&\text{image is fake}\\ 1&\text{image is real}\end{cases}$. It doesn't want to be fooled by the generator $D(G(Z))\rightarrow 0,\ D(X)\rightarrow 1$
- **Generator:** processes some noise to send to the discriminator. It wants to fool the discriminator, that is: $D(G(Z))\rightarrow 1$ and therefore a real image $D(X)\rightarrow0$.

We define the loss as:
$$L(D,G)=\E_{x\sim p_r}[\log D(x)]+\E_z[\log (1-D(G(z)))]$$
with $\E_{x\sim p_r}$ when it is sampled from real distribution, and the other expectation when the image is fake.
This needs to be
- minimized by generator $D(G(z))\rightarrow 1,\ D(x)\rightarrow 0$
- maximized by discriminator $D(G(z))\rightarrow 0,\ D(x)\rightarrow 1$

This is solved with game theory: it is a **Zero-Sum von-Neuman Game**. Logically, if both the generator and the discriminator are perfect, the discriminator will only guess randomly.

We can show this by using the definition of expectation to rewrite the loss as:
$$\begin{align}L(D,G)&=\E_{x\sim p_r}[\log D(x)]+\E_{z\sim p_g}[\log (1-D(G(z)))]\\
&=\int_xp_r(x)\log D(x)dx+\int_zp_g(z)\log(1-D(z))dz
\end{align}$$
Now let: $\tilde x=D(x)\quad A=p_r(x)\quad B=p_g(x)$ the function in the integrals becomes:
$$f(\tilde x)=A\log(\tilde x)+B\log(1-\tilde x)$$
so the minimization/maximization needs just to be performed on D(x), that is to set the derivative of $f$ to 0:
$$\frac{df}{d\tilde x}=\frac A{\tilde x}-\frac B{1-\tilde x}=\frac{A-(A+B)\tilde x}{\tilde x(1-\tilde x)}=0\rightarrow \tilde x=\frac{A}{A+B}\rightarrow D(x)=\frac{p_r(x)}{p_r(x)+p_g(x)}$$
and the generator is perfect if $p_g\rightarrow p_r$ and this brings to $D(x)\rightarrow\frac12$. Which doesn't make the discriminator work.
To avoid this a different loss is defined:
$$L(D,G)=-\frac12\E_z[\log (D(G(z))]$$


The GAN **training** is done in 2 steps:
1. Train $D$ only on its loss (perfect samples $D(x)\rightarrow 1$ and crappy generated data $D(z)\rightarrow 0$) the weights are updated via standard backpropagation
2. Train $G$ with the discriminator of step 1. Update weights via standard backpropagation (passing through $D$ also)
3. repeat steps 1,2

This however has some problems:
- vanishing gradients (as $p_g\rightarrow p_r$)
- Mode collapse: only one subset of possible outputs is generated
- failure to convergence

#### Quality Metrics
Various quality metrics are used as it is difficult to measure the quality of the generated data (discriminator guesses randomly in ideal case). we introduce in particular the **Inception Score (IS)** and **Frechet Inception Distance (FID)**

This uses a pre trained network (InceptionNet) that measures the properties of high classifiability and diversity for samples.

The conditional label distribution has low entropy $p(y|x)$ while the general distribution has high entropy

## 10.4) Diffusion Models TODO

A diffusion model is a generative model that learns how noise is added to an image and learns to denoise it.

This can be seen as a markov chain that starts with a clean image and every step of the chain one layer of noise is added, until the image is only noise.

The **forward process** (diffusion process) is the product of all the gaussian noises added:
$$q(x_{1:T}|x_0)\def \prod_{t=1}^Tq(x_t|x_{t-1})\text{ with } q(x_t|x_{t-1})=\mathcal(x_t;\sqrt{1-\beta_t}x_{t-1},\beta_tI)$$
Recall that a sum of gaussian = gaussian with combined parameters. Now define
$$\begin{cases}\alpha_t=1-\beta_t\\ \overline\alpha_t=\prod_{s=1}^t\alpha_s\end{cases}\longrightarrow q(x_t|x_0)=\mathcal N\par{x_t;\sqrt{\overline\alpha_t}x_0,(1-\overline\alpha_t)I}$$
so it is possible to skip sampling steps:
$$x_t=\sqrt{\overline\alpha_t}x_0+(1-\overline\alpha_t)\epsilon\qquad \text{ with }\epsilon\sim\mathcal(0,I)$$
which implies that as $t\rightarrow \infty$ we get to $\mathcal N(0,I)$ since $\overline\alpha_t\rightarrow 0$.

![[Pasted image 20260523182445.png|Example|450]]

The **reverse process** is done by CNNs (not GANs)


# 11) Quiz

## 11.1) Quiz 2
#### **Question 1: Motion Modeling Strategies**

Assign the most suitable strategy (Animation or Simulation) for each object/event.

- **Body motion:** Animation
    
- **Clothes:** Simulation
    
- **Bone motion:** Animation
    
- **Low complexity motion rendering:** Animation
    
- **Hair and fur:** Simulation
    

**Explanation:** L'**Animation** si usa per movimenti controllati o predefiniti (come lo scheletro/ossa). La **Simulation** (fisica) è necessaria per fenomeni complessi dove il movimento dipende da forze esterne, collisioni e gravità, come tessuti e capelli.

---

#### **Question 2: Ray Casting vs. Z-Buffer**

Select the true statements:

- a) In ray casting, a ray is generated for each pixel.
    
- b) Z-buffer rendering is more efficient than ray casting.
    
- c) In ray casting, a ray always intersects one object only.
    
- d) In ray casting and z-buffer, the color of a pixel is determined by the closest object projected on that pixel.
    

**Correct answers:** **a, d** **Explanation:** Il Ray Casting proietta un raggio per ogni pixel per trovare l'intersezione più vicina. Sia Ray Casting che Z-buffer risolvono il problema della "visibilità" identificando l'oggetto più vicino alla camera per determinarne il colore. La (b) è spesso falsa (dipende dall'hardware, ma il rasterizzatore con Z-buffer è lo standard per la velocità), e la (c) è falsa perché un raggio può attraversare molti oggetti prima di fermarsi.

---

#### **Question 3: Phong Illumination Model**

Select the true statement:

- a) The ambient light component depends on the viewers' position.
    
- b) Phong model includes the reflected and refracted components as well.
    
- c) Specular component depends on the positions of the light source, on surface normals, and location of the viewer/camera.
    

**Correct answer:** **c** **Explanation:** La componente speculare simula il "luccichio" che cambia in base a dove si trova l'osservatore rispetto alla luce e alla normale della superficie. La luce ambientale (a) è costante ovunque, e il modello Phong base non gestisce rifrazioni (b) in modo nativo (serve il Ray Tracing).

---

#### **Question 4: Rendering Complexity**

Given four 3D spheres and a frustum including only three of them, select the correct sentences:

- a) Ray-tracing is less complex than ray-casting.
    
- b) Ray-casting is less complex than ray-tracing.
    
- c) Image resolution affects the computational complexity.
    
- d) Rendering complexity depends only on three out of four spheres.
    

**Correct answers:** **b, c, d** **Explanation:** Il Ray Tracing è più complesso perché calcola raggi secondari (riflessi/ombre). La risoluzione (c) conta perché determina il numero di raggi o pixel da processare. Gli oggetti fuori dal _view frustum_ (d) vengono scartati (culling), quindi non pesano sul rendering finale.

---

#### **Question 5: Graphical Pipeline (Rasterization)**

Select the true statements:

- a) Every 3D point in the scene is projected on the image.
    
- b) Objects outside the viewing frustrum are not considered.
    
- c) Anti-aliasing is used to correct occlusions.
    
- d) Objects need to be ordered with respect to their distance from the camera.
    
- e) Illumination effects are controlled by shading.
    

**Correct answers:** **b, d, e** **Explanation:** Il _view frustum culling_ elimina ciò che non è visibile (b). L'ordinamento (d) è fondamentale per gestire correttamente le sovrapposizioni (algoritmo del pittore o Z-buffer). Lo shading (e) definisce come la luce colpisce le superfici rasterizzate.

---

#### **Question 6: Texture Mapping (Inverse)**

Inverse mapping...

- a) ... maps texels into pixels.
    
- b) ... maps pixels into the corresponding texel.
    
- c) ... maps texels to a spherical surface.
    

**Correct answer:** **b** **Explanation:** Nell'**Inverse Mapping**, per ogni pixel dell'immagine finale, si "torna indietro" per vedere quale coordinata (u,v) della texture vi corrisponde. È il metodo più usato perché evita buchi nell'immagine finale.

---

#### **Question 7: 3D Mesh Models**

Select the true statements:

- a) Normal maps (bump mapping) define how light interacts with the surface.
    
- b) In complex models, using a texture map is more efficient than specifying a color for each face.
    
- c) In order to render the model, we need to define a normal map and a texture map.
    
- d) For each face, we necessarily need to specify a color.
    

**Correct answers:** **a, b** **Explanation:** Le Normal Maps (a) simulano micro-dettagli alterando il calcolo della luce senza aggiungere poligoni. Usare un'immagine (texture) è molto più efficiente (b) che gestire milioni di colori singoli per ogni faccia. (c) e (d) sono false perché sono componenti opzionali.

---

#### **Question 8: Textures in CG**

Select the true statements:

- a) ... contributes to create the finally-rendered image of an object.
    
- b) ... corresponds to the final rendering of the object.
    
- c) ... could require anti-aliasing filters after rendering.
    
- d) ... faithfully reproduce the area of the surface of 3D objects.
    

**Correct answers:** **a, c** **Explanation:** Le texture sono dati di input che contribuiscono al risultato (a). Richiedono filtri (c) come il mipmapping o filtri anisotropici per evitare artefatti (aliasing) quando l'oggetto è lontano o inclinato.

---

#### **Question 9: Bump Mapping**

Select the true statements:

- a) ... it defines how objects interact among themselves.
    
- b) ... it models the normals to the surface.
    
- c) ... it is useful for objects with repetitive or complex structure.
    

**Correct answers:** **b, c** **Explanation:** Il Bump Mapping non cambia la geometria, ma "inganna" l'occhio modificando le normali (b) usate per l'illuminazione, rendendolo perfetto per superfici rugose o ripetitive (c) come muri di mattoni o pelle.

---

#### **Question 10: Low-Complexity Rendering**

Which strategies allow for quick rendering?

- a) Bump mapping
    
- b) Texture mapping
    
- c) Ray-tracing
    
- d) Billboarding
    
- e) LOD adaptation
    

**Correct answers:** **a, b, d, e** **Explanation:** Tutte tranne il Ray-tracing. Il **Billboarding** usa piani 2D per oggetti distanti; il **LOD (Level of Detail)** riduce i poligoni lontano dalla camera; **Texture** e **Bump mapping** aggiungono dettaglio visivo senza appesantire la geometria.

---

#### **Question 11: Pose-to-Pose Animation**

Select the correct statement:

- a) It is totally handled by the computer.
    
- b) You must specify the first and the last poses of the motion segment.
    
- c) You can generate very complex motions by specifying a few poses.
    
- d) You must specify a pose for each frame.
    

**Correct answer:** **b** **Explanation:** L'animatore definisce i "Keyframes" (pose chiave), e il computer esegue l'interpolazione (in-betweening) tra la posa iniziale e finale.

---

#### **Question 12: Skinning**

In animating a character, skinning...

- a) ... fits a skeleton into a 3D mesh model.
    
- b) ... links joints and bones together.
    
- c) ... is used to animate the skeleton.
    
- d) ... is used to deform the mesh model according to the motion of the skeleton.
    
- e) ... associates the 3D mesh model to the skeleton.
    

**Correct answers:** **d, e** **Explanation:** Lo skinning è il processo che lega i vertici della mesh (la "pelle") alle ossa dello scheletro, definendo come la mesh si deve deformare quando le ossa si muovono.

---

#### **Question 13: Puppeteering**

In CGI, puppeteering refers to...

- a) ... controlling motion by capturing a real person/actor.
    
- b) ... animating using complex mathematical algorithms.
    
- c) ... using real puppets.
    
- d) ... using face motion capture to reproduce facial expression.
    

**Correct answers:** **a, d** **Explanation:** Il termine si riferisce all'uso del **Motion Capture (MoCap)**, dove i movimenti di un attore (corpo o faccia) guidano in tempo reale o differito il personaggio digitale.

---

#### **Question 14: Realistic Illumination**

Which components are needed for realistic lighting from a point source?

- a) Diffused light.
    
- b) Reflected light.
    
- c) Emitted light.
    
- d) Ambient light.
    

**Correct answers:** **a, b, d** **Explanation:** Per il realismo servono: **Ambient** (luce globale), **Diffused** (colore base colpito dalla luce) e **Reflected** (riflessi speculari). L'emitted light riguarda oggetti che brillano di luce propria, non la risposta di un oggetto a una fonte esterna.

---

#### **Question 15: Forward Mapping**

In texture mapping, forward mapping...

- a) ... maps image pixels to texels.
    
- b) ... maps texels to image pixels.
    
- c) ... could require an anti-aliasing filter.
    
- d) ... can be used only for color components.
    

**Correct answers:** **b, c** **Explanation:** Il **Forward Mapping** proietta i texel sulla superficie e poi sullo schermo. È meno efficiente dell'inverse mapping perché può lasciare pixel vuoti ("holes") nello schermo, richiedendo filtri pesanti.

---

#### 7.1.8) **Question 16: Skeleton Joints**

Select the true statements:

- a) joints support rotations, translations and stretchings.
    
- b) joints can have from 0 to 6 DOF.
    
- c) most of the joints have from 1 to 3 DOF.
    
- d) a joint can be connected to another joint without a bone in between.
    

**Correct answers:** **b, c** **Explanation:** I **Grandi di Libertà (DOF - Degrees of Freedom)** indicano come un giunto può muoversi. Nella maggior parte dei casi umani sono 1-3 (rotazioni), ma matematicamente possono arrivare a 6 (includendo traslazioni).

## 11.2) Quiz 3
#### Question 1: Epipolar Geometry and Homography

The epipolar geometry relations between two pictures taken by a moving camera simplifies into a homography...

a) ... when the camera is simply translating (no rotations).

b) ... when the camera is simply rotating (no translation).

c) ... always.

d) ... when the world coordinates correspond to the camera coordinates at the beginning.

e) ... when points acquired by the camera lie on a plane.

Correct answers: b, e Explanation: La geometria epipolare si riduce a un'omografia piana nel caso in cui la scena osservata giaccia interamente su un piano, oppure quando la telecamera compie una rotazione pura attorno al proprio centro ottico (senza alcuna traslazione).

#### Question 2: Stereo Camera Rectification

In stereo camera rectification, ...

a) ... camera rotates around the COP.

b) ... the pixel m corresponding to a given 3D point changes.

c) ... the COP of each camera is translated.

d) ... the optical rays for a given point M changes.

Correct answers: a, b Explanation: La rettificazione stereo virtualizza le telecamere simulando una rotazione attorno ai rispettivi centri di proiezione (COP), in modo da rendere i piani immagine complanari e paralleli alla baseline. Di conseguenza, le coordinate dei pixel cambiano per riflettere questa nuova proiezione, ma i centri di proiezione e i raggi ottici originali non subiscono traslazioni.

#### Question 3: RANSAC Algorithm

The RANSAC algorithm is useful to estimate homographies whenever:

a) Only a few couples of conjugate points are available.

b) The number of couple of conjugate points is really high.

c) Point coordinates are noisy.

d) Calibration parameters are available.

Correct answers: a, c Explanation: Il RANSAC è un algoritmo robusto impiegato per stimare un modello matematico filtrando il rumore e i valori anomali (outlier). Essendo basato su campionamenti casuali di sottoinsiemi minimi di dati, risulta molto utile per ricavare la stima migliore anche in presenza di coordinate rumorose e quando le coppie di punti coniugati a disposizione sono limitate.

#### Question 4: Disparity and Depth Calculation

The following 3D points are seen by a stereo camera (two parallel RGB cameras); the difference between the horizontal pixel coordinates in the two views can be characterized by the disparity value. According to the disparity value, assign the correct distance with respect to the camera.

a) Disparity=3

b) Disparity=35

c) Disparity=54

d) Disparity=15

_Distances to match: 15cm, 10cm, 36cm, 1.8m_

Correct answers: a $\rightarrow$ z=1.8m, b $\rightarrow$ z=15cm, c $\rightarrow$ z=10cm, d $\rightarrow$ z=36cm Explanation: Maggiore è la disparità, più il punto è vicino alla telecamera. Essendo la profondità inversamente proporzionale alla disparità ($z = \frac{b \cdot f}{d}$), è sufficiente ordinare i valori di disparità in modo decrescente e associarli alle distanze in ordine crescente.

#### Question 5: Stereo System Depth Range

In a stereo system (with rectified cameras), we can say that ...

a) ... the allowed depth range increases with the baseline distance.

b) ... disparity estimation depends on the vertical coordinate as well.

c) ... depth accuracy increases proportionally with the distance of the point from the camera.

Correct answers: a Explanation: In un sistema stereo, la profondità massima è descritta dall'equazione $z_{max} = b \cdot f$ (assumendo una disparità minima rilevabile pari a 1 pixel). Questo significa che, all'aumentare della lunghezza della baseline $b$, aumenta proporzionalmente il range di profondità massima che il sistema è in grado di percepire.

#### Question 6: Disparity Estimation via Block Matching

In a stereo system, a disparity estimation using block matching could ...

a) ... verify the disparity consistency performing a left-right check.

b) ... minimize the NCC value between displaced blocks.

c) ... minimize the SAD value between displaced blocks.

d) ... reduce block size to minimize the effect of noise.

Correct answers: a, c Explanation: Nel block matching, metriche di errore come la SAD (Sum of Absolute Differences) devono essere minimizzate per trovare le corrispondenze tra blocchi (al contrario della NCC che, essendo una misura di correlazione, andrebbe massimizzata). Inoltre, un metodo standard per validare le stime della disparità (e filtrare le occlusioni) consiste nell'eseguire il "left-right consistency check".

# 12) Q&A
## 12.1) Present how active stereo systems work and overviews the different 3D scanners that are exploiting such principle

Active stereo systems differ from passive ones since the employ one active light projector (laser, IR, ...) and one or more cameras. These allow for more precise measurements and also in more complex environments (for example dark areas). 

We identify two main technologies. Active stereo and active triangulations.

The first method is more similar to the traditional stereo system as two cameras and one projector are employed. The projector illuminates the scene and the cameras calculate the disparity on the laser projections. Three main methods exist:
- Structured light: a texture is painted on the whole object
- Laser pointer: one single laser point is shot, multiple shots are needed for an entire object
- Laser line: one vertical line is shot, also here multiple shots are needed

The active triangulation employs one camera and one laser. Calibration is needed. Here we can identify:
- Laser line: one vertical line is shot (since v_p cannot be estimated), also here multiple shots are needed
- Coded light: a series of bands is used to speed up the process

Active methods however have some limitations:
- Occlusion
- different objects have different reflectivites which skew the measurements
- external illumination
- noise

Active stereo methods work best in short range and have low costs, they hive high precision but require the correct environment. Another type of 3D sensor is the ToF sensor. This sensor measures the phase shift (phase-shift )of the returning ray or also the time of flight itself (pulse based). The first category works at up to 100m and has high precision and high speed, the latter are used for even longer distances but are more noisy.

The kinekt v1 was the first commercial active structured light stereo method, which allowed to generate a depth map at relatively high refresh rates using IR cameras. The v2 of the same technology resorted to a ToF scanner. It is worth noticing that both only create a "2.5"D view of the scene as a fixed acmera cannot create a 3D point cloud

## 12.2) Describe how Time-of-Flight sensors work.
ToF sensors measure the distance of an object using the physical properties of light itself. In fact the traveled distance will be $z=c\tau/2$ with tau the e2e time. 

Phase shift based ToF sensors can be more precise by inferring on the phase f_mod of the amplitude modulated signal:
The system emits s$_E(t)=A_E(1+sin(2\pi f_{mod} t))$
It will receive $s_R(t)=A_R(1+sin(2\pi f_{mod} t+\Delta\phi))+B_R$

Where $B_R$ is the additional recorded light (assumed as constant), $A_R$ is the amplitude attenuation proportional to $1/z^2$ and $\Delta\phi$ is proportional to \tau. In fact the distance can now be inferred from the phase as:
$\Delta\phi=2\pi f_{mod} \tau=2\pi f_{mod} \frac{2z}c$ From here $z=\frac{c}{4\pi f_{mod}}\Delta\phi$

This however has one limitation, the phase wrapping, if the distance is not in the range $[0,c/2 f_{mod}]$ then the measurement will be incorrect. This can be fixed by sending multiple impulses with different phases.

Since the cameras have a sampling time, it must be assured that at least 4 samples are recorded in the period, that is F_$s=4f_{mod}$. Then with these 4 measuremenst the phase can be inferred as
$arctan2(s_R(0)-s_R(2/F_s), s_R(1/F_s)-s_R(3/F_s).$

Other issues are given by pixel size, where one pixel has many measurements, $z_\max-z_\min/2$ is chosen. Radiation noise is modeled as a gaussian

Proofs:
Active stereo system:
- Active triangulation
- ToF phase distance
Multiview:
- Find LH in normalized coords (E matrix)
- Prove theorem E=SR if 2 eigenvalues the same and third one 0
- 8 points
- Bundle adjustment (only explanation)
- Projective Reconstruction (chicken-egg)
Orientation:
- ICP, orthogonal procrustean algorithm
- Optional: Fiore, Lowe and 
Optical Flow:
- Image brightness constancy equation
- 1D tracking
- Lucas Kanad, Kanade Lucas Tomasi
Gaussian Splat:
- Transmittance (discorsivo)