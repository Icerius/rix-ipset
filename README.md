# RIX IPSet
This script populates an ipset with the icelandi ip numbers from RIX. One ipset contains the IPv4 and the other contains the IPv6.
If the either ipset does not exist it is ignored.

## Setup on linux 
```bash
chmod 0700 rix-ipset.sh
ipset create rixv4
ipset create rixv6
./rix-ipset.sh
```
Add a cronjob to run the script regularly as root

## Setup on EdgeOS
### As user
```bash
configure
set firewall group address-group rixv4
set firewall group ipv6-address-group rixv6
set system task-scheduler task rix-ipset executable path /config/scripts/post-config.d/rix-ipset.sh
set system task-scheduler task rix-ipset interval 1d
commit
save
```
### As root
Put the script in /config/scripts/post-config.d to make sure that the ipset is populated on reboot and run it once to initialize
```bash
chown root /config/scripts/post-config.d/rix-ipset.sh
chmod 0700 /config/scripts/post-config.d/rix-ipset.sh
/config/scripts/post-config.d/rix-ipset.sh
```
