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

  kubectl create deployment nginx --image=nginx:1.7.8 --replicas=2 --port=80
}

exercise13() {
  echo "### View the YAML of this deployment"

  kubectl get deployment nginx -o yaml
}

exercise14() {
  echo "### View the YAML of the replica set that was created by this deployment"

  kubectl get replicasets -lapp=nginx -o yaml
}

exercise15() {
  echo "### Get the YAML for one of the pods"

  local pod_name=""
  # grab last pod in list
  pod_name="$(kubectl get pods -lapp=nginx | tail -n1 | awk '{print $1}')"

  kubectl get pods "$pod_name" -o yaml
}

exercise16() {
  echo "### Check how the deployment rollout is going"
  
  kubectl rollout status deployment nginx
}

exercise17() {
  echo "### Update the nginx image to nginx:1.7.9"

  kubectl set image deployment nginx nginx=nginx:1.7.9
}
  
exercise18() {
  echo "### Check the rollout history and confirm that the replicas are OK"

  echo "print rollout history"
  kubectl rollout history deployment nginx

  echo "check rollout status"
  kubectl rollout status deployment nginx
}

exercise19() {
  echo "### Undo the latest rollout and verify that new pods have the old image (nginx:1.7.8)"

  kubectl rollout undo deployment nginx
}

exercise20() {
  echo "### Do an on purpose update of the deployment with a wrong image nginx:1.91"

  kubectl set image deployment nginx nginx=nginx:1.91
}

exercise21() {
  echo "### Verify that something's wrong with the rollout"

  echo "watch the status of the rollout for 10s (hint: it is never going to complete)"
  kubectl rollout status deployment nginx --timeout=10s

  echo "check deployment"
  kubectl get deployment nginx -o wide

  echo "check pods (should display an error: ImagePullBackOff"
  kubectl get pods -o wide
}

exercise22() {
  echo "### Return the deployment to the second revision (number 2) and verify the image is nginx:1.7.9"

  echo "perform rollback to revision 2"
  kubectl rollout undo --to-revision=2 deployment nginx

  echo "verify rollout status"
  kubectl rollout status deployment nginx
  
  echo "print current image version used by deployment"
  kubectl get deployment nginx -o=jsonpath='{.spec.template.spec.containers[*].image}'

  # print newline
  echo
}

exercise23() {
  echo "### Check the details of the fourth revision (number 4)"

  echo "compact overview of revision 4"
  kubectl rollout history deployment nginx --revision=4

  echo "details (YAML) of revision 4"
  kubectl rollout history deployment nginx --revision=4 -o yaml
}

exercise24() {
  echo "### Scale the deployment to 5 replicas"

  kubectl scale deployment nginx --replicas=5
}

exercise25() {
  echo "### 25. Autoscale the deployment, pods between 5 and 10, targetting CPU utilization at 80%"

  kubectl autoscale deployment nginx --min=5 --max=10 --cpu-percent=80
}

exercise26() {
  echo "### 26. Pause the rollout of the deployment"

  kubectl rollout pause deployment nginx
}

exercise27() {
  echo "### 27. Update the image to nginx:1.9.1 and check that there's nothing going on, since we paused the rollout"

  echo "set image to 1.9.1"
  kubectl set image deployment nginx nginx=nginx:1.9.1

  echo "verify rollout status (for max 5s if in progress)"
  timeout 5 kubectl rollout status deployment nginx

  echo "observe pods for 5s to make sure nothing is happening"
  timeout 5 kubectl get pods --watch
}

exercise28() {
  echo "### 28. Resume the rollout and check that the nginx:1.9.1 image has been applied"

  echo "resume rollout"
  kubectl rollout resume deployment nginx

  echo "check rollout status (for max 30s)"
  timeout 30 kubectl rollout status deployment nginx
}

exercise29() {
  echo "### 29. Delete the deployment and the horizontal pod autoscaler you created"

  echo "delete deployment"
  kubectl delete deployment nginx

  echo "delete autoscaler"
  kubectl delete horizontalpodautoscalers.autoscaling nginx
}

exercise30() {
  echo "### 30. Create a job named pi with image perl that runs the command with arguments \"perl -Mbignum=bpi -wle 'print bpi(2000)'\""

  kubectl create job pi --image=perl -- perl -Mbignum=bpi -wle 'print bpi(2000)'
}

exercise31() {
  echo "### 31. Wait till it's done, get the output"

  echo "wait max 40s till job is complete"
  kubectl wait job pi --for=condition=complete --timeout=40s

  echo "print output from the job"
  kubectl logs -ljob-name=pi

  echo "delete job"
  kubectl delete job pi --now
}

exercise32() {
  echo "### 32. Create a job with the image busybox that executes the command 'echo hello;sleep 30;echo world'"

  kubectl create job helloworld --image=busybox -- /bin/sh -c 'echo hello;sleep 30;echo world'
}

exercise33() {
  echo "### 33. Follow the logs for the pod (you'll wait for 30 seconds)"

  echo "print output from the job (max 30s)"
  timeout 30 kubectl logs -ljob-name=helloworld --tail
}

exercise34() {
  echo "### 34. See the status of the job, describe it and see the logs"

  echo "print helloworld job data"
  kubectl get job helloworld -o wide

  echo "describe job helloworld"
  kubectl describe job helloworld
}

exercise35() {
  echo "### 35. Delete the job"

  kubectl delete job helloworld --now
}

exercise36() {
  echo "### 36. Create a job but ensure that it will be automatically terminated by kubernetes if it takes more than 30 seconds to execute"

  echo "apply job manifest"
  kubectl apply -f ./c/exercise36.yaml

  echo "watch the pod for 40 seconds (it should stop after 30s)"
  timeout 40 kubectl get pod -ljob-name=killmein30s --watch

  echo "show some job details"
  kubectl get job killmein30s -o wide

  echo "show some job pod details"
  kubectl get pod -ljob-name=killmein30s -o wide

  echo "cleanup job"
  kubectl delete job killmein30s --now
}

exercise37() {
  echo "### 37. Create the same job, make it run 5 times, one after the other. Verify its status and delete it"

  echo "apply job manifest"
  kubectl apply -f ./c/exercise37.yaml
}

exercise38() {
  echo "### 38. Create the same job, but make it run 5 parallel times"
}

exercise39() {
  echo "### 39. Create a cron job with image busybox that runs on a schedule of \"*/1 * * * *\" and writes 'date; echo Hello from the Kubernetes cluster' to standard output"
}

exercise40() {
  echo "### 40. See its logs and delete it"
}

exercise41() {
  echo "### 41. Create a cron job with image busybox that runs every minute and writes 'date; echo Hello from the Kubernetes cluster' to standard output. The cron job should be terminated if it takes more than 17 seconds to start execution after its schedule."
}

# exercise1
# exercise2
# exercise3
# exercise4
# exercise5
# exercise6
# exercise7
# exercise8
# exercise9
# exercise10
# exercise11
# exercise12
# exercise13
# exercise14
# exercise15
# exercise16
# exercise17
# exercise18
# exercise19
# exercise20
# exercise21
# exercise22
# exercise23
# exercise24
# exercise25
# exercise26
# exercise27
# exercise28
# exercise29
# exercise30
# exercise31
# exercise32
# exercise33
# exercise34
# exercise35
# exercise36
exercise37
# exercise38
# exercise39
# exercise40
# exercise41

# vim: set expandtab tabstop=2 softtabstop=2 shiftwidth=2:
