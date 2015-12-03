#! /bin/bash

target_dir=`cd $(dirname ${0}) && pwd`
prog_dir="${target_dir}/module"
log_dir="${target_dir}/log"

dir_clear () {
  for i in `ls ${log_dir}`
  do
    rm -rf ${log_dir}/${i}
  done
}

start () {

  dir_clear

  echo "== start time: `date` =="
  echo ""
  echo "`date '+ %T'`" >> ${log_dir}/period

  # modules start
  modules=`find ${prog_dir} -type f`
  for prog in ${modules}
  do
    echo "== execute ${prog} =="
    cmd="bash ${prog} &"
    echo ${cmd}

    echo $$
    echo ""
  done

}

stop () {
  top_pid=`ps aux | grep "bash ./to[p]" | awk '{print $2}'`
  vmstat_pid=`ps aux | grep "bash ./vmsta[t]" | awk '{print $2}'`
  vmstat_ppid=`ps --ppid ${vmstat_pid} | grep vmstat | awk '{print $1}'`
  # jstack_pid=`ps aux | grep "bash ./jstac[k]" | awk '{print $2}'`

  pids=(${top_pid} ${vmstat_pid} ${vmstat_ppid} ${jstack_pid})

  for i in ${pids[@]}; do
    cmd="kill ${i}"
    echo ${cmd}
    eval ${cmd}
  done

  echo "== stop time: `date` =="
  echo "`date '+ %T'`" >> ${log_dir}/period
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  clear)
    dir_clear
    ;;
  *)
    echo "Usage: $0 {start|stop|clear}"
esac
