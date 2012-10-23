# Multi-component methods on drift counteraction

## Contents

* [pca](drift-multicomp/tree/master/pca)
* [cpca](drift-multicomp/tree/master/cpca)

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

To install the packages, run the following command in R terminal:
```
install.packages("JADE")
```
