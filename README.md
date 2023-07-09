# BLUPF90_usage
**How to use BLUPF90 To fit random regression model for genomic prediction and GWAS?**

## Official materials
More details from official website. 
- BLUPF90 wiki. http://nce.ads.uga.edu/wiki/doku.php
- GitHub tutorial. https://masuday.github.io/blupf90_tutorial/index.html
    Related pages.
    - Restricted (residual) maximum likelihood with AIREMLF90: https://masuday.github.io/blupf90_tutorial/vc_aireml.html
    - GBLUP: https://masuday.github.io/blupf90_tutorial/mrode_c11ex113_gblup.html
    - Random regression model: https://masuday.github.io/blupf90_tutorial/mrode_c09ex092_random_regression.html
    - GWAS using the ssGBLUP framework: https://masuday.github.io/blupf90_tutorial/genomic_gwas.html 

## Similar paper about RRM
- Github link: https://github.com/Rostamabd/Random-Regression-Analysis/tree/master

## Install in Mac_OS system:

1.  Download the programs from here: http://nce.ads.uga.edu/html/projects/programs/Mac_OSX/64bit/
2.	Put these programs in your Workshop folder. Such as ``` ~/bin ```
3.	To make your program executable open a terminal window                                    
    ```chmod 777 <filename>```
4.  After downloading and executing, add them to your path (mac or linux). ```export PATH=~/bin:$PATH```  
To execute this command on log-in everytime, set the variable in ```~/.bash_profile```.

## Variance Component Estimation
['aireml1.txt'](https://github.com/yebigithub/BLUPF90_usage/blob/main/VCE/github_vce/aireml1.txt) is parameter file containing default initial variances and OPTION, we will use it in blupf90+ to get the estimated variances.

In terminal, run:
```
blupf90+ aireml1.txt
```

From the generated file 'blupf90.log', copy residual variance, and genetic effect variance into ['aireml1_1.txt'](https://github.com/yebigithub/BLUPF90_usage/blob/main/VCE/github_vce/aireml1_1.txt). Then run the following code, we can get the sulotions.
```
blupf90+ aireml1_1.txt 
```