# Internal-Spatial Decomposition

Matlab code for internal and spatial decomposition algorithm devised by Ish Dhand and Sandeep K. Goyal

---

This repository comprises Matlab code for the decomposition algorithm presented in article ["Realization of arbitrary discrete unitary transformations using spatial and internal modes of light"](http://arxiv.org/abs/1508.06259) by Ish Dhand and Sandeep K. Goyal. If you use this decomposition or code, please consider citing our article.

The file Driver.m illustrates the use of the two matlab functions in our decomposition. The first function (Decomposition.m) receives a unitary matrix as input, and returns internal and CS matrices (refer to article). The second function (CSMatrices.m) factorizes a received CS matrix into internal and beamsplitter matrices.

Comments, suggestions and bug-fixes are welcome. Please contact [me](http://ishdhand.me/) at [ishdhand@gmail.com](ishdhand@gmail.com)
