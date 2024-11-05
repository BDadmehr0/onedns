#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
WHITE=$(tput sgr0)

# Service Check API
url='https://api.anti403.ir/api/search-filter?url='

fil_and_sop='{"isSuccess":true,"message":"result success","result":{"support":true,"sanction_status":true,"crossings":[{"name":"DNS","link":"\/download"},{"name":"\u0633\u0631\u0648\u06cc\u0633 \u0648\u06cc\u0698\u0647","link":"\/subscription"}]},"statusCode":200}'
n_fil='{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":false,"crossings":null},"statusCode":200}'
fill_and_n_sop='{"isSuccess":true,"message":"result success","result":{"support":false,"sanction_status":true,"crossings":null},"statusCode":200}'



# DNS configurations
electro="nameserver 78.157.42.101\nnameserver 78.157.42.100"
shecandns="nameserver 178.22.122.100\nnameserver 185.51.200.2"
text="nameserver 10.202.10.202\nnameserver 10.202.10.102"
reset_text="nameserver 8.8.8.8"

# Banner
banner="${BLUE}
  ___             ____  _   _ ____  
 / _ \ _ __   ___|  _ \| \ | / ___| 
| | | | '_ \ / _ \ | | |  \| \___ \ 
| |_| | | | |  __/ |_| | |\  |___) | | github BDadmehr0/onedns
 \___/|_| |_|\___|____/|_| \_|____/  | V.2${WHITE}\n"

# Check if running as root
if [ "$(whoami)" = "root" ]; then
    echo -e "$banner"

	start_menu="${BLUE}[${WHITE}1${BLUE}]${WHITE} 403 online dns\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Electro (for youtube unlock)\n${BLUE}[${WHITE}3${BLUE}]${WHITE} Shecan dns\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit\n"

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
						3)
							echo -e "$shecandns" > /etc/resolv.conf
                			echo -e "\n${GREEN}Change DNS to (178.22.122.100, 185.51.200.2)${WHITE}\n"
                			exit
							;;
						2)
							echo -e "$electro" > /etc/resolv.conf
							echo -e "\n${GREEN}Change DNS to (78.157.42.101, 78.157.42.100)${WHITE}\n"
							exit
							;;
						00)
							exit
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
            echo -e "One DNS is made up of several DNS + separate tools to improve the quality of DNS.\nThe good thing about this DNS is that it can be easily installed and executed on Linux systems and automatically adjusts DNS."                ;;
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
