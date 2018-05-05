#!/bin/bash
# initialize variables from args 
backupdir=$1
filespath=$2
dbname=$3
bucketname=$4

#creating backup dir if not exist and open it
mkdir -p $backupdir
cd $backupdir

backupmask=$bucketname"_*.zip"
backupfile=$bucketname"_"$(date "+%Y-%m-%d-%H-%M-%S")".zip"
dbfile=$dbname".sql"

#clear last copies
rm -f $backupmask

# making backup
mysqldump -u root $dbname > $dbfile
zip -x "*.git*" -r $backupfile $filespath $dbfile
rm -f $dbfile

#uploading to remote S3
s3cmd --guess-mime-type --delete-removed sync ./ s3://$bucketname/