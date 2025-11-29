: 'Author: Aditya Upadhye

This is a bash program to display basic information about your system. For network information to be shown, your system needs to support 'nmcli' command.

'

#!/bin/bash


os_info()
{

	local os_name="$(uname -o)"
	echo "Operating system: $os_name"

	local kernel_name="$(uname -s)"
	echo "Kernel name: $kernel_name"

	local kernel_version="$(uname -r)"
	echo "Kernel version: $kernel_version"

}


cpu_info()
{

	local property_names=("Model name" "Byte Order" "Architecture")

	declare -A cpu_info

	for i in "${property_names[@]}"
	do 

		cpu_info["$i"]="$(lscpu | grep "$i" | cut -d':' -f2)"
		cpu_info["$i"]=${cpu_info["$i"]##*( )}

	done

	for key in "${!cpu_info[@]}"
	do
		echo "$key: ${cpu_info[$key]}"
	done

}


network_info()
{

	nmcli dev show &>/dev/null

	if [[ $? -eq 0 ]]
	then

		local connected_state="$(nmcli connection show --active | grep -v loopback | grep -v UUID | cut -d' ' -f1)"
		if [[ -n $connected_state ]]
		then 
			local network_name="$(nmcli dev show | grep -m 1 "GENERAL.CONNECTION" | cut -d':' -f2)"
			network_name="${network_name##*( )}"
			echo "Connected Network Name: $network_name"

			local network_status="$(nmcli networking connectivity)"
			if [[ $network_status == "full" ]]
			then
				echo "Internet status of $network_name: Active"
			else
				echo "Internet status of $network_name: Not active"
			fi

			local dns_server_ipv4="$(nmcli dev show | grep "IP4.DNS" | cut -d':' -f2)"
			local dns_server_ipv6="$(nmcli dev show | grep "IP6.DNS" | cut -d':' -f2-)"

			dns_server_ipv4="${dns_server_ipv4##*( )}"
			dns_server_ipv6="${dns_server_ipv6##*( )}"
			if [[ -n $dns_server_ipv4 ]]
			then
				echo "DNS IPv4: $dns_server_ipv4"
			fi
			if [[ -n $dns_server_ipv6 ]]
			then
				echo  "DNS IPv6: $dns_server_ipv6"
			fi

		else 
			echo "Network info: not connected to a network"
		fi

	else
		echo "Not available to fetch network info."

	fi

}


user_info()
{

	local current_user_name="$(whoami)"
	local current_users="$(who | cut -d' ' -f1 | sort | uniq)" 
	local system_name="$(hostname)"
	echo "Current user name: $current_user_name"
	echo "Logged in user(s): $current_users"
	echo "System name: $system_name"

}


os_info
cpu_info
network_info
user_info
