Useful snippets of code for interfacing with Kubernetes

# Wiping a kubernetes installation and starting again
Because sometimes stuff goes wrong...

```bash
kubeadm reset; \
sudo apt-get -y purge kubeadm kubectl kubelet kubernetes-cni kube*; \
sudo apt-get -y autoremove; \
sudo rm -rf ~/.kube; \
sudo rm -rf /etc/kubernetes; \
sudo rm -rf /opt/cni/bin; \
sudo rm -rf /var/lib/etcd

sudo shutdown -r now

sudo apt-get update; \
sudo apt-get install -y kubelet kubeadm kubectl
sudo kubeadm init \
    --pod-network-cidr=10.244.0.0/16 \
    --apiserver-advertise-address $(ip -4 addr show wg0 | grep inet | awk '{print $2}' | awk -F/ '{print $1}')
```
To also ensure that `rook` configuration has been removed 
```bash
sudo rm -rf /var/lib/rook/*
```

# Getting the IP address of a node
```bash
export NODE_NAME=banks
kubectl get node ${NODE_NAME} -o jsonpath='{.status.addresses[0].address}'
```

# Kill a namespace stuck as "Terminating"
See: https://stackoverflow.com/a/53661717/322358

```bash
export NAMESPACE=your-rogue-namespace
kubectl proxy &
kubectl get namespace $NAMESPACE -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
```