Useful snippets for interacting with Ceph.

# Toolbox
Connect to the toolbox
```bash
kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
```

You can then run commands such as `ceph device ls`

# Normal
If you don't have any devices or OSDs created check what's happening during startup. See [docs](https://rook.io/docs/rook/v1.1/ceph-common-issues.html#osd-pods-are-not-created-on-my-devices)

```bash
# get the prepare pods in the cluster
$ kubectl -n rook-ceph get pod -l app=rook-ceph-osd-prepare
NAME                                   READY     STATUS      RESTARTS   AGE
rook-ceph-osd-prepare-node1-fvmrp      0/1       Completed   0          18m
rook-ceph-osd-prepare-node2-w9xv9      0/1       Completed   0          22m
rook-ceph-osd-prepare-node3-7rgnv      0/1       Completed   0          22m

# view the logs for the node of interest in the "provision" container
$ kubectl -n rook-ceph logs rook-ceph-osd-prepare-node1-fvmrp provision
```

# Remove and wipe
```bash
kubectl delete -f ~/rook/toolbox.yaml; \
kubectl delete -f ~/rook/cluster.yaml; \
kubectl delete -f ~/rook/operator.yaml; \
kubectl delete -f ~/rook/common.yaml; \
kubectl delete namespace rook-ceph; \
rm -rf ~/rook; \
sudo rm -rf /var/lib/rook/*
```