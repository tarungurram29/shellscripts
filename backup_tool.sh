#######################
# Author: Tarun gurram
# About this script: Archiving/backup file/folder in a backup folder   
#######################
#!/bin/bash

back_up(){
    USER=$1
    if [ "${#USER}" -gt 0 ]; then
        echo "Switching to ${USER} folder"
        cd /home/"${USER}" || { echo "Cannot switch to the user"; exit 1; }

        echo "Enter source path(eg:- /home/username/Downloads)"
        read sourcepath
        echo "Enter backup dir path(eg:- /home/username/Downloads/back_up)"
        read backuppath
        if [ "${#sourcepath}" -gt 0 ]; then
            SOURCE_PATH="${sourcepath}"
            BACKUP_PATH="${backuppath}"
            HOSTNAME=$(hostname -s)
            DATE=$(date +"%Y-%m-%d_%H-%M-%S")
            ARCHIVE_NAME="${HOSTNAME}_backup_${DATE}.tar.gz"

            echo "Creating the backup of $SOURCE_PATH.."
            tar -czf "$BACKUP_PATH/$ARCHIVE_NAME" -C "$SOURCE_PATH" .

            if [ $? -eq 0 ]; then
                echo "Created backup"
            else
                echo "failed"
                exit 1
            fi

            echo "want to delete old backup files? (y/n)"
            read option
            if [ "${option}" = "y" ]; then
                echo "enter the retention days"
                read retention_days
                    if [[ "$retention_days" =~ ^[0-9]+$ ]]; then
                        find "${BACKUP_PATH}" -type f -name "*.tar.gz" -mtime +$retention_days -exec rm {} \; 
                    fi
            else
                exit 1
            fi
        else
            echo "Go to root "/" directory and run the script"
        fi
    else
        echo "please give a paramter(user)"
    fi
} 
back_up "$1"