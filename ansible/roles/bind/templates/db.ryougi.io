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
ns1.ryougi.io.         IN      A       192.168.1.1
ns2.ryougi.io.         IN      A       192.168.1.2

; 10.128.0.0/16 - A records
prox.ryougi.io.        IN      A      192.168.0.73
nas.ryougi.io.         IN      A      192.168.0.23
router.ryougi.io.      IN      A      192.168.0.1

; Kube Records
kube1.ryougi.io.      IN      A      192.168.0.86
kube2.ryougi.io.      IN      A      192.168.0.89
kube11.ryougi.io.      IN      A      192.168.0.100
kube12.ryougi.io.      IN      A      192.168.0.101
kube13.ryougi.io.      IN      A      192.168.0.102

; Kube Services
plex.ryougi.io.          IN      A      192.168.0.89
plex.ryougi.io.          IN      A      192.168.0.86
terraria.ryougi.io.      IN      A      192.168.0.89
terraria.ryougi.io.      IN      A      192.168.0.86
minecraft.ryougi.io.     IN      A      192.168.0.89
minecraft.ryougi.io.     IN      A      192.168.0.86
satisfactory.ryougi.io.  IN      A      192.168.0.89
satisfactory.ryougi.io.  IN      A      192.168.0.86
game.ryougi.io.          IN      A      192.168.0.89
game.ryougi.io.          IN      A      192.168.0.86
