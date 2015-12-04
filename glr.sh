#! /bin/bash

target_dir=`cd $(dirname ${0}) && pwd`
prog_dir="${target_dir}/module"
log_dir="${target_dir}/log"

dir_clear () {
  find ${log_dir} -maxdepth 1 ! -path ${log_dir} | xargs rm -rf
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
    # echo ${cmd}
    eval ${cmd}
    echo ""

  done

}

stop () {

  pid_files=`find ${log_dir} -name "*.pid"`

  for i in ${pid_files}
  do

    p_pid=`cat ${i}` 
    c_pid=`ps ho pid --ppid=${p_pid}`

    # delete parent
    cmd="kill ${p_pid}"
    echo ${cmd}
    eval ${cmd}
    
    # delete child
    for i in ${c_pid}
    do

      ans=`ps aux | grep ${i} | grep -v grep | awk '{print $2}'`

      if [ ! -z ${ans} ]; then
        cmd="kill ${ans}"
        eval ${cmd}
      fi

    done

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
