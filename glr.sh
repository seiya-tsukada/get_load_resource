#! /bin/bash

target_dir=`dirname ${0}`

dir_clear () {
  # trash
  find ${target_dir} -type d ! -path "." | xargs rm -rf
  rm -f ${target_dir}/period
}

start () {
  echo "== start time: `date` =="
  echo "`date '+ %T'`" >> ${target_dir}/period

  dir_clear

  # top.sh
  cmd="bash ${target_dir}/top.sh &"
  echo ${cmd}

  eval ${cmd}

  # vmstat.sh
  cmd="bash ${target_dir}/vmstat.sh &"
  echo ${cmd}

  eval ${cmd}

  # jstack.sh
  # cmd="bash ${target_dir}/jstack.sh &"
  # echo ${cmd}

  # eval ${cmd}
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
  echo "`date '+ %T'`" >> ${target_dir}/period
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
