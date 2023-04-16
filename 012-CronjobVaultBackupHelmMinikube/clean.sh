#!/bin/sh
kubectl config set-context --current --namespace=vault-test
kubectl delete cronjob vault-backup-cronjob
kubectl delete job vault-backup-test
helm uninstall vault-backup
kubectl delete configmap upload
