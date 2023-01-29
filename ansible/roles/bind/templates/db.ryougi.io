;
; BIND data file for ryougi.io
;
$TTL	604800
@           10800 IN	SOA	ns1.ryougi.io. admin.ryougi.io. (
			      {{ __bind9_zone_serial }}	; Serial
			      604800		; Refresh
			      86400		  ; Retry
			      2419200		; Expire
			      604800 )	; Negative Cache TTL
;
; name servers - NS records
                         IN      NS      ns1.ryougi.io.
                         IN      NS      ns2.ryougi.io.

; name servers - A records
ns1.ryougi.io.           IN      A       192.168.1.254
ns2.ryougi.io.           IN      A       192.168.1.253

; Physical/Virtual equipment
pfsense.ryougi.io.        IN      A      192.168.1.1
prox.ryougi.io.          IN      A      192.168.1.10
nas.ryougi.io.           IN      A      192.168.1.20
tower.ryougi.io.           IN      A      192.168.1.20
router.ryougi.io.        IN      A      192.168.1.1
kumori.ryougi.io.        IN      A      192.168.1.11
fgmb.ryougi.io.          IN      A      192.168.1.15
kumori.linux.ryougi.io.  IN      A      192.168.1.14
unifi.ryougi.io.         IN      A      192.168.1.200

; Kubernetes
kube1.ryougi.io.         IN      A      192.168.1.50
kube2.ryougi.io.         IN      A      192.168.1.51
kube-master1.ryougi.io.  IN      A      192.168.1.65
kube-master2.ryougi.io.  IN      A      192.168.1.66
rancher.ryougi.io.       IN      A      192.168.1.60
rancher1.ryougi.io.      IN      A      192.168.1.60


; Kube Services
terraria.ryougi.io.      IN      A      192.168.1.50
minecraft.ryougi.io.     IN      A      192.168.1.50
satisfactory.ryougi.io.  IN      A      192.168.1.50
game.ryougi.io.          IN      A      192.168.1.50
qbt.ryougi.io.           IN      A      192.168.1.50
radarr.ryougi.io.        IN      A      192.168.1.50
sonarr.ryougi.io.        IN      A      192.168.1.50
prowlarr.ryougi.io.      IN      A      192.168.1.50
flaresolverr.ryougi.io.  IN      A      192.168.1.50
overseerr.ryougi.io.     IN      A      192.168.1.50
heimdall.ryougi.io.      IN      A      192.168.1.50
ryougi.io.               IN      A      192.168.1.50
bruna.ryougi.io.         IN      A      192.168.1.50
plex.ryougi.io.          IN      A      192.168.1.50

; MetalLB - 192.168.2.0/24
; Required for TV, It needs a direct IP
plex.static.ryougi.io.        IN      A      192.168.2.10

terraria.ryougi.io.           IN      A      192.168.2.13

; Required as it must use host networking due to k8s NAT
factorio.static.ryougi.io.    IN      A      192.168.2.11
factorio2.static.ryougi.io.   IN      A      192.168.2.12
