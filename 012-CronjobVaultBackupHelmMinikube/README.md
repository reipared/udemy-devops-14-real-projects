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

kubectl get cronjob
kubectl describe cronjob vault-backup-cronjob 
-->
