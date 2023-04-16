# Lab 012: Backup Vault in Minio

## Lab Goal

In this lab, we will deploy a helm chart with a cronjob to backup vault periodically into the Minio storage.

<!--
## Clean up

Run below commands to remove docker containers and volumes

```bash
sudo docker compose down -v
sudo systemctl stop metricbeat
sudo systemctl disable metricbeat
sudo apt remove metricbeat
```
-->

## Environments

| #  | Env  | Y/N  | Recommended   |  Comment |
|---|---|---|---|---|
| 1 | Windows only | YN | YN |   |
| 2 | Windows + Ubuntu | N | N |   |
| 3 | Mac only | YN | YN |   |
| 4 | Mac + Ubuntu | N | N |   |

[Windows Only](01_YN_WindowsOnly.md)

<!--
[With_Windows_Ubuntu](02_N_Windows_Ubuntu.md)

[Mac Only doesn't work](03_N_MacOnly.md)

[With_Mac_Ubuntu](04_N_Mac_Ubuntu.md)
-->

<!--
PS C:\devbox> helm install --set resources.requests.memory=512Mi --set replicas=1 --set mode=standalone --set rootUser=rootuser,rootPassword=rootpass123 --generate-name --namespace=minio minio/minio --version 5.0.4
NAME: minio-1681595552
LAST DEPLOYED: Sat Apr 15 17:52:33 2023
NAMESPACE: minio
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
MinIO can be accessed via port 9000 on the following DNS name from within your cluster:
minio-1681595552.minio.svc.cluster.local

To access MinIO from localhost, run the below commands:

  1. export POD_NAME=$(kubectl get pods --namespace minio -l "release=minio-1681595552" -o jsonpath="{.items[0].metadata.name}")

  2. kubectl port-forward $POD_NAME 9000 --namespace minio

Read more about port forwarding here: http://kubernetes.io/docs/user-guide/kubectl/kubectl_port-forward/

You can now access MinIO server on http://localhost:9000. Follow the below steps to connect to MinIO server with mc client:

  1. Download the MinIO mc client - https://min.io/docs/minio/linux/reference/minio-mc.html#quickstart

  2. export MC_HOST_minio-1681595552-local=http://$(kubectl get secret --namespace minio minio-1681595552 -o jsonpath="{.data.rootUser}" | base64 --decode):$(kubectl get secret --namespace minio minio-1681595552 -o jsonpath="{.data.rootPassword}" | base64 --decode)@localhost:9000

  3. mc ls minio-1681595552-local

Unseal Key 1: gnKSjtM479Wkn8TaOrsy8Pxr/UXkhY8kuLp2j1/7U7bt
Unseal Key 2: lcb4semOF1XnDIcORl/pdE1hQsBMIQ6tEhA5OWI69Ng7
Unseal Key 3: qKH/AyhxmKiAD7QYakrZgY4ogst0EJcrGeKFEKhQmM6N
Unseal Key 4: +l3d/5ankavKHARejzF/7Oh+XiWsP4ctz2emrp/MJjAS
Unseal Key 5: Ol8otqE9YCuAPIlIEyArmkYGfLH6vHloJhEmiFhy5boU

Initial Root Token: hvs.4tq0M4fES5a1bUKJl3XgCUaO

kubectl -n vault-test exec vault-0 -- vault operator unseal gnKSjtM479Wkn8TaOrsy8Pxr/UXkhY8kuLp2j1/7U7bt
kubectl -n vault-test exec vault-0 -- vault operator unseal lcb4semOF1XnDIcORl/pdE1hQsBMIQ6tEhA5OWI69Ng7
kubectl -n vault-test exec vault-0 -- vault operator unseal qKH/AyhxmKiAD7QYakrZgY4ogst0EJcrGeKFEKhQmM6N

kubectl -n vault-test exec vault-0 -- vault login hvs.4tq0M4fES5a1bUKJl3XgCUaO

/tmp $ export ROLE_ID="$(vault read -field=role_id auth/approle/role/first-role/role-id)"
/tmp $ echo Role_ID is $ROLE_ID
Role_ID is b4eb088f-5350-8225-282e-c1a235c161fc
/tmp $
/tmp $ export SECRET_ID="$(vault write -f -field=secret_id auth/approle/role/first-role/secret-id)"
/tmp $ echo SECRET_ID is $SECRET_ID
SECRET_ID is 7dbd1f89-f1f5-59b0-dba9-49ffc3f05c19

Role_ID is b4eb088f-5350-8225-282e-c1a235c161fc
SECRET_ID is 63787483-f0ed-433c-3b54-05d9841558a1

MINIO_SERVICE_NAME=$(kubectl get svc -n minio -o=jsonpath={.items[0].metadata.name})
echo Minio service name is $MINIO_SERVICE_NAME

kubectl port-forward svc/vault 8200:8200

kubectl -n vault-test apply -f upload-configmap.yaml

kubectl -n vault-test create configmap upload --from-file=upload.sh
helm -n vault-test upgrade --install vault-backup helm-chart -f vault-backup-values.yaml
kubectl -n vault-test create job vault-backup-test --from=cronjob/vault-backup-cronjob

kubectl delete cronjob vault-backup-cronjob
kubectl delete job vault-backup-test
helm uninstall vault-backup
kubectl delete configmap upload

kubectl get pod
kubectl logs vault-backup-test-

kubectl logs -f $(kubectl get pod -l app=vault-backup -o jsonpath="{.items[0].metadata.name}")

kubectl get cronjob
kubectl describe cronjob vault-backup-cronjob 
-->

<!--
#/bin/sh
#mc alias set local-minio http://$MINIO_ADDR:9000 $MINIO_USERNAME $MINIO_PASSWORD
#mc cp --recursive /tmp/* local-minio/$BUCKET_NAME
#mc cp --recursive /* local-minio/$BUCKET_NAME
mc cp --recursive /backup/* local-minio/$BUCKET_NAME

PS C:\devbox\udemy-devops-14-real-projects\012-CronjobVaultBackupHelmMinikube> kubectl logs vault-backup-test-qm2km
Defaulted container "upload" out of: upload, vault-backup (init)
`/backup/vault-backup-202304160057.json` -> `local-minio/test/vault-backup-202304160057.json`
Total: 0 B, Transferred: 416 B, Speed: 25.35 KiB/s
-->

<!--
Mac

MINIO_SERVICE_NAME=$(kubectl get svc -n minio -o=jsonpath="{.items[1].metadata.name}")
echo Minio service name is $MINIO_SERVICE_NAME

MINIO_USERNAME=$(kubectl get secret -l app=minio -o=jsonpath="{.items[0].data.rootUser}"|base64 -d)
echo "MINIO_USERNAME is $MINIO_USERNAME"

MINIO_PASSWORD=$(kubectl get secret -l app=minio -o=jsonpath="{.items[0].data.rootPassword}"|base64 -d)
echo "MINIO_PASSWORD is $MINIO_PASSWORD"

Minio service name is minio--console

Unseal Key 1: FomjwEf2zjH4GMBvEz3s9V1H1s/WFmpN1/NwqVUNI8QY
Unseal Key 2: boBsU6JQRQq4/vkSYDW5p2S8xWJLr1agpz5BGNElFATJ
Unseal Key 3: rYPAYlbwAkLDl6cyVviDAixCYrwBn4kIDh4490qjQALk
Unseal Key 4: wtslNugnWG/Dc9k1pGk7jDDODWq4BKr9qEN3gzDln56v
Unseal Key 5: dnJ1bZvyTZE5Li6x73vDMe/ESPqyRbX45GpAqgOSAjE8

Initial Root Token: hvs.118u4Q77K9kxIFZWXaJ8Xzmv

kubectl -n vault-test exec vault-0 -- vault operator unseal FomjwEf2zjH4GMBvEz3s9V1H1s/WFmpN1/NwqVUNI8QY
kubectl -n vault-test exec vault-0 -- vault operator unseal boBsU6JQRQq4/vkSYDW5p2S8xWJLr1agpz5BGNElFATJ
kubectl -n vault-test exec vault-0 -- vault operator unseal rYPAYlbwAkLDl6cyVviDAixCYrwBn4kIDh4490qjQALk

kubectl -n vault-test exec vault-0 -- vault login hvs.118u4Q77K9kxIFZWXaJ8Xzmv

/tmp $ export ROLE_ID="$(vault read -field=role_id auth/approle/role/first-role/role-id)"
/tmp $ echo Role_ID is $ROLE_ID
Role_ID is be05a5d4-7658-3334-a57e-fa81ca5eefc4
/tmp $ export SECRET_ID="$(vault write -f -field=secret_id auth/approle/role/first-role/secret-id)"
/tmp $ echo SECRET_ID is $SECRET_ID
SECRET_ID is 8bd1c5d4-5dda-41f3-ac92-55f56a8e8033

alias k="kubectl"

devops@Brians-MBP 012-CronjobVaultBackupHelmMinikube % k logs -f vault-backup-test-hmbvq 
Defaulted container "upload" out of: upload, vault-backup (init)
total 4
-rw-r--r-- 1 root root 418 Apr 16 13:54 vault-backup-202304161354.json
`/backup/vault-backup-202304161354.json` -> `local-minio/test/vault-backup-202304161354.json`
Total: 0 B, Transferred: 418 B, Speed: 39.55 KiB/s

  Init Containers:
   vault-backup:
    Image:      hashicorp/vault:1.9.2
    Port:       <none>
    Host Port:  <none>
    Command:
      /bin/sh
    Args:
      -ec
      apk update && apk add jq
      export VAULT_TOKEN=$(vault write auth/approle/login role_id=$VAULT_APPROLE_ROLE_ID secret_id=$VAULT_APPROLE_SECRET_ID -format=json |jq -r .auth.client_token);
      echo "vault kv get -format=json $MOUNT_POINT/$SECRET_PATH"
      vault kv get -format=json $MOUNT_POINT/$SECRET_PATH > /backup/vault-backup-`date +%Y%m%d%H%M`.json

kubectl apply -f network-policy.yaml

mc alias ls

gcs  
  URL       : https://storage.googleapis.com
  AccessKey : YOUR-ACCESS-KEY-HERE
  SecretKey : YOUR-SECRET-KEY-HERE
  API       : S3v2
  Path      : dns
local
  URL       : http://localhost:9000
  AccessKey : 
  SecretKey : 
  API       : 
  Path      : auto
play 
  URL       : https://play.min.io
  AccessKey : Q3AM3UQ867SPQQA43P2F
  SecretKey : zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG
  API       : S3v4
  Path      : auto
s3   
  URL       : https://s3.amazonaws.com
  AccessKey : YOUR-ACCESS-KEY-HERE
  SecretKey : YOUR-SECRET-KEY-HERE
  API       : S3v4
  Path      : dns
total 76

devops@Brians-MBP 012-CronjobVaultBackupHelmMinikube % k get svc -n vault-test
NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
vault                      ClusterIP   10.105.115.231   <none>        8200/TCP,8201/TCP   57m
vault-agent-injector-svc   ClusterIP   10.100.64.112    <none>        443/TCP             57m
vault-internal             ClusterIP   None             <none>        8200/TCP,8201/TCP   57m

devops@Brians-MBP 012-CronjobVaultBackupHelmMinikube % k get svc -n minio
NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
minio-1681651829           ClusterIP   10.102.37.217    <none>        9000/TCP   60m
minio-1681651829-console   ClusterIP   10.109.112.146   <none>        9001/TCP   60m

devops@Brians-MBP 012-CronjobVaultBackupHelmMinikube % k describe svc minio-1681651829  
Name:              minio-1681651829
Namespace:         minio
Labels:            app=minio
                   app.kubernetes.io/managed-by=Helm
                   chart=minio-5.0.5
                   heritage=Helm
                   monitoring=true
                   release=minio-1681651829
Annotations:       meta.helm.sh/release-name: minio-1681651829
                   meta.helm.sh/release-namespace: minio
Selector:          app=minio,release=minio-1681651829
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.102.37.217
IPs:               10.102.37.217
Port:              http  9000/TCP
TargetPort:        9000/TCP
Endpoints:         10.244.0.11:9000
Session Affinity:  None
Events:            <none>

devops@Brians-MBP 012-CronjobVaultBackupHelmMinikube % k describe svc minio-1681651829-console
Name:              minio-1681651829-console
Namespace:         minio
Labels:            app=minio
                   app.kubernetes.io/managed-by=Helm
                   chart=minio-5.0.5
                   heritage=Helm
                   release=minio-1681651829
Annotations:       meta.helm.sh/release-name: minio-1681651829
                   meta.helm.sh/release-namespace: minio
Selector:          app=minio,release=minio-1681651829
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.109.112.146
IPs:               10.109.112.146
Port:              http  9001/TCP
TargetPort:        9001/TCP
Endpoints:         10.244.0.11:9001
Session Affinity:  None
Events:            <none>

-->
