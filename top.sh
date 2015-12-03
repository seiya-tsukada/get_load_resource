#! /bin/sh

target_dir="`dirname ${0}`/top"
if [ ! -e ${target_dir} ]; then
  mkdir ${target_dir}
fi

while :
do
  top -b -n 1 > ${target_dir}/top_`date +%H%M%S`
  sleep 1
done
