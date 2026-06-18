anilla 3DGS results (7K iterations):
SSIM: tensor(0.7716)
PSNR: tensor(27.0049)
LPIPS: tensor(0.3152)
Vanilla 3DGS results (30K iterations):
SSIM: tensor(0.7716)
PSNR: tensor(27.0049)
LPIPS: tensor(0.3152)

--- Starting Evaluation of SuGaR... ---
Using surface Gaussian Splatting for rendering.

Processing Surface level: 0.3, Decimation target: 1000000, Refinement iterations: 15000...
Loading mesh to bind to: 
./output/coarse_mesh/stump/sugarmesh_3Dgs7000_dn_consistencyestim02_sdfnorm02_level03_decim1000000.ply
Loading SuGaR model config 
./output/refined/stump/sugarfine_3Dgs7000_dn_consistencyestim02_sdfnorm02_level03_decim1000000_normalconsistency01_gauss
perface1/15000.pt...
Binding radiance cloud to surface mesh...
Evaluation of SuGaR finished, with surface level 0.3 and decimation target 1000000 and refinement iterations 15000.
SuGaR results:
SSIM: tensor(0.7034)
PSNR: tensor(25.0681)
LPIPS: tensor(0.3246)