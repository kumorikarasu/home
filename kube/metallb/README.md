
## MetalLB Installation

Router has to be configured to support bgp ahead of time, Current router config already has this

```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.4/config/manifests/metallb-native.yaml
kubectl apply -f metallb-bgp-config.yaml
```
