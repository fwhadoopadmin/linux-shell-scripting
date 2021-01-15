#################################################################
#
#     Program    : check.linux.inode.sh
#                : Fredrick 
#                : Oct 2018
#
#################################################################

#!/bin/bash

MOUNT=$(mount|egrep -iw "ext4|ext3|xfs|gfs|gfs2|btrfs"|sort -u -t' ' -k1,2)
FS_USAGE=$(df -PTh|egrep -iw "ext4|ext3|xfs|gfs|gfs2|btrfs"|sort -k6n|awk '!seen[$1]++')
IUSAGE=$(df -PThi|egrep -iw "ext4|ext3|xfs|gfs|gfs2|btrfs"|sort -k6n|awk '!seen[$1]++')

S="************************************"
D="-------------------------------------"


#--------Check Inode usage--------#
echo -e "\n\nChecking For INode Usage" 2>&1 >/dev/null;
echo -e "$D$D" 2>&1 >/dev/null;
echo -e "( 0-90% = OK/HEALTHY, 90-95% = WARNING, 95-100% = CRITICAL )" 2>&1 >/dev/null;
echo -e "$D$D" 2>&1 >/dev/null;
echo -e "INode Utilization (Percentage Used):\n" 2>&1 >/dev/null;

echo "$IUSAGE"|awk '{print $1" "$7}' > /tmp/s1.out
echo "$IUSAGE"|awk '{print $6}'|sed -e 's/%//g' > /tmp/s2.out
> /tmp/s3.out

for i in $(cat /tmp/s2.out);
do
  if [[ $i = *[[:digit:]]* ]];
  then
  {
  if [ $i -ge 95 ];
  then
    echo -e $i"% ------------------Critical" >> /tmp/s3.out;
  elif [[ $i -ge 90 && $i -lt 95 ]];
  then
    echo -e $i"% ------------------Warning" >> /tmp/s3.out;
  else
    echo -e $i"% ------------------Good/Healthy" >> /tmp/s3.out;
  fi
  }
  else
    echo -e $i"% (Inode Percentage details not available)" >> /tmp/s3.out
  fi
done
paste -d"\t" /tmp/s1.out /tmp/s3.out|column -t |awk '{print $4}' |cut -d '/' -f2|sort|uniq >>/tmp/s6.out
/export/home/ambari/fwWorkstation/ansibleWorkstation/normalscripts/systemhealth/report/check.linux.inode.sh
