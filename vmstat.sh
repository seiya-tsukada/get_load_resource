#! /bin/bash

target_dir="`dirname ${0}`/vmstat"
if [ ! -e ${target_dir} ]; then
  mkdir ${target_dir}
fi

while :
do
  vmstat 1 -n | gawk 'BEGIN{OFS="\t"} NR>=2 { print strftime("%H:%M:%S"),$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17 } { fflush() }' >> ${target_dir}/vmstat.ans
  sleep 1
done
