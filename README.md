# BLUPF90_usage
How to use BLUPF90 To fit random regression model for genomic prediction and GWAS? 

More details from official website. https://masuday.github.io/blupf90_tutorial/index.html

BLUPF90 wiki. http://nce.ads.uga.edu/wiki/doku.php#headline

## In Mac_OS system:

1.  Download the programs from here: http://nce.ads.uga.edu/html/projects/programs/Mac_OSX/64bit/
2.	Put these programs in your Workshop folder. Such as ``` ~/bin ```
3.	To make your program executable open a terminal window                                    
    ```chmod 777 <filename>```
4.  After downloading and executing, add them to your path (mac or linux). ```export PATH=~/bin:$PATH```  
To execute this command on log-in everytime, set the variable in ```~/.bash_profile```.

## Variance Component Estimation
'aireml1.txt' is parameter file containing default initial variances and OPTION, we will use it in blupf90+ to get the estimated variances.

In terminal, run:
```
renumf90 aireml1.txt 
```

From the generated file 'blupf90.log', copy residual variance, and genetic effect variance into 'aireml1_1.txt'. Then run the following code, we can get the sulotions.
```
renumf90 aireml1_1.txt 
```