: 'Author: Aditya Upadhye

This is a bash program for creating a backup of a directory in a specified directory with compressed backup containing the name, date and time.

Running the file:

bash backup.sh path_to_directory_to_be_compressed path_to_destination_directory

Will work if your directory name does not contain spaces as $# then will interpret it as an extra argument. 

'


#!/bin/bash


verify_no_of_arguments()
{

	flag=1

	if [[ $# -lt 2 ]]
	then
		echo "Not enough arguments."
	elif [[ $# -gt 2 ]]
	then 
		echo "More than 2 arguments."
	else
		flag=0
	fi

	return $flag

}


verify_both_directories()
{

	valid_dir=1

	if [[ ! -d "$1" && ! -d "$2" ]]
	then
		echo "$1 and $2 are not directories."

	elif [[ ! -d "$1" ]]
	then 
		echo "$1 is not a directory."
	elif [[ ! -d "$2" ]]
	then
		echo "$2 is not a directory."
	else    
		valid_dir=0
	fi

	return $valid_dir

}


backup()
{

	args_mesg="$(verify_no_of_arguments "$@")"
	args_status=$?
    dir_status=1
	
	if [[ $args_status -eq 0 ]]
	then
		dir_mesg="$(verify_both_directories "$1" "$2")"
		dir_status=$?
	fi

	if [[ $dir_status -eq 0 ]]
	then
		dir="$1"
		destination="$2"

		echo "Creating backup..."
		dat="$(date +%Y-%m-%d-[%T])"
		tar -cvzf "$destination/${dir##*/}-${dat}.tar.gz" "$dir/"

	else
		echo -n $args_mesg
		echo -n $dir_mesg
		echo -e "\nBackup failed."

	fi

}


backup $@

