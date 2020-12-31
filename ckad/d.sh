#!/bin/bash

source common.sh

exercise1() {
  echo "### Create a configmap named config with values foo=lala,foo2=lolo"

  kubectl create cm config --from-literal=foo=lala --from-literal=foo2=lolo
}

exercise2() {
  echo "### Display its values"

  kubectl describe cm config

  echo "### Cleanup"
  kubectl delete cm config --now
}

exercise3() {
  echo "### Create and display a configmap from a file"

  echo "create file 'config.txt'"
  echo -e "foo3=lili\nfoo4=lele" > config.txt

  echo "create configmap from file"
  kubectl create cm cmfromfile --from-file=config.txt

  echo "describe the newly created configmap"
  kubectl describe cm cmfromfile

  echo "### Cleanup"
  rm -f config.txt
  kubectl delete cm cmfromfile --now
}

exercise4() {
  echo "### Create and display a configmap from a .env file"

  echo "create file 'config.env'"
  echo -e "var1=val1\n# this is a comment\n\nvar2=val2\n#anothercomment" > config.env

  echo "create the configmap from envfile"
  kubectl create cm cmfromenvfile --from-env-file=config.env

  echo "describe the newly created configmap"
  kubectl describe cm cmfromenvfile

  echo "### Cleanup"
  rm -f config.env
  kubectl delete cm cmfromenvfile --now
}

exercise5() {
  echo "### Create and display a configmap from a file, giving the key 'special'"

  echo "create file 'config4.txt"
  echo -e "var3=val3\nvar4=val4" > config4.txt

  echo "### Cleanup"
  rm -f config4.txt
}

exercise6() {
  echo "### Create a configMap called 'options' with the value var5=val5. Create a new nginx pod that loads the value from variable 'var5' in an env variable called 'option'"
}

exercise7() {
  echo "### Create a configMap 'anotherone' with values 'var6=val6', 'var7=val7'. Load this configMap as env variables into a new nginx pod"
}

exercise8() {
  echo "### Create a configMap 'cmvolume' with values 'var8=val8', 'var9=val9'. Load this as a volume inside an nginx pod on path '/etc/lala'. Create the pod and 'ls' into the '/etc/lala' directory."
}

exercise9() {
  echo "### Create the YAML for an nginx pod that runs with the user ID 101. No need to create the pod"
}

exercise10() {
  echo "### Create the YAML for an nginx pod that has the capabilities \"NET_ADMIN\", \"SYS_TIME\" added on its single container"
}

exercise11() {
  echo "### Create an nginx pod with requests cpu=100m,memory=256Mi and limits cpu=200m,memory=512Mi"
}

exercise12() {
  echo "### Create a secret called mysecret with the values password=mypass"
}

exercise13() {
  echo "### Create a secret called mysecret2 that gets key/value from a file"

  echo "create file with name 'username' and content 'admin'"
  echo -n admin > username

  echo "### Cleanup"
  rm -f username
}

exercise14() {
  echo "### Get the value of mysecret2"
}

exercise15() {
  echo "### Create an nginx pod that mounts the secret mysecret2 in a volume on path /etc/foo"
}

exercise16() {
  echo "### Delete the pod you just created and mount the variable 'username' from secret mysecret2 onto a new nginx pod in env variable called 'USERNAME'"
}

exercise17() {
  echo "### See all the service accounts of the cluster in all namespaces"
}

exercise18() {
  echo "### Create a new serviceaccount called 'myuser'"
}

exercise19() {
  echo "### Create an nginx pod that uses 'myuser' as a service account"
}

exercise1
exercise2
exercise3
exercise4
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

# vim: set expandtab tabstop=2 softtabstop=2 shiftwidth=2:
