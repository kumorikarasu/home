FROM chatwork/sops:3.7.1 as sops



FROM alpine/helm:3.10.2 as helm

COPY --from=sops /usr/local/bin/sops /usr/local/bin/sops
