container_name="packstack"

function lv_create {
    size=$1
    loopdev=$(losetup -f)
    dd if=/dev/zero of=/tmp/cinder-volumes bs=1 count=0 seek=${size}G
    losetup ${loopdev} /tmp/cinder-volumes
    pvcreate ${loopdev}
    vgcreate cinder-volumes ${loopdev}
    lvcreate -T -L 2g cinder-volumes/cinder-volumes-pool
}

function lv_remove {
    lvremove cinder-volumes/cinder-volumes-pool -y
    for pv in $(pvdisplay -qC | grep dev | awk -e '{print $1}') ; do pvremove $pv --force --force -y ; done
    pvremove cinder-volumes -y
    vgremove cinder-volumes -y
    rm -rf /dev/cinder-volumes
    rm -rf /tmp/cinder-volumes
}

function get_osp_services {
   systemctl | grep -P "neutr|openstack|mariadb|glance|rabbit|libv|httpd" | awk '{print $1}'
}

function healthcheck {
   echo "systemctl state is $(systemctl is-system-running)"
   for svc in `get_osp_services`; do
    echo " $(systemctl status $svc | head -n 3)"
    echo " $(systemctl status $svc | grep Memory)"
   done
}

function source_keystonerc {
    docker cp ${container_name}:/root/keystonerc_admin keystonerc_admin
    source keystonerc_admin
    rm -rf keystonerc_admin
}
function openstack_wrapper {
    command=$@
    cat<<EOF >/tmp/test.cmd
    #!/bin/bash
    source /root/keystonerc_admin
    openstack ${command}
EOF
docker cp /tmp/test.cmd ${container_name}:/test.sh
docker exec -i ${container_name} bash /test.sh
}


function run_command {
    command=$@
    docker cp hack/utils.sh ${container_name}:/utils.sh 
    docker exec -i ${container_name} bash<<EOF
source /utils.sh
$command
EOF
}

function openstack_container {
    command=$@

    openstack_wrapper "$command"
}

