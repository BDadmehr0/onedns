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
 / _ \\ _ __   ___|  _ \\| \\ | / ___| 
| | | | '_ \\ / _ \\ | | |  \\| \\___ \\ 
| |_| | | | |  __/ |_| | |\\  |___) | | github BDadmehr0/onedns
 \\___/|_| |_|\\___|____/|_| \\_|____/  | V.2${WHITE}\n"

# Menu Banner
menu_banner="${BLUE}[${WHITE}1${BLUE}]${WHITE} Start\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Reset DNS to (8.8.8.8)\n${BLUE}[${WHITE}3${BLUE}]${WHITE} Custom DNS\n${BLUE}[${WHITE}4${BLUE}]${WHITE} Service check\n${BLUE}[${WHITE}5${BLUE}]${WHITE} About\n${BLUE}[${WHITE}6${BLUE}]${WHITE} Show my DNS\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit${WHITE}\n"

# Function to validate IP addresses
validate_ip() {
    local ip="$1"
    local valid=1
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        for octet in $(echo "$ip" | tr '.' ' '); do
            if ((octet < 0 || octet > 255)); then
                valid=0
                break
            fi
        done
    else
        valid=0
    fi
    return $valid
}

# Check if running as root
if [[ "$(id -u)" -ne 0 ]]; then
    echo -e "\n${RED}Please run with sudo for editing /etc/resolv.conf${WHITE}\n"
    exit 1
fi

# Display banner
clear
echo -e "$banner"
echo -e "$menu_banner"

# Menu loop
while true; do
    read -p "Select: " choice
    echo ""
    case $choice in
        1)
            echo -e "\n${YELLOW}Start: DNS Management Options Coming Soon${WHITE}\n"
            ;;
        2)
            echo -e "nameserver 8.8.8.8" > /etc/resolv.conf
            echo -e "\n${GREEN}DNS reset to 8.8.8.8${WHITE}\n"
            ;;
        3) # Custom DNS
            read -p "Enter primary DNS: " primary_dns
            if ! validate_ip "$primary_dns"; then
                echo -e "${RED}Invalid DNS address${WHITE}\n"
                continue
            fi
            read -p "Enter secondary DNS (optional): " secondary_dns
            if [[ -n "$secondary_dns" && ! $(validate_ip "$secondary_dns") ]]; then
                echo -e "${RED}Invalid secondary DNS address${WHITE}\n"
                continue
            fi
            echo -e "nameserver $primary_dns" > /etc/resolv.conf
            [[ -n "$secondary_dns" ]] && echo -e "nameserver $secondary_dns" >> /etc/resolv.conf
            echo -e "\n${GREEN}Custom DNS set to: $primary_dns ${secondary_dns:+and $secondary_dns}${WHITE}\n"
            ;;
        4)
            echo -e "\n${YELLOW}Service Check Coming Soon${WHITE}\n"
            ;;
        5)
            echo -e "One DNS is a tool to manage and enhance DNS configurations easily on Linux systems."
            ;;
        6)
            echo -e "${GREEN}Current DNS settings:${WHITE}"
            cat /etc/resolv.conf
            ;;
        00)
            echo -e "\n${YELLOW}Goodbye!${WHITE}\n"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option, please try again.${WHITE}\n"
            ;;
    esac
done
