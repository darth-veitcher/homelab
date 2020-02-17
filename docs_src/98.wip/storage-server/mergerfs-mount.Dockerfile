# Run this after
# docker run -v /tmp:/build --rm -it trapexit/mergerfs-static-build && cp /tmp/mergerfs .
FROM alpine as base
COPY mergerfs /usr/local/bin/mergerfs
RUN  apk -U add ca-certificates fuse wget && rm -rf /var/cache/apk/*; \
# build info and cleanup
    echo "Timestamp:" `date --utc` | tee /image-build-info.txt
ENTRYPOINT [ "mergerfs" ]