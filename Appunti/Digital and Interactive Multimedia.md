# 1) Human Visual System
## 1.1) Human Eye
The main parts of the human eye are:
- Cornea: refraction (2/3)
- Sclera: outer wall of eye
- Iris: size of opening of pupil
- Pupil: amount of light
- Ciliary muscle: eye focus mechanism
- Eye lens: final part of refraction
- Retina: photosensitive detectors (rods low level, cones color)
- Fovea: retina with max density of cones
- Optic nerve: sends input to brain: this part is a blind spot in the eye (no cones or rods)

Retina response is based also on surrounding context:
- rods/cones adjust based on luminosity
- surrounding receptive field

When we change point of focus the eye performs two actions:
- Accommodation: ciliary muscle contracts/lengthens in order to move lens and change focal point
- Vergences: the eyes rotate to look at the same point in 3D space

#### Monocular Depth Indicators (exam)
Monocular depth indicators are also called cues:
Static:
- occlusion
- relative dimensions
- textures
- linear/aerial perspective
- shadows
Dynamic (video):
- motion parallax: before fixation point moves opposite way
- relative angular velocity
- shadow movement
- radial expansion

#### Binocular Vision
In order to have binocular perception, three phases occur:
- Simultaneous perception of both images
- Fusion: combine two retinal images (can be tiring if it changes too much)
- Stereopsis: perceive depth form disparity

The visual fields of the two eyes are reciprocally linked: one retinal area of the right eye corresponds to another of the left eye in a homologous position
![[Pasted image 20261018172206.png|example|350]]
The horopter includes all the points in space whose images fall on corresponding retinal points, for a given angle of convergence $\beta$. The area around it is called Panum area. In this area we can correctly apply the fusion: content must be created to be in panum.

We have a dominant eye, we see what this eye sees with depth information from other eye

Stereograms simulate disparity on one single image, allowing our eyes to still detect the depth
## 1.2) Image Formation
#### Weber's Law TODO
Weber's Law (TODO) Scaling every intensity by the same factor does not change the relative perceptual contrast.

#### 2D Image Formation
An image is a 2d function of brightness, which is given by illuminance and reflectance.
$$f(x,y)=i(x,y)r(x,y)$$
Digital images are obtained by sampling and quantizing the values of this function. This becomes a $M\times N$ matrix

An image loses some information:
- temporal evolution
- rapid changes
- dynamics
- depth

#### 3D Display Types
Auto stereoscopic display: 3d with no glasses

**Microlens screens**
Foil of semi cylindrical lenses on top of display
- The surface of the panel coincides with the focal plane of the lenses
- The lenses diffract the light and send it in the desired direction: for each microlens the eyes see two different sets of pixels.
This has significantly lower res

![[Pasted image 20261018174754.png|Example|250]]

**Parallax barrier screens:**
Add electro-optical panel with equally spaced thin vertical slits on top of display
![[Pasted image 20261018174816.png|Example|250]]
this however reduces brightness, less horizontal definition, specific distance and viewing angle

**Passive 3D glasses:**
- Anaglyph: red and blue filter. The image is the superimposition of red and green image, poor colour quality
- Dolby 3D: glasses with no polarization but colour filter, poor colour info. advantage of the fact that red, green, and blue can be defined differently to isolate the image for each eye in a stereoscopic presentation.
- Polarized Light: horizontal/vertical polarization. Also clockwise/counterclockwise circular polarization to be independent of viewing angle. Each projector is equipped with a filter that polarizes the light so that the two light signals reflected by the screen are orthogonally polarized. A special screen (silver screen) maintains the polarization of the projected images and compensates for the loss of light.

**Active 3D glasses:**
- Active shutter: shutter of r/l lens is synced with display to see only r or l view
- Xpand3d: ir projected on audience so to synchronize dimming with no special display