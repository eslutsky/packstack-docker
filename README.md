

# Archived - this repo moved to https://github.com/kubev2v/packstack-img 


# this repo contains source code for building [packstack](https://github.com/redhat-openstack/packstack) container using docker

- build the container from src
    ```
    docker build .
    hack/run.sh
    docker exec -t packstack bash -x /deploy-packstack.sh
    docker commit packstack packstack-intalled
    ```


- running services healthcheck
    ```
    source hack/utils.sh ; run_command healthcheck
    systemctl state is running
    ● httpd.service - The Apache HTTP Server
    Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:09 UTC; 2h 58min ago
    Memory: 673.3M
    ● libvirtd.service - Virtualization daemon
    Loaded: loaded (/usr/lib/systemd/system/libvirtd.service; enabled; vendor preset: enabled)
    Active: active (running) since Thu 2023-02-02 06:04:09 UTC; 2h 58min ago
    Memory: 49.4M
    ● mariadb.service - MariaDB 10.3 database server
    Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:11 UTC; 2h 58min ago
    Memory: 208.7M
    ● neutron-dhcp-agent.service - OpenStack Neutron DHCP Agent
    Loaded: loaded (/usr/lib/systemd/system/neutron-dhcp-agent.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 118.6M
    ● neutron-l3-agent.service - OpenStack Neutron Layer 3 Agent
    Loaded: loaded (/usr/lib/systemd/system/neutron-l3-agent.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 184.7M
    ● neutron-linuxbridge-agent.service - OpenStack Neutron Linux Bridge Agent
    Loaded: loaded (/usr/lib/systemd/system/neutron-linuxbridge-agent.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 257.8M
    ● neutron-metadata-agent.service - OpenStack Neutron Metadata Agent
    Loaded: loaded (/usr/lib/systemd/system/neutron-metadata-agent.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 176.0M
    ● neutron-server.service - OpenStack Neutron Server
    Loaded: loaded (/usr/lib/systemd/system/neutron-server.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:30 UTC; 2h 58min ago
    Memory: 513.1M
    ● openstack-glance-api.service - OpenStack Image Service (code-named Glance) API server
    Loaded: loaded (/usr/lib/systemd/system/openstack-glance-api.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 146.7M
    ● openstack-nova-compute.service - OpenStack Nova Compute Server
    Loaded: loaded (/usr/lib/systemd/system/openstack-nova-compute.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:44 UTC; 2h 58min ago
    Memory: 136.0M
    ● openstack-nova-conductor.service - OpenStack Nova Conductor Server
    Loaded: loaded (/usr/lib/systemd/system/openstack-nova-conductor.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:36 UTC; 2h 58min ago
    Memory: 247.0M
    ● openstack-nova-novncproxy.service - OpenStack Nova NoVNC Proxy Server
    Loaded: loaded (/usr/lib/systemd/system/openstack-nova-novncproxy.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 115.8M
    ● openstack-nova-scheduler.service - OpenStack Nova Scheduler Server
    Loaded: loaded (/usr/lib/systemd/system/openstack-nova-scheduler.service; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:36 UTC; 2h 58min ago
    Memory: 227.6M
    ● rabbitmq-server.service - RabbitMQ broker
    Loaded: loaded (/usr/lib/systemd/system/rabbitmq-server.service; enabled; vendor preset: disabled)
    Drop-In: /etc/systemd/system/rabbitmq-server.service.d
    Memory: 131.0M
    ● libvirtd-admin.socket - Libvirt admin socket
    Loaded: loaded (/usr/lib/systemd/system/libvirtd-admin.socket; disabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 0B
    ● libvirtd-ro.socket - Libvirt local read-only socket
    Loaded: loaded (/usr/lib/systemd/system/libvirtd-ro.socket; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 0B
    ● libvirtd.socket - Libvirt local socket
    Loaded: loaded (/usr/lib/systemd/system/libvirtd.socket; enabled; vendor preset: disabled)
    Active: active (running) since Thu 2023-02-02 06:04:08 UTC; 2h 58min ago
    Memory: 0B


    ```

## examples

- running the packstack container: `hack/run.sh`
- ruuning openstack CLI from the host (using tcp exposed  ports)
    ```
    source hack/utils.sh
    source_keystonerc
    openstack flavor list
    ```

- running openstack CLI from a container
    ```
    source hack/utils.sh
    openstack_container flavor list
    +----+-----------+-------+------+-----------+-------+-----------+
    | ID | Name      |   RAM | Disk | Ephemeral | VCPUs | Is Public |
    +----+-----------+-------+------+-----------+-------+-----------+
    | 1  | m1.tiny   |   512 |    1 |         0 |     1 | True      |
    | 2  | m1.small  |  2048 |   20 |         0 |     1 | True      |
    | 3  | m1.medium |  4096 |   40 |         0 |     2 | True      |
    | 4  | m1.large  |  8192 |   80 |         0 |     4 | True      |
    | 5  | m1.xlarge | 16384 |  160 |         0 |     8 | True      |
    +----+-----------+-------+------+-----------+-------+-----------+
    ```


-  create cirros image and instance
    ```shell

    source hack/utils.sh
    run_sh "wget https://download.cirros-cloud.net/0.6.1/cirros-0.6.1-x86_64-disk.img -O /tmp/cirros-0.6.1.img"

    openstack image create "cirros-0.6.1" --disk-format raw \
    --container-format bare --public \
    --file /tmp/cirros-0.6.1.img

    openstack server create --image cirros-0.6.1 --flavor m1.tiny cirros
    
    ```
