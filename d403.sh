#!/bin/bash

# Colors
BLUE='\033[34m'
WHITE='\e[0m'
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'

# Service Check API
url='https://api.anti403.ir/api/search-filter?url='

fil_and_sop='{"isSuccess":true,"message":"result success","result":{"support":true,"sanction_status":true,"crossings":[{"name":"DNS","link":"\/download"},{"name":"\u0633\u0631\u0648\u06cc\u0633 \u0648\u06cc\u0698\u0647","link":"\/subscription"}]},"statusCode":200}'
n_fil='{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":false,"crossings":null},"statusCode":200}'
fill_and_n_sop='{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":true,"crossings":null},"statusCode":200}'



# DNS configurations
shecandns="nameserver 178.22.122.100\nnameserver 185.51.200.2"
text="nameserver 10.202.10.202\nnameserver 10.202.10.102"
reset_text="nameserver 8.8.8.8"

# Banner
banner="${BLUE}
    d8888   .d8888b.   .d8888b.
   d8P888  d88P  Y88b d88P  Y88b
  d8P 888  888    888      .d88P
 d8P  888  888    888     8888\"
d88   888  888    888      \"Y8b.${WHITE} | git https://github.com/BDadmehr0${BLUE}
8888888888 888    888 888    888${WHITE} | 403 Service For linux${BLUE}
      888  Y88b  d88P Y88b  d88P
      888   \"Y8888P\"   \"Y8888P\" .online${WHITE}\n"

# Check if running as root
if [ "$(whoami)" = "root" ]; then
    clear
    echo -e "$banner"

	start_menu="${BLUE}[${WHITE}1${BLUE}]${WHITE} 403 online dns\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Shecan dns\n${BLUE}[${WHITE}3${BLUE}]${WHITE} Exit\n"

    # Menu Banner
    mode_banner="${BLUE}[${WHITE}1${BLUE}]${WHITE} Start\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Reset DNS to (8.8.8.8)\n${BLUE}${BLUE}[${WHITE}3${BLUE}]${WHITE} Service check\n${BLUE}[${WHITE}4${BLUE}]${WHITE} New Service request(Cooming)\n${WHITE}${BLUE}[${WHITE}5${BLUE}]${WHITE} About\n${BLUE}[${WHITE}6${BLUE}]${WHITE} Show my DNS\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit${WHITE}\n"
    echo -e "$mode_banner"

    # Menu loop
    while true; do
        read -p "Select: " i
        echo " "
        case $i in
            1)
				clear
				echo -e "$banner"
				while true; do
					echo -e "$start_menu"
       				read -p "Select: " i
					case $i in
						1)
                			echo -e "$text" > /etc/resolv.conf
                			echo -e "\n${GREEN}Change DNS to (10.202.10.202, 10.202.10.102)${WHITE}\n"
                			exit
							;;
						2)
							echo -e "$shecandns" > /etc/resolv.conf
                			echo -e "\n${GREEN}Change DNS to (178.22.122.100, 185.51.200.2)${WHITE}\n"
                			exit
							;;
						3)
					echo -e "\n${YELLOW}Bye bye${WHITE}\n"
					exit
							;;
					esac
				done
                ;;
            2)
                echo -e "$reset_text" > /etc/resolv.conf
				echo -e "${GREEN}Change DNS to (8.8.8.8)${WHITE}\n"
                exit
                ;;
            3)
                read -p "Service Url: " service_s_url
                response=$(curl -s "${url}${service_s_url}")
                case "$response" in
                    "$fil_and_sop")
                        echo -e "\n${YELLOW}URL Filter or support 403 Service${WHITE}\n"
                        ;;
                    "$n_fil")
                        echo -e "\n${GREEN}URL No Filter or support 403 Service${WHITE}\n"
                        ;;
                    "$fill_and_n_sop")
                        echo -e "\n${RED}URL Filter or not support 403 Service${WHITE}\n"
                        ;;
                esac
                ;;
            4)
                # s
                ;;
            5)
                echo -e "\n403 is a platform for the dear programmers and developers of our country who face all kinds of sanctions and disruptions in the development of their desired projects.\n\nBy supporting various protocols, this project allows users to access the libraries and websites they need for development by removing the existing problems.\n\nThis site will be updated over time with user feedback to fix all the problems of this precious community.\n"
                ;;
            6)
                #echo res.confg
                command="cat /etc/resolv.conf"
                rep1="options edns0 trust-ad"

                # Run
                out=$(eval "$command")
                echo -e "${GREEN}$out${WHITE}\n"
                ;;
            00)
                #EXIT
                exit
                ;;
            clear)
                clear
                echo -e "$banner"
                echo -e "$mode_banner"
                ;;
            *)
                echo -e "${RED}Command Not Found${WHITE}\n"
                exit
                ;;
        esac
    done
else
    echo -e "\n${RED}Please run with sudo for edit /etc/resolv.conf\n${WHITE}"
fi
