#!/bin/bash
for i in $( seq 1 53 )
do
  line1=$( head -n $i $1  | tail -n1)
  line2=$( head -n $i $2  | tail -n1)
  l1=$( echo "${line1}"  | awk '{print $9}'  )
  a1=$( echo "${line1}"  | awk '{print $10}' )
  b1=$( echo "${line1}"  | awk '{print $11}' )
  l2=$( echo "${line2}"  | awk '{print $9}'  )
  a2=$( echo "${line2}"  | awk '{print $10}' )
  b2=$( echo "${line2}"  | awk '{print $11}' )

python3 delta_e_2000.py $l1 $a1 $b1 $l1 $a2 $b2

done > s_de_adj_${1}_${2}.txt

python3 stats_adjusted.py s_de_adj_${1}_${2}.txt > s_stats_adj_${1}_${2}.txt
