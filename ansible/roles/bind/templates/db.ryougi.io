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
ns1.ryougi.io.           IN      A       192.168.1.1
ns2.ryougi.io.           IN      A       192.168.1.2

; physical equipment
prox.ryougi.io.          IN      A      192.168.0.73
nas.ryougi.io.           IN      A      192.168.0.23
router.ryougi.io.        IN      A      192.168.0.1
kumori.ryougi.io.        IN      A      192.168.0.13

; Kube Records
kube1.ryougi.io.         IN      A      192.168.1.100
kube2.ryougi.io.         IN      A      192.168.1.101
kube3.ryougi.io.         IN      A      192.168.1.102
kube-master1.ryougi.io.  IN      A      192.168.1.90
kube-master2.ryougi.io.  IN      A      192.168.1.91

rancher1.ryougi.io.      IN      A      192.168.1.10
rancher2.ryougi.io.      IN      A      192.168.1.11

; Kube Services
plex.ryougi.io.          IN      A      192.168.1.100
plex.ryougi.io.          IN      A      192.168.1.100
terraria.ryougi.io.      IN      A      192.168.1.100
terraria.ryougi.io.      IN      A      192.168.1.100
minecraft.ryougi.io.     IN      A      192.168.1.100
minecraft.ryougi.io.     IN      A      192.168.1.100
satisfactory.ryougi.io.  IN      A      192.168.1.100
satisfactory.ryougi.io.  IN      A      192.168.1.100
game.ryougi.io.          IN      A      192.168.1.100
game.ryougi.io.          IN      A      192.168.1.100
