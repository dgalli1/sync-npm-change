# Companion Script for Nginx-Proxy-Manager

Some applications need direct access to ssl certs because they serve other protocols then https (e.x Matrix/LDAP etc)

This script syncs the certs to an other server so that you can acces the certs directly


* Auth your local ssh key to target server
* Edit sync-ssh.bash script for your server
* Install systemctl task (cp sync-npm-ssh.service /etc/systemd/system/)
* Start systemctl task (systemctl enable --now sync-npm-ssh)
