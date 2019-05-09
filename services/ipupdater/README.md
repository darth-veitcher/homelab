# AnonDNS updater
This is a very basic docker image to allow you to update a dynamic dns service from [AnonDNS.net](http://anondns.net) with your current ip address.

Usage:
```
docker run -e ANONDNS=<mydomain>.anondns.net -e TOKEN=<mysecuretoken> ipupdater
```