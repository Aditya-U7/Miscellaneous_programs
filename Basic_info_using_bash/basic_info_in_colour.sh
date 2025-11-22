: 'Author: Aditya Upadhye

This is a bash program to display basic information about your system. For network information to be shown, your system needs to support 'nmcli' command.

'

#!/bin/bash


BOLDGREEN='\e[1;32m'
RED_BOLD="\e[1;31m"
DARK_YELLOW='\e[1;33m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
ENDCOLOUR='\e[0m'


os_info()
{

	os_name="$(uname -o)"
	echo -e "${CYAN}Operating system:${ENDCOLOUR} ${MAGENTA}${os_name}${ENDCOLOUR}"

	kernel_name="$(uname -s)"
	echo -e "${CYAN}Kernel name:${ENDCOLOUR} ${MAGENTA}${kernel_name}${ENDCOLOUR}"

	kernel_version="$(uname -r)"
	echo -e "${CYAN}Kernel version:${ENDCOLOUR} ${MAGENTA}${kernel_version}${ENDCOLOUR}"

}


cpu_info()
{

	property_names=("Model name" "Byte Order" "Architecture")

	declare -A cpu_info

	for i in "${property_names[@]}"
	do 

		cpu_info["$i"]="$(lscpu | grep "$i" | cut -d':' -f2)"
		cpu_info["$i"]=${cpu_info["$i"]##*( )}

	done

	for key in "${!cpu_info[@]}"
	do
		echo -e "${CYAN}$key${ENDCOLOUR}: ${MAGENTA}${cpu_info[$key]}${ENDCOLOUR}"
	done 

}


network_info()
{

	nmcli dev show &>/dev/null

	if [[ $? -eq 0 ]]
	then

		connected_state="$(nmcli connection show --active | grep -v loopback | grep -v UUID | cut -d' ' -f1)"
		if [[ -n $connected_state ]]
		then 
			network_name="$(nmcli dev show | grep -m 1 "GENERAL.CONNECTION" | cut -d':' -f2)"
			network_name="${network_name##*( )}"
			echo -e "${CYAN}Connected Network Name${ENDCOLOUR}: ${DARK_YELLOW}$network_name${ENDCOLOUR}"

			network_status="$(nmcli networking connectivity)"
			if [[ $network_status == "full" ]]
			then
				echo -e "${CYAN}Internet status of${ENDCOLOUR} ${DARK_YELLOW}$network_name${ENDCOLOUR}: ${BOLDGREEN}Active${ENDCOLOUR}"             
			else
				echo -e "${CYAN}Internet status of${ENDCOLOUR} ${DARK_YELLOW}$network_name${ENDCOLOUR}: ${RED_BOLD}Not active${ENDCOLOUR}"
			fi

			dns_server_ipv4="$(nmcli dev show | grep "IP4.DNS" | cut -d':' -f2)"
			dns_server_ipv6="$(nmcli dev show | grep "IP6.DNS" | cut -d':' -f2-)"

			dns_server_ipv4="${dns_server_ipv4##*( )}"
			dns_server_ipv6="${dns_server_ipv6##*( )}"
			if [[ -n $dns_server_ipv4 ]]
			then
				echo -e "${CYAN}DNS IPv4 ${ENDCOLOUR}:${MAGENTA} $dns_server_ipv4 ${ENDCOLOUR}"
			fi
			if [[ -n $dns_server_ipv6 ]]
			then
				echo -e "${CYAN}DNS IPv6 ${ENDCOLOUR}:${MAGENTA} $dns_server_ipv6 ${ENDCOLOUR}"
			fi

		else 
			echo -e "${DARK_YELLOW}Network info: not connected to a network.${ENDCOLOUR}"
		fi

	else
		echo -e "${RED_BOLD}Not available to fetch network info.${ENDCOLOUR}"

	fi

}


user_info()
{

	current_user_name="$(whoami)"
	current_users="$(who | cut -d' ' -f1 | sort | uniq)" 
	system_name="$(hostname)"
	echo -e "${CYAN}Current user name${ENDCOLOUR}: ${MAGENTA}${current_user_name}${ENDCOLOUR}"
	echo -e "${CYAN}Logged in user(s)${ENDCOLOUR}: ${MAGENTA}${current_users}${ENDCOLOUR}"
	echo -e "${CYAN}System name${ENDCOLOUR}: ${MAGENTA}${system_name}${ENDCOLOUR}"

}


os_info
cpu_info
network_info
user_info
