docker run -d --rm --name packstack  -v /lib/modules/:/lib/modules/ --privileged --cap-add ALL --security-opt seccomp=unconfined   --cgroup-parent=docker.slice  packstack
