# Multi-component methods on drift counteraction

## Contents

* [pca](drift-multicomp/tree/master/pca)
* [cpca](drift-multicomp/tree/master/cpca)

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
