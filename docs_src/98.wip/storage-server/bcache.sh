# sda+sdb = HDDs
# sdc+sdd = SSDs

# Partition SSDs
echo "2\no\ny\nn\n\n\n+100M\nef00\nn\n\n\n+200M\n\nn\n\n\n+16G\n8200\nn\n\n\n\nfd00\np\nw\ny\n" | gdisk /dev/sdc

sgdisk --backup=table /dev/sdc

sgdisk --load-backup=table /dev/sdc
partprobe /dev/sdc

sgdisk --load-backup=table /dev/sdd
partprobe /dev/sdd

# Create RAID1 on SSDs
mdadm --create /dev/md0 --level=1 --metadata=1.2 --raid-devices=2 /dev/sd[cd]4

# Create cache against entire HDDs using the SSD RAID1 device
make-bcache --wipe-bcache --writeback -B /dev/sd[ab] -C /dev/md0

# Format non-RAID partitions on SSDs
mkfs.vfat -F 32 /dev/sdc1
mkfs.ext3 -L boot /dev/sdc2
mkswap -L swap_c /dev/sdc3
swapon /dev/sdc3

mkfs.vfat -F 32 /dev/sdd1
mkfs.ext3 -L boot /dev/sdd2
mkswap -L swap_d /dev/sdd3
swapon /dev/sdd3

# Create matching btrfs RAID1 on cache devices
mkfs.btrfs -f -d raid1 /dev/bcache0 /dev/bcache1

# Mount one cache device to /mnt
mount /dev/bcache0 /mnt/

# Create folder structure
btrfs subvolume create /mnt/home

mkdir /mnt/boot
mount  /dev/sdc2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sdc1 /mnt/boot/efi
