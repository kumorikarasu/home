;
; BIND data file for ryougi.io
;
$TTL	604800
@           10800 IN	SOA	ns1.ryougi.io. admin.ryougi.io. (
			      4		      ; Serial
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
