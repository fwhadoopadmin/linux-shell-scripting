#!/bin/bash

#``````````````````````````````````````````````````````````````````````
SERVER=vdcplhdps1001.dominionnet.com
PORT=8080
USERNAME=admin2
PASSWORD=$(cat ambaripass.txt | base64 --decode)
CLUSTERNAME=domsandbox
SERVICE=$1


#############################################
fgGreen=$(tput setaf 2)     # green
fgRed=$(tput setaf 1)       # red
fgYellow=$(tput setaf 3)    # yellow
blue=$(tput setaf 4)        #blue
normal=$(tput sgr0)         #normal
#------------------------------------------------------------


generatereport () {
sleep 2;
SCR=`basename $0`

AMBARI_INFRA="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"AMBARI_INFRA"?fields=ServiceInfo | grep state)"
AMBARI_METRICS="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"AMBARI_METRICS"?fields=ServiceInfo | grep state)"
ATLAS="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"ATLAS"?fields=ServiceInfo | grep state)"
BIGSQL="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"BIGSQL"?fields=ServiceInfo | grep state)"
DATASERVERMANAGER="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"DATASERVERMANAGER"?fields=ServiceInfo | grep state)"
DRUID="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"DRUID"?fields=ServiceInfo | grep state)"
ELASTICSEARCH="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"ELASTICSEARCH"?fields=ServiceInfo | grep state)"
FLUME="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"FLUME"?fields=ServiceInfo | grep state)"
HBASE="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"HBASE"?fields=ServiceInfo | grep state)"
HDFS="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"HDFS"?fields=ServiceInfo | grep state)"
HIVE="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"HIVE"?fields=ServiceInfo | grep state)"
KAFKA="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"KAFKA"?fields=ServiceInfo | grep state)"
KERBEROS="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"KERBEROS"?fields=ServiceInfo | grep state)"
KIBANA="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"KIBANA"?fields=ServiceInfo | grep state)"
KNOX="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"KNOX"?fields=ServiceInfo | grep state)"
LOGSTASH="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"LOGSTASH"?fields=ServiceInfo | grep state)"
MAPREDUCE2="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"MAPREDUCE2"?fields=ServiceInfo | grep state)"
OOZIE="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"OOZIE"?fields=ServiceInfo | grep state)"
PIG="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"PIG"?fields=ServiceInfo | grep state)"
RANGER="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"RANGER"?fields=ServiceInfo | grep state)"
RANGER_KMS="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"RANGER_KMS"?fields=ServiceInfo | grep state)"
SLIDER="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"SLIDER"?fields=ServiceInfo | grep state)"
SPARK2="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"SPARK2"?fields=ServiceInfo | grep state)"
SQOOP="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"SQOOP"?fields=ServiceInfo | grep state)"
STORM="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"STORM"?fields=ServiceInfo | grep state)"
TEZ="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"TEZ"?fields=ServiceInfo | grep state)"
YARN="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"YARN"?fields=ServiceInfo | grep state)"
ZEPPELIN="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"ZEPPELIN"?fields=ServiceInfo | grep state)"
ZOOKEEPER="$(curl --silent -u ${USERNAME}:${PASSWORD} -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/"ZOOKEEPER"?fields=ServiceInfo | grep state)"

USER=$(who a mi |awk '{print $1}')
HOSTNAME=$(hostname -f)


printf "%s\n" "*****************************************************************************"
printf "%s\n\t" "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
printf "%s\n\t\t" " Sandbox DOMSANDBOX: Monitoring Report"

printf "%s\n\t\t" " `date`"
printf "%s\n\t\t" "Generated by $USER"
printf "%s\n\t\t" "$HOSTNAME"
printf "%s\n\t\t" "Report can be generated anytime to keep abreast of Issues b4 they're reported"
printf "%s\n\t" "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
printf "%s\n" "*****************************************************************************"

# AMBARI_INFRA
DOWN="$(echo $AMBARI_INFRA |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
    Process="AMBARI_INFRA"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
    msg="$(printf "%40s" "${fgRed}$Process:      ${fgGreen} $msg1${normal}")"
    REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
    Process="AMBARI_INFRA"
    msg1="process is Down & Check_Status=Failed"
    msg="$(printf "%40s\t" "${fgRed}$Process:   ${fgYellow} $msg1${normal}")"
    REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# AMBARI_METRICS

DOWN="$(echo $AMBARI_METRICS |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="AMBARI_METRICS"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="AMBARI_METRICS"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "ATLAS"

DOWN="$(echo $ATLAS |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
    Process="ATLAS"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
    msg="$(printf "%40s" "${fgRed}$Process:       ${fgGreen} $msg1${normal}")"
    REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
    Process="ATLAS"
    msg1="process is Down & Check_Status=Failed"
    msg="$(printf "%40s" "${fgRed}$Process:              ${fgYellow} $msg1${normal}")"
    REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi

# "BIGSQL"

 DOWN="$(echo $BIGSQL |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="BIGSQL"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:          ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="BIGSQL"
    msg1="process is Down & Check_Status=Failed"
    msg="$(printf "%40s" "${fgRed}$Process:             ${fgYellow} $msg1${normal}")"
    REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"DATASERVERMANAGER"

 DOWN="$(echo $DATASERVERMANAGER |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="DATASERVERMANAGER"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="DATASERVERMANAGER"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "DRUID"


 DOWN="$(echo $DRUID |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="DRUID"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process :        ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="DRUID"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "ELASTICSEARCH"

 DOWN="$(echo $ELASTICSEARCH |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="ELASTICSEARCH"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="ELASTICSEARCH"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "FLUME"

DOWN="$(echo $FLUME |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="FLUME"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="FLUME"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"HBASE"

 DOWN="$(echo $HBASE |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="HBASE"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="HBASE"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "HDFS"

 DOWN="$(echo $HDFS |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="HDFS"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="HDFS"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "HIVE"

 DOWN="$(echo $HIVE |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="HIVE"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="HIVE"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"KAFKA"

 DOWN="$(echo $KAFKA |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="KAFKA"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="KAFKA"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "KERBEROS"
 DOWN="$(echo $KERBEROS |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="KERBEROS"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="KERBEROS"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "KIBANA"

 DOWN="$(echo $KIBANA |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="KIBANA"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="KIBANA"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "KNOX"

 DOWN="$(echo $KNOX |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="KNOX"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="KNOX"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"LOGSTASH"

 DOWN="$(echo $LOGSTASH |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="LOGSTASH"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="LOGSTASH"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "MAPREDUCE2"

DOWN="$(echo $MAPREDUCE2 |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="MAPREDUCE2"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="MAPREDUCE2"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"OOZIE"

 DOWN="$(echo $OOZIE |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="OOZIE"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="OOZIE"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"PIG"

 DOWN="$(echo $PIG |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="PIG"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="PIG"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"RANGER"

 DOWN="$(echo $RANGER |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="RANGER"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="RANGER"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"RANGER_KMS"

 DOWN="$(echo $RANGER_KMS |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="RANGER_KMS"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="RANGER_KMS"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "SLIDER"

 DOWN="$(echo $SLIDER |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="SLIDER"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="SLIDER"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"SPARK2"

 DOWN="$(echo $SPARK2 |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="SPARK2"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="SPARK2"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "SQOOP"

 DOWN="$(echo $SQOOP |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="SQOOP"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="SQOOP"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "STORM"

 DOWN="$(echo $STORM |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="STORM"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="STORM"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"TEZ"

 DOWN="$(echo $TEZ |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="TEZ"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="TEZ"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


# "YARN"

 DOWN="$(echo $YARN |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="YARN"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:          ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="YARN"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi


#"ZEPPELIN"

 DOWN="$(echo $ZEPPELIN |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="ZEPPELIN"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="ZEPPELIN"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi



#"ZOOKEEPER"

DOWN="$(echo $ZOOKEEPER |grep INSTALLED |cut -d "," -f3 |awk '{print $3}' |wc -l)"

if [ $DOWN -le 0 ]; then
    echo "Success" 2>&1 >/dev/null;
    status="OK"
        Process="ZOOKEEPER"
    msg1="Process Running Successfully & Check_Status=HEALTHY"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgGreen} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgGreen}$status: $msg"| sed '/^\s*$/d')"
        printf "%s\n" "$REPORT"

else
    echo "Check Failed" 2>&1 >/dev/null;
    status="WARN"
        Process="ZOOKEEPER"
    msg1="process is Down & Check_Status=Failed"
    #msg="$(printf "%40s" "${fgYellow} $msg1${normal}")"
        msg="$(printf "%40s" "${fgRed}$Process:         ${fgYellow} $msg1${normal}")"
        REPORT="$( printf "%s\n" "${fgYellow}$status: $msg" | sed '/^\s*$/d')"
    printf "%s\n" "$REPORT"
fi

printf "%s\n" "*****************************************************************************"
printf "%s\n" "*****************************************************************************"

}

#main script
###################################
generatereport
