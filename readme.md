# Multi-component methods on drift counteraction

## About
This project is about multi-variate methods on drift counteraction applied to gas sensor array data.
Two methods of interest include component correction based on PCA of reference class (Artursson et al, 2000)
and component correction based on CPCA (Common Principal Component Analysis) (Ziyatdinov et al., 2010).

The main intention is to publish some basic R code and collect some references on the topic, available software and datasets.

One of the project goals is to attempt to investigate multi-component approach to drift correction,
when a drift-related sub-space of data has more than one principal components. 
This work is within the framework of master thesis of Susana Albarracín at Instituto Tecnológico Metropolitano, Medellín
entitled as *Metodología de selección de componentes principales comunes para representación y extracción de las derivas presentes en sensores de gas*.

## R code

* [pca](drift-multicomp/tree/master/pca)
* [cpca](drift-multicomp/tree/master/cpca)

## References

Machine Olfaction
* Gutierrez-Osuna, R. (2002). Pattern analysis for machine olfaction: a review. IEEE Sensors Journal, 2(3), 189–202. [(link)](http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=1021060&tag=1)
* Gutierrez-osuna, R. (2003). Signal processing methods for drift compensation. [(pdf)](http://research.cse.tamu.edu/prism/lectures/talks/nose03.pdf)
* Artursson, T., Eklov, T., Lundstrom, I., Martensson, P., Sjostrom, M., & Holmberg, M. (2000). Drift correction for gas sensors using multivariate methods. Journal of Chemometrics, 14(5-6), 711–723. [(http://onlinelibrary.wiley.com/)](http://onlinelibrary.wiley.com/)
* Ziyatdinov, A., Marco, S., Chaudry, A., Persaud, K., Caminal, P., & Perera, A. (2010). Drift compensation of gas sensor array data by common principal component analysis. Sensors and Actuators B: Chemical, 146(2), 460–465. [(link)](http://www.sciencedirect.com/science/article/pii/S0925400509008995).

CPCA
* Flury, B. N. . (1984). Common Principal Components in K Groups. Journal of the American Statistical Association, 79(388), 892– 898. [(link)](http://www.jstor.org/stable/2288721).
* Boik, B. R. J. (2002). Spectral models for covariance matrices. Biometrika, 159–182. [(link)](http://biomet.oxfordjournals.org/content/89/1/159.abstract).


CPCA software
* [R package JADE](http://cran.r-project.org/web/packages/JADE/index.html) by [Jean-François Cardoso](http://perso.telecom-paristech.fr/~cardoso/) et al.
  * See example for function `djd` about commuting matrices in Reference manual [(pdf)](http://cran.r-project.org/web/packages/JADE/JADE.pdf).
* [CPC](http://pages.uoregon.edu/pphil/programs/cpc/cpc.htm) (Common Principal Component Analysis Program) by [Patrick Phillips](http://pages.uoregon.edu/pphil/) et al.
  * Source code is not available, but some sample output files are interesting, e.g. [this](http://darkwing.uoregon.edu/~pphil/programs/cpc/data/vole.out).
  * See Section References, most dedicated to investigation of covariance structure in data.
* [Matlab code](http://www.math.montana.edu/~rjboik/spectral/) for Spectral Models for Covariance Matrices by [Robert J. Boik](http://www.math.montana.edu/~rjboik/).


CPCA datasets
* [Gas Sensor Array Drift Dataset](http://archive.ics.uci.edu/ml/datasets/Gas+Sensor+Array+Drift+Dataset) at UCI Machine Learning Repository. Creator: Alexander Vergara.

## Notation

PCA model: `X = T P' + E`, where
* `X` is data matrix.
* `T` is matrix of scores.
* `P` is matrix of loadings (`P'` is transpose of `P`). Columns of `P` are Principal Component vectors `PC1`, `PC2`, etc.
* `E` is matrix of errors.

Formula to covert data to scores: `T = X P`.

CPCA model: `Hc: Li = V' Ci V`, where

* `Hc` is hypothesis of common components.
* `i` is the class index.
* `V` is transformation matrix (like `P` in PCA model). Columns of `V` are Common Principal Component vectors `CPC1`, `CPC2`, etc.
* `Ci` is covariance matrix of class `i`.

## Component-Correction results on iris data

A subspace `E` (supposed to underline a subspace of common variance) was computed
on *scaled* iris data by two methods (1) PCA of reference class and (2) CPCA. 
Some basic information can be revealed looking at subspace matrix `E` and the captured variance.

(1) rotation matrix:
```
##                  CPC1     CPC2      CPC3      CPC4
## Sepal.Length -0.37223  0.91893  0.122460  0.044907
## Sepal.Width  -0.92712 -0.37462 -0.003361 -0.009776
## Petal.Length -0.02147  0.08063 -0.324802 -0.942095
## Petal.Width  -0.03785  0.09341 -0.937815  0.332183
```

(1) captured variance:
```
##    CPC1    CPC2    CPC3    CPC4 
## 0.22866 0.35414 0.33155 0.08564 
```

(2) rotation matrix:
```
##                CPC1    CPC2    CPC3    CPC4
## Sepal.Length 0.5248  0.4132 -0.4214  0.6134
## Sepal.Width  0.4885  0.5661  0.4415 -0.4959
## Petal.Length 0.5155 -0.4637 -0.5274 -0.4910
## Petal.Width  0.4693 -0.5420  0.5910  0.3697
```

(2) captured variance:
```
##   CPC1   CPC2   CPC3   CPC4 
## 0.4741 0.2946 0.1080 0.1233 
```


## R packages

* JADE: function `djd` performs a joint diagonalizaion.
* abind: function `abind` composes a 3D matrix from a list of 2D matrices (needed by function `djd`).
* ggplot2: plotting routine.
* reshape: functions `melt` and others prepare data.frames for plotting by `ggplot2`.
* grid: required by `ggplot` to draw arrows on graphics.

To install the packages, e.g. `JADE`, run the following command in R terminal:
```
install.packages("JADE")
```
