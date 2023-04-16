#/bin/sh
#mc alias set local-minio http://$MINIO_ADDR:9000 $MINIO_USERNAME $MINIO_PASSWORD
mc cp --recursive /tmp/* local-minio/$BUCKET_NAME