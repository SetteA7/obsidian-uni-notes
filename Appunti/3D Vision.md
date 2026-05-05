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
then $P=K[I_3|0_3]$
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
The COP point is the optical center of the camera. Since every light ray passes thorugh this point, if an object is placed in C there are infinitely many rays passing through it, thus **the projection is not defined, that is COP is not defined in projective plane**
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
Let there be a set of coupled points between two images $m_i,m'_i=Hm_i$. To compute the homography $H$ between the two images, a set of at least $n=4$ matching points are needed with noise free matches.
The solution is found by finding  $ker(A)$ of this system:
$$\begin{bmatrix}
m_1^T\otimes\stackvec{m_1'}\\
m_2^T\otimes\stackvec{m_2'}\\
\vdots\\
m_n^T\otimes\stackvec{m_n'}\\
\end{bmatrix}vec(H)=Avec (H)=0_{2n\times 1}$$

If matches are noisy, RANSAC is used
First outliers are discarded, that is, keep only matches that
$$\abs{m_i'-Hm_i}\leq \epsilon$$
Now RANSAC is applied to the N matches in set $\mathcal M=\curly{m_i,m_i'}$.
1. Select $N_0<N$ couples from $\mathcal M$ and create subset $\mathcal M_0$
2. Compute the estimated matrix $H_0$ on $\mathcal M_0$
3. Compute the number of inliers $N_{in}$
4. if $N_{in}>T$ or max iterations stop, otherwise restart from 1.

--- 
Proof of noise free homography:
Let there be a set of coupled points between two images $m_i,m'_i\simeq Hm_i$. 
Notice that 
$$m_i'\times Hm_i=0\rightarrow \stackvec{m_i'}H m_i=0_{2\times 1}$$
Apply the vec operator:
$$vec\par{\stackvec{m_i'}Hm_i}=vec (0)=0$$
Now expand:
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
$$F=\stackvec{e'}Q'Q^{-1}=\stackvec{Kt}K'RK^{-1}$$

A fundamental equation is the **Longuet Higgins Equation:**
$$m'^T\stackvec{e'}Q'Q^{-1}m=m'^TFm=0$$
this equation is a bilinear relation between $m,m'$ with $P=[Q|q],\ P'=[Q'|q']$. This allows to find if $m,m'$ are on the same epipolar line without knowing the depth of $M$.

---
Proof of Longuet-Higgins Equation
Longuet-Higgins equation relates matching points on the same epipolar line.
In the general case the two camera matrices are
$$P\simeq [Q|q],\qquad P'\simeq [Q'|q']$$

The optical ray of m is:
$$M=C+\lambda \begin{bmatrix}Q^{-1}m\\ 0\end{bmatrix}$$
This is used to compute the epipolar line $e'$, so we project the line onto $P'$:
$$P'M=P'C+\lambda P'\begin{bmatrix}Q^{-1}m\\ 0\end{bmatrix}=P'C+\lambda [Q'|q']\begin{bmatrix}Q^{-1}m\\ 0\end{bmatrix}=P'C+\lambda Q'Q^{-1}m+q'\cdot 0
$$
Recall that by definition $P'C=e'$ and therefore we have:
$$m'\simeq P'M=e'+\lambda Q'Q^{-1}m$$
Notice that since we don't know at what distance $M$ is located, we only know that $m'\simeq P'M$, that is $m'$ is on the epipolar line.

Now we can do some algebraic manipulations to get the final equation:
Vector multiplication by $e'$:
$$e'\times m'=\stackvec {e'} m'=e'\times (e'+\lambda Q'Q^{-1}m)=\underbrace{e'\times e'}_{=0}+\lambda e'\times Q'Q^{-1}m=\stackvec {e'}\lambda Q'Q^{-1}m$$
Now multiply by $m'^T$
- The first term is immediately 0 since $\stackvec{e'}m'\perp e', m'$ and thus $m'^T\cdot \stackvec{e'}m'=0$ 
- The second term is the Longuet-Higgins eq times $\lambda$
$$m'^T\stackvec {e'}m'=0=m'^T\stackvec {e'}\lambda Q'Q^{-1}m$$
$\endproof$

---

#### Morion Estimation


---
Fundamental Matrix in the world coordinates system
Center the world coordinates on $P$ and then $P'$ is a roto translation:
$$P=K[I|0]=[K|0]\qquad P'=K'[R|t]$$
The optical center becomes:
$$C=\begin{bmatrix}-Q^{-1}q\\1\end{bmatrix}=\begin{bmatrix}0_{1\times 3}\\1\end{bmatrix}$$
And the epipole is easily found:
$$e'=P'C=K'[R|t]\begin{bmatrix}\vec 0\\1\end{bmatrix}=K't$$
therefore we have:
$$F=\stackvec{K't}K'RK^{-1}$$
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

# 7) Optical Flow

# 8) 3D Gaussian Splatting


# 9) Quiz

## 9.1) Quiz 2
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

## 9.2) Quiz 3
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