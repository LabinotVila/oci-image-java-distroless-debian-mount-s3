#!/bin/sh

echo "Starting bootstrap script!"

mount-s3 --help

# You could use the following lines to mount a real bucket
# mkdir -p /mnt/s3_input /mnt/s3_output /tmp_input /tmp_output
# mount-s3 --cache /tmp_input --allow-overwrite "$S3_BUCKET_INPUT" "/mnt/s3_input"
# mount-s3 --cache /tmp_output --allow-overwrite "$S3_BUCKET_OUTPUT" "/mnt/s3_output"

echo "Bootstrap script finished, now running the application!"

# Run command
eval "$@"
