#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

if ! command -v ping >/dev/null 2>&1
then
    echo -e "${RED}Error: ping command not found!${NC}"
    exit 1
fi

 echo  -e " ${BLUE}************************************************** ${NC}"
 echo  -e " ${CYAN}       LINUX SYSTEM HEALTH CHECKER ${NC}               "
 echo  -e " ${BLUE}**************************************************${NC}"
 
 echo " "
 echo " ~~~~~~~~~~~SYSTEM INFORMATION~~~~~~~~~~~~~~~~~"
 echo "Hostname: $(hostname) "
 echo "Operating System : $(uname -s)"
 echo "Kernal version : $(uname -r)"
 echo "user : $(whoami)"
 echo "Date : $(date)"
 
 echo " "
 echo "~~~~~~~~~~~~~~~SYSTEM UPTIME~~~~~~~~~~~~~"
 uptime
 
 echo " "
 echo "~~~~~~~~~~~~~MEMORY USAGE~~~~~~~~~~~~~~~~"
 free -h
 
 echo " "
 echo "~~~~~~~~~~~~~~~~DISK USAGE~~~~~~~~~"
 df -h

 echo " "
 echo "~~~~~~~~~~~~~~~~~~~USER INFORMATION~~~~~~~~~~~"
 echo "Currrent Username : $(whoami)"
 echo "Logged in user:"
 who

 echo " "
 echo "~~~~~~~~~~~~~~~~INTERNET CONNECTIVITY~~~~~~~~~~~~"
 if ping -c 2 google.com >  /dev/null
 then
    echo -e " INTERNET STATUS : ${GREEN}connected${NC}"
 else
    echo -e " INTERNET STATUS : ${RED}not connected${NC}"
 fi
echo ""
echo "~~~~~~~~~~~~~~CPU INFORMATION~~~~~~~~~~~~~~~~~~"
echo " Processor : $(lscpu | grep 'Model' | cut -d ':' -f2)"
echo " Architecture : $(uname -m)"
echo " CPU cores : $(nproc)"
echo ""
echo "~~~~~~~~~~~~~~PROCESSES STATUS~~~~~~~~~~~~~~~~~"
echo "Total Running Processes : $(ps -e | wc -l)"
echo ""
echo "~~~~~~~~~~~~~~HEALTH SUMMARY~~~~~~~~~~~~~~~~~~~"
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk Usage : ${disk_usage}%"

if [ "$disk_usage" -lt 80 ]

then
   echo -e "Systen Health : ${GREEN}Healthy${NC}"
else
   echo -e "System Health : ${YELLOW}Warning${NC}"
fi