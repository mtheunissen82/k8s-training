#!/bin/bash

source common.sh

exercise1() {
  echo "### 1. Create a Pod with two containers, both with image busybox and command \"echo hello; sleep 3600\". Connect to the second container and run 'ls'"

  kubectl apply -f - <<YAML
apiVersion: v1
kind: Pod
metadata:
  name: busybox-duo
spec:
  containers:
  - name: uno
    image: busybox
    command: ['/bin/sh', '-c', 'echo hello; sleep 3600']
  - name: dos
    image: busybox
    command: ['/bin/sh', '-c', 'echo hello; sleep 3600']
YAML

  echo "Wait for busybox-duo to get up"
  wait_for_pending_pod busybox-duo

  echo "Execute 'ls' command in container 'dos'"
  kubectl exec busybox-duo -c dos -- ls
  
  echo "### Cleanup"
  kubectl delete pod busybox-duo --now
}

exercise2() {
  echo "### Create pod with nginx container exposed at port 80. Add a busybox init container which downloads a page using \"wget -O /work-dir/index.html http://neverssl.com/online\". Make a volume of type emptyDir and mount it in both containers. For the nginx container, mount it on \"/usr/share/nginx/html\" and for the initcontainer, mount it on \"/work-dir\". When done, get the IP of the created pod and create a busybox pod and run \"wget -O- IP\""

  kubectl apply -f - <<YAML
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    volumeMounts:
    - mountPath: /usr/share/nginx/html
      name: tmp-volume
  # initContainers:
  # - name: busybox
  #   image: busybox
  #   volumeMounts:
  #   - mountPath: /work-dir
  #     name: tmp-volume
  #   command: ['/bin/sh', '/bin/wget -q -O /work-dir/index.html http://neverssl.com/online']
  volumes:
  - name: tmp-volume
    emptyDir: {}
YAML

  echo "Wait for pod to get up"
  wait_for_pending_pod nginx

  local nginxPodIp wgetCommand
  nginxPodIp="$(get_pod_ip nginx)"
  wgetCommand="/bin/wget -q -O - http://${nginxPodIp}/"
  echo "wget command to perform: $wgetCommand"

  kubectl run tmpbox --image=busybox -i --rm --restart=Never -- $wgetCommand
}

# exercise1
exercise2

# vim: set expandtab tabstop=2 softtabstop=2 shiftwidth=2:
