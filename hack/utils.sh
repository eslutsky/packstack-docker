container_name="packstack"

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

function run_sh {
    command=$1
    docker exec -i ${container_name} $command
}

function run_command {
    command=$1
    docker cp hack/utils.sh ${container_name}:/utils.sh 
    docker exec -i ${container_name} bash<<EOF
source /utils.sh
$command
EOF
}

function openstack {
    command=$@
	run_sh bash<<EOF
source /root/keystonerc_admin
openstack "$command"
EOF
}

