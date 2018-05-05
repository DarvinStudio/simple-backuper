# Simple Backuper
Simple script provides basic functionality to make a db and files backup and send it to Amazone S3

## Installation
Download the script and provide +x mode

    wget https://raw.githubusercontent.com/DarvinStudio/simple-backuper/master/backup.sh
    chmod +x backup.sh
    
Install s3cmd, in Debian-base just

    apt-get install s3cmd
    
Configure s3cmd, input access and secret key. Another settings aren't matter right now.

    s3cmd --configure
    
## Setup the backup    
    
Creating the bucket, type any bucket name instead of {mybucketname}

    s3cmd --acl-private --bucket-location=EU mb s3://{mybucketname}

Check that everythins is correct and the bucket is created

    s3cmd la
    
Now you can just run the script with parameters 
1) Path where copies will be stored on local file syste
2) Path to files needed to be backuped 
3) Db name to be backuped
4) Bucket name created on the previous step

For example
 
    backup.sh /var/backups/mysitename/ /var/www/mysitename.ru/ mydbname mynewbuckentname
    
If everything is correct next step will be to setup cron, for example once per day at 1AM

    crontab -e
    00 1 * * * /bin/bash /pathtoscript/backup.sh /var/backups/mysitename/ /var/www/mysitename.ru/ mydbname mynewbuckentname
    
## IMPORTANT NOTICE
The script checks nothing when does a job, please make sure provided paths are correct and a bucket is successfully created. 
