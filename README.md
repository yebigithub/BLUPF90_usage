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

### Main steps
- Calculate legender polynomial matrix (Phi). There is one ref from Dr.Morota's website: http://morotalab.org/Mrode2005/rr/rr.html
- Column bind your phenotype data and legender polynomial matrix (Phi) together as input data file.
- renum: Since the tutorial rawdata and rawpedigree data are just numbers, so there is no step of renum. In real dataset, you may need renumber firstly. 
- Variance components: To use ```OPTION METHOD VCE``` firstly to get residual variances, and random effects variances.
- RRM: BLUPF90+ to run random regression model.

### Example from Mrode textbook
Example from [Mrode textbook](http://sherekashmir.informaticspublishing.com/278/1/9780851990002.pdf). Chapter7 7.2 Random regression model and Appendix G.
- [data_mr09b.txt](https://github.com/yebigithub/BLUPF90_usage/blob/main/RRM/data_mr09b.txt): First 4 colums are phenotypes from table 7.1 in Mrode book page 138. The names are ```ID```, ```DIM```, ```HTD```, ```TDY``` respectively. The fifth to last columns are from Phi matrix, they are intercep, first, second, third, and fourth order of polynomials.  
***Attention***: Phi matrix just contains ten rows, which are corresponding to DIM values, so first row is for ```DIM=4```, second row is for ```DIM=38```, thrid row is for ```DIM=72```, etc.  
- [param_mr09b.txt](https://github.com/yebigithub/BLUPF90_usage/blob/main/RRM/param_mr09b.txt): This is the parameter file you need in blupf90+. I will summarize important points here. Read this [link](https://masuday.github.io/blupf90_tutorial/mrode_c09ex092_random_regression.html) for more detials. 

```
DATAFILE
data_mr09b.txt
NUMBER_OF_TRAITS
1                       #just single trait.
NUMBER_OF_EFFECTS
12                      #Totally 12 effects, including 
                        #HTD, 
                        #5 polynomials for fixed effect, 
                        #3polynomials for additive effects, 
                        #3 polynomics for perminent environment.
OBSERVATION(S)
4                       #4th column in data_mr09b.txt is the phenotype
WEIGHT(S)

EFFECTS:
 3 10 cross  # HTD
 5  1 cov    # Legendre polynomials (intercept) for fixed regression
 6  1 cov    # Legendre polynomials (1st order) for fixed regression
 7  1 cov    # Legendre polynomials (2nd order) for fixed regression
 8  1 cov    # Legendre polynomials (3rd order) for fixed regression
 9  1 cov    # Legendre polynomials (4th order) for fixed regression
 5  8 cov 1  # Legendre polynomials (intercept) for additive genetic effect
             # 5 means this effect is in the column 5 of data_mr09b.txt
             # 8 means 8 animals
             # 1 means this effect is nested with column 1 (ID) of data_mr09b.txt
 6  8 cov 1  # Legendre polynomials (1st order) for additive genetic effect
 7  8 cov 1  # Legendre polynomials (2nd order) for additive genetic effect
 5  8 cov 1  # Legendre polynomials (intercept) for permanent environmental effect
 6  8 cov 1  # Legendre polynomials (1st order) for permanent environmental effect
 7  8 cov 1  # Legendre polynomials (2nd order) for permanent environmental effect
RANDOM_RESIDUAL VALUES
3.710
RANDOM_GROUP
7 8 9
RANDOM_TYPE
add_animal
FILE
pedigree_mr09b.txt
(CO)VARIANCES
 3.297  0.594 -1.381
 0.594  0.921 -0.289
-1.381 -0.289  1.005
RANDOM_GROUP
10 11 12
RANDOM_TYPE
diagonal
FILE

(CO)VARIANCES
 6.872 -0.254 -1.101
-0.254  3.171  0.167
-1.101  0.167  2.457
OPTION solv_method FSPAK
```
- Variances and covariances are provided by textbook. For real dataset, you need to calculate them firstly.
- [solutions](https://github.com/yebigithub/BLUPF90_usage/blob/main/RRM/solutions) shows the results. Compare them with textbook page 146. For animal 3, the intercept additive effect (effect 7), first order additive effect (effect 8), and second order additive effect (effect 9) are 0.13110519， -0.02470608, 0.06857404, respectively.
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
### related materials 
- GWAS using the ssGBLUP framework: https://masuday.github.io/blupf90_tutorial/genomic_gwas.html 
- PreGSF90 / PostGSF90: http://nce.ads.uga.edu/wiki/doku.php?id=readme.pregsf90



```chrsnp_pval``` contains  
    - 1: trait  
    - 2: effect  
    - 3: -log10(p-value)  
    - 4: SNP  
    - 5: Chromosome  
    - 6: Position in bp  



# Appendix ---- good practise for beginners. 
I am also a beginner..
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