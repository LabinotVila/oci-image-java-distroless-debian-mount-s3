## Creating an OCI-compliant Java application, using Bazel and Google Distroless and including mount-s3

This is a demo project that demonstrates the creation of an OCI-image using Bazel and Google Distroless. The created 
image contains `mount-s3` as a built-in command which is installed using `apt` in a Debian distribution.

### Overview

This article explains in detail the approach [link](https://medium.com/p/f62c9a1cdb1d).

### Requirements

- Bazel (version `7.1.2`)
- Java (version `21`)
- Docker

### Running the demo

Build the image using:
```shell
bazel build //src:image-tarball
```

Load the image using:
```shell
docker load -i bazel-bin/src/image-tarball/tarball.tar
```

Run the image using:
```shell
docker run --platform linux/amd64 image:1
```

If everything went well, you will see:
```shell
Mountpoint for Amazon S3

Usage: mount-s3 [OPTIONS] <BUCKET_NAME> <DIRECTORY>
...
Bootstrap script finished, now running the application!
Hi
```
