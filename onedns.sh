#!/bin/bash

# Colors
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
WHITE=$(tput sgr0)

# Banner
banner="${BLUE}
  ___             ____  _   _ ____  
 / _ \ _ __   ___|  _ \| \ | / ___| 
| | | | '_ \ / _ \ | | |  \| \___ \ 
| |_| | | | |  __/ |_| | |\  |___) | | github BDadmehr0/onedns
 \___/|_| |_|\___|____/|_| \_|____/  | V.2${WHITE}\n"

# Install function
install_onedns() {
    # Get the full path to the current directory
    script_path=$(dirname "$(realpath "$0")")
    script_name="onedns_installer.sh"
    install_path="/usr/local/bin/onedns.sh"

    # Copy the current script to /usr/local/bin
    cp "$script_path/$script_name" "$install_path"
    if [[ $? -ne 0 ]]; then
        echo -e "\n${RED}Installation failed: Could not find the file $script_name in $script_path. Please make sure the file exists.${WHITE}\n"
        exit 1
    fi

    chmod +x "$install_path"
    if [[ $? -ne 0 ]]; then
        echo -e "\n${RED}Installation failed: Could not set executable permission for $install_path.${WHITE}\n"
        exit 1
    fi

    # Create a small wrapper script in /usr/local/bin
    wrapper_content="#!/bin/bash\n\n$install_path"

    echo -e "$wrapper_content" > /usr/local/bin/onedns
    chmod +x /usr/local/bin/onedns

    echo -e "\n${GREEN}Installation successful!${WHITE}"
    echo -e "${YELLOW}You can run the program anytime by typing 'onedns' in your terminal.${WHITE}\n"
}

# Check if running as root
if [[ "$(id -u)" -ne 0 ]]; then
    echo -e "\n${RED}Please run with sudo for editing /etc/resolv.conf and installation\n${WHITE}"
    exit 1
fi


# Prompt for installation or live use
clear
echo -e "$banner"
echo -e "${YELLOW}Would you like to install the program on your system or use it live?${WHITE}"
echo -e "${BLUE}[${WHITE}1${BLUE}]${WHITE} Install\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Use Live\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit${WHITE}\n"
read -p "Select: " install_option

case $install_option in
    1)
        install_onedns
        exit 0
        ;;
    2)
        # Continue with live use
        echo -e "${GREEN}Running in live mode.${WHITE}\n"
        ;;
    00)
        echo -e "\n${YELLOW}Bye bye${WHITE}\n"
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid option. Exiting.${WHITE}\n"
        exit 1
        ;;
esac

# Continue with the original script if using live mode

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
            echo -e "One DNS is made up of several DNS + separate tools to improve the quality of DNS.\nThe good thing about this DNS is that it can be easily installed and executed on Linux systems and automatically adjusts DNS."
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

