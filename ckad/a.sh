#!/bin/bash

source common.sh

exercise1() {
  echo "### 1. Create a namespace called 'mynamespace' and a pod with image nginx called nginx on this namespace"

  kubectl create namespace mynamespace
  kubectl run nginx --image=nginx --namespace=mynamespace

  echo "### Cleanup"
  kubectl delete namespace mynamespace --now
}

exercise2() {
  echo "### 2. Create the pod that was just described using yaml"

  kubectl create --save-config -f - <<YAML
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  containers:
  - name: nginx
    image: nginx
YAML

  echo "### Cleanup"
  kubectl delete pod busybox --now
}

exercise3() {
  echo "### 3. Create a busybox pod (using kubectl command) that runs the command \"env\". Run it and see the output"
  kubectl run busybox --image=busybox -- env

  echo "Wait for busybox te be ready and print logs"
  wait_for_pending_pod busybox
  kubectl logs busybox

  echo "### Cleanup"
  kubectl delete pod busybox --now
}

exercise4() {
  echo "### 4. Create a busybox pod (using YAML) that runs the command \"env\". Run it and see the output"

  kubectl create --save-config -f - <<YAML
apiVersion: v1
kind: Pod
metadata:
  name: busybox
spec:
  containers:
  - name: busybox
    image: busybox
    command: ["env"]
YAML

  echo "Wait for busybox te be ready and print logs"
  wait_for_pending_pod busybox
  kubectl logs busybox

  echo "### Cleanup"
  kubectl delete pod busybox --now
}

exercise5() {
  echo "### 5. Get the YAML for a new namespace called 'myns' without creating it"

  kubectl create namespace myns --dry-run=client -o yaml
}

exercise6() {
  echo "### 6. Get the YAML for a new ResourceQuota called 'myrq' with hard limits of 1 CPU, 1G memory and 2 pods without creating it"

  kubectl create quota myrq --hard=cpu=1,memory=1G,pods=2 --dry-run=client -o yaml
}

exercise7() {
  echo "### 7. Get pods on all namespaces"

  kubectl get pods --all-namespaces
}

exercise8() {
  echo "### 8. Create a pod with image nginx called nginx and expose traffic on port 80"

  kubectl run nginx --image=nginx --port=80

  echo "### Cleanup"
  kubectl delete pod nginx --now
}

exercise9() {
  echo "### 9. Change pod's image to nginx:1.7.1. Observe that the container will be restarted as soon as the image gets pulled"

  kubectl run nginx --image=nginx --port=80
  kubectl set image nginx nginx=nginx:1.7.1

  # Observe pods for 15 seconds
  timeout 15 kubectl get pods --watch

  echo "### Cleanup"
  kubectl delete pod nginx --now
}

exercise10() {
  echo "### 10. Get nginx pod's ip created in previous step, use a temp busybox image to wget its '/'"
  kubectl run nginx --image=nginx --port=80

  # wait a bit nginx container is ready
  echo "Wait for 'nginx' pod to come up"
  wait_for_pending_pod nginx

  # then fetch the podIP and construct wget command
  local nginxPodIp wgetCommand
  nginxPodIp="$(get_pod_ip nginx)"
  wgetCommand="/bin/wget -q -O - http://${nginxPodIp}/"

  # perform wget command in busybox pod
  echo "wget command to run is: '${wgetCommand}'"
  kubectl run busybox --image=busybox -- $wgetCommand

  # wait a bit before fetching logs
  echo "Wait for 'busybox' pod to come up"
  wait_for_pending_pod busybox

  echo "wget response:"
  kubectl logs busybox
}

exercise11() {
  echo "### 11. Get pod's YAML"

  kubectl get pod nginx -o yaml
  kubectl get pod busybox -o yaml
}

exercise12() {
  echo "### 12. Get information about the pod, including details about potential issues (e.g. pod hasn't started)"

  kubectl describe pod nginx
  kubectl describe pod busybox
}

exercise13() {
  echo "### 13. Get pod logs"

  kubectl logs nginx
  kubectl logs busybox
}

exercise14() {
  echo "### 14. If pod crashed and restarted, get logs about the previous instance"

  kubectl logs -p nginx
  kubectl logs -p busybox
}

exercise15() {
  echo "### 15. Execute a simple shell on the nginx pod"

  echo "Perform command: kubectl exec -it nginx -- sh (not for real since it will take over the tty)"

  echo "### Cleanup"
  kubectl delete pod nginx busybox --now
}

exercise16() {
  echo "### 16. Create a busybox pod that echoes 'hello world' and then exits"

  kubectl run busybox --image=busybox -- echo hello world

  # wait a bit before fetching logs
  echo "Wait for 'busybox' pod to come up"
  wait_for_pending_pod busybox
  kubectl logs busybox

  echo "### Cleanup"
  kubectl delete pod busybox --now
}

exercise17() {
  echo "### 17. Do the same, but have the pod deleted automatically when it's completed"

}

exercise18() {
  echo "### 18. Create an nginx pod and set an env value as 'var1=val1'. Check the env value existence within the pod"

  kubectl run nginx --image=nginx --env="var1=val1"

  echo "Wait for 'nginx' pod to come up"
  wait_for_pending_pod nginx

  kubectl exec nginx -- env | grep var1

  kubectl delete pod nginx
}

# exercise1
# exercise2
# exercise3
exercise4
exercise5
exercise18

# vim: set expandtab tabstop=2 softtabstop=2 shiftwidth=2:
