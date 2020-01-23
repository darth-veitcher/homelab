Some good stuff here https://github.com/MoJo2600/pihole-kubernetes/tree/master/classic

Particularly make sure that we launch in the right order from manifests

kubectl apply -f pihole-secret-webpassword.yaml
kubectl apply -f pihole-configmap-custom-dnsmasq.yml
kubectl apply -f pihole-deployment.yml
kubectl apply -f pihole-svc.yml
