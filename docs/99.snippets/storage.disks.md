# How to setup encrypted disks for usage by Ceph
If Rook determines that a device is not available (has existing `partitions` or a formatted `file system`) then it will skip consuming the devices. As a result we need to encrypt the disk and leave it without partitions or a filesystem for it to be read correctly.

Finding the relevant disks is done with `lsblk`.

??? info "example lsblk"
    ```bash
    $ lsblk 
    NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
    loop0    7:0    0  89.1M  1 loop /snap/core/8039
    loop1    7:1    0  88.5M  1 loop /snap/core/7270
    sda      8:0    0 111.3G  0 disk 
    ├─sda1   8:1    0     1M  0 part 
    └─sda2   8:2    0 111.3G  0 part /
    sdb      8:16   0   1.8T  0 disk 
    sdc      8:32   0   1.8T  0 disk 
    sr0     11:0    1  1024M  0 rom 
    ```

```bash
# Create a keyfile (for automounting when plugged in)
# This will take a number of minutes...
dd if=/dev/random of=/root/secretkey bs=1 count=4096
chmod 0400 /root/secretkey

# Set the disk
export d=sdb
export DISK=/dev/${d}

# Reset using fdisk (write new GPT and single partition)
printf "g\nn\n1\n\n\nw\n" | sudo fdisk "${DISK}"

# Encrypt the partition
cryptsetup luksFormat -s 512 -c aes-xts-plain64 ${DISK}1
# Add the keyfile
cryptsetup luksAddKey ${DISK}1 /root/secretkey
# Open and format
cryptsetup open open -d /root/secretkey ${DISK}1 luks-${d}
mkfs.btrfs -f -L DATA /dev/mapper/luks-${d}

# Mount
mkdir -p /mnt/${BLKID}
mount -t btrfs -o defaults,noatime,compress=lzo,autodefrag /dev/mapper/luks-$d /mnt/${BLKID}
```

#### Auto-mount encrypted devices at boot
We'll now configure the system to automatically unlock the encrypted partitions on boot. Edit the `/etc/crypttab` file to provide the nexessary information. For that we'll need the `UUID` for each block device which can be found from the `blkid` command. For more details on the principles and processes behind the below see the excellent [Arch Wiki](https://wiki.archlinux.org/index.php/Dm-crypt/System_configuration#crypttab).

>The `/etc/crypttab` (encrypted device table) file is similar to the `fstab` file and contains a list of encrypted devices to be unlocked during system boot up. This file can be used for automatically mounting encrypted swap devices or secondary file systems.
>
>`crypttab` is read before `fstab`, so that `dm-crypt` containers can be unlocked before the file system inside is mounted.

```bash
# Get the UUID
export d=sdb
export DISK=/dev/${d}
export BLKID=$(blkid ${DISK}1 | awk -F'"' '{print $2}')

# Now edit the crypttab
# file: /etc/crypttab
# Fields are: name, underlying device, passphrase, cryptsetup options.
# The below mounts the device with UUID into /dev/mapper/data-uuid and unlocks using the secretkey
echo "data-${BLKID}  UUID=${BLKID}    /root/secretkey    luks,retry=1,timeout=180" >> /etc/crypttab

# Add to fstab
# file: /etc/fstab
echo "/dev/mapper/data-${BLKID}        /data/${BLKID}   btrfs        defaults        0       2" >> /etc/fstab
```
