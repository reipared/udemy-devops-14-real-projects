#/bin/sh
ls -trl /backup

cat > /tmp/t.txt <<EOF
Test
EOF

#ls -trl /vault/data
#mc alias set local-minio http://$MINIO_ADDR:9000 $MINIO_USERNAME $MINIO_PASSWORD
#mc cp --recursive /tmp/* local-minio/$BUCKET_NAME
#mc cp --recursive /* local-minio/$BUCKET_NAME
#mc cp /tmp/policy.hcl local-minio/$BUCKET_NAME
mc cp /tmp/t.txt local-minio/$BUCKET_NAME
mc cp --recursive /backup/* local-minio/$BUCKET_NAME
#mc cp --recursive /vault/data/* local-minio/$BUCKET_NAME