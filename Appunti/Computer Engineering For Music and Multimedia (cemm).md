# 1) Acoustics and Psychoacoustics
ANSI/ASA describes acoustic as **science of sound including production, transmission and effects, including biological and psicological effects. The qualities of a room together determine the character wrt adutiroy effects**

The wave equation is:
$$\frac{\partial ^2p}{\partial x^2}-\frac1{c^2}\frac{\partial p}{\partial t^2}=0$$
where $p$ is the pressure and $c$ the speed of sound.
The general solution ( with $c$ constant)
$$p=f(ct-x)+g(ct+x)$$
with $f,g$ twice differentiable functions

Recall the fundamental properties of waves:
$$\lambda =\frac vf\quad f=\frac1T$$

Each periodic signal can be decomposed into a series of simple periodi cwaves called harmonics. The set of all harmonics is called the spectrum:
$$f(t)=\frac{a_0}2+\sum_{n=1}^Na_n\cos(nt)+b_n\sin(nt)$$
For periodic waves, the partials are integer multiples of the fundamental frequency $f_0$.

A standing wave is a wave where the peaks (max/min) and nodes (zero) do not change position over time.

For auditory communications we have:
- Source: vibrating object with energy injected to it
- Medium: allows for sound propagation
- Receiver: ear-brain transforms acoustic pressure into neural impulses

**The warmer a medium the faster the sound**. Steel has the fastest propagation. It propagates the fastest in solids, then liquids then gasses. In air at 0 C it is 331.5 m/s, at 20 C it is 344 m/s

There are three domains of acoustics based on where the sound lives: Air, ear, brain:
![[Pasted image 20260305143943.png|3 domains|450]]
The brain might trick us:
- Shepard tones: seemingly infinite increase in pitch
- Aural harmonics as integer multiple of original tone
- Tartini's third note: play a perfect fifth, the brain will hear a third note one octave below (perfect fifth is $f_2=\frac32 f_1\rightarrow \Delta f=\frac12 f_1$)


Beats are a **amplitude modulation** phenomenon that allows two similar tone to be perceived as one beating tone. The beat frequency is $f_b=\Delta f$

#### Auditory System TODO


#### Elements of Psychoacoustics
The perceived loudness of a sound depends on different factors not only on intensity. 
The unit of measure for loudness is Phon 

The acoustic pressure $p$ is derived from the velocity $v$ of the particles. Intensity is the power per unit area $I\sim p^2$. The scale is the decibel.
We define the base reference intensity as the minimum sound intensity that can be heard by a normal hearing person.
$$I_0=10^{-12}\unit{\frac W{m^2}}\qquad p_0=2\cdot 10^{-5} \unit{Pa}$$

$$ dB=10\logt\par{\frac I{I_0}}=20\logt\par{\frac{p}{p_0}}$$
**Doubling intensity means +3dB, doubling pressure is +6 db** since $log(2)\approx 0.3$

We do not hear all sound equally however:
![[Pasted image 20260512181324.png|Example|350]]
At 10 dB we hear 5kHz but not 50 Hz. A curve was empirically derived.

Also the **equal loudness curve** was defined, that **given a frequency tells you what pressure it should have to match the pressure of a 1 kHz sinusoid with 1000 pressure**. This is the **Phon scale**

The **sone scale** is used to describe relationships with sound of different loudness values. **A doubling of loudness is 10 phon.**
$$phon=40+10\log_2(sone)\qquad sone = 2^{\frac{phon}{10}-4}$$

**Volley Theory:** groups of neurons of the auditory system respond to a sound by firing action potentials slightly out of phase with one another so that, when combined, a greater frequency of sound can be encoded and sent to the brain to be analyzed

One octave is double the frequency, there are 12 semitones:
$$s^{12}=2\qquad s=\sqrt[12]2$$
# 2) Elements of Acoustics
Science of sound including production, transmission and effects. Also the qualities of a room that determine the character wrt auditory perception.

Wave equation:
$$\frac{\partial ^2p}{\partial x^2}-\frac1{c^2}\frac{\partial p}{\partial t^2}=0$$
The general solution (c constant)
$$p=f(ct-x)+g(ct+x)$$
with $f,g$ twice differentiable functions

Sound waves are transversal waves and create a **disturbance** since they move adjacent particles

infrasound $<20$ Hz
audible 20Hz - 16 kHz
ultrasound $>16$ kHz

Decibel:
$$dB=10\log(S_1/S_2)$$
Timbre:
perception of sound quality

Chladni Plates: nodal line is where there is no perturbation

Todo
Reverberation

There are three domains of acoustics based on where the sound lives: Air, ear, brain:
![[Pasted image 20260305143943.png|3 domains|450]]

#### Loudness
Perceived intensity (brain) of a sound depends on several feature of the signal. In fact we perceive equal loudness for different frequencies at different intensities
![[Pasted image 20260305151824.png|Perceived Sound|350]]

We measure sound intensity as acoustic pressure in dB with base reference intensity $I_0=10^{-12} W/m^2$ or reference pressure $p_0=2 \cdot 10^{-12}$Pa. In dB we have
$$SPL=10\log_t(I/I_0)=10\logt(p/p_0)$$
Doubling the intensity means +3dB. Doubling the acoustic pressure means +6dB

# 3) Audio Archives Preservation
Preservation of archives is essential as carriers degrade quickly while playback devices and knowledge are fast obsolete.

**Traditional preservation paradigm:** Preserve original

This paradigm however does not take into account the deterioration of the media and the machines used to play them

The digitization process was not considered a good solution for preservation, but it had only an access-oriented value. The rapid growth of computer sciences quickly led to the obsolescence of technologies, that had a short lifetime expectation. 
As digitization assumed more importance (better performance, birate, ecc) and started to be considered a good way to store information.

In acoustic music (or speech recordings) the carrier only acts as a container of the artwork, not part of it.
In electroacoustic music however the carrier coincides with the artwork: the carrier is the witness of the process.

#### Preservation vs Restoration
Physical degradation of the carrier can be slowed down (but not stopped) with good preservation strategies.

Preservation consists in keeping the original acoustic information and carriers. There are two types of preservation
- Indirect: operating on the environment in which the audio document is stored.
- Direct: operating on the carrier itself with procedures for the stabilization of its physical conditions, without causing an alteration of the structure and the composition

Restoration is the process of recovering the original information from a degraded carrier, possibly through digitalization.

#### Incision Based Carriers
The Phonographic Disc is the first carrier standardized for audio preservation. This immediately led to problems (also future formats)
- From the standard, a disc should be run at 78 RPM. However due to different voltages (60 Hz vs 50Hz) the disc runs at slightly different speeds (78.26 vs 77.92 RPM)
- Disc is prone to degradation. The diamond needle slightly scratches the disc at every run so after a dozen listens the disc is damaged. Dust and scratches also damage the listening experience (crackle sound)
- They introduced a equalization. High frequencies are boosted, therefore an eq curve is needed to return a flat profile

#### Magnetic Based Carriers
These range from tapes to cassettes.

The first was the Open-Reel Tape (30's) and had various diameters and speeds.
In general the magnetic tape works as follows:
![[Pasted image 20260319151744.png|Tape|350]]
**Vinegar Syndrome:**
Humidity and temperature affect the acetic acid which degrades and damages the tape.

**Soft Binder Syndrome– Sticky Shed Syndrome (SBS-SSS)**
Deterioration of magnetic tape binder. The binder polymers used in magnetic tape
constructions are subject to a **chemical process known as hydrolysis**. In this process,
**long molecules are broken apart** by a reaction with water to produce shorter molecules.
The **shorter molecules do not impart the same degree of integrity** to the binder system
as do the longer molecules

This can be solved by baking (in the oven) at max 50-60°C for 1h up to 8 hours. However a wrongly baked tape can be irreparably damaged.

# 4) Midi
