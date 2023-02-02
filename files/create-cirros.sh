#!/bin/bash

source /root/keystonerc_admin

nova-manage cell_v2 discover_hosts
sleep 2
wget https://download.cirros-cloud.net/0.6.1/cirros-0.6.1-x86_64-disk.img -O /tmp/cirros-0.6.1.img
openstack network create net-int
openstack subnet create sub-int --network net-int --subnet-range 192.0.2.0/24

openstack image create "cirros-0.6.1" --disk-format raw \
--container-format bare --public \
--file /tmp/cirros-0.6.1.img 

sleep 10

openstack server create --image cirros-0.6.1 --flavor m1.tiny --wait cirros --network net-int