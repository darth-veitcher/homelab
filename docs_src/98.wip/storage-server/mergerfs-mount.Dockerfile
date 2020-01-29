FROM ubuntu as base
ENV DEBIAN_FRONTEND=noninteractive
ARG MERGERFS_RELEASE=2.28.3

RUN  mkdir -p /data; \
     apt-get update; \
     apt-get install -y wget fuse; \
     wget -O "/tmp/mergerfs.deb" \
          "https://github.com/trapexit/mergerfs/releases/download/"${MERGERFS_RELEASE}"/mergerfs_"${MERGERFS_RELEASE}".ubuntu-bionic_amd64.deb"; \
     dpkg -i "/tmp/mergerfs.deb"; \
# build info and cleanup
    apt-get -y autoremove; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    echo "Timestamp:" `date --utc` | tee /image-build-info.txt

# CMD ["mergerfs \
#           -o allow_other,use_ino \
#           /mnt/* \
#           /data"]
ENTRYPOINT [ "mergerfs" ]