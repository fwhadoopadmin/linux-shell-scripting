#################################################################

#!/bin/bash
#############################################
fgGreen=$(tput setaf 2)     # green
fgRed=$(tput setaf 1)       # red
fgYellow=$(tput setaf 3)    # yellow
blue=$(tput setaf 4)        #blue
normal=$(tput sgr0)         #normal
#------------------------------------------------------------

SCR=`basename $0`
LINEOUT="/export/home/ambari/fwWorkstation/ansibleWorkstation/normalscripts/systemhealth/qa.lineout"
#--------------------------------------------------------------------

result="$(ps -ef|grep -i flume  |grep -v "grep" |grep -i jar | awk '{print $2}' |wc -l)"

echo $result 2>&1 >/dev/null;
if [ $result -le 0 ]; then
    echo "FLUME WARNING" 2>&1 >/dev/null;
    status="WARN"
    msg1="FLUME Warning!!: FLUME is either Down  or not in this machine please validate"
    msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
    REPORT="$( $LINEOUT "$status $SCR $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"

else
    echo "Swap condition is Green" 2>&1 >/dev/null;
    status="OK"
    msg1="FLUME Process Running Successfully & OK: Condition=HEALTHY"
    msg="$(printf "%40s" "${fgGreen} $msg1${normal}")"
    REPORT="$( $LINEOUT "$status $SCR $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi
