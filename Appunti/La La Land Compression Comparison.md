---
tags: [video-compression, hevc, mpeg2, qsv, signal-processing]
date: 2026-05-17
---

# 1) Video Codec Performance Analysis: HEVC QSV vs. MPEG-2 QSV

## 1.1) Overview and Encoding Parameters
This document evaluates the encoding efficiency and signal degradation of HEVC (Main 10) against legacy MPEG-2 (Main) when compressing a 4K 10-bit source to a 1080p target at a heavily constrained bitrate (~4.6 Mbps). 

| Attribute | The Source (Original) | MPEG2 QSV | HEVC QSV (Best) | HEVC QSV (Worst) |
| :--- | :--- | :--- | :--- | :--- |
| **Resolution** | 3840x2160 (4K) | 1920x1080 | 1920x1080 | 1920x1080 |
| **Codec** | HEVC (Main 10) | MPEG-2 (Main) | HEVC (Main 10) | HEVC (Main 10) |
| **Bit Depth / Format**| 10-bit (yuv420p10le) | 8-bit (yuv420p) | 10-bit (yuv420p10le) | 10-bit (yuv420p10le)|
| **Overall Bitrate** | ~81,332 kbps | ~4,684 kbps | ~4,673 kbps | ~4,673 kbps |
| **Video Bitrate Limit**| N/A | Max: 3,278 kbps| N/A (VBR/CQP implied) | N/A (VBR/CQP implied) |
| **B-Frames** | 2 | 1 | 3 | 3 |
| **Color Space** | bt2020nc (HDR10) | bt2020nc (Mapped) | bt2020nc | bt2020nc |

---

## 1.2) Objective Quality Metrics (PSNR & MAE)
The frame-by-frame objective metrics reveal a severe structural failure in the MPEG-2 encode when subjected to high-entropy scenes, whereas HEVC maintains statistical stability.

![[HEVC_Best_PSNR_Comp.png]]
![[HEVC_Worst_PSNR_Comp.png]]
![[MPEG2_PSNR_Comp.png]]

### 1.2.1) Statistical Observations:
* **HEVC Stability:** Both HEVC profiles ("Best" at **39.92 dB** and "Worst" at **39.72 dB**) show a tightly clustered PSNR distribution. The difference between optimal and suboptimal HEVC settings at this bitrate is statistically measurable but demonstrates a predictable, controlled degradation curve against Mean Absolute Error (MAE).
* **MPEG-2 Collapse:** The MPEG-2 encode yields a significantly lower mean PSNR of **36.73 dB**. More critically, during the high-motion scene at `~150s`, the PSNR collapses below 30 dB. This is accompanied by massive spikes in MAE, indicating a complete breakdown of temporal prediction and catastrophic signal loss.

---

## 1.3) Visual Fidelity and Error Mapping
Objective metrics are validated by spatial error mapping. The high-frequency detail loss in HEVC is negligible compared to the macroblocking artifacts in MPEG-2.

![[HEVC_Best_Img_Comp.png]]
![[HEVC_Worst_Img_Comp.png]]
![[MPEG2_Img_Comp.png]]

### 1.3.1) Visual Observations:
* **Low-Complexity Scenes (Static/Low-Motion):** Across the 190s–299s range, all codecs handle the spatial data adequately. The resulting error maps are predominantly black, indicating minimal deviation from the original downsampled frames.
* **High-Complexity Scenes (High-Motion/Crowds):** At the 160s mark, the architectural limitations of MPEG-2 become visible. The MPEG-2 error maps show intense, chaotic noise across all color channels, manifesting visually as severe macroblocking and color smearing. The HEVC encodes, utilizing 3 B-frames instead of MPEG-2's single B-frame, successfully leverage bidirectional temporal references to maintain structural integrity without macroblocking.

---

## 1.4) Conclusion
For a target bitrate of ~4.6 Mbps at 1080p, MPEG-2 is mathematically starved. It lacks the advanced temporal prediction and spatial transform efficiency required to handle high-motion video, resulting in severe artifacting. Furthermore, its limitation to 8-bit quantization permanently discards color volume. HEVC QSV is the only viable codec for this application, preserving the 10-bit color depth and maintaining high signal fidelity throughout high-entropy scenes.