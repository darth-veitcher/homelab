# Dynamic DNS
I'm going to use [AnonDNS](https://anondns.net) for a dynamic IP resolution to get me from the public internet back to the house.

With a fairly straightforward `updater` image we can then poll an API from [ipify](https://www.ipify.org) on a scheduled basis to keep this external record in sync if we have our IP address changed by our ISP.