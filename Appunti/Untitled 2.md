![[Pasted image 20250107182953.png]]
The problem isn't hard by itself, but I don't understand some key concepts on source/signal and T0/TA

a) By the definition of $F=\frac{p_{w,out}}{p_{w,out}^S}=\frac{p_{w,out}}{p_{w,out}^S}\frac{P_{s,in}g}{P_{s,in}g}=\frac{SNR_i}{SNR_o}$ I can conclude that $SNR_i=46dB=39810$.
From here $P_{s,in}=SNR_iP_{w,in}=SNR_ikT_0B=-81dBm$.
This gives the correct result but I don't understand why I had to use $T_0$ and not $T_A=T_0(F_A-1)$
I would say that I used $T_0$ since I'm looking before the noise is applied (I already counted the noise contribution with $F_A$)

b) $M_v=\int_B\mathcal P_vdf=Z\int_Bp_v=ZP_v$
Here $P_v$ is the electric power of the source and I would calculate it as $SNR_ikT_AB$

If I were to imagine the circuit I would suppose te signal to be the voltage source and the source to be the sum of w+v, but I'm not too sure about it. In point b) did I use $T_A$ since I'm looking at the system where $w_{(in)}$ was included?


![[Pasted image 20250107155308.png]]
b) The noise PSD at the output of the amplifier
c) The output SNR (in dB)

Point a, b are easy:
a) Since we are narrowband and centered around $f=10 kHz$ We have that $g_{ch}=|H_{ch}(10kHz)|^2=\frac{1}{1+(2\pi fT_{ch})^2}=2,53\cdot10^{-4}=-35,96dB$ and thus $a_{ch}=36dB$.

b) Now we look at the antenna-amplifier 2 port network: $g=10^3,\ T_{eff}=T_S+T_A=700K$.
Here I propose 2 equivalent types of solutions:
>[!col]
>$p_{w,out}=p_{w,in}g=\frac12kT_{eff}g$
>Then, since we are matched: $\mathcal P_{w,out}=p_{w,out}\cdot R=4,83\cdot10^{-16}\frac{V^2}{Hz}$.
>
>Equivalently, only by looking directly at the PSD
>$\mathcal P_{w,out}=\mathcal P_{w,in}g=\frac12kT_{eff}Rg$

c) We first need to find what signal is picked up by the antenna. This is pretty straight forward since in the first channel we can set $\mathcal P_{a,out}=\mathcal P_a g_{ch}$.

Let's also find $\displaystyle P_{tx}=\int_{-\infty}^\infty\frac{\mathcal P_{a,out}}{R}df=2B_aAg_{ch}/R$.

Now I will use the direct formula $SNR_o=\frac{P_{tx}g}{kT_{eff}B}=\frac{2B_aAg_{ch}}{kT_{eff}2B_aR}$

Here the problem arises:
I would solve the problem by using the noise figure $F=\frac{SNR_i}{SNR_o}$.
I use Friis to find the equivalent noise figure, which is equivalent to the noise figure of the amplifier: $F_A=1+\frac{T_A}{T_0}=2,724$
Find $P_{w,in}=kT_{eff}2B_a$
Then $SNR_i=\frac{P_{tx}}{P_{w,in}}=\frac{2B_aAg_{ch}}{kT_{eff}2B_aR}=\frac{Ag_{ch}}{kT_{eff}R}$

![[Pasted image 20250113092649.png]]
First we find $E_{tx}=A^2T=A^2/R_b\rightarrow E_s=E_{tx}g=E_{tx}/a=$
