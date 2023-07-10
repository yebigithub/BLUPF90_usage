# BLUPF90_usage
**How to use BLUPF90 To fit random regression model for genomic prediction and GWAS?**

# Official materials
***More details from official website***
- BLUPF90 wiki. http://nce.ads.uga.edu/wiki/doku.php
- GitHub tutorial. https://masuday.github.io/blupf90_tutorial/index.html
    Related pages.
    - Restricted (residual) maximum likelihood with AIREMLF90: https://masuday.github.io/blupf90_tutorial/vc_aireml.html
    - GBLUP: https://masuday.github.io/blupf90_tutorial/mrode_c11ex113_gblup.html
    - Random regression model: https://masuday.github.io/blupf90_tutorial/mrode_c09ex092_random_regression.html
    - GWAS using the ssGBLUP framework: https://masuday.github.io/blupf90_tutorial/genomic_gwas.html 

***Similar paper about RRM***
- Github link: https://github.com/Rostamabd/Random-Regression-Analysis/blob/master/renf90.par

# Install BLUPF90 family in Mac_OS system:

1.  Download the programs from here: http://nce.ads.uga.edu/html/projects/programs/Mac_OSX/64bit/
2.	Put these programs in your Workshop folder. Such as ``` ~/bin ```
3.	To make your program executable open a terminal window                                    
    ```chmod 777 <filename>```
4.  After downloading and executing, add them to your path (mac or linux). ```export PATH=~/bin:$PATH```  
To execute this command on log-in everytime, set the variable in ```~/.bash_profile```.


# GBLUP
**Materials:**  
- Theory and codes: https://masuday.github.io/blupf90_tutorial/mrode_c11ex113_gblup.html  
- Data: I didn't find the rawdata in the website above, so I used rawdata6 from ssGBLUP. Including ```rawdata6.txt```, ```snp6.txt```, ```rawpedegree.txt```.  
- All the raw files and generated files are in the [GBLUP folder](https://github.com/yebigithub/BLUPF90_usage/tree/main/GBLUP)

**Main steps:**  
- Setp1. RENUM90 to generate snp_XrefID  
- Setp2. BLUPF90+ to generate variance components.   
- Setp3. PREGSF90 to generate G inverse.  
- Setp4. BLUPF90+ to run GBLUP.  

### Step1. RENUM90
- Type in all related information into renum6.txt
- In terminal, run ```renumf90 renum6.txt```.
- After that you can get the ```snp6.txt_XrefID``` in the same folder.  
- ```renf90.par``` is what we need in next step.

### Step2. BLUP90+ to get variance components
- In the last line of ```renf90.par``` add the following line to get variance components.
```
OPTION method VCE
```
- In terminal, run ```blupf90+ renf90.par```
- ```blupf90.log``` is the file we need for next step.

### Step3. PREGSF90
- Copy paste ```renf90.par``` and rename into ```preparam.par```
- From ```blupf90.log```, extract the residual variance, and effect variance, and type them into ```preparam.par```. 
- In the last part of preparam.par, add the following lines:
```
OPTION SNP_file snp6.txt snp6.txt_XrefID   #add XrefID file.
OPTION no_quality_control
OPTION AlphaBeta 0.95 0.05                 #since no G-Inverse, let us use alphabeta.
OPTION tunedG 0
OPTION saveGInverse
OPTION createGimA22i 0
```
- In terminal, run ```preGSf90 preparam.par ```

### Step4. GBLUP
- Copy paste ```preparam.par``` and rename into ```gblup.par```
- Delete all the OPTIONs and add the following one. ```OPTION solv_method FSPAK```
- In terminal, run ```blupf90+ gblup.par```
- ```solutions``` is what we want. The number information is showing in ```snp6.txt_XrefID```.

# Ramdom Regression Model
Read this tutorial page, summarized very well.  
https://masuday.github.io/blupf90_tutorial/mrode_c09ex092_random_regression.html

**Main steps**
- Column bind your phenotype data and legender polynomial matrix (Phi) together as input data file.
- renum: Since the tutorial rawdata and rawpedigree data are just numbers, so there is no step of renum. In real dataset, you may need renum firstly.
- Variance components: To use ```OPTION METHOD VCE``` firstly to get residual variances, and random effects variances.
- RRM: BLUPF90+ to run random regression model.
- If you don't want to include perminent effects, delete the following rows in ```para_mr09b.txt```.
```
 5  8 cov 1  # Legendre polynomials (intercept) for permanent environmental effect
 6  8 cov 1  # Legendre polynomials (1st order) for permanent environmental effect
 7  8 cov 1  # Legendre polynomials (2nd order) for permanent environmental effect

RANDOM_GROUP
10 11 12
RANDOM_TYPE
diagonal
FILE

(CO)VARIANCES
 6.872 -0.254 -1.101
-0.254  3.171  0.167
-1.101  0.167  2.457
```
# GWAS to get p-val of all the markers.
GWAS using the ssGBLUP framework: https://masuday.github.io/blupf90_tutorial/genomic_gwas.html


# Appendix ---- good practise for beginners. 
I am also a beginner..🤪🥸（所谓“现学现卖”）
## Variance Component Estimation
***In real data analysis, it is better to estimate variance components with reml (AI-REML or EM-REML) firstly***
['aireml1.txt'](https://github.com/yebigithub/BLUPF90_usage/blob/main/VCE/general/aireml1.txt) is parameter file containing default initial variances and OPTION, we will use it in blupf90+ to get the estimated variances.

In terminal, run:
```
blupf90+ aireml1.txt
```

From the generated file 'blupf90.log', copy residual variance, and genetic effect variance into ['aireml1_1.txt'](https://github.com/yebigithub/BLUPF90_usage/blob/main/VCE/general/aireml1_1.txt). Then run the following code, we can get the sulotions.
```
blupf90+ aireml1_1.txt 
```