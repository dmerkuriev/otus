#!/bin/bash

out() {
    for pidpath in $(find /proc/ -maxdepth 1 -regex "^/proc/[0-9]+$"); 
    do
        pid=$(echo $pidpath | awk 'BEGIN {FS ="/"} {print $3, '\t';}')
        #set -x

        tty=$(readlink $pidpath/fd/0 | cut -d "/" -f3)
        [ -z "$tty" ] && tty="?"
        #set +x

        cmdline=$(cat $pidpath/cmdline)
        [ -z "$cmdline" ] && cmdline=$(cut -d " " -f2 $pidpath/stat)
        
	stat=$(cut -d " " -f3 $pidpath/stat)
        
	hertz=$(getconf CLK_TCK)
        utime=$(cut -d " " -f14 $pidpath/stat)
        stime=$(cut -d " " -f15 $pidpath/stat)
        seconds=$((($utime+$stime)/$hertz))
	time=`date -u -d @${seconds} +"%M:%S"`

        printf "%s\t%s\t%s\t%s\t%s\n" $pid $tty $stat $time $cmdline
    done
}

printf "PID\tTTY\tSTAT\tTIME\tCOMMAND\n"
out 2>/dev/null

