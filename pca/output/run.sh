#!/bin/bash

name="output"
file_Rmd="$name.Rmd"
dir_R="../"
files_R=$(ls $dir_R | grep R | grep '^[0-9][0-9]-') # ) # R files like 01-script.R

header_str='
```{r setup, include = FALSE}
opts_chunk$set(fig.path = "figure/", tidy = FALSE, dev = "pdf")
# upload images automatically? (identity/imgur_upload)
opts_knit$set(upload.fun = identity)
```
'

echo " * file processing: R > Rmd"
echo "$header_str" > $file_Rmd

pat='```'
for file in $files_R ; do
  echo $file
  
  echo "# $file" >> $file_Rmd
  echo "$pat{r $file}" >> $file_Rmd
  cat $dir_R/$file >> $file_Rmd
  echo "$pat" >> $file_Rmd
done

echo " * knitr: Rmd -> md"
R -q -e 'library(knitr);knit("output.Rmd")'

echo " * pandoc: md -> pdf"
pandoc -N $name.md --toc -o $name.pdf

echo "* finish: ls"
echo $(ls)s
