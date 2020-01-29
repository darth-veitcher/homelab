FROM alpine
RUN apk add --no-cache ceph-common

ENV MON_ENDPOINTS=
ENV KEYCHAIN_SECRET=
ENV MDS_NAMESPACE=rook-ceph
ENV USERNAME=admin

CMD [ "mount -t ceph -o mds_namespace=${MDS_NAMESPACE},name=${USERNAME},secret=${KEYCHAIN_SECRET} ${MON_ENDPOINTS}:/ /data" ]