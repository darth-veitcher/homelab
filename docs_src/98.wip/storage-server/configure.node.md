wget -q -O- 'https://download.ceph.com/keys/release.asc' | sudo apt-key add -; \
echo deb https://download.ceph.com/debian-nautilus/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list; \
sudo apt-get update && sudo apt install ceph-common -y

# Create a user for the `nodes`
See [advanced docs](https://github.com/rook/rook/blob/release-1.2/Documentation/ceph-advanced-configuration.md)
```bash
ceph auth get-or-create-key client.nodes \
  mon 'allow r' \
  osd 'allow rw tag cephfs pool=YOUR_FS_DATA_POOL' \
  mds 'allow r, allow rw path=/bar' \
  > /etc/ceph/keyring.nodes

ceph-authtool /etc/ceph/keyring.nodes -p -n client.nodes
```

Now save as a kubernetes secret

```bash
kubectl create secret generic ceph-nodes-secret --from-literal=key=YOUR_CEPH_KEY
```

# Use the direct mount trick with a local drive


# Mount

mount -a



References:
https://geek-cookbook.funkypenguin.co.nz/ha-docker-swarm/shared-storage-ceph/
https://rook.io/docs/rook/v1.1/direct-tools.html#shared-filesystem-tools