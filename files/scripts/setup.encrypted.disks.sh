#!/bin/sh
# Wipes disks excluding the ROOT and USB keyfile and then encrypts them with the USB key.
# Needs to be run as root.
export ROOT_DISK=; \
export KEYFILE_DISK=g; \
export DISKS=$(sudo lsblk --scsi --noheadings --list --output KNAME | grep sd[^$KEYFILE_DISK^$ROOT_DISK]); \
echo $DISKS; \
echo "# DATA devices" | sudo tee -a /etc/crypttab
for d in $DISKS; do 
  sudo umount /dev/$d; \
  sudo wipefs -af /dev/$d; \
  sudo cryptsetup luksFormat -q -s 512 -c aes-xts-plain64 -d /mnt/key/.secretkey /dev/$d; \
  export BLKID=$(blkid -s UUID -o value /dev/$d); \
  sudo tee -a /etc/crypttab <<EOF
  data-${BLKID}  UUID=${BLKID}    /mnt/key/.secretkey    luks,retry=1,timeout=180
EOF
done;

# Now create a `/etc/default/cryptdisks` file so that `/mnt/key` is made available
# from fstab before `crypttab` is run.
sudo tee /etc/default/cryptdisks <<EOF
# /etc/default/cryptdisks
CRYPTDISKS_MOUNT='/mnt/key'
EOF