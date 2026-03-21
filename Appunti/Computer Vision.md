# 1) Image Formation
There are 3 types of images:
- **Grayscale**: $f(x,y)\in[0,1]$ continuous function that represents the intensity of the gray level
- **Color Image**: $f_c(x,y,\lambda)$ where $\lambda$ is the value for each wavelength. A good approximation is to use 3 continuous functions for each pixel color: $f_{R/G/B}(x,y)$ (details later)
- **Digital Images**: as before but $x,y\in\mathbb N$. So the values of $f$ are discrete and finite

This course deals with digital images that are stored as 2D matrices with 8-bit values per pixel $[0,255]$.

**How are images formed?**
![[Pasted image 20251001105046.png|Image Formation|300]]
$f(x,y)=i(x,y)r(x,y)$ this shows that the final image will be the light source ($i$) multiplied by the reflectance ($r$) of the objects. The reflected light is the one reaching the sensor.

But the light gets scattered everywhere and therefore we need a barrier (pinhole) to block most duplicate rays. This produces an inversion in the result.
![[Pasted image 20251001105940.png|Pinhole Camera Model|350]]
The pinhole is called **Center of Projection** (COP, C) and the perpendicular line passing through it is the **optical axis** this plane is called focal plane (F). The image is built on the **imaging plane** (R) and the **principle point** (P*) is the intersection between R and optical axis. The **focal distance** (f) is the distance between C and R. 

This creates a projection from 3D space $\tilde M=\begin{bmatrix} x \\ y \\ z\end{bmatrix}$ to a 2D space $\tilde m =\begin{bmatrix} x \\ y\end{bmatrix}$. In this model we have that $u=f\frac xz, v=f\frac yz$, which is clearly non linear due to the division by z which is the perspective shift.


By adding an extra dimension  $M=\begin{bmatrix} x \\ y \\ z \\ 1\end{bmatrix}$, $m =\begin{bmatrix} x \\ y\\ 1\end{bmatrix}$ and by normalizing by the last coordinate ($\tilde m = \alpha m$) we have **homogeneous coordinates**, this allows for a linear mapping, that is
$$\lambda m = PM$$
![[Pasted image 20251001110903.png|Homogeneous Coordinates|350]]
## 1.1) Mathematical Model for 3D to 2D Projection

The mathematical model must map the **world reference coordinates** ($\curly{x,y,z, (1)}$) to the **camera reference system** ($\curly{u,v, (1)}$).
#### Simplified Model
>[!col]
>- Notice that optical axis is the z axis
>- Set $C=(0,0,0)$ and $P^*=(0,0)$
>- $(u,v)$ aligned with $(X,Y)$
>
>![[Pasted image 20251001111232.png|Graphical View|350]]

from here:
$$\begin{cases}
u=\displaystyle\frac{-f}{Z}X \\
v = \displaystyle\frac{-f}{Z}Y
\end{cases}
\quad\stackrel{\text{hom. coord}}\longrightarrow
 Z\begin{bmatrix}u \\ v\\ 1\end{bmatrix}=Z\begin{bmatrix}\frac{-fX}Z \\ \frac{-fY}Z\\ 1\end{bmatrix}=\begin{bmatrix}-fX \\ -fY\\ Z\end{bmatrix}=\begin{bmatrix}
-f & 0& 0 &0\\
0 & -f & 0 &0\\
0 &0 &1 & 0
\end{bmatrix}
\begin{bmatrix} X\\Y \\ Z\\ 1\end{bmatrix}$$
and we can see that $$m\approx PM$$ with P the 3x4 matrix. Note how the image is reversed ($-f$).

#### A more general model:
Forst we must **drop some assumptions:**
- Arbitrary camera position and orientation ($\theta\approx 90^\circ$ ignored for this course)
- (optional) real lenses have distortion
Define the **intrinsic parameters**
- Focal Length ($f$)
- Pixel Size in $u,v$ directions ($p_u,p_v$) and number of pixels ($k_u=1/p_u, k_v=1/p_v$)
- Position of principal point ($u_0,v_0$)
And the **extrinsic parameters**
- Camera position
- Viewing Direction

First define the 3x3 matrix $V$:
$$V=\begin{bmatrix}
-k_u & 0 & u_0\\
0 & -k_v & v_0\\
0 & 0& 1
\end{bmatrix}$$
And P will become the matrix multiplication between V and the P of the simplified model:
$$P=\begin{bmatrix}
-k_u & 0 & u_0\\
0 & -k_v & v_0\\
0 & 0& 1
\end{bmatrix}
\begin{bmatrix}
-f & 0 & 0 &0\\
0 & -f & 0 & 0\\
0 & 0 & 1& 0
\end{bmatrix}=
\begin{bmatrix}
-fk_u & 0 & u_0& 0\\
0 & -fk_v & v_0& 0\\
0 & 0& 1 &0
\end{bmatrix}$$
This matrix contain **the $K$ matrix, the intrinsic parameter matrix** that is the P without the last 0 column and contains 4 (+1 skew) **intrinsic parameters**
- $\alpha_u=fk_u=f/p_u, \alpha_v=fk_v=f/P_v$ (focal length of pixels)
- $u_0,v_0$
- ($\theta$)

>[!todo]
>Extrinsic Parameters$\rightarrow$ Full model

Finally the model has 11 degrees of freedom (5 intrinsic + 3 rotation + 3 translation).
The final image will loose some information like the correct perspective, angles, dimension and distance. However straight lines will remain straight. Notice that due to the angle loss parallel lines are not parallel anymore.
## 1.2) Real Cameras
![[Pasted image 20251006164014.png|Lens|450]]
The lens corrects the path of the rays.
- Any ray parallel to the axis proceeds towards F
- Any ray passing through the center is unchanged
- Any ray passing through F before the lens becomes parallel

If an object at distance $Z$ is at focus ad distance $Z'$ then the following relation holds:
$$\frac1{f_{tl}}=\frac1Z+\frac1{Z'}$$

If the distance is different from $Z'$ we enter the **circle of confusion** where the rays don't focus on the plane. If this circle is bigger than the pixel (cmos sensor) then we get blurring. 

A lens allow to get more light coming in.

>[!col]
>A digital camera is made of a grid of CMOS sensors. Each sensor reacts to each photon that arrived. They **do not sense wavelength**, to get colour a filter is used. E single pixel is made of 1 red 2 green and 1 blue filter on each diode (**Bayer pattern**). By interpolating the values the RGB is found
>
>![[Pasted image 20251006164743.png|CMOS|300]]

![[Pasted image 20251006165323.png|Example of Out Of Focus|350]]
Aperture and shutter speed regulate exposure, that is, how much light enters the sensor. Higher shutter speed allows for more light and therefore more motion blur.
- Shutter speed regulates the time the sensor is open in fractions of a second: $1/x$
- Aperture regulates the diameter of the pinhole expressed by focal length divided by number: $a=f/N$ it increases with $N=2$ as a sqrt of 2: $2\rightarrow 2\sqrt 2= 2.8\rightarrow 2.8\sqrt 2= 4\rightarrow ...$ This is proportional to the area and $\sqrt 2$ doubles the light coming in
![[Pasted image 20251006170348.png|Big vs Small Aperture|350]]
**Reciprocity: The same exposure is obtained with and exposure twice as long and an aperture area half as big**
$$a_1f_1=a_2f_2\rightarrow\begin{cases}a_2=a_1/2\\f_2=2f_1\end{cases}$$
## 1.3) Colorimetry TODO

# 2) Intro to Image Processing
Recall the difference between an analog and a digital image. How do we discretize the values? By sampling and quantizing!
- Sampling:
$$f(m,n)\def f(m\Delta x, n\Delta y)$$
where $\Delta x, \Delta y$ correspond to the pixel size and are the sampling period.
- Quantization:
$$f_d(m,n)=Q[f(m,n)]$$
A quantizer has $L=2^k$ levels. Each $M\times N$ image requires $b=MNk$ bits to store the data.

>[!rmk|*]
>This is greyscale, for the colors you do this three times with each rgb value. An rgb image requires thrice the space $b_{rgb}=3b=3MNk$

Images are 2D signals and therefore the frequency analysis has to be performed also in 2 dimensions.
$$
\begin{align}
F(u,v)=\int_{-\infty}^\infty\int_{-\infty}^\infty f(x,y)e^{-j2\pu (ux+vy)}dx dy \\
f(x,y)=\int_{-\infty}^\infty\int_{-\infty}^\infty F(u,v)e^{j2\pu (ux+vy)}du dv
\end{align}$$
But most importantly the discrete transforms:
$$\begin{align}
F(u,v)=\sum_{x=0}^{M-1}\sum_{y=0}^{N-1}f(x,y)e^{-j2\pi(\frac{ux}M+\frac{vy}N)}\\
f(x,y)=\frac1{MN}\sum_{u=0}^{M-1}\sum_{v=0}^{N-1}F(u,v)e^{j2\pi(\frac{ux}M+\frac{vy}N)}
\end{align}$$
However in the DFT **the transforms are discrete and periodic**

>[!thm] Fourier Transform Separability
>A 2D DFT can be computed by M 1D-DFT (one) for each column and N 1D DFT (one) for each row.
>$$F(u,v)=\sum_{x=0}^{M-1}e^{-j2\pi\frac{ux}M}\underbrace{\sum_{y=0}^{N-1}f(x,y)e^{^{-j2\pi\frac{vy}N}}}_{F'=\text{1d DFT}}=\sum_{x=0}^{M-1}F'(x,v)e^{-j2\pi\frac{ux}M}$$
>Where $F'(x,v)$ is the sum of all 1D DFT done on the Y axis.

>[!thm] Separability Theorem
>If the system allows the decomposition $h(x,y)=f(x)g(y)$ then the 2D DFT will be $H(u,v)=F(u)G(v)$

^f40d24

>[!rmk|*]
>Do not confuse the separability thm with product$\leftrightarrow$convolution property! In fact, in general if
>$$h(x,y)=f(x,y)g(x,y)\fourier H(u,v)=F(u,v)*G(u,v)$$

^5013f2

#### Quick Recap on DFT Properties
**Polar Representation:**
$$F(u,v)=|F(u,v)|e^{j\phi(u,v)}$$
**Spectrum (Magnitude):**
$$|F(u,v)|=\sqrt{\Re[F(u,v)]+\Im[F(u,v)]}$$
>[!col]
>Notice how a translation in the image doesn't change the spectrum, however a rotation changes the frequency (it rotates the spectrum)
>
>![[Pasted image 20251008160325.png|Translation and Rotation|300]]


**Phase:**
$$\phi(u,v)=\arctan\left(\frac{\Re[F(u,v)]}{\Im[F(u,v)]}\right)$$

>[!col]
>The phase contains the most info on the image
>
>![[Pasted image 20251008160811.png|Example|300]]

**Convolution/Product:**
$$f(x,y)*h(x,y)=\sum_{m=0}^{M-1}\sum_{n=0}^{N-1}f(m,n)h(x-m,y-n)\fourier F(u,v)H(u,v)$$
See also this [[#^5013f2]].

**Separability:**
See [[#^f40d24]].

**Translation To Center of The Frequency Rectangle:**
$$f(x-M/2, y-N/2)\fourier F(u,v)(-1)^{u+v}$$
In particular the power is concentrated in the lower frequencies (start and end of period), the shift allows to have the energy in the middle region.
>[!col]
>![[Pasted image 20251008155952.png|Translation Visualized|300]]
>
>![[Pasted image 20251008160119.png|Example|300]]




**Differentiation:**

**Gaussian:** (dft of gaussian is gaussian)
$$A2\pi\sigma^2e^{-2\pi^2\sigma^2(t^2+z^2)}\fourier Ae^{-(\mu^2+v^2)/2\sigma^2}$$

**Band-limited Images:**
>[!thm] Band-Limited
>A 2D signal is said to be strictly band limited if it's fourier transform is such that
>$$\begin{align}
F(u,v)=0 &\text{ for } |u|>u_{\max}\\
\text{and}\\
F(u,v)=0 &\text{ for } |v|>v_{\max}
\end{align}$$

**2D Sampling Theorem**
>[!thm] 2D Sampling Theorem
>Let $f(x,y)$ be a band limited image uniformly sampled over an orthogonal lattice with spacing $\Delta X, \Delta Y$. Then, if the sampling rate is greater than the nyquist rate, $f(x,y)$ can be reconstructed from the sampled values without any loss of information, that is
>$$F_x=\frac1{\Delta X}>2u_{\max} \text{ and } F_y=\frac1{\Delta Y}>2v_\max\implies F^{-1}(u,v)=f(x,y)$$

## 2.2) Geometric (Affine) Transforms ez TODO


## 2.3) Single-Pixel Operations
It is possible to modify each pixel on a one by one basis to change the output image.
For example an color inversion is obtained by mapping $$s=T(r)=(L-1)-r$$
Or the gamma transformation:
$$s=cr^\gamma$$
where $\gamma>1$ images get darker and $\gamma<1$ images get brighter.

The dynamic range can be adjusted via a **histogram tuning** approach:
- First compute the Probability Density Function (PDF) as $$p_r(r_k)=\frac{n_k}{MN}$$ where $n_k$ is the number of pixels with intensity $r_k$
- Map the values to the CDF $$s_k=T(r_k)=(L-1)\sum_{i=0}^k p_r(r_i)=\frac{L-1}{MN}\sum_{i=0}^k n_i$$
- Compute the PDF and CDF of the target function so that $$G(z_q)=s_k\rightarrow z_q=G^{-1}(s_k)$$

In practice the last step isn't very easy to do so just do the following:
- Compute $T(r)$ and $G(z)$ tables and find pairs $T(r_i)\rightarrow G(z_j)$, that are the ones with closest value.
- Now the final PDF is obtained by plotting the PDF value of $T(r_i)$ in the intensity $q$ of $G(z_q)$. If more than one $T(r_j)$ is assigned to the same $G(z_q)$ then just sum the PDF values and the mapping is obtained by checking what $s_k\rightarrow z_q$, that is $k\rightarrow q$.

We use a target function as a flat histogram isn't necessarily good (ex. night photo must be dark)

>[!example|*]
>Suppose to have the following image PDF
>![[Pasted image 20251014095155.png|PDF|200]]
>Now, consider also the following target PDF
>![[Pasted image 20251014095401.png|Target PDF|100]]
>By Calculating $G(z_q)$ and the CDF $T(r_k)$ it is possible to now link $s$ and $z$
>![[Pasted image 20251014095538.png|Final Tables|350]]
>And now
>
| $p_z(z_0)$ | $p_z(z_1)$ | $p_z(z_2)$ | $p_z(z_3)$ | $p_z(z_4)$ | $p_z(z_5)$ | $p_z(z_6)$     | $p_z(z_7)$         |
| ---------- | ---------- | ---------- | ---------- | ---------- | ---------- | -------------- | ------------------ |
| 0          | 0          | 0          | $s_0=0.19$ | $s_1=0.25$ | $s_2=0.21$ | $s_3+s_4=0.24$ | $s_5+s_6+s_7=0.11$ |

>[!rmk|*]
>Alternatively a graphical way can be used:
>![[Pasted image 20251015150637.png|Example|550]]

# 3) Edge Detection
The task of edge detection is to **extract relevant features from the images**, the could be edges, isolated points, corners, etc. 

#### Quick Math Recap
Derivative of discrete signal:
$$f_x=\frac{\partial f}{\partial x}=f(x+1)-f(x)$$
This is actually the derivative at $x+1/2$ (the connection between two points).
Or also, to have the derivative at x we can center it. Notice how we loose resolution
$$f_x=\frac{\partial f}{\partial x}=\frac{f(x+1)-f(x-1)}{2}$$
And the second order derivative is:
$$f_{xx}=\frac{\partial^2f}{\partial x^2}=f(x+1)+f(x-1)-2f(x)$$

Differential operators:
$$\begin{align}
&\text{Gradient: }\nabla=[f_x,f_y]\\
&\text{Gradient Module: }M=|\nabla|=\sqrt{f_x^2+f_y^2}\\
&\text{Laplacian: } f_{xx}+f_{yy}
\end{align}$$
To approximate a laplacian it is possible to use a mask filter:
![[Pasted image 20251029144623.png|Laplacian Filter Mask|200]]
![[Pasted image 20251029144806.png|Example: Image, Laplacian, Threshold|300]]
## 3.2) Edges
There exist many types of edges:
![[Pasted image 20251029144906.png|Edges|300]]
Derivatives are able to detect many different informations:

|                    | 1st Order    | 2nd Order             |
| ------------------ | ------------ | --------------------- |
| Large Values       | All the edge | Start and end of edge |
| Response Type      | Single       | Double                |
| Response Thickness | Thick        | Thin                  |
| Noise Sensitivity  | Moderate     | High                  |

Notice that derivatives (especially 2nd order) are sensitive to noise
![[Pasted image 20251029145758.png|Example: Noise Sensitivity|150]]

To find an edge therefore the gradient is used.
$$M=|\nabla f|=\sqrt{f_x^2+f_y^2}\approx|f_x|+f_y|$$
and the edge exists if $M>T$ with T a threshold.

Instead of using the standard derivative FIR, we use the **sobel filter**
![[Pasted image 20251029150247.png|Sobel Filter|350]]
Which is more robust to noise, centered on the pixel and gives more relevance to close locations. However, as with the second 1st order derivative approach, this is not too precise

>[!rmk|*]
>The gradient is perpendicular to the edge!

With a low pass filter, the noise is attenuated, then by applying sobel a better edge detection is obtained (some information loss).
 3 steps:
 1) Low pass filter the image: $f\rightarrow f^{lp}=h^{lp}*f$
 2) Compute radient: $\nabla f$
 3) Threshold the module: $f=\begin{cases}|\nabla f| &\text{ if }|\nabla f|>T\\ 0 &\text{ elsewhere}\end{cases}$

This **does not precisely locate edge points** but generally recognizes edges correctly.

Optimal: Low $t_l$ propagates the edges and high $T_h$ detects more

# 4) Corner Detection
The difference between a corner and an edge is that if we take an area around the corner and move it parallel to the edge, the content inside the box remains identical, while for a corner, independently of the direction of movement, the content changes
![[Pasted image 20251105143908.png|Example|450]]
What are the targeted properties for a corner detection?
- Accurate localization
- Invariance wrt shift, rotation, scale and brightness change
- Robust against noise
- High repeatability

Many approaches exist but we will see just 2:

## 4.1) Harris Corner Detector
This approach works in 3 steps:
- Analyze gradient of image to detect response to any shift
- Eigenvalue decomposition to get orientation of change and distinguish corner and edges
- Detect corner by comparing eigenvalues with a threshold (or also with trace/determinant)

![[Pasted image 20251105144638.png|TODO This Proof|350]]
Change in intensity for a shift of ($\Delta x,\Delta y$) at location ($x_i,y_i$). MSE of i of window and shifted window.

The two resulting eigenvalues and eigenvectors are:
- $\lambda_1,v_1$ is the strength of response in direction of max change
- $\lambda_2,v_2\perp v_1$ is the strength of response in direction perpendicular to edge
 
 If both are large it is a corner (change in both directions), if one is large and the other not, it is an edge, while if both are small it is an interior point.

A faster computation is done via traces and determinants
$$R(x,y)=\det M(x,y)-k\curly{tr M(x,y)}^2=\lambda_1\lambda_2+k(\lambda_1+\lambda_2)^2$$
Where 
$$\begin{align}
\det M(x,y)=AB-C^2=\lambda_1\lambda_2\\
tr M(x,y)=A+B=\lambda_1+\lambda_2\\
k\approx 0.05\text{ small value}
\end{align}$$
And thus 
$$R_(x,y)\begin{cases}
\gg0&\text{ corner}\\
\ll0&\text{ edge}\\
\approx0&\text{ uniform region}\\
\end{cases}$$
This method is 
- Invariant to constant brightness offset
- Invariant to shift and rotation
- NOT invariant to complex illumination effects
- NOT invariant to scaling as seen in the image below

![[Pasted image 20251105151010.png|Non Scaling Invariant|350]]
## 4.2) FAST Corner Detection
Fast uses a circle of N pixels and a pixel at the center $p$. There is a corner if there is a **continuous** arc ($S$) of $n$ pixels (usually $\frac34N$) in the circle that are brighter OR darker than $p$, that is:
$$\forall x\in S:I_x>I_p+T\text{ or } \forall x\in S:I_x<I_p-T$$
![[Pasted image 20251105153035.png|FAST Example|350]]
In this case from 1 to 12 ($12=\frac34 N=\frac34\cdot 16$) are all brighter than $p$ and therefore $p$ is an edge.
Typical values are circles of $N=16$ pixels and $n=12$ as in the example.

This approach, as the name suggests, is very fast. There is fast rejection method called Rapid Rejection, which only holds up well with $N=16$. This method consists in only analyzing the 4 pixels on opposite sides of the circles and 3 of them must satisfy the intensity constraint.

It is invariant to:
- Rotation
- Illumination shift
- Translation

But as before it is not invariant to scale changes. Moreover many corners tend to be clustered together.

# 5) Hough Transform

# 6) Scale Invariant Feature Transform (SIFT)

Use [[Intro to ML#2.1) Cost Minimization Algorithm k-Means Clustering]] for a recap on k means clustering

gaussian kernel function
- $k(x)\stackrel\infty\rightarrow 0$
- radial symmetry
- is a pdf so int =1
