#!/bin/sh
# Wipes disks excluding the ROOT and USB keyfile and then encrypts them with the USB key.
# Needs to be run as root.
export ROOT_DISK=
export KEYFILE_DISK=a
DISKS=$(sudo lsblk --scsi --noheadings --list --output KNAME | grep sd[^$KEYFILE_DISK^$ROOT_DISK])
echo "\n# Configuring for:"
echo $DISKS

# Wipe
for d in $DISKS; do 
  sudo umount /dev/$d; \
  sudo wipefs -af /dev/$d; \
  sudo cryptsetup luksFormat -q -s 512 -c aes-xts-plain64 -d /mnt/key/.secretkey /dev/$d; 
done;

# Crypttab
echo "# DATA devices" | sudo tee -a /etc/crypttab
for d in $DISKS; do 
  export BLKID=$(sudo blkid -s UUID -o value /dev/$d); \
  export ROTA=$(sudo lsblk -n -o rota /dev/$d | sed "s/1/hdd/g" | sed "s/0/ssd/g" | sed "s/ //g"); \
  echo "data-${ROTA}-${BLKID}  UUID=${BLKID}    /mnt/key/.secretkey    luks,retry=1,timeout=180"  | sudo tee -a /etc/crypttab; 
done;

# Now create a `/etc/default/cryptdisks` file so that `/mnt/key` is made available
# from fstab before `crypttab` is run.
sudo tee /etc/default/cryptdisks <<EOF
# /etc/default/cryptdisks
CRYPTDISKS_MOUNT='/mnt/key'
EOF