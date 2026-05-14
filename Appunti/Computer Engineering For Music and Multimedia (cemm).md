This document is meant to be used in the following way. Each chapter is a brief recap of what was in the slides. **Take Home Concepts** is a list of concepts recapped at the end of the slides while **Stuff to Know** is what is listed under the # Open-ended exam questions. The **Quiz** part contains the quizzes he uploaded with solutions and explanations.

# 1) Acoustics and Psychoacoustics
ANSI/ASA describes acoustic as **science of sound including production, transmission and effects, including biological and psicological effects. The qualities of a room together determine the character wrt adutiroy effects**

## 1.1) Acoustics
The wave equation is:
$$\frac{\partial ^2p}{\partial x^2}-\frac1{c^2}\frac{\partial p}{\partial t^2}=0$$
where $p$ is the pressure and $c$ the speed of sound.
The general solution ( with $c$ constant) is a **longitudinal** wave
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

![[Pasted image 20260513155125.png|Table|350]]

There are three domains of acoustics based on where the sound lives: Air, ear, brain:
![[Pasted image 20260305143943.png|3 domains|450]]
The brain might trick us:
- Shepard tones: seemingly infinite increase in pitch
- Aural harmonics as integer multiple of original tone
- Tartini's third note: play a perfect fifth, the brain will hear a third note one octave below (perfect fifth is $f_2=\frac32 f_1\rightarrow \Delta f=\frac12 f_1$)
- Missing Fundamental: If the fundamental is removed from a harmonic spectrum, it is heard all the same


Beats are a **amplitude modulation** phenomenon that allows two similar tone to be perceived as one beating tone. The beat frequency is $f_b=\Delta f$

## 1.2) Auditory System TODO
The ear is divided into external, middle and inner ear.

The inner ear contains the **cochlea** 

The **basilar membrane** is **narrow-rigid at the base, wide-soft at the apex**. This is a bank of filters tuned at specific vibrations.
Low at base, high at apex.
It is non-linear $\rightarrow$ additional aural harmonics
## 1.3) Elements of Psychoacoustics
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
**Localization Theory:** pitch changes based on where maximum is in membrane
**Temporal theory:** pitch depends on temporal pattern of firing

One octave is double the frequency, there are 12 semitones:
$$s^{12}=2\qquad s=\sqrt[12]2$$

But our brain looses to distinguish the double frequency as an octave at high frequencies and  needs more frequency

**Critical bands** are used to quantify the ability of the human ear to distinguish between individual frequency tones. The human ear can hear from 20 to 20,000 Hertz, but the ability to distinguish individual tones varies as a function of frequency.
![[Pasted image 20260513152645.png|Log Cochlea Scale|250]]

This is given from the **cochlea** as it has a logarithmic spiral shape. The tones are therefore not distinguished but percieved as modulating or beating. These bands decrease in bandwidth as the intensity increases.

![[Pasted image 20260513152710.png|Example|250]]
These bands are described via the **bark** scale. That is the distance of 1 CB is 1 bark.

**Masking** happens when a sound of higher intensity masks a sound of lower intensity. A pure tone can be masked with:
- +17 dB white noise up to 1 kHz
- linear grow after 1kHz
It can also be masked with another pure tone

## 1.4) Take Home Concepts
- **Basilar membrane** (auditory filters, tonotopic mapping): 
	- **Auditory Filters:** The basilar membrane is narrow and rigid at its base and wide and soft at its apex, which allows it to act as a bank of filters tuned to different frequency bands.
	- **Tonotopic Mapping:** This spatial arrangement creates a mapping where high frequencies produce maximum vibrations at the base and low frequencies produce them at the apex.
- **Nonlinearities in the BM** (difference tones, Tartini's 3rd sound)
	- **Difference Tones:** When two sine tones are played loudly enough, the ear’s nonlinear distortion creates additional "difference tones" at frequencies like $(x-y)$ or $(2y-x)$.    
	- **Tartini's 3rd Sound:** This specific phenomenon occurs when two notes (like a perfect fifth) are played; the listener perceives a third, lower note produced by intermodulation distortion in the ear.
- **Loudness perception** (threshold of hearing, equal-loudness curves, loudness scales – phons and sones)
	- **Threshold of Hearing:** This is the minimum sound pressure level required for a sound to be just audible, which varies significantly depending on the frequency of the stimulus.
	- **Equal-Loudness Curves:** These curves (ISO 226:2003) describe the physical intensity needed for sinusoids of different frequencies to be perceived as having the same loudness as a reference 1 kHz tone. 
	- **Loudness Scales (Phons and Sones):** The **Phon** scale matches the perceived loudness of any tone to the decibel level of an equally loud 1 kHz sinusoid, while the **Sone** scale is a linear scale where a doubling of loudness corresponds to an increase of 10 phons.
- **Pitch perception** (sinuoidal/harmonic/inharmonic sounds, pitch scales – mel)
	- **Sound Types (Sinusoidal/Harmonic/Inharmonic):** Pitch perception varies by source: pure sinusoids have a clear height, harmonic sounds can maintain a "virtual pitch" even if the fundamental frequency is missing, and inharmonic sounds (like bells) may have unclear or complex pitch sensations.
	- **Pitch Scales (Mel):** The **Mel** scale is a perceptual scale that maps physical frequency to "ratio pitch," where doubling the mel value corresponds to a perceived doubling of pitch.
- **Masking and critical bands** (masking thresholds critical bandwidth, auditory filterbank, bark scale)
	- - **Masking Thresholds:** This is the sound pressure level a test signal must reach to become just audible in the presence of a louder "masking" signal.
	- **Critical Bandwidth:** The human ear processes sound through "hearing bands" created by the cochlea; if two tones fall within the same critical band, they are difficult to distinguish and may result in "beating" or "roughness"
	- **Auditory Filterbank:** This concept treats the ear as a series of overlapping filters that quantify our ability to distinguish individual frequencies.
	- **Bark Scale:** The Bark scale is a psychoacoustic scale ranging from 1 to 24 that represents these discrete critical bands across the entire audible frequency range.

## 1.5) Stuff to Know
- Definition of Period, Frequency, velocity, wavelength, Standing waves 
- Description of the human ear
- Sound Intensity: Decibel, Phon, Sone.
- Pitch
- Critical band, beating.
- Masking


# 2) Sound Synthesis & Sound Design
## 2.1) Sound Analysis
Sound is analyzed in the frequency domain which is consistent on how the human ear perceives sound. The characteristics of the sound can be better seen (high/low frequencies, harmonic vs non harmonic partials). Moreover **some filters are efficient in frequency domain**

We use the Discrete Fourier Transform (DFT)
$$X(k)=\sum_{n=0}^{N-1}x(n)e^{-j\omega_kn}$$
In computers this is implemented via the Fast Fourier Transform (FFT)
From N samples in the time domain we get N samples in the frequency domain.
For better understanding see [[DSP 2#5.3) Fast Fourier Transform (FFT)]].

Each value of the FFT is called **bin** and represents the amplitude of a frequency of $f_s/n$ Hz where $f_s$ is the sampling frequency and $n$ the size of the FFT. Since the DFT is periodic only the first $0-f_s/2$ bins have an utility.

If the FFT is bigger than the signal, zero padding is used.

Also the Short Time Fourier Transform (STFT) is used to analyze **time varying signals**. STFT has a compromise. $N$ is the window length: **bigger N implies better frequency resolution but worse time resolution** this is called the **uncertainty principle**. Also here see [[DSP 2#5.3) Fast Fourier Transform (FFT)]]. 

To get a frequency response of a room we can find the Room Impulse Response (RIR) by recording the sound that a balloon makes in the quiet room. Since the balloon can be considered as a dirac delta:
$$y[n]=(h*\delta)[n]=h[n]$$
## 2.2) Classification of Sound Models
Various classifications of sound exist based on specific needs

#### Classification Based on Model Structure
This is based on **how the sound was generated**
- **Direct Generation:** techniques based on one or more independent blocks and sum of the results: **Additive and granular synthesis**
- **Feed Forward Structure:** feed forward multi block structure (lot of post processing): All non linear models **subtractive synthesis, ring and frequency modulation synthesis**
- **Interacting Structure:** interacting multi block (feedback). Most physiscs based models

#### Classification Based on Cognitive Representation
This is based on **what the model aims to represent**
- **Signal Based Models:** Represents shape of wave, the acoustic perception **ignoring the underlying physical model**. The focus is on receiver and human ear
- **Physics Based Model:** Represents acoustic signal as by product of physical mechanism of the production of the sound. Focus on emitter, sound source.

#### Classification Based on Underlying Techniques
These are based on the **processing domain**. 
- **Time Domain Models:** based on time characteristics
- **Frequency Domain Models:** based on spectral characteristics

Filters are **linear** transformations, Modulation is a **non linear** one. 
The processing is either on **sample basis** or most commonly on **block processing**, that is, N samples analyzed at a time like with FFT.
These can be done via **hardware or software**

## 2.3) Time Domain Model Synthesis
This is a signal based approach. A characteristic of a musical sound is its complex dynamic behavior. Depends on external control and internal structure and generating process

#### Basic Generators
This produces a simple signal from a given data. The basic ones are oscillators for periodic signals and noise generators for random signals.

##### Table Lookup Oscillator
An oscillator generates a simple periodic waveform. Instead of calculating this waveform, rather a lookup table with equidistant samples of the sound to generate is used. This is then amplified $a[n]$. Therefore: $s[n]=a[n]f[n]$

This is low quality approach as it lacks timbre and more complex modulations

##### Noise Generator
Natural sounds are not perfectly periodic. They contain varying statistical properties therefore a noise generator is required. 
Noise generator produces a sequence of random sounds with however clear statistical properties (flat spectral density)

### 2.3.2) Time-Segment Based Models
#### Sampling (Wavetable) Synthesis
This technique consists is sampling real sounds and then processing and playing them.
Some easy processing is speeding up the sound which heightens the pitch. But this has a bad effect. It lacks **prosodic** rules, which is the ability to modify the sound on the go with dynamics, vibratos etc.
#### Granular Synthesis
Granular synthesis consists in dividing sounds into **grains;** small windows of acoustic elements in time domain. The mixing of these grains can recreate a complex sound. This was born from tape music.

From real sounds the grains are obtained by taking slightly overlapping windows to allow for both reproduction of the sound and the extraction of grains.

When segments are not very short we call it **synthesis by time segment processing**.

A second approach is the **micro-granular synthesis** which defines the grains as a windowed sinusoidal signal.

## 2.4) Frequency Domain Model Synthesis
#### Additive Synthesis
Created by superimposing elementary sounds (sine waves).

# 3) Subtractive Synthesis

#### Ring Modulation

#### Frequency Modulation

# 4) Live Electronics

# 5) Audio Archives Preservation
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

# 6) Pure Data TODO
PD is a cross platform open source real time dataflow program environment
![[Pasted image 20260514104835.png|PD|200]]
# 7) Midi TODO


# 8) Quiz
## 8.1) Acoustics and Psychoacoustics

| **Question**                                                                                 | **Possible Choices**                                                                                                                                              | **Answer** | **Explanation**                                                                                                                                  |
| -------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| At which frequency is the human ear most sensitive among these values?                       | 1. 20 Hz<br>2. 100 Hz<br>3. 2000 Hz<br>4. 20000 Hz                                                                                                                | 3          | The human ear is most sensitive between 2000 and 5000 Hz, a range critical for speech. Extreme frequencies require higher intensity to be heard. |
| What is the term for the smallest change in frequency that can be detected by the human ear? | 1. Pitch<br>2. Timbre<br>3. Just noticeable difference (JND)<br>4. Resonance                                                                                      | 3          | JND is the threshold where physical change becomes perceptible. Pitch is the perception of frequency, and timbre is sound quality.               |
| What is the threshold of hearing for the average human?                                      | 1. 0 dB<br>2. 20 dB<br>3. 40 dB<br>4. 60 dB                                                                                                                       | 1          | 0 dB is the standard reference for the minimum sound pressure audible to a healthy ear at 1000 Hz.                                               |
| Frequency modulation in the cochlea is primarily used to:                                    | 1. Adjust pitch<br>2. Amplify soft sounds<br>3. Protect from damage<br>4. Encode frequency                                                                        | 4          | The cochlea acts as a frequency analyzer, converting vibrations into neural signals to encode spectral info for the brain.                       |
| The basilar membrane in the cochlea is known for:                                            | 1. Constant thickness/stiffness<br>2. Incr. thickness/Decr. stiffness (apex to base)<br>3. Decr. thickness/Incr. stiffness (apex to base)<br>4. Uniform stiffness | 3          | The membrane is narrow/stiff at the base (high freq) and wide/flexible at the apex (low freq), allowing for tonal decomposition.                 |
| The term 'critical band' refers to:                                                          | 1. Frequency group within which ear cannot distinguish tones<br>2. Middle ear response<br>3. Max amplitude tolerated<br>4. Smallest freq increment                | 1          | If two tones fall within the same critical band, they interfere and the auditory system cannot resolve them individually.                        |
| The term 'tonotopy' refers to:                                                               | 1. Intensity mapping<br>2. Spatial arrangement of frequency in cochlea<br>3. Temporal sequence<br>4. Neural synchronization                                       | 2          | Tonotopy is the spatial organization where specific frequencies stimulate specific points along the cochlea and nervous system.                  |
| What is the role of the outer hair cells in the cochlea?                                     | 1. Transmit sound to brain<br>2. Act as microphones<br>3. Protect inner cells<br>4. Improve frequency resolution                                                  | 4          | They act as a "cochlear amplifier," physically changing shape to sharpen membrane vibration, improving sensitivity and selectivity.              |
| In which medium does sound travel the fastest?                                               | 1. Air<br>2. Water<br>3. Steel<br>4. Vacuum                                                                                                                       | 3          | Sound travels fastest in solids due to high molecular rigidity. It cannot travel in a vacuum as there is no medium.                              |
| True or False: Sound waves are longitudinal waves.                                           | 1. True<br>2. False                                                                                                                                               | 1          | In fluids like air, sound travels as longitudinal waves where particles oscillate parallel to the direction of wave propagation.                 |
| True or False: Higher frequencies have longer wavelengths.                                   | 1. True<br>2. False                                                                                                                                               | 2          | Frequency and wavelength are inversely proportional ($v = f \cdot \lambda$); higher frequencies result in shorter wavelengths.                   |
| True or False: Frequency determines loudness.                                                | 1. True<br>2. False                                                                                                                                               | 2          | Frequency determines pitch (high/low). Loudness is determined by the amplitude of the wave and sound pressure level.                             |
| True or False: Frequency determines speed.                                                   | 1. True<br>2. False                                                                                                                                               | 2          | Speed depends only on the physical properties of the medium (temperature, density). All frequencies travel at the same speed in one medium.      |
| What is the speed of sound in dry air at 20°C?                                               | 1. 343 m/s<br>2. 434 m/s<br>3. 440 m/s<br>4. 3430 m/s                                                                                                             | 1          | 343 m/s is the standard value for air at room temperature. 440 Hz is a musical pitch reference, not a speed.                                     |
| What is the unit used to measure frequency?                                                  | 1. Decibels (dB)<br>2. Hertz (Hz)<br>3. Pascals (Pa)<br>4. Newtons (N)                                                                                            | 2          | Hertz (Hz) measures cycles per second. dB measures intensity, Pa measures pressure, and N measures force.                                        |
| What is the unit used to measure sound intensity level?                                      | 1. Decibels (dB)<br>2. Hertz (Hz)<br>3. Watts<br>4. Pascals (Pa)                                                                                                  | 1          | Decibels are logarithmic units expressing the ratio of a physical quantity to a reference level, matching human perception.                      |
| What property of a sound wave determines its pitch?                                          | 1. Amplitude<br>2. Frequency<br>3. Wavelength<br>4. Speed                                                                                                         | 2          | Pitch is the psychological perception of frequency; more cycles per second result in a "higher" perceived sound.                                 |
| What property of a sound wave determines its timbre?                                         | 1. Amplitude<br>2. Frequency<br>3. Wavelength<br>4. Shape of the wave                                                                                             | 4          | Timbre is determined by the waveform's complexity (harmonics), allowing us to distinguish different instruments.                                 |
| What type of wave is sound?                                                                  | 1. Transverse<br>2. Longitudinal<br>3. Electromagnetic<br>4. Mechanical                                                                                           | 2          | Sound is a mechanical wave, and "longitudinal" describes the particle motion being parallel to the path of the wave.                             |
## 8.2) Sound Synthesis & Sound Design
| **Question**                                                         | **Possible Choices**                                                                                          | **Answer** | **Explanation**                                                                                                                                                               |
| -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| In what does granular synthesis divide the sound?                    | 1. Frequencies<br>2. Waveforms<br>3. Tiny  particles/fragments in time domain<br>4. Partials                  | 3          | Granular synthesis deconstructs sound into microscopic snippets (grains) in the time domain. It doesn't look at individual partials or abstract waveforms until reassembly.   |
| What are physical sound models primarily concerned with?             | 1. Environmental effects<br>2. Simulating physical mechanisms<br>3. Perceptual aspects<br>4. Granular effects | 2          | Physical modeling focuses on the mathematical laws of physics governing how an object (like a string or tube) produces sound, rather than just mimicking the output wave.     |
| What can nonlinear distortion and ring modulation change?            | 1. Frequency<br>2. Spectrum<br>3. Both frequency and spectrum<br>4. None                                      | 3          | These processes create new frequencies (sidebands/harmonics) not present in the original signal, fundamentally altering both the frequency content and the harmonic spectrum. |
| What do hybrid models combine in sound generation?                   | 1. Time domain models<br>2. Frequency domain models<br>3. Both time and frequency domain<br>4. None           | 3          | Hybrid models leverage the advantages of both time-domain (like physical modeling) and frequency-domain (like additive synthesis) processing to create complex textures.      |
| What does granular synthesis specifically divide sound into?         | 1. Partials<br>2. Grains<br>3. Waveforms<br>4. Beats                                                          | 2          | The "grain" is the fundamental unit of this synthesis. Partials belong to additive synthesis, while beats refer to rhythmic or amplitude interference patterns.               |
| What involves separation into sinusoidal and noisy components?       | 1. Subtractive synthesis<br>2. Additive synthesis<br>3. Spectral Modeling Synthesis (SMS)<br>4. FM synthesis  | 3          | SMS models sound as a deterministic part (sinusoids) and a stochastic part (residual noise). Additive synthesis only deals with the sinusoidal components.                    |
| What is the main focus of physical sound models?                     | 1. Transformation<br>2. Synthesis<br>3. Simulation of physical mechanisms<br>4. Signal processing             | 3          | While used for synthesis, the defining goal is simulating the mechanical or physical source of the sound (the "instrument") rather than the resulting signal.                 |
| Which method is specifically used for voice compression?             | 1. Additive synthesis<br>2. FM synthesis<br>3. Subtractive synthesis<br>4. Linear Predictive Coding (LPC)     | 4          | LPC models the human vocal tract. It is efficient for compression because it transmits the parameters of the vocal filter rather than the full audio waveform.                |
| Which model emphasizes the shape of the sound wave reaching the ear? | 1. Live electronics<br>2. Signal-based model<br>3. Frequency domain<br>4. Time domain                         | 2          | A signal-based model focuses purely on the resultant acoustic waveform and its characteristics as it arrives at the listener's ear.                                           |
| Which synthesis method is complementary to additive synthesis?       | 1. Subtractive synthesis<br>2. FM synthesis<br>3. Granular synthesis<br>4. Spectral Modeling                  | 1          | Additive "builds" sound by adding sine waves (bottom-up), while subtractive "shapes" sound by filtering frequencies out of a complex source (top-down).                       |
