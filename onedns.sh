#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
WHITE=$(tput sgr0)

# Service Check API
url='https://api.anti403.ir/api/search-filter?url='

# DNS configurations
declare -A dns_configs
dns_configs=(
 ["electro"]="nameserver 78.157.42.101\nnameserver 78.157.42.100"
 ["shecan"]="nameserver 178.22.122.100\nnameserver 185.51.200.2"
 ["default"]="nameserver 10.202.10.202\nnameserver 10.202.10.102"
 ["reset"]="nameserver 8.8.8.8"
)

# Banner
banner="${BLUE}
___             ____  _   _ ____  
/ _ \ _ __   ___|  _ \| \ | / ___| 
| | | | '_ \ / _ \ | | |  \| \___ \ 
| |_| | | | |  __/ |_| | |\  |___) | | github BDadmehr0/onedns
\___/|_| |_|\___|____/|_| \_|____/  | V.2${WHITE}\n"

# Change DNS function
change_dns() {
 echo -e "$1" > /etc/resolv.conf
 echo -e "\n${GREEN}DNS changed to $2${WHITE}\n"
}

# Check if running as root
if [[ "$(id -u)" -ne 0 ]]; then
 echo -e "\n${RED}Please run with sudo for editing /etc/resolv.conf\n${WHITE}"
 exit 1
fi

clear
echo -e "$banner"

# Menu Banner
menu_options="${BLUE}[${WHITE}1${BLUE}]${WHITE} Start\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Reset DNS to (8.8.8.8)\n${BLUE}[${WHITE}3${BLUE}]${WHITE} Service check\n${BLUE}[${WHITE}4${BLUE}]${WHITE} New Service request (Coming)\n${WHITE}${BLUE}[${WHITE}5${BLUE}]${WHITE} About\n${BLUE}[${WHITE}6${BLUE}]${WHITE} Show my DNS\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit${WHITE}\n"
echo -e "$menu_options"

# Menu loop
while true; do
 read -p "Select: " i
 echo " "
 case $i in
     1)
         clear
         echo -e "$banner"
         sub_menu="${BLUE}[${WHITE}1${BLUE}]${WHITE} 403 online dns\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Electro (for youtube unlock)\n${BLUE}[${WHITE}3${BLUE}]${WHITE} Shecan dns\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit\n"
         echo -e "$sub_menu"
         while true; do
             read -p "Select: " sub_option
             case $sub_option in
                 1)
                     change_dns "${dns_configs["default"]}" "10.202.10.202, 10.202.10.102"
                     ;;
                 2)
                     change_dns "${dns_configs["electro"]}" "78.157.42.101, 78.157.42.100"
                     ;;
                 3)
                     change_dns "${dns_configs["shecan"]}" "178.22.122.100, 185.51.200.2"
                     ;;
                 00)
                     echo -e "\n${YELLOW}Bye bye${WHITE}\n"
                     exit 0
                     ;;
             esac
         done
         ;;
     2)
         change_dns "${dns_configs["reset"]}" "8.8.8.8"
         ;;
     3)
         read -p "Service Url: " service_s_url
         response=$(curl -s "${url}${service_s_url}")
         if [[ "$response" == *"support\":true"* && "$response" == *"sanction_status\":true"* ]]; then
             echo -e "\n${YELLOW}URL is filtered or supports 403 service${WHITE}\n"
         elif [[ "$response" == *"support\":false"* && "$response" == *"sanction_status\":false"* ]]; then
             echo -e "\n${GREEN}URL is not filtered or doesn't support 403 service${WHITE}\n"
         elif [[ "$response" == *"support\":false"* && "$response" == *"sanction_status\":true"* ]]; then
             echo -e "\n${RED}URL is filtered and doesn't support 403 service${WHITE}\n"
         else
             echo -e "\n${RED}Unknown response${WHITE}\n"
         fi
         ;;
     4)
         echo -e "\n${YELLOW}New service request coming soon!${WHITE}\n"
         ;;
     5)
         echo -e "\n403 is a platform for the dear programmers and developers of our country who face all kinds of sanctions and disruptions in the development of their desired projects.\n\nBy supporting various protocols, this project allows users to access the libraries and websites they need for development by removing the existing problems.\n\nThis site will be updated over time with user feedback to fix all the problems of this precious community.\n"
         ;;
     6)
         echo -e "${GREEN}$(cat /etc/resolv.conf)${WHITE}\n"
         ;;
     00)
         echo -e "\n${YELLOW}Bye bye${WHITE}\n"
         exit 0
         ;;
     *)
         echo -e "${RED}Command Not Found${WHITE}\n"
         ;;
 esac
done
