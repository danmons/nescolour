ref=avfamicom
ls -1d mister* | while read comp
do
  for prog in ./render.sh ./render_adjusted.sh ./stats.sh ./stats_adjusted.sh
  do
    $prog $ref $comp &
  done &
done &
