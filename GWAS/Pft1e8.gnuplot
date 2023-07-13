set xrange [1:3000]
set title '-log10(p_val) - Trait: 1 Effect: 8'
plot   'chrsnp_pval' u 4:(($5==1 & $1==1 & $2==8) ? $3 : 1/0) w points pt 6 ps 1 t '' ,  'chrsnp_pval' u 4:(($5==2 & $1==1 & $2==8) ? $3 : 1/0) w points pt 6 ps 1 t '' 
pause 600
 exit
