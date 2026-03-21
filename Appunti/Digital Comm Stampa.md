**Link Budget:** $P_r[dB]=P_t[dB]+\underbrace{G_t[dB]+G_r[dB]-\par{L_p[dB]+\chi[dB]}}_{\text{large scale gain } G}$
**Path Loss:** $L_P(D)=K_{ref}\par{\frac{D}{D_{ref}}}^\eta\rightarrow L_p(D)[dB]=K_{ref}[dB]+10\eta\logt\par{\frac{D}{D_{ref}}}$
**Free Space Path Loss:** $L_P(D)[dB]=20\logt\par{\frac{4\pi D}{\lambda_c}}$
**Fading:** $f_\chi(\xi)=\frac{1}{\sqrt{2\pi}\sigma\xi}\exp{-\frac{(\log_e\xi)^2}{2\sigma^2}}\stackrel{dB}\rightarrow f_\chi(\xi)=\frac{1}{\sqrt{2\pi}\sigma_{dB}}\exp{-\frac{\xi^2}{2\sigma^2_{dB}}}$
**Rice:** $\displaystyle{f_{|h|}(\xi)=2(K+1)\xi e^{-(K+1)\xi^2-K}I_0\par{2\sqrt{K(K+1)}\xi}}$
**Rayleigh Magnitude:** $f_{|h|}(\xi)=\xi\displaystyle e^{-\frac12\xi^2}$
**Exponential magnitude squared:** $f_{|h|^2}(\xi)=e^{-\xi}$
**Doppler:** $\nu=\underbrace{\frac vcf_c}_{\nu_M}\cos(\theta)$
**Coherence**: $N_c=\frac{T_c}T=BT_c\stackrel{\text{IID Blocks}}\longrightarrow \frac1{2\nu_m T}$
$T_c\gg T_s\quad T_c=\frac1{2\nu_M}\propto\frac1{\nu_M}, \quad\nu_m\ll B$
**PDP:** $\mu_\tau=\int\tau S_h(\tau)d\tau\longrightarrow\sum_{q=0}^{Q-1}\tau_qP_q$
$\sigma^2_\tau=T_d=\sqrt{\int(\tau-\mu_\tau)^2s_h(\tau)d\tau}\longrightarrow\sqrt{\sum_{q=0}^{Q-1}(\tau_q-\mu_q)^2P_q}$

**Flat**
$$\begin{align}\boxed{\text{Frequency Flat iff: }\tau_m\ll T_s\iff T_d\ll T_s\iff B_c\gg B}\\\implies\tau_i(t)\approx\tau_j(t)\approx\hat\tau \ \forall i,j\rightarrow h(\tau)=h\delta(\tau)\end{align}$$
**LMSSE Estimator:**$W^{MMSE}=\frac1{\sqrt G}\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD$
$E=\frac{E_s}{N_t}I-\frac{E_s}{N_t}D^*T^*\par{TT^*+\frac{N_t}{SNR}I}^{-1}TD$
**Some Z**
$$\begin{align}
&H(z)=\frac{1}{1-az^-1}\rightarrow h[n]=(a)^nu[n] &\text{ROC: }|z|>|a|\\
&w[n]=x[n-n_0]\stackrel{\mathcal Z}\longrightarrow W(z)=z^{-n_0}X(z) \qquad R_W=R_X
\end{align}$$

**LMMSE:** $W_{MMSE}=R_y^{-1}R_{ys}$
$E=R_s-R_{ys}^*R_y^{-1}R_{ys}$
**Gauss Vec MMSE:** $\hat s(y)=\sqrt \rho R_sA^*(\rho AR_sA^*+R_z)^{-1}y$ 
$E=(R_s^{-1}+\rho A^*R_z^{-1}A)^{-1}$
