#!/bin/bash

#set the correct IP address
packstack --answer-file=/packstack.answer

#run host rediscovery in openstack yoga due to https://bugs.launchpad.net/packstack/+bug/1673305
nova-manage cell_v2 discover_hosts
