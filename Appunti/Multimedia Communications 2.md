# 1) Evaluation Criteria
Error image:
$$\mathcal E(f,\tilde f)=f-\tilde f$$
Mean Square Error (MSE):
$$\mathcal D(f,\tilde f)=\frac1{NM}\abs{\mathcal E}^2$$
Peaks Signal to Noise Ratio (PSNR)
$$PSNR(f,\tilde f)=10\logt\frac{255^2}{\mathcal D(f,\tilde f)}$$