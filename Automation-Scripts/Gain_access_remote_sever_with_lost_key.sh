#!/usr/bin/env bash

if [ "$#" -ne 7 ]; then
	echo "Usage : $0 <Instance Id> <Volume Id> <Device Name> <Region Name> <Rescue Instance Id> <Rescue Instance Volume Id> <Rescue device Name>"
        exit 1
fi

#Variables
instance_id="$1"
volume_id="$2"
device_name="$3"
region_name="$4"
instance_id_2="$5"
volume_id_2="$6"
device_name_2="$7"
remote_server="ubuntu@54.191.119.255"
success_steps=""

# Functions
function log_and_exit {
  local exit_code="$1"
  local message="$2"
  echo "$message"  # Print the message to the console
  echo "Exiting due to error."
  exit "$exit_code"
}

function execute_step {
  local command="$1"
  local step_description="$2"

  echo "$step_description"


  # Execute the command and capture its exit status
  eval "$command"
  local exit_code=$?

  if [ $exit_code -eq 0 ]; then
    echo "$step_description - Successful"
    success_steps+="$step_description"$'\n'
  else
    log_and_exit "$exit_code" "$step_description - Failed"
  fi
}

# Run set of Command to Restore Server Access
echo "Stoping the Affected instance"
execute_step 'aws ec2 stop-instances --instance-ids "${instance_id}" --region "${region_name}" ' "Step 1: Stoping the Affected instance"
sleep 40

echo "Detaching affetcted instance volume"
execute_step 'aws ec2 detach-volume --instance-id "${instance_id}" --volume-id "${volume_id}" --region "${region_name}"' "Step 2: Detaching affetcted instance volume"
sleep 40

echo "Attaching the affected volume to the rescue instance." 
execute_step 'aws ec2 attach-volume --instance-id "${instance_id_2}" --volume-id "${volume_id}" --device "${device_name_2}" --region "${region_name}"' "Step 3: Attaching the affected volume to the rescue instance."


# Connecting to remote server to execute some commands
echo "Connecting to remote server to exucute some commands"
ssh "$remote_server" << EOF
echo "updating server"
sudo apt-get update

echo "Checking if Disk is Attached"
lsblk

echo "Changing to Root user"
sudo su

echo 'Creating root-volume in "mnt direcotory"'
mkdir -p /mnt/root-volume
sleep 5

echo "Mounting Voulme to root-volume"
mount /dev/xvdf1 /mnt/root-volume/

echo "Checking if Disk is Mounted"
lsblk

echo "Copying authorized_keys file to new disk"
cat /home/ubuntu/.ssh/authorized_keys > /mnt/root-volume/home/ubuntu/.ssh/authorized_keys
echo "Copied authorized_keys file to new disk"
sleep 10


echo "Unmount the Root Volume"
umount /mnt/root-volume/
sleep 10

echo "Removing the root-volume directory"
sudo rm -rf /mnt/root-volume/

echo "Checking if Disk is Umounted"
lsblk

echo "Exiting Remote Server"
exit
EOF

echo "Detaching the drive from the recovery instance."
execute_step 'aws ec2 detach-volume --instance-id "${instance_id_2}" --volume-id "${volume_id}" --region "${region_name}"' "Step 13: Detaching the drive from the recovery instance."
sleep 30

echo "Attaching the volume to the instance to recover."
execute_step 'aws ec2 attach-volume --instance-id "${instance_id}" --volume-id "${volume_id}" --device "${device_name}" --region "${region_name}"' "Step 14: Attaching the volume to the instance to recover."
sleep 30

echo "Starting the affected instance"
execute_step 'aws ec2 start-instances --instance-ids "${instance_id}" --region "${region_name}"' "Step 15: Starting the affected instance"



# Check if all steps completed successfully
if [ $? -eq 0 ]; then
  echo "All steps completed successfully."
  echo "Successful steps:"
  echo "$success_steps"
else
  echo "One of the steps in the script failed. Exiting..."
fi
