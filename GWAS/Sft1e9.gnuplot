set xrange [1:3000]
set title 'SNP Solutions - Trait: 1 Effect: 9'
plot   'chrsnp' u 4:(($5==1 & $1==1 & $2==9) ? $3 : 1/0) w points pt 6 ps 1 t '' ,  'chrsnp' u 4:(($5==2 & $1==1 & $2==9) ? $3 : 1/0) w points pt 6 ps 1 t '' 
pause 600
 exit
