#!/bin/bash
TN=Dirrecursive_minutly_EPAMIvanov
LOGFILE=/var/log/EPAMIvanovbackup.log
echo  >>$LOGFILE
echo "====================================================="  >>$LOGFILE
echo "$(date +'%d-%b-%Y %R')" >>$LOGFILE
echo "Task/"$TN/" started..." >>$LOGFILE
#SRСD=/home/snoop/Pictures
TGTD="/var/backups/"
rsync -avz --delete  /home/snoop/Pictures $TGTD &>> $LOGFILE
STATUS=$?
IFS=$OLDFS
if [[ $STATUS != 0 ]];
then
rm -r $TGTD & >> $LOGFILE
echo "###########################################" >>$LOGFILE
    echo "###  The Matrix has you.... Failed to backup. ###" >>$LOGFILE
    echo "###########################################" >>$LOGFILE
    echo "$(date +'%d-%b-%Y %R%n') backup $TN didnt create"
else
    echo "File save as \"$TGTD\"" >>$LOGFILE
    echo "Backup of file succesefully saved in $(date +'%R %d-%b-%Y')!" >>$LOGFILE
fi
 tail -n 300  $LOGFILE >/tmp/EPAMIvanovbackup.tmp
mv -f /tmp/EPAMIvanovbackup.tmp $LOGFILE 2>1
exit