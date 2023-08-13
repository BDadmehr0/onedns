#!/bin/bash

# Colors
BLUE='\033[34m'
WHITE='\033[37m'

# Service Check API
url='https://api.anti403.ir/api/search-filter?url='
fil_and_sop='{"isSuccess":true,"message":"result success","result":{"support":true,"sanction_status":true,"crossings":[{"name":"DNS","link":"\/download"},{"name":"\u0633\u0631\u0648\u06cc\u0633 \u0648\u06cc\u0698\u0647","link":"\/subscription"}]},"statusCode":200}'
n_fil='{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":false,"crossings":null},"statusCode":200}'
fill_and_n_sop='{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":true,"crossings":null},"statusCode":200}'

# Texts
about="
Fa

403 چیست
...
En

What is 403?
...
"

info="Please run with sudo for edit /etc/resolv.conf"

# DNS configurations
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
    echo -e "$banner"

	start_menu="${BLUE}[${WHITE}1${BLUE}]${WHITE} 403 online dns\n${BLUE}[${WHITE}1${BLUE}]${WHITE} Shecan dns\n"

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
				while true; do

                	echo "Change DNS to (10.202.10.202, 10.202.10.102)"
                	exit
                	echo -e "$text" > /etc/resolv.conf
				done
                ;;
            2)
                echo -e "$reset_text" > /etc/resolv.conf
                exit
                ;;
            3)
                read -p "Service Url: " service_s_url
                response=$(curl -s "${url}${service_s_url}")
                case "$response" in
                    "$fil_and_sop")
                        echo -e "\e[33mURL Filter or support 403 Service\e[0m"
                        ;;
                    "$n_fil")
                        echo -e "\e[32mURL No Filter or support 403 Service\e[0m"
                        ;;
                    "$fill_and_n_sop")
                        echo -e "\e[31mURL Filter or not support 403 Service\e[0m"
                        ;;
                esac
                ;;
            4)
                #echo "New service request"
                ;;
            5)
                echo -e "$about"
                ;;
            6)
                #echo res.confg
                command="cat /etc/resolv.conf"
                rep1="options edns0 trust-ad"

                # Run
                out=$(eval "$command")
                echo "$out"
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
                echo "Command Not Found"
                exit
                ;;
        esac
    done
else
    echo -e "$info"
fi
