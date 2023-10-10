#!/usr/bin/env bash
if [ "$#" -ne 7 ]; then
	echo "Usage : $0 <Instance Id> <Volume Id> <Device Name> <Region Name> <Rescue Instance Id> <Rescue Instance Volume Id> <Rescue device Name>"
        exit 1
fi


instance_id="$1"
volume_id="$2"
device_name="$3"
region_name="$4"
instance_id_2="$5"
volume_id_2="$6"
device_name_2="$7"
remote_server="ubuntu@54.214.207.19"

function exit_status() {
if [ "$1" -eq 0 ]; then
	echo "Successful"
else
	echo "Not Successful"
fi
}


echo -e '
The process to follow are:
1. Stop the affected instance.
2. Detach the volume.
3. Attach the affected volume to the rescue volume.
4. Create a new recovery directory in the "mnt" directory.
5. Mount the affected volume to the newly created directory.
6. Change directory to the ssh directory.
7. Copy the authorized_key file from the ssh directory to the newly mounted directory.
8. Unmount the created direcroty
9. Detach the drive from the recovery instance.
10. Attach the volume to the instance to recover.
'

echo "Lets get to work"
echo "Stopping the affected instance"
aws ec2 stop-instances --instance-ids "${instance_id}" --region "${region_name}"
exit_status $?
sleep 40

echo "Detaching affetcted instance volume"
aws ec2 detach-volume --instance-id "${instance_id}" --volume-id "${volume_id}" --region "${region_name}"
exit_status $?
sleep 30

echo "Attaching the affected volume to the rescue instance."
aws ec2 attach-volume --instance-id "${instance_id_2}" --volume-id "${volume_id}" --device "${device_name_2}" --region "${region_name}"
exit_status $?
sleep 30

echo "Logging into Rescue Server"
ssh "$remote_server" << EOF
echo "Checking if Disk is Attached"
lsblk
echo "Changing to Root user"
sudo su
echo "Cheandging Directory to 'mnt folder' and creating root-volume direcotory"
cd /mnt/ && mkdir root-volume
echo "Mounting Voulme to root-volume"
mount /dev/sdf /mnt/root-volume/
echo "Checking if Disk is Mounted"
df -h
echo "Copying authorized_keys file to new disk"
cd /home/ubuntu/.ssh
cat authorized_keys >> /mnt/root_volume/authorized_keys
echo "Removing the Attached Disk"
umount /mnt/root_volume/
exit
EOF

echo "Detaching the drive from the recovery instance."
aws ec2 detach-volume --instance-id "${instance_id_2}" --volume-id "${volume_id}" --region "${region_name}"
exit_status $?
sleep 30

echo "Attaching the volume to the instance to recover."
aws ec2 attach-volume --instance-id "${instance_id}" --volume-id "${volume_id}" --device "${device_name_1}" --region "${region_name}"
exit_status $?

echo "Starting the affected instance"
aws ec2 start-instances --instance-ids "${instance_id}" --region "${region_name}"
exit_status $?
sleep 30

echo -e "
- Recovery Completed. 
- You can now access the Server with the Recover Instance KEY
"
