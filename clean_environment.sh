#!/bin/bash
alias velero='oc -n openshift-adp exec deployment/velero -c velero -it -- ./velero'
# Loop through the output of ls 
for i in {1..3};do
for file in $(oc get backup -n oadp-user$i -o json | jq .items[].metadata.name); do 
    back=$(eval "echo \$$file")
    echo Backup: $back
    oc project
    oc get backup -n oadp-user$i
    velero backup delete $back -n oadp-user$i
done

for file2 in $(oc get restore -n oadp-user$i -o json | jq .items[].metadata.name); do
    rest=$(eval "echo \$$file2")
    echo Restore: $rest
    oc project
    oc get restore -n oadp-user$i
    velero restore delete $rest -n oadp-user$i
done



done
