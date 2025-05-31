###################
# Author:- Tarun Gurram
# Note:- Use this script only if you have sudo access to execute! 
###################
#!/bin/bash

if [ $# -gt 0 ]; then
    USER=$@
    EXIST_USER=$( sudo cat /bin/passwd | awk -F ":" '{print $1}' | grep -w "${USER}"  )
        if [ ${USER} = ${EXIST_USER} ]; then
            echo "User ${USER} already exist"
        else
            echo "User ${USER} is creating"
            echo "If want to create group enter (y) or (n)"; read groupinput;
                if [ ${groupinput} = "y" ]; then
                    echo "groupname"; read group;
                    sudo addgroup "${group}"
                        echo "Enter 'bash' for default shell...enter any other shell if no bash(sh,csh,ksh,zsh)"; read bash;
                            if [ ${bash} = "bash" ]; then
                              sudo useradd -g "${group}" -s /bin/bash -c "creating user ${USER}" -m -d /home/"${USER}" "${USER}"
                              echo -e "\n user ${USER} is created"
                              echo -e "\n Enter password"
                              sudo passwd "${USER}"
                            else
                              sudo useradd -g "${group}" -s /bin/"${bash}" -c "creating user ${USER}" -m -d /home/"${USER}" "${USER}"
                              echo -e "\n user ${USER} is created"
                              echo -e "\n Enter password"
                              sudo passwd "${USER}"
                            fi
                else
                    echo "Enter 'bash' for default shell...enter any other shell if no bash(sh,csh,ksh,zsh)"; read bash;
                    echo "Enter groupname existing one"; read groupname;
                        if [ "${#groupname}" -gt 0 ]; then
                            if [ ${bash} = "bash" ]; then
                              sudo useradd -g "${groupname}" -s /bin/bash -c "creating user ${USER}" -m -d /home/"${USER}" "${USER}"
                              echo -e "\n user ${USER} is created"
                              echo -e "\n Enter password"
                              sudo passwd "${USER}"
                            else
                              sudo useradd -g "${groupname}" -s /bin/"${bash}" -c "creating user ${USER}" -m -d /home/"${USER}" "${USER}"
                              echo -e "\n user ${USER} is created"
                              echo -e "\n Enter password"
                              sudo passwd "${USER}"
                            fi
                        else
                            echo "Enter groupname"
                        fi
                fi      
                echo "wanna modify the user? like changing the group or change the ownership of a file to a particular file (y/n)"; read input;
                if [ ${input} = "y" ]; then
                            echo -e "\n 1. Group change"
                            echo -e "\n 2. add in multiple groups"
                            echo -e "\n 3. ownership change for a file"
                            echo -e "\n 4. username change"
                            echo -e "\n 5. Lock user"
                            echo -e "\n 6. unlock user"
                            echo -e "\n 7. can allow a specific user to execute sudo command"
                            echo -e "\n Enter any one of the number(1,2,3,4,5,6,7)"; read modify;
                            echo -e "\n Enter the username"; read username;
                            case "${modify}" in
                                "1")
                                    echo "Enter existing groupname"; read grupname;
                                    sudo usermod -g "${grupname}" "${username}" 
                                ;;
                                "2")
                                    echo "Enter existing groupname"; read grupname1;
                                    sudo usermod -G "${grupname1}" "${username}" 
                                ;;
                                "3")
                                    echo "Enter existing groupname"; read grupname2;
                                    echo "File name"; read filename;
                                    sudo chown "${username}":"${grupname2}" "${filename}"
                                ;;
                                "4")
                                    echo "Enter new username"; read newusername;
                                    echo "Enter old username"; read oldusername;
                                    sudo usermod -l "${newusername}" "${oldusername}"
                                ;;
                                "6")
                                    echo "Enter username to Lock"; read username1;
                                    sudo usermod -L "${username1}"
                                ;;
                                "7")
                                    echo "Enter username to Unlock"; read username2;
                                    sudo usermod -U "${username2}"
                                ;;
                                "8")
                                    echo "Enter username"; read username3;
                                    sudo usermod -aG sudo "${username3}"
                                ;;
                            esac
                else
                             exit
                fi
        fi
else
    echo "Invalid parameter"
fi

