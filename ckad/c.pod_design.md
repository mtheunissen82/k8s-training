![](https://gaforgithub.azurewebsites.net/api?repo=CKAD-exercises/pod_design&empty)
# Pod design (20%)

## Labels and annotations
kubernetes.io > Documentation > Concepts > Overview > [Labels and Selectors](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors)

### Create 3 pods with names nginx1,nginx2,nginx3. All of them should have the label app=v1

ANSWER: _______________

### Show all labels of the pods

ANSWER: _______________

### Change the labels of pod 'nginx2' to be app=v2

ANSWER: _______________

### Get the label 'app' for the pods (show a column with APP labels)

ANSWER: _______________

### Get only the 'app=v2' pods

ANSWER: _______________

### Remove the 'app' label from the pods we created before

ANSWER: _______________

### Create a pod that will be deployed to a Node that has the label 'accelerator=nvidia-tesla-p100'

ANSWER: _______________

### Annotate pods nginx1, nginx2, nginx3 with "description='my description'" value

ANSWER: _______________

### Check the annotations for pod nginx1

ANSWER: _______________

### Remove the annotations for these three pods

ANSWER: _______________

### Remove these pods to have a clean state in your cluster

ANSWER: _______________

## Deployments

kubernetes.io > Documentation > Concepts > Workloads > Controllers > [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment)

### Create a deployment with image nginx:1.7.8, called nginx, having 2 replicas, defining port 80 as the port that this container exposes (don't create a service for this deployment)

ANSWER: _______________

### View the YAML of this deployment

ANSWER: _______________

### View the YAML of the replica set that was created by this deployment

ANSWER: _______________

### Get the YAML for one of the pods

ANSWER: _______________

### Check how the deployment rollout is going

ANSWER: _______________

### Update the nginx image to nginx:1.7.9

ANSWER: _______________

### Check the rollout history and confirm that the replicas are OK

ANSWER: _______________

### Undo the latest rollout and verify that new pods have the old image (nginx:1.7.8)

ANSWER: _______________

### Do an on purpose update of the deployment with a wrong image nginx:1.91

ANSWER: _______________

### Verify that something's wrong with the rollout

ANSWER: _______________


### Return the deployment to the second revision (number 2) and verify the image is nginx:1.7.9

ANSWER: _______________

### Check the details of the fourth revision (number 4)

ANSWER: _______________

### Scale the deployment to 5 replicas

ANSWER: _______________

### Autoscale the deployment, pods between 5 and 10, targetting CPU utilization at 80%

ANSWER: _______________

### Pause the rollout of the deployment

ANSWER: _______________

### Update the image to nginx:1.9.1 and check that there's nothing going on, since we paused the rollout

ANSWER: _______________

### Resume the rollout and check that the nginx:1.9.1 image has been applied

ANSWER: _______________

### Delete the deployment and the horizontal pod autoscaler you created

ANSWER: _______________

## Jobs

### Create a job named pi with image perl that runs the command with arguments "perl -Mbignum=bpi -wle 'print bpi(2000)'"

ANSWER: _______________

### Wait till it's done, get the output

ANSWER: _______________

### Create a job with the image busybox that executes the command 'echo hello;sleep 30;echo world'

ANSWER: _______________

### Follow the logs for the pod (you'll wait for 30 seconds)

ANSWER: _______________

### See the status of the job, describe it and see the logs

ANSWER: _______________

### Delete the job

ANSWER: _______________

### Create a job but ensure that it will be automatically terminated by kubernetes if it takes more than 30 seconds to execute

ANSWER: _______________

### Create the same job, make it run 5 times, one after the other. Verify its status and delete it

ANSWER: _______________

### Create the same job, but make it run 5 parallel times

ANSWER: _______________

## Cron jobs

kubernetes.io > Documentation > Tasks > Run Jobs > [Running Automated Tasks with a CronJob](https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/)

### Create a cron job with image busybox that runs on a schedule of "*/1 * * * *" and writes 'date; echo Hello from the Kubernetes cluster' to standard output

ANSWER: _______________

### See its logs and delete it

ANSWER: _______________

### Create a cron job with image busybox that runs every minute and writes 'date; echo Hello from the Kubernetes cluster' to standard output. The cron job should be terminated if it takes more than 17 seconds to start execution after its schedule.

ANSWER: _______________
