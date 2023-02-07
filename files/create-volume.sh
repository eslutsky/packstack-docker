#!/bin/bash

source /root/keystonerc_admin

nova-manage cell_v2 discover_hosts

openstack volume create --size 1 cirros_root_disk
sleep 20
openstack volume list 
vgdisplay
lvdisplay

#systemctl status openstack-losetup.service
cat /var/log/cinder/volume.log

