IP=192.168.0.69
PORT=5013
RSYNC="ssh -p $PORT"
FOLDERS=(Applications/ Archive/ Documents/ Emulators/ Library/ Music/ Projects/ Scripts/ Sync/ Vaults/ .ssh/)
LOCATION=/home/aeron

# Functions

# Checking wether my Backup PC is on
function ping_host() {
	nmap -p $PORT $IP
	printf "\n"

	if [[ $? -eq 0 ]]
	then
		echo -e "Host is up!... Continuing \n"
		sleep 3
		return 0
	else
		echo -e "Host is down!... Exiting\n"
		sleep 3
		return 1
	fi
}

# Archive the files into a .7z
function archiving() {
	read -p "Delete earlier archive? (y) (n): " confirm
	if [[ $confirm == [yY] ]]
	then
		printf "Deleting current "; printf "$s" "${HOME}"; printf "Backup.7z"
		echo -e "\n"
		rm $LOCATION/Backup.7z
		sleep 3
	else
		echo -e "Using existing Archive..."
		sleep 1
		return 0
	fi

	printf "Compressing the following folders: \n" ; printf "%s\n" "${FOLDERS[@]}"
	sleep 3
	cd $LOCATION
	7z a "Backup.7z" ${FOLDERS[*]}
		
	if [[ $? -eq 0 ]]
	then
		echo -e "Archiving complete!\n"
		return 0
		sleep 3
	else
		echo -e "Error in Archiving!\n"
		return 1
		sleep 3
	fi
}

# Try to rsync trough ssh in the port specified in $PORT
function rsync_into_host() {
	echo -e "Starting transfer files to $IP with the port: $PORT\n"
	sleep 3
	rsync -e "$RSYNC" -aP $LOCATION/Backup.7z aeron@$IP:~/Backups/

	if [[ $? -eq 0 ]]
		then
			echo -e "Backup Complete!\n"
			return 0
			sleep 3
		else
			echo -e "Error in Backup!\n"
			return 1
			sleep 3
		fi
}

# "Main"
echo -e "Starting backup script for local network!\n"

# Check the return codes to allow execution or exit
# Very primitive way of error handling but it works :)
ping_host
if [[ $? -eq 0 ]]
then
	archiving
	if [[ $? -eq 0 ]] 
	then
		rsync_into_host
	else
		exit
	fi
else
	exit
fi
