: 'Author: Aditya Upadhye

This is a bash program to display basic information about your system. For network information to be shown, your system needs to support 'nmcli' command.

'

#!/bin/bash


BOLD_GREEN='\e[1;32m'
BOLD_RED="\e[1;31m"
DARK_YELLOW='\e[1;33m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
END_COLOUR='\e[0m'


os_info()
{

	os_name="$(uname -o)"
	echo -e "${CYAN}Operating system:${END_COLOUR} ${MAGENTA}${os_name}${END_COLOUR}"

	kernel_name="$(uname -s)"
	echo -e "${CYAN}Kernel name:${END_COLOUR} ${MAGENTA}${kernel_name}${END_COLOUR}"

	kernel_version="$(uname -r)"
	echo -e "${CYAN}Kernel version:${END_COLOUR} ${MAGENTA}${kernel_version}${END_COLOUR}"

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
		echo -e "${CYAN}$key${END_COLOUR}: ${MAGENTA}${cpu_info[$key]}${END_COLOUR}"
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
			echo -e "${CYAN}Connected Network Name${END_COLOUR}: ${DARK_YELLOW}$network_name${END_COLOUR}"

			network_status="$(nmcli networking connectivity)"
			if [[ $network_status == "full" ]]
			then
				echo -e "${CYAN}Internet status of${END_COLOUR} ${DARK_YELLOW}$network_name${END_COLOUR}: ${BOLD_GREEN}Active${END_COLOUR}"             
			else
				echo -e "${CYAN}Internet status of${END_COLOUR} ${DARK_YELLOW}$network_name${END_COLOUR}: ${BOLD_RED}Not active${END_COLOUR}"
			fi

			dns_server_ipv4="$(nmcli dev show | grep "IP4.DNS" | cut -d':' -f2)"
			dns_server_ipv6="$(nmcli dev show | grep "IP6.DNS" | cut -d':' -f2-)"

			dns_server_ipv4="${dns_server_ipv4##*( )}"
			dns_server_ipv6="${dns_server_ipv6##*( )}"
			if [[ -n $dns_server_ipv4 ]]
			then
				echo -e "${CYAN}DNS IPv4 ${END_COLOUR}:${MAGENTA} $dns_server_ipv4 ${END_COLOUR}"
			fi
			if [[ -n $dns_server_ipv6 ]]
			then
				echo -e "${CYAN}DNS IPv6 ${END_COLOUR}:${MAGENTA} $dns_server_ipv6 ${END_COLOUR}"
			fi

		else 
			echo -e "${DARK_YELLOW}Network info: not connected to a network.${END_COLOUR}"
		fi

	else
		echo -e "${BOLD_RED}Not available to fetch network info.${END_COLOUR}"

	fi

}


user_info()
{

	current_user_name="$(whoami)"
	current_users="$(who | cut -d' ' -f1 | sort | uniq)" 
	system_name="$(hostname)"
	echo -e "${CYAN}Current user name${END_COLOUR}: ${MAGENTA}${current_user_name}${END_COLOUR}"
	echo -e "${CYAN}Logged in user(s)${END_COLOUR}: ${MAGENTA}${current_users}${END_COLOUR}"
	echo -e "${CYAN}System name${END_COLOUR}: ${MAGENTA}${system_name}${END_COLOUR}"

}


os_info
cpu_info
network_info
user_info
