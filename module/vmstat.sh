#! /bin/bash

current_dir=`cd $(dirname ${0}) && pwd`
target_dir=`cd ${current_dir}/../ && pwd`
log_dir="${target_dir}/log/vmstat"
pid_file="${target_dir}/log/vmstat.pid"

if [ ! -e ${log_dir} ]; then
  mkdir -p ${log_dir}
fi

echo $$ > ${pid_file}

while :
do
  vmstat 1 -n | gawk 'BEGIN{OFS="\t"} NR>=2 { print strftime("%H:%M:%S"),$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17 } { fflush() }' >> ${log_dir}/vmstat.log
  sleep 1
done
