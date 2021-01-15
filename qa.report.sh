######################################################################
#
# Program       : qa.report.sh
#               : 10/11/2018
#               :
#
######################################################################
#
# A simple wrapper script that runs entire  programs
# The programs uses the data table (underneath)
# #####################################################################

cat $0 | awk '

BEGIN {
      "hostname" | getline host
      "date"     | getline date
      #base = "/app/documentum/fwerescripts/systemhealth/report"          # Directory that program is running in
      base = "/export/home/ambari/fwWorkstation/ansibleWorkstation/normalscripts/systemhealth/report"           # Directory that program is running in


      while (i<90){
          i++
          #line = line "*"
          line = line "~"
          }
      printf("\n")                                        # Print Heading
      printf("%s\n", line )
      printf("\n")
      printf("%s\n",    "Report       : Hadoop applications & system usage report  (Oct.2020)   ")
      printf("%s%s\n",  "Server       : ", host)
      printf("%s%s\n",  "Run Date     : ", date)
      printf("\n")
      printf("%s\n", line )
      printf("\n")                                        # Print sub heading
      printf("%s\n", line )
      printf("%s\n", "Status         Program               Description")
      printf("%s\n", line )
      printf("\n")
}

{
      if ($1=="#data"){                                   # Run #data scripts
         cmd = sprintf("%s/%s", base, $2)
         while (cmd | getline){ print $0 }
         close(cmd)
         }
}

END {                                                     # Print footer
    printf("\n")
    printf("%s\n", line )
    printf("\n")
}
' |                                                       # pipe output to total results

awk '

##########################################################################################################################

function lineout(status, progname, message){
      #cmd = sprintf("/app/documentum/fwerescripts/systemhealth/qa.lineout  %s   %s   \"%s\" ", status, progname, message)
      cmd = sprintf("/export/home/ambari/fwWorkstation/ansibleWorkstation/normalscripts/systemhealth/qa.lineout  %s   %s   \"%s\" ", status, progname, message)
      cmd | getline xout
      print xout
      close(cmd)
      }


BEGIN  { totfail    = 0                                   # initalize variables
         totwarn    = 0
         totok      = 0
         totinfo    = 0
         while (i<90){
               i++
               line = line "*~"
               }
}

{                                                        # Total status
      print $0
      if (tolower($1) ~ "ok"){
          totok++
          }
      if (tolower($1) ~ "fail"){
          totfail++
          }
      if (tolower($1) ~ "warn"){
          totwarn++
          }
      if (tolower($1) ~ "info"){
          totinfo++
          }
}

END {                                                   # Print totals
    printf("TOTALS FAILURES & WARNINGS\n\n")
     print line
    lineout("TOTAL_FAILURES", totfail, "Must: Triag (prod) Failures & remediate exigent cases ASAP")
    lineout("TOTAL_WARNINGS", totwarn, "")
    print ""
    print line
}
'


#         Programs to run
#         -----------------
#--------------------------------my----------------------------
#data   check_ATLAS_process.sh*
#data   check_DRUID_process.sh*
#data   check_ELASTIC_process.sh*
#data   check_FLUME_process.sh*
#data   check_HBASE_process.sh*
#data   check_HDFS_process.sh*
#data   check_IBM_BIGSQL_process.sh*
#data   check_INFRA_process.sh*
#data   check_KAFKA_process.sh*
#data   check_KMS_process.sh*
#data   check_KNOX_process.sh*
#data   check.linux.uptime.sh*
#data   check_MAPREDUCE_process.sh*
#data   check_memory.sh*
#data   check_OOZIE_process.sh*
#data   check_RANGER_process.sh*
#data   check_SPARK2_process.sh*
#data   check_STORM_process.sh*
#data   check_Swap.sh*
#data   check_YARN_process.sh*
#data   check_ZEPPLIN_process.sh*
#data   check_ZOOKPR_process.sh*
#data   check.linux.disk_usage.sh*
#-------------------------------------my-end----------------------
