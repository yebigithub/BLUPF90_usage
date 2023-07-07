# BLUPF90_usage
How to use BLUPF90?

## In linux system:
1.	Create a new directory. 
2.	Download the following programs from here: http://nce.ads.uga.edu/html/projects/programs/Linux/64bit/ 

-	blupf90+
-	renumf90
-	airemlf90
-	remlf90
-	preGSf90
-	postGSf90
-	predf90
3.	Put these programs in your Workshop folder.
4.	To make your program executable open a terminal window    
    ```chmod 777 <filename>```
5.	To run your program type ./nameofprogram in your terminal window.

## In Mac_OS system:

1. Download the programs from here: http://nce.ads.uga.edu/html/projects/programs/Mac_OSX/64bit/

2.	Put these programs in your Workshop folder.
3.	To make your program executable open a terminal window                                    
    ```chmod 777 <filename>```
4.	To run your program type ./nameofprogram in your terminal window.
5. After downloading Julia, add it to path (mac or linux)
```
# 1. make a directory for binaries if you don't have it.
mkdir ~/bin

# 2. move the program to the directory.
mv blupf90 ~/bin

# 3. add to PATH 
export PATH=~/bin:$PATH
```
