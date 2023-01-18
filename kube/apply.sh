#Ingress
kubectl create namespace ingress
helm -n ingress upgrade -i nginx ingress-nginx/ingress-nginx --set controller.hostNetwork=true,controller.service.type="",controller.kind=DaemonSet,controller.extraArgs.default-ssl-certificate=default/cert-ryougi-ca

# Cert Manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml

# Godaddy webhook
mkdir -p ~/dev
git clone https://github.com/TomKeyte/godaddy-webhook.git ~/dev/godaddy-webhook
helm install -n cert-manager godaddy-webhook ~/dev/godaddy-webhook/deploy/helm

# Godaddy Secret
if [ -z $GODADDY_API_PASS ]; then
  kubectl -n cert-manager create secret generic godaddy-api-key --from-literal="token=$GODADDY_API_PASS"
fi

# Load Balancer
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.4/config/manifests/metallb-native.yaml
kubectl apply -f metallb/metallb-bgp-config.yaml

# Application namespace
kubectl create namespace apps

# Arr
kubectl -n apps apply -f arr

# Factorio
kubectl -n apps apply -f factorio
