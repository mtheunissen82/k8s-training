![](https://gaforgithub.azurewebsites.net/api?repo=CKAD-exercises/configuration&empty)
# Configuration (18%)

## ConfigMaps

kubernetes.io > Documentation > Tasks > Configure Pods and Containers > [Configure a Pod to Use a ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/)

### Create a configmap named config with values foo=lala,foo2=lolo

ANSWER: _______________

### Display its values

ANSWER: _______________

### Create and display a configmap from a file

Create the file with

```bash
echo -e "foo3=lili\nfoo4=lele" > config.txt
```

ANSWER: _______________

### Create and display a configmap from a .env file

Create the file with the command

```bash
echo -e "var1=val1\n# this is a comment\n\nvar2=val2\n#anothercomment" > config.env
```

ANSWER: _______________

### Create and display a configmap from a file, giving the key 'special'

Create the file with

```bash
echo -e "var3=val3\nvar4=val4" > config4.txt
```

ANSWER: _______________

### Create a configMap called 'options' with the value var5=val5. Create a new nginx pod that loads the value from variable 'var5' in an env variable called 'option'

ANSWER: _______________

### Create a configMap 'anotherone' with values 'var6=val6', 'var7=val7'. Load this configMap as env variables into a new nginx pod

ANSWER: _______________

### Create a configMap 'cmvolume' with values 'var8=val8', 'var9=val9'. Load this as a volume inside an nginx pod on path '/etc/lala'. Create the pod and 'ls' into the '/etc/lala' directory.

ANSWER: _______________

## SecurityContext

kubernetes.io > Documentation > Tasks > Configure Pods and Containers > [Configure a Security Context for a Pod or Container](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

### Create the YAML for an nginx pod that runs with the user ID 101. No need to create the pod

ANSWER: _______________


### Create the YAML for an nginx pod that has the capabilities "NET_ADMIN", "SYS_TIME" added on its single container

ANSWER: _______________

## Requests and limits

kubernetes.io > Documentation > Tasks > Configure Pods and Containers > [Assign CPU Resources to Containers and Pods](https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/)

### Create an nginx pod with requests cpu=100m,memory=256Mi and limits cpu=200m,memory=512Mi

ANSWER: _______________

## Secrets

kubernetes.io > Documentation > Concepts > Configuration > [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

kubernetes.io > Documentation > Tasks > Inject Data Into Applications > [Distribute Credentials Securely Using Secrets](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)

### Create a secret called mysecret with the values password=mypass

ANSWER: _______________

### Create a secret called mysecret2 that gets key/value from a file

Create a file called username with the value admin:

```bash
echo -n admin > username
```

ANSWER: _______________

### Get the value of mysecret2

ANSWER: _______________

### Create an nginx pod that mounts the secret mysecret2 in a volume on path /etc/foo

ANSWER: _______________

### Delete the pod you just created and mount the variable 'username' from secret mysecret2 onto a new nginx pod in env variable called 'USERNAME'

ANSWER: _______________

## ServiceAccounts

kubernetes.io > Documentation > Tasks > Configure Pods and Containers > [Configure Service Accounts for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)

### See all the service accounts of the cluster in all namespaces

ANSWER: _______________

### Create a new serviceaccount called 'myuser'

ANSWER: _______________

### Create an nginx pod that uses 'myuser' as a service account

ANSWER: _______________
