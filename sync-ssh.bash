#!/bin/bash
#This script syncs the ssl keys down to the proxied server
#start this script as systemctl process
#use included systemctl file
# apt install inotify-tools
CERT_PATH_HOST="/root/proxy-manager/letsencrypt/live/" # path of the certs on the current machine,should end with wildcard or file 
SSH_KEYFILE="/root/.ssh/id_rsa" # key that is authed to target server
SSH_TARGET="root@192.168.178.81:/ssl/cert" # target sever:path (rsync)
SCRIPT_DIR="/root/ssl-sync/"
echo $SCRIPT_DIR;
rm -rf $SCRIPT_DIR/tmp-sync
while inotifywait -r $CERT_PATH_HOST; do
     mkdir $SCRIPT_DIR/tmp-sync
     rsync -avL $CERT_PATH_HOST tmp-sync/ # Resolve Symlinks
     cd tmp-sync
     mv npm-11 wildcard.galli.site
     mv npm-13 galli.site
     cd ..
     rsync -av --delete -e "ssh -i $SSH_KEYFILE" $SCRIPT_DIR/tmp-sync/ $SSH_TARGET
     echo 
     rm -rf $SCRIPT_DIR/tmp-sync
done
