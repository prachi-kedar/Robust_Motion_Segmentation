## TOPIC: Robust Motion Segmentation

### Contributors:
- Pınar Erbil 
- Prachi Kedar 

This is a readme file for the code. The repository is available [1]. We are listing the parts where we added the code.

---

### Change in Clustering Algorithms

Users can comment out the method they want to use.

- **/Tools/support/SpectralClustering_svd.m**: Added implementations of DBSCAN, hierarchical, and fuzzy c-means clustering codes. The implementations can be found from the comments.

- **/script/MoSeg/script_AHF_CoReg_RandSamp.m**: Added implementations of DBSCAN, hierarchical, and fuzzy c-means clustering codes. The implementations can be found from the comments.

- **/script/MoSeg/script_AHF_Subset_RandSamp.m**: Added implementations of DBSCAN, hierarchical, and fuzzy c-means clustering codes. The implementations can be found from the comments.

---

### Change to Non-consecutive Pairs

- **/Tools/multigs/run_settings.m**: Returns the frame gap number and number of hypotheses to run.

```matlab
[FrameGap, max_NumHypoPerFrames] = run_settings();
```

All the files inside the `/script/` directory are modified to call the `run_settings` function, and they all have a for loop for each hypothesis obtained from the function. Furthermore, we store results in folders specified by the frame gap number. Simply, instead of saving to `/Results/Kernels/`, we save it to `/Results/Kernels/FrameGap`. Other modifications to prevent excessive prints are commented.

- **/script/MoSeg/script_AHF_CoReg_RandSamp.m**: We have a lambda range of [1e-4 1e-3 1e-2 1e-1].

- **/script/MoSeg/script_AHF_Subset_RandSamp.m**: We have a gamma range of [1e-4 1e-3 1e-2 1e-1].

All the scripts in `/script/CheckPerf` are saving the results in an Excel file to make the analyses easier. Also, generating graphs are in a false while loop to prevent generating a lot of pop-up graphs.

Only the results of CheckPerf for non-consecutive pairs are in  '/Results/' folder. The other middle results were too big to put in the zip.

---
### Change the Homograpghy Fit Function

Users can comment out the method they want to use.

- **/Tools/vgg_geometry/vgg_examples/ransacfithomography_vgg.m**: Added implementations for LMedS and MSAC, marked with comments

- **/Tools/vgg_geometry/vgg_examples/ransacfithomography_vgg_bak.m**: Added implementations for LMedS and MSAC, marked with comments

--



[1] X. Xu, L.F. Cheong, and Z. Li. Motion segmentation by exploiting complementary geometric models, In CVPR 2018.
