#!/bin/bash

echo "__START__"

rdir=render_$(uuidgen)
mkdir "${rdir}"

# chunk size for colours
csize=100
# spacer size for black spacers
smallspace=20
bigspace=$csize

## xyz is 4,5,6
## Lab is 9,10,11

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

  x1=$( echo "${line1}"  | awk '{print $4}' )
  y1=$( echo "${line1}"  | awk '{print $5}' )
  z1=$( echo "${line1}"  | awk '{print $6}' )
  x2=$( echo "${line2}"  | awk '{print $4}' )
  y2=$( echo "${line2}"  | awk '{print $5}' )
  z2=$( echo "${line2}"  | awk '{print $6}' )


  rgb1=$( python3 lab2rgb.py ${l1} ${a1} ${b1} )
  rgb2=$( python3 lab2rgb.py ${l2} ${a2} ${b2} )

  #echo chunk $i rgb1 $rgb1 rgb2 $rgb2

  echo chunk $i

  convert -size ${csize}x${csize} xc:"rgb(${rgb1})" -colorspace sRGB -type truecolor -depth 8 ${rdir}/chunk_1_${i}.tif
  convert -size ${csize}x${csize} xc:"rgb(${rgb2})" -colorspace sRGB -type truecolor -depth 8 ${rdir}/chunk_2_${i}.tif

  #convert -size ${csize}x${csize} xc:"xyz(${x1},${y1},${z1})" -colorspace XYZ -type truecolor -depth 8 ${rdir}/chunk_1_${i}.png
  #convert -size ${csize}x${csize} xc:"xyz(${x2},${y2},${z2})" -colorspace XYZ -type truecolor -depth 8 ${rdir}/chunk_2_${i}.png




done

for k in 0 127 188 255
do
  convert -size "${smallspace}x${smallspace}" xc:"rgb(${k},${k},${k})" ${rdir}/corner${k}.tif
  convert -size "${smallspace}x${bigspace}" xc:"rgb(${k},${k},${k})" ${rdir}/vert${k}.tif
  convert -size "${bigspace}x${smallspace}" xc:"rgb(${k},${k},${k})" ${rdir}/horiz${k}.tif
done

compsize=$((${smallspace}+${bigspace}+${bigspace}+${smallspace}))

for k in 0 127 188 255
do
  for i in $( seq 1 53 )
  do

    echo montage $i $k

    montage -size ${compsize}x${compsize} \
      ${rdir}/corner${k}.tif ${rdir}/horiz${k}.tif ${rdir}/horiz${k}.tif ${rdir}/corner${k}.tif \
      ${rdir}/vert${k}.tif ${rdir}/chunk_1_${i}.tif ${rdir}/chunk_2_${i}.tif ${rdir}/vert${k}.tif \
      ${rdir}/corner${k}.tif ${rdir}/horiz${k}.tif ${rdir}/horiz${k}.tif ${rdir}/corner${k}.tif \
      -tile 4x3 -geometry +0+0 \
      ${rdir}/compare_${i}_${k}.tif
  done
done


rowsize=$((${compsize}*13))
colsize=$((${compsize}*16))

for k in 0 127 188 255
do
  for j in $(seq 2 53 )
  do
    export montageseq="${montageseq} ${rdir}/compare_${j}_${k}.tif"
  done
done

echo final montage

montage -size ${rowsize}x${colsize} \
  ${montageseq} \
  -tile 13x16 -geometry +0+0 \
  ${rdir}/finalcomp.tif

convert ${rdir}/finalcomp.tif ${rdir}/finalcomp.png

cp -vf "${rdir}/finalcomp.png" "render_${1}_${2}.png"

echo cleaning up
rm -rf "${rdir}"

echo "__FINISH__"
