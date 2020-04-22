cat ./oracle_scripts/err_vizdb2.sh
#!/bin/bash
ORACLE_HOME=/home/user/oracle/instantclient_19_6/
PATH=$ORACLE_HOME:$PATH
LD_LIBRARY_PATH=$ORACLE_HOME
export ORACLE_HOME
export LD_LIBRARY_PATH
export PATH
/home/user/oracle/instantclient_19_6/sqlplus SYSTEM/oracle@//172.19.236.151:1522/vizrtdb2 @/home/user/oracle_scripts/total_err.sql | grep "rows selected" | awk {'print $1}' | tr "\\\ " " " >> /home/user/vizdb/vizdb2_err.txt





cat ./oracle_scripts/total_err.sql
COLUMN APPLY_NAME HEADING 'Apply|Process|Name' FORMAT A11
COLUMN SOURCE_DATABASE HEADING 'Source|Database' FORMAT A10
COLUMN LOCAL_TRANSACTION_ID HEADING 'Local|Transaction|ID' FORMAT A11
COLUMN ERROR_NUMBER HEADING 'Error Number' FORMAT 99999999
COLUMN ERROR_MESSAGE HEADING 'Error Message' FORMAT A20
COLUMN MESSAGE_COUNT HEADING 'Messages in|Error|Transaction' FORMAT 99999999

SELECT APPLY_NAME,
       SOURCE_DATABASE,
       LOCAL_TRANSACTION_ID,
       ERROR_NUMBER,
       ERROR_MESSAGE,
       MESSAGE_COUNT
  FROM DBA_APPLY_ERROR;
exit;




cat ./oracle_scripts/total_vizdb1.sh
#!/bin/bash
ORACLE_HOME=/home/user/oracle/instantclient_19_6/
PATH=$ORACLE_HOME:$PATH
LD_LIBRARY_PATH=$ORACLE_HOME
export ORACLE_HOME
export LD_LIBRARY_PATH
export PATH
/home/user/oracle/instantclient_19_6/sqlplus SYSTEM/oracle@//172.19.236.151:1521/vizrtdb1 @/home/user/oracle_scripts/total.sql | grep "APPLY_SRC_VIZRTDB" | awk {'print $2 "," $3 "," $4 "," $5 "," $6 "," $7}' | tr "\\\ " " " >> /home/user/vizdb/vizdb1.txt




cat /home/user/oracle_scripts/total.sql
COLUMN APPLY_NAME HEADING 'Apply Process Name' FORMAT A20
COLUMN TOTAL_RECEIVED HEADING 'Total|Trans|Received' FORMAT 99999999
COLUMN TOTAL_APPLIED HEADING 'Total|Trans|Applied' FORMAT 99999999
COLUMN TOTAL_ERRORS HEADING 'Total|Apply|Errors' FORMAT 9999
COLUMN BEING_APPLIED HEADING 'Total|Trans Being|Applied' FORMAT 99999999
COLUMN UNASSIGNED_COMPLETE_TXNS HEADING 'Total|Unnasigned|Trans' FORMAT 99999999
COLUMN TOTAL_IGNORED HEADING 'Total|Trans|Ignored' FORMAT 99999999

SELECT APPLY_NAME,
       TOTAL_RECEIVED,
       TOTAL_APPLIED,
       TOTAL_ERRORS,
       (TOTAL_ASSIGNED - (TOTAL_ROLLBACKS + TOTAL_APPLIED)) BEING_APPLIED,
       UNASSIGNED_COMPLETE_TXNS,
       TOTAL_IGNORED
       FROM V$STREAMS_APPLY_COORDINATOR;
exit;
