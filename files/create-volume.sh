#!/bin/bash

source /root/keystonerc_admin

nova-manage cell_v2 discover_hosts

# create cinder empty volume
openstack volume create --size 1 empty_volume

# create cinder volume from image
openstack volume create --image cirros --size 1 cirros-volume

# boot VM instance from volume
openstack server create --flavor m1.tiny --volume cirros-volume cirros-volume
sleep 5
openstack volume list 


