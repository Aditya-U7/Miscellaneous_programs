: 'Author : Aditya Upadhye 

This is a bash implementation of a countdown timer using 'sleep' only to find out it is inaccurate. Expect a time delay of at least 3 seconds after a while.

Input format:

1 1 5 

where the first column is hours, second is minutes, and the last one is seconds.

'


#!/bin/bash

hours=0
minutes=0
seconds=0


user_input()
{

	echo "Enter the timer values in hours, minutes and seconds:"
	read hours minutes seconds
	printf "\\n"

}


range_check()
{

	while true
	do
		if [[ $hours -gt 23 || $hours -lt 0 ]]
		then
		        echo "Invalid hours entry: $hours"
		        read -p "Re-enter hours: (0-23)" hours
		
                elif [[ $minutes -gt 59 || $minutes -lt 0 ]]
		then
			echo "Invalid minutes entry:  $minutes"
			read -p "Re-enter minutes: (0-59)" minutes
			
                elif [[ $seconds -gt 59 || $seconds -lt 0 ]]
		then
			echo "Invalid seconds entry:  $seconds"
			read -p "Re-enter seconds: (0-59)" seconds      
		
		else
			break
		fi
		
		printf "\\n\\n"

	done

}


seconds_counter()
{

	while true
	do
		printf "%02d : %02d : %02d\r" "$hours" "$minutes" "$seconds"
		sleep 1
		((--seconds))
		if [[ $seconds -eq -1 ]] 	
		then 
			seconds=0
			break
		fi

	done
	
}


minutes_counter()
{

	while [[ $minutes -ge 0 ]]
	do
		seconds_counter
		((--minutes))
		
		if [[ $minutes -eq -1 ]]
		then 
			minutes=0
			break
		else
			seconds=59
			continue
		fi
	done

}


hours_counter()
{

	while [[ $hours -ge 0 ]]
	do 

		minutes_counter
		((--hours))
		if [[ $hours -eq -1 ]]
		then 
			hours=0
			break
		else
			minutes=59
			seconds=59
			continue
		fi
	done

}


timer()
{

	if [[ $hours -gt 0 ]]
	then
		hours_counter		
	elif [[ $minutes -gt 0 ]]
	then 
		minutes_counter
	elif [[ $seconds -gt 0 ]]
	then
		seconds_counter
	fi        

}        


user_input
range_check 
timer 

printf "%02d :: %02d :: %02d" "$hours" "$minutes" "$seconds" 
printf "\\n\\nTime is over.\\n"
