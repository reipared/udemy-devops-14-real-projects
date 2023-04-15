# Lab 012: Backup Vault in Minio

Windows + Ubuntu (vagrant vbox)

<!--
Issues:

-->

## Lab Goal

In this lab, we will deploy a helm chart with a cronjob to backup vault periodically into the Minio storage.

## Prerequisites

<!--
### 1. Install VirtualBox for Windows
-->

### 1. Install Docker for Windows

### 2. Install Vagrant for Windows

### 3. Start Vagrant with Docker as the provider

### 4. Install Minikube for Ubuntu

### 5. Start Minikube in Ubuntu

`minikube start`

or

`minikube start --kubernetes-version=v1.26.1`

### 6. Install kubectl for Ubuntu

```bash
minikube kubectl
```

### 7. Start kubectl in Ubuntu

Run the command `kubectl get node`, then we should see something similar to the below ouput:

```bash
NAME       STATUS   ROLES           AGE     VERSION
minikube   Ready    control-plane   4m37s   v1.25.3
```

### 8. Install in Ubuntu

```bash
...
```

## Steps

### 1. Enable Minikube Dashboard (Optional)

We can also enable our **Minikube dashboard** by running below command:

```bash
minikube dashboard
```

We should see a Kuberentes Dashboard page pop out in our browser immediately.

We can explore all Minikube resources in this UI website.

### 2. Add Helm Repo

```bash
helm repo add minio https://charts.min.io/
```

### 3. Create a namespace

Create a `minio` namespace

```bash
kubectl create ns minio
```

<!--
Output:

```bash
PS C:\devbox> kubectl create ns minio
namespace/minio created

PS C:\devbox> kubectl get ns
NAME                   STATUS   AGE
default                Active   2m50s
kube-node-lease        Active   2m51s
kube-public            Active   2m51s
kube-system            Active   2m52s
kubernetes-dashboard   Active   22s
minio                  Active   7s
```
-->

### 4. Install Minio Helm Chart

Since we are using Minikube cluster which has only 1 node, we just deploy the Minio in a test mode.

```bash
helm install --set resources.requests.memory=512Mi --set replicas=1 --set mode=standalone --set rootUser=rootuser,rootPassword=Test1234! --generate-name minio/minio
```

==>

```bash
helm install --set resources.requests.memory=512Mi --set replicas=1 --set mode=standalone --set rootUser=rootuser,rootPassword=Test1234! --generate-name --namespace=minio minio/minio
```

<!--
Output:

```bash
PS C:\devbox> helm install --set resources.requests.memory=512Mi --set replicas=1 --set mode=standalone --set rootUser=rootuser,rootPassword=Test1234! --generate-name minio/minio
NAME: minio-1679172101
LAST DEPLOYED: Sat Mar 18 16:41:42 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
MinIO can be accessed via port 9000 on the following DNS name from within our cluster:
minio-1679172101.default.svc.cluster.local

To access MinIO from localhost, run the below commands:

  1. export POD_NAME=$(kubectl get pods --namespace default -l "release=minio-1679172101" -o jsonpath="{.items[0].metadata.name}")

  2. kubectl port-forward $POD_NAME 9000 --namespace default

Read more about port forwarding here: http://kubernetes.io/docs/user-guide/kubectl/kubectl_port-forward/

we can now access MinIO server on http://localhost:9000. Follow the below steps to connect to MinIO server with mc client:

  1. Download the MinIO mc client - https://min.io/docs/minio/linux/reference/minio-mc.html#quickstart

  2. export MC_HOST_minio-1679172101-local=http://$(kubectl get secret --namespace default minio-1679172101 -o jsonpath="{.data.rootUser}" | base64 --decode):$(kubectl get secret --namespace default minio-1679172101 -o jsonpath="{.data.rootPassword}" | base64 --decode)@localhost:9000

  3. mc ls minio-1679172101-local
```
-->

<!--
PS C:\devbox> helm list
NAME                    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
minio-1679175880        default         1               2023-03-18 17:44:41.4395894 -0400 EDT   deployed        minio-5.0.7     RELEASE.2023-02-10T18-48-39Z
PS C:\devbox> helm uninstall  minio-5.0.7
Error: uninstall: Release not loaded: minio-5.0.7: release: not found

PS C:\devbox> helm uninstall minio-1679175880
release "minio-1679175880" uninstalled

PS C:\devbox> helm install --set resources.requests.memory=512Mi --set replicas=1 --set mode=standalone --set rootUser=rootuser,rootPassword=Test1234! --generate-name minio/minio
NAME: minio-1679439883
LAST DEPLOYED: Tue Mar 21 19:04:44 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
MinIO can be accessed via port 9000 on the following DNS name from within our cluster:
minio-1679439883.default.svc.cluster.local

To access MinIO from localhost, run the below commands:

  1. export POD_NAME=$(kubectl get pods --namespace default -l "release=minio-1679439883" -o jsonpath="{.items[0].metadata.name}")

  2. kubectl port-forward $POD_NAME 9000 --namespace default

Read more about port forwarding here: http://kubernetes.io/docs/user-guide/kubectl/kubectl_port-forward/

we can now access MinIO server on http://localhost:9000. Follow the below steps to connect to MinIO server with mc client:

  1. Download the MinIO mc client - https://min.io/docs/minio/linux/reference/minio-mc.html#quickstart

  2. export MC_HOST_minio-1679439883-local=http://$(kubectl get secret --namespace default minio-1679439883 -o jsonpath="{.data.rootUser}" | base64 --decode):$(kubectl get secret --namespace default minio-1679439883 -o jsonpath="{.data.rootPassword}" | base64 --decode)@localhost:9000

  3. mc ls minio-1679439883-local
-->

### 5. Update the configure file

Update the minio username and password in `vault-backup-values.yaml`

```bash
MINIO_USERNAME=$(kubectl get secret -l app=minio -o=jsonpath="{.items[0].data.rootUser}"|base64 -d)
echo "MINIO_USERNAME is $MINIO_USERNAME"
MINIO_PASSWORD=$(kubectl get secret -l app=minio -o=jsonpath="{.items[0].data.rootPassword}"|base64 -d)
echo "MINIO_PASSWORD is $MINIO_PASSWORD"
```

Check the minio service name and update the `MINIO_ADDR` env var in the `vault-backup-values.yaml` file.

```bash
MINIO_SERVICE_NAME=$(kubectl get svc -n minio -o=jsonpath={.items[0].metadata.name})
echo Minio service name is $MINIO_SERVICE_NAME
```

<!--
```bash
 /c/devbox (DevOps Labs: Real DevOps Projects) $ MINIO_SERVICE_NAME=$(kubectl get svc -n minio -o=jsonpath={.items[0].metadata.name})
echo Minio service name is $MINIO_SERVICE_NAME
Minio service name is minio-1681406939
```
-->

```bash
POD_NAME = kubectl get pods --namespace default -l "release=minio-1679439883" -o jsonpath="{.items[0].metadata.name}"
echo "Minio POD name is $POD_NAME"
kubectl port-forward $POD_NAME 9000 --namespace default

$MINIO_SERVICE_NAME = kubectl get svc -o jsonpath="{.items[1].metadata.name}"
echo "Minio service name is $MINIO_SERVICE_NAME"
```

<!--
Output:

```bash
PS C:\devbox> $POD_NAME = kubectl get pods --namespace default -l "release=minio-1679442603" -o jsonpath="{.items[0].metadata.name}"
PS C:\devbox>
PS C:\devbox> echo "Minio POD name is $POD_NAME"
Minio POD name is minio-1679175880-74bc6487b8-lqmqx
PS C:\devbox>
PS C:\devbox> kubectl port-forward $POD_NAME 9000 --namespace default
Forwarding from 127.0.0.1:9000 -> 9000
Forwarding from [::1]:9000 -> 9000
```
-->

<!--
PS C:\devbox> kubectl get pods
NAME                              READY   STATUS    RESTARTS       AGE
configmap-demo-pod                1/1     Running   1 (9m4s ago)   21h
minio-1679439883-dd748c6c-n74np   1/1     Running   0              2m52s

PS C:\devbox> $POD_NAME = kubectl get pods --namespace default -l "release=minio-1679439883" -o jsonpath="{.items[0].metadata.name}"
PS C:\devbox> echo "Minio POD name is $POD_NAME"
Minio POD name is minio-1679439883-dd748c6c-n74np

PS C:\devbox>  kubectl get svc
NAME                       TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
kubernetes                 ClusterIP   10.96.0.1       <none>        443/TCP    3d1h
minio-1679439883           ClusterIP   10.101.97.206   <none>        9000/TCP   3m57s
minio-1679439883-console   ClusterIP   10.107.132.79   <none>        9001/TCP   3m57s

PS C:\devbox> $MINIO_SERVICE_NAME = kubectl get svc -o jsonpath="{.items[1].metadata.name}"
PS C:\devbox> echo "Minio service name is $MINIO_SERVICE_NAME"
Minio service name is minio-1679439883
```
-->

### 6. Create a Bucket in the Minio Console

In order to access the Minio console, we need to port forward it to our local

<!--
```bash
kubectl port-forward svc/$(kubectl get svc|grep console|awk '{print $1}') 9001:9001

kubectl port-forward $(kubectl get svc -n minio | grep console | awk '{print $1}') 9001:9001
```
-->

```bash
 /c/devbox (DevOps Labs: Real DevOps Projects) $ kubectl get pod -n minio
NAME                                READY   STATUS    RESTARTS   AGE
minio-1681406939-568496f55d-nbg97   1/1     Running   0          12m

 /c/devbox (DevOps Labs: Real DevOps Projects) $ kubectl port-forward -n minio minio-1681406939-568496f55d-nbg97 9001:9001
Forwarding from 127.0.0.1:9001 -> 9001
Forwarding from [::1]:9001 -> 9001
```

Open our browser and go to this URL [http://localhost:9001](http://localhost:9001), and login with the username/password as `rootUser`/`rootPassword` setup above.

Go to *Buckets* section in the left lane and click *Create Bucket* with a name `test`, with all other setting as default.

![minio-bucket.png](images/minio-bucket.png)

### 8. Install Vault Helm Chart

We are going to deploy a Vault helm chart in the Minikube cluster. Create a `vault-values.yaml` first:

```bash
cat <<EOF > vault-values.yaml

injector:
  enabled: "-"
  replicas: 1
  image:
    repository: "hashicorp/vault-k8s"
    tag: "1.1.0"

server:
  enabled: "-"
  image:
    repository: "hashicorp/vault"
    tag: "1.12.1"
EOF
```

Run below commands to apply the helm chart:

```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
kubectl create ns vault-test
helm -n vault-test install vault hashicorp/vault -f vault-values.yaml
```

Initiate the Vault

```bash
kubectl -n vault-test exec vault-0 -- vault operator init
kubectl -n vault-test exec vault-0 -- vault operator unseal <unseal key from .vault.key>
kubectl -n vault-test exec vault-0 -- vault operator unseal <unseal key from .vault.key>
kubectl -n vault-test exec vault-0 -- vault operator unseal <unseal key from .vault.key>

# Enable secrets engine and import config
kubectl -n vault-test exec vault-0 -- vault login <root token>
kubectl -n vault-test exec vault-0 -- vault secrets enable -version=2 kv-v2 
kubectl -n vault-test exec vault-0 -- vault kv put -mount=kv-v2 devops-secret username=root password=changeme

# Enable approle engine and create role/secret
kubectl -n vault-test exec -it vault-0 -- sh

cd /tmp
cat > policy.hcl  <<EOF
path "kv-v2/*" {
  capabilities = ["create", "update","read"]
}
EOF
vault policy write first-policy policy.hcl
vault policy list
vault policy read first-policy

vault auth enable approle
vault write auth/approle/role/first-role \
    secret_id_ttl=10000m \
    token_num_uses=10 \
    token_ttl=20000m \
    token_max_ttl=30000m \
    secret_id_num_uses=40 \
    token_policies=first-policy
export ROLE_ID="$(vault read -field=role_id auth/approle/role/first-role/role-id)"
echo Role_ID is $ROLE_ID
export SECRET_ID="$(vault write -f -field=secret_id auth/approle/role/first-role/secret-id)"
echo SECRET_ID is $SECRET_ID
```

### 9. Deploy Vault Backup Helm Chart

```bash
kubectl -n vault-test create configmap upload --from-file=upload.sh
helm -n vault-test upgrade --install vault-backup helm-chart -f vault-backup-values.yaml
kubectl -n vault-test create job vault-backup-test --from=cronjob/vault-backup-cronjob
```

### 10. Verification

Port forward Minio console to our local host:

```bash
MINIO_CONSOLE_ADDR=$(kubectl -n minio get svc|grep console|awk '{print $1}')
kubectl -n minio port-forward svc/$MINIO_CONSOLE_ADDR 9001:9001
```

Login to the Minio console [http://localhost:9001](http://localhost:9001) and go to **Object Browser** section in the left navigation lane. Click **Test** bucket and we should see the backup files list there.
![minio-console.png](images/minio-console.png)

<!--
Reference

[Minio Helm Deployment](https://github.com/minio/minio/tree/master/helm/minio)

git clone https://github.com/briansu2004/udemy-devops-14-real-projects.git
cd udemy-devops-14-real-projects/012-CronjobVaultBackupHelmMinikube
-->
