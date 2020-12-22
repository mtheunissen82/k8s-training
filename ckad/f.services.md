![](https://gaforgithub.azurewebsites.net/api?repo=CKAD-exercises/services&empty)
# Services and Networking (13%)

### Create a pod with image nginx called nginx and expose its port 80

ANSWER: _______________


### Confirm that ClusterIP has been created. Also check endpoints

ANSWER: _______________

### Get service's ClusterIP, create a temp busybox pod and 'hit' that IP with wget

ANSWER: _______________

### Convert the ClusterIP to NodePort for the same service and find the NodePort port. Hit service using Node's IP. Delete the service and the pod at the end.

ANSWER: _______________

### Create a deployment called foo using image 'dgkanatsios/simpleapp' (a simple server that returns hostname) and 3 replicas. Label it as 'app=foo'. Declare that containers in this pod will accept traffic on port 8080 (do NOT create a service yet)

ANSWER: _______________

### Get the pod IPs. Create a temp busybox pod and trying hitting them on port 8080

ANSWER: _______________

### Create a service that exposes the deployment on port 6262. Verify its existence, check the endpoints

ANSWER: _______________

### Create a temp busybox pod and connect via wget to foo service. Verify that each time there's a different hostname returned. Delete deployment and services to cleanup the cluster

ANSWER: _______________

### Create an nginx deployment of 2 replicas, expose it via a ClusterIP service on port 80. Create a NetworkPolicy so that only pods with labels 'access: granted' can access the deployment and apply it

kubernetes.io > Documentation > Concepts > Services, Load Balancing, and Networking > [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)

ANSWER: _______________
