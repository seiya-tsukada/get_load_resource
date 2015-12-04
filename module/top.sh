#! /bin/sh

current_dir=`cd $(dirname ${0}) && pwd`
target_dir=`cd ${current_dir}/../ && pwd`
log_dir="${target_dir}/log/top"
pid_file="${target_dir}/log/top.pid"

if [ ! -e ${log_dir} ]; then
  mkdir -p ${log_dir}
fi

echo $$ > ${pid_file}

while :
do
  top -b -n 1 > ${log_dir}/top_`date +%H%M%S`.log
  sleep 1
done

exit
