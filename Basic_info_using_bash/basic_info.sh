: 'Author: Aditya Upadhye

This is bash program to display basic information about your system. For network information to be shown, your system needs to support 'nmcli' command.

'

#!/bin/bash


os_info()
{

	os_name="$(uname -o)"
	echo "Operating system: $os_name"

	kernel_name="$(uname -s)"
	echo "Kernel name: $kernel_name"

	kernel_version="$(uname -r)"
	echo "Kernel version: $kernel_version"

}


cpu_info()
{

	cpu_name="$(lscpu | grep "Model name" | cut -d':' -f2)"
	cpu_name="${cpu_name##*( )}"
	cpu_byte_order="$(lscpu | grep "Byte Order" | cut -d':' -f2)"
	cpu_byte_order="${cpu_byte_order##*( )}"
	architecture="$(lscpu | grep "Architecture" | cut -d':' -f2)"
	architecture="${architecture##*( )}"

	echo "CPU name: $cpu_name"
	echo "Byte order: $cpu_byte_order"
	echo "Architecture: $architecture"

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
			echo "Connected Network Name: $network_name"

			network_status="$(nmcli networking connectivity)"
			if [[ $network_status == "full" ]]
			then
				echo "Internet status of $network_name: Active"
			else
				echo "Internet status of $network_name: Not active"
			fi

			dns_server_ipv4="$(nmcli dev show | grep "IP4.DNS" | cut -d':' -f2)"
			dns_server_ipv6="$(nmcli dev show | grep "IP6.DNS" | cut -d':' -f2-)"

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

	current_user_name="$(whoami)"
	current_users="$(who | cut -d' ' -f1 | uniq)" 
    system_name="$(hostname)"
	echo "Current user name: $current_user_name"
	echo "Logged in user(s): $current_users"
    echo "System name: $system_name"


}


os_info
cpu_info
network_info
user_info
