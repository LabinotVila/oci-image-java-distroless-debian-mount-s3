## Creating an OCI-compliant Java application, using Bazel and Google Distroless and including mount-s3

This is a demo project that demonstrates the creation of an `OCI`-image using `Bazel` and Google `Distroless`. The 
created image contains `mount-s3` as a built-in command which is installed using `apt` in a `Debian` distribution.

For the sake of simplicity, this image is `arm64` architecture based. 

### Overview

### Requirements

- Bazel (version `7.1.2` or later)
- Java (version `21` or later)
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
docker run image:1
```

If everything went well, you will see:
```shell
Mountpoint for Amazon S3

Usage: mount-s3 [OPTIONS] <BUCKET_NAME> <DIRECTORY>
...
Bootstrap script finished, now running the application!
Hi
```

which means that `mount-s3` command is available in the image.
