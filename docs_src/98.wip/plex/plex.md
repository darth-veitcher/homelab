Get your claim token from [here](https://www.plex.tv/claim)

Now encode it into the secret

```bash
API_TOKEN_CLEAN=claim-superdupersecret
API_TOKEN_OPAQUE=$(echo -n ${API_TOKEN_CLEAN} | base64)

tee plex-claim.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  name: plex-claim-token
  namespace: media
type: Opaque
data:
  token: ${API_TOKEN_OPAQUE}
EOF
```