#!/bin/bash

source common.sh

exercise1() {
  echo "### 1. Create 3 pods with names nginx1,nginx2,nginx3. All of them should have the label app=v1"

  kubectl run nginx1 --image=nginx -l"app=v1"
  kubectl run nginx2 --image=nginx -l"app=v1"
  kubectl run nginx3 --image=nginx -l"app=v1"

  # wait a bit before proceeding to next exercise
  wait_for_pending_pod nginx3
}

exercise2() {
  echo "### 2. Show all labels of the pods"

  kubectl get pods --show-labels
}

exercise3() {
  echo "### 3. Change the labels of pod 'nginx2' to be app=v2"

  kubectl label --overwrite pod nginx2 app=v2
}

exercise4() {
  echo "### 4. Get the label 'app' for the pods (show a column with APP labels)"

  kubectl get pods -o jsonpath='{.items[*].metadata.labels.app}'

  # print newline
  echo
}

exercise5() {
  echo "### 5. Get only the 'app=v2' pods"

  kubectl get pods -lapp=v2
}

exercise6() {
  echo "### 6. Remove the 'app' label from the pods we created before"
  
  kubectl label pods nginx1 nginx2 nginx3 app-
}

exercise7() {
  echo "### 7. Create a pod that will be deployed to a Node that has the label 'accelerator=nvidia-tesla-p100'"

  kubectl apply -f - <<YAML
apiVersion: v1
kind: Pod
metadata:
  name: tesla-pod
spec:
  nodeSelector:
    accelerator: nvidia-tesla-p100
  containers:
  - name: busybox
    image: busybox
    command: ['/bin/sh', '-c', 'echo hello; sleep 3600']
YAML

  # node with label does not exist so this should fail
  wait_for_pending_pod tesla-pod

  echo "### Cleanup"
  kubectl delete pod tesla-pod --now
}

exercise8() {
  echo "### 8. Annotate pods nginx1, nginx2, nginx3 with \"description='my description'\" value"

  kubectl annotate pods nginx1 nginx2 nginx3 description="my description"
}

exercise9() {
  echo "### 9. Check the annotations for pod nginx1"

  kubectl get pods nginx1 -o=jsonpath='{.metadata.annotations}'

  # print newline
  echo
}

exercise10() {
  echo "### 10. Remove the annotations for these three pods"

  kubectl annotate pods nginx1 nginx2 nginx3 description-
}

exercise11() {
  echo "### 11. Remove these pods to have a clean state in your cluster"

  echo "### Cleanup"
  kubectl delete pods nginx1 nginx2 nginx3 --now
}

exercise12() {
  echo "### Create a deployment with image nginx:1.7.8, called nginx, having 2 replicas, defining port 80 as the port that this container exposes (don't create a service for this deployment)"
}

exercise13() {
  echo "### View the YAML of this deployment"
}

exercise14() {
  echo "### View the YAML of the replica set that was created by this deployment"
}

exercise15() {
  echo "### Get the YAML for one of the pods"
}

exercise16() {
  echo "### Check how the deployment rollout is going"
}

exercise17() {
  echo "### Update the nginx image to nginx:1.7.9"
}
  
exercise18() {
  echo "### Check the rollout history and confirm that the replicas are OK"
}

exercise19() {
  echo "### Undo the latest rollout and verify that new pods have the old image (nginx:1.7.8)"
}

exercise20() {
  echo "### Do an on purpose update of the deployment with a wrong image nginx:1.91"
}

exercise21() {
  echo "### Verify that something's wrong with the rollout"
}

exercise22() {
  echo "### Return the deployment to the second revision (number 2) and verify the image is nginx:1.7.9"
}

exercise23() {
  echo "### Check the details of the fourth revision (number 4)"
}

exercise24() {
  echo "### Scale the deployment to 5 replicas"
}

exerciseX() {
  echo "### Autoscale the deployment, pods between 5 and 10, targetting CPU utilization at 80%"
}

exerciseX() {
  echo "### Pause the rollout of the deployment"
}

exerciseX() {
  echo "### Update the image to nginx:1.9.1 and check that there's nothing going on, since we paused the rollout"
}

exerciseX() {
  echo "### Resume the rollout and check that the nginx:1.9.1 image has been applied"
}

exerciseX() {
  echo "### Delete the deployment and the horizontal pod autoscaler you created"
}

exerciseX() {
  echo "### Create a job named pi with image perl that runs the command with arguments \"perl -Mbignum=bpi -wle 'print bpi(2000)'\""
}

exerciseX() {
  echo "### Wait till it's done, get the output"
}

exerciseX() {
  echo "### Create a job with the image busybox that executes the command 'echo hello;sleep 30;echo world'"
}

exerciseX() {
  echo "### Follow the logs for the pod (you'll wait for 30 seconds)"
}

exerciseX() {
  echo "### See the status of the job, describe it and see the logs"
}

exerciseX() {
  echo "### Delete the job"
}

exerciseX() {
  echo "### Create a job but ensure that it will be automatically terminated by kubernetes if it takes more than 30 seconds to execute"
}

exerciseX() {
  echo "### Create the same job, make it run 5 times, one after the other. Verify its status and delete it"
}

exerciseX() {
  echo "### Create the same job, but make it run 5 parallel times"
}

exerciseX() {
  echo "### Create a cron job with image busybox that runs on a schedule of \"*/1 * * * *\" and writes 'date; echo Hello from the Kubernetes cluster' to standard output"
}

exerciseX() {
  echo "### See its logs and delete it"
}

exerciseX() {
  echo "### Create a cron job with image busybox that runs every minute and writes 'date; echo Hello from the Kubernetes cluster' to standard output. The cron job should be terminated if it takes more than 17 seconds to start execution after its schedule."
}

# vim: set expandtab tabstop=2 softtabstop=2 shiftwidth=2:

exercise1
exercise2
exercise3
exercise4
exercise5
exercise6
exercise7
exercise8
exercise9
exercise10
exercise11
