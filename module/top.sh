#! /bin/sh

current_dir=`cd $(dirname ${0}) && pwd`
target_dir=`cd ${current_dir}/../ && pwd`
log_dir="${target_dir}/log/top"
pid_file="${target_dir}/log/top.pid"

echo $$ > ${pid_file}

if [ ! -e ${log_dir} ]; then
  mkdir ${log_dir}
fi

while :
do
  top -b -n 1 > ${log_dir}/top_`date +%H%M%S`.log
  sleep 1
done

exit
