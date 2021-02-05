cat /opt/fwsysadmin_admintools/rotate_all_zipslogs.sh
#!/bin/bash

cleaningfiles() {

if [[ $(df -hT |grep -i /var/log/hadoop |awk '{print $6}' |cut -d "%" -f1) -ge 70 ]]; then
        echo "We have hadoop Disk issue" ;
        echo -e "Rotating old zip files  ***********"
        for file1 in $(sudo su - atlas -c  "ls /var/log/atlas/temp_atlas/ |grep -v "$(date |awk '{print $2 " " $3}')" "); do
                sudo su - atlas -c "/bin/rm -f  /var/log/atlas/temp_atlas/$file1";
                sleep 2;
        done
else
        echo "No Zipfile Found";
fi

}


##############################
# main script
cleaningfiles


###########################################
# old school 


#!/bin/bash 
# disk monitor for hive metadata that is always filling up 
# Delete all the logs if disksize is greater than 80% used 


LIMIT=80

DISKSIZE=$(df -hT | grep -i /var/log/hadoop | awk '{print $6}' | cut -d "%" -f1)


if [[ $DISKSIZE -ge $LIMIT2 ]]; then 
	echo "disk issue" ;
	cd /var/log/hadoop/hdfs && \
	ls -ltr | grep -v "drwxr" | awk '{print $9}'  | xargs rm -f
	sleep 5;

	cd /var/log/hadoop/hdfs/audit/solr/spool && \ 
	ls -ltr | grep -v "drwxr" | awk '{print $9}'  | xargs rm -f
else 
	echo " Green"; 
fi


#######################################

#!/bin/bash

ThreshHold=70
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ $HaddopSize -ge $ThreshHold ]]; then
        echo "Disk Issue ....Resloving it ****";
        for file1 in $(sudo su - atlas -c "/bin/ls -t1 /var/log/hadoop/hdfs/audit/solr/spool/|grep -i 'spool_hdfs.log.bk*'"); do
                sudo su - hdfs -c "/bin/gzip -9 -r  /var/log/hadoop/hdfs/audit/solr/spool/$file1";
                #sudo su - hdfs -c "/bin/gzip -9 -r  /var/log/hadoop/hdfs/audit/solr/spool/spool_hdfs_* /var/log/hadoop/hdfs/audit/solr/spool/spool_hdfs_*.gz"
                sudo su - hdfs -c "/bin/find  /var/log/hadoop -type f -size +200000k -exec gzip -9 -r {} \;"
                #sudo su - hdfs -c "/bin/find  /var/log/hadoop f -size +200000k -exec ls -lh {} \; 2> /dev/null | awk '{ print $NF }'  | grep ".tgz" |sort -hrk 2,2 | head -n 10 |xargs rm -f"
                sudo su - hdfs -c "/bin/find  /var/log/hadoop f -size +200000k -exec gzip -9 -r {} \;"
                sleep 5;
        done
else
        echo "NO Issues Quiting";
        exit 0;
fi




#!/bin/bash

ThreshHold=70
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ $HaddopSize -ge $ThreshHold ]]; then
        echo "Disk Issue ....Resloving it ****";
        for file1 in $(sudo su - atlas -c "/bin/ls -t1 /var/log/hadoop/hdfs/audit/solr/spool/|grep -i 'spool_hdfs.log.bk*'"); do
                sudo su - hdfs -c "/bin/rm -f  /var/log/hadoop/hdfs/audit/solr/spool/$file1";
                #sudo su - hdfs -c "/bin/gzip -9 -r  /var/log/hadoop/hdfs/audit/solr/spool/spool_hdfs_* /var/log/hadoop/hdfs/audit/solr/spool/spool_hdfs_*.gz"
                sudo su - hdfs -c "/bin/find  /var/log/hadoop -type f -size +200000k -exec rm -f {} \;"
                sudo su - hdfs -c "/bin/find  /var/log/hadoop f -size +200000k -exec ls -lh {} \; 2> /dev/null | awk '{ print $NF }'  | grep ".tgz" |sort -hrk 2,2 | head -n 10 |xargs rm -f"
                sudo su - hdfs -c "/bin/find  /var/log/hadoop f -size +200000k -exec ls -lh {} \; 2> /dev/null | awk '{ print $NF }' ||sort -hrk 2,2 | head -n 10 |xargs rm -f"
                sleep 5;
        done
else
        echo "NO Issues Quiting";
        exit 0;
fi



#!/bin/bash


hadoop-hdf () {

ThreshHold=90
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ "$HaddopSize" -ge  "90" ]]; then
        echo "Real trouble";
        #sudo su - hdfs -c  "/bin/find  /var/log/hadoop/hdfs -name "hadoop-hdfs*.gz" -type f -mtime +2 -exec rm -f {} \;"
        sudo su - hdfs -c  "/bin/find  /var/log/hadoop/hdfs -name "hadoop-hdfs*.gz" -type f -exec rm -f {} \;"
        sleep 2;
        echo "Done"
else
        echo "No Zip files to remove"
        exit 0;
fi
}

################################################################################
security() {

ThreshHold=90
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ "$HaddopSize" -ge  "90" ]]; then
        echo "Real trouble";
        sudo su - hdfs -c  "/bin/find  /var/log/hadoop/hdfs -name "SecurityAuth.audit*.gz" -type f  -exec rm -f {} \;"
else
        echo "No Zip files to remove"
        exit 0;
fi
}

####################################################################
gclog() {

ThreshHold=80
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ "$HaddopSize" -ge  "90" ]]; then
        echo "Real trouble";
        sudo su - hdfs -c  "/bin/find  /var/log/hadoop/hdfs -name "gc.log*.gz" -type f -exec rm -f {} \;"
        sleep 2;
        echo "done"
        exit 0
else
        echo "No Zip files to remove"
        exit 0;
fi
}

#########################################################################################
hdfs-auditlog() {

ThreshHold=90
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ "$HaddopSize" -ge  "90" ]]; then
        echo "Real trouble";
        sudo su - hdfs -c  "/bin/find  /var/log/hadoop/hdfs -name "hadoop-hdfs*.gz" -type f -exec rm -f {} \;"
        sleep 2;
        echo "done"
        exit 0

else
        echo "No Zip files to remove"
        exit 0;
fi
}



auditlog2() {

ThreshHold=90
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ "$HaddopSize" -ge  "90" ]]; then
        echo "Real trouble";
        sudo su - hdfs -c  "/bin/find  /var/log/hadoop/hdfs -name "hdfs-audit.log.gz*" -type f -exec rm -f {} \;"
        sleep 2;
        echo "done"
        exit 0

else
        echo "No Zip files to remove"
        exit 0;
fi

}
###############################################



security2() {

ThreshHold=90
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ "$HaddopSize" -ge "90" ]]; then
        echo "Real trouble";
        sudo su - hdfs -c  "/bin/find  /var/log/hadoop/hdfs -name "SecurityAuth_log.bk*" -type f -exec rm -f {} \;"
        sleep 2;
        echo "done"
        exit 0

else
        echo "No Zip files to remove"
        exit 0;
fi
}



########################################
hadoop-hdf
security
gclog
hdfs-auditlog
auditlog2
security2




#!/bin/bash

ThreshHold=70
HaddopSize=$(df -hT |grep -i /var/log/hadoop|awk '{print $6}'|cut -d "%" -f1)

if [[ $HaddopSize -ge $ThreshHold ]]; then
        echo "Disk Issue ....Resloving it ****";
        for file1 in $(sudo su - atlas -c "/bin/ls -t1 /var/log/hadoop/hdfs/audit/solr/spool/|grep -i 'spool_hdfs*'"); do
                sudo su - hdfs -c "/bin/zip -9 -r /var/log/hadoop/hdfs/audit/solr/spool/spool_hdfs.log.bk_$(date +".%m-%d-%Y-%H:%M:%S").gz /var/log/hadoop/hdfs/audit/solr/spool/$file1";
                #sudo su - hdfs -c "/bin/gzip -9 -r  /var/log/hadoop/hdfs/audit/solr/spool/spool_hdfs_* /var/log/hadoop/hdfs/audit/solr/spool/spool_hdfs_*.gz"
                sleep 5;
        done
else
        echo "NO Issues Quiting";
        exit 0;
fi














