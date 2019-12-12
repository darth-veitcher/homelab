Configuration for RancherOS is performed by a `cloud-init` file.

The main things we want to do is enable the `kernel-headers` services (so that we can run wireguard later on) and then install our configuration via a yaml file.

```bash
sudo ros service enable kernel-headers
sudo ros service enable kernel-headers-system-docker
```

This can be added to a `cloud-init` file. Running `sudo ros config export` will show the actual settings to add.

```bash hl_lines="6 7 8"
$ sudo ros config export

rancher:
  environment:
    EXTRA_CMDLINE: /init
  services_include:
    kernel-headers: true
    kernel-headers-system-docker: true
ssh_authorized_keys: []
```

Whilst each individual node will potentially have some different configurations for the likes of physcial networking we will have a section at the top that simply enables wireguard.

```yaml
rancher:
    # Load Kernel module for wireguard
    modules: [wireguard]
```

We also want to install a compatible docker version

```yaml
rancher:
  # https://rancher.com/docs/os/v1.x/en/installation/configuration/switching-docker-versions/
  docker:
    engine: docker-18.09.9
```