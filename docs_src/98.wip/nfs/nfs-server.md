```bash
sudo apt-get install nfs-kernel-server -y
```

Now edit the `exports`

```bash
# file: /etc/exports
# Use * for everyone or just the internal IPs
# /mnt/unionfs/storage *(rw,fsid=1,no_root_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)
/mnt/unionfs/storage 10.244.0.0/16(rw,fsid=1,no_root_squash,insecure,async,no_subtree_check,anonuid=1000,anongid=1000)
```

Start the nfs server

```bash
sudo exportfs -ra
```