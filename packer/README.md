
# Packer

# Boot
Boot wait time will have to change based on how fast the VM start, you want to make sure cancel the "new" boot path since ubuntu 18 and drop to the old one

## WSL
Since this is running in WSL we have a bit of IP fuckery when the vm tries to connect to the http server inside wls

Have to set the boot_command to be our host IP not wsl IP
To proxy traffic to wsl on port 5000, we set the XXXX port to whatever packer picks
```
netsh advfirewall firewall add rule name="Allowing LAN connections" dir=in action=allow protocol=TCP localport=5000
netsh interface portproxy add v4tov4 listenport=5000 listenaddress=0.0.0.0 connectport=XXXX connectaddress=<WSL IP>
```

