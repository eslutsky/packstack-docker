#!/bin/bash

wget https://download.cirros-cloud.net/0.6.1/cirros-0.6.1-x86_64-disk.img -O /tmp/cirros-0.6.1.img

source /root/keystonerc_admin
  
openstack image create "cirros-0.6.1" --disk-format raw \
--container-format bare --public \
--file /tmp/cirros-0.6.1.img 

sleep 10

openstack server create --image cirros-0.6.1 --flavor m1.tiny --wait cirros