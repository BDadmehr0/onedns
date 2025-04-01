#!/bin/bash

# -------------------- رنگ‌ها --------------------
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
WHITE=$(tput sgr0)

# -------------------- بنر --------------------
banner="${BLUE}
  ___             ____  _   _ ____  
 / _ \ _ __   ___|  _ \| \ | / ___| 
| | | | '_ \ / _ \ | | |  \| \___ \ 
| |_| | | | |  __/ |_| | |\  |___) | | github BDadmehr0/onedns
 \___/|_| |_|\___|____/|_| \_|____/  | V.2${WHITE}\n"

# -------------------- نیازمندی‌ها --------------------
check_requirements() {
    if ! command -v curl &> /dev/null; then
        echo -e "${RED}Error: curl is not installed. Please install curl and try again.${WHITE}"
        exit 1
    fi
}

# -------------------- نصب --------------------
install_onedns() {
    current_script_path="$(realpath "$0")"
    install_path="/usr/local/bin/onedns"

    cp "$current_script_path" "$install_path" || {
        echo -e "\n${RED}Installation failed: Unable to copy the script.${WHITE}"
        exit 1
    }

    chmod +x "$install_path" || {
        echo -e "\n${RED}Installation failed: Cannot set execute permission.${WHITE}"
        exit 1
    }

    echo -e "\n${GREEN}Installation successful!${WHITE}"
    echo -e "${YELLOW}You can now run OneDNS from anywhere with: sudo onedns${WHITE}\n"
}

# -------------------- حذف --------------------
uninstall_onedns() {
    echo -e "${YELLOW}Are you sure you want to uninstall OneDNS from your system?${WHITE}"
    read -p "Type 'yes' to confirm: " confirm
    if [[ "$confirm" == "yes" ]]; then
        if [[ -f "/usr/local/bin/onedns" ]]; then
            rm -f /usr/local/bin/onedns
            [[ -f "/etc/resolv.conf.onedns.bak" ]] && rm -f /etc/resolv.conf.onedns.bak
            echo -e "${GREEN}OneDNS and backup (if exists) have been removed.${WHITE}"
        else
            echo -e "${RED}OneDNS is not installed or already removed.${WHITE}"
        fi
        exit 0
    else
        echo -e "${GREEN}Uninstallation cancelled.${WHITE}"
    fi
}

# -------------------- بکاپ و تغییر DNS --------------------
change_dns() {
    backup_file="/etc/resolv.conf.onedns.bak"

    if [[ ! -f "$backup_file" ]]; then
        cp /etc/resolv.conf "$backup_file"
        echo -e "${YELLOW}Backup created at $backup_file${WHITE}"
    fi

    echo -e "${YELLOW}Setting DNS to: $2${WHITE}"
    echo -e "nameserver $(echo "$2" | cut -d, -f1)" > /etc/resolv.conf
    echo -e "nameserver $(echo "$2" | cut -d, -f2)" >> /etc/resolv.conf
    echo -e "${GREEN}DNS successfully changed!${WHITE}\n"
}

# -------------------- بازگردانی بکاپ --------------------
restore_backup_dns() {
    backup_file="/etc/resolv.conf.onedns.bak"
    if [[ -f "$backup_file" ]]; then
        cp "$backup_file" /etc/resolv.conf
        echo -e "${GREEN}Original DNS restored from backup.${WHITE}"
    else
        echo -e "${RED}No backup found. DNS has not been restored.${WHITE}"
    fi
}

# -------------------- پنل مقدماتی --------------------
show_intro() {
    echo -e "$banner"
    echo -e "${GREEN}Welcome to OneDNS — Smart DNS Switcher for Linux${WHITE}"
    echo -e "${YELLOW}Before proceeding, make sure you're connected to the internet and running this as root.${WHITE}"
    echo -e "${BLUE}--------------------------------------------------${WHITE}"
    echo -e "${BLUE}[${WHITE}1${BLUE}]${WHITE} Install (system-wide)\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Use in Live mode (no install)\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit${WHITE}"
    echo -e "${BLUE}--------------------------------------------------${WHITE}"
}

# -------------------- چک روت --------------------
if [[ "$(id -u)" -ne 0 ]]; then
    echo -e "\n${RED}Please run with sudo for installing or changing DNS.${WHITE}\n"
    exit 1
fi

# -------------------- اگر نصب نشده --------------------
installed_path="/usr/local/bin/onedns"
if [[ "$(realpath "$0")" != "$installed_path" ]]; then
    check_requirements
    show_intro
    read -p "Select: " install_option

    case $install_option in
        1)
            install_onedns
            exit 0
            ;;
        2)
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
else
    echo -e "${GREEN}Running OneDNS from system path.${WHITE}\n"
fi

# -------------------- تنظیمات DNS --------------------
declare -A dns_configs
dns_configs["default"]="10.202.10.202, 10.202.10.102"
dns_configs["electro"]="78.157.42.101, 78.157.42.100"
dns_configs["shecan"]="178.22.122.100, 185.51.200.2"
dns_configs["reset"]="8.8.8.8"

# -------------------- منوی اصلی --------------------
echo -e "$banner"
menu_options="${BLUE}[${WHITE}1${BLUE}]${WHITE} Start DNS Options
${BLUE}[${WHITE}2${BLUE}]${WHITE} Reset DNS (8.8.8.8)
${BLUE}[${WHITE}5${BLUE}]${WHITE} About
${BLUE}[${WHITE}6${BLUE}]${WHITE} Show Current DNS
${BLUE}[${WHITE}7${BLUE}]${WHITE} Restore Original DNS from Backup
${BLUE}[${WHITE}9${BLUE}]${WHITE} Uninstall OneDNS
${BLUE}[${WHITE}00${BLUE}]${WHITE} Exit${WHITE}\n"
echo -e "$menu_options"

while true; do
    read -p "Select: " i
    echo " "
    case $i in
        1)
            echo -e "${BLUE}DNS Options:${WHITE}"
            echo -e "${BLUE}[${WHITE}1${BLUE}]${WHITE} 403 Online\n${BLUE}[${WHITE}2${BLUE}]${WHITE} Electro (YouTube unlock)\n${BLUE}[${WHITE}3${BLUE}]${WHITE} Shecan\n${BLUE}[${WHITE}00${BLUE}]${WHITE} Back"
            while true; do
                read -p "Select DNS: " sub_option
                case $sub_option in
                    1) change_dns "default" "${dns_configs["default"]}" ;;
                    2) change_dns "electro" "${dns_configs["electro"]}" ;;
                    3) change_dns "shecan" "${dns_configs["shecan"]}" ;;
                    00) break ;;
                    *) echo -e "${RED}Invalid DNS Option${WHITE}" ;;
                esac
            done
            ;;
        2)
            change_dns "reset" "${dns_configs["reset"]}"
            ;;
        # 3)
        #     read -p "Enter website URL: " service_s_url
        #     response=$(curl -s "https://example.com/check?url=${service_s_url}")
        #     if [[ "$response" == *"support\":true"* && "$response" == *"sanction_status\":true"* ]]; then
        #         echo -e "${YELLOW}Filtered or 403-supported.${WHITE}"
        #     elif [[ "$response" == *"support\":false"* && "$response" == *"sanction_status\":false"* ]]; then
        #         echo -e "${GREEN}Not filtered or unsupported.${WHITE}"
        #     elif [[ "$response" == *"support\":false"* && "$response" == *"sanction_status\":true"* ]]; then
        #         echo -e "${RED}Filtered, no 403 support.${WHITE}"
        #     else
        #         echo -e "${RED}Unknown response.${WHITE}"
        #     fi
        #     ;;
        5)
            echo -e "${GREEN}OneDNS is a lightweight DNS tool designed for simplicity and flexibility on Linux systems. Developed by BDadmehr0 on GitHub.${WHITE}"
            ;;
        6)
            echo -e "${GREEN}$(cat /etc/resolv.conf)${WHITE}"
            ;;
        7)
            restore_backup_dns
            ;;
        9)
            uninstall_onedns
            ;;
        00)
            echo -e "\n${YELLOW}Bye bye${WHITE}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid command.${WHITE}"
            ;;
    esac
done

